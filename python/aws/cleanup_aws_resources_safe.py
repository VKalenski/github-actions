import boto3

ec2 = boto3.client('ec2')

def get_unused_ebs_volumes():
    volumes = ec2.describe_volumes(Filters=[
        {"Name": "status", "Values": ["available"]}
    ])["Volumes"]
    return volumes

def get_own_snapshots():
    snapshots = ec2.describe_snapshots(OwnerIds=["self"])["Snapshots"]
    return snapshots

def get_unassociated_eips():
    addresses = ec2.describe_addresses()["Addresses"]
    return [a for a in addresses if "AssociationId" not in a]

def show_and_confirm(resources, resource_type, delete_func):
    if not resources:
        print(f"✅ No {resource_type} found.\n")
        return

    print(f"\n🔍 Found {len(resources)} {resource_type}:")
    for res in resources:
        if resource_type == "EBS volumes":
            print(f" - {res['VolumeId']} | {res['Size']} GiB | {res['AvailabilityZone']}")
        elif resource_type == "Snapshots":
            print(f" - {res['SnapshotId']} | {res['StartTime']} | {res.get('Description', '')}")
        elif resource_type == "Elastic IPs":
            print(f" - {res['PublicIp']} | Allocation ID: {res['AllocationId']}")

    if ask_confirm(f"\n❓ Do you want to delete these {resource_type}?"):
        for res in resources:
            delete_func(res)
        print(f"🗑️ Deleted {resource_type}.\n")
    else:
        print(f"❌ Skipped deleting {resource_type}.\n")

def ask_confirm(question):
    reply = input(f"{question} (yes/[no]): ").strip().lower()
    return reply == "yes"

def delete_volume(volume):
    ec2.delete_volume(VolumeId=volume["VolumeId"])

def delete_snapshot(snapshot):
    ec2.delete_snapshot(SnapshotId=snapshot["SnapshotId"])

def release_eip(address):
    ec2.release_address(AllocationId=address["AllocationId"])

def main():
    print("🔧 AWS Cleanup Tool – Preview First\n")

    ebs_vols = get_unused_ebs_volumes()
    snapshots = get_own_snapshots()
    eips = get_unassociated_eips()

    show_and_confirm(ebs_vols, "EBS volumes", delete_volume)
    show_and_confirm(snapshots, "Snapshots", delete_snapshot)
    show_and_confirm(eips, "Elastic IPs", release_eip)

    print("✅ Cleanup finished.\n")

if __name__ == "__main__":
    main()
