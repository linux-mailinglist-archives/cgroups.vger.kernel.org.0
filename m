Return-Path: <cgroups+bounces-2918-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AE98C6B15
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 18:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035111C217C6
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7297736AF2;
	Wed, 15 May 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV8k6vLr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083512B6C;
	Wed, 15 May 2024 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792285; cv=none; b=uZW2CWGBMQTQDh97qL1zM83P2Y0yb1i4I8l1I27DH14lvADcpyXfFRmBiZnTUZqmrFej2Eg7cDrmE9UBN+0RrZ0U2vySeob5R8HQQyMG3AmQkV84oHt1Gkwx7TUwCbD1x6WEq+dBa+4eDG0yhVT3Af1PKGj7BLiLaSTouyJIYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792285; c=relaxed/simple;
	bh=QDqaJwtTVl0GHXKlC/HrjCtU144s0RKtNX4orwnBVUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOVilSqiQ+wCL/7SzCkG2WxFKwyyBuV3EVnsRagL3c2hqVD20j6Y5ufwxQ87fxo61fE6c5Dk1XWofLGD5NCRPuqvGdG/qMrD2Ic/qDqS2+PoCK8X6eACe36q9DW/K57fCkJj7nXFVxM/+10COKEOhQHejMfoQjy8yz9BF2l4KmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZV8k6vLr; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-792b8cd0825so640073785a.0;
        Wed, 15 May 2024 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715792283; x=1716397083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pQDotCdPdPCkgm8cle2fS9xDk5zHSYJRqw3XQSQ/9U=;
        b=ZV8k6vLrrQzjNv9CuBaDcsqelNCO7yoUDxLZ6mZXWYVGEhGfomXfbDw3EAA3bcHgJ3
         WzArj421VId0LocU3RXp9S3N2keLiJjuX6eVzl6ZFg62It66yb+9s+AVBmNldHStd6H7
         IHK6wE5/r+PnSSDiYjc5o4UXa4v52X9Jw7xtHp/uZ7RLXcInz/Bbu1XpJLDbfNQdyfZq
         Ap9J+88/pvSfYH3f+6d6FdSAyjww2WQeGlAYGCD8iDtzVik4d1gjPzoYC5/wUbodozCw
         rsnuZS0OZIWUeyjre/RHWjuk+goIIb0Lc1wDSQ4XVuRs4p1c2sxTovX3ToY1xD9b3Pj/
         VAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715792283; x=1716397083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pQDotCdPdPCkgm8cle2fS9xDk5zHSYJRqw3XQSQ/9U=;
        b=BRHhtaD7ju7rgWZ8cQGlcv9mSU1thZEXIDQl5tVeC3OlLHGPvXejjp2Uh9pRk2zBQm
         eJZikGmn+qLOX3930MSgZWEQVbgiJdqZXcd32dErt8TMhv6fmXuwnfwvGYIE/iVim5g6
         3OptzLQo57xmTSmXUjJXX+M6u0YlpdzODIDcJEbvk4tAvfVUZM6sVMTtnTKo5Wwc4Sc3
         OpveemxJWs1tcPPMImVNAN5DA0sfHD/Kwv1iu2HI9hK+/IDoe1U9PoY1Q8F2BUjeumK1
         7qMHPZ+W7ekFpsOIHUPQjj4mL4q6YPFw8kE05/GM/5V7oLNmjsrUQhrj6tY6ftlBflgP
         rUmA==
X-Forwarded-Encrypted: i=1; AJvYcCUPk9r9PHiEAmxpByb/+tizCBVUQluQ8Fwn2DU6RkKe0wHcjP23d8aVHrJo7HOayolBx/Q71PHRYZImU98Bj4XRdpMj4xjyheDrBlJIREcJ9bHlcoop7ZMK5G7ig4AWkb2Ric4e+5Jndh4YmA3A7WZpawHukUyv01pCAaWfQPj516cZ
X-Gm-Message-State: AOJu0YxpaYyxaMZf86nlnIjDSdJ4KAby5S1vF3BVt2xAFb2CKOBDab37
	eikMFprAtwz8/3GCoXmeVIXP0M6p+RaE2keKj1+tKR4LNrbnLnGF
X-Google-Smtp-Source: AGHT+IFJtlglhIwapcrP+uS3RQY3OU31faztIYfG9NFCUSU+i5SwQNUTdQE5Z/5ASxfwuyECQZGRCQ==
X-Received: by 2002:a05:620a:5232:b0:792:ff4f:43b5 with SMTP id af79cd13be357-792ff4f459fmr125434785a.24.1715792282528;
        Wed, 15 May 2024 09:58:02 -0700 (PDT)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::4:d26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792ee702076sm185805985a.60.2024.05.15.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 09:58:02 -0700 (PDT)
Date: Wed, 15 May 2024 12:58:00 -0400
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-cgroup: Properly propagate the iostat update up the
 hierarchy
Message-ID: <ZkTpmPoMb4PyPwCl@dschatzberg-fedora-PF3DHTBV>
References: <20240515143059.276677-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515143059.276677-1-longman@redhat.com>

On Wed, May 15, 2024 at 10:30:59AM -0400, Waiman Long wrote:
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
>  block/blk-cgroup.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 059467086b13..2a7624c32a1a 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -323,6 +323,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>  	blkg->q = disk->queue;
>  	INIT_LIST_HEAD(&blkg->q_node);
>  	blkg->blkcg = blkcg;
> +	blkg->iostat.blkg = blkg;
>  #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
>  	spin_lock_init(&blkg->async_bio_lock);
>  	bio_list_init(&blkg->async_bios);
> @@ -1025,6 +1026,8 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>  		unsigned int seq;
>  
>  		WRITE_ONCE(bisc->lqueued, false);
> +		if (bisc == &blkg->iostat)
> +			goto propagate_up; /* propagate up to parent only */
>  
>  		/* fetch the current per-cpu values */
>  		do {
> @@ -1034,10 +1037,24 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>  
>  		blkcg_iostat_update(blkg, &cur, &bisc->last);
>  
> +propagate_up:
>  		/* propagate global delta to parent (unless that's root) */
> -		if (parent && parent->parent)
> +		if (parent && parent->parent) {
>  			blkcg_iostat_update(parent, &blkg->iostat.cur,
>  					    &blkg->iostat.last);
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
>  	}
>  	raw_spin_unlock_irqrestore(&blkg_stat_lock, flags);
>  out:
> -- 
> 2.39.3
> 

I've tested and confirmed this patch fixes the original issue. Thanks!

