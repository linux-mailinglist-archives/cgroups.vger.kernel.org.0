Return-Path: <cgroups+bounces-2916-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2B58C68DF
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC0E1C219D6
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A81A155756;
	Wed, 15 May 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQxbYQtG"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEEB155727
	for <cgroups@vger.kernel.org>; Wed, 15 May 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783739; cv=none; b=Sw7pqkONaKLD2x1ANm6A1yoru3pjcrFWv+qI1UTowvkzf0JDTrSZt7anYtH2mhUvoIoaKunrZLiyV66h+PiKUgkyvovpI56Z9i4L+/xKU72jtF99SomK6dg81aBFlm76enF7eTwMDf/zBQNDfJ4Vnw4ZYGA8sAXpfjHD+HidIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783739; c=relaxed/simple;
	bh=XrEHWXzHYH414DvlVESjOtx15TYA6noXORpfTNUMgRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/b6r3mRNnYy+S1ddbS+d3Qjetv3OUEB0TnV78Hu+czMezteTlkwqFTR7oWK4fHohw+OsMHbMOenYVDxNF+YcROQa7c2A6az0tGVRLZLw4R6S3njIN21Ls6w64DkNmJCcvswtFqu+chf677hGtdw9Fv9xPswBbKl/L+nHtq7XVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQxbYQtG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715783736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sc9fEb2mK7PfNta2o/2kA9lq5+CKKqFEWMN/clrZxT8=;
	b=AQxbYQtGsY0luZpzEKZJbDwBT9i9HsNmAUAjkZdX+aRtcFJwZyde/tJcLKdJYMtuq4daUS
	VS7vZ9ZiSOgmpXPd28cmOVgiuMOdVKWnaJuuAmx2MBr6SVzoOwASM0KgNVOCjfAfEHISi8
	9aZOVdYkjxtW50dpvVdFhjCD6LN/ops=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-OvT26MQQMRis29XSB5ZWXA-1; Wed,
 15 May 2024 10:35:21 -0400
X-MC-Unique: OvT26MQQMRis29XSB5ZWXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77A5D1C3F0EE;
	Wed, 15 May 2024 14:35:20 +0000 (UTC)
Received: from [10.22.33.50] (unknown [10.22.33.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD231200A08E;
	Wed, 15 May 2024 14:35:19 +0000 (UTC)
Message-ID: <7ab67d43-84af-4328-8aca-9383afa2d6df@redhat.com>
Date: Wed, 15 May 2024 10:35:19 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-cgroup: Properly propagate the iostat update up the
 hierarchy
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Schatzberg <schatzberg.dan@gmail.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20240515143059.276677-1-longman@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240515143059.276677-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 5/15/24 10:30, Waiman Long wrote:
> During a cgroup_rstat_flush() call, the lowest level of nodes are flushed
> first before their parents. Since commit 3b8cc6298724 ("blk-cgroup:
> Optimize blkcg_rstat_flush()"), iostat propagation was still done to
> the parent. Grandparent, however, may not get the iostat update if the
> parent has no blkg_iostat_set queued in its lhead lockless list.
>
> Fix this iostat propagation problem by queuing the parent's global
> blkg->iostat into one of its percpu lockless lists to make sure that
> the delta will always be propagated up to the grandparent and so on
> toward the root blkcg.
>
> Note that successive calls to __blkcg_rstat_flush() are serialized by
> the cgroup_rstat_lock. So no special barrier is used in the reading
> and writing of blkg->iostat.lqueued.
>
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Closes: https://lore.kernel.org/lkml/ZkO6l%2FODzadSgdhC@dschatzberg-fedora-PF3DHTBV/
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   block/blk-cgroup.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 059467086b13..2a7624c32a1a 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -323,6 +323,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>   	blkg->q = disk->queue;
>   	INIT_LIST_HEAD(&blkg->q_node);
>   	blkg->blkcg = blkcg;
> +	blkg->iostat.blkg = blkg;
>   #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
>   	spin_lock_init(&blkg->async_bio_lock);
>   	bio_list_init(&blkg->async_bios);
> @@ -1025,6 +1026,8 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>   		unsigned int seq;
>   
>   		WRITE_ONCE(bisc->lqueued, false);
> +		if (bisc == &blkg->iostat)
> +			goto propagate_up; /* propagate up to parent only */
>   
>   		/* fetch the current per-cpu values */
>   		do {
> @@ -1034,10 +1037,24 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>   
>   		blkcg_iostat_update(blkg, &cur, &bisc->last);
>   
> +propagate_up:
>   		/* propagate global delta to parent (unless that's root) */
> -		if (parent && parent->parent)
> +		if (parent && parent->parent) {
>   			blkcg_iostat_update(parent, &blkg->iostat.cur,
>   					    &blkg->iostat.last);
> +			/*
> +			 * Queue parent->iostat to its blkcg's lockless
> +			 * list to propagate up to the grandparent if the
> +			 * iostat hasn't been queued yet.
> +			 */
> +			if (!parent->iostat.lqueued) {
> +				struct llist_head *plhead;
> +
> +				plhead = per_cpu_ptr(parent->blkcg->lhead, cpu);
> +				llist_add(&parent->iostat.lnode, plhead);
> +				parent->iostat.lqueued = true;
> +			}
> +		}
>   	}
>   	raw_spin_unlock_irqrestore(&blkg_stat_lock, flags);
>   out:

Note that this patch will conflict with Ming's patch 
(https://lore.kernel.org/linux-block/20240515013157.443672-3-ming.lei@redhat.com/). 
Will send out an updated version later on to synchronize with his patch.

Cheers,
Longman


