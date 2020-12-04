Setup instructions

1. Navigate to project directory
2. Run bash ./download.sh
3. Run bash ./macos_configure.sh (Or ./configure.sh if Linux, or ./gpu_configure.sh if Linux with GPU)
4. Run bash -i ./main_test.sh



Steps to connect to the AWS:

1. Under the AWS management console, Open the Amazon EC2 console by choosing EC2 under Compute.
2. From the Amazon EC2 dashboard, choose Launch Instance.
3. The Choose an Amazon Machine Image (AMI) page displays a list of basic configurations called Amazon Machine Images (AMIs) that serve as templates for your instance. Select the HVM edition of the Amazon Linux AMI. Notice that this configuration is marked Free tier eligible.
4. On the Choose an Instance Type page, choose p2 or g3 as the hardware configuration of your instance and Review and Launch. (For getting the p2 and g3 instance with 150 GPU you have to raise a ticket and get the access from the support Team.
5. On the Review Instance Launch page, choose Launch.
6. In the Select an existing key pair or create a new key pair dialog box, choose Create a new key pair, enter a name for the key pair, and then choose Download Key Pair. This is the only chance for you to save the private key file, so be sure to download it. Save the private key file in a safe place. You can use C:\user\yourusername\.ssh\myfirstkey.pem if you are on a Windows machine, and ~/.ssh/myfirstkey.pem if you are on a Mac or Linux machine. You need to provide the name of your key pair when you launch an instance, and the corresponding private key each time you connect to the instance.
7. A confirmation page lets you know that your instance is launching. Choose View Instances to close the confirmation page and return to the console.

------------FOR WINDOWS-----------------
PuTTY uses .ppk files instead of .pem files. If you haven't already generated a .ppk file, do so now.
1. On the Start menu, choose All Programs, PuTTY, PuTTY.
2. In the Category pane, choose Session and complete the following fields:
      For Host Name, enter ec2-user@public_dns_name.
      For Connection type, choose SSH.
      For Port, ensure that the value is 22.
3. In the Category pane, choose Connection, SSH, and Auth. Complete the following:
      Choose Browse, select the .ppk file that you generated for your key pair, and then choose Open.
      Choose Open to start the PuTTY session.
4. If this is the first time you have connected to this instance, PuTTY displays a security alert dialog box that asks whether you trust the host you are connecting to. Choose Yes. A window opens and you are connected to your instance.

-------------------FOR MAC-----------------------
1. Open your command line shell and change the directory to the location of the private key file that you created when you launched the instance.
    Use the chmod command to make sure your private key file isn't publicly viewable. For example, if the name of your private key file is my-key-pair.pem, use the     following command:
    chmod 400 my-key-pair.pem

2. Use the following SSH command to connect to the instance:
   ssh -i /path/my-key-pair.pem ec2-user@public_dns_name
----------------------Copy data folder from local to ec2 instance-----------------------------
1. scp -i path/to/key file/to/copy user@ec2-xx-xx-xxx-xxx.compute-1.amazonaws.com:path/to/file (To copy files)
2. scp -i path/to/key -r directory/to/copy user@ec2-xx-xx-xxx-xxx.compute-1.amazonaws.com:path/to/directory (To copy entire directory)




