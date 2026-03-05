Return-Path: <cgroups+bounces-14623-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GABiNbrvqGkwzAAAu9opvQ
	(envelope-from <cgroups+bounces-14623-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 03:51:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D783720A53C
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 03:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 255AA302BB96
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 02:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE70727280A;
	Thu,  5 Mar 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="quHxP0Mw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B92690C0
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679091; cv=none; b=NQq34gxY+sxCM+bKFZPRla/CSEdm/AfETXsj/e0sF59PzTaVk/8h/agCEPR9c61lJT3EqP9PCE+QgJVuQ5fjfMYrRl4SgJjXLI3J00kicwPlHs1ehuBx3d9pxx1d7PfBQjyC58u2maxQpeujdVVFCRf2pzMAKMm/nQvsWySvB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679091; c=relaxed/simple;
	bh=goNIL7rblXwt9X7GWywLJzSBkrl7oYRm7B0ofHBC884=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm/CoB8mvDxKWfhmDypVxzWphYWc94MM79i641xpCNMmpyUDduPpAN/vaj8+0AizlwM9dgdQw49yWlYAKmbseLGfSj2AkpSx4SmkTfM+tAI4+qUCXVeAR2gfTY3vljHLXVlIre0B17nraBhqR+SqJpM8ImhmjQFu+WW1P8FjGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=quHxP0Mw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Mar 2026 10:51:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772679088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9FqhU6Xi0PEqicBejsWOUxlERCcjHUVkJ8ZqPzRTOYU=;
	b=quHxP0MwZvOap9vf1E4sRojPwn/nlQlO8RMKQU8tbevfLu6QO2IBZOMfqmKxLJJF9mHM1q
	zbECuBQnbYD5HjbvRNRhGY96P4rqxlGt26YFhyabRnf6k+YGCussA5DsFNYU5/nMQLynve
	AMZnEAdXjc31hAk0JwjmGT3AryIJSvg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.com>, Harry Yoo <harry.yoo@oracle.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	cl@gentwo.org, hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, surenb@google.com, venkat88@linux.ibm.com, pfalcato@suse.de
Subject: Re: [PATCH] mm/slab: change stride type from unsigned short to
 unsigned int
Message-ID: <5r7p6pelk4u5c43kvuxwi75f5dr6msx3x7hapaezourrpgvkr6@jlala4o5z2xf>
References: <20260303135722.2680521-1-harry.yoo@oracle.com>
 <fe9dacdd-8b96-4375-8730-8fb9ed5fad60@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe9dacdd-8b96-4375-8730-8fb9ed5fad60@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D783720A53C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14623-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:17:46AM +0100, Vlastimil Babka wrote:
> On 3/3/26 2:57 PM, Harry Yoo wrote:
> > Commit 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> > defined the type of slab->stride as unsigned short, because the author
> > initially planned to store stride within the lower 16 bits of the
> > page_type field, but later stored it in unused bits in the counters
> > field instead.
> > 
> > However, the idea of having only 2-byte stride turned out to be a
> > serious mistake. On systems with 64k pages, order-1 pages are 128k,
> > which is larger than USHRT_MAX. It triggers a debug warning because
> > s->size is 128k while stride, truncated to 2 bytes, becomes zero:
> > 
[...]
> > 
> > This leads to slab_obj_ext() returning the first slabobj_ext or all
> > objects and confuses the reference counting of object cgroups [1] and
> > memory (un)charging for memory cgroups [2].
> > 
> > Fortunately, the counters field has 32 unused bits instead of 16
> > on 64-bit CPUs, which is wide enough to hold any value of s->size.
> > Change the type to unsigned int.
> > 
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com [1]
> > Closes: https://lore.kernel.org/all/ddff7c7d-c0c3-4780-808f-9a83268bbf0c@linux.ibm.com [2]
> > Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Added to slab/for-next-fixes, thanks!
> Hopefully Venkat confirms the fix and we can close and try to forget
> about the memory ordering can of worms again ;)

Oh, by the way, for that earlier patch that added a memory barrier, the
reported testing results also show the issue no longer reproduces.[1]
So, could it just be that it didn't happen to reproduce that time?

[1] https://lore.kernel.org/linux-mm/84492f08-04c2-485c-9a18-cdafd5a9c3e5@linux.ibm.com/

> 
> > ---
> > 
> > Hi Venkat, could you please test this on top of 7.0-rc2 (instead of
> > 7.0-rc1) and see if the bugs [1] [2] are reproduced on your machine?
> > 
> > I reproduced a debug warning on a ppc machine and fixed it.
> > The bugs are expected to be resolved by this fix.
> > 
> > p.s. After more debugging, I saw stride appeared as 0 even on the CPU
> > that wrote it, which likely rules out a memory ordering issue...
> > and I discovered this while decoding ppc assembly suspecting memory
> > corruption or a compiler bug, which came down to:
> >   
> >     "Hmm... why is the size truncated to 2 bytes?... OH WAIT!"
> > 
> >  mm/slab.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
[...]

