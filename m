Return-Path: <cgroups+bounces-12336-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10137CB58D8
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 11:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95BD63010FFD
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 10:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A1E303C8A;
	Thu, 11 Dec 2025 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ghp34S4R"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E926980F
	for <cgroups@vger.kernel.org>; Thu, 11 Dec 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765450144; cv=none; b=FlJC8xMgt+zD2fGspY3uoi02lxSKCT3q/XOqcte/Li1rltWuRgQ9h8kYy58LS6T+Ytn/Upq2ARog2Sm3mTt5ZVCYdf9Wx7lWdSk5fvG01r5scJlBTJ8TZZgoZQ/kZz6ESugHpFxI6q0klgpdVM2G/wlGKcOmmEq0Oko/9Ck3xnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765450144; c=relaxed/simple;
	bh=pcN71IFUDIqhAGtQRU+Z1JbUPnlij6PX3KwUTSMEfFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj15NqIAslFZrlO2RbEpXPhHTLO25nkcgKVelWAr8UKDeDlPUOHb3n8fDLg/XDJLlAA1ASXEOe7z4y9YsO5Ju+NIyO0dKgw66Gs8eb6AAGk8ojASbasDOYIkfPo3+KhiMFiEFp0qG+5Y1hY5n1XfJQkSbTzxLJGKfmPwfE+iZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ghp34S4R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477b91680f8so8290645e9.0
        for <cgroups@vger.kernel.org>; Thu, 11 Dec 2025 02:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765450141; x=1766054941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Id+mKyK2rpQjMmy5lZn1vycT1sBmx/sBfGFCg09yGQU=;
        b=ghp34S4R8/SF6Zocx8pg6vhalFtCcXz4thCWbN7ijZarkJoZztaNu6CRWymT9nyy8I
         fZ4fYxyOPRtk7FK2vvbOiw3p/u/PjvpVv7vfAYI05hFVYThfAP7QjOWFTI44DpeCLYyS
         HDl8de6qSlqNVuSQGUiVgaaXxjejOZRl/dCYcMrUjJMb8Gmo+iZcEzDxGhocW/rFQqd+
         cssiR0uTe7gmIJC7Rx2i1IP0x/oMa00lWeNHpzJ7d/5FV3m6hw/iz/g5Z2fzm0NZho/l
         jVGSYmkavRcu3Bfspi16lf7e0A35S+8o30Td9RFW1zNUSCym4e5fuwrXge7V74p1Fpt7
         zlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765450141; x=1766054941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id+mKyK2rpQjMmy5lZn1vycT1sBmx/sBfGFCg09yGQU=;
        b=DuFUCdwXhuB+6K1/am8jgRbGV5jA6NtZJKgAdRKMqDWqxjRlxT9so2ZljyfJWvw13q
         Sy8sdaWG+llo9cU1ktDYOLgiUoRaqqqXCy7OrE8btCU5x/yUQnlXRtVGYWX6qXYHqXiw
         Z9WTxjcM2nd+2xJLcAKyrzVJ/TnkaPDTpeBi8BP1sjbx3V06l84ohxw8LQpxUvjymdkm
         2v/mhX855GL1TMF+bDbkBmSMwEgcOqA3frNz8V2eXZbk3htbHI0kKq2Fh5RHbBO0+Ii4
         wnTsXRMHoW6zSdzQge5Mqrw0n4XdUlVFCan5m1jZ0nmCA2GFwHruaC/C8Vy7B94c52rA
         hrRA==
X-Forwarded-Encrypted: i=1; AJvYcCXh72YgahkOXzL+wABwhDu38DZ35s77e/VRVz282d/MGegVkd9LGSCvOPK/hPwuJv6lG16jm/OF@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzNcse0K9bdCGoQqzx/UbXcJPkMc8+paDzPEzaBndhBpI7JOB
	6A/ybfq2FRnT5lCSpIbgzzUhkrS4ZjzlGsDuK2rajd0xqxA4rIg5nItbDeaYejk2BOQ=
X-Gm-Gg: AY/fxX7kvA+hrphAS6ULfJ5u7Ou5TEvTQiKnGz4itL6WCz/oW0G47EUpWDhE3gKGpeZ
	VddQHzi0anfEcz71I6lmSCYjgMDhsYOxlrNsqQI8RUGZc7caq9YyZLXrHGKF/gWvSeqsGQHPun4
	cKi9u/BFzJoHtGXhVfGxg+R7WKB/Sev6nDdAFexUBXgsO7xtrsDieGriz3RqkJZ8me9QkZqIkSY
	miF1t0DTk8Pf+2Np9TGBeB9GTy4FYAppqKn0wjoESiZdmHRKVnMGeKu1CDYxWZUU46YlWwXUg8P
	TudYcZpDvYRTZFKWR43VBFHR19/UzWGI1fIeLu3zV+EIh4yGUrz+Gpape2ClErwBQ0MG+msSQbU
	sbMudKWexp7CIm2RgGyHW4pzfsgjFiujsQzQh6UQ4Uy+UIWywWSGUZezJn1ynL8W+Kh++3IJ3HF
	VeoKhW+wfnkYVTSdwWYzm4Qg==
X-Google-Smtp-Source: AGHT+IEBLP4GufhuQ9ivk06ROp8MdpmTBKZZfneqKF/kFhPRh8XsQe0Q9OfzTGlG+nMO6BdDjT2lXw==
X-Received: by 2002:a05:600c:4685:b0:477:63b5:6f39 with SMTP id 5b1f17b1804b1-47a856249e0mr47088695e9.19.1765450140799;
        Thu, 11 Dec 2025 02:49:00 -0800 (PST)
Received: from localhost (109-81-21-76.rct.o2.cz. [109.81.21.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f05cebsm10241835e9.19.2025.12.11.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 02:49:00 -0800 (PST)
Date: Thu, 11 Dec 2025 11:48:59 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH -next v3 2/2] memcg: remove mem_cgroup_size()
Message-ID: <aTqhm67ouVl8CHQG@tiehlicka>
References: <20251211013019.2080004-1-chenridong@huaweicloud.com>
 <20251211013019.2080004-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211013019.2080004-3-chenridong@huaweicloud.com>

On Thu 11-12-25 01:30:19, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The mem_cgroup_size helper is used only in apply_proportional_protection
> to read the current memory usage. Its semantics are unclear and
> inconsistent with other sites, which directly call page_counter_read for
> the same purpose.
> 
> Remove this helper and get its usage via mem_cgroup_protection for
> clarity. Additionally, rename the local variable 'cgroup_size' to 'usage'
> to better reflect its meaning.
> 
> No functional changes intended.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Yes, this looks much better.
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  include/linux/memcontrol.h | 18 +++++++-----------
>  mm/memcontrol.c            |  5 -----
>  mm/vmscan.c                |  9 ++++-----
>  3 files changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6a48398a1f4e..603252e3169c 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -557,13 +557,15 @@ static inline bool mem_cgroup_disabled(void)
>  static inline void mem_cgroup_protection(struct mem_cgroup *root,
>  					 struct mem_cgroup *memcg,
>  					 unsigned long *min,
> -					 unsigned long *low)
> +					 unsigned long *low,
> +					 unsigned long *usage)
>  {
> -	*min = *low = 0;
> +	*min = *low = *usage = 0;
>  
>  	if (mem_cgroup_disabled())
>  		return;
>  
> +	*usage = page_counter_read(&memcg->memory);
>  	/*
>  	 * There is no reclaim protection applied to a targeted reclaim.
>  	 * We are special casing this specific case here because
> @@ -919,8 +921,6 @@ static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
>  
>  unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
>  
> -unsigned long mem_cgroup_size(struct mem_cgroup *memcg);
> -
>  void mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
>  				struct task_struct *p);
>  
> @@ -1102,9 +1102,10 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  static inline void mem_cgroup_protection(struct mem_cgroup *root,
>  					 struct mem_cgroup *memcg,
>  					 unsigned long *min,
> -					 unsigned long *low)
> +					 unsigned long *low,
> +					 unsigned long *usage)
>  {
> -	*min = *low = 0;
> +	*min = *low = *usage = 0;
>  }
>  
>  static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
> @@ -1328,11 +1329,6 @@ static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
>  	return 0;
>  }
>  
> -static inline unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
> -{
> -	return 0;
> -}
> -
>  static inline void
>  mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *p)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index dbe7d8f93072..659ce171b1b3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1621,11 +1621,6 @@ unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
>  	return max;
>  }
>  
> -unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
> -{
> -	return page_counter_read(&memcg->memory);
> -}
> -
>  void __memcg_memory_event(struct mem_cgroup *memcg,
>  			  enum memcg_memory_event event, bool allow_spinning)
>  {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 670fe9fae5ba..9a6ee80275fc 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2451,9 +2451,9 @@ static inline void calculate_pressure_balance(struct scan_control *sc,
>  static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>  		struct scan_control *sc, unsigned long scan)
>  {
> -	unsigned long min, low;
> +	unsigned long min, low, usage;
>  
> -	mem_cgroup_protection(sc->target_mem_cgroup, memcg, &min, &low);
> +	mem_cgroup_protection(sc->target_mem_cgroup, memcg, &min, &low, &usage);
>  
>  	if (min || low) {
>  		/*
> @@ -2485,7 +2485,6 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>  		 * again by how much of the total memory used is under
>  		 * hard protection.
>  		 */
> -		unsigned long cgroup_size = mem_cgroup_size(memcg);
>  		unsigned long protection;
>  
>  		/* memory.low scaling, make sure we retry before OOM */
> @@ -2497,9 +2496,9 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>  		}
>  
>  		/* Avoid TOCTOU with earlier protection check */
> -		cgroup_size = max(cgroup_size, protection);
> +		usage = max(usage, protection);
>  
> -		scan -= scan * protection / (cgroup_size + 1);
> +		scan -= scan * protection / (usage + 1);
>  
>  		/*
>  		 * Minimally target SWAP_CLUSTER_MAX pages to keep
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs

