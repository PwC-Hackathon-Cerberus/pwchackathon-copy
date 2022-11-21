# HSUHK-CERBERUS, PwC Hackaday Hackathon 2022

# Cerberus Web Portal

GitLab Repository: https://gitlab.com/pwc-hackathon-cerberus/pwchackathon

## Prerequisites

At the time of writing, this app works well under below environment:

- [✓] Chrome: Version 107.0.5304.110 (Official Build) (arm64)
- [✓] Safari: Version 16.1 (18614.2.9.1.12)
- [✓] Firefox: 106.0.5 (64-bit)

## Things to know before you access this web portal

- The project is based on t2.micro AWS EC2 instance, using the AWS Free Tier includes 750 hours of Linux and Windows t2.micro instances each month for one year. To stay within the Free Tier, use only EC2 Micro instances. For details: https://aws.amazon.com/ec2/instance-types/t2/

## To access this web portal

http://34.219.26.84/

### Steps we did to build this project (Detailed steps to compile/run the source code)

1. Download Terraform
   https://www.terraform.io/downloads

2. Install Terraform
   https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
   2.1 Unzip
   Terminal:
   2.2

   ```bash
   echo $PATH
   ```

   2.3

   ```bash
   mv ~/Downloads/terraform /usr/local/bin/
   ```

   2.4

   ```bash
    mkdir terraform-aws-instance
   ```

   2.5

   ```bash
   cd terraform-aws-instance
   ```

   2.6

   ```bash
    touch main.tf
   ```

   2.7 Edit main.tf

3. Install AWS CLI
   Terminal:
   3.1

   ```bash
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
   ```

   3.2

   ```bash
    sudo installer -pkg AWSCLIV2.pkg -target /
   ```

   3.3

   ```bash
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
   ```

   3.4

   ```bash
     sudo installer -pkg ./AWSCLIV2.pkg -target /
   ```

   3.5

   ```bash
   which aws
   ```

   3.6

   ```bash
   aws –version
   ```

4. Run AWS CLI
   Terminal:
   4.1

   ```bash
    aws configure
   ```

   4.2 Enter the Access Key ID and Secret Access Key
   https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/security_credentials
   4.3

   ```bash
   terraform init
   ```

   4.4

   ```bash
   terraform apply -auto-approve
   ```

   4.5

   ```bash
   terraform show
   ```

5. Check EC2
   https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#Instances:

6. Check DynamoDB
   https://us-west-2.console.aws.amazon.com/dynamodbv2/home?region=us-west-2#table?initialTagKey=&name=tf-notes-table&tab=indexes

7. Create key pair

By Terraform
https://www.youtube.com/watch?v=lJbf0J9rRzE
Or by AWS panel
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html#having-ec2-create-your-key-pair

8. How to Create AWS Security group using Terraform and attach to instance
   https://www.youtube.com/watch?v=Ldj9HWv4CpE

9. Upload file to S3 using Terraform
   https://www.youtube.com/watch?v=3ahcgi8RqCM
   How to create S3 bucket in AWS using Terraform code
   https://www.youtube.com/watch?v=zMEaEMPzOws

10. Using EC2 to run Python script:
    https://alek-cora-glez.medium.com/deploying-flask-application-on-aws-ec2-using-load-balancer-elb-and-auto-scaling-group-asg-141355d97f94

10.1

```bash
cd terraform-aws-instance
```

10.2

```bash
chmod 400 tfkey
```

10.3

```bash
ssh ec2-user@YOUR_EC2_INSTANCE_PUBLIC_IPv4Address -i tfkey
```

or

```bash
ssh ec2-user@34.219.26.84 -i tfkey
```

10.4

```bash
sudo yum update
```

10.5

```bash
sudo yum install python3
```

10.6

```bash
pip3 install flask

```

10.7 (if any)

```bash
pip3 install requirements.txt
```

10.8

```bash
pip3 install urllib3
```

10.9 Upload app.py, home.html to S3 via Terraform script
10.10 Modify the path in app.py by home.html URL in S3
10.11

```bash
python3 -c "$(wget -q -O - https://my-tf-cerberus-bucket09112022.s3.us-west-2.amazonaws.com/app.py)"
```

In case of failed use URL file: https://www.youtube.com/watch?v=SvgcMGfZxiY&ab_channel=SagarS
