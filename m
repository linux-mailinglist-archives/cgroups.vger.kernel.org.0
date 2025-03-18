Return-Path: <cgroups+bounces-7114-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E487A664C4
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 02:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79211189C571
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 01:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49487126C02;
	Tue, 18 Mar 2025 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VtTsTjJG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF881749
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260443; cv=none; b=JI1JvMUhPGqoFpdxpAlCnmKjqCyjgwQp0/QY8Onlk08GvJ2/1IGFYHXYG1D+8tsblU1W0yncSPaA4j1vs3bu6VCU/SWrFDlUIXE8qgdiCqYUhRalIryjWxMfNmFZSiTSS5E3CDd2/36ds1aY4+XfN9H07AFbWZ3MYr3NiR1Bt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260443; c=relaxed/simple;
	bh=ngrXW5OGnozsH3LpRBKU9FtsESl6OnusHLUi7b59djc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frwqkNzcI60gBU+Ddpo8+bPgWnK8XXN92CLxQonRa+6ZMiS0IYGXiTmCMV+5I9r50vhj1zTdjRwer2mVhUrGGrFIgqRTRGQUkEASGUE4uO8fnTH87Iaf+KY1k5abqDTwsQZYSa32o1OsZSvGVufVTV4XXMoPZUs+SaWrGj3IV9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VtTsTjJG; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 01:13:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742260429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXsTKHcuddy1YSKto3W7H1Cp7bk8qRJyAR00726aAHw=;
	b=VtTsTjJGb8MWmUtCJKt+7eGKLLa5cg9fuBs5cRP/UkiGZuTshbdUWj55y715ExOjMvORE2
	LkwxUkbGT1MILWSH43oUc/3FbbQ/qCi6vSBTfixkEZL6tSDSfDNaIYZcrr3dkzZDahg+Oi
	8BQYyD7HOilk6YmFzmAFrKjldiQ/z88=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 7/9] memcg: use __mod_memcg_state in drain_obj_stock
Message-ID: <Z9jIxxllVwFSLYeL@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-8-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-8-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:28AM -0700, Shakeel Butt wrote:
> For non-PREEMPT_RT kernels, drain_obj_stock() is always called with irq
> disabled, so we can use __mod_memcg_state() instead of
> mod_memcg_state(). For PREEMPT_RT, we need to add memcg_stats_[un]lock
> in __mod_memcg_state().
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  mm/memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3c4de384b5a0..dfe9c2eb7816 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -707,10 +707,12 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
>  	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
>  		return;
>  
> +	memcg_stats_lock();
>  	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
>  	val = memcg_state_val_in_pages(idx, val);
>  	memcg_rstat_updated(memcg, val);
>  	trace_mod_memcg_state(memcg, idx, val);
> +	memcg_stats_unlock();
>  }
>  
>  #ifdef CONFIG_MEMCG_V1
> @@ -2845,7 +2847,7 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)

VM_WARN_ON_IRQS_ENABLED() ?

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

