Return-Path: <cgroups+bounces-5488-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060BA9C2771
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 23:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC201F21457
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 22:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29041E1C2B;
	Fri,  8 Nov 2024 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iWtoo3Vg"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3061AA1FD
	for <cgroups@vger.kernel.org>; Fri,  8 Nov 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104477; cv=none; b=ct79RQEKwdUDIoJmOdRVuL9IaO6Cpy3NbWNdxePS5gc56zti2dCjPC3P4XZqIuAQnEyeSbSgXl8Ga22wYHGzlotJkfO+xTxCQDKwUG3QYbYcN3XAW8LNibjeaHgpN2NsFCvtBmXjvFvBs97ZAPhT113q3j/i7hdBSML42i6/5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104477; c=relaxed/simple;
	bh=W1ZiWT8LoXEaj2sAEB9yYQV+WMQK0SyaJfoj5NdD4mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sO+f0/7clIKw89DQjV8riLj1IylHilSWzsShn16fFwKaQenTN77+J9k7SKZYHU93a/xiA05JbR47NgMuGiJbkNOQGmaBnjKWKuQGc2bpj9nBOE54IuECArCU/dPY7aDUPhsfjZxYvCySywepxK5XPHtpHmjzO4QXPCuavSRffN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iWtoo3Vg; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 8 Nov 2024 14:21:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731104472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1Ptippr8U80MLfwMylqbY3GBCBNohqHFsVTsoCWnoA=;
	b=iWtoo3VgzB8fTxFnKYWHljRWnkmFJTCz26g6g+9xm75hYdSW/g+rEIWhqH/g25N/2+5CIl
	Jua0e1RhWJuPVGRKSkERqCMiwaZj+ooMJGAXd42T6o7SEy7Z56EnN1kliV7WNHvDzB4YYo
	8G19e/uBy8zTA1ZmcmMOgYpCWnmjIN0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/3] memcg/hugetlb: Introduce memcg_accounts_hugetlb
Message-ID: <elww7lzpj4htuhgdeu2e3j5mhogi54x6w75fk5sodaptletk3x@r2fnnh7gz72h>
References: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
 <20241108212946.2642085-2-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108212946.2642085-2-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 08, 2024 at 01:29:44PM -0800, Joshua Hahn wrote:
> This patch isolates the check for whether memcg accounts hugetlb.
> This condition can only be true if the memcg mount option
> memory_hugetlb_accounting is on, which includes hugetlb usage
> in memory.current.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> 
> ---
>  mm/memcontrol.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f3a9653cef0e..97f63ec9c9fb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1425,6 +1425,9 @@ unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item)
>  		memcg_page_state_output_unit(item);
>  }
>  
> +/* Forward declaration */
> +bool memcg_accounts_hugetlb(void);

No need for forward declaration. Just define it here and make it static.

> +
>  static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  {
>  	int i;
> @@ -1446,7 +1449,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  		if (unlikely(memory_stats[i].idx == NR_HUGETLB) &&
> -		    !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
> +			!memcg_accounts_hugetlb())
>  			continue;
>  #endif
>  		size = memcg_page_state_output(memcg, memory_stats[i].idx);
> @@ -4483,6 +4486,15 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
>  	return ret;
>  }
>  
> +bool memcg_accounts_hugetlb(void)
> +{
> +#ifdef CONFIG_HUGETLB_PAGE
> +	return cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
> +#else
> +	return false;
> +#endif
> +}
> +
>  /**
>   * mem_cgroup_hugetlb_try_charge - try to charge the memcg for a hugetlb folio
>   * @memcg: memcg to charge.
> @@ -4508,8 +4520,7 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  	 * but do not attempt to commit charge later (or cancel on error) either.
>  	 */
>  	if (mem_cgroup_disabled() || !memcg ||
> -		!cgroup_subsys_on_dfl(memory_cgrp_subsys) ||
> -		!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
> +		!cgroup_subsys_on_dfl(memory_cgrp_subsys) || !memcg_accounts_hugetlb())
>  		return -EOPNOTSUPP;
>  
>  	if (try_charge(memcg, gfp, nr_pages))
> -- 
> 2.43.5
> 

