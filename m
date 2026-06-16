Return-Path: <cgroups+bounces-17004-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TjzwC6p/MWqpkwUAu9opvQ
	(envelope-from <cgroups+bounces-17004-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 18:54:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4494B6928ED
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 18:54:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cQuwGAkw;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17004-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17004-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8ABA8301EFF9
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15148466B79;
	Tue, 16 Jun 2026 16:44:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A12F745E
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 16:44:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628258; cv=none; b=n4pH1JxPhm+pELzENf4PzqxadZuP2qKCdqkgyxlsp/WOFLUP/IvXOSrqdO+FVfu/F1bpPjcC2sM/PTd1N7YP/xhv/gYM9MVBLjlFot3JNVO3uM6w/C5BhRMZFDoVLs4oZK54ifMc8QrvDlo8JYT9qAttqzZ3aKmUvWFd0H2PPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628258; c=relaxed/simple;
	bh=rzzTs9fhIg4PWYleHoMK85337153JCynCROXTm1Ez1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZ/dNqXPPQxvyVAuNlj2o1I20D3EOFBdAKFTHP+x8Hkk4V4fMW6c6NDmmK0sYwyR7czaKDZ7mlI5eSw/YPq8lIe5g63onXq94pS/U9xwXVxwP8NAecKWRrVEDE+aHgaxBvlCyAS/7jcsWNeq4kXpjlfvrWqNDWm29HK932wFTqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQuwGAkw; arc=none smtp.client-ip=209.85.215.173
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so1879863a12.2
        for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781628257; x=1782233057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t2CCEUKQZKvmLv8dOI8g0/AAZWEkeikspIPGZa/cYB8=;
        b=cQuwGAkweII/lsClKqNu7AVRCAIN0iw89dSlrImVIrEO4eTa31n3BA0yPvRZRHz/rG
         Q6tPkt1wsOUE0rAQbhE1NMZymYJbgb2CuyjGTjS44i0++70k64B2OatUZgRJxMO94hSF
         2mhFuFtDPwNnm5hIWhT8ya7YxoBeLdwpuWlt8lUXt7lTc638oKNdHRiydbNCPriZjmR4
         VuTOrmTBMOwMCbGpsamb/oYxGmxKBI5cON9VDYlgBNnY3gJPNqoqnoI1cR/Yv89DRP66
         9Fvw/wzB06YFWGX4oQE5AFgW9hiaPCTPAxSxxlRxFabN92KCHH9/besz/dukHeJ3Ax6L
         WELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628257; x=1782233057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2CCEUKQZKvmLv8dOI8g0/AAZWEkeikspIPGZa/cYB8=;
        b=IYV/ZrCG3hl9rr/LjWrbLHlYhvEiwnBDkIfOjcs0+Fzf3ypxIA0+DBvE8k+H+JCBVf
         BUhJywbYavGTxZJ+bXBqPq5OajBnOMP4bLmrGWsusKf5ykuvVWq0uPP0V18FSJm9bKco
         YsrToGvUja0VNmBbN+lAEVLqfqI8UbdgOEyKrW4KsENPhyfefebntmlzHETUlsBAOphN
         n2GiT9MJ/n/7Nt8eUuTkVRbBjti+//tbqVs86eG09dztanJ5uNpXp2qbEdJed6NPsplN
         fJ+sN2LsuBamfAmQ87M9qudyDeNUZqm0T7bTKaLhS6SRqGUSDCa0oU+AABsvAy30OFtl
         9f8A==
X-Gm-Message-State: AOJu0YzUe0XSY+sm1Rrx8FGI7Uj2hzIw99KF3MqMtJhe1yHv2w7OzPcu
	1xqrSmKEC3Kd5pex56mhJcJUg1qMLfdXdtGM9FJFIG4rTKarQYHMzUht
X-Gm-Gg: Acq92OHn4KgM+ijGewjncyn0GPKxkxiVBE74m6M6ul5GW01DOioErOGzeKpOI+h4cGr
	CyNdmIHODxlJXxBR4S04bHrOrE3bdK46fTd0ADvVJhvIx89vfw1qpKLxTAMcRDDuPHKMEqaZXdv
	3C9PJbiQatpT7d2x9W4O9I7qil7vWeBLziqK5FSK1JkyXNuBKea6Y1jrbRhOzgU0ByTvEOJiw/X
	Llo3qDeThtjX+Kx+QX3c1Ewu+8xZKnwsA55dGxBkjIoOAsPekFGJxj4QbGG9lHLfbuaOTR1XG1u
	wDmIPRXQm+7SYRI4ZnI4qWYvBFgThqpP/r406Glcx2SPPyLGaraKhM3db+ak2s9F/uGPWbgCXdG
	2U+bmS60OlxYFU4R6NkZ9wfHmmJsdCqmlAABUTP/dDa86at82ungVDYEQG7Rel/uL63bGdGhKlM
	+SNq0+XWMdyIre9VlE0bLwI6dcyBCb1ASQc1C0/OnVOCOEFR7bdlCzo2n2V6nTEqt8n1qsWRZD/
	c0/uND2G8Qw06UMzGTjahOl/g==
X-Received: by 2002:a05:6a21:6d84:b0:3b4:871a:5aaa with SMTP id adf61e73a8af0-3b8b75cbff1mr109629637.26.1781628256881;
        Tue, 16 Jun 2026 09:44:16 -0700 (PDT)
Received: from ?IPV6:2400:79e0:1203:64b0:8460:77be:58ac:5bd9? ([2400:79e0:1203:64b0:8460:77be:58ac:5bd9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9cfebsm12407961b3a.9.2026.06.16.09.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 09:44:16 -0700 (PDT)
Message-ID: <910b0637-0afe-4533-937c-86ec8076376f@gmail.com>
Date: Wed, 17 Jun 2026 00:44:13 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] blk-cgroup: defer blkcg css_put until blkg is unlinked
 from queue
To: Hou Tao <houtao@huaweicloud.com>, yukuai@fygo.io,
 Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, linux-block@vger.kernel.org
Cc: cgroups@vger.kernel.org, yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20260615115556.1225472-1-wozizhi@huaweicloud.com>
 <70642ddf-9ed9-45cb-bf40-891a07247c97@fnnas.com>
 <8bdf88b3-0879-e3ec-a52d-3e7559bfddbb@huaweicloud.com>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <8bdf88b3-0879-e3ec-a52d-3e7559bfddbb@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17004-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:houtao@huaweicloud.com,m:yukuai@fygo.io,m:wozizhi@huaweicloud.com,m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:yangerkun@huawei.com,m:chengzhihao1@huawei.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tangyeechou@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tangyeechou@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,fygo.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4494B6928ED

On 16/6/26 9:23 am, Hou Tao wrote:
> Hi,
> 
> On 6/16/2026 12:16 AM, Yu Kuai wrote:
>> Hi，
>>
>> 在 2026/6/15 19:55, Zizhi Wo 写道:
>>> From: Zizhi Wo <wozizhi@huawei.com>
>>>
>>> [BUG]
>>> Our fuzz testing triggered a blkcg use-after-free issue:
>>>
>>>    BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x75/0xe0
>>>    Call Trace:
>>>    ...
>>>    blkcg_deactivate_policy+0x244/0x4d0
>>>    ioc_rqos_exit+0x44/0xe0
>>>    rq_qos_exit+0xba/0x120
>>>    __del_gendisk+0x50b/0x800
>>>    del_gendisk+0xff/0x190
>>>    ...
>>>
>>> [CAUSE]
>>> process1						process2
>>> cgroup_rmdir
>>> ...
>>>    css_killed_work_fn
>>>      offline_css
>>>      ...
>>>        blkcg_destroy_blkgs
>>>        ...
>>>          __blkg_release
>>> 	  css_put(&blkg->blkcg->css)
>>>            blkg_free
>>> 	    INIT_WORK(xxx, blkg_free_workfn)
>>> 	    schedule_work
>>>      css_put
>>>      ...
>>>        blkcg_css_free
>>>          kfree(blkcg)--------blkcg has been freed!!!
>>> ====================================schedule_work
>>>                blkg_free_workfn
>>> 							__del_gendisk
>>> 							  rq_qos_exit
>>> 							    ioc_rqos_exit
>>> 							      blkcg_deactivate_policy
>>> 							        mutex_lock(&q->blkcg_mutex)
>>> 								spin_lock_irq(&q->queue_lock)
>>> 							        list_for_each_entry(blkg, xxx)
>>> 								  blkcg = blkg->blkcg
>>> 								  spin_lock(&blkcg->lock)-------UAF!!!
>>> 	        mutex_lock(&q->blkcg_mutex)
>>> 	        spin_lock_irq(&q->queue_lock)
>>> 	        /* Only then is the blkg removed from the list */
>>> 	        list_del_init(&blkg->q_node)
>>>
>>> As a result, a blkg can still be reachable through q->blkg_list while
>>> its ->blkcg has already been freed.
>>>
>>> [Fix]
>>> Fix this by deferring the blkcg css_put() until after the blkg has been
>>> unlinked from q->blkg_list in blkg_free_workfn(). This ensures that the
>>> blkcg outlives every blkg still reachable through q->blkg_list, so any
>>> iterator holding q->queue_lock is guaranteed to observe a valid
>>> blkg->blkcg.
>>>
>>> While at it, move css_tryget_online() from blkg_create() into blkg_alloc()
>>> so that the css reference is owned by the alloc/free pair rather than
>>> straddling layers:
>>> blkg_alloc()  <-> blkg_free()
>>> blkg_create() <-> blkg_destroy()
>>>
>>> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
>>> Suggested-by: Hou Tao <houtao1@huawei.com>
>>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>>> ---
>>> v2:
>>>   - Move css_tryget_online() from blkg_create() into blkg_alloc() so the
>>>     css reference follows the blkg's own lifetime, making the put in
>>>     blkg_free_workfn() symmetric with the get in blkg_alloc().
>>>
>>> v1: https://lore.kernel.org/all/20260518010932.633707-1-wozizhi@huaweicloud.com/
>>>
>>>   block/blk-cgroup.c | 24 ++++++++++++------------
>>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>> index bc63bd220865..27414c291e49 100644
>>> --- a/block/blk-cgroup.c
>>> +++ b/block/blk-cgroup.c
>>> @@ -132,10 +132,15 @@ static void blkg_free_workfn(struct work_struct *work)
>>>   	if (blkg->parent)
>>>   		blkg_put(blkg->parent);
>>>   	spin_lock_irq(&q->queue_lock);
>>>   	list_del_init(&blkg->q_node);
>>>   	spin_unlock_irq(&q->queue_lock);
>>> +	/*
>>> +	 * Release blkcg css ref only after blkg is removed from q->blkg_list,
>>> +	 * so concurrent iterators won't see a blkg with a freed blkcg.
>>> +	 */
>>> +	css_put(&blkg->blkcg->css);
>>>   	mutex_unlock(&q->blkcg_mutex);
>> Please move css_put after mutex_unlock, unless there is a strong reason.
> 
> I think blkcg_mutex is used here to serialize the access of blkg->q_node
> and blkg->blkcg. We could move the css_put after the mutex_unlock(),
> however it stills depends on the mutex_lock and mutex_unlock pair on
> blkcg_mutex implicitly. Instead of such implicit dependency, we move the
> css_put inside the lock to make it be explicit.

Hi, I think I understand your point. Keeping css_put() inside blkcg_mutex makes the dependency explicit, since the same mutex serializes both the removal of blkg->q_node and the access to blkg->blkcg.

Placing css_put() after mutex_unlock(&q->blkcg_mutex) is still functionally correct. The blkg has already been removed from q->blkg_list under the mutex, so once we drop the mutex no iterator can reach this blkg anymore.

The benefit of moving it out is a smaller critical section.

-- 
Best Regards,
Yi

>>
>> With above change, feel free to add:
>>
>> Reviewed-by: Yu Kuai <yukuai@fygo.io>
>>
>>>   
>>>   	blk_put_queue(q);
>>>   	free_percpu(blkg->iostat_cpu);
>>>   	percpu_ref_exit(&blkg->refcnt);
>>> @@ -177,12 +182,10 @@ static void __blkg_release(struct rcu_head *rcu)
>>>   	 * blkg_stat_lock is for serializing blkg stat update
>>>   	 */
>>>   	for_each_possible_cpu(cpu)
>>>   		__blkcg_rstat_flush(blkcg, cpu);
>>>   
>>> -	/* release the blkcg and parent blkg refs this blkg has been holding */
>>> -	css_put(&blkg->blkcg->css);
>>>   	blkg_free(blkg);
>>>   }
>>>   
>>>   /*
>>>    * A group is RCU protected, but having an rcu lock does not mean that one
>>> @@ -311,10 +314,13 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>>>   	blkg->iostat_cpu = alloc_percpu_gfp(struct blkg_iostat_set, gfp_mask);
>>>   	if (!blkg->iostat_cpu)
>>>   		goto out_exit_refcnt;
>>>   	if (!blk_get_queue(disk->queue))
>>>   		goto out_free_iostat;
>>> +	/* blkg holds a reference to blkcg */
>>> +	if (!css_tryget_online(&blkcg->css))
>>> +		goto out_put_queue;
>>>   
>>>   	blkg->q = disk->queue;
>>>   	INIT_LIST_HEAD(&blkg->q_node);
>>>   	blkg->blkcg = blkcg;
>>>   	blkg->iostat.blkg = blkg;
>>> @@ -351,10 +357,12 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>>>   
>>>   out_free_pds:
>>>   	while (--i >= 0)
>>>   		if (blkg->pd[i])
>>>   			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
>>> +	css_put(&blkcg->css);
>>> +out_put_queue:
>>>   	blk_put_queue(disk->queue);
>>>   out_free_iostat:
>>>   	free_percpu(blkg->iostat_cpu);
>>>   out_exit_refcnt:
>>>   	percpu_ref_exit(&blkg->refcnt);
>>> @@ -379,32 +387,26 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>>>   	if (blk_queue_dying(disk->queue)) {
>>>   		ret = -ENODEV;
>>>   		goto err_free_blkg;
>>>   	}
>>>   
>>> -	/* blkg holds a reference to blkcg */
>>> -	if (!css_tryget_online(&blkcg->css)) {
>>> -		ret = -ENODEV;
>>> -		goto err_free_blkg;
>>> -	}
>>> -
>>>   	/* allocate */
>>>   	if (!new_blkg) {
>>>   		new_blkg = blkg_alloc(blkcg, disk, GFP_NOWAIT);
>>>   		if (unlikely(!new_blkg)) {
>>>   			ret = -ENOMEM;
>>> -			goto err_put_css;
>>> +			goto err_free_blkg;
>>>   		}
>>>   	}
>>>   	blkg = new_blkg;
>>>   
>>>   	/* link parent */
>>>   	if (blkcg_parent(blkcg)) {
>>>   		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk->queue);
>>>   		if (WARN_ON_ONCE(!blkg->parent)) {
>>>   			ret = -ENODEV;
>>> -			goto err_put_css;
>>> +			goto err_free_blkg;
>>>   		}
>>>   		blkg_get(blkg->parent);
>>>   	}
>>>   
>>>   	/* invoke per-policy init */
>>> @@ -440,12 +442,10 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>>>   
>>>   	/* @blkg failed fully initialized, use the usual release path */
>>>   	blkg_put(blkg);
>>>   	return ERR_PTR(ret);
>>>   
>>> -err_put_css:
>>> -	css_put(&blkcg->css);
>>>   err_free_blkg:
>>>   	if (new_blkg)
>>>   		blkg_free(new_blkg);
>>>   	return ERR_PTR(ret);
>>>   }
> 
> 



