Return-Path: <cgroups+bounces-7174-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF119A6998C
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 20:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE24480BA5
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A7F20AF6C;
	Wed, 19 Mar 2025 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TEIueVsF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A361632D9
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412988; cv=none; b=pnttsDDC8PSjId/rrSXZMYB/HBANNbl10MAkkkcNZ9ovXSd3GzoO1fPtRj8r7mrsQ0nwD2j3DCmptFwuTtmKotoqAFP2k+WTM5AwAmW8jhVFScG25uP/AXAKBzk1m1O1emxoLoGNGTwqLvn7pK+vuO3l6X7OPE6XRXXEK9QLGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412988; c=relaxed/simple;
	bh=NyhiDgl6f/KUsW4Fsn2KqToAkLI9xTHj88+pRQOWUnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fw8pcZu0tRkL+BG1jEhfpZVHE2QvdvKhwIYMsRXyBgMHWUURhcccrFeY1YKiE31lHPPc8iC7Wo90veji4s8+Srrlk77GN4dZqELVF+LItJa9BG8gNQneTAYgoFV2bE7b2Ruw18iVM6LLJlcwVXpV6CbcPV4Id1UhGu6wRnBsFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TEIueVsF; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 12:36:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742412984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUhHul+GQB09ExhXQGylt0MFwmGkY50Obp7AgaSPFNY=;
	b=TEIueVsFglnybKo8FFiwe8d5GLPH2u+QLf+3Il+MaswPlr/59POrUuE5tSIiPjjxwCSVmS
	PeiJ1VlXSSCcDSnUdPUfk/YJKQKRMtNdnMKjtttRsSSm1Pkccio4ZV4iZS2Dmu0GuPXVIh
	nprhIvmQaXlQXRlXeU5DSXCfqKst3Xk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, kasong@tencent.com
Subject: Re: [RFC 3/5] mm/memcontrol: do not scan anon pages if memsw limit
 is hit
Message-ID: <nlnwcpezzfmq4rh7oeckrl5nmc4sszd534bo3cx34rpkadhsph@mqphvl3zyanl>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-4-jingxiangzeng.cas@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319064148.774406-4-jingxiangzeng.cas@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 02:41:46PM +0800, Jingxiang Zeng wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> When memory recycling is triggered by the hard watermark of

What is hard watermark?

> memsw, anonymous pages do not want to be recycled any further.
> This is consistent with the processing method of cgroup v2.
> 
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>

Is this patch orthogonal to the series or is it needed for v1 as well?

> ---
>  mm/memcontrol.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c1171fb2bfd6..623ebf610946 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5072,14 +5072,21 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
>  
>  long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>  {
> +	struct page_counter *pg_counter;
>  	long nr_swap_pages = get_nr_swap_pages();
>  
> -	if (mem_cgroup_disabled() || do_memsw_account())
> +	if (mem_cgroup_disabled())
>  		return nr_swap_pages;
> -	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
> +	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
> +		if (do_memsw_account())
> +			pg_counter = &memcg->memsw;
> +		else
> +			pg_counter = &memcg->swap;
> +
>  		nr_swap_pages = min_t(long, nr_swap_pages,
> -				      READ_ONCE(memcg->swap.max) -
> -				      page_counter_read(&memcg->swap));
> +				      READ_ONCE(pg_counter->max) -
> +				      page_counter_read(pg_counter));
> +	}
>  	return nr_swap_pages;
>  }
>  
> -- 
> 2.41.1
> 

