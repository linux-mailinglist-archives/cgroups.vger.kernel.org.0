Return-Path: <cgroups+bounces-3343-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDFC915F95
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 09:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044D41F21C42
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA21474D7;
	Tue, 25 Jun 2024 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gbSetYL5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916731474BF
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299224; cv=none; b=cPpgjvwrwhZMsg78G1ZGIB7WdVdB+8T60z2sDYC8iwSKG6YSum0x6iB7oP52K/05CTqgvIef1bd4WbIzO8NGsnSTGaAu6PRSzP0fr8tmFhV3NhVO5o6vyh/1ELldpt0Z5f97wemnnIMpBOViwcMDsPQzuBzuRQP5Vx35wbsNhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299224; c=relaxed/simple;
	bh=pwbSHIa/iEcbcCuTHn2l12BGzVYhiY1GdrORyvZNc14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnQuhuab9EVhzjXqBLv6DA1tl11+E3kAaHFT4KYgrGFF3HMJey76MvB978Q9eoPbpVHtwXeN0ooSar+k+qEyzVC3eO/ldMNDxiSAAe9IRr82ZmYiOVaDaWBIgrZ16Zf//GGkSQINmkSrC8n9IeGJUA9i5Y2jmrVR3xEIhuJZ/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gbSetYL5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so5403159a12.2
        for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299221; x=1719904021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tBnjieBKnSNXiXs3LFFb3+UTctu7j97oa3WJTwneIP4=;
        b=gbSetYL51W7tVkm+4Ub1vDHE0UQR+i2R2Sr8dt7d2O0/ZrtDCd4gZRzZrl8yj3xMt/
         /u74OdhvLQH4TtvJNn+uYe8lHbtUrh4k39nXmixvkPNcZfKEeFCVFCVaK1t2uLkW/SAJ
         rbnWzT/QqsbZVEB6hp9Cm0bNEiQeORacEenPwN5rVOebVWjYfEOR+V1aYBRMpNFO5wQB
         Not0XYhizQF3RkoUogMpEZb641tinVgQqASMhB8n+RyU/iYVzp0t8uVURlyjOkzGsG2n
         8uQNbxsDSYzg2vsBybzawtkkt+r4M0o+l02KNIO4WzL5a76xCcq/X9Rgqq+MfHn9yGiW
         sTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299221; x=1719904021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBnjieBKnSNXiXs3LFFb3+UTctu7j97oa3WJTwneIP4=;
        b=fNjrKCNQXQ6/cwj7OAA3bg6MXJgspyWclSd0kF8oPawDcJkSwEGDrIJBQVl4YCjX5Z
         31PoTBCIRyyO6P8wTfVIQ2pyeMChAhHJtAzMRVpSDUF5qId3ZQ4yt8Cybkj9yIHq6mlM
         8POWzHjGvTA21gMU1H7a1mpY71VJjJaq+fj99Co5cbEtQ9vqqukrkSZP+OJTeKgYXb7d
         1bsIhswyFBrssou8k9dKFACJ050Yi1K4ax/WW3K92WUxLYUkWVb5/8Vag3WrYFUuRvJK
         Biw25Vs6opvQt3qF3DVPisAeKMkIxwToru1KZ6I3gxyebF23xlP9KyYkrlzN4xt0BMgx
         mItg==
X-Forwarded-Encrypted: i=1; AJvYcCXigFfF3fAROg4eVew65cLYMcgEtH3gszNDOlJGq/AIcHKasfV3AfhRXCy/+1OlDZOetpGafSzuvPbycW4MwtZ+jFiOH+gpWA==
X-Gm-Message-State: AOJu0YzkgnqvN3mrfBsHctivNBfxhinO8+VjKdd6F3NLZa9Ai91Zrl5K
	KlOWAyaMBYv7s5wNygilug/E5TWZ07LYlXq0C3FgbPRsejxiAS9iPa3mHmGrOtM=
X-Google-Smtp-Source: AGHT+IHyD9jte7ZcutqOQMcaAMjGsTYOxDxkPRF6/pVK32a+zUwsInesnxzyA2WjqVMGCFaK1SG2tg==
X-Received: by 2002:a50:c359:0:b0:57c:a886:c402 with SMTP id 4fb4d7f45d1cf-57d45791c04mr6137793a12.12.1719299220786;
        Tue, 25 Jun 2024 00:07:00 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30563026sm5535506a12.85.2024.06.25.00.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:07:00 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:06:59 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 03/14] mm: memcg: rename soft limit reclaim-related
 functions
Message-ID: <Znpsk9yyXmMyA7Vf@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-4-roman.gushchin@linux.dev>

