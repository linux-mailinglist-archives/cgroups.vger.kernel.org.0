Return-Path: <cgroups+bounces-3349-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815A3915FA9
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 09:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F9E1C20890
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 07:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22563146A90;
	Tue, 25 Jun 2024 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I+c8YUrX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDB1405F8
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299329; cv=none; b=nwm21DiQDEw2uJ8RtMJEVIYPiAKX4VZP+Gi6iBWLUlatFS+pLahZfMPXO7bKa/aRldjRTwrR3q1DMXmGob1CxZ7N2k7ERziFvW3seVYG+kyRpDgxXxk3ELPoXqTehfn6lnYC44jijaxfsQ/tEcqIKsJ2ngNA06S8I0PlElI3E5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299329; c=relaxed/simple;
	bh=UJc21I2DOwpj9Mc15e/sDLMl/Qc/3Jobi7RBfu/CvGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAhbzxEoPAWcetF60QONoJXhiiIswB/IFJB492yN13kQukQ0MAt5rkeLVCCfWFEDVYV9fuSZgQR8+nymfVTYb17L+UDZr0iNegYDNDjkiT8WewfHPyUgF0OWogB5cKQr/bL3gUhuxJZy4QbNwEAmuJjHNktIbpZaFb83rQdCXvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I+c8YUrX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57cc30eaf0aso3027317a12.2
        for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299326; x=1719904126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/r8Fui7XgizOYipYXhnp7Nwq9UOlmXXqKU464DYZ+I=;
        b=I+c8YUrXUDiZSgbZGSkJ8yX94R5Vmr/yz+D92yEfah3O05kogUZfD1rPOvhjLvkWBM
         sBzHqco1Xvqx7VxrsKmFNCBsRsdLJnqqxDe9yS+/Si3conOdf6ChAnwFh5Q3v+ZQRpVH
         04VImm1A/3/laCzJh711FA88jxXePrYDZmQToJMxiIRMK78WLRF2oTQO00OxFK458ldU
         9kC1eZDqFesApJa3B8BGxrTw0U+xAR6x5JKvoFJVuIgKH63s59a3HNVe1dnaThYaVx0N
         nd1wkyhr+i/h8x3QMGJbK1lxz+HjvJaZldsh3PnpmXz/36bZJaxiA3dzGj3pOw4HU/OZ
         sqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299326; x=1719904126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/r8Fui7XgizOYipYXhnp7Nwq9UOlmXXqKU464DYZ+I=;
        b=mdTvUPMm5UI4DXI1+iXNZZJ4tWHuKkr9B3rl96KvedFMjYF5GyTh99PKD7YWQJ6UMO
         iiAD7wYgLcqXhzCcjx74LvhdRQlDhFEQeF/7ZFIpRxDe2txmuGf0aU0zwMcWKMhPMojD
         tMWCyIkfROwtl1B9qx2f9U29nEBvxGUNKLM/1cGmwTl9UZPGZoAqdamChA3pyByZGMXN
         k/PPArQEAP1NzjbR0/m/mb1SFlMS0Ct7e4QbnjV1eekPsTTRb+xblns9SGNte1MyQPdA
         CxeowP8li2FEb2zOuM5YvLNwPuUTkfWv8lg9cN9SqNThJ60BRHYSHXQehn3i0uXVN0GN
         W69g==
X-Forwarded-Encrypted: i=1; AJvYcCUImL2YZ9v08KCQyUy5emLicBybfJK8NziwQtUwgNPIW1GRAtEnyulBLSqIWHLL55/zQuajH+M82vJ0X5nRY6XggPgRXjgZHQ==
X-Gm-Message-State: AOJu0Yx/MJQJqzanr6qNZ0ZCqsXuk4YOs6LKGOiieWPqDFVwaEWfwAGM
	3bhiw0YQ330fZ03BcJhFS0OcgBku/MjTq+6AumpcBqnFgkMk4oTC0nMse7V3OW0=
X-Google-Smtp-Source: AGHT+IH9BIEIK9v/StFIWF0TDQwnIYeHsAbrGB05TNVA/FWNDxYSlTGuWTk+xbxhEgb5v1SiTtfZeA==
X-Received: by 2002:a50:a6d8:0:b0:57c:fd20:352d with SMTP id 4fb4d7f45d1cf-57d4bde08cdmr5885682a12.36.1719299326146;
        Tue, 25 Jun 2024 00:08:46 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30562cabsm5500971a12.81.2024.06.25.00.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:08:45 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:08:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 09/14] mm: memcg: rename memcg_oom_recover()
Message-ID: <Znps_epDGtylLgEc@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-10-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-10-roman.gushchin@linux.dev>

On Mon 24-06-24 17:59:01, Roman Gushchin wrote:
> Rename memcg_oom_recover() into memcg1_oom_recover() for consistency
> with other memory cgroup v1-related functions.
> 
> Move the declaration in mm/memcontrol-v1.h to be nearby other
> memcg v1 oom handling functions.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol-v1.c | 6 +++---
>  mm/memcontrol-v1.h | 2 +-
>  mm/memcontrol.c    | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 253d49d5fb12..1d5608ee1606 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1090,8 +1090,8 @@ static void __mem_cgroup_clear_mc(void)
>  
>  		mc.moved_swap = 0;
>  	}
> -	memcg_oom_recover(from);
> -	memcg_oom_recover(to);
> +	memcg1_oom_recover(from);
> +	memcg1_oom_recover(to);
>  	wake_up_all(&mc.waitq);
>  }
>  
> @@ -2067,7 +2067,7 @@ static int memcg_oom_wake_function(wait_queue_entry_t *wait,
>  	return autoremove_wake_function(wait, mode, sync, arg);
>  }
>  
> -void memcg_oom_recover(struct mem_cgroup *memcg)
> +void memcg1_oom_recover(struct mem_cgroup *memcg)
>  {
>  	/*
>  	 * For the following lockless ->under_oom test, the only required
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 3de956b2422f..972c493a8ae3 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -13,7 +13,6 @@ static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
>  
>  void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
>  void memcg1_check_events(struct mem_cgroup *memcg, int nid);
> -void memcg_oom_recover(struct mem_cgroup *memcg);
>  int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		     unsigned int nr_pages);
>  
> @@ -92,5 +91,6 @@ ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  
>  bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
>  void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
> +void memcg1_oom_recover(struct mem_cgroup *memcg);
>  
>  #endif	/* __MM_MEMCONTROL_V1_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8abd364ac837..37e0af5b26f3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3167,7 +3167,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>  	} while (true);
>  
>  	if (!ret && enlarge)
> -		memcg_oom_recover(memcg);
> +		memcg1_oom_recover(memcg);
>  
>  	return ret;
>  }
> @@ -3752,7 +3752,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
>  
>  	WRITE_ONCE(memcg->oom_kill_disable, val);
>  	if (!val)
> -		memcg_oom_recover(memcg);
> +		memcg1_oom_recover(memcg);
>  
>  	return 0;
>  }
> @@ -5479,7 +5479,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
>  		if (ug->nr_kmem)
>  			memcg_account_kmem(ug->memcg, -ug->nr_kmem);
> -		memcg_oom_recover(ug->memcg);
> +		memcg1_oom_recover(ug->memcg);
>  	}
>  
>  	local_irq_save(flags);
> -- 
> 2.45.2
> 

-- 
Michal Hocko
SUSE Labs

