Return-Path: <cgroups+bounces-13512-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILcaGEVbe2nXEAIAu9opvQ
	(envelope-from <cgroups+bounces-13512-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 14:06:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A7B03DB
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 14:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FCE301BF66
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D01388866;
	Thu, 29 Jan 2026 13:05:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689F433F392;
	Thu, 29 Jan 2026 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769691930; cv=none; b=QCoTXNiNoXQZ47VBoS2UZMmxRVp4mFJWBRXVydS3FVazGe0a0HweOiw9y9/0amUJbYUD7DmgJSS1S5H8bRjjrZd092k86T0BvSYzlASpwmaEUmRjyCbTW3qdNZg7BhE0DJs39Qwpour6EFTm5X5gLDlmMrYYXfZDA7KNp9jWxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769691930; c=relaxed/simple;
	bh=m+m2WLAYmUZ/xenVmoSkJ+ivQF2wbD9iPSTafg6cxpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3/eBiQ/Zjalp5mxq7I2w8FMqNHnUgc/ShTM9ypAh9ECZ6LwVwcyaT+nXyFMk+GwdXroNLb3XQhSCVOEmQ/XDpSfY/n3lnj/th6I7+UuDLz1DBoxipL1ga1x/Hk6wkmD1AXDUadivIcg1/nLqnlBW5E3cTYGtVLBCktcthnOeTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CDD2153B;
	Thu, 29 Jan 2026 05:05:21 -0800 (PST)
Received: from [10.164.18.94] (unknown [10.164.18.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 420E43F73F;
	Thu, 29 Jan 2026 05:05:24 -0800 (PST)
Message-ID: <1052a452-9ba3-4da7-be47-7d27d27b3d1d@arm.com>
Date: Thu, 29 Jan 2026 18:35:21 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Qi Zheng <qi.zheng@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <20251110232008.1352063-2-shakeel.butt@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251110232008.1352063-2-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13512-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,cgroups@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B62A7B03DB
X-Rspamd-Action: no action


On 11/11/25 4:50 am, Shakeel Butt wrote:
> The memcg stats are safe against irq (and nmi) context and thus does not
> require disabling irqs. However some code paths for memcg stats also
> update the node level stats and use irq unsafe interface and thus
> require the users to disable irqs. However node level stats, on
> architectures with HAVE_CMPXCHG_LOCAL (all major ones), has interface
> which does not require irq disabling. Let's move memcg stats code to
> start using that interface for node level stats.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Hello Shakeel,

We are seeing a regression in micromm/munmap benchmark with this patch, on arm64 -
the benchmark mmmaps a lot of memory, memsets it, and measures the time taken
to munmap. Please see below if my understanding of this patch is correct.

>  include/linux/memcontrol.h | 2 +-
>  include/linux/vmstat.h     | 4 ++--
>  mm/memcontrol.c            | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 8c0f15e5978f..f82fac2fd988 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1408,7 +1408,7 @@ static inline void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
>  {
>  	struct page *page = virt_to_head_page(p);
>  
> -	__mod_node_page_state(page_pgdat(page), idx, val);
> +	mod_node_page_state(page_pgdat(page), idx, val);
>  }
>  
>  static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index c287998908bf..11a37aaa4dd9 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -557,7 +557,7 @@ static inline void mod_lruvec_page_state(struct page *page,
>  static inline void __mod_lruvec_state(struct lruvec *lruvec,
>  				      enum node_stat_item idx, int val)
>  {
> -	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
> +	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
>  }
>  
>  static inline void mod_lruvec_state(struct lruvec *lruvec,
> @@ -569,7 +569,7 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
>  static inline void __lruvec_stat_mod_folio(struct folio *folio,
>  					 enum node_stat_item idx, int val)
>  {
> -	__mod_node_page_state(folio_pgdat(folio), idx, val);
> +	mod_node_page_state(folio_pgdat(folio), idx, val);
>  }

See folio_remove_rmap_ptes -> __folio_mod_stat -> __lruvec_stat_mod_folio. This path now
has the unconditional overhead of doing this_cpu_try_cmpxchg(). AFAIU the purpose of
this patch was to remove local_irq_save and optimize it by using a cmpxchg atomic
(coupled with the fact that the caller will have ensured preempt_disable), but
there are code paths which are not doing local_irq_save in the first place, so
those get regressed.

>  
>  static inline void lruvec_stat_mod_folio(struct folio *folio,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 025da46d9959..f4b8a6414ed3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -770,7 +770,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  			int val)
>  {
>  	/* Update node */
> -	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
> +	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
>  
>  	/* Update memcg and lruvec */
>  	if (!mem_cgroup_disabled())
> @@ -789,7 +789,7 @@ void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
>  	/* Untracked pages have no memcg, no lruvec. Update only the node */
>  	if (!memcg) {
>  		rcu_read_unlock();
> -		__mod_node_page_state(pgdat, idx, val);
> +		mod_node_page_state(pgdat, idx, val);
>  		return;
>  	}
>  
> @@ -815,7 +815,7 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>  	 * vmstats to keep it correct for the root memcg.
>  	 */
>  	if (!memcg) {
> -		__mod_node_page_state(pgdat, idx, val);
> +		mod_node_page_state(pgdat, idx, val);
>  	} else {
>  		lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  		__mod_lruvec_state(lruvec, idx, val);

