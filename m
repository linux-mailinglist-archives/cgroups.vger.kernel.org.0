Return-Path: <cgroups+bounces-16178-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODsuGIs/D2pNIQYAu9opvQ
	(envelope-from <cgroups+bounces-16178-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 19:23:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 051165AA26E
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 19:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F3403044E38
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4637C90D;
	Thu, 21 May 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cgpeDyzT"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C57360ECA;
	Thu, 21 May 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383923; cv=none; b=WnI3JN49BohLO2RYoH396VTl3MPL6mVKrGV8WXC3hJkEgOqqHsTqnuHtVHKiCz09eRAxJ3fD4awpLr30iD+iLFFlpFG2s4bhwIf/1SG24A5BKvn9IT1z/5qe/LoFNnR3kz5Xwp6ceyuc+mtJ/tsrfpAHAKh2JexJKA2NEpy8IE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383923; c=relaxed/simple;
	bh=99B93sucbYYP5l+9zRE8BiI8uV0S0Bp7gV4hiBBOvDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYX1VGxdxoqv2W7i+u2K7R0RNmSerYbRXhFFkzCpYlWNU0ejmROI/U5zl4CN/WBDD8oAEj4OGdajv7IEFncOclzzysKjJ6lp+v+a8P0VF8QpK5ZSOC2BiO+HdYhzj9nEokSmV+tYwxPfdjBnNz6YS3Y9fL54AmWVPMU662Dqak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cgpeDyzT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6uBaRWeboZvmpTwEOOUnQd/wpJgce6tSxtmt3LHmSMg=; b=cgpeDyzTxHXrutNT1OLjKEANXa
	tuJ7EygeSCCWRY73ILnRFUSrT+YePgAcqmWO3wOt8RvMftzp8NynHhxYocjZsnj+Oej48ITkVACTT
	t4o+Flsnxt3f5XX6z/+xps53VX2o5DK1+hXKuvGPOPuj02QgJgpVuQmJugoaPUHaSfUBGH19ilAq+
	Z92P5OvmpPEXYHxovxwCTouRStYdGazxe/2Bu1TE4sn13Gw5rQmup/4zL7oDACwPmsLZJfziQlMHD
	GD7SvlrWR5/Yn3iikw00Nd9A7zuNOFHTczZFpovLWP/pLy+JEfJBKP/wrUYrMNE3KJIH/eVv1S9xV
	3odIx6wA==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ72b-00000008c2v-3otI;
	Thu, 21 May 2026 17:18:38 +0000
Date: Thu, 21 May 2026 13:18:35 -0400
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
Subject: Re: [PATCH v4 4/8] mm: list_lru: deduplicate lock_list_lru()
Message-ID: <jzpcbo7vheq2soyyayxv5kmsgachg7f7whlzvjh5wxd7ptceby@vegyxf7ejrv4>
References: <20260521150330.1955924-1-hannes@cmpxchg.org>
 <20260521150330.1955924-5-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521150330.1955924-5-hannes@cmpxchg.org>
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
	TAGGED_FROM(0.00)[bounces-16178-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,infradead.org:dkim,cmpxchg.org:email,linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 051165AA26E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/05/21 11:02AM, Johannes Weiner wrote:
> The MEMCG and !MEMCG paths have the same pattern. Share the code.
> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>

> ---
>  mm/list_lru.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 9da6fce19832..65962dbf6dda 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -15,6 +15,14 @@
>  #include "slab.h"
>  #include "internal.h"
>  
> +static inline void lock_list_lru(struct list_lru_one *l, bool irq)
> +{
> +	if (irq)
> +		spin_lock_irq(&l->lock);
> +	else
> +		spin_lock(&l->lock);
> +}
> +
>  static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
>  {
>  	if (irq_off)
> @@ -68,14 +76,6 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
>  	return &lru->node[nid].lru;
>  }
>  
> -static inline void lock_list_lru(struct list_lru_one *l, bool irq)
> -{
> -	if (irq)
> -		spin_lock_irq(&l->lock);
> -	else
> -		spin_lock(&l->lock);
> -}
> -
>  static inline struct list_lru_one *
>  lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
>  		       bool irq, bool skip_empty)
> @@ -136,10 +136,7 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
>  {
>  	struct list_lru_one *l = &lru->node[nid].lru;
>  
> -	if (irq)
> -		spin_lock_irq(&l->lock);
> -	else
> -		spin_lock(&l->lock);
> +	lock_list_lru(l, irq);
>  
>  	return l;
>  }
> -- 
> 2.54.0
> 

