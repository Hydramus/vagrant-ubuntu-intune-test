# Ubuntu Test Device for Microsoft Intune Enrollment

This project sets up a virtual Ubuntu desktop environment using Vagrant, provisioned with necessary tools and applications for testing the enrollment into Microsoft Intune. The virtual machine is configured to use VirtualBox as a provider.

The provisioning script installs Ubuntu desktop, VirtualBox guest utilities, Google Chrome, Microsoft Edge, Visual Studio Code, Microsoft Intune App, Microsoft Defender Endpoint, and Node.js. The script also configures the timezone and adds the default vagrant user to the admin group.

The project is intended to work on Windows, macOS, Linux, and within Windows Subsystem for Linux (WSL).

## Prerequisites

- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Internet connection (the VM requires access to the internet to download necessary packages and tools)

## Quick Start

1. Clone this repository.
    ```sh
    git clone https://github.com/your-repo/Ubuntu-Test-Device-for-Intune-Enrollment.git
    cd Ubuntu-Test-Device-for-Intune-Enrollment
    ```

2. Launch the Vagrant VM.
    ```sh
    vagrant up
    ```

3. The GUI should automatically pop up. If not, open VirtualBox and start the VM manually.

4. SSH into the VM once it is up and running, if needed.
    ```sh
    vagrant ssh
    ```

5. When finished, you can suspend the virtual machine by running:
    ```sh
    vagrant suspend
    ```

   Or, you can completely delete it with:
    ```sh
    vagrant destroy
    ```

## Accessing the GUI

This Vagrant setup is configured to automatically display the graphical user interface (GUI) of the Ubuntu desktop environment when the VM starts. If the GUI does not automatically appear, follow these steps:

1. Open the VirtualBox application on your host machine.
2. Locate the VM named 'Ubuntu Desktop and Microsoft Intune app' in the list of virtual machines.
3. Right-click on the VM and select "Start" and then "Normal Start".
4. The GUI should now appear in a new window.

## Directory Structure

- `Vagrantfile` - This file contains the configuration settings for the Vagrant VM.
- `scripts/ubuntu_config.sh` - This is the provisioning script that installs and configures the required tools and applications.

## Network Configuration

The VM is configured with a public network, allowing it to communicate with the internet.

## Shared Folders

The project directory is automatically synchronized to the `/vagrant` directory inside the VM. You can change this by modifying the `config.vm.synced_folder` setting in the `Vagrantfile`.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome. Please submit a pull request or create an issue for any enhancements or fixes.


