Return-Path: <cgroups+bounces-16480-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLOMDtaoGmr26ggAu9opvQ
	(envelope-from <cgroups+bounces-16480-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 11:07:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839DE60BCA5
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 11:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DF46303AB65
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303CF366816;
	Sat, 30 May 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dNEg1+6p"
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD365395ACD;
	Sat, 30 May 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131995; cv=none; b=LC4bnEOKrhtEEISonwlrdc1gi+W3loftaCorBaMeYNzp0y+5pM85dZeInKgwtoiUFW6Uw637IE8G12mw1POjaBqPmCEgP9PrKCjWPXOJIw+RMlQwrsPUFsNZNSGYRcv7vLv3W2o3nC9Wgl3L9cKLvQugqFVf871wrEwmMtgo/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131995; c=relaxed/simple;
	bh=F0p1JUNXdPw9WM8ZvqkieC/oNoI7GZ3ZiURm7l0kcHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SR8xedFYnPhavp3Gd3FeWNRCfNISeJCR5fVwD1X1QZYESMz7KwPMszPflcs3+R4I+Y84Hh74o9lmSmX/3cQPl9dLllqyr7TSHN6ZZUMeL0GxUVZhf4uiWvV1VKf5nQl/GhvnEYRn2DsDPLRUYTrQnZF4eA35X8iEkJ6En8kPWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dNEg1+6p; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1805D3515;
	Sat, 30 May 2026 02:06:28 -0700 (PDT)
Received: from [10.164.11.56] (unknown [10.164.11.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF8283F905;
	Sat, 30 May 2026 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780131993; bh=F0p1JUNXdPw9WM8ZvqkieC/oNoI7GZ3ZiURm7l0kcHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dNEg1+6pYnhWTOOlXa+3OmugwTNXX7EZHMrHrspJwwLNfQDM1rNven1dKHpjKewYT
	 6w//+zwvelx4A/tz5Lh4kJsIuq+P/tFD2r/IbDvWryJcclu/5qukk3oUdgkFDdr439
	 rZsOVxjnqYg+pqg8TXWRsqSj4+Xq+6fVzqtIvwtA=
Message-ID: <593c5a6c-efcd-4790-9398-1b0e6b94fa8a@arm.com>
Date: Sat, 30 May 2026 14:36:21 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] mm: memory: flatten alloc_anon_folio() retry loop
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Dave Chinner <david@fromorbit.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Qi Zheng <qi.zheng@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 Zi Yan <ziy@nvidia.com>, "Liam R . Howlett" <liam@infradead.org>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Kairui Song <ryncsn@gmail.com>,
 Mikhail Zaslonko <zaslonko@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
 <20260527204757.2544958-9-hannes@cmpxchg.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260527204757.2544958-9-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,redhat.com,arm.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16480-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:mid,arm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,cmpxchg.org:email]
X-Rspamd-Queue-Id: 839DE60BCA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 28/05/26 2:15 am, Johannes Weiner wrote:
> alloc_anon_folio() uses a top-level if (folio) that buries the success
> path four levels deep. This makes for awkward long lines and wrapping.
> The next patch will add more code here, so flatten this now to keep
> things clean and simple.
> 
> The next label is already there, use it for !folio.
> 
> No functional change intended.
> 
> Suggested-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/memory.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7c020995eafc..135f5c0f57bd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5215,24 +5215,24 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  	while (orders) {
>  		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>  		folio = vma_alloc_folio(gfp, order, vma, addr);
> -		if (folio) {
> -			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
> -				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> -				folio_put(folio);
> -				goto next;
> -			}
> -			folio_throttle_swaprate(folio, gfp);
> -			/*
> -			 * When a folio is not zeroed during allocation
> -			 * (__GFP_ZERO not used) or user folios require special
> -			 * handling, folio_zero_user() is used to make sure
> -			 * that the page corresponding to the faulting address
> -			 * will be hot in the cache after zeroing.
> -			 */
> -			if (user_alloc_needs_zeroing())
> -				folio_zero_user(folio, vmf->address);
> -			return folio;
> +		if (!folio)
> +			goto next;
> +		if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
> +			count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +			folio_put(folio);
> +			goto next;
>  		}
> +		folio_throttle_swaprate(folio, gfp);
> +		/*
> +		 * When a folio is not zeroed during allocation
> +		 * (__GFP_ZERO not used) or user folios require special
> +		 * handling, folio_zero_user() is used to make sure
> +		 * that the page corresponding to the faulting address
> +		 * will be hot in the cache after zeroing.
> +		 */
> +		if (user_alloc_needs_zeroing())
> +			folio_zero_user(folio, vmf->address);
> +		return folio;
>  next:
>  		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>  		order = next_order(&orders, order);


