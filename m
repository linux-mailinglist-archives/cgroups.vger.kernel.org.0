Return-Path: <cgroups+bounces-17070-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NObMKt2nM2oMEwYAu9opvQ
	(envelope-from <cgroups+bounces-17070-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 10:10:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BA569E5B7
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 10:10:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=uLPXuD4N;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17070-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17070-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EF04303265F
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 08:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996033D6CC4;
	Thu, 18 Jun 2026 08:10:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225D628504D
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 08:09:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770200; cv=none; b=MA/TC5DhmVu+Jg1RElYBrtgNIbCmxmDY342yBZp9xepzBtwiM0WaablP5Oj6bWvdYuT8toAS1MUzc8ocR8qKuNLDpph3mniusREi3HQfJyu8CixPTh2mfddrc+NaafyifbnUogcQZBcVmdxKZVmXapzO4TMDhci6+qFZvvmjsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770200; c=relaxed/simple;
	bh=hm3pcLfPpufbBAae83s/z1mFxIUSczuS+WqOOg/pV5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXsToz7U52AnN4sTIKonhEx2leW4HM0haZGAc9Q5WPjhLLXfKpXMLkSpkuIuLdvmDxu/q/U9q+TGVFmjI3O58LpVY/SIWF7/dTsFPNx8Qs/wrnUK0ppZHDT3EcsvUteGptk8krIZefFTzdER48h3B62A6GeIluAXo2CmaZ9L+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uLPXuD4N; arc=none smtp.client-ip=91.218.175.183
Date: Thu, 18 Jun 2026 16:09:44 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781770196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPz+/6ozPt/d74JBAdAyoBjizvXRlrgjpuqP5wOKvag=;
	b=uLPXuD4NEEQLwI/WTOt7gNtfmYXk+DRz/v5gPNoYBL6JiuYWOC4+KiGR3iVq3QdkgA3ih6
	QiIuV951SK9PzO02tMc9C8sWK8BnaFdXeIquOeXMnz6gGNfGCDXlhYoVk/RWqc/dEb7xNr
	9CLAngLDI8yBa2rXlvgZeq7y1B7VVLE=
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
Subject: Re: [PATCH v3 10/15] mm/slab: allow kmem_cache_alloc_bulk() with any
 gfp flags
Message-ID: <ajOns5I57UrExxW6@fedora>
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-10-ce1146d140fb@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-slab_alloc_flags-v3-10-ce1146d140fb@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-17070-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[fedora:mid,msgid.link:url,linux.dev:dkim,linux.dev:email,linux.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8BA569E5B7

On Mon, Jun 15, 2026 at 01:54:43PM +0200, Vlastimil Babka (SUSE) wrote:
> The last user of gfpflags_allow_spinning() in slab is
> alloc_from_pcs_bulk(), which is only called from
> kmem_cache_alloc_bulk().
> 
> It turns out that gfpflags_allow_spinning() is not necessary, because
> kmem_cache_alloc_bulk() is only expected to be called from context that
> does allow spinning, so simply replace it with 'true'. This means we can
> also drop the gfp parameter from alloc_from_pcs_bulk().
> 
> With that, we can remove the "@flags must allow spinning" part of the
> kernel doc, as there is no more connection to the gfp flags in the slab
> implementation.
> 
> Also remove a comment in alloc_slab_obj_exts() because there should be
> no more false positives possible due to gfp_allowed_mask during early
> boot.
> 
> Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-11-7190909db118@kernel.org
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao

