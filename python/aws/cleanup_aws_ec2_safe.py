"""
AWS EC2 Cleanup Tool – Safe Mode 🧹

This script identifies EC2 instances that have been running for more than 7 days.
It displays a table with details of all EC2 instances (including newer ones),
and then prompts you to decide whether to terminate each older instance individually.

🔐 Protection: Instances launched less than 7 days ago are never deleted automatically.
🔎 Extras: The script also shows attached resources (volumes, Elastic IPs, network interfaces).

💡 Usage:
1. Make sure your AWS credentials are configured (`aws configure`)
2. Install dependencies: `pip install boto3 tabulate`
3. Run the script: `python list_old_ec2_instances.py`

⚠️ WARNING: The script requires appropriate IAM permissions (e.g., EC2:Describe*, EC2:TerminateInstances).
"""

import boto3
from datetime import datetime, timezone, timedelta
from tabulate import tabulate

ec2 = boto3.resource('ec2')
client = boto3.client('ec2')

def get_instance_name(tags):
    if tags:
        for tag in tags:
            if tag["Key"] == "Name":
                return tag["Value"]
    return "(no-name)"

def list_old_instances(min_age_days=7):
    print(f"\n🔍 Checking for EC2 instances older than {min_age_days} days...\n")

    instances = ec2.instances.all()
    old_instances = []
    rows = []

    now = datetime.now(timezone.utc)
    for inst in instances:
        launch_time = inst.launch_time
        age_days = (now - launch_time).days
        name = get_instance_name(inst.tags)
        status = inst.state['Name']

        rows.append([
            inst.id,
            name,
            inst.instance_type,
            status,
            launch_time.strftime('%Y-%m-%d'),
            f"{age_days}d"
        ])

        if status == "running" and age_days >= min_age_days:
            old_instances.append(inst)

    headers = ["Instance ID", "Name", "Type", "Status", "Launch Date", "Age"]
    print(tabulate(rows, headers=headers, tablefmt="github"))

    return old_instances

def show_instance_resources(instance):
    print(f"\n🔗 Resources for EC2 {instance.id}:")

    # Attached volumes
    for vol in instance.volumes.all():
        print(f" - 📦 Volume: {vol.id} | Size: {vol.size} GiB | Type: {vol.volume_type}")

    # Elastic IP (if any)
    eni_ids = [eni.id for eni in instance.network_interfaces]
    if eni_ids:
        eips = client.describe_addresses(Filters=[
            {"Name": "network-interface-id", "Values": eni_ids}
        ])["Addresses"]
        for eip in eips:
            print(f" - 🌐 Elastic IP: {eip['PublicIp']} | AllocationId: {eip['AllocationId']}")

    # Network interfaces
    for eni in instance.network_interfaces:
        print(f" - 📶 ENI: {eni.id} | Private IP: {eni.private_ip_address}")

def ask_confirm(question):
    reply = input(f"{question} (yes/[no]): ").strip().lower()
    return reply == "yes"

def delete_instance(instance):
    instance.terminate()
    print(f"🗑️ Terminating {instance.id}...")

def main():
    old_instances = list_old_instances()

    if not old_instances:
        print("\n✅ No EC2 instances older than 7 days were found.\n")
        return

    for inst in old_instances:
        show_instance_resources(inst)

        if ask_confirm(f"\n❓ Do you want to terminate EC2 instance {inst.id}?"):
            delete_instance(inst)
        else:
            print(f"⏭️ Skipping {inst.id}.\n")

    print("✅ Done.\n")

if __name__ == "__main__":
    main()
