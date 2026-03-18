@echo off
for /f "tokens=*" %%a in ('aws ecs list-tasks --cluster claimiq-cluster --region ap-south-1 --query "taskArns[0]" --output text') do set TASK_ARN=%%a
for /f "tokens=*" %%a in ('aws ecs describe-tasks --cluster claimiq-cluster --tasks %TASK_ARN% --region ap-south-1 --query "tasks[0].attachments[0].details[1].value" --output text') do set ENI_ID=%%a
for /f "tokens=*" %%a in ('aws ec2 describe-network-interfaces --network-interface-ids %ENI_ID% --region ap-south-1 --query "NetworkInterfaces[0].Association.PublicIp" --output text') do set PUBLIC_IP=%%a
echo.
echo Backend IP: %PUBLIC_IP%
echo.
echo Update your .env.local:
echo VITE_API_BASE_URL=http://%PUBLIC_IP%:3000
echo.get-backend-ip.cmd