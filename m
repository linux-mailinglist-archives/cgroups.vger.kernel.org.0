Return-Path: <cgroups+bounces-15974-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FAFDGL3BmpUpwIAu9opvQ
	(envelope-from <cgroups+bounces-15974-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 12:37:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4EC54D777
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 401DF30E97D4
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E333A1685;
	Fri, 15 May 2026 10:16:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60522F0C74;
	Fri, 15 May 2026 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840173; cv=none; b=QFAVvKO9UeNSN9hRPJiZFAfWEalDlT/LVmGrFk6ptjowS2ltXJ+Z7WTn4GZNh2PTXDS1vU1GrPYMi0eNnII8D1e7BoCqplOgX4nm6uoWU+VXpoMhNoMaUjN+lLJx19DGKkFdAXRmYFdk4/FNxrSVTXTRIwoRzZajT5/OSxSCfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840173; c=relaxed/simple;
	bh=zO2C2VZXqqpIKBRLjUDBRpJc1zsU7/IHST8QK5POwls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXQUIUwi+timAE9fBOKXl3XYbzdmrSwClcEV5gvxucBDcUwDnsMzs9Pp7MYSaP2H+/LDv4K6GmZWh08sl7XP5TcHhblLKfYvHFVS+OXFIUqI7bpEbY3gLul/puHuk4Fb6wbTlVC8NjLUmcc/UMSSnpxr5BWezfttXualgrFlULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gH33d3dNzzKHMnB;
	Fri, 15 May 2026 18:15:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 985BF40578;
	Fri, 15 May 2026 18:16:06 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP4 (Coremail) with SMTP id gCh0CgCnb1th8gZqmNWFCQ--.6285S3;
	Fri, 15 May 2026 18:16:02 +0800 (CST)
Message-ID: <077ba2ac-f921-4cd4-865c-d803f3eaa5cb@huaweicloud.com>
Date: Fri, 15 May 2026 18:16:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-cgroup: Fix UAF in blkcg_activate_policy() by using
 blkg_tryget()
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, yukuai@fnnas.com, linux-block@vger.kernel.org
Cc: cgroups@vger.kernel.org, yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20260515061516.3461291-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20260515061516.3461291-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnb1th8gZqmNWFCQ--.6285S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4fuw15KF47KFWUJF4DXFb_yoW5urW8pF
	Z8GrZayr97Xryqqa1Uua47X340ga1vgr4UJrWxGr13Cr4avr1aqF4UCr4DXFZ7uFZrAr45
	AF45JayqkF4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/
X-Rspamd-Queue-Id: 9A4EC54D777
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15974-lists,cgroups=lfdr.de];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wozizhi@huaweicloud.com,cgroups@vger.kernel.org];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


I just realized that the fix has already been included in this patchset:

https://lore.kernel.org/all/20260304073809.3438679-5-yukuai@fnnas.com/

Please disregard this patch.

在 2026/5/15 14:15, Zizhi Wo 写道:
> [BUG]
> Our fuzz testing triggered a blkg use-after-free issue:
> 
>    BUG: KASAN: slab-use-after-free in percpu_ref_put_many.constprop.0+0xbe/0xe0
>    Call Trace:
>    ...
>    blkcg_activate_policy+0x347/0xfa0
>    bfq_create_group_hierarchy+0x5b/0x140
>    bfq_init_queue+0xc1b/0x1470
>    ? mutex_init_generic+0x9f/0x100
>    ? elevator_alloc+0x166/0x2b0
>    blk_mq_init_sched+0x2b0/0x730
>    elevator_switch+0x188/0x450
>    elevator_change+0x290/0x470
>    elv_iosched_store+0x30a/0x3a0
>    ...
> 
> [CAUSE]
> process1						process2
> cgroup_rmdir
> ...
>    blkcg_destroy_blkgs
>      spin_trylock(&q->queue_lock)
>      blkg_destroy
>        percpu_ref_kill(&blkg->refcnt)
>        ...
>          blkg_free
> 	  INIT_WORK(xxx, blkg_free_workfn)
> 	  schedule_work
>      spin_unlock(&q->queue_lock)
> ====================================schedule_work
>              blkg_free_workfn
> 							elevator_change
> 							...
> 							  bfq_create_group_hierarchy
> 							    blkcg_activate_policy
> 							      spin_lock_irq(&q->queue_lock)
> 							      blkg_get		// get dead ref !!
> 							      pinned_blkg = blkg
> 							      spin_unlock_irq(&q->queue_lock)
> 	      spin_lock_irq(&q->queue_lock)
> 	      list_del_init(&blkg->q_node)
> 	      spin_unlock_irq(&q->queue_lock)
> 	      kfree(blkg)
> 							      blkg_put(pinned_blkg)	// UAF !!
> 
> A blkg killed by blkg_destroy() stays on q->blkg_list until
> blkg_free_workfn() grabs queue_lock and unlinks it. blkg_get() on a dead
> percpu_ref does not resurrect the blkg, so the later blkg_put() hits freed
> memory and triggers this issue.
> 
> [Fix]
> Replace blkg_get() with blkg_tryget(), which fails on a dead ref and lets
> the loop skip dying blkgs.
> 
> Also hoist the ref acquisition to the top of the loop so dying blkgs are
> filtered out before a pd is allocated and attached. Otherwise a pd attached
> to an already-destroyed blkg would never called pd_offline_fn().
> 
> Fixes: 9d179b865449 ("blkcg: Fix multiple bugs in blkcg_activate_policy()")
> Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
> ---
>   block/blk-cgroup.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 554c87bb4a86..03b6ce934848 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1621,6 +1621,10 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>   		if (blkg->pd[pol->plid])
>   			continue;
>   
> +		/* a destroyed blkg may still be on q->blkg_list; skip it via tryget */
> +		if (!blkg_tryget(blkg))
> +			continue;
> +
>   		/* If prealloc matches, use it; otherwise try GFP_NOWAIT */
>   		if (blkg == pinned_blkg) {
>   			pd = pd_prealloc;
> @@ -1637,7 +1641,6 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>   			 */
>   			if (pinned_blkg)
>   				blkg_put(pinned_blkg);
> -			blkg_get(blkg);
>   			pinned_blkg = blkg;
>   
>   			spin_unlock_irq(&q->queue_lock);
> @@ -1666,6 +1669,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>   		pd->online = true;
>   
>   		spin_unlock(&blkg->blkcg->lock);
> +
> +		blkg_put(blkg);
>   	}
>   
>   	__set_bit(pol->plid, q->blkcg_pols);


