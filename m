Return-Path: <cgroups+bounces-14376-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG1RA1Yqn2kOZQQAu9opvQ
	(envelope-from <cgroups+bounces-14376-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 17:59:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D7419B172
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE469301C6A2
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926003D903F;
	Wed, 25 Feb 2026 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FFPwNoyo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5103D7D9C
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038574; cv=none; b=GYnn5JpvJwMxe2VuKwiyhuiLyNGiwLdq3bGOW+gAiU8Et4j4ToWewziBBD7OXdS1KwcVz4aDHL+aoXa7/chltvdriUfeHhoJcivTSHKgrwgsknC1XbZvBdhD2cTt79Pj6PI9ekifEk1bUm33TJwMla8GICCyNj73ramT29T72/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038574; c=relaxed/simple;
	bh=MkdGCXcVppG/A2jjAYS5dLK+LnljSe05UrL/1fOAnms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtyAtSjrF4iQKGqx9F0s6eHYn03q1uS7QZBIYMZUs1dvlrPy0Iiw82G/3UDtwAYdDRAjygZAhARo03kM0h/9GOWsY38aHJX8a8p+SPJr+/pazjkBeIqqZUlS3ZR3kXsTWZWPcV/1JOwruTMumWWY7RDNMi0MEOraRoscUYDtt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FFPwNoyo; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Feb 2026 08:55:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772038568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rwb9ZB8iGf8KTJOkEtuivHllAa1gLbstzaN/aCan+o=;
	b=FFPwNoyoqhV82NnpPDbeYKTGPtM2BEZYDwDRl9XwLldIas6KaJOPbCxZAWeYKabMotZwEG
	YcWJ1zYO82FLrAybyYRppCNSXKZdhfch59fw6UcHsMn8vYcRj57HH5icCTV0+knmO0xEQW
	HBXz3CfPvyML+adagDnokYNS5V2LbAk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 3/3] ptdesc: Account page tables to memcgs again
Message-ID: <aZ8oT-n4a8VDY2AH@linux.dev>
References: <20260225162319.315281-1-willy@infradead.org>
 <20260225162319.315281-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225162319.315281-4-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14376-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 36D7419B172
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:22:17PM +0000, Matthew Wilcox (Oracle) wrote:
> Commit f0c92726e89f removed the accounting of page tables to memcgs.
> Reintroduce it.
> 
> Fixes: f0c92726e89f (ptdesc: remove references to folios from __pagetable_ctor() and pagetable_dtor())
> Reported-by: Axel Rasmussen <axelrasmussen@google.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h       | 15 +++++++++++++--
>  include/linux/mm_types.h |  6 +++---
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5be3d8a8f806..34bc6f00ed7b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3519,21 +3519,32 @@ static inline unsigned long ptdesc_nr_pages(const struct ptdesc *ptdesc)
>  	return compound_nr(ptdesc_page(ptdesc));
>  }
>  
> +static inline struct mem_cgroup *pagetable_memcg(const struct ptdesc *ptdesc)
> +{
> +#ifdef CONFIG_MEMCG
> +	return ptdesc->pt_memcg;
> +#else
> +	return NULL;
> +#endif
> +}
> +
>  static inline void __pagetable_ctor(struct ptdesc *ptdesc)
>  {
>  	pg_data_t *pgdat = NODE_DATA(memdesc_nid(ptdesc->pt_flags));
> +	struct mem_cgroup *memcg = pagetable_memcg(ptdesc);
>  
>  	__SetPageTable(ptdesc_page(ptdesc));
> -	mod_node_page_state(pgdat, NR_PAGETABLE, ptdesc_nr_pages(ptdesc));
> +	memcg_stat_mod(memcg, pgdat, NR_PAGETABLE, ptdesc_nr_pages(ptdesc));
>  }
>  
>  static inline void pagetable_dtor(struct ptdesc *ptdesc)
>  {
>  	pg_data_t *pgdat = NODE_DATA(memdesc_nid(ptdesc->pt_flags));
> +	struct mem_cgroup *memcg = pagetable_memcg(ptdesc);
>  
>  	ptlock_free(ptdesc);
>  	__ClearPageTable(ptdesc_page(ptdesc));
> -	mod_node_page_state(pgdat, NR_PAGETABLE, -ptdesc_nr_pages(ptdesc));
> +	memcg_stat_mod(memcg, pgdat, NR_PAGETABLE, -ptdesc_nr_pages(ptdesc));
>  }
>  
>  static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3cc8ae722886..e9b1da04938a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -564,7 +564,7 @@ FOLIO_MATCH(compound_head, _head_3);
>   * @ptl:              Lock for the page table.
>   * @__page_type:      Same as page->page_type. Unused for page tables.
>   * @__page_refcount:  Same as page refcount.
> - * @pt_memcg_data:    Memcg data. Tracked for page tables here.
> + * @pt_memcg:         Memcg that this page table belongs to.
>   *
>   * This struct overlays struct page for now. Do not modify without a good
>   * understanding of the issues.
> @@ -602,7 +602,7 @@ struct ptdesc {
>  	unsigned int __page_type;
>  	atomic_t __page_refcount;
>  #ifdef CONFIG_MEMCG
> -	unsigned long pt_memcg_data;
> +	struct mem_cgroup *pt_memcg;

This is kernel memory, so this would be struct obj_cgroup * instead of struct
mem_cgroup pointer. We will need something similar to __folio_objcg(), maybe
__ptdesc_objcg() and then call obj_cgroup_memcg() on it. Basically how
folio_memcg() handles the kernel memory.


