Return-Path: <cgroups+bounces-16888-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 92YVMMaYK2qXAAQAu9opvQ
	(envelope-from <cgroups+bounces-16888-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 07:27:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB40676BF4
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 07:27:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=FhKVk9tP;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16888-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16888-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C3B531EE8FB
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 05:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C1F3A48F1;
	Fri, 12 Jun 2026 05:27:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C85C3290BD;
	Fri, 12 Jun 2026 05:27:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781242031; cv=none; b=OQ6RoGvHGc6Vs/SDmAq2OskCBFFnPWUV07WJbljOLta17mKElh81ZSQDFEgF3mpb/7oLstwsx9tUNGoeGpJ/Y7nIV2AFV9Jsza4Fpelpb+ocnvggwgJCowcsgD143/L/SjlQYulnyhSz7hEio9VEnxngLvWI+Z4FTJ3wi6X7LPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781242031; c=relaxed/simple;
	bh=J228wGjhBNa3gtDG9PaBh/hqV6p77KV8odXCtoWxFhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zdyk/B29aSHkqzhGmyBhROPijSypa3U7f7MNyhj5HtHE7bl0Hs7rvSjLJvXN8EWC/aoheVaX/8Fb6lAP1HCxPLvynSpP3RgIzTKmvsOC15/VE/xAD9Hzn8hTytCu9M1TOVlzGaMdqYDy1drA/sn+wKnya1u84z2c5dbOU8ahY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FhKVk9tP; arc=none smtp.client-ip=95.215.58.180
Date: Fri, 12 Jun 2026 13:26:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781242026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4h74kcxJkFPwFOo5Mrw9gW8GX36OPR00MRCmR90JPNU=;
	b=FhKVk9tPR9od9h9I7gPVRNxgWrFle6W6cYkv2sScxzuHrqE+O5WO6CoLjTgIs7QeogntS8
	RzrIpsfM0UjJOLH4cGzjwP18JOd7L7VfgvUxMNHdCdeWLLvlMAoC/8mTVGQPqsal6+wB09
	pdeW7MKR+F/sKHu2EsIlxXSFJFiZezU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 08/16] mm/slab: pass alloc_flags to new slab allocation
Message-ID: <aiuX6SRATJoaq-jH@fedora>
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-8-7190909db118@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-slab_alloc_flags-v2-8-7190909db118@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16888-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,fedora:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDB40676BF4

On Wed, Jun 10, 2026 at 05:40:10PM +0200, Vlastimil Babka (SUSE) wrote:
> Add the alloc_flags parameter to allocate_slab() and new_slab()
> so it can be used to determine if spinning is allowed, independently
> from gfp flags.
> 
> refill_objects() passes SLAB_ALLOC_DEFAULT because it can only be
> reached from contexts that allow spinning.
> 
> Also change how trynode_flags are constructed in ___slab_alloc() to
> achieve the same "do not upgrade to GFP_NOWAIT" by using masking instead
> of a branch. It will now also not upgrade in cases where gfp is weaker
> than GFP_NOWAIT (i.e. lacks __GFP_KSWAPD_RECLAIM) but doesn't come from
> kmalloc_nolock() - which is more correct anyway.
> 
> During the masking keep also existing __GFP_NOMEMALLOC (pointed out by
> Sashiko) and __GFP_ACCOUNT. Previously the hardcoded GFP_NOWAIT would
> eliminate them, but it's not a big problem that would need a separate
> fix.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/slub.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 98b79e5e7679..8f6ca3d5fdfa 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3378,9 +3378,10 @@ static __always_inline void unaccount_slab(struct slab *slab, int order,
>  }
>  
>  /* Allocate and initialize a slab without building its freelist. */
> -static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
> +static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
> +				  unsigned int alloc_flags, int node)
>  {
> -	bool allow_spin = gfpflags_allow_spinning(flags);
> +	bool allow_spin = alloc_flags_allow_spinning(alloc_flags);

nit: allow_spin doesn't depend on `flags` now, so it seems we can delete the
comments:

/*
 * __GFP_RECLAIM could be cleared on the first allocation attempt,
 * so pass allow_spin flag directly.
 */

Otherwise, looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao

