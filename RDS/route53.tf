resource "aws_route53_zone" "zone_id" {
  name =  "illiasoroka.com"
}

resource "aws_route53_record" "writer" {
  zone_id =  aws_route53_zone.zone_id.id
  name    =  "writer.illiasoroka.com"
  type    = "A"
  ttl     = "300"
  records = [aws_db_instance.db_writer.endpoint]
  depends_on = [ aws_db_instance.db_writer ]
}

resource "aws_route53_record" "reader" {
  count = 3
  zone_id = aws_route53_zone.zone_id.id
  name = "reader${count.index + 1}.illiasoroka.com"
  type = "CNAME"
  ttl = 300
  records = [aws_db_instance.db_readers[count.index].endpoint]
  depends_on = [ aws_db_instance.db_readers ]
}