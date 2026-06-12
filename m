Return-Path: <cgroups+bounces-16884-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +l14KfGBK2om+wMAu9opvQ
	(envelope-from <cgroups+bounces-16884-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 05:50:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9449E6767C0
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 05:50:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="s/MyNDrW";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16884-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16884-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86E8A3012C5D
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 03:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90C358D27;
	Fri, 12 Jun 2026 03:50:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2687C2F7EF3
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 03:50:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781236203; cv=none; b=SyuE8y7ttmuB6jcMfSJdFCXi/Dw1qmD4sqglxDPrun2lZnoLo4M6hWM7JQ1bP/bLpyFaPIvgTAAVGGLnoj8iMyWgWuz0vB1YF4oiQwXk1FKy8Ls9WZ94wCBlKZQl1tYBk9RLqMT4gz30G57Dynyy//V8975CH+DhyIGw/u9zMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781236203; c=relaxed/simple;
	bh=6YDnyl+NTmBwmgeaa2NWCuN3n+3EutNTkE0zEPAtkrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL7oSd3AyjUPTnjanZg/gRgjnOBGOoWnMw9KXGKKzsuI+0+5JUJd0uykLfSngR5Oytrg9C41NbF4W0wOWPPGyTU3sfLPaMMFCnl7fgZcg/gOpMrjemuxIyLn62moTuF52HJaCUI/vExImaKrpP6L5fUZ5wsBCvmacGC+cKgpX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s/MyNDrW; arc=none smtp.client-ip=95.215.58.182
Date: Fri, 12 Jun 2026 11:49:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781236190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixiQyVcnY3YM6U4Uy1f3lDFZTErmkQjeBnlfx6n7LgU=;
	b=s/MyNDrWb1pU/BXD6bpLz0rJoAePBgxJvUr6QVez9L3LkBGjOQInrcL1rqRUUrwq3Dpu6M
	omIbmFHhMYnzSMKHvjT5i05ejKg/w8VIo6UYiHOCH7GhESGXUnE4o1Ra1kmlNRB1G+jhYn
	id4UwS6u815FUDzrY1XJRFiEYFa0R/8=
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
Subject: Re: [PATCH v2 05/16] mm/slab: introduce alloc_flags and
 SLAB_ALLOC_TRYLOCK
Message-ID: <aiuBoDbQc0N-l7e-@fedora>
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16884-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:from_mime,fedora:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9449E6767C0

On Wed, Jun 10, 2026 at 05:40:07PM +0200, Vlastimil Babka (SUSE) wrote:
> Similarly to the page allocators, introduce slab-allocator specific
> alloc flags that internally control allocation behavior in addition to
> gfp_flags, without occupying the limited gfp flags space.
> 
> Introduce the first flag SLAB_ALLOC_TRYLOCK that behaves similarly to
> page allocator's ALLOC_TRYLOCK and will be used to reimplement
> kmalloc_nolock()'s "!allow_spin" behavior. That currently relies on
> gfpflags_allow_spinning() and thus the lack of both __GFP_RECLAIM flags,
> importantly __GFP_KSWAPD_RECLAIM. This can give false-positive results
> e.g. in early boot with a restricted gfp_allowed_mask.
> 
> Also introduce alloc_flags_allow_spinning() to replace the usage of
> gfpflags_allow_spinning().
> 
> Start using alloc_flags and the new check first in alloc_from_pcs() and
> __pcs_replace_empty_main(). This means some slab allocations that were
> falsely treated as kmalloc_nolock() due to their gfp flags will now have
> higher chances of succeed, and this will further increase with followup
> changes.
> 
> Remove a WARN_ON_ONCE() from refill_objects() as it's now legitimate to
> reach it from a slab allocation that's not _nolock() and yet lacks
> __GFP_KSWAPD_RECLAIM for other reasons.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao

