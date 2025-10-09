Return-Path: <cgroups+bounces-10614-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD101BC742E
	for <lists+cgroups@lfdr.de>; Thu, 09 Oct 2025 05:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD5624F0D9F
	for <lists+cgroups@lfdr.de>; Thu,  9 Oct 2025 03:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49834212556;
	Thu,  9 Oct 2025 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VyIJmssX"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DA1FF5E3
	for <cgroups@vger.kernel.org>; Thu,  9 Oct 2025 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978984; cv=none; b=Dztar7V4e/uNC9gxRZ6LnGggn+km9fC8Ar8MvLMqsGJMKLKlSGhcw9iZVAP3tmuzFmmR0JfBAidb0G0wEf5c0CHrRsIzYCsouc9D09Vdl8qHHPtyxkRDJS3slqTz3Zl5BcqumXRU1vqRKL6tQbEvCwQI9Ue3t1NM0JtYEy7QwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978984; c=relaxed/simple;
	bh=jXqYSB6FAdmUnZFoKmnXNwGWyrXkXVtJuSNystAZJCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2+s4+HSA/obnTQxhYpZJWOmucIoCfonggCNF+wWjdqJZtdxW9hRs/SDRUKuL6aYH9lnUKnaJXex0kjgEfqSSBqwEhfh2PyuD7z3aWsQ9h8Op48s/5pa+6MN5hZopEeYrpk8nZwxxnBYNku2/pivVriyfEiTdQ3bpL05pgLpTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VyIJmssX; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e3de261-0421-439e-a763-7f2895c2496f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759978978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YEIJe1l7uPPwXCLKi51on2x3YEMf9V1p1qQ0Ogt3bY=;
	b=VyIJmssXWpo4mfVElfR8iHujbljan6VThvQAVU7woPIpircc2b+FrP//5zchULofz5Stjn
	Vty8Ap7MH+g+82dkjpSBtZpApBVxWiDXh95a/dWrMrBWNyrHXlpzmdu6C8xKMGwiHtavco
	tNyFnoSdV0823jYmFGf9N6JSVGWtXew=
Date: Thu, 9 Oct 2025 11:02:50 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] mm/zswap: fix typos: s/zwap/zswap/
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 cgroups@vger.kernel.org, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251003203851.43128-1-sj@kernel.org>
 <20251003203851.43128-3-sj@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20251003203851.43128-3-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/10/4 04:38, SeongJae Park wrote:
> As the subject says.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>   mm/memcontrol.c | 2 +-
>   mm/zswap.c      | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 69c970554e85..74b1bc2252b6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5421,7 +5421,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>    * @size: size of compressed object
>    *
>    * This forces the charge after obj_cgroup_may_zswap() allowed
> - * compression and storage in zwap for this cgroup to go ahead.
> + * compression and storage in zswap for this cgroup to go ahead.
>    */
>   void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
>   {
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 80619c8589a7..f6b1c8832a4f 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -879,7 +879,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>   	 * acomp instance, then get those requests done simultaneously. but in this
>   	 * case, zswap actually does store and load page by page, there is no
>   	 * existing method to send the second page before the first page is done
> -	 * in one thread doing zwap.
> +	 * in one thread doing zswap.
>   	 * but in different threads running on different cpu, we have different
>   	 * acomp instance, so multiple threads can do (de)compression in parallel.
>   	 */
> @@ -1128,7 +1128,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>   	 *
>   	 * 1. We extract the swp_entry_t to the stack, allowing
>   	 *    zswap_writeback_entry() to pin the swap entry and
> -	 *    then validate the zwap entry against that swap entry's
> +	 *    then validate the zswap entry against that swap entry's
>   	 *    tree using pointer value comparison. Only when that
>   	 *    is successful can the entry be dereferenced.
>   	 *

