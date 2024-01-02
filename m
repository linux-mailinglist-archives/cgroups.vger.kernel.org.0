Return-Path: <cgroups+bounces-1052-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD33822087
	for <lists+cgroups@lfdr.de>; Tue,  2 Jan 2024 18:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E531B1C2236F
	for <lists+cgroups@lfdr.de>; Tue,  2 Jan 2024 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9C2156C3;
	Tue,  2 Jan 2024 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOiN84Ux"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F185156C6;
	Tue,  2 Jan 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3ba14203a34so9435014b6e.1;
        Tue, 02 Jan 2024 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704217432; x=1704822232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFAXfoSqedernbiWEjd/3knzaFCGGb+zuLCr9vWqgk4=;
        b=VOiN84UxslOPnST1uF8yuuaZMaZY0rUIIYnQeqsSglW96kxtLiZO0eos081mZc4gUr
         QZtvusJYn81jE7Qh2ytWaM+A1qPoNKdGOK9xO5bcPYVH0jE279entbrA9zltayxa40/e
         dtLzKy9A8ZcPMy0SE3Lek8kZLQhBTBPI2mWH3UlYr7jq7scYY39id07xhkoS6GuY0D0h
         qaBiBIFJBTRWZqvzWKmnQwMPx5mlqSJMAjXUnNzXHLVNqT14Pp7SIWLoEisxfyZlZ3AA
         r9jbHMguaHJ5r4/V+rqdgvx+rLsxyDtKZmu/IV0PPbyXH3A7HK5fvwfjYcre2DTMBTVr
         ZXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704217432; x=1704822232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFAXfoSqedernbiWEjd/3knzaFCGGb+zuLCr9vWqgk4=;
        b=CpGcU+QsGC+f4afZU2G+Ng/om1PLb1v7C0N1Fbjyr6OPkZ9JulURAWoiJ60Fy4+GHB
         rvwDyYfGfSRTniKREAIB6+mUooxc5bn6MWgn5sIznHtVMnYPbSETBAzobhrWtmQE/APl
         kAgSRcnKmw1HKa0Gj1PkY719Bzh1riiF8oiByy/Cd9+iC0Wb5k6oxGhxfQ42oyV7NS4Q
         21PLxnFG5XUvtY6UPzx/2n21/VO6UTLg2+sMRZXHFpsNw4UNtjM5B9q4bd485Hr3dZ2E
         hyLdWycVx7lqxUnksGXOG68O2agHC8K6APaSuxAmf/2nJJ9gPULFW/nPDOChj93Hv2uq
         2r8Q==
X-Gm-Message-State: AOJu0YwcXIPrt8vzAdaxrE6zoPV6lU0xTDbPcsf/3y9xMzuMg5Evqkhs
	2/I5nryDEDxRpir8KcGDPWkMfD9jrBgP5A==
X-Google-Smtp-Source: AGHT+IHl/019xddMgz9dzwdw//SCPvoCIFqs7YXU8Oot7eKHFac5tM8u9C/Ua4cEkhMMQP3o/7gPlg==
X-Received: by 2002:a05:6808:3c4d:b0:3bb:cdd5:17c4 with SMTP id gl13-20020a0568083c4d00b003bbcdd517c4mr15552274oib.83.1704217432358;
        Tue, 02 Jan 2024 09:43:52 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:7ce3])
        by smtp.gmail.com with ESMTPSA id dm6-20020ad44e26000000b0067f6ec98ae9sm10239578qvb.32.2024.01.02.09.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 09:43:51 -0800 (PST)
Date: Tue, 2 Jan 2024 12:43:49 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Nhat Pham <nphamcs@gmail.com>, Yue Zhao <findns94@gmail.com>
Subject: Re: [PATCH v5 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZZRLVYeTjljn0dO5@dschatzberg-fedora-PF3DHTBV>
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com>
 <20231220152653.3273778-3-schatzberg.dan@gmail.com>
 <ZYQFlynE7CU_Fjoc@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYQFlynE7CU_Fjoc@tiehlicka>

On Thu, Dec 21, 2023 at 10:29:59AM +0100, Michal Hocko wrote:
> On Wed 20-12-23 07:26:51, Dan Schatzberg wrote:
> >  ...
> 
> LGTM
> Acked-by: Michal Hocko <mhocko@suse.com.
> 
> Just one minor thing. It would be really great to prevent from potential
> incorrect use of mem_cgroup_swappiness. This should be internal function
> to memcg. Now, having scan_control internal to vmscan.c makes that
> harder and moving it out to swap.h or internal.h sounds overreaching.
> 
> We could do this at least to reduce those mistakes. I can make it a
> proper patch if this seems reasonable or you can fold it into your patch
> directly.
> --- 
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f98dff23b758..5f3a182e9515 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -92,8 +92,10 @@ struct scan_control {
>  	unsigned long	anon_cost;
>  	unsigned long	file_cost;
>  
> -	/* Swappiness value for reclaim. NULL will fall back to per-memcg/global value */
> +#ifdef CONFIG_MEMCG
> +	/* Swappiness value for reclaim. Always use sc_swappiness()! */
>  	int *swappiness;
> +#endif
>  
>  	/* Can active folios be deactivated as part of reclaim? */
>  #define DEACTIVATE_ANON 1
> @@ -230,6 +232,13 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  #endif
>  	return false;
>  }
> +
> +static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
> +{
> +	if (sc->swappiness)
> +		return *sc->swappiness;
> +	return mem_cgroup_swappiness(memcg);
> +}
>  #else
>  static bool cgroup_reclaim(struct scan_control *sc)
>  {
> @@ -245,6 +254,10 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  {
>  	return true;
>  }
> +static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
> +{
> +	return READ_ONCE(vm_swappiness);
> +}
>  #endif
>  
>  static void set_task_reclaim_state(struct task_struct *task,
> @@ -2330,8 +2343,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>  	unsigned long anon_cost, file_cost, total_cost;
> -	int swappiness = sc->swappiness ?
> -		*sc->swappiness : mem_cgroup_swappiness(memcg);
> +	int swappiness = sc_swappiness(sc, memcg);
>  	u64 fraction[ANON_AND_FILE];
>  	u64 denominator = 0;	/* gcc */
>  	enum scan_balance scan_balance;
> @@ -2612,10 +2624,7 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
>  	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
>  		return 0;
>  
> -	if (sc->swappiness)
> -		return *sc->swappiness;
> -
> -	return mem_cgroup_swappiness(memcg);
> +	return sc_swappiness(sc, memcg);
>  }
>  
>  static int get_nr_gens(struct lruvec *lruvec, int type)
> -- 
> Michal Hocko
> SUSE Labs

Thanks for the review Michal and sorry for the delayed response. Your
patch looks reasonable to me but I'm a bit unclear about the need for
#ifdef - mem_cgroup_swappiness already works correctly regardless of
CONFIG_MEMCG or not - why not make sc->swappiness and sc_swappiness()
unconditional?

Happy to roll that into the next version of my patch.

