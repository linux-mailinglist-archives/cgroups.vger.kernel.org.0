Return-Path: <cgroups+bounces-14454-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPi7E/zsoGlaoAQAu9opvQ
	(envelope-from <cgroups+bounces-14454-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 02:01:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A001B15EA
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 02:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88B3B300F7AC
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 01:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB7E2556E;
	Fri, 27 Feb 2026 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oDi5sO2u"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5E23313E
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154100; cv=none; b=G6HlHok4zGDBa+b64yjNH+WVWqKIUS4yIoNwJ9CqroVUNYhy06w7r7oW9Ihsgf5OHYWpltW8Rra/TkHgG1XAVrfc5EgZmt7cl4CCIp+bg1I1MyQSBPuD7nFctOw56wMzga/teKcbUjnkPA7Tu8ufY9h5SBeDu3K6/YX8Vyd9QCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154100; c=relaxed/simple;
	bh=42tptfIdhG5jvOr+5Okkmzf9uoHNfscXI5+7EsrwC14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ1ngfTgrCngi1RaCKEH8iftMaO3RPRbt63jh2RPNdjvrDNJXflvZdz+pQU2eD381LvqVsS6tv33VVVlunUUgbdZiBlbAQBIZMyF8IWZYDO7XnzHe1h3ZQ36KKW9bH2h5LoqKEtTevsq9YANdaAIkvMCmErDJjD9M/Blpxwlgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oDi5sO2u; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 27 Feb 2026 09:01:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772154095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlJB5kvuqCF53/lXF2sDltcN60w2q3Z8arXeZA7jEjU=;
	b=oDi5sO2uB64YCfPb7Avp4YSvjX6rcfbfiOv+UeqPjNP4kYWcIYo4aJZzojd2g4k/jxL2Xs
	OCLaIp2gLbRNDo/Ky6PRDU1sS3R4CG3u61su74QUaLfvQERFtHoXjCOynjQBDD8BYBagFi
	8CKE37DHaLsCVwliA2serNe26J6eoUo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, vbabka@suse.cz, harry.yoo@oracle.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: fix slab accounting in refill_obj_stock() trylock
 path
Message-ID: <siuyozcbi5x6vusawdy3be5buho5y4qilc5uls7rgiihagk7uv@cfrr75gh4bty>
References: <20260226115145.62903-1-hao.li@linux.dev>
 <aaBM0fN8fqER7Avf@linux.dev>
 <e759dd9b-0857-4155-b570-cd002155f123@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e759dd9b-0857-4155-b570-cd002155f123@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14454-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 48A001B15EA
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 02:44:02PM +0100, Vlastimil Babka wrote:
> On 2/26/26 14:39, Shakeel Butt wrote:
> > On Thu, Feb 26, 2026 at 07:51:37PM +0800, Hao Li wrote:
> >> In the trylock path of refill_obj_stock(), mod_objcg_mlstate() should
> >> use the real alloc/free bytes (i.e., nr_acct) for accounting, rather
> >> than nr_bytes.
> >> 
> >> Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hao Li <hao.li@linux.dev>
> > 
> > Thanks for the fix.
> > 
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> What are the user-visible effects of the bug?

The user-visible impact is that the NR_SLAB_RECLAIMABLE_B and
NR_SLAB_UNRECLAIMABLE_B stats can end up being incorrect.

For example, if a user allocates a 6144-byte object, then before this fix
refill_obj_stock() calls mod_objcg_mlstate(..., nr_bytes=2048), even though it
should account for 6144 bytes (i.e., nr_acct).

When the user later frees the same object with kfree(), refill_obj_stock() calls
mod_objcg_mlstate(..., nr_bytes=6144). This ends up adding 6144 to the stats,
but it should be applying -6144 (i.e., nr_acct) since the object is being
freed.

-- 
Thanks,
Hao

