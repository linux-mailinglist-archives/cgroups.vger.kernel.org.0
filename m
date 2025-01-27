Return-Path: <cgroups+bounces-6334-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A362A1D634
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 13:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB633A5876
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 12:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2251FF1B3;
	Mon, 27 Jan 2025 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BKwXw1Rw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D31FC7ED
	for <cgroups@vger.kernel.org>; Mon, 27 Jan 2025 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737982249; cv=none; b=DQEov9woyMpIZETEO5KcMGkTzUnGwDs4xQeoUslzDobd9LI/MYJSfmVVY6f1DHxdcU6nSvPzska9aRYCLHK/gKTlGZTh31Kp7YqtKnkkbQsLEOEH9gt+eqSfkuZ6fjwRfHPmYld+E6kKvZH8k9XYP0l1lhf5uRQ4SlK2Nzx9vfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737982249; c=relaxed/simple;
	bh=1gijTm2RblYI3PvZLu5b4Q0RhEui4jiwLCNdQhlvU/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7UGlPjM8lIMqvwZZVfQhoSoLKK/cjOu7wafpk3u/8V40+7LPXbK0+noh5Mv0iqfk7jXM3oJYT/DN0Ah1mSPLCJGnQR6cPYU5OY2pfV7yC54eL4hPkjy8gGwveOw1AxUSXSg6eyzmQ7RZB0aZQR+SGjIJEHP7JVWoplOGa5lk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BKwXw1Rw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso28465255e9.0
        for <cgroups@vger.kernel.org>; Mon, 27 Jan 2025 04:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737982246; x=1738587046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cokFZPoIQmX9RBxxgHEXC/b+MepK83mN2x94MEbPICU=;
        b=BKwXw1RwLdNZAY3p6kkDhfpUc3WqXZKQAvYeK7FRmdxwd2TBJv4PD6yyROojUcmN/q
         cw/iBGMrIWukVkt8ecdPY1I0Cuh3VKH+ny3f9+3Dxk2fmQ/f83thw5wYvPc5M+sewCDH
         rDtsMXLDGxlRyLmkeLzsZrIKpyUqykzWM0gXWplg9hCb1OhNo8Ng+3hgkIqP4V33aied
         uV3U5YKXjn9qJ/Mho+BSr54+pUZ2x+S6AV+ijAGfwatjeD3uIdB+lAc3ZObL8dKkVHXo
         ndw+lH2sHA1/wz3FWNRAhQnMcv1bEXmygQmFkU1w+k0cMoLfljfCPOzUzy0horzLj2zV
         x17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737982246; x=1738587046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cokFZPoIQmX9RBxxgHEXC/b+MepK83mN2x94MEbPICU=;
        b=qv0CgAPeeIA1+Bm1aie33lbzybY2C9RLiv1PbHf0YWEC0OyDLAKT76SDbPCXzZa0Ba
         fMdf61FsvECFL9Wf0cqLqW8/xDbaqgga6D7+pfkjasgOyMbrXjXKbxggTxlqsU2M3xAf
         ++hAELWvTSm84CFwnmh/XfJ7jkXcHtB6NxAT2P4wd53lGcgT99FqkWMKfpVVMXnWLovX
         Ive8ccvqIh5g0GlAM7Q8vkQjar4zZ4gIrSrKBZNo+0yA+8gSFTyD5tvAyhWGxbXdNrGR
         gSO5SRd9GoIPRD8vYzMbppvLtbvWLUNeJQWdPOQUdIuUecUF6fwWxigqGS4k6/3qnsrN
         S/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoildtwwVJ1cCabL4go+1uKu9+jRNQGNL6gfw5K98X0XRWTN2CfTDMg2/Yn3TmofpZCHlrnRsw@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2vC9Z+aI8SLSHrHcnlnKA2j0keOlSE8izsm4ZIYgwdqhE8tP
	6ok4W0roMBHUJUzAxpHS0VsjTu1PnIgFa/ZSpfgHHDE2JNnwT8qrg06U6CaKo0c=
