Return-Path: <cgroups+bounces-2633-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4D38AB87F
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 03:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69891B212EB
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A5A10F7;
	Sat, 20 Apr 2024 01:48:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F7DDB1;
	Sat, 20 Apr 2024 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577709; cv=none; b=FVVeZxur4IZr0sMDuo92lnRxAxcK5C0VJoCxwsm9kNxLhxf4Uhuvzqdcr/veYgwdVHLl+KPMhA9VCItOr3sPo0YgKb8LsVN7h3S1UqqWvJrSFQPVzdo31peFj4AJuxRLoDbgloJeDkFY2baKfEOOw0fvC4L59+Fk9dSOQ0OK0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577709; c=relaxed/simple;
	bh=PRyhg7e+mN6SBwakmbZV54xUMWp9H3k8cyG0AlwU5UQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XyiFC0FAwiLWn3Ln8c66D6mNNYu5Y5k/bUn/H07+mQZQpLnIhRi79oBdAEcMmLpbvD8ncJ0710Q0yeXYA3pkGAud+wx+LwJ7vByl2cSKFJ824zb+ofT78zAgIW96tBhhR34FeXQYb7j/AEtxCCE2tgGDAaHPhEVsgIGHLOrrDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VLvY94bfyz4f3lWJ;
	Sat, 20 Apr 2024 09:48:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A6A581A0DE0;
	Sat, 20 Apr 2024 09:48:22 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHkHiNmgGPIKQ--.24502S3;
	Sat, 20 Apr 2024 09:48:22 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: fix repeat limit on bio with
 BIO_BPS_THROTTLED
To: zhoutaiyu <zhoutaiyu@kuaishou.com>, tj@kernel.org
Cc: josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240419120747.38031-1-zhoutaiyu@kuaishou.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ea781ccc-c29e-894e-c54a-f44ea349edca@huaweicloud.com>
Date: Sat, 20 Apr 2024 09:48:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240419120747.38031-1-zhoutaiyu@kuaishou.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBHkHiNmgGPIKQ--.24502S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1Uur45Cr4fKFyruFW3Jrb_yoW5Gw17pr
	WxuF4UJw1kXF4qkr45Kr1agF93t3yxAryUAas3J3yayFW3Wry2gr1UZF18A3y0vFs7GayU
	ZFs7Xr93G3WjyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/19 20:07, zhoutaiyu Ð´µÀ:
> Give a concrete example, a bio is throtted because of reaching bps
> limit. It is then dispatched to request layer after a delay. In the
> request layer, it is split and the split bio flagged with
> BIO_BPS_THROTTLED will re-enter blkthrottle.
> The bio with BIO_BPS_THROTTLED should not be throttled for its bytes
> again. However, when the bps_limit and iops_limit are both set and
> sq->queue is not empty, the bio will be throttled again even the tg is
> still within iops limit.

I don't understand here, split bio should be throttled by iops limit
again, this is expected. If you mean that that throtl time calculated
by iops_limit is wrong, you need to provide more informatiom.
> 
> Test scrips:
> cgpath=/sys/fs/cgroup/blkio/test0
> mkdir -p $cgpath
> echo "8:0 10485760" > $cgpath/blkio.throttle.write_bps_device
> echo "8:16 100000" > $cgpath/blkio.throttle.write_iops_device

What? 8:0 and 8:16?

> for ((i=0;i<50;i++));do
>    fio -rw=write -direct=1 -bs=4M -iodepth=8 -size=200M -numjobs=1 \
> -time_based=1 -runtime=30  -name=testt_$i -filename=testf_$i > /dev/null &
>    echo $! > $cgpath/tasks
> done
> 
> The output of iostat:
> Device:  ...  wMB/s  ...
> sdb      ...  3.75  ...
> sdb      ...  2.50  ...
> sdb      ...  3.75  ...
> sdb      ...  2.50  ...
> sdb      ...  3.75  ...
> 
> In order to fix this problem, early throttled the bio only when
> sq->queue is no empty and the bio is not flagged with BIO_BPS_THROTTLED.
> 
> Signed-off-by: zhoutaiyu <zhoutaiyu@kuaishou.com>
> ---
>   block/blk-throttle.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index f4850a6..499c006 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -913,7 +913,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>   	 * queued.
>   	 */
>   	BUG_ON(tg->service_queue.nr_queued[rw] &&
> -	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
> +	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]) &&
> +	       !bio_flagged(bio, BIO_BPS_THROTTLED));
>   
>   	/* If tg->bps = -1, then BW is unlimited */
>   	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
> @@ -2201,7 +2202,7 @@ bool __blk_throtl_bio(struct bio *bio)
>   		throtl_downgrade_check(tg);
>   		throtl_upgrade_check(tg);
>   		/* throtl is FIFO - if bios are already queued, should queue */
> -		if (sq->nr_queued[rw])
> +		if (sq->nr_queued[rw] && !bio_flagged(bio, BIO_BPS_THROTTLED))

No, this change is wrong. Split IO will not be throttled by iops limit
anymore.

Thanks,
Kuai

>   			break;
>   
>   		/* if above limits, break to queue */
> 


