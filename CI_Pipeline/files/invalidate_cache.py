import boto3
from datetime import datetime

cloudfront = boto3.client("cloudfront")
bucket_key = "index.html"
distribution_id = "E2D4ZRI8IRCEPK"

cloudfront.create_invalidation(
    DistributionId= distribution_id,
    InvalidationBatch= {
        'Paths': {
            'Quantity': 1,
            'Items': [
                f"/{bucket_key}",
            ]
        },
        'CallerReference': str(datetime.timestamp(datetime.now()))
    }
)
