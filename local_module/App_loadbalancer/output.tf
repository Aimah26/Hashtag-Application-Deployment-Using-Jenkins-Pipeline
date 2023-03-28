output "lb_tg" {
    value = aws_lb_target_group.Hash_lb_TG.arn
}

output "lb_DNS" {
    value = aws_lb.Hash_lb.dns_name
}

output "lb_zone_id" {
    value = aws_lb.Hash_lb.zone_id
}

output "lb_arn" {
    value = aws_lb.Hash_lb.arn
}