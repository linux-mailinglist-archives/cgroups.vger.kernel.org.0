Return-Path: <cgroups+bounces-3717-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6D693336A
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 23:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBCD1C2224C
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 21:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814C144D0A;
	Tue, 16 Jul 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmB+ltOQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7F9142E86;
	Tue, 16 Jul 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721164420; cv=none; b=WwTf26G1/i1227I2KAFJoeYZbQxH0tkl2zmn3QyJ4hMcfyVoVvugA6jH1Bd6BCHbM+j+JZBH4HMFGS+67uEkeRLZI8+FplYVwhamZcyPSsMAO74SQXZQpDDS+QbgzHUfRC4vzJCubTsVzsvmroum/d3yE4ztFAKipub2B/t0xBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721164420; c=relaxed/simple;
	bh=9iC87dpWlEete4vWmjJZ/0kZqeyGrcAPBgky9h1AQi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3k3e1blXzJpp6H6IgFkY14id928aJ6ReGsv7dKDIYadAg95YxjTmqsY+Q9g1lIqJF4HjYqlFT56XLfdWJkhQlF/CKbEPNwyYnStFA5ZNaMT7fGoA6vQh4q/sX82wrvPR3xiMwsM6QnZ9s4HRE8+uZh6SA5rGmcI3LbtrN1F3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmB+ltOQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b2a0542c2so5664813b3a.3;
        Tue, 16 Jul 2024 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721164417; x=1721769217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ag5NdJlDjgGBhuGOZDzJcu7IZkmLpKyxnSbjG+hkilc=;
        b=OmB+ltOQAbD1cnIF8uvsqBkbzhH/3coeN9/3JSRxQcqlgpeQzRrbj8iqf5FsBki3gR
         gBwFrnYQyibour3nRSjN5J3VYF9SlUiY2kNs2OIORFGK99yFVAcq9c40wzFE5anSJTDe
         QyHu1whwCLZt9ygTOLJZkQCkBTanpFt9Hd9swgsN1ANSoRy2dhqKKxoOrwQoOaoWLI84
         DC1wUABcsCaZbyY2SEh2MHPDzt0QfXvCsJIevAHZ44Y8u6U1vQgqmRJ+4shCGcHblVbL
         kniBMFzGLTHl4UcWrdjoeVb1kccNTZYD9E2Qy4vyCtb79aKse7U7RK1EqT9ToFh4jGrh
         DF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721164417; x=1721769217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ag5NdJlDjgGBhuGOZDzJcu7IZkmLpKyxnSbjG+hkilc=;
        b=qKS1DIhOduu4ecJ/Ebk4xIbkAQDfYfR7GoXU0yfYHkIleP/xD3tEYgFCpNYcUZEUQI
         At4GwLE37XaWi6jmaoNYYKcKnn37aPQBpRucKTS2RYiP4Amn/j0yxua5BXuc35UDtOcT
         gf2Nl+WIQu0amsaXz2aXI6Ca/ltCU/zGQGFQrT4YP9C8lDJRDZN8T7/L5qxsgiZ9bmNU
         y24k4MXJFGMJdYeqxAjMD0KRCyt/dusiNe6TwTKesIR+pHZoD/OcswiaGfG9jaKh//gT
         C3I1Yo+A7gJMicGMV99uBj693hGs0FOhSkoTpT4QibakXYB6CNJqPlEGGb6hAJvtSx95
         rKyw==
X-Forwarded-Encrypted: i=1; AJvYcCVXNEYHgOz9yik8ewFEkdm56PxZ9yryNcQN6jnvRsJ8d3WXqriGQHPI8MDH7QRA54K/Ef4LZ17PMoaKKxnx+pLGP2lrECcH09COe89ddWmwMRXmvUbnS3LguZ9SsD73+gGIgqDq330Xd/zgtVIFggXx3Za6mgtUBoglIvoFRVpa6eBc
X-Gm-Message-State: AOJu0Yxdw0/7IJPnxGZwd8MPrwKP6kOnqwMYwpjt70X+G7fJDnsuCxDj
	aYdgwQrKRg7Lng8oLu7zEdzCjwYIkiGkqdrMnrDbyVhyuEsS1/zA
X-Google-Smtp-Source: AGHT+IEvPNah8o8ElhR2lXdjKaUmNu2BHdD7tWO6AdHw+HwAq26CaXaLi2pF9DM3SbCMdFzYQrtBvg==
X-Received: by 2002:a05:6a20:729c:b0:1c1:89f8:8609 with SMTP id adf61e73a8af0-1c3f10e02d5mr4669359637.0.1721164417106;
        Tue, 16 Jul 2024 14:13:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca7a7bsm6795727b3a.152.2024.07.16.14.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 14:13:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jul 2024 11:13:35 -1000
From: Tejun Heo <tj@kernel.org>
To: "boy.wu" <boy.wu@mediatek.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Burkov <boris@bur.io>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, iverlin.wang@mediatek.com
Subject: Re: [PATCH v3] blk-cgroup: Replace u64 sync with spinlock for iostat
 update
Message-ID: <Zpbify32lel9J-5I@slm.duckdns.org>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716075206.23121-1-boy.wu@mediatek.com>

Hello, Boy.

So, looking at the patch, I'm not sure per-blkg lock makes sense.

On Tue, Jul 16, 2024 at 03:52:06PM +0800, boy.wu wrote:
> @@ -995,15 +995,13 @@ static void blkcg_iostat_update(struct blkcg_gq *blkg, struct blkg_iostat *cur,
>  				struct blkg_iostat *last)
>  {
>  	struct blkg_iostat delta;
> -	unsigned long flags;
>  
>  	/* propagate percpu delta to global */
> -	flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
> +	guard(spinlock_irqsave)(&blkg->iostat.spinlock);
>  	blkg_iostat_set(&delta, cur);
>  	blkg_iostat_sub(&delta, last);
>  	blkg_iostat_add(&blkg->iostat.cur, &delta);
>  	blkg_iostat_add(last, &delta);
> -	u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
>  }

This is already called with blkg_stat_lock held.

> @@ -1051,10 +1048,8 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>  			goto propagate_up; /* propagate up to parent only */
>  
>  		/* fetch the current per-cpu values */
> -		do {
> -			seq = u64_stats_fetch_begin(&bisc->sync);
> +		scoped_guard(spinlock_irqsave, &bisc->spinlock)
>  			blkg_iostat_set(&cur, &bisc->cur);
> -		} while (u64_stats_fetch_retry(&bisc->sync, seq));

This is per-cpu stat and we should keep using u64_sync for them.

> @@ -1134,9 +1128,8 @@ static void blkcg_fill_root_iostats(void)
>  				cpu_dkstats->sectors[STAT_DISCARD] << 9;
>  		}
>  
> -		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
> +		guard(spinlock_irqsave)(&blkg->iostat.spinlock);
>  		blkg_iostat_set(&blkg->iostat.cur, &tmp);
> -		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
>  	}
>  }
...
> @@ -1157,16 +1149,14 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
>  
>  	seq_printf(s, "%s ", dname);
>  
> -	do {
> -		seq = u64_stats_fetch_begin(&bis->sync);
> -
> +	scoped_guard(spinlock_irqsave, &bis->spinlock) {
>  		rbytes = bis->cur.bytes[BLKG_IOSTAT_READ];
>  		wbytes = bis->cur.bytes[BLKG_IOSTAT_WRITE];
>  		dbytes = bis->cur.bytes[BLKG_IOSTAT_DISCARD];
>  		rios = bis->cur.ios[BLKG_IOSTAT_READ];
>  		wios = bis->cur.ios[BLKG_IOSTAT_WRITE];
>  		dios = bis->cur.ios[BLKG_IOSTAT_DISCARD];
> -	} while (u64_stats_fetch_retry(&bis->sync, seq));
> +	}

The above two are the only places which can potentially benefit from
per-blkg lock but these aren't hot paths. I'd just use blkg_stat_lock for
the above.

> @@ -2152,30 +2141,29 @@ void blk_cgroup_bio_start(struct bio *bio)
>  
>  	cpu = get_cpu();
>  	bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
> -	flags = u64_stats_update_begin_irqsave(&bis->sync);
> -
> -	/*
> -	 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a split
> -	 * bio and we would have already accounted for the size of the bio.
> -	 */
> -	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> -		bio_set_flag(bio, BIO_CGROUP_ACCT);
> -		bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
> -	}
> -	bis->cur.ios[rwd]++;
> +	scoped_guard(spinlock_irqsave, &bis->spinlock) {
> +		/*
> +		 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a split
> +		 * bio and we would have already accounted for the size of the bio.
> +		 */
> +		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> +			bio_set_flag(bio, BIO_CGROUP_ACCT);
> +			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
> +		}
> +		bis->cur.ios[rwd]++;
>  
> -	/*
> -	 * If the iostat_cpu isn't in a lockless list, put it into the
> -	 * list to indicate that a stat update is pending.
> -	 */
> -	if (!READ_ONCE(bis->lqueued)) {
> -		struct llist_head *lhead = this_cpu_ptr(blkcg->lhead);
> +		/*
> +		 * If the iostat_cpu isn't in a lockless list, put it into the
> +		 * list to indicate that a stat update is pending.
> +		 */
> +		if (!READ_ONCE(bis->lqueued)) {
> +			struct llist_head *lhead = this_cpu_ptr(blkcg->lhead);
>  
> -		llist_add(&bis->lnode, lhead);
> -		WRITE_ONCE(bis->lqueued, true);
> +			llist_add(&bis->lnode, lhead);
> +			WRITE_ONCE(bis->lqueued, true);
> +		}

These are per-cpu stat updates which should keep using u64_sync. We don't
want to incur locking overhead for stat updates in the hot issue path.

Thanks.

-- 
tejun