On Mon 24-06-24 17:58:55, Roman Gushchin wrote:
> Rename exported function related to the softlimit reclaim
> to have memcg1_ prefix.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 12 ++++++------
>  mm/memcontrol-v1.c         |  6 +++---
>  mm/memcontrol-v1.h         |  4 ++--
>  mm/memcontrol.c            |  4 ++--
>  mm/vmscan.c                | 10 +++++-----
>  5 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7403dd5926eb..83c8327455d8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1121,9 +1121,9 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  
>  void split_page_memcg(struct page *head, int old_order, int new_order);
>  
> -unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> -						gfp_t gfp_mask,
> -						unsigned long *total_scanned);
> +unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
> +					gfp_t gfp_mask,
> +					unsigned long *total_scanned);
>  
>  #else /* CONFIG_MEMCG */
>  
> @@ -1572,9 +1572,9 @@ static inline void split_page_memcg(struct page *head, int old_order, int new_or
>  }
>  
>  static inline
> -unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> -					    gfp_t gfp_mask,
> -					    unsigned long *total_scanned)
> +unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
> +					gfp_t gfp_mask,
> +					unsigned long *total_scanned)
>  {
>  	return 0;
>  }
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 2ccb8406fa84..68e2f1a718d3 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -100,7 +100,7 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
>  	return excess;
>  }
>  
> -void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
> +void memcg1_update_tree(struct mem_cgroup *memcg, int nid)
>  {
>  	unsigned long excess;
>  	struct mem_cgroup_per_node *mz;
> @@ -143,7 +143,7 @@ void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
>  	}
>  }
>  
> -void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
> +void memcg1_remove_from_trees(struct mem_cgroup *memcg)
>  {
>  	struct mem_cgroup_tree_per_node *mctz;
>  	struct mem_cgroup_per_node *mz;
> @@ -243,7 +243,7 @@ static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
>  	return total;
>  }
>  
> -unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> +unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  					    gfp_t gfp_mask,
>  					    unsigned long *total_scanned)
>  {
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 4da6fa561c6d..e37bc7e8d955 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -3,8 +3,8 @@
>  #ifndef __MM_MEMCONTROL_V1_H
>  #define __MM_MEMCONTROL_V1_H
>  
> -void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid);
> -void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg);
> +void memcg1_update_tree(struct mem_cgroup *memcg, int nid);
> +void memcg1_remove_from_trees(struct mem_cgroup *memcg);
>  
>  static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 003e944f34ea..3479e1af12d5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1012,7 +1012,7 @@ static void memcg_check_events(struct mem_cgroup *memcg, int nid)
>  						MEM_CGROUP_TARGET_SOFTLIMIT);
>  		mem_cgroup_threshold(memcg);
>  		if (unlikely(do_softlimit))
> -			mem_cgroup_update_tree(memcg, nid);
> +			memcg1_update_tree(memcg, nid);
>  	}
>  }
>  
> @@ -5610,7 +5610,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>  
>  	vmpressure_cleanup(&memcg->vmpressure);
>  	cancel_work_sync(&memcg->high_work);
> -	mem_cgroup_remove_from_trees(memcg);
> +	memcg1_remove_from_trees(memcg);
>  	free_shrinker_info(memcg);
>  	mem_cgroup_free(memcg);
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 900bad16e506..3d4c681c6d40 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6186,9 +6186,9 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>  			 * and balancing, not for a memcg's limit.
>  			 */
>  			nr_soft_scanned = 0;
> -			nr_soft_reclaimed = mem_cgroup_soft_limit_reclaim(zone->zone_pgdat,
> -						sc->order, sc->gfp_mask,
> -						&nr_soft_scanned);
> +			nr_soft_reclaimed = memcg1_soft_limit_reclaim(zone->zone_pgdat,
> +								      sc->order, sc->gfp_mask,
> +								      &nr_soft_scanned);
>  			sc->nr_reclaimed += nr_soft_reclaimed;
>  			sc->nr_scanned += nr_soft_scanned;
>  			/* need some check for avoid more shrink_zone() */
> @@ -6952,8 +6952,8 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  		/* Call soft limit reclaim before calling shrink_node. */
>  		sc.nr_scanned = 0;
>  		nr_soft_scanned = 0;
> -		nr_soft_reclaimed = mem_cgroup_soft_limit_reclaim(pgdat, sc.order,
> -						sc.gfp_mask, &nr_soft_scanned);
> +		nr_soft_reclaimed = memcg1_soft_limit_reclaim(pgdat, sc.order,
> +							      sc.gfp_mask, &nr_soft_scanned);
>  		sc.nr_reclaimed += nr_soft_reclaimed;
>  
>  		/*
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