X-Gm-Gg: ASbGnctALxxt6CHhzUD+y3u6B6GqBSFPB9YcBPUlij+DqRZss6/9/fushsg1eJMKVzc
	ahdDsiwhXZx4gUHipS6PyCzPpCAS06uHlAhR4+soRFq1OoPt67JF0n/pcTs6RqrYrtX5s1MtrAP
	JEi/zxUmtcAevM0bgS0lyjCS/Yw8X8bJyjLVMyhraIrcoTHBYmQgHEqpsv7VE8WguOyzXzk4LBs
	GlIid23rkgTsv4KAh4pnBIMInRJQ5hnMxnOoNehO/itCYkks6KRt/rAZWIf7MvJfXlqW/KhD+dE
	stNwlzt5TGcxBQo=
X-Google-Smtp-Source: AGHT+IEsomHPSy4KNCMWfxo6O3PT1jcbenn9lQBeEG79bYkvI1dUoL17Y07xyLnwhpkYqu+7hMebow==
X-Received: by 2002:a05:600c:28c:b0:436:5fc9:309d with SMTP id 5b1f17b1804b1-4389ec8a8d0mr395834775e9.30.1737982246230;
        Mon, 27 Jan 2025 04:50:46 -0800 (PST)
Received: from localhost (109-81-84-37.rct.o2.cz. [109.81.84.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd50184dsm129003935e9.10.2025.01.27.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 04:50:45 -0800 (PST)
Date: Mon, 27 Jan 2025 13:50:44 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: memcontrol: unshare v2-only charge API bits again
Message-ID: <Z5eBJIF0SPDLaeGg@tiehlicka>
References: <20250124043859.18808-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124043859.18808-1-hannes@cmpxchg.org>

On Thu 23-01-25 23:38:58, Johannes Weiner wrote:
> 6b611388b626 ("memcg-v1: remove charge move code") removed the
> remaining v1 callers.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol-v1.h | 15 ---------------
>  mm/memcontrol.c    | 17 +++++++++++++----
>  2 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 144d71b65907..6dd7eaf96856 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -7,21 +7,6 @@
>  
>  /* Cgroup v1 and v2 common declarations */
>  
> -int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> -		     unsigned int nr_pages);
> -
> -static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> -			     unsigned int nr_pages)
> -{
> -	if (mem_cgroup_is_root(memcg))
> -		return 0;
> -
> -	return try_charge_memcg(memcg, gfp_mask, nr_pages);
> -}
> -
> -void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
> -void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
> -
>  /*
>   * Iteration constructs for visiting all cgroups (under a tree).  If
>   * loops are exited prematurely (break), mem_cgroup_iter_break() must
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 46f8b372d212..818143b81760 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2198,8 +2198,8 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
>  	css_put(&memcg->css);
>  }
>  
> -int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> -		     unsigned int nr_pages)
> +static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> +			    unsigned int nr_pages)
>  {
>  	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
>  	int nr_retries = MAX_RECLAIM_RETRIES;
> @@ -2388,6 +2388,15 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	return 0;
>  }
>  
> +static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> +			     unsigned int nr_pages)
> +{
> +	if (mem_cgroup_is_root(memcg))
> +		return 0;
> +
> +	return try_charge_memcg(memcg, gfp_mask, nr_pages);
> +}
> +
>  static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  {
>  	VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
> @@ -3368,13 +3377,13 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>  	}
>  }
>  
> -void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
> +static void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
>  					   unsigned int n)
>  {
>  	refcount_add(n, &memcg->id.ref);
>  }
>  
> -void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
> +static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
>  {
>  	if (refcount_sub_and_test(n, &memcg->id.ref)) {
>  		mem_cgroup_id_remove(memcg);
> -- 
> 2.48.1

-- 
Michal Hocko
SUSE Labs

