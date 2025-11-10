Return-Path: <cgroups+bounces-11716-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E45C456E4
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 09:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EDD188FB9B
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B292FDC23;
	Mon, 10 Nov 2025 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QakBKAIe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187972FD697
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764548; cv=none; b=WKz6RLzGrgVUcCRszZOPJVR2ZgEmctPIPh4saq5GuGcXY29BpyXf5PODPCvVGqaryco1tGDS4hXWr/qbFTYv6jGTRodn6QUDwfcA10UivGf6RMkZ9x2ozfrCjMmGEsORWyzGzLCPCmLuvWoayN6EDYP84/wlO+LgSHOobDMccSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764548; c=relaxed/simple;
	bh=SYX+Wy7bJsOihCfrh07XC2V+14ZgJEkkJ3rX4N05Puk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A234B8dYoGeyx1IVRLQimU4yoRvaLmiCLh6Uz+CdK/8jz+/sltWCq69OlhlWt3D2GbBLJk/2mzofT80uNJZD3tkGmUle4PTcMuB6GIaYJpp5GL0To8gL1v1MEEVX15IHe8Su4vITb5tZxmwj8BV3kpPTdgMUK2GEhmNFhv3jpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QakBKAIe; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b727f330dd2so464496366b.2
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 00:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762764541; x=1763369341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYB3eNFBCkjH9q1uLbtzcXRkRk6p1kh+Sygy8eTu3sY=;
        b=QakBKAIe/3yS67qIEcpuvukggq1LgUspMnGX4htskEVXk1zn1I0y2o8KYWPr2CUE3d
         fhhLcSOtLH7YMw4KhZeH6/TPHOiWE4z9mCihclFUxyfrXSx2cZ5O/gxJ+eVp3UlxgBWk
         savu48/aDFOsqYzHGARsRwBBfLrVmdVkQi3m9KNNvzA2v9XeC5kteHaH6I4+l8uepCS/
         35NGsA3G70gFeCWFw4mLot930jUX716OxTtWfPZeutu2a3rJ7MPQ9RaOY261Y26l9woi
         q1cgnMz6OMLAtqcSamq/EV+rJDeUd4obdrOd05K6bd2qbpFwNkYrwXcIDIvpzI0Blb0Q
         5hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764541; x=1763369341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYB3eNFBCkjH9q1uLbtzcXRkRk6p1kh+Sygy8eTu3sY=;
        b=nEtYOKc+/FXv9C8wSWau2fA18tihXHc8beKiF0WITVF3tXZSl8TSF3myBxPrvxDgde
         LHOJaaaDDeQWd/2vVj1FYpMGN28NNGRR9QpuhH/IX5xNuPu787Xmx2I1G+vX2qwS7PsJ
         gu6c0U7T052uuNj/xyH04JTQNU5NKfT3hjuOWpg16LHecuB/DDhhcD5gHV0zpvf1Q5+E
         u/tOO/98RIl+zRv9DchyDLxulVfOIulThQ9kN4Yj+JuZ4erYzYpxTEgw7gf2cp0CJy7B
         YVZaIyzoygNHimWYg9/wt4JKx6cjK7wVdD5Ve+FwRCFQDEIFU0M7yUxq77MkFGJFVpVv
         RrBg==
X-Forwarded-Encrypted: i=1; AJvYcCW+hbYWLADilXgvaJ33xmH0/FKWfrP5psRN6zof7p9ifRta6C2NNRlKCcoqOpAd6FUJ6T40YbNS@vger.kernel.org
X-Gm-Message-State: AOJu0YzKe4KJlVk2xTFP48Nr9ZgUJInv1VlMUXHiA3Xn7XRTnHhi7uP5
	0GjiHJpmVzVPEQd8IMoBJrKHgVKGowIUmV1kphboKJjn5ut/1evvuVO5km7R7cUEZRc=
