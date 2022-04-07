import os

handler(){ 
  BUCKET_ARN = os.environ['BUCKET_ARN']
  print("My bucket ARN is: " + BUCKET_ARN)
}