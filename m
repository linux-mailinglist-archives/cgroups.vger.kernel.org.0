Return-Path: <cgroups+bounces-11452-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE77C23D1D
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 09:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A168C18926ED
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 08:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6162BE646;
	Fri, 31 Oct 2025 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WoyDtMBu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9668E22172E
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899560; cv=none; b=tqTgcmNbLxVZwCZFXPjMY0H7Mcw/G+vwoRBpr9N4kqQOi7qrgMEKBotauYEKD38lh2CLcpYXX7WO+JwkdBKAI2VflhthOcRCjyh1dkGaVkriPA1kyrHo5AYCf0m1Z4rkWySuIC4DUPjEwoCt33d8L0Vzezx2VwZWgHuxIAAD2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899560; c=relaxed/simple;
	bh=3j8afmSJ7Nmsi16sNeqRifyt/WmVa4gl82NY0GZWAqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXkrfHsqUF7jvqEdWbEDpw4e6t6IANo/xgulyK8Ie2Gzlrvo66vVkdUL788r292IIi3HzgpkyJ72F3VfImUpin11F7Bz/VSiTcrUUCWcTOhV4fbPW4yF8YXHMKwDU4dizPO5vGiPmBzagXOYEGI9gNE2shaEWYYhjuEoAzHwLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WoyDtMBu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47117f92e32so16543635e9.1
        for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761899557; x=1762504357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4h4q0wa7BdASeLKkAa33sOr+LqpNtBVUob6S/qE5mOw=;
        b=WoyDtMBuNhhFFznEpNIVqcF2X8Widy/OoxXlAPNS9tf4RR1UCNUREksKORQRI6yHHa
         Z0XjnXYYxmTep6USUQftuXPQ3AKA3IOLtlc1K5UrfKYJzIkvcXYzVYvqvq93a/eODgSt
         fNmeJIAoydG1RoAtJAc53SELCfJzaqJDms83Z+HfMZs8ZZd06vetrDwxcnqbWlT+Bhsx
         n3qz0JDHWCbYfLpbZTghOvE2Y3XqVOtRecg0gjvV/3NGn9eMZsx9t4KywxXTkZesTyFT
         TRez8XiTcf77/jOFeVVke5YfzY7UVYW4G2kz59apMI1vXAs7kdwJzqfdC5+RzCoMOO9N
         NnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899557; x=1762504357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h4q0wa7BdASeLKkAa33sOr+LqpNtBVUob6S/qE5mOw=;
        b=u/NntIY8KYCjQMfVX1m28flcMU+2c8gIvIecnerLrASXcaiTWgJrcAhnAQ41jr8XLO
         1I5OmHH9ksLrdgtjgU5SdQ6UyULh6kWU5NrO8gYxEh0NPur8sNgCTDT1HGvcMFUoNflv
         HiW/LYBISWOnkxuw8qeEcB4Jz+tuLL7SrF/jHSs2fmdajGaEn7lb2lMqLhoTniPPjv3t
         1FHydvrVfgFOyTsrU4P0gT5cCzJFotaSiD8PBEYy+9tmNA5GAM3yZQGtz4jWPUdQJ2H0
         Rv65VVkvMCX9qFc42cXP2N9ZK0TMcZNiY4XX96WFY4man/u6JzGr311CMwQe9DNa37jF
         HXjg==
X-Forwarded-Encrypted: i=1; AJvYcCXPzywK57KMFNcB8sW1ZMyLlh3jIl04BR3+c5MJrP8UA6ugkfjedvzWisKKqKlQukxEFYudIVTG@vger.kernel.org
X-Gm-Message-State: AOJu0YyU34nDA5Vx+rfUe2pAwJiG5WMmBv9JE6ONjG7aLoh3q9jjbKMF
	0R7AiEBzfBgxm2FNy/nk5XDw1Vpzgh+Q6Y1MkAFMAVMJTuNkpN0GA6tLWXJCDdK0baY=
X-Gm-Gg: ASbGncs2LDROaQYbnFW82LMuT5i99Vh1Em3dcys+aNlrEjcfEtSh7E6lHNu8czFQCtU
	ZAEwKw2oM+Q1OUcatzXAQ7PKQBycwaygMyJe+LPm7ZllrjbUtyTOUJ6AjO2RiB7H+ovif7jJTsC
	3jRB1NyICdcHDMpjwEYKUFcaM3/jt4gUwU9vEP2yYnDjgksM9qYb5xlO1OxFM0D+rrddxH6+62p
	hga4kKIAJrjb82w6w8us+z9f2gRLLa9XFT0k9i4vbCs149TGKOWzeryYg/l6IDkUrUx5j96JmUG
	GvqoT3lbGuOi02XFa3Skt1Wi2mWjI55kUYlE3xPVIbKLRJndqXDHFuDHKyW5MXcMCRqnOQKruHG
	r328pEAr9I4c3z11qozKtxMA7emD64oOtSw/hKv8q2P1yS7XNdxf/UD673s8Xzp1kwRGInY/yRF
	a2sxhVnvA/3iTagitGgKuppqPM
X-Google-Smtp-Source: AGHT+IGfDhEwc+4540g9zxrsusq87Jw5oannsM7AsDgvzrefgTdYZ1mcnrXQoAnn7esV8SehlhvpnQ==
X-Received: by 2002:a05:600c:1f91:b0:475:daba:d03c with SMTP id 5b1f17b1804b1-477307c51d5mr21021365e9.13.1761899556870;
        Fri, 31 Oct 2025 01:32:36 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732cb7f41sm20722905e9.0.2025.10.31.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:32:36 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:32:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 04/23] mm: define mem_cgroup_get_from_ino() outside of
 CONFIG_SHRINKER_DEBUG
Message-ID: <aQR0I9B9b1VvmYl2@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-5-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-5-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:07, Roman Gushchin wrote:
> mem_cgroup_get_from_ino() can be reused by the BPF OOM implementation,
> but currently depends on CONFIG_SHRINKER_DEBUG. Remove this dependency.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 4 ++--
>  mm/memcontrol.c            | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 873e510d6f8d..9af9ae28afe7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -832,9 +832,9 @@ static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
>  {
>  	return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
>  }
> +#endif
>  
>  struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
> -#endif
>  
>  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
>  {
> @@ -1331,12 +1331,12 @@ static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
>  {
>  	return 0;
>  }
> +#endif
>  
>  static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
>  {
>  	return NULL;
>  }
> -#endif
>  
>  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4deda33625f4..5d27cd5372aa 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3618,7 +3618,6 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
>  	return xa_load(&mem_cgroup_ids, id);
>  }
>  
> -#ifdef CONFIG_SHRINKER_DEBUG
>  struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
>  {
>  	struct cgroup *cgrp;
> @@ -3639,7 +3638,6 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
>  
>  	return memcg;
>  }
> -#endif
>  
>  static void free_mem_cgroup_per_node_info(struct mem_cgroup_per_node *pn)
>  {
> -- 
> 2.51.0

-- 
Michal Hocko
SUSE Labs

