Return-Path: <cgroups+bounces-5175-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565029A965D
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 04:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0F028322A
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 02:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D5513A863;
	Tue, 22 Oct 2024 02:43:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9912F5B3;
	Tue, 22 Oct 2024 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565017; cv=none; b=XPt5Hnk3hKtxbX51OPbmuvCe2Ol8y5XDFDFbvNslw9L0nrfplBySuLRdsh4svAexEce0lM68CLVS+atUAID+GqO56ffGHiOcM/yePV2rKiri+U6H9rN5SxTMpNj/71WUxgZjuMbVVrBYrxSZV6Bm37AivDqKwtq5FRVbcY9S884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565017; c=relaxed/simple;
	bh=Wggp83axKwYuG52/5IBox4xlMsX+yBkM3ohG7r4Va/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4gMJuhW9Rdk3Km6f1CpujnYihPt5tM9+L8PPNCoqRU+g7K4uK6dkO8hpKSIXUQSJYyj8Lxxv4zkrTl+OVU3kJ6uN4aDXSht2bXpJLpBUP6BRlDn1pi0vZuSKqgrwf2wKwjFV/ONYp6IFbRsjOozGiZkF9WcxNFeLEtqcNGygA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXc1809QNz4f3jLy;
	Tue, 22 Oct 2024 10:43:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 61ABB1A018C;
	Tue, 22 Oct 2024 10:43:25 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8RLERdnxkAUEw--.52830S3;
	Tue, 22 Oct 2024 10:43:23 +0800 (CST)
Message-ID: <b49ccd16-d31c-af03-7833-d8caaa71d7f6@huaweicloud.com>
Date: Tue, 22 Oct 2024 10:43:23 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH v3] block: flush all throttled bios when deleting the
 cgroup
To: tj@kernel.org, josef@toxicpanda.com, hch@lst.de, mkoutny@suse.com,
 axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
 lilingfeng3@huawei.com
References: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHR8RLERdnxkAUEw--.52830S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4xZr4kWr1ruw45GF1Utrb_yoWrZr4DpF
	WS93W5Cw1Utr9Ikr4agr15JFWS9ws5WrW3C3s7Ja4akrWxt3WDKFn5ZrWrXFWrJFn3Cr4S
	vF1DtrW8uF1DG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUrsqXDUUUU
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

Friendly ping ...

Thanks

在 2024/8/17 15:11, Li Lingfeng 写道:
> From: Li Lingfeng <lilingfeng3@huawei.com>
>
> When a process migrates to another cgroup and the original cgroup is deleted,
> the restrictions of throttled bios cannot be removed. If the restrictions
> are set too low, it will take a long time to complete these bios.
>
> Refer to the process of deleting a disk to remove the restrictions and
> issue bios when deleting the cgroup.
>
> This makes difference on the behavior of throttled bios:
> Before: the limit of the throttled bios can't be changed and the bios will
> complete under this limit;
> Now: the limit will be canceled and the throttled bios will be flushed
> immediately.
>
> References:
> [1] https://lore.kernel.org/r/20220318130144.1066064-4-ming.lei@redhat.com
> [2] https://lore.kernel.org/all/da861d63-58c6-3ca0-2535-9089993e9e28@huaweicloud.com/
>
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>    v2->v3:
>      Change "tg_cancel_bios" to "tg_flush_bios";
>      Add reference of v2 to describe the background.
>   block/blk-throttle.c | 68 ++++++++++++++++++++++++++++----------------
>   1 file changed, 44 insertions(+), 24 deletions(-)
>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 6943ec720f39..cf7f4912c57a 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1526,6 +1526,42 @@ static void throtl_shutdown_wq(struct request_queue *q)
>   	cancel_work_sync(&td->dispatch_work);
>   }
>   
> +static void tg_flush_bios(struct throtl_grp *tg)
> +{
> +	struct throtl_service_queue *sq = &tg->service_queue;
> +
> +	if (tg->flags & THROTL_TG_CANCELING)
> +		return;
> +	/*
> +	 * Set the flag to make sure throtl_pending_timer_fn() won't
> +	 * stop until all throttled bios are dispatched.
> +	 */
> +	tg->flags |= THROTL_TG_CANCELING;
> +
> +	/*
> +	 * Do not dispatch cgroup without THROTL_TG_PENDING or cgroup
> +	 * will be inserted to service queue without THROTL_TG_PENDING
> +	 * set in tg_update_disptime below. Then IO dispatched from
> +	 * child in tg_dispatch_one_bio will trigger double insertion
> +	 * and corrupt the tree.
> +	 */
> +	if (!(tg->flags & THROTL_TG_PENDING))
> +		return;
> +
> +	/*
> +	 * Update disptime after setting the above flag to make sure
> +	 * throtl_select_dispatch() won't exit without dispatching.
> +	 */
> +	tg_update_disptime(tg);
> +
> +	throtl_schedule_pending_timer(sq, jiffies + 1);
> +}
> +
> +static void throtl_pd_offline(struct blkg_policy_data *pd)
> +{
> +	tg_flush_bios(pd_to_tg(pd));
> +}
> +
>   struct blkcg_policy blkcg_policy_throtl = {
>   	.dfl_cftypes		= throtl_files,
>   	.legacy_cftypes		= throtl_legacy_files,
> @@ -1533,6 +1569,7 @@ struct blkcg_policy blkcg_policy_throtl = {
>   	.pd_alloc_fn		= throtl_pd_alloc,
>   	.pd_init_fn		= throtl_pd_init,
>   	.pd_online_fn		= throtl_pd_online,
> +	.pd_offline_fn		= throtl_pd_offline,
>   	.pd_free_fn		= throtl_pd_free,
>   };
>   
> @@ -1553,32 +1590,15 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>   	 */
>   	rcu_read_lock();
>   	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
> -		struct throtl_grp *tg = blkg_to_tg(blkg);
> -		struct throtl_service_queue *sq = &tg->service_queue;
> -
> -		/*
> -		 * Set the flag to make sure throtl_pending_timer_fn() won't
> -		 * stop until all throttled bios are dispatched.
> -		 */
> -		tg->flags |= THROTL_TG_CANCELING;
> -
>   		/*
> -		 * Do not dispatch cgroup without THROTL_TG_PENDING or cgroup
> -		 * will be inserted to service queue without THROTL_TG_PENDING
> -		 * set in tg_update_disptime below. Then IO dispatched from
> -		 * child in tg_dispatch_one_bio will trigger double insertion
> -		 * and corrupt the tree.
> +		 * disk_release will call pd_offline_fn to cancel bios.
> +		 * However, disk_release can't be called if someone get
> +		 * the refcount of device and issued bios which are
> +		 * inflight after del_gendisk.
> +		 * Cancel bios here to ensure no bios are inflight after
> +		 * del_gendisk.
>   		 */
> -		if (!(tg->flags & THROTL_TG_PENDING))
> -			continue;
> -
> -		/*
> -		 * Update disptime after setting the above flag to make sure
> -		 * throtl_select_dispatch() won't exit without dispatching.
> -		 */
> -		tg_update_disptime(tg);
> -
> -		throtl_schedule_pending_timer(sq, jiffies + 1);
> +		tg_flush_bios(blkg_to_tg(blkg));
>   	}
>   	rcu_read_unlock();
>   	spin_unlock_irq(&q->queue_lock);


