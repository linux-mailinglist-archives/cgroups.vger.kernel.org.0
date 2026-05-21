Return-Path: <cgroups+bounces-16176-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIg2Cto+D2pzIQYAu9opvQ
	(envelope-from <cgroups+bounces-16176-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 19:20:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6AB5AA196
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 19:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EE0B3008C07
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AC6395AEE;
	Thu, 21 May 2026 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ub0Ujck9"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72495356772;
	Thu, 21 May 2026 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383813; cv=none; b=mJ3B2RDPD8iDyapMKM5IM3kP5d3nlCSvNqFzyTW1zW8IkWKtA/VhSrCLHzdoQXzswx/XSTuv8ZZ1z5+vyN4J26Ov9wsy1vEaWxp5Q4vvOtoLd8BhjU3OpYIPq+9RSUfE4k51Gsgr8rTRvw5qoLlWA88q7JN9bcaBeyRhcTnPtm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383813; c=relaxed/simple;
	bh=MhT4xIROXekYNevTxt0aQWZRsttVHqAq+qDgJCLgKbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il+YbBB78jE+AC3SeZxllMWdsXmJ24E9ilGI75zTXJYipzhRoadCDUL5vA5L5XoZEkb4/MGcSjFYUd2MMlAcoOy2HNp/l0JmMS0pOmgdc7Y/FMxoexP4FdBvME+YJW6oXyiuixhriTpFgKmAr5FwZu9ecszNVM7YO+hYzO/F+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ub0Ujck9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZvUjhf1UU/IohtHymqimCuPKGDaSQBsrsNMlIA60drc=; b=ub0Ujck9hnxGESg0BOKgJ4xVXT
	L1UOhZJowMMFbByRnTcfSo15BTAqDPdk7zOqWTaGvE2CGQ5Ta2NxXuUtaxhH//STzNDdmUpM3ZaRI
	ajidiw6tUhsGiUqNgzIUVmcMXShVld5lLotoOnRZE09/J9Uqf/mwUfTebkDlnHGMEzxS9KZAXdo9H
	ygdQibwbGeghHNYLcVwoyghEFmClmSbNCbvmtDSlNrPizo0ojNQEZ8vY3P4KrCRZSuyb4G6AJSj7P
	QyCTnCURVpxfSG3jlDxuHMfuQuZLKPnJDtWH/qd8Ep5QdJwmj0MeWrHwiDN9VICp68T21wvOHUCKF
	mTppm22w==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ70o-00000008bi0-02sn;
	Thu, 21 May 2026 17:16:46 +0000
Date: Thu, 21 May 2026 13:16:43 -0400
From: "Liam R . Howlett" <liam@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Kairui Song <ryncsn@gmail.com>, Mikhail Zaslonko <zaslonko@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/8] mm: list_lru: deduplicate unlock_list_lru()
Message-ID: <x6zjeg2tlnuz22ofpvlpmnskiw3gnkhkghomfgdasfajwwye55@pbz76jdh2tru>
References: <20260521150330.1955924-1-hannes@cmpxchg.org>
 <20260521150330.1955924-3-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521150330.1955924-3-hannes@cmpxchg.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16176-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liam@infradead.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,infradead.org:email,infradead.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: BD6AB5AA196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/05/21 11:02AM, Johannes Weiner wrote:
> The MEMCG and !MEMCG variants are the same. lock_list_lru() has the
> same pattern when bailing. Consolidate into a common implementation.
> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>

> ---
>  mm/list_lru.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index d3619961a7ac..9a68177619bf 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -15,6 +15,14 @@
>  #include "slab.h"
>  #include "internal.h"
>  
> +static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
> +{
> +	if (irq_off)
> +		spin_unlock_irq(&l->lock);
> +	else
> +		spin_unlock(&l->lock);
> +}
> +
>  #ifdef CONFIG_MEMCG
>  static LIST_HEAD(memcg_list_lrus);
>  static DEFINE_MUTEX(list_lrus_mutex);
> @@ -67,10 +75,7 @@ static inline bool lock_list_lru(struct list_lru_one *l, bool irq)
>  	else
>  		spin_lock(&l->lock);
>  	if (unlikely(READ_ONCE(l->nr_items) == LONG_MIN)) {
> -		if (irq)
> -			spin_unlock_irq(&l->lock);
> -		else
> -			spin_unlock(&l->lock);
> +		unlock_list_lru(l, irq);
>  		return false;
>  	}
>  	return true;
> @@ -101,14 +106,6 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
>  	memcg = parent_mem_cgroup(memcg);
>  	goto again;
>  }
> -
> -static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
> -{
> -	if (irq_off)
> -		spin_unlock_irq(&l->lock);
> -	else
> -		spin_unlock(&l->lock);
> -}
>  #else
>  static void list_lru_register(struct list_lru *lru)
>  {
> @@ -147,14 +144,6 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
>  
>  	return l;
>  }
> -
> -static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
> -{
> -	if (irq_off)
> -		spin_unlock_irq(&l->lock);
> -	else
> -		spin_unlock(&l->lock);
> -}
>  #endif /* CONFIG_MEMCG */
>  
>  /* The caller must ensure the memcg lifetime. */
> -- 
> 2.54.0
> 

