Return-Path: <cgroups+bounces-16782-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3fDhE6MXKGpJ9wIAu9opvQ
	(envelope-from <cgroups+bounces-16782-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 15:39:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9EE660A84
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 15:39:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=QzMh49Ds;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16782-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16782-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2C333034DC1
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 13:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D378416CEC;
	Tue,  9 Jun 2026 13:35:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58916416CE8
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 13:35:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012158; cv=none; b=OaYLcwuuBBmBieilFqSRL6j8/spKkQ2CARSCIKmgXvFmmS59GY2bMYfOro4gsbETInI/3olwQDtuQ6Zob5k2lJ5nwO8iljkkoIHJnDtj1vBRT4OJaUqApyGWrvfYvEOvAVEzDA7bYxc7nZnqE6lPqyehsPTy26AczQV819lh324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012158; c=relaxed/simple;
	bh=8BiK1KxFqztyD5pyllvGHSu2mNRsxr7nrC6FMk+3mWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9euku5SlZB0WakoScv6lqLHfOsyF3J6aQIR1a0sruKYedAK7iXTb6u0o5ZII3a4Lf8S4zyAoif8Dfk63aKsV6/N0rn5jIskSj4plSYYclxfjnF1s3HOp+Hz/9TtBIkxBvcqK23bYXnISyXLWikbTingzYxkz763/afEhnwZO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QzMh49Ds; arc=none smtp.client-ip=95.215.58.180
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781012144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fac/qHX5WhfF08NyL9azVrutmt3ga+s6RNOocK4YyzE=;
	b=QzMh49DsK+rj/HXv5ZB23N3Vey836AfUWpRWeQB+4uJpkIFKUHr/nYKDkrrc3u9axP/w6+
	G8LnrLfGwv5PmvjS5plSoaMlSixod6mR3J7+nv+mIwdPz2OS4IGGsXKprqsCyP4tQInw82
	IWHwXtMn288yweMaFWfxY47HQQDv6/g=
From: Usama Arif <usama.arif@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Harry Yoo <harry@kernel.org>,
	hao.ge@linux.dev,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH RFC 00/15] mm/slab: introduce alloc_flags and slab_alloc_context
Date: Tue,  9 Jun 2026 06:35:33 -0700
Message-ID: <20260609133534.3548059-1-usama.arif@linux.dev>
In-Reply-To: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16782-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:usama.arif@linux.dev,m:harry@kernel.org,m:hao.ge@linux.dev,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD9EE660A84

