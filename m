Return-Path: <cgroups+bounces-9780-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5685B48869
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 11:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE15A1750E7
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D252F5485;
	Mon,  8 Sep 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z3qiOu/N"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A72F60A7
	for <cgroups@vger.kernel.org>; Mon,  8 Sep 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323708; cv=none; b=EXIGW1htwSFxMrbn5FWfidpMl4+nlTrYa3bwrIBAfCoSQgXbFldawWa6lWt/+8gA55x0Z4SscqjY57kFfJmnvYtmQJ8lsTC5ts7EbzG/iOt9RKgjCQOJXZosvGqitmP1vVnw3WS/DOO6HKjo7trTqIykG/YhWDmtix1hD6z8/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323708; c=relaxed/simple;
	bh=TBVEeAm7Jtahmfw3TwXLAhZmf3DGQa3stylZWm+XYAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlKTxXDcDLygZySuzfIpNbZwzDYiXrD7X3dU+Krmt1ztLe8PdmEw1qNZNnvKalK34br+d2U4790o/kCNLYv7iZ0PoKwKtYFKAhr8eHazlysr+pVR42LBN1pVseI1OeUoZBOePS0izyGSn6qyEikpu9UMcKsvMuD5/Kg85jgWiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z3qiOu/N; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so33854535e9.0
        for <cgroups@vger.kernel.org>; Mon, 08 Sep 2025 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757323702; x=1757928502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oULmcJMXha8v5gh2i1FU5HOTdqs6IUKbO31Sh0Sihfo=;
        b=Z3qiOu/N5JLeCGJ1KArDUResn2Ooekd2eNrUjiBarf5GOd5FCc0lNZfL9+2w0PXXbw
         SD/FqDX+a16g8ikki+1Ditu/8uB5GK8shol2pJY+23k9q2VpUH0V5yacstCgGQQxcUYx
         7FHIk2G//Ku9nBRKZw/1ZnOmPen/jJvOxaBMYRNhxWYPViZu2ehEd7SBzt0qZq/9tppH
         uzcTa0DWYbVYvZ3NLmfOV99WpEg1m9fQN5iPwCfDpEaZOsz8w0E08hwl+mEcJ1rLQDPS
         ObJFaqbwEGHa+BxmOfs9DLYbGEN9cT0pD9ifsXGiEg4pUyLAfIP3CL7S0b5B1H5iqwqj
         mYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323702; x=1757928502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oULmcJMXha8v5gh2i1FU5HOTdqs6IUKbO31Sh0Sihfo=;
        b=s2gU8a0iRccJgvjaqdDAuczP/ubCVkce6PeaRRq9pEUoFP0Xraa33rSb1WVd2ru9Lx
         ft2lk19T9iHsY6syLI3DwozW4fjdqnmz+OC7WByxbiHkhCEzfUTvUgY8Q1Gc5VQJj3OB
         NeX2UoMUOM06fDlKV02/8w/QVOVj0caHkXrE6YqgXLyZ02O6h3irhZ132eMkxgYW+cd1
         BVsjrS6tMD3DeAjnPF2vL8bZeUBFlY60ax9J2TcIoY988dOxeE5/ozWPhTHckMs+iV08
         p+ZxK+Bp+yRvxHPA6Ug3va8+ZTfmcbHm/4gAiW9E6S4uQphLMSeLr/eAk+oWzJ5Ys+F1
         LaXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTnUdT8QdBggfHjtRk4Gbr4zs6DiJcb0/GoCDrFNTcFQftdWCLKD8rjIDxo6JFUWw/Q4ANy9Aq@vger.kernel.org
X-Gm-Message-State: AOJu0YyGBDouATtU4Sq8tFBXXrg4b52RQ3Ufh7ysfod7vi6grLM9l09X
	uwkOwPefvCQDyDb36Bez+8IMyaOgblKTe9k2McYLUatA+gtBXp6oSblOqat/51MDYt4=
X-Gm-Gg: ASbGnctsezQlrfKD/sKQVmcUjKlSZHq7wam0e2DV7q/eFArh6PhyHiOkL47KPMccgwf
	DC9BS18FqhVgKllzLfA2eGaLWrSj1QA96esokqreWZUvnjC71z73KAcHhEWy+KUkvhj2i+JjHKX
	z1s2O/COqIm6oC4SMk414ebYmPaNrdaOuYg9P9nXI/fEUcMiYO8qRThrO+PeLNbhE4l0WwEVt84
	zrI2qQ9IrXTq4S5jIZwbvBkmKQx+tE3Nw4wHW/VJbziroZlO02oKOO/RtSCssVhZ4ruGPRZEKBD
	sMZ602K6RrPnG4QLs0qHNwHilyiHdLTWDV0qOdVt4k2IfrHNV7vCcwG/hM43uJDZkc7l+c4rfMY
	IPx7TB2BO+eXbvkAvr8C3wDMEQoszdA==
X-Google-Smtp-Source: AGHT+IGGMokDFkj82R0pk4Z/rqNX/HhpeR5ehoF8XM4OAGAn6N/D/anNfAR0B0g0zuYN0L4mk8/Jeg==
X-Received: by 2002:a05:6000:4404:b0:3e6:a8ba:7422 with SMTP id ffacd0b85a97d-3e6a8ba779cmr2767890f8f.10.1757323702096;
        Mon, 08 Sep 2025 02:28:22 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf33fba9fbsm40887135f8f.50.2025.09.08.02.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:28:21 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:28:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Peilin Ye <yepeilin@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aL6htMt-jHAaCGLv@tiehlicka>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905201606.66198-1-shakeel.butt@linux.dev>

On Fri 05-09-25 13:16:06, Shakeel Butt wrote:
> Generally memcg charging is allowed from all the contexts including NMI
> where even spinning on spinlock can cause locking issues. However one
> call chain was missed during the addition of memcg charging from any
> context support. That is try_charge_memcg() -> memcg_memory_event() ->
> cgroup_file_notify().
> 
> The possible function call tree under cgroup_file_notify() can acquire
> many different spin locks in spinning mode. Some of them are
> cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> just skip cgroup_file_notify() from memcg charging if the context does
> not allow spinning.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 23 ++++++++++++++++-------
>  mm/memcontrol.c            |  7 ++++---
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9dc5b52672a6..054fa34c936a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -993,22 +993,25 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
>  	count_memcg_events_mm(mm, idx, 1);
>  }
>  
> -static inline void memcg_memory_event(struct mem_cgroup *memcg,
> -				      enum memcg_memory_event event)
> +static inline void __memcg_memory_event(struct mem_cgroup *memcg,
> +					enum memcg_memory_event event,
> +					bool allow_spinning)
>  {
>  	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
>  			  event == MEMCG_SWAP_FAIL;
>  
>  	atomic_long_inc(&memcg->memory_events_local[event]);

Doesn't this involve locking on 32b? I guess we do not care all that
much but we might want to bail out early on those arches for
!allow_spinning

> -	if (!swap_event)
> +	if (!swap_event && allow_spinning)
>  		cgroup_file_notify(&memcg->events_local_file);
>  
>  	do {
>  		atomic_long_inc(&memcg->memory_events[event]);
> -		if (swap_event)
> -			cgroup_file_notify(&memcg->swap_events_file);
> -		else
> -			cgroup_file_notify(&memcg->events_file);
> +		if (allow_spinning) {
> +			if (swap_event)
> +				cgroup_file_notify(&memcg->swap_events_file);
> +			else
> +				cgroup_file_notify(&memcg->events_file);
> +		}
>  
>  		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  			break;
> @@ -1018,6 +1021,12 @@ static inline void memcg_memory_event(struct mem_cgroup *memcg,
>  		 !mem_cgroup_is_root(memcg));
>  }
>  
> +static inline void memcg_memory_event(struct mem_cgroup *memcg,
> +				      enum memcg_memory_event event)
> +{
> +	__memcg_memory_event(memcg, event, true);
> +}
> +
>  static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  					 enum memcg_memory_event event)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 257d2c76b730..dd5cd9d352f3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2306,12 +2306,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	bool drained = false;
>  	bool raised_max_event = false;
>  	unsigned long pflags;
> +	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
>  
>  retry:
>  	if (consume_stock(memcg, nr_pages))
>  		return 0;
>  
> -	if (!gfpflags_allow_spinning(gfp_mask))
> +	if (!allow_spinning)
>  		/* Avoid the refill and flush of the older stock */
>  		batch = nr_pages;
>  
> @@ -2347,7 +2348,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (!gfpflags_allow_blocking(gfp_mask))
>  		goto nomem;
>  
> -	memcg_memory_event(mem_over_limit, MEMCG_MAX);
> +	__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
>  	raised_max_event = true;
>  
>  	psi_memstall_enter(&pflags);
> @@ -2414,7 +2415,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * a MEMCG_MAX event.
>  	 */
>  	if (!raised_max_event)
> -		memcg_memory_event(mem_over_limit, MEMCG_MAX);
> +		__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
>  
>  	/*
>  	 * The allocation either can't fail or will lead to more memory
> -- 
> 2.47.3
> 

-- 
Michal Hocko
SUSE Labs

