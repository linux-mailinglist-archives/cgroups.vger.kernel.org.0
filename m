Return-Path: <cgroups+bounces-7033-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0015DA5ED0E
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 08:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659443B7850
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521525F96F;
	Thu, 13 Mar 2025 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gxUvWowm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831A25EFB2
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851234; cv=none; b=ufGaHdcnnAWWghrb/oCJG9dOWOuF1SUQq8lKN0+MccS234ANgzvEzT6SMvNgupl7KJDuVqwFeYUC/GkeEMBHPV5Op9OtqUD3TAIXRH4xYQ7mnRRwquGNnCvmvN9P7CC0vdrP3E44gzd23vm+TSmlTL/NboqYC6HU6W2QAOAHh2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851234; c=relaxed/simple;
	bh=vObYQsP7GkP0nRI6tEymGrq2o97DTg5Y6+GNPwRsdtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/doi+u1Ekpujo3nNQ3VCvaHQYo8RpYMMGSwppIYTA7KO4FFLLVJ8unMa3H77VrQzrhPr+ysBDPJtpXji1QHUjFzclrNe2qary8o9P+cXQwdhZ2xuPPoDXe/0FPJ9aoqoLvpH7XipiE23MLUTCEHbSBVtpCaRqewmvwdomD5ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gxUvWowm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso3580355e9.0
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741851230; x=1742456030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5iry1yvg4WZMN2YDV1CqlFA/zutLhrsd/H0iQw/Ekw8=;
        b=gxUvWowmNw39FShfhyabCKU2MPKLt4p2HBmhYto7uxFo/YbQeLmBhtAuMerrJp/Ia4
         fh4ccI/kd3/Q8uXz2XF3gYdHvx4u7p5IiUHdIhOtJkhT6Z9DVIYOXpsOn6xjSF2u1sKk
         6eIPWivrrDDjJidUGHA58KiX5bb1e6jOkowtJOlT1Tw4TsdLqi6uX/iYTMK+e6gaaD4J
         Z5cDv90Y4Hmq5UqwP8vTbzs2DCg6rUkNJji6LA8d6anJ4v+7cMXuTH4PR1UVfEOGzYQF
         ieKf2eDahvMzK3eg3WM4now7g+xW4gFVqBgFGrTdrgoHgXs0q04GUNh3cIsQQ7ZEvmdM
         dmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741851230; x=1742456030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iry1yvg4WZMN2YDV1CqlFA/zutLhrsd/H0iQw/Ekw8=;
        b=t33aoGyySCbEhPopOHTN+UeckVhB61KpWTjsWqppC8VWMD50wdxj2LUSZDJYPFbqQx
         P8yCJhUSs0aG+wtwc14iMY2HxIqWbzrxs2BtwdIblWWCgT+LL3WuhPrBRhHrPuG3VQQy
         nn+Pma4+OfoDL+wrNBWogYrYUwaY7YBSRDgVQ/FXSU3DteQyr22ysqwjfSgIBEfShy2L
         W2eewHJ2SYZVIkE5GYiR6ZsP6brYWjJHq1c9W+9MkzH1b6zzmLA8Pislda/oBBzpnGDt
         4iBbwMhlrijpIzsI2e0kyKFN6yjqdS5Kiw/uUAuPmAh6oQSdmGINKS8qO3XO5HLhp65Z
         30aA==
X-Forwarded-Encrypted: i=1; AJvYcCXfvEOoUsNZQA4u/AhdCmGoBXM9BHL0ZAx4zUSUc4aDoSBfLwr4eGpkQ528gsmTNXBwsxdFOVuA@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhcBofRDnGZf6kg0j6i1KExsETPB1az5nX80VzFY1XCsHEPhl
	T3kWBq9ZCB2ThCv1kysSXOGM24mtVv4cbN6kw+o5bT3GusM5YuGBUynKMCuuwNs=
X-Gm-Gg: ASbGnctjJCgkJ1R785gRUzdCVPnqHqUi/BCDM8oKuH7Sk5Rb/cxuD71tuLUYllN57tg
	cIIbblwEYF4CgktrnRhBj+FalrNTjZAEEjIKDZF94Ga1Va5/oZoeiUsQyrVBFtLV67TnEW/OdjB
	Oac+TabNLb8b+lXLQjvpNxoDJm4ql/sgOEZpz+dGNg0ysQYQ8kaTZz49wWMtWPLGmx5LSwK7aon
	dsGKYtT9v2X5pwxgdtF/mQ0GKuDOLEuXwjSW4liFqPFDbSVcCnF0pt3/1jzCF1SX14mEIRx2jk4
	RDsyWPES+Q797YY1gXnfCXKh6YRVAykN9Kf4hmjEL08FlTzrP6wwumRMBw==
X-Google-Smtp-Source: AGHT+IGqSdtxUzy4WVCEjGF5SMHyXXXJMyFQAnCcaO8h0IsRnJgjQQ/oyOP70bQSW5L64iW4bCi0rA==
X-Received: by 2002:a05:600c:3512:b0:43c:fded:9654 with SMTP id 5b1f17b1804b1-43cfded98b3mr105776725e9.19.1741851230496;
        Thu, 13 Mar 2025 00:33:50 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d0a731031sm45483895e9.7.2025.03.13.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:33:50 -0700 (PDT)
Date: Thu, 13 Mar 2025 08:33:48 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: move do_memsw_account() to CONFIG_MEMCG_V1
Message-ID: <Z9KKXF-CSYuGKSXW@tiehlicka>
References: <20250312222552.3284173-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312222552.3284173-1-shakeel.butt@linux.dev>

On Wed 12-03-25 15:25:52, Shakeel Butt wrote:
> The do_memsw_account() is used to enable or disable legacy memory+swap
> accounting in memory cgroup. However with disabled CONFIG_MEMCG_V1, we
> don't need to keep checking it. So, let's always return false for
> !CONFIG_MEMCG_V1 configs.
> 
> Before the patch:
> 
> $ size mm/memcontrol.o
>    text    data     bss     dec     hex filename
>   49928   10736    4172   64836    fd44 mm/memcontrol.o
> 
> After the patch:
> 
> $ size mm/memcontrol.o
>    text    data     bss     dec     hex filename
>   49430   10480    4172   64082    fa52 mm/memcontrol.o
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/memcontrol-v1.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 653ff1bad244..6358464bb416 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -22,12 +22,6 @@
>  	     iter != NULL;				\
>  	     iter = mem_cgroup_iter(NULL, iter, NULL))
>  
> -/* Whether legacy memory+swap accounting is active */
> -static inline bool do_memsw_account(void)
> -{
> -	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
> -}
> -
>  unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
>  
>  void drain_all_stock(struct mem_cgroup *root_memcg);
> @@ -42,6 +36,12 @@ struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
>  /* Cgroup v1-specific declarations */
>  #ifdef CONFIG_MEMCG_V1
>  
> +/* Whether legacy memory+swap accounting is active */
> +static inline bool do_memsw_account(void)
> +{
> +	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
> +}
> +
>  unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
>  unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx);
>  unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
> @@ -94,6 +94,7 @@ extern struct cftype mem_cgroup_legacy_files[];
>  
>  #else	/* CONFIG_MEMCG_V1 */
>  
> +static inline bool do_memsw_account(void) { return false; }
>  static inline bool memcg1_alloc_events(struct mem_cgroup *memcg) { return true; }
>  static inline void memcg1_free_events(struct mem_cgroup *memcg) {}
>  
> -- 
> 2.47.1

-- 
Michal Hocko
SUSE Labs

