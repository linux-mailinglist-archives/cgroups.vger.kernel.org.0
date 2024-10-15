Return-Path: <cgroups+bounces-5134-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC2999FA92
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 23:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC561C22C51
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91C21E3B7;
	Tue, 15 Oct 2024 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QkFWq9d7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CDE21E3A2
	for <cgroups@vger.kernel.org>; Tue, 15 Oct 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029183; cv=none; b=IX1MsmEsgF04u/PHAADjR8sRSBLb43FQxxZh/l8NQ0SaBm+q+KZXar0sH5YV7sb64Y82pCdQZy9ehvLsNvSTnEbojdpeBSjrDDNx3V43Ybh+hc6qEiuZuWekCYBr4TgtjjZ0IwurP2h53RTvWGppn7YKgT4EARHblBSuniC1DdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029183; c=relaxed/simple;
	bh=APRZwFHntprhiV9dfwW2dJ+pQBi9YNVvUShHRvQlatc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3wBzHTJ6UuNZps6LuUzYChD1EyyppYewJt+cmxLJhqO3BPHS8adgZoN2PvcZBllwvZT+9ETDi28I5fzsDFgIZN05SlXWhjW1vGZE55SxE10uoX/cV8vdViLGBmK1qddoJ0iJpsp2JBMRo8YHDumMCsqokeyl0soLLFK3WK9Uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QkFWq9d7; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so2708586d6.0
        for <cgroups@vger.kernel.org>; Tue, 15 Oct 2024 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729029180; x=1729633980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByrqP2HuNDz4/B2jUpoQ0m7Is0xEnttOr3HRUCLizRc=;
        b=QkFWq9d7lYTb4GWKIS50dqmosVATEP9Oo3OGhKi9xg1lMY53S6lJ9ahp/bnrb0VkXl
         CY3X2kdzlKprFZnuI0OSw28Pu4mSuG+UQQoVHI6lS9xGrqKib3bB9+ILBBXJ5ypJvd7z
         31l1Parf/rhj+HrBtGPZNKz0psV7aCvwPfj9vj+rYsxkup00FpZgv4d/7NhCDgN5JDAR
         anU7MwUOUSOZHYHDbAATSr4BmExEp/Ien2Mw/r6YMhAD1xXy3Gs7oddrD15cZPK7q7tL
         fIDOPIqVMZGrKPDnb/CemCmCCB93NJI2HX4Zk50thtqK1lBbeFQ1gyQ9+O2RboJkyfzW
         /YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029180; x=1729633980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByrqP2HuNDz4/B2jUpoQ0m7Is0xEnttOr3HRUCLizRc=;
        b=Txnhu7zmyPXbGVO/ydPgVpWFsLzKPNgLegC6e+CcOkylFuTTXINWiDSWYpJNy1DEjV
         UROvijm5xeaCC1oY9zj8OagTMi1jf3qhNWnnJ6ZHHGtEfy9iIxne52cJEdOccK4sQ9Ir
         56NUIFH/wJnmUjDIqsO9v/OXSDBDh5Dlmnuka5szLdB1J3aGLrZxmkLet4hlhyYolDvl
         FHMjEF161+UAJW2x38ii4SGY5dMY953sW7k1Eh/T0w0eTNMoi3pIX92y0rYwS5hppyc6
         aGmee+feny2fPf9CHhjTqOqFSw+xZMbLxLn//p0zHTNeCLQy97QXj00zvf5IItKrNklp
         iUzg==
X-Forwarded-Encrypted: i=1; AJvYcCXcj9sQ5z94vC3NTH5q0yOkJZzW/s4MV0uyrqSeAO9wbAzHG3uxNmfIUEsL2RVRsIEzdf0ofZ24@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9OyQrdmiarSE8avEkQRaQAgsli3e5MtIJ4Yho2/aOym12Gfom
	6PJPegqDMyJeyMI0C3+2wacIsnN/aoGIHFF/SIAsMIKCKqzFuHo5Bj6CdCKtF5mznJcJjhlIwq5
	3
X-Google-Smtp-Source: AGHT+IH7T8p8v5N9Ela+YmiiUwvyud0j7BoExroRpPen0ZBA/8H/A3UwSM4Z0as+ot9qaaX2knyEZA==
X-Received: by 2002:ad4:5aed:0:b0:6cb:fc3f:6cc7 with SMTP id 6a1803df08f44-6cc2b5c1009mr35780666d6.15.1729029180281;
        Tue, 15 Oct 2024 14:53:00 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a6760sm10926471cf.6.2024.10.15.14.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:52:59 -0700 (PDT)
Date: Tue, 15 Oct 2024 17:52:56 -0400
From: Gregory Price <gourry@gourry.net>
To: kaiyang2@cs.cmu.edu
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, mhocko@kernel.org, nehagholkar@meta.com,
	abhishekd@meta.com, hannes@cmpxchg.org, weixugc@google.com,
	rientjes@google.com
Subject: Re: [RFC PATCH 3/4] use memory.low local node protection for local
 node reclaim
Message-ID: <Zw7kOJ-LOvQo5PzV@PC2K9PVX.TheFacebook.com>
References: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
 <20240920221202.1734227-4-kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920221202.1734227-4-kaiyang2@cs.cmu.edu>

On Fri, Sep 20, 2024 at 10:11:50PM +0000, kaiyang2@cs.cmu.edu wrote:
> From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
> 
> When reclaim targets the top-tier node usage by the root memcg,
> apply local memory.low protection instead of global protection.
> 

Changelog probably needs a little more context about the intended
affect of this change.  What exactly is the implication of this
change compared to applying it against elow?

> Signed-off-by: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
> ---
>  include/linux/memcontrol.h | 23 ++++++++++++++---------
>  mm/memcontrol.c            |  4 ++--
>  mm/vmscan.c                | 19 ++++++++++++++-----
>  3 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 94aba4498fca..256912b91922 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -586,9 +586,9 @@ static inline bool mem_cgroup_disabled(void)
>  static inline void mem_cgroup_protection(struct mem_cgroup *root,
>  					 struct mem_cgroup *memcg,
>  					 unsigned long *min,
> -					 unsigned long *low)
> +					 unsigned long *low, unsigned long *locallow)
>  {
> -	*min = *low = 0;
> +	*min = *low = *locallow = 0;
>  

"locallow" can be read as "loc allow" or "local low", probably you
want to change all the references to local_low.

Sorry for not saying this on earlier feedback.


>  	if (mem_cgroup_disabled())
>  		return;
> @@ -631,10 +631,11 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
>  
>  	*min = READ_ONCE(memcg->memory.emin);
>  	*low = READ_ONCE(memcg->memory.elow);
> +	*locallow = READ_ONCE(memcg->memory.elocallow);
>  }
>  
>  void mem_cgroup_calculate_protection(struct mem_cgroup *root,
> -				     struct mem_cgroup *memcg);
> +				     struct mem_cgroup *memcg, int is_local);
>  
>  static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
>  					  struct mem_cgroup *memcg)
> @@ -651,13 +652,17 @@ static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
>  unsigned long get_cgroup_local_usage(struct mem_cgroup *memcg, bool flush);
>  
>  static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
> -					struct mem_cgroup *memcg)
> +					struct mem_cgroup *memcg, int is_local)
>  {
>  	if (mem_cgroup_unprotected(target, memcg))
>  		return false;
>  
> -	return READ_ONCE(memcg->memory.elow) >=
> -		page_counter_read(&memcg->memory);
> +	if (is_local)
> +		return READ_ONCE(memcg->memory.elocallow) >=
> +			get_cgroup_local_usage(memcg, true);
> +	else
> +		return READ_ONCE(memcg->memory.elow) >=
> +			page_counter_read(&memcg->memory);

Don't need else case here is if block returns.

>  }
>  
>  static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
> @@ -1159,13 +1164,13 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  static inline void mem_cgroup_protection(struct mem_cgroup *root,
>  					 struct mem_cgroup *memcg,
>  					 unsigned long *min,
> -					 unsigned long *low)
> +					 unsigned long *low, unsigned long *locallow)
>  {
>  	*min = *low = 0;
>  }
>  
>  static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
> -						   struct mem_cgroup *memcg)
> +						   struct mem_cgroup *memcg, int is_local)
>  {
>  }
>  
> @@ -1175,7 +1180,7 @@ static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
>  	return true;
>  }
>  static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
> -					struct mem_cgroup *memcg)
> +					struct mem_cgroup *memcg, int is_local)
>  {
>  	return false;
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d7c5fff12105..61718ba998fe 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4495,7 +4495,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
>   *          of a top-down tree iteration, not for isolated queries.
>   */
>  void mem_cgroup_calculate_protection(struct mem_cgroup *root,
> -				     struct mem_cgroup *memcg)
> +				     struct mem_cgroup *memcg, int is_local)
>  {
>  	bool recursive_protection =
>  		cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT;
> @@ -4507,7 +4507,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  		root = root_mem_cgroup;
>  
>  	page_counter_calculate_protection(&root->memory, &memcg->memory,
> -					recursive_protection, false);
> +					recursive_protection, is_local);
>  }
>  
>  static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ce471d686a88..a2681d52fc5f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2377,6 +2377,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  	enum scan_balance scan_balance;
>  	unsigned long ap, fp;
>  	enum lru_list lru;
> +	int is_local = (pgdat->node_id == 0) && root_reclaim(sc);

