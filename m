Return-Path: <cgroups+bounces-16985-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eDSlLxmmMGqYVwUAu9opvQ
	(envelope-from <cgroups+bounces-16985-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 03:25:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F768B3DA
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 03:25:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16985-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16985-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D6E0309286E
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 01:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D134D377EAF;
	Tue, 16 Jun 2026 01:23:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0965264614;
	Tue, 16 Jun 2026 01:23:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573026; cv=none; b=rTqyJaURRE3Mea819IFGZUX119LzcPl8yEwZp/k59L7clpSd1tsu6jQc7Yt7hAlEiXJsR3eQUy+Sy3JB2Hzr9RvVn3tL+frb7EdohBhf9ewof5WsCcH5mYtXTfE2PIKeFMEcuRMNLQqhEEXm/CTi4h6Ao2vMmIo8Ezj6N8Atp14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573026; c=relaxed/simple;
	bh=bBNuEJHmDJG2LM/oCOFLavh5FTjUAjTqfBcMMDIVhqM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GOFsXzMcgAwM0Av+/7VbnxNjn4LFIP0GVSzPIK/9Wg8KwPdXZZwiB/PZn49YE84wnxWZ+5YNwT/yj0hB1ciJKJvPeyRttQ33Auvn7csJXyT8nBWTxCTxWTPKg53hDWbl4mZAzd30zYCx1ZnkpGkwMSZPmkkNnmPAZcLeYqjOiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gfTkc3YYwzKHMQH;
	Tue, 16 Jun 2026 09:22:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 802FA4058D;
	Tue, 16 Jun 2026 09:23:34 +0800 (CST)
Received: from [10.174.176.103] (unknown [10.174.176.103])
	by APP1 (Coremail) with SMTP id cCh0CgCHiT6QpTBqKGzMBw--.34947S2;
	Tue, 16 Jun 2026 09:23:32 +0800 (CST)
Subject: Re: [PATCH V2] blk-cgroup: defer blkcg css_put until blkg is unlinked
 from queue
To: yukuai@fygo.io, Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, linux-block@vger.kernel.org
Cc: cgroups@vger.kernel.org, yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20260615115556.1225472-1-wozizhi@huaweicloud.com>
 <70642ddf-9ed9-45cb-bf40-891a07247c97@fnnas.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <8bdf88b3-0879-e3ec-a52d-3e7559bfddbb@huaweicloud.com>
Date: Tue, 16 Jun 2026 09:23:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <70642ddf-9ed9-45cb-bf40-891a07247c97@fnnas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCHiT6QpTBqKGzMBw--.34947S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyxJrWrWry7Zr43Xw18Zrb_yoWxAryUpr
	ZxGFWSy3yxKr9rJw4Yqr17X34Fvw40qr1rGrWxG3WfCr4ayr9aqF17CFWkuFW8AFZ7Ar1f
	Ar4vqF9FkF40kw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:mid,huaweicloud.com:from_mime];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16985-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS(0.00)[m:yukuai@fygo.io,m:wozizhi@huaweicloud.com,m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:yangerkun@huawei.com,m:chengzhihao1@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[houtao@huaweicloud.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houtao@huaweicloud.com,cgroups@vger.kernel.org];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,huaweicloud.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,fygo.io:email,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 284F768B3DA

Hi,

On 6/16/2026 12:16 AM, Yu Kuai wrote:
> Hi，
>
> 在 2026/6/15 19:55, Zizhi Wo 写道:
>> From: Zizhi Wo <wozizhi@huawei.com>
>>
>> [BUG]
>> Our fuzz testing triggered a blkcg use-after-free issue:
>>
>>    BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x75/0xe0
>>    Call Trace:
>>    ...
>>    blkcg_deactivate_policy+0x244/0x4d0
>>    ioc_rqos_exit+0x44/0xe0
>>    rq_qos_exit+0xba/0x120
>>    __del_gendisk+0x50b/0x800
>>    del_gendisk+0xff/0x190
>>    ...
>>
>> [CAUSE]
>> process1						process2
>> cgroup_rmdir
>> ...
>>    css_killed_work_fn
>>      offline_css
>>      ...
>>        blkcg_destroy_blkgs
>>        ...
>>          __blkg_release
>> 	  css_put(&blkg->blkcg->css)
>>            blkg_free
>> 	    INIT_WORK(xxx, blkg_free_workfn)
>> 	    schedule_work
>>      css_put
>>      ...
>>        blkcg_css_free
>>          kfree(blkcg)--------blkcg has been freed!!!
>> ====================================schedule_work
>>                blkg_free_workfn
>> 							__del_gendisk
>> 							  rq_qos_exit
>> 							    ioc_rqos_exit
>> 							      blkcg_deactivate_policy
>> 							        mutex_lock(&q->blkcg_mutex)
>> 								spin_lock_irq(&q->queue_lock)
>> 							        list_for_each_entry(blkg, xxx)
>> 								  blkcg = blkg->blkcg
>> 								  spin_lock(&blkcg->lock)-------UAF!!!
>> 	        mutex_lock(&q->blkcg_mutex)
>> 	        spin_lock_irq(&q->queue_lock)
>> 	        /* Only then is the blkg removed from the list */
>> 	        list_del_init(&blkg->q_node)
>>
>> As a result, a blkg can still be reachable through q->blkg_list while
>> its ->blkcg has already been freed.
>>
>> [Fix]
>> Fix this by deferring the blkcg css_put() until after the blkg has been
>> unlinked from q->blkg_list in blkg_free_workfn(). This ensures that the
>> blkcg outlives every blkg still reachable through q->blkg_list, so any
>> iterator holding q->queue_lock is guaranteed to observe a valid
>> blkg->blkcg.
>>
>> While at it, move css_tryget_online() from blkg_create() into blkg_alloc()
>> so that the css reference is owned by the alloc/free pair rather than
>> straddling layers:
>> blkg_alloc()  <-> blkg_free()
>> blkg_create() <-> blkg_destroy()
>>
>> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
>> Suggested-by: Hou Tao <houtao1@huawei.com>
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> ---
>> v2:
>>   - Move css_tryget_online() from blkg_create() into blkg_alloc() so the
>>     css reference follows the blkg's own lifetime, making the put in
>>     blkg_free_workfn() symmetric with the get in blkg_alloc().
>>
>> v1: https://lore.kernel.org/all/20260518010932.633707-1-wozizhi@huaweicloud.com/
>>
>>   block/blk-cgroup.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index bc63bd220865..27414c291e49 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -132,10 +132,15 @@ static void blkg_free_workfn(struct work_struct *work)
>>   	if (blkg->parent)
>>   		blkg_put(blkg->parent);
>>   	spin_lock_irq(&q->queue_lock);
>>   	list_del_init(&blkg->q_node);
>>   	spin_unlock_irq(&q->queue_lock);
>> +	/*
>> +	 * Release blkcg css ref only after blkg is removed from q->blkg_list,
>> +	 * so concurrent iterators won't see a blkg with a freed blkcg.
>> +	 */
>> +	css_put(&blkg->blkcg->css);
>>   	mutex_unlock(&q->blkcg_mutex);
> Please move css_put after mutex_unlock, unless there is a strong reason.

I think blkcg_mutex is used here to serialize the access of blkg->q_node
and blkg->blkcg. We could move the css_put after the mutex_unlock(),
however it stills depends on the mutex_lock and mutex_unlock pair on
blkcg_mutex implicitly. Instead of such implicit dependency, we move the
css_put inside the lock to make it be explicit.
>
> With above change, feel free to add:
>
> Reviewed-by: Yu Kuai <yukuai@fygo.io>
>
>>   
>>   	blk_put_queue(q);
>>   	free_percpu(blkg->iostat_cpu);
>>   	percpu_ref_exit(&blkg->refcnt);
>> @@ -177,12 +182,10 @@ static void __blkg_release(struct rcu_head *rcu)
>>   	 * blkg_stat_lock is for serializing blkg stat update
>>   	 */
>>   	for_each_possible_cpu(cpu)
>>   		__blkcg_rstat_flush(blkcg, cpu);
>>   
>> -	/* release the blkcg and parent blkg refs this blkg has been holding */
>> -	css_put(&blkg->blkcg->css);
>>   	blkg_free(blkg);
>>   }
>>   
>>   /*
>>    * A group is RCU protected, but having an rcu lock does not mean that one
>> @@ -311,10 +314,13 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>>   	blkg->iostat_cpu = alloc_percpu_gfp(struct blkg_iostat_set, gfp_mask);
>>   	if (!blkg->iostat_cpu)
>>   		goto out_exit_refcnt;
>>   	if (!blk_get_queue(disk->queue))
>>   		goto out_free_iostat;
>> +	/* blkg holds a reference to blkcg */
>> +	if (!css_tryget_online(&blkcg->css))
>> +		goto out_put_queue;
>>   
>>   	blkg->q = disk->queue;
>>   	INIT_LIST_HEAD(&blkg->q_node);
>>   	blkg->blkcg = blkcg;
>>   	blkg->iostat.blkg = blkg;
>> @@ -351,10 +357,12 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>>   
>>   out_free_pds:
>>   	while (--i >= 0)
>>   		if (blkg->pd[i])
>>   			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
>> +	css_put(&blkcg->css);
>> +out_put_queue:
>>   	blk_put_queue(disk->queue);
>>   out_free_iostat:
>>   	free_percpu(blkg->iostat_cpu);
>>   out_exit_refcnt:
>>   	percpu_ref_exit(&blkg->refcnt);
>> @@ -379,32 +387,26 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>>   	if (blk_queue_dying(disk->queue)) {
>>   		ret = -ENODEV;
>>   		goto err_free_blkg;
>>   	}
>>   
>> -	/* blkg holds a reference to blkcg */
>> -	if (!css_tryget_online(&blkcg->css)) {
>> -		ret = -ENODEV;
>> -		goto err_free_blkg;
>> -	}
>> -
>>   	/* allocate */
>>   	if (!new_blkg) {
>>   		new_blkg = blkg_alloc(blkcg, disk, GFP_NOWAIT);
>>   		if (unlikely(!new_blkg)) {
>>   			ret = -ENOMEM;
>> -			goto err_put_css;
>> +			goto err_free_blkg;
>>   		}
>>   	}
>>   	blkg = new_blkg;
>>   
>>   	/* link parent */
>>   	if (blkcg_parent(blkcg)) {
>>   		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk->queue);
>>   		if (WARN_ON_ONCE(!blkg->parent)) {
>>   			ret = -ENODEV;
>> -			goto err_put_css;
>> +			goto err_free_blkg;
>>   		}
>>   		blkg_get(blkg->parent);
>>   	}
>>   
>>   	/* invoke per-policy init */
>> @@ -440,12 +442,10 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>>   
>>   	/* @blkg failed fully initialized, use the usual release path */
>>   	blkg_put(blkg);
>>   	return ERR_PTR(ret);
>>   
>> -err_put_css:
>> -	css_put(&blkcg->css);
>>   err_free_blkg:
>>   	if (new_blkg)
>>   		blkg_free(new_blkg);
>>   	return ERR_PTR(ret);
>>   }


