Return-Path: <cgroups+bounces-13233-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B706D226D0
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 06:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13C0C304869B
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 05:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD8E2D59E8;
	Thu, 15 Jan 2026 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="BO/v8l4R"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-33.ptr.blmpb.com (sg-1-33.ptr.blmpb.com [118.26.132.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865F2D1F64
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768454698; cv=none; b=NOW0vuMtBxCX/N2FbgckZ/2NUmeKDmcnJZIeHghr67CKMgL0odCMB1MPSWqYGCnp1/9Kcv2bPFFSzh/IpdW4mT9BTuIcn2C4i8mX7K4dt63Pm/ayr0LZl1dBepmdg6o/RLu4/MZ+qMGsLfD/ZMXqogZM7ax/YbP8+lIPXzuy2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768454698; c=relaxed/simple;
	bh=udqXm+27Da4QgLfqsQ8AYjGfU336UmclFiiWtl3OOmk=;
	h=Cc:Message-Id:To:Subject:Mime-Version:Content-Type:From:Date:
	 In-Reply-To:References; b=WVvVkn4WvT7gT5GZFssQPIV1GMXC3t9zSlJUoFW0ymzFrXzxFPct16SxK71WpGSVtgobdj9++Nep80nlDhNaEw7wtI9CXEoHqIO/l0T04NHBng1kvyuQ3bENkZ8WNoIJm8W+4xBJMkYreTxHp6fxUtpcH+UvzfcfUfEPg0zA4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=BO/v8l4R; arc=none smtp.client-ip=118.26.132.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1768454678;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=pGbqDVxaaSoXeisy9oAv4kNo2B4S4W5koTiOhYTomKs=;
 b=BO/v8l4RCc8nzg9R4V2jGmXLFefTMIHla/yPxitsbomzjp5M40vYeG26L09awMybW5KWO/
 itO9TTvpuYWVGE2HZTzUSQZbLtfIHIBYZ0i0DUthH6eTBl5ym6kNuyNQ9z1x8BtLU8ETMt
 jegOPoXGma0T3WO94wb8HD3aCHqzM8EmvUt+s2M5hOtZztchVJOh+25v+NJUcdqs6+L4Mg
 DxAv2I1S1KdkrsERD9kVzLxhsGmjQqxTJ3WN+1b/SB7z0Mf58eJBMXNkFao/uwVXF+b0JC
 2Dg+vSlQGsmW70e6z63Pi+GkFzOcp9xDl3R6seI+mLzq/Vfu+F1RzO5svInNlw==
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <mkoutny@suse.com>, 
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <houtao1@huawei.com>, 
	<zhengqixing@huawei.com>, <yukuai@fnnas.com>
Message-Id: <50d63ff3-97ef-499f-961d-cf6766a8028b@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+269687a14+0652d4+vger.kernel.org+yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
To: "Zheng Qixing" <zhengqixing@huaweicloud.com>, <tj@kernel.org>, 
	<josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@infradead.org>
Subject: Re: [PATCH v2 2/3] blk-cgroup: skip dying blkg in blkcg_activate_policy()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Thu, 15 Jan 2026 13:24:33 +0800
In-Reply-To: <20260113061035.1902522-3-zhengqixing@huaweicloud.com>
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Thu, 15 Jan 2026 13:24:35 +0800
References: <20260113061035.1902522-1-zhengqixing@huaweicloud.com> <20260113061035.1902522-3-zhengqixing@huaweicloud.com>
Content-Language: en-US
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2026/1/13 14:10, Zheng Qixing =E5=86=99=E9=81=93:
> From: Zheng Qixing <zhengqixing@huawei.com>
>
> When switching IO schedulers on a block device, blkcg_activate_policy()
> can race with concurrent blkcg deletion, leading to a use-after-free in
> rcu_accelerate_cbs.
>
> T1:                               T2:
> 		                  blkg_destroy
>                   		  kill(&blkg->refcnt) // blkg->refcnt=3D1->0
> 				  blkg_release // call_rcu(__blkg_release)
>                                    ...
> 				  blkg_free_workfn
>                                    ->pd_free_fn(pd)
> elv_iosched_store
> elevator_switch
> ...
> iterate blkg list
> blkg_get(blkg) // blkg->refcnt=3D0->1
>                                    list_del_init(&blkg->q_node)
> blkg_put(pinned_blkg) // blkg->refcnt=3D1->0
> blkg_release // call_rcu again
> rcu_accelerate_cbs // uaf
>
> Fix this by replacing blkg_get() with blkg_tryget(), which fails if
> the blkg's refcount has already reached zero. If blkg_tryget() fails,
> skip processing this blkg since it's already being destroyed.
>
> Link: https://lore.kernel.org/all/20260108014416.3656493-4-zhengqixing@hu=
aweicloud.com/
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free=
_workfn() and blkcg_deactivate_policy()")
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-cgroup.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 600f8c5843ea..5dbc107eec53 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1622,9 +1622,10 @@ int blkcg_activate_policy(struct gendisk *disk, co=
nst struct blkcg_policy *pol)
>   			 * GFP_NOWAIT failed.  Free the existing one and
>   			 * prealloc for @blkg w/ GFP_KERNEL.
>   			 */
> +			if (!blkg_tryget(blkg))
> +				continue;

So, why this check is still before the pd_alloc_fn()?

See blkg_destroy(), can you replace this by the same checking:

list_for_each_entry_reverse()
	if (hlist_unhashed(&blkg->blkcg_node))
		continue;
	if (blkg->pd[pol->plid])
		continue;

>   			if (pinned_blkg)
>   				blkg_put(pinned_blkg);
> -			blkg_get(blkg);
>   			pinned_blkg =3D blkg;
>  =20
>   			spin_unlock_irq(&q->queue_lock);

--=20
Thansk,
Kuai

