Return-Path: <cgroups+bounces-7173-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD295A6999A
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 20:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0C9880B64
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB7214812;
	Wed, 19 Mar 2025 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NmUCr7H6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415422144C8
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412850; cv=none; b=ljc4qCx/Hzt3a8DsgKH4z/0r57Ij7EF4Q4QHLFtY7yBlDzHn7BB52B+F+6PIIjm0bXj4nq0UYnI2Pgq1igoiw78ECrrIqkZnTeFi7SPhW9zscUu0j+AXsWeRimc84KNmpUH1wxBXRIwO7LuIzc9fLX5xc9rFchVSqhvfimAUk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412850; c=relaxed/simple;
	bh=J/fCez060NOi+MlSRAXhwSfQCdFvJuRmx9tWZ38H9Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov7CFmRnpVFMK4aJAoZQoKXfORX6x5fzFCm5lyu6SP8F+utlUZ2AtsiGxv+RcXzB4cyfl0CnMpuoVHmm9Zl0xLr9C0itJvj8rj2d8WsJ7OGy0so3vDaJuHn4/ErkquwP+G2f6S6ZnsZv1bvdzcALhSrfWAyIfBus/dhYObfPWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NmUCr7H6; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 12:34:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742412845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7iiFyfv8ZcZH4P9FmMSSbT74XJienNrg0Fu09eyZfBw=;
	b=NmUCr7H6RP7IncbOChFoOSmP9R6xYH6qvsP2HZNDBfwBnEn7qbLk3K4GZJVLT415nd/Vny
	y/qMy5hyBg4uABkfPfaBvFagE//kiW759upydTR1QjgkhUudT64O/iFIyueQD6KVnMPz0c
	0cbsT6xrjfFAAzDVzmNBNsQF+4Ta6d0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, kasong@tencent.com
Subject: Re: [RFC 2/5] memcontrol: add boot option to enable memsw account on
 dfl
Message-ID: <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-3-jingxiangzeng.cas@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319064148.774406-3-jingxiangzeng.cas@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 02:41:45PM +0800, Jingxiang Zeng wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> Added cgroup.memsw_account_on_dfl startup parameter, which
> is off by default. When enabled in cgroupv2 mode, the memory
> accounting mode of swap will be reverted to cgroupv1 mode.
> 
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> ---
>  include/linux/memcontrol.h |  4 +++-
>  mm/memcontrol.c            | 11 +++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index dcb087ee6e8d..96f2fad1c351 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -62,10 +62,12 @@ struct mem_cgroup_reclaim_cookie {
>  
>  #ifdef CONFIG_MEMCG
>  
> +DECLARE_STATIC_KEY_FALSE(memsw_account_on_dfl);
>  /* Whether enable memory+swap account in cgroupv2 */
>  static inline bool do_memsw_account_on_dfl(void)
>  {
> -	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL);
> +	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL)
> +				|| static_branch_unlikely(&memsw_account_on_dfl);

Why || in above condition? Shouldn't it be && ?

>  }
>  
>  #define MEM_CGROUP_ID_SHIFT	16
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 768d6b15dbfa..c1171fb2bfd6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5478,3 +5478,14 @@ static int __init mem_cgroup_swap_init(void)
>  subsys_initcall(mem_cgroup_swap_init);
>  
>  #endif /* CONFIG_SWAP */
> +
> +DEFINE_STATIC_KEY_FALSE(memsw_account_on_dfl);
> +static int __init memsw_account_on_dfl_setup(char *s)
> +{
> +	if (!strcmp(s, "1"))
> +		static_branch_enable(&memsw_account_on_dfl);
> +	else if (!strcmp(s, "0"))
> +		static_branch_disable(&memsw_account_on_dfl);
> +	return 1;
> +}
> +__setup("cgroup.memsw_account_on_dfl=", memsw_account_on_dfl_setup);

Please keep the above in memcontrol-v1.c

> +
> \ No newline at end of file
> -- 
> 2.41.1
> 

