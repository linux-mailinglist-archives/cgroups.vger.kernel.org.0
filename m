Return-Path: <cgroups+bounces-17005-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mo8rOzl/MWqBkwUAu9opvQ
	(envelope-from <cgroups+bounces-17005-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 18:52:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A7227692879
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 18:52:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oFJaoSdc;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17005-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17005-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18B60304EC14
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 16:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247F547AF56;
	Tue, 16 Jun 2026 16:50:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768347279B
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 16:50:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628606; cv=none; b=DM1GbSKzFbBPmG2/2D5JGIQ9rf5th+Lta2HMrS0SG5DYXkr21kkVfwmCSL9U04ZDckm71X8sSfKw3FecOK0lp1xqxdt5q3XZf+qu8lNg3/J/aifeGCbdPPL1OIAXb/apSJ4aFyXASr2qaoSwj/+i85uWMhP8tSyANTvXneebhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628606; c=relaxed/simple;
	bh=qH1REposY/vkap/PpdBJI139eXdCCEzXcTca8g46ZJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ppo2kKoOwD+tPaA8i+vvQwRHizSczRD04ZpVsFDyJN3eRTenwVN4BUSPH5Yc7F7nHzRihj/EacaxFk/fstGcZBE9kxpQZ+bSzE+FKLKu1Bt6nwFItIuyCoTUpIMrbrqstn018L1CRB/c/3wPZupn9vyouGsye29ZoGTcDMJIbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFJaoSdc; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8424b6792efso2064325b3a.3
        for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781628605; x=1782233405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnLBkKiTFM9IdGpuO3vRcsVvlePjixksYNezzzUDvlo=;
        b=oFJaoSdcxXbftAoQaiV2ONa+ezgh4uMN+soqn0Knl9dsn3K7CxscyI2YTcARPYvjBC
         iAoc4jE32Dzd6yP90m85uVOttLl1koauMnWgKXwrckS+BPSb4fE2TUE0lcpgchQj99wB
         TVD6/OOOvnDtTf0wYdxKzA2TBr0zaxzEgKDFNqjKL53AX8cpS4V4oqgN5iVzdsIp76CY
         7fMSLFn5LquGLMrt29xqmO1uC3fbmRzdp05W2z1a8BdNzejqT6GPYE+tV+bcqEUL0WP9
         xWfvIKVy2fnm+788PtTRDTyd9T5qCCFYIH6lWSW694w8yVDCdKp/ts29C6pU27Za/cv4
         mw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628605; x=1782233405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnLBkKiTFM9IdGpuO3vRcsVvlePjixksYNezzzUDvlo=;
        b=pyhX5vi/5TwtiPmMazIqt1sL1CB59In30oeG4uQ2DWzt+0UrFM7Xg/5p3k/sHXlYAl
         eXopkV7jcbzxfYisyXMjtFmnwUQCsDhgPI9B4Nis8EJzpOxoo6rtCsEjtR3XZHari3UX
         4Q6tG9CmFlBoaMG+rVkEmtnYSX6SbExREM4qsVi0sv+4v/UUETqxx9y6AB0Mwz8vrxtR
         vi5gS2cydv/6yW6XPjdxp9DDKOtM3F8Xbm/EMu3coVwDFc3o/1YN6bPnA1CAv8N6aJS9
         2xTPYhne9MbwMaXpKVNee+PD1OvwrH5hZBkvqJ9YWSgfLxupkWDumsQ7KsO1quri9d7g
         kIdw==
X-Gm-Message-State: AOJu0Yx7hTHVt6xZRKKf1WJ01G0lAn3qo6Lnm7AntOXM9LCkl1yh/Nl1
	35kdeLWtdfwZ0ZFOz6AX1mt1b74Q9h4OJvT1s5xjSsxYJ7azUtptqhKr
X-Gm-Gg: Acq92OF1gqSE+V3zLYUh+48AYZMEF95ixv3I5XPH5LYkkhJrZqFLpo0uMBobbpFDwVI
	dVGCrHw/rnniYRsSwiQcS8Gq9xpyt31SO51bG21c8IEnyaam7bmcXD9DLe5/gfbb+BPy5tope8V
	jF/TvmlRRm25McAaw6dC1EitVQ7bWFfk1/VgHobyGDjk6OL4ajWISvNRJWi1kAQTXfcPryY8W0Z
	dCinUMup0ZLvD3TqPjoP6FZ5s+mJhBkV7CcTfE/zRpjbS1sNUC67Pucsxi+z2h6rP2FJQ+9GpfK
	PPblmL9gbO1mtcmEkhugdjF62VQfevAgck1RFfDqhraoOc7HwUXQ7+cn9ZfIp+Y7Xc0IJvBcIP4
	oBbmU67XZVhMCZSerFUVOmbHEJtBTT9kKxV+YMzSd6Uyr0mPi0wWWSjjiJXZeGGeZ3RKGrBoP7F
	Ay4xQ/8O4dZy9CP69C+OjcltWoEBFoeBfFAmya+ABIT0mmsyohE5KpbSVNqR2nF1bK+rE/c6sF+
	qWoent5/oTm9IykSYW0k5CjiA==
X-Received: by 2002:a05:6a00:1146:b0:831:7f71:c810 with SMTP id d2e1a72fcca58-844e1a75b45mr16326686b3a.35.1781628604768;
        Tue, 16 Jun 2026 09:50:04 -0700 (PDT)
Received: from ?IPV6:2400:79e0:1203:64b0:8460:77be:58ac:5bd9? ([2400:79e0:1203:64b0:8460:77be:58ac:5bd9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c4c0sm12310480b3a.3.2026.06.16.09.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 09:50:04 -0700 (PDT)
Message-ID: <774f145f-cec0-4408-9557-5db196302ebd@gmail.com>
Date: Wed, 17 Jun 2026 00:50:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] blk-cgroup: defer blkcg css_put until blkg is unlinked
 from queue
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, linux-block@vger.kernel.org
Cc: cgroups@vger.kernel.org, yangerkun@huawei.com, chengzhihao1@huawei.com,
 houtao1@huawei.com, yukuai@fygo.io
References: <20260616011746.2451461-1-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260616011746.2451461-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17005-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wozizhi@huaweicloud.com,m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:yangerkun@huawei.com,m:chengzhihao1@huawei.com,m:houtao1@huawei.com,m:yukuai@fygo.io,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tangyeechou@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fygo.io:email,vger.kernel.org:from_smtp,huawei.com:email,shopee.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7227692879

On 16/6/26 9:17 am, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> [BUG]
> Our fuzz testing triggered a blkcg use-after-free issue:
> 
>   BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x75/0xe0
>   Call Trace:
>   ...
>   blkcg_deactivate_policy+0x244/0x4d0
>   ioc_rqos_exit+0x44/0xe0
>   rq_qos_exit+0xba/0x120
>   __del_gendisk+0x50b/0x800
>   del_gendisk+0xff/0x190
>   ...
> 
> [CAUSE]
> process1						process2
> cgroup_rmdir
> ...
>   css_killed_work_fn
>     offline_css
>     ...
>       blkcg_destroy_blkgs
>       ...
>         __blkg_release
> 	  css_put(&blkg->blkcg->css)
>           blkg_free
> 	    INIT_WORK(xxx, blkg_free_workfn)
> 	    schedule_work
>     css_put
>     ...
>       blkcg_css_free
>         kfree(blkcg)--------blkcg has been freed!!!
> ====================================schedule_work
>               blkg_free_workfn
> 							__del_gendisk
> 							  rq_qos_exit
> 							    ioc_rqos_exit
> 							      blkcg_deactivate_policy
> 							        mutex_lock(&q->blkcg_mutex)
> 								spin_lock_irq(&q->queue_lock)
> 							        list_for_each_entry(blkg, xxx)
> 								  blkcg = blkg->blkcg
> 								  spin_lock(&blkcg->lock)-------UAF!!!
> 	        mutex_lock(&q->blkcg_mutex)
> 	        spin_lock_irq(&q->queue_lock)
> 	        /* Only then is the blkg removed from the list */
> 	        list_del_init(&blkg->q_node)
> 
> As a result, a blkg can still be reachable through q->blkg_list while
> its ->blkcg has already been freed.
> 
> [Fix]
> Fix this by deferring the blkcg css_put() until after the blkg has been
> unlinked from q->blkg_list in blkg_free_workfn(). This ensures that the
> blkcg outlives every blkg still reachable through q->blkg_list, so any
> iterator holding q->queue_lock is guaranteed to observe a valid
> blkg->blkcg.
> 
> While at it, move css_tryget_online() from blkg_create() into blkg_alloc()
> so that the css reference is owned by the alloc/free pair rather than
> straddling layers:
> blkg_alloc()  <-> blkg_free()
> blkg_create() <-> blkg_destroy()
> 
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> Reviewed-by: Yu Kuai <yukuai@fygo.io>
> ---
> v3:
>  - move css_put() after mutex_unlock() in blkg_free_workfn().
> 
> v2:
>  - Move css_tryget_online() from blkg_create() into blkg_alloc() so the
>    css reference follows the blkg's own lifetime, making the put in
>    blkg_free_workfn() symmetric with the get in blkg_alloc().
> 
> v1: https://lore.kernel.org/all/20260518010932.633707-1-wozizhi@huaweicloud.com/
>  block/blk-cgroup.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bc63bd220865..3ac41f766caf 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -136,6 +136,11 @@ static void blkg_free_workfn(struct work_struct *work)
>  	spin_unlock_irq(&q->queue_lock);
>  	mutex_unlock(&q->blkcg_mutex);
>  
> +	/*
> +	 * Release blkcg css ref only after blkg is removed from q->blkg_list,
> +	 * so concurrent iterators won't see a blkg with a freed blkcg.
> +	 */
> +	css_put(&blkg->blkcg->css);
>  	blk_put_queue(q);
>  	free_percpu(blkg->iostat_cpu);
>  	percpu_ref_exit(&blkg->refcnt);
> @@ -179,8 +184,6 @@ static void __blkg_release(struct rcu_head *rcu)
>  	for_each_possible_cpu(cpu)
>  		__blkcg_rstat_flush(blkcg, cpu);
>  
> -	/* release the blkcg and parent blkg refs this blkg has been holding */
> -	css_put(&blkg->blkcg->css);
>  	blkg_free(blkg);
>  }
>  
> @@ -313,6 +316,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>  		goto out_exit_refcnt;
>  	if (!blk_get_queue(disk->queue))
>  		goto out_free_iostat;
> +	/* blkg holds a reference to blkcg */
> +	if (!css_tryget_online(&blkcg->css))
> +		goto out_put_queue;
>  
>  	blkg->q = disk->queue;
>  	INIT_LIST_HEAD(&blkg->q_node);
> @@ -353,6 +359,8 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>  	while (--i >= 0)
>  		if (blkg->pd[i])
>  			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
> +	css_put(&blkcg->css);
> +out_put_queue:
>  	blk_put_queue(disk->queue);
>  out_free_iostat:
>  	free_percpu(blkg->iostat_cpu);
> @@ -381,18 +389,12 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>  		goto err_free_blkg;
>  	}
>  
> -	/* blkg holds a reference to blkcg */
> -	if (!css_tryget_online(&blkcg->css)) {
> -		ret = -ENODEV;
> -		goto err_free_blkg;
> -	}
> -
>  	/* allocate */
>  	if (!new_blkg) {
>  		new_blkg = blkg_alloc(blkcg, disk, GFP_NOWAIT);
>  		if (unlikely(!new_blkg)) {
>  			ret = -ENOMEM;
> -			goto err_put_css;
> +			goto err_free_blkg;
>  		}
>  	}
>  	blkg = new_blkg;
> @@ -402,7 +404,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>  		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk->queue);
>  		if (WARN_ON_ONCE(!blkg->parent)) {
>  			ret = -ENODEV;
> -			goto err_put_css;
> +			goto err_free_blkg;
>  		}
>  		blkg_get(blkg->parent);
>  	}
> @@ -442,8 +444,6 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>  	blkg_put(blkg);
>  	return ERR_PTR(ret);
>  
> -err_put_css:
> -	css_put(&blkcg->css);
>  err_free_blkg:
>  	if (new_blkg)
>  		blkg_free(new_blkg);

LGTM.

Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>

-- 
Best Regards,
Yi


