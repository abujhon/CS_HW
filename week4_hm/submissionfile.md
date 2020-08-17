#### Step 1: Ensure Permissions on Sensitive Files
Inspect the file permissions of each of the files below. If they do not match the descriptions, please update the permissions.
  1. Permissions on `/etc/shadow` should allow only `root` read and write access.
  2. Permissions on `/etc/gshadow` should allow only `root` read and write access.
  3. Permissions on `/etc/group` should allow `root` read and `write` access, and allow everyone else `read` access only.
  4. Permissions on `/etc/passwd` should allow `root` read and `write` access, and allow everyone else `read` access only.

ls -l /etc/shadow
ls -l /etc/gshadow
ls -l /etc/group
ls -l /etc/passwd

#### Step 2: Create User Accounts

This step asks you to set up various users. These commands do not require you to be working from a specific directory.
1. Add user accounts for `sam`, `joe`, `amy`, `sara`, and `admin`.
sudo adduser sam
sudo adduser joe
sudo adduser amy
sudo adduser sara
sudo adduser admin
2. Next, we want to ensure that the user's passwords fit various requirements for length and complexity.
    - Force users to create passwords with a minimum length of 16 characters that incorporate all 4 types of character type classes (numbers, symbols, etc.).

sudo vim /etc/pam.d/common-password
then change "password   requisite   pam_pwquality.so"
to "password    requisite      pam_pwquality.so retry=3 minlen=8 maxrepeat=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1"

3. We also want to enforce a password rotation policy. In old Linux terms, we might have called this process the **change age** for password expiration.
    - Force passwords to expire at a _maximum_ of every 90 days.

sudo nano /etc/login.defs
then change PASS_MAX_DAYS = 90

4. Lastly, we want to make sure that only the `admin` user has general `sudo` group access. This requires a command that will allow user modifications.

sudo visudo 
then add this line "admin ALL=(ALL:ALL) /usr/bin/sudo"

#### Step 3: Create User Group and Collaborative Folder

1. Add the group `engineers` to the system.
sudo groupadd engineers
2. Add users `sam`, `joe`, `amy`, and `sara` to the managed group. This will be similar to how you added `admin` to the `sudo` group in the previous exercise.
sudo usermod -a -G engineers sam
sudo usermod -a -G engineers joe
sudo usermod -a -G engineers amy
sudo usermod -a -G engineers sara

3. Create a shared folder for this group: `/home/engineers`.
sudo mkdir /home/engineers
4. Change ownership on the new engineers' shared folder to the `engineers` group.
sudo chmod g+rwx /home/engineers
5. Using `chmod`'s letter-based options, add the SGID bit _and_ the sticky bit to allow collaboration between engineers in this directory.
sudo chmod -R 2775 /home/engineers


#### Step 4: Lynis Auditing

1. Install the Lynis package to your system if it is not already installed.
sudo apt install lynis
2. Check the Lynis documentation for instructions on how to run a system audit.
sudo lynis --help
3. Run a Lynis system audit with `sudo`.
sudo lynis audit system
4. Provide a report from the Lynis output on what more could be done to harden the system.


#### Bonus 

1. Install the chkrootkit package to your system if it is not already installed.
sudo apt install chkrootkit
2. Check the chkrootkit documentation for instructions on how to run a scan to find system root kits.
chkrootkit -h
3. Run chkrootkit (with `sudo`) in expert mode to verify the system does not have a root kit installed.
sudo chkrootkit -x
4. Provide a report from chkrootkit output on what more could be done to harden the system.


