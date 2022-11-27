provider "aws" {
    region = "ap-southeast-2"
}

variable "domain_name" { # creating variables
  type        = string
  default     = "explorecalifornia.org"
  description = "The name of the domain for out website."

}


data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "PublicReadGetObject"
    effect = "Allow"
    actions = [ "s3:GetObject" ]
    principals {
      type = "*"
      identifiers = [ "*" ]
    }
    resources = [ "arn:aws:s3:::${var.domain_name}" ] # calling our variables using the "var.<VAR_NAME>"
  }
}
 
/* We can access properties from data sources using this format:
   ${data.<data_source_type>.<data_source_name>.<property>.
 
   In this case, we need the JSON document, which the documentation
   says can be accessed from the .json property. */
 
resource "aws_s3_bucket" "website" { # creates a s3 bucket (think of this as giant folder)
  bucket = "${var.domain_name}"  // The name of the bucket.
  acl    = "public-read"            /* Access control list for the bucket.
                                       Websites need to be publicly-available
                                       to the Internet for website hosting to
                                       work. */
  policy = "${data.aws_iam_policy_document.bucket_policy.json}" # this points to data "aws_iam_policy..." to apply this to bucket
  website {
    index_document = "index.htm"   // The root of the website.
    error_document = "error.htm"   // The page to show when people hit invalid pages.
  }
}
 
output "website_bucket_url" { # output return values of our cmdline
  value = "${aws_s3_bucket.website.website_endpoint}"
}
