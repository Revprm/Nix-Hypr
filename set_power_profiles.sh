#!/bin/bash
read -p "Enter power profile (e.g., performance, balanced, power_saver): " power_profile
echo "Setting power profile to: $power_profile"

echo "Checking if the power profile path exists..."

power_profiles_path='/sys/firmware/acpi/platform_profile'

# Check if file exists
if [ -e "$power_profiles_path" ]; then
    echo "Power profile path exists: $power_profiles_path"
else
    echo "Power profile path does not exist: $power_profiles_path"
    echo "Please ensure you have the correct permissions and that the system supports power profiles."
    exit 1
fi

echo "Setting power profile..."
echo "$power_profile" | sudo tee "$power_profiles_path" > /dev/null
if [ $? -eq 0 ]; then
    echo "Power profile set successfully."
else
    echo "Failed to set power profile. Please check your permissions or the profile name."
    exit 1
fi
echo "Current power profile:"
cat "$power_profiles_path"
echo "Script completed."
exit 0