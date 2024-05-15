echo "Enter the IP address of the Samba server: [e.g 192.168.50.52]"
read ip_address
echo "Enter the name of the Samba share: [e.g samba-share]"
read share_name
echo "Enter your Samba username: [e.g smbuser]"
read smb_username

# Ask the user to enter their Samba password without echoing it
echo "Please enter your Samba password:"
read -s smb_password

# Export the password as an environment variable
export SMB_PASSWORD=$smb_password

# Construct the mount command using the user-provided inputs
mount_command="sudo mkdir /mnt/samba_share ; sudo mount -t cifs //${ip_address}/${share_name} /mnt/samba_share -o username=${smb_username},password=\$SMB_PASSWORD"

# Execute the constructed mount command
eval $mount_command

# Inform the user about the operation result
if [ $? -eq 0 ]; then
    echo "Mounting was successful. [/mnt/samba_share]"
else
    echo "Failed to mount the Samba share."
fi