int should be bool to be more explicit as to what the valid values are.

Should be addressed across the patch set.

>  
>  	/* If we have no swap space, do not bother scanning anon folios. */
>  	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
> @@ -2457,12 +2458,14 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  	for_each_evictable_lru(lru) {
>  		bool file = is_file_lru(lru);
>  		unsigned long lruvec_size;
> -		unsigned long low, min;
> +		unsigned long low, min, locallow;
>  		unsigned long scan;
>  
>  		lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
>  		mem_cgroup_protection(sc->target_mem_cgroup, memcg,
> -				      &min, &low);
> +				      &min, &low, &locallow);
> +		if (is_local)
> +			low = locallow;
>  
>  		if (min || low) {
>  			/*
> @@ -2494,7 +2497,12 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  			 * again by how much of the total memory used is under
>  			 * hard protection.
>  			 */
> -			unsigned long cgroup_size = mem_cgroup_size(memcg);
> +			unsigned long cgroup_size;
> +
> +			if (is_local)
> +				cgroup_size = get_cgroup_local_usage(memcg, true);
> +			else
> +				cgroup_size = mem_cgroup_size(memcg);
>  			unsigned long protection;
>  
>  			/* memory.low scaling, make sure we retry before OOM */
> @@ -5869,6 +5877,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  	};
>  	struct mem_cgroup_reclaim_cookie *partial = &reclaim;
>  	struct mem_cgroup *memcg;
> +	int is_local = (pgdat->node_id == 0) && root_reclaim(sc);
>  
>  	/*
>  	 * In most cases, direct reclaimers can do partial walks
> @@ -5896,7 +5905,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  		 */
>  		cond_resched();
>  
> -		mem_cgroup_calculate_protection(target_memcg, memcg);
> +		mem_cgroup_calculate_protection(target_memcg, memcg, is_local);
>  
>  		if (mem_cgroup_below_min(target_memcg, memcg)) {
>  			/*
> @@ -5904,7 +5913,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  			 * If there is no reclaimable memory, OOM.
>  			 */
>  			continue;
> -		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
> +		} else if (mem_cgroup_below_low(target_memcg, memcg, is_local)) {
>  			/*
>  			 * Soft protection.
>  			 * Respect the protection only as long as
> -- 
> 2.43.0
> 

