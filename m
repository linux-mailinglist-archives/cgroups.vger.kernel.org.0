Return-Path: <cgroups+bounces-16885-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1V6LEmKCK2pA+wMAu9opvQ
	(envelope-from <cgroups+bounces-16885-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 05:52:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9636767CE
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 05:52:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=iDVoXPJP;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16885-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16885-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75FD332A9171
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 03:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E334C324B33;
	Fri, 12 Jun 2026 03:51:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A22F7EF3
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 03:51:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781236264; cv=none; b=Tb4tp9dgYnIGOzFkacW0RbOl43jQVs4X7TPPjYwJMOLu5l9x9SiLB9gAebnq1EnyryNJlIDqI+BlrcLPpQpWFTeaHAFFKFrhe5y/26vddCshhf0loLJG1cLGmxGMfaCl+3eD5xuaO7wpxI+RhJRfHeqUJSfc0aii8j4x2ivTc4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781236264; c=relaxed/simple;
	bh=nUOvwGJABJ96llqmsfb++sL02EEx8wFc5Sj5wDn0e2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTKp+6j+6jZMiiURT3BbXjbw5Sh/k7nA8dBJPbLAa0P51LExPLqhw7uy9asAlv/jkypNuFRUXaTxx4v2Lbln3AdcPCcN+/HbW/nHVgswidHgFJfKZzD0GfFBew7GjhclTEEIcH1cW6y8EX3kpLWj9hDJ5IHwDojxN4VXr/YNo00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iDVoXPJP; arc=none smtp.client-ip=91.218.175.181
Date: Fri, 12 Jun 2026 11:50:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781236261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFablcsfaJDFV28UgBUNum1R14bfzcLjgvR4MHNUUB8=;
	b=iDVoXPJPbZ/3PSb05ZM5akVqcgSO4QZ+ARaT2daBspxmVqa6IMcmpUr57SBhcl1lGZXGYE
	hVWzkEUd076PffVQMKdItpA7i2zDLY7Jiqlav3KFgCJOv1i9x+c+Bxq0+uPptIQPaCsSUg
	4Ln5GvpNWulb/ERj7FWip5zcDV/QrVs=
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
Subject: Re: [PATCH v2 06/16] mm/slab: add alloc_flags to slab_alloc_context
Message-ID: <aiuB47Lj0vFGyuFA@fedora>
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-6-7190909db118@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-slab_alloc_flags-v2-6-7190909db118@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16885-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:from_mime,fedora:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A9636767CE

On Wed, Jun 10, 2026 at 05:40:08PM +0200, Vlastimil Babka (SUSE) wrote:
> Add alloc_flags as a new field to the slab_alloc_context helper struct,
> so we can pass it to more functions in the slab implementation without
> adding another function parameter.
> 
> Start checking them via alloc_flags_allow_spinning() in
> alloc_single_from_new_slab() (where we can drop the allow_spin
> parameter) and ___slab_alloc(). This further reduces false-positive
> spinning-not-allowed from allocations that are not kmalloc_nolock() but
> lack __GFP_RECLAIM flags.
> 
> _kmalloc_nolock_noprof() initializes ac.alloc_flags using its flags that
> are SLAB_ALLOC_TRYLOCK. slab_alloc_node() and __kmem_cache_alloc_bulk()
> are not reachable from kmalloc_nolock() and all their callers expect
> spinning to be allowed, so they can use SLAB_ALLOC_DEFAULT. This is
> temporary as the scope of slab_alloc_context will further move to the
> callers, making the alloc_flags usage more obvious.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao

