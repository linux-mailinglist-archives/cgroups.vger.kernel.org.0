Return-Path: <cgroups+bounces-5330-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD309B61F0
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 12:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7FE1F2491B
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B831E4929;
	Wed, 30 Oct 2024 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XjLDP5HO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296021E4937
	for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288130; cv=none; b=RwiY0sjsTxIgxYTWFdl8dQCCATyf1ip/jkjrXOG7lEcdf1Si15ykj1Of+lylyuCoExI7kYy3NG5NfK5H6AbBZ0/cVI9y4Lk3HfX2wmx+FDW+TOMZ8tglAJvQwjnn/kcTDJDWOfTCUjEPrVJStuWRIk+Ko7+Pzp74+6Ih5mWztVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288130; c=relaxed/simple;
	bh=1fyz08x/Kfb96WrpapF+TWctlqmSXy+pjOmTfAbWKgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVxrGaA63y3V5YmcKLi54ODMzhnYcMgva3I+CJMXM3nKwCFs+27vkPH6PKWLhfxUusH4vwThs0jllcTkdTt2tdZP7Y7cRPotYjfePdETo0s2TvuzO+Q6tjBi6Q8sE4zVaUyw4jjPdFgfj4WEbYrFYRTn2L/USQDI0gPyij+dPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XjLDP5HO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso7491375a12.3
        for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 04:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730288126; x=1730892926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6sR+aml3UxyTUx7NT7wVuDjaBfNaFGGHSlzNTNXs/8=;
        b=XjLDP5HONNG9cLow71h+Nn5VS6utY8Am4mjYDywzDczSXwtXh+0NjqpmbZA3+C7CkB
         FMLJEDMtZHaIATi+yL7Mq3+LkTSsFOHiNHkNrwBnJtgzJq7zFIqq9S/LX+QaXHumatc5
         arebOkkiAq0KlGi2btCjpsCfJSHtBrTzUpjycGvrCbgAnywxsY5VM1San14DYXVmhO6O
         fbEJzG0X0p9Tk2SMZpUqpXhx4tQ9EJ9ZBX16pzBK1mjrdMRO+yiq4FzaewL1+NMLqew3
         v0SXlYt3T8b5WNB7R+8ostMEy0knf3PgskyatvCdjhr0yUdXIhPuXyXOA99Ixy2Lcsjg
         NRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288126; x=1730892926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6sR+aml3UxyTUx7NT7wVuDjaBfNaFGGHSlzNTNXs/8=;
        b=uN6jRPpYl+qXEdAIMkJSaapL0CG9Cvrz0lJcGAz0MDX7YG+dot4syIuAC+0fAIbeYJ
         P1atbVT48JSh1LA4gXY3enGjoQ0cjVJON+tQ6+pwMROcMs3ajf/r92j5NkaUweZ5hCF4
         n9NRaHRLIzLTZzONHOv1wq/Rj+KQpJGyfWnKhdrrpLid1WqLD61+fklX74tetfC/VifK
         Grm1ashyyz7QQk3e7yYxwazJOUSg0FJ6CJUnIHs9qQ+1mfmLb6HpngFub7AMgNComGDs
         UpQWAMpfP2bW0mcL0mejqhN6D6zOjocTWvnT4tm1KR47fDWFdFqBiEEkf59dL3jy84UX
         gfUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUumBimZCo4YcprqtF1MCcjAQfyp7IB9FC35QqP8s8qE3sZfO69T08vDTjvAjgR+h7KzfvcRW3j@vger.kernel.org
X-Gm-Message-State: AOJu0YyXr785P+RW0g/P5Lds1ulJug904CfB4AsnlRBHvUGPn3JVKYs9
	xNpSa8GPIjGfvcjRuLiKiGraMuw6wDeJATOWdaiRdutUc/n7pYNud/XNP/DKXwo=
X-Google-Smtp-Source: AGHT+IF1UTGG2OAepUDBUpyfkcQLgws5vfUoxVF55Jzoc7e5WgTf3wnHDi9okD0LZFzSuEMoKEAu+w==
X-Received: by 2002:a17:906:f597:b0:a99:ebcc:bfbe with SMTP id a640c23a62f3a-a9de5d992f1mr1459936866b.27.1730288126292;
        Wed, 30 Oct 2024 04:35:26 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f298319sm556719966b.105.2024.10.30.04.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:35:26 -0700 (PDT)
Date: Wed, 30 Oct 2024 12:35:25 +0100
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, shakeel.butt@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	lizefan.x@bytedance.com, mkoutny@suse.com, corbet@lwn.net,
	lnyng@meta.com, akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <ZyIZ_Sq9D_v5v43l@tiehlicka>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>

On Mon 28-10-24 14:05:05, Joshua Hahn wrote:
[...]
> Changelog
> v3:
>   * Removed check for whether CGRP_ROOT_HUGETLB_ACCOUNTING is on, since
>     this check is already handled by lruvec_stat_mod (and doing the
>     check in hugetlb.c actually breaks the build if MEMCG is not
>     enabled.
[...]
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 190fa05635f4..fbb10e52d7ea 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1925,6 +1925,7 @@ void free_huge_folio(struct folio *folio)
>  				     pages_per_huge_page(h), folio);
>  	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
>  					  pages_per_huge_page(h), folio);
> +	lruvec_stat_mod_folio(folio, NR_HUGETLB, -pages_per_huge_page(h));
>  	mem_cgroup_uncharge(folio);
>  	if (restore_reserve)
>  		h->resv_huge_pages++;
> @@ -3093,6 +3094,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  
>  	if (!memcg_charge_ret)
>  		mem_cgroup_commit_charge(folio, memcg);
> +	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
>  	mem_cgroup_put(memcg);
>  
>  	return folio;

I do not see any specific checks for CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING
in these paths. I guess you wanted to say that you rely on
mem_cgroup_commit_charge setting memcg pointer which then __lruvec_stat_mod_folio
relies on when updating stats.

I suspect this all is done because you want a global counter to be
updated as well, right? Changelog doesn't say anything about that
though. Why is this needed when /proc/meminfo already describes the
global hugetlb usage?
-- 
Michal Hocko
SUSE Labs

