Return-Path: <cgroups+bounces-14167-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ti4/OmS3nGkqKAQAu9opvQ
	(envelope-from <cgroups+bounces-14167-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 21:24:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E5617CD30
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 21:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B099630185FD
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 20:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D81377547;
	Mon, 23 Feb 2026 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LZORV9g8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8203336BCCC
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878240; cv=none; b=AtQx7Fz3OY+vq6LQ8SyeWrGTaZRrAxMpFXr7XzGKScCg1uB0m9nt7oIQSZ8ekEWUDdgSinmR8HVb/GMDajVrOnszcpdoV/klX8e3gV+6D22ejtuScy+knNlT/Habnja+xZItZwFJvSgBRmIpb4Q7kv9MjtxTr9i024m3hp8SKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878240; c=relaxed/simple;
	bh=/9ML08qUE0pdWg6cx8tuajrI54hNzKFy59Rse3jrEFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6eDs6zsPbpEEtl0rnpa3tKdtBZKQ7cz5f8SS3/VIxjSdgaNgcOHFCraNXawrTyDqawEvJyrkV3hbDS8pTEN8550fTfOSWZGgoUeoha2pvf14r1YeJqnqeIfETxtfRtx14HkPEIJ2Q8RBB+69W7UYkXTh94ErJ7umzdFxSvzC2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LZORV9g8; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Feb 2026 12:23:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771878236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RNvomJRDzKYDBuDBzLOEEqO4is1h/8XYWfpUrymqly4=;
	b=LZORV9g8xqhHSpLuPZ7ZD6V3kX11yA8PbWI0FhROUlo2tk75m0eEDrveWRmwIYtoPY2mlw
	zUupYzowXMd/nMquPwB+McK+Gy307vVza93iB+iCDurVWLwk25tLdIY1pBV8jMWBlXNfHg
	Gs9D09m5aTx7GynWG9R5x6EYqzCPnFU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] mm/slab: initialize slab->stride early to avoid memory
 ordering issues
Message-ID: <aZy3O2qcULFDoDU1@linux.dev>
References: <20260223075809.19265-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223075809.19265-1-harry.yoo@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14167-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78E5617CD30
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:58:09PM +0900, Harry Yoo wrote:
> When alloc_slab_obj_exts() is called later in time (instead of at slab
> allocation & initialization step), slab->stride and slab->obj_exts are
> set when the slab is already accessible by multiple CPUs.
> 
> The current implementation does not enforce memory ordering between
> slab->stride and slab->obj_exts. However, for correctness, slab->stride
> must be visible before slab->obj_exts, otherwise concurrent readers
> may observe slab->obj_exts as non-zero while stride is still stale,
> leading to incorrect reference counting of object cgroups.
> 
> There has been a bug report [1] that showed symptoms of incorrect
> reference counting of object cgroups, which could be triggered by
> this memory ordering issue.
> 
> Fix this by unconditionally initializing slab->stride in
> alloc_slab_obj_exts_early(), before the need_slab_obj_exts() check.
> In case of SLAB_OBJ_EXT_IN_OBJ, it is overridden in the same function.
> 
> This ensures stride is set before the slab becomes visible to
> other CPUs via the per-node partial slab list (protected by spinlock
> with acquire/release semantics), preventing them from observing
> inconsistent stride value.
> 
> Thanks to Shakeel Butt for pointing out this issue [2].
> 
> Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com [1]
> Link: https://lore.kernel.org/linux-mm/aZu9G9mVIVzSm6Ft@hyeyoo [2]
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

