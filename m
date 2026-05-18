Return-Path: <cgroups+bounces-16042-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COmCNk1cC2ppGAUAu9opvQ
	(envelope-from <cgroups+bounces-16042-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 20:37:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5245725AD
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 20:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC7F9306929A
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F638AC90;
	Mon, 18 May 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oMay0ixZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54638A716
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129169; cv=none; b=TLl0BO1shNBwA003v4l0ak8wckXXQ/3nkPBb/yp16tYIiFBsNJjuU3wVlXAU1lyiSS0bjMznp2jZ2s5QNipwfPR3t3hc1x4gYwiJav1oRrro8KPic9FFK3LtY+yKAkLf1JudY4tT3HheWrxuHmQwgqpIreifhryw8McxuCz714c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129169; c=relaxed/simple;
	bh=BuwAlBQNUrzN0SwgsF4mfLwvIdFbOc/B84lH4N4VHpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4ZGShJC1+Jd7Tq+tJFSu4gjOrFFVWvr000B2JSAuYJrHFKzGW1lgKMNyc4NPib9Bj8Gjlj8ehpNmTk+R9baJpON8EIyvzyUpywvPP7xeXYXMJXRnFqu36NjlRaNsr5feBiUF9UWRvhzC8/DCeuWazKgLU+0+4OSNKGF8V+z/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oMay0ixZ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 May 2026 11:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779129155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXHUYRMce7ARIc5s4WnL47A3d01wGcNanUodNfVijnI=;
	b=oMay0ixZ8rUB5vFEuLI8LeuR0E7rii2KoCUvRIRwi9ahQcInm6XJsG/kmSCF3JIPGhEOij
	df40rL6/I/w4/poq/oF9Ydo/WfNP9U/69c7BkPH3Fv0HnP/eYUg0ym+ycUfYXVIsfFdFva
	1GYmVy1PqokvefTdam4LyFdtnr1wlOY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, alex@ghiti.fr, joshua.hahnjy@gmail.com
Subject: Re: [PATCH v2] memcg: cache obj_stock by memcg, not by objcg pointer
Message-ID: <agtZWXhtXSfLQ4GW@linux.dev>
References: <20260517194308.952655-1-shakeel.butt@linux.dev>
 <ags818dAvMjylVmP@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ags818dAvMjylVmP@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16042-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,meta.com,kvack.org,vger.kernel.org,intel.com,ghiti.fr,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 4A5245725AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 09:46:04AM -0700, Shakeel Butt wrote:
> Cc Alex, Joshua (since they are working on making per-num kmem accounting work)
> 
> On Sun, May 17, 2026 at 12:43:08PM -0700, Shakeel Butt wrote:
> > Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
> > per-node type") split a memcg's single obj_cgroup into one per NUMA
> > node, but the per-CPU obj_stock_pcp still keys cached_objcg by
> > pointer. Cross-NUMA workloads now see a drain on every refill and a
> > miss on every consume that targets a sibling per-node objcg of the
> > same memcg, producing the 67.7% stress-ng switch-mq regression
> > reported by LKP.
> > 
> > stock->nr_bytes are fungible across per-node objcgs of one memcg.
> > Treat the cache as keyed by memcg in __consume_obj_stock() and
> > __refill_obj_stock() so siblings share the reserve. Compare via
> > READ_ONCE(objcg->memcg) directly: pointer-compare only, no deref, so
> > the rcu_read_lock contract on obj_cgroup_memcg() does not apply.
> > 
> > In the same-memcg refill path also fold the incoming objcg's
> > nr_charged_bytes into the stock; otherwise sub-page residue
> > accumulates on whichever sibling was cached at drain time and
> > obj_cgroup_release() silently drops it, leaking up to nr_node_ids *
> > (PAGE_SIZE - 1) bytes per memcg lifecycle from the page_counter.
> > This issue was reported by Sashiko.
> > 
> > Update the now-stale invariant comment on __account_obj_stock().
> > 
> > Qi Zheng built a specialized reproducer [1] for the corner case and
> > confirmed the fix.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com
> > Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> > Link: https://lore.kernel.org/19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev/ [1]
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Debugged-by: Qi Zheng <qi.zheng@linux.dev>
> > Tested-by: Qi Zheng <qi.zheng@linux.dev>
> 
> Sashiko [1] reported two issues. First one seems benign but the second one is
> real. However I think we need to take a step back and rethink on how to solve
> this issue in more future proof way.
> 
> It seems like Alex and Joshua are working on enabling per-node kmem accounting
> and that would need accurate per-numa association for each per-node objcg.
> So, checking objcg->memcg in consume and refill, would go against the per-node
> kmem accounting.
> 
> One way to fix the regression and be future proof is to follow the approach we
> have for memcg_stock_pcp which is multiple per-cpu objcg stocks. We will need to
> test it more and depending on the additional code complexity, we will need to
> decide to backport it to 7.2 or not.
> 
> 
> [1] https://sashiko.dev/#/patchset/20260517194308.952655-1-shakeel.butt@linux.dev?part=1
> 

Previously I had prototyped the multiple per-cpu objcg stocks (when I worked on
multi-memcg percpu stock) which I just rebased on latest linux-next and sent [1].

That patch is additional 100 LOC. For upstreaming, I will break it up into at
least 4 patches. However I am questioning about backporting them to 7.1. One
thing I can do is fix whatever sashiko is asking for and send v3 which can be
ported to 7.1 and then later for 7.2+, revert this short term fix and send out
the multiple objcg patch series.

Any concerns?

[1] http://lore.kernel.org/agtPMpQK2jXdQAY4@linux.dev



