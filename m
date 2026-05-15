Return-Path: <cgroups+bounces-15986-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EKBLRRqB2oJ2QIAu9opvQ
	(envelope-from <cgroups+bounces-15986-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 20:46:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E185556799
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 20:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43CC2301B935
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA243E16B5;
	Fri, 15 May 2026 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qRvy1mR+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6633F8887
	for <cgroups@vger.kernel.org>; Fri, 15 May 2026 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870577; cv=none; b=OFueX21221tm+Y+t9wkFDHjl62hWcSNjCCujGSTw2fRCzF3H4hEMcfQ6FTKDRjtorrcniPmYk3Lx2XU1J06TTVnjygtOmmrqyb0S754BlBPpeX6gxt1dCKz1ix2ioG1OsTL2sL2KkIqFMSAbGZ0zT67snqa13KtxYg01FkPV0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870577; c=relaxed/simple;
	bh=n8jQYgD+2PRHjYMFDRXsZqBg+Ud73/R4/XfqicTuEpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP35e5oBNM1RTnyeGG+Ngu+HcpUIIuINzEcgwHJRxa/j1zxoR463TEm5ROodBD9j41I5hyCNjJlpXsNsfkVtVvhm25hbD7pYc/i5niVzRM8VdlCq71wK+Us+ShgLVvLAgNe4QWFk/9vxsDp+ADpyrzUFH4r154b88126iKLsiQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qRvy1mR+; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 May 2026 11:42:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778870569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjvRMJtvM6Mkc95mQ7/7EbrQxH9jqXTEFZpG9TrHmG8=;
	b=qRvy1mR+U/vAVR7cDUbzs088r2gSDw15pRWeMOcnGAKJkR3UJjFUdLRmfk00zHrPM1t9FU
	TKrWNMLh8uOBZq7JMKkzgHB49EP5E1uVs/oWEmO1K54BmVr1kkCZYv4CPFflbErxavpRvO
	wL/rqecTS770pdQXOxhk58tdf/o2lp8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] memcg: cache obj_stock by memcg, not by objcg pointer
Message-ID: <agdnTPXhuepuu7hG@linux.dev>
References: <20260515171953.2224503-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515171953.2224503-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 4E185556799
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15986-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 10:19:53AM -0700, Shakeel Butt wrote:
> Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
> per-node type") split a memcg's single obj_cgroup into one per NUMA
> node, but the per-CPU obj_stock_pcp still keys cached_objcg by
> pointer. Cross-NUMA workloads now see a drain on every refill and a
> miss on every consume that targets a sibling per-node objcg of the
> same memcg, producing the 67.7% stress-ng switch-mq regression
> reported by LKP.
> 
> stock->nr_bytes are fungible across per-node objcgs of one memcg:
> drain_obj_stock() and obj_cgroup_uncharge_pages() both account via
> obj_cgroup_memcg(). Treat the cache as keyed by memcg in both
> __consume_obj_stock() and __refill_obj_stock() so siblings share the
> reserve -- eliminating the drain on free and keeping the alloc fast
> path in consume.
> 
> Though kernel test robot reported the regression but it was not easy to
> reproduce locally. Qi implemented [1] a specialized reproducer to show
> the corner case which cause the regression and then Qi tested the patch
> and reported that the corner case is eliminated after the patch.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com
> Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> Link: https://lore.kernel.org/19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev/ [1]
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Debugged-by: Qi Zheng <qi.zheng@linux.dev>
> Tested-by: Qi Zheng <qi.zheng@linux.dev>

Pasting the sashiko review here as it seems interesting and good:

May 15, 2026 at 10:52 AM, sashiko-bot@kernel.org mailto:sashiko-bot@kernel.org  wrote:


> 
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Fungible sharing of stock reserve bytes between per-node objcgs breaks the obj_cgroup_release invariant, causing permanent kmem charge leaks and WARN_ON_ONCE.
> - [High] Missing update to `__account_obj_stock()` bypasses vmstat batching for sibling objcgs, causing severe lock and atomic contention.
> - [High] Calling `obj_cgroup_memcg()` without required RCU or cgroup locks triggers lockdep splats on fast paths.
> --
> 
> commit e77fe5b6af93b69e06c1ccd13f83e26b59234483
> Author: Shakeel Butt <shakeel.butt@linux.dev>
> 
> memcg: cache obj_stock by memcg, not by objcg pointer
> 
> This commit modifies the per-CPU object stock caching to share the reserve
> among per-node sibling obj_cgroups of the same memcg, aiming to reduce
> drains and refills on cross-NUMA workloads.
> 
> Link: https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com
> Link: https://lore.kernel.org/19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev/
> 
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >  index d978e18b9b2d0..66448f4285316 100644
> >  --- a/mm/memcontrol.c
> >  +++ b/mm/memcontrol.c
> >  @@ -3210,7 +3210,11 @@ static bool __consume_obj_stock(struct obj_cgroup *objcg,
> >  struct obj_stock_pcp *stock,
> >  unsigned int nr_bytes)
> >  {
> >  - if (objcg == READ_ONCE(stock->cached_objcg) &&
> >  + struct obj_cgroup *cached = READ_ONCE(stock->cached_objcg);
> >  +
> >  + /* Cache is keyed by memcg; sibling per-node objcgs share the reserve. */
> >  + if ((cached == objcg ||
> >  + (cached && obj_cgroup_memcg(cached) == obj_cgroup_memcg(objcg))) &&
> > 
> Does calling obj_cgroup_memcg() here trigger lockdep warnings on slab fast
> paths?
> 
> Looking at obj_cgroup_memcg(), it expects rcu_read_lock_held() or
> lockdep_is_held(&cgroup_mutex) to be true.
> 
> Since this function is called from slab fast paths where only the local
> CPU stock lock is held, the RCU read lock may not be held.
> 
> Could this check directly compare READ_ONCE(cached->memcg) and
> READ_ONCE(objcg->memcg) to avoid the lockdep assertion?

Yes, this makes sense as we are not really dereferencing the memcg here.

> 
> > 
> > stock->nr_bytes >= nr_bytes) {
> >  stock->nr_bytes -= nr_bytes;
> >  return true;
> > 
> Will sharing the reserve between per-node sibling objcgs without updating
> stock->cached_objcg break the page multiple invariant in
> obj_cgroup_release()?
> 
> If an allocation for objcg_B consumes bytes originally funded by objcg_A,
> and the stock is later drained, those borrowed bytes are flushed into
> objcg_A->nr_charged_bytes.
> 
> When obj_cgroup_release() is invoked, nr_charged_bytes will not be an
> exact multiple of PAGE_SIZE. Will this trigger
> WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1)) and truncate the remainder,
> permanently leaking the page charge from the memcg?

This is actually a very good point and need more thought.

> 
> [ ... ]
> 
> > 
> > @@ -3318,6 +3322,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> >  unsigned int nr_bytes,
> >  bool allow_uncharge)
> >  {
> > 
> [ ... ]
> 
> > 
> > - if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> >  + cached = READ_ONCE(stock->cached_objcg);
> >  + /* Same memcg: bytes are fungible, no drain needed. */
> >  + if (cached != objcg &&
> >  + (!cached || obj_cgroup_memcg(cached) != obj_cgroup_memcg(objcg))) {
> >  drain_obj_stock(stock);
> > 
> Since the stock->cached_objcg pointer is not updated when a sibling is
> already cached, does this bypass the vmstat batching in
> __account_obj_stock()?
> 
> If __account_obj_stock() still requires strict pointer equality
> (READ_ONCE(stock->cached_objcg) == objcg), alternating cross-node
> allocations will continually fail that match.
> 
> Will this force a fallback to direct mod_objcg_mlstate() updates on every
> object allocation and free, causing severe cacheline contention?

This is not that worrying. Yes, the stats update will take slower path. This can
be fixed when we add multiple objcg per-cpu stock.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260515171953.2224503-1-shakeel.butt@linux.dev?part=1
>