On Tue, 09 Jun 2026 11:17:45 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> This series is based on slab/for-next. If all goes well, it would
> hopefully go to slab/for-next soon after the 7.2 merge window, so any
> other work can be based on it to avoid conflicts, as it touches a lot
> parts of slab.
> 
> Git: https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slab_alloc_flags
> 
> The slab implementation currently relies on gfp flags to convey
> some context information internally:
> 
> - The absence of both __GFP_RECLAIM flags is interpreted as "cannot spin
>   on locks", and intended to be used by kmalloc_nolock(). But false
>   positives are possible e.g. during early boot where gfp_allowed_mask
>   clears __GFP_RECLAIM from all allocations. This leads to unnecessary
>   allocation failures and workarounds such as fd3634312a04 ("debugobject:
>   Make it work with deferred page initialization - again").
> 
> - __GFP_NO_OBJ_EXT exists and takes up valuable bit in the gfp flags
>   space, only to prevent recursive kmalloc() allocations for obj_ext
>   arrays and sheaves.
> 

Hello Valstimil!

I think memory allocation profiling uses __GFP_NO_OBJ_EXT, and I dont see
it being removed in the series (hopefully I didnt miss it).

Adding Hao Ge in CC who did this in the commit:
mm/alloc_tag: replace fixed-size early PFN array with dynamic linked list


> The page allocator uses its internal alloc_flags to convey various
> context information, including ALLOC_TRYLOCK (meaning "cannot spin").
> This series copies that concept for the slab allocator, with its own
> slab-specific internal flags:
> 
> - SLAB_ALLOC_DEFAULT - no extra flags (the value is 0), but explicit
> - SLAB_ALLOC_TRYLOCK - do not spin on locks (used by kmalloc_nolock())
> - SLAB_ALLOC_NEW_SLAB - replacing existing 'bool new_slab' parameter
> 			for allocating obj_ext arrays
> - SLAB_ALLOC_NO_RECURSE - replacing usage of __GFP_NO_OBJ_EXT
> 
> To reduce the amount of parameters in various internal functions, we
> additionally introduce slab_alloc_context (also inspired by page
> allocator's alloc_context) for passing a number of existing arguments
> and the new alloc_flags:
> 
> /* Structure holding extra parameters for slab allocations */
> struct slab_alloc_context {
> 	unsigned long caller_addr;
> 	unsigned long orig_size;
> 	unsigned int alloc_flags;
> 	struct list_lru *lru;
> };
> 
> This also replaces the existing struct partial_context.
> 
> The last necessary piece is kmalloc_flags() which can take the
> alloc_flags in addition to gfp flags and is intended for the recursive
> allocations of sheaves and obj_ext arrays, so that both
> SLAB_ALLOC_TRYLOCK and SLAB_ALLOC_NO_RECURSE can be communicated.
> Internally it decides between kmalloc_nolock() and normal kmalloc()
> depending SLAB_ALLOC_TRYLOCK.
> 
> The rest of the series is gradually expanding the usage of both
> alloc_flags and slab_alloc_context as necessary, with bits of
> refactoring. Then, __GFP_NO_OBJ_EXT is removed completely.
> 
> Note that some usage of gfpflags_allow_spinning() relying on absence of
> __GFP_RECLAIM remains outside of slab (and page allocator) in memcg,
> page_owner and stackdepot code. These can thus yield false-positive
> decisions that spinning is not allowed, but should not result in
> important allocations failing anymore.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
> Vlastimil Babka (SUSE) (15):
>       mm/slab: always zero only requested size on alloc
>       mm/slab: stop inlining __slab_alloc_node()
>       mm/slab: introduce slab_alloc_context
>       mm/slab: introduce alloc_flags and SLAB_ALLOC_TRYLOCK
>       mm/slab: add alloc_flags to slab_alloc_context
>       mm/slab: replace struct partial_context with slab_alloc_context
>       mm/slab: pass alloc_flags to new slab allocation
>       mm/slab: pass alloc_flags through slab_post_alloc_hook() chain
>       mm/slab: replace slab_alloc_node() parameters with slab_alloc_context
>       mm/slab: allow kmem_cache_alloc_bulk() with any gfp flags
>       mm/slab: pass slab_alloc_context to __do_kmalloc_node()
>       mm/slab: introduce kmalloc_flags()
>       mm/slab: remove __GFP_NO_OBJ_EXT usage from alloc_slab_obj_exts()
>       mm/slab: replace __GFP_NO_OBJ_EXT with SLAB_ALLOC_NO_RECURSE for sheaves
>       mm: remove the __GFP_NO_OBJ_EXT flag
> 
>  include/linux/gfp_types.h       |   7 -
>  include/linux/slab.h            |  14 +-
>  include/trace/events/mmflags.h  |  10 +-
>  lib/alloc_tag.c                 |   2 +-
>  mm/kfence/core.c                |   6 +-
>  mm/memcontrol.c                 |   5 +-
>  mm/slab.h                       |  16 +-
>  mm/slub.c                       | 423 ++++++++++++++++++++++++----------------
>  tools/include/linux/gfp_types.h |   7 -
>  9 files changed, 288 insertions(+), 202 deletions(-)
> ---
> base-commit: 500b2c9755301742bdbb61249511ac11a4665dae
> change-id: 20260601-slab_alloc_flags-25c782b0c57c
> 
> Best regards,
> --  
> Vlastimil Babka (SUSE) <vbabka@kernel.org>
> 
> 