X-Gm-Gg: ASbGncuSe9UZap5nBj1bTVdUTEedZwnagAXrPMJr/ENmhPKiEjYGXPzUm6b4G/ioX2A
	pVVJdzuVMi94QXTzyv6mQZ2QsfzC8WF6h90yGrpsa0QwrcG1S5LFWQ/sTMsHo4m3swIz2wEV2XW
	zJu/CdFVlv3tNFSGbwI7DsgwGb3t9tRwBO+0dOfcHB6pfeBll9dL8wPJ09MPxJ8cACM7lHJjI4Z
	0n/JYUkjvCP81f6QoONpA2hrPm+2oUBAI7P4RcoawALhDDjLHA4HQtM70yyhgxVPk+hyMDBogN9
	e7EDkr+GpoQ39CvPJ2geKYUS6AYZwDp/mvAm4bQcV7u8f/DZKfHjw1lZm4KCIW+iUO7TA9PzQuo
	4Z2Y47j3mZ62wSpL0YBfv6LJUiiFjaTj4ypwkw5QYT3zWCgQqVevsQcenRLDxaR3Wga5es8FA2F
	vTQrfBlSBSn554dxufKkFfFguS
X-Google-Smtp-Source: AGHT+IHkCcGZffVbGb8qG3xm/rRfqIb/GgVIQQoNThnr6QrJwoyhjqnbS9/gl3lEpfFn0E7hIkOGtw==
X-Received: by 2002:a17:907:9807:b0:b6d:2b14:4aa4 with SMTP id a640c23a62f3a-b72e05ac909mr660427666b.63.1762764541165;
        Mon, 10 Nov 2025 00:49:01 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9be184sm1016802566b.56.2025.11.10.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 00:49:00 -0800 (PST)
Date: Mon, 10 Nov 2025 09:48:59 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: memcg: dump memcg protection info on oom or alloc
 failures
Message-ID: <aRGm-yJwkHIlF07I@tiehlicka>
References: <20251107234041.3632644-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107234041.3632644-1-shakeel.butt@linux.dev>

On Fri 07-11-25 15:40:41, Shakeel Butt wrote:
> Currently kernel dumps memory state on oom and allocation failures. One
> of the question usually raised on those dumps is why the kernel has not
> reclaimed the reclaimable memory instead of triggering oom. One
> potential reason is the usage of memory protection provided by memcg.
> So, let's also dump the memory protected by the memcg in such reports to
> ease the debugging.

Makes sense to me.

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  include/linux/memcontrol.h |  5 +++++
>  mm/memcontrol.c            | 13 +++++++++++++
>  mm/oom_kill.c              |  1 +
>  mm/page_alloc.c            |  1 +
>  4 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 8d2e250535a8..6861f0ff02b5 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1779,6 +1779,7 @@ static inline bool memcg_is_dying(struct mem_cgroup *memcg)
>  	return memcg ? css_is_dying(&memcg->css) : false;
>  }
>  
> +void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
>  #else
>  static inline bool mem_cgroup_kmem_disabled(void)
>  {
> @@ -1850,6 +1851,10 @@ static inline bool memcg_is_dying(struct mem_cgroup *memcg)
>  {
>  	return false;
>  }
> +
> +static inline void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
> +{
> +}
>  #endif /* CONFIG_MEMCG */
>  
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c34029e92bab..623446821b00 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5636,3 +5636,16 @@ bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
>  {
>  	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
>  }
> +
> +void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
> +{
> +	if (mem_cgroup_disabled() || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		return;
> +
> +	if (!memcg)
> +		memcg = root_mem_cgroup;
> +
> +	pr_warn("Memory cgroup min protection %lukB -- low protection %lukB",
> +		K(atomic_long_read(&memcg->memory.children_min_usage)*PAGE_SIZE),
> +		K(atomic_long_read(&memcg->memory.children_low_usage)*PAGE_SIZE));
> +}
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index c145b0feecc1..5eb11fbba704 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -472,6 +472,7 @@ static void dump_header(struct oom_control *oc)
>  		if (should_dump_unreclaim_slab())
>  			dump_unreclaimable_slab();
>  	}
> +	mem_cgroup_show_protected_memory(oc->memcg);
>  	if (sysctl_oom_dump_tasks)
>  		dump_tasks(oc);
>  }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e4efda1158b2..26be5734253f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3977,6 +3977,7 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
>  		filter &= ~SHOW_MEM_FILTER_NODES;
>  
>  	__show_mem(filter, nodemask, gfp_zone(gfp_mask));
> +	mem_cgroup_show_protected_memory(NULL);
>  }
>  
>  void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
> -- 
> 2.47.3

-- 
Michal Hocko
SUSE Labs

