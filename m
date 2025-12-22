Return-Path: <cgroups+bounces-12591-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A522DCD7359
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 22:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34C0A3006720
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE811305962;
	Mon, 22 Dec 2025 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Px0g27Rf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959D26E706
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766439392; cv=none; b=pnclKomrPQyrer1l7pyESa3g7jh7/u241HzEr0+MiTIwXomiBe0+AchQ8CJeJn3H+4pmYv/UVFfWGucgJYTsu/eNkbbXvZIz9k6c2oTEYDAX+5tCeavEh2iUCURGVn/M8+YYWQmY5cLHBlW17R06d2t/CRCODehBARJzBNCCtiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766439392; c=relaxed/simple;
	bh=/S2VXXzc55bsYORWABuNsNmRS5Jboa+arX4cb9CVM9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umgq2SSyL/uYqiqSxbcDxZelKsQanTVGH7XSTRfnF2thuLPdr8ITeD1zi9dJP7gkB1bqgaZqgKCdTMDTSTT3mDgIv+dkJstcdWv7ZnLOS1WYZZxQuKVSND+8nVv4sLWcAArZZketY7gnAsP+od/Le5m2gS6irlwXsWigmlQAsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Px0g27Rf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Dec 2025 13:36:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766439388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsefXJ4KipxZIgZ3+WStAOI/ItAHnWqRJxteZDI57M0=;
	b=Px0g27RfwypVGEVCIEA1bR0D/IOF2AnMmpDn/uIpKPCykX7WcCtn6xTDaXRtOx9EFjCynI
	9KAKYXv3FnayRNLzGouHCzY7D9LPHwApDAaGG2pcbKfyhm5KYAXROXEpqNFQcuYkJ696Hs
	PsabLK+H4u0y3qIsCFs2VTbOv/tapd4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, david@kernel.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, corbet@lwn.net, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, zhengqi.arch@bytedance.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	lujialin4@huawei.com, zhongjinji@honor.com
Subject: Re: [PATCH -next 3/5] mm/mglru: extend shrink_one for both lrugen
 and non-lrugen
Message-ID: <7kwk3bkvhvflsyxgljnxzvrxco2u2rxjcdwqooeboyrkf2oxjj@2nywxl2sc6g5>
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <20251209012557.1949239-4-chenridong@huaweicloud.com>
 <20251215211357.GF905277@cmpxchg.org>
 <6c69c4d9-f154-4ad3-93c8-907fa4f98b27@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c69c4d9-f154-4ad3-93c8-907fa4f98b27@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 16, 2025 at 09:14:45AM +0800, Chen Ridong wrote:
> 
> 
> On 2025/12/16 5:13, Johannes Weiner wrote:
> > On Tue, Dec 09, 2025 at 01:25:55AM +0000, Chen Ridong wrote:
> >> From: Chen Ridong <chenridong@huawei.com>
> >>
> >> Currently, flush_reclaim_state is placed differently between
> >> shrink_node_memcgs and shrink_many. shrink_many (only used for gen-LRU)
> >> calls it after each lruvec is shrunk, while shrink_node_memcgs calls it
> >> only after all lruvecs have been shrunk.
> >>
> >> This patch moves flush_reclaim_state into shrink_node_memcgs and calls it
> >> after each lruvec. This unifies the behavior and is reasonable because:
> >>
> >> 1. flush_reclaim_state adds current->reclaim_state->reclaimed to
> >>    sc->nr_reclaimed.
> >> 2. For non-MGLRU root reclaim, this can help stop the iteration earlier
> >>    when nr_to_reclaim is reached.
> >> 3. For non-root reclaim, the effect is negligible since flush_reclaim_state
> >>    does nothing in that case.
> >>
> >> After moving flush_reclaim_state into shrink_node_memcgs, shrink_one can be
> >> extended to support both lrugen and non-lrugen paths. It will call
> >> try_to_shrink_lruvec for lrugen root reclaim and shrink_lruvec otherwise.
> >>
> >> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >> ---
> >>  mm/vmscan.c | 57 +++++++++++++++++++++--------------------------------
> >>  1 file changed, 23 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 584f41eb4c14..795f5ebd9341 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -4758,23 +4758,7 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
> >>  	return nr_to_scan < 0;
> >>  }
> >>  
> >> -static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
> >> -{
> >> -	unsigned long scanned = sc->nr_scanned;
> >> -	unsigned long reclaimed = sc->nr_reclaimed;
> >> -	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> >> -	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> >> -
> >> -	try_to_shrink_lruvec(lruvec, sc);
> >> -
> >> -	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
> >> -
> >> -	if (!sc->proactive)
> >> -		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
> >> -			   sc->nr_reclaimed - reclaimed);
> >> -
> >> -	flush_reclaim_state(sc);
> >> -}
> >> +static void shrink_one(struct lruvec *lruvec, struct scan_control *sc);
> >>  
> >>  static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
> >>  {
> >> @@ -5760,6 +5744,27 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
> >>  	return inactive_lru_pages > pages_for_compaction;
> >>  }
> >>  
> >> +static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
> >> +{
> >> +	unsigned long scanned = sc->nr_scanned;
> >> +	unsigned long reclaimed = sc->nr_reclaimed;
> >> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> >> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> >> +
> >> +	if (lru_gen_enabled() && root_reclaim(sc))
> >> +		try_to_shrink_lruvec(lruvec, sc);
> >> +	else
> >> +		shrink_lruvec(lruvec, sc);
> > 
> 
> Hi Johannes, thank you for your reply.
> 
> > Yikes. So we end up with:
> > 
> > shrink_node_memcgs()
> >   shrink_one()
> >     if lru_gen_enabled && root_reclaim(sc)
> >       try_to_shrink_lruvec(lruvec, sc)
> >     else
> >       shrink_lruvec()
> >         if lru_gen_enabled && !root_reclaim(sc)
> >           lru_gen_shrink_lruvec(lruvec, sc)
> >             try_to_shrink_lruvec()
> > 
> > I think it's doing too much at once. Can you get it into the following
> > shape:
> > 
> 
> You're absolutely right. This refactoring is indeed what patch 5/5 implements.
> 
> With patch 5/5 applied, the flow becomes:
> 
> shrink_node_memcgs()
>     shrink_one()
>         if lru_gen_enabled
> 	    lru_gen_shrink_lruvec  --> symmetric with else shrink_lruvec()
> 		if (root_reclaim(sc))  --> handle root reclaim.
> 		    try_to_shrink_lruvec()
> 		else
> 		    ...
> 		    try_to_shrink_lruvec()
> 	else
> 	    shrink_lruvec()
> 
> This matches the structure you described.
> 
> One note: shrink_one() is also called from lru_gen_shrink_node() when memcg is disabled, so I
> believe it makes sense to keep this helper.

I think we don't need shrink_one as it can be inlined to its callers and
also shrink_node_memcgs() already handles mem_cgroup_disabled() case, so
lru_gen_shrink_node() should not need shrink_one for such case.

> 
> > shrink_node_memcgs()
> >   for each memcg:
> >     if lru_gen_enabled:
> >       lru_gen_shrink_lruvec()
> >     else
> >       shrink_lruvec()
> > 

I actually like what Johannes has requested above but if that is not
possible without changing some behavior then let's aim to do as much as
possible in this series while keeping the same behavior. In a followup
we can try to combine the behavior part.

> 
> Regarding the patch split, I currently kept patch 3/5 and 5/5 separate to make the changes clearer
> in each step. Would you prefer that I merge patch 3/5 with patch 5/5, so the full refactoring
> appears in one patch?
> 
> Looking forward to your guidance.


