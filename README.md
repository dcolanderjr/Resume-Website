Not the fanciest of things, but its more of a proof of concept. Completed using Terraform, Javascript, HTML, and CSS. This was fun, but frustrating. Alot of back and forth with the terraform set up regarding CloudFront.
Everytime I would deploy, I'd always get this XML error, and after scouring the internet for hours upon hours, I'd fix, then break, fix then break. It came down to a piece of my code that I was using to deploy the OAC(origin access control)
was misconfigured.

The architecture for this is simple: it's a static website hosted within an S3 bucket, that has a cloudfront distribution, and uses route53 for domain hosting.
The S3 bucket has the index.html file, as well as the javascript, and css files necessary to host the website, and its different portions (background, interactive clicking, etc.) I registered a personal domain
through route53, which has the hosted zone. I used ACM to provide an SSL certificate for the CloudFront distribution in order to provide HTTPS connectivity to the website. All of this was deployed via the source files.

Anyway, here's the link to the site, enjoy!

www.kloudkamp.com/
