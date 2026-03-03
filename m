Return-Path: <cgroups+bounces-14569-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SckTOngMp2kAcwAAu9opvQ
	(envelope-from <cgroups+bounces-14569-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 17:29:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B62E1F3CBD
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 17:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F05E6303CB1F
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E754BC006;
	Tue,  3 Mar 2026 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cTct34xt"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8E4D90CC
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555205; cv=none; b=R4kbi/1rsdfB+yrDCq2Ty3yYqbGxjAfVGsFF0z49Nvy7l9ZKMYxBQFvCjfsElOC0bWC0AL028fKohlJ4jct1wvhMv3nZbbanDIoErCftd+NNxiSAZ/WLGd52c7SpmMQmWBYTcLxm5MgpHNyLcgeR9UjvZxdZ7iXlkyqobxGsxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555205; c=relaxed/simple;
	bh=3mi18L2XAhtNJP4w0YftC8HpJpTk85/bCiQBpe/fGzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTfq4pszXcc5zZm8wcd1ZcKYoydwsf5CJn28X4WC8vz3oRcMvC/WkG+6rTXgGqAohUxp9zmc4XZa6DMXnB/VO9UQSNgOQOTl4dX6Fv1aQWlHsuC4flJyZhq/I6BaMjRX4zB2PMhSAC/IqwUTtcm4dSHaiLwpaHIdaJJUpieYsGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cTct34xt; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 3 Mar 2026 08:26:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772555199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWZ2Q88mCamuBtdqha7mUqDv9x9r6pDkpjHI+V+2Iuk=;
	b=cTct34xtiw6UR8JCa5DZiQShjiTVn3S5vutC2R8hjpvh0fvfPB7sIcEkVQf5PVaPUOsDgw
	GqfOywqGUWr+JlDAE+MQRWf2kugQdKM6+VZtboockpUKIh1M73Pijxkld7/AO6m/7+azjf
	xB1dcAQPS3aOKgl2l9uuAU7qOxT+suc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm: memcg: separate slab stat accounting from objcg
 charge cache
Message-ID: <aacLODh5BY45Zp9s@linux.dev>
References: <20260302195305.620713-1-hannes@cmpxchg.org>
 <20260302195305.620713-6-hannes@cmpxchg.org>
 <ji2jjt4vtmt2ox7wzytpivttc4z7j3u6cwmv23r6xit5322gns@te4t4djl5nlk>
 <541a6661-7bfe-4517-a32c-5839002c61e5@kernel.org>
 <aablae2eFl9ne5fW@linux.dev>
 <aacBoazC21TAi-Q2@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacBoazC21TAi-Q2@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6B62E1F3CBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14569-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:43:29AM -0500, Johannes Weiner wrote:
> On Tue, Mar 03, 2026 at 05:45:18AM -0800, Shakeel Butt wrote:
> > On Tue, Mar 03, 2026 at 11:42:31AM +0100, Vlastimil Babka (SUSE) wrote:
> > > On 3/3/26 09:54, Hao Li wrote:
> > > > On Mon, Mar 02, 2026 at 02:50:18PM -0500, Johannes Weiner wrote:
> > > >>  
> > > >> +static void refill_obj_stock(struct obj_cgroup *objcg,
> > > >> +			     unsigned int nr_bytes,
> > > >> +			     bool allow_uncharge)
> > > >> +{
> > > >> +	struct obj_stock_pcp *stock = trylock_stock();
> > > >> +	__refill_obj_stock(objcg, stock, nr_bytes, allow_uncharge);
> > > >> +	unlock_stock(stock);
> > > > 
> > > > Hi Johannes,
> > > > 
> > > > I noticed that after this patch, obj_cgroup_uncharge_pages() is now inside
> > > > the obj_stock.lock critical section. Since obj_cgroup_uncharge_pages() calls
> > > > refill_stock(), which seems non-trivial, this might increase the lock hold time.
> > > > In particular, could that lead to more failed trylocks for IRQ handlers on
> > > > non-RT kernel (or for tasks that preempt others on RT kernel)?
> 
> Good catch. I did ponder this, but forgot by the time I wrote the
> changelog.
> 
> > > Yes, it also seems a bit self-defeating? (at least in theory)
> > > 
> > > refill_obj_stock()
> > >   trylock_stock()
> > >   __refill_obj_stock()
> > >     obj_cgroup_uncharge_pages()
> > >       refill_stock()
> > >         local_trylock() -> nested, will fail
> > 
> > Not really as the local_locks are different i.e. memcg_stock.lock in
> > refill_stock() and obj_stock.lock in refill_obj_stock().
> 
> Right, refilling the *byte* stock could produce enough excess that we
> refill the *page* stock. Which in turn could produce enough excess
> that we drain that back to the page counters (shared atomics).
> 
> > However Hao's concern is valid and I think it can be easily fixed by
> > moving obj_cgroup_uncharge_pages() out of obj_stock.lock.
> 
> Note that we now have multiple callsites of __refill_obj_stock(). Do
> we care enough to move this to the caller?
> 
> There are a few other places with a similar pattern:
> 
> - drain_obj_stock(): calls memcg_uncharge() under the lock
> - drain_stock(): calls memcg_uncharge() under the lock
> - refill_stock(): still does full drain_stock()
> 
> All of these could be more intentional about only updating the per-cpu
> data under the lock and the page counters outside of it.
> 
> Given that IRQ allocations/frees are rare, nested ones even rarer, and
> the "slowpath" is a few extra atomics, I'm not sure it's worth the
> code complication. At least until proven otherwise.
> 
> What do you think?

Yes this makes sense. We already have at least one evidence (bug Hao fixed) that
these are very rare, so optimizing for such cases will just increase complexity
without real benefit.

