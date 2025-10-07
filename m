Return-Path: <cgroups+bounces-10594-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B625BC2F7D
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 01:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BB724E7795
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 23:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C94325A2A2;
	Tue,  7 Oct 2025 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ik2GK1eK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6FA25D209
	for <cgroups@vger.kernel.org>; Tue,  7 Oct 2025 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880455; cv=none; b=jqFUX/MDqnZMj1+DmQxNYIuK/QnDwNKEcCrLCBX+iakTuPutZGE2xeS5K8tQZVW6Fyow8G/YTENyvFyEKkbF7bsme7+c1WdOpRcJhSUnvwbfeYVpv8IsIavAJylnKFpvrgEw4MFued1neLyfbkfH9JUIahYEnZGrZwIVGVIfjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880455; c=relaxed/simple;
	bh=kPOg73LsFm0VhO3hCIMBYbq1D6CbqS1d4DmEn+yVioE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyL/GWF0HhVefyw5uo6J2nQRVhBHUCNxIMXflnjsJdKHtulac7Jl9lbu64O0EL5a5yLWopbNTiWxKxCFjFQ/Tf+ufQDLGX1YGEmLbSEmogdrLjAcFmJdstSr53UkIZh8f3RhtE0P/SR+OZNsKCJcPt7fTPwv1HMonIcXgwif3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ik2GK1eK; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 Oct 2025 23:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759880450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E6OD1bQXaicr9WCwyTV1JRRGSFUf3V7VjtgLaaXPLUQ=;
	b=ik2GK1eKqJ/QpncSodtUJDqaZ1CxjtRJZpZXNofmS05mT7WKjS1TA1XtUWKRbME70i+3CT
	0BQj1BKgoLhhfoYfbSr8rpw2TuWe4dMMZU+rRfsbTNoEQEqAdNNVJyu6SRXzy0zJoHlFOf
	gITYeZiFDARdwU/DvrwJixjCfb1CJhw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, cgroups@vger.kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm/zswap: fix typos: s/zwap/zswap/
Message-ID: <k7suwksw5kvivopboym4zny3u7rqwq3gw6rvlrcrydo7kiadvg@gumequ2fft7h>
References: <20251003203851.43128-1-sj@kernel.org>
 <20251003203851.43128-3-sj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003203851.43128-3-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 03, 2025 at 01:38:49PM -0700, SeongJae Park wrote:
> As the subject says.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  mm/memcontrol.c | 2 +-
>  mm/zswap.c      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 69c970554e85..74b1bc2252b6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5421,7 +5421,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>   * @size: size of compressed object
>   *
>   * This forces the charge after obj_cgroup_may_zswap() allowed
> - * compression and storage in zwap for this cgroup to go ahead.
> + * compression and storage in zswap for this cgroup to go ahead.
>   */
>  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
>  {
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 80619c8589a7..f6b1c8832a4f 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -879,7 +879,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>  	 * acomp instance, then get those requests done simultaneously. but in this
>  	 * case, zswap actually does store and load page by page, there is no
>  	 * existing method to send the second page before the first page is done
> -	 * in one thread doing zwap.
> +	 * in one thread doing zswap.
>  	 * but in different threads running on different cpu, we have different
>  	 * acomp instance, so multiple threads can do (de)compression in parallel.
>  	 */
> @@ -1128,7 +1128,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>  	 *
>  	 * 1. We extract the swp_entry_t to the stack, allowing
>  	 *    zswap_writeback_entry() to pin the swap entry and
> -	 *    then validate the zwap entry against that swap entry's
> +	 *    then validate the zswap entry against that swap entry's
>  	 *    tree using pointer value comparison. Only when that
>  	 *    is successful can the entry be dereferenced.
>  	 *
> -- 
> 2.39.5

