Return-Path: <cgroups+bounces-16893-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RjmALPi0K2pGCQQAu9opvQ
	(envelope-from <cgroups+bounces-16893-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 09:27:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FDE67737E
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 09:27:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16893-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16893-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52B3930D7979
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 07:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22EB2EC0B0;
	Fri, 12 Jun 2026 07:27:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2863955CE
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 07:27:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249268; cv=none; b=FzrPU07CU3XrEUTpSt+serXWzQRBou/h/I9xD77nKYhATCJYu8RU+4PbXWq9RfbqOzMtomZNm9xbANNcQhXUyN7DqyIMEylp4NJ1Vj/qtrvlcVnrF/AWZbnITHMKnkivhJO3nqpkyvWN2o7U8S6PW7QKGsAk/eV+OGfrx+x1its=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249268; c=relaxed/simple;
	bh=OYWXsPG8UewcUGUYPqG+FW2ak5otVsvhS6Zi21qeS0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiZRiTKkPXuV+SGJI5cV7wnUP9158HwLT4m/bv+Slh+n5k6YUooV7H6J1DdSkL9EqBbUlvVK3v+ia8LXpvcfbnIuykxq33ScyjiDjHP+d3cTxiLWpB8VIUE/bcql8FID5j+BVzh1C2UT8aGF0Mcuj7rTAqCPv+bbmJCTNY6ZJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 12 Jun 2026 16:27:37 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 12 Jun 2026 16:27:37 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yosry Ahmed <yosry@kernel.org>, Hao Jia <jiahao.kernel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org,
	tj@kernel.org, mkoutny@suse.com, roman.gushchin@linux.dev,
	Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>, chrisl@kernel.org,
	kasong@tencent.com, baoquan.he@linux.dev
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
Message-ID: <aiu06fbV7rWqY0Bm@yjaykim-PowerEdge-T330>
References: <6db27a22-cc7a-9a94-db3f-c912fd39aa32@gmail.com>
 <CAO9r8zM4SDdTgz9L2s1VfXL8K2VBjMD9ej2BTDxaGge1t2+quA@mail.gmail.com>
 <aicJBVT4pBvmyooT@linux.dev>
 <aicZ-5GX9De3MAU7@linux.dev>
 <CAO9r8zNBJ-BsXyKFveA92jbwMu63uFVTY5CuT4fRHTBVcOjhPw@mail.gmail.com>
 <aictKA0XWMWbxFdN@linux.dev>
 <CAO9r8zPvCaCqvoUhPdAN5Oi_Sj0mK-t7DJhOOz3Xf1DT-Wrgcw@mail.gmail.com>
 <aieUQUBHI+E3uNPW@yjaykim-PowerEdge-T330>
 <airzE7jD9UtyR17J@google.com>
 <aisEWnb3pzmVC4dl@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aisEWnb3pzmVC4dl@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shakeel.butt@linux.dev,m:yosry@kernel.org,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:roman.gushchin@linux.dev,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16893-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,cmpxchg.org,suse.com,linux.dev,linux-foundation.org,vger.kernel.org,kvack.org,lixiang.com,tencent.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lge.com:from_mime,yjaykim-PowerEdge-T330:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3FDE67737E

On Thu, Jun 11, 2026 at 12:12:40PM -0700, Shakeel Butt wrote:
> On Thu, Jun 11, 2026 at 05:45:04PM +0000, Yosry Ahmed wrote:
> > On Tue, Jun 09, 2026 at 01:19:13PM +0900, YoungJun Park wrote:
> > > On Mon, Jun 08, 2026 at 03:27:07PM -0700, Yosry Ahmed wrote:
> > > 
> > > +Chris +Kairui +Baoquan
> > > 
> > > Hello
> > > 
> > > Thanks for inviting me to the discussion, Shakeel.
> > > 
> > > > > > > Youngjun is working on swap tiers. At the moment he is more interested in
> > > > > > > allowing a specific swap device to a memcg or not. I can imagine in future there
> > > > > > > will be use-cases where there will be a need to demote data on higher tier swap
> > > > > > > to lower tier swap. What would be the appropriate interface?
> > > 
> > > Speaking of my work on swap tiers, I recently submitted a patch and am
> > > currently considering memcg integration:
> > > https://lore.kernel.org/linux-mm/20260527062247.3440692-1-youngjun.park@lge.com/
> > > 
> > > The future use-cases imagined above seem to align with this
> > > direction. (BTW, I am currently waiting for reviews/feedback from the memcg
> > > folks on this patch. Any reviews would be highly appreciated!)
> > > 
> > > We could potentially assign a target tier
> > > for writeback within the existing memory.zswap.writeback interface. 
> > > 
> > > For instance, '0' could mean disabled, while non-zero values could represent
> > > specific tiers, which would maintain backward compatibility with the current
> > > version. Alternatively, if zswap is treated as the default top tier, 
> > > the `memory.swap.tiers` interface could potentially replace `memory.zswap.writeback`.
> > > 
> > > Furthermore, this could be expanded so that each swap tier can demote data
> > > user-triggered demotion between swap tiers.
> > > 
> > > Based on the current patch's ideas combined with my swap tiers concept:
> > > 
> > > Assuming a hierarchy like:
> > > zswap -> tier1 (SSD swap) -> tier2 (HDD swap) -> tier3 (Network swap)
> > > 
> > > We could configure the active tiers via a setting like `memory.swap.tiers`
> > > (tier2 enabled, tier3 enabled).
> > > 
> > > For example, the concept of `echo "100M zswap_writeback_only > memory.reclaim"`
> > > could be extended. A user could run `echo "100M tier2 > memory.reclaim"`
> > > to explicitly trigger demotion from tier2 to tier3.
> > > (BTW, if we combine these features, my personal preference for the keyword
> > > format would be `<size> <demote_prefix><tier_name>`. I think it would be
> > > better to explicitly indicate that it is a swap demotion by using a specific
> > > prefix followed by the tier name. 
> > > Or make demote prefix another key is also possible)
> > 
> > I am not sure if proactive demotion between swap tiers would be driven
> > by memory.reclaim, I am guessing a new interface might be more suitable.
> > But yes, you are right that it's very possible that
> > 'zswap_writeback_only' with memory.reclaim will become obsolete once
> > swap tiering matures and starts supporting things like proactive
> > demotion.
> > 
> > Part of me wants to wait until the swap tiering interfaces are figured
> > out so that we don't end up with redundant interfaces, but I also don't
> > want to hold Hao's work since it doesn't directly depend on swap
> > tiering.
> However I would need zswap folks (Yosry & Nhat) help in figuring out swap tiers
> interfaces. Zswap is the current top tier swap usage in real world. I want
> zswap users to eaily (and hopefully transparently) migrate to swap tiers.

> > Shakeel, how do you want to handle this? I think there's a few options:
> > 
> > 1. Add zswap_writeback_only now, and when we have swap tiering demotion
> > it becomes a redundant interface, like memory.zswap.writeback -- or
> > maybe we try to deprecate both of them at that point. It's difficult to
> > remove interfaces tho, but maybe easier to stop supporting
> > zswap_writeback_only.
> > 
> > 2. Add zswap_writeback_only behind an experimental config option, to
> > unblock development but have a line of sight to dropping support once we
> > have a swap tiering interface.
> > 
> > 3. Wait until we figure out the swap tiering interfaces and then add
> > the proactive zswap writeback as part of it.
> > 
> > WDYT?
> 
> Is Hao's work needed for some followup work/development? The earliest Hao's
> work can is 7.3, so if we aim to figure out swap tiering interfaces in next
> couple of weeks then option 3 is the way to go. If swap tiers take more time
> then we can discuss other options as well.
> However I would need zswap folks (Yosry & Nhat) help in figuring out swap tiers
> interfaces. Zswap is the current top tier swap usage in real world. I want
> zswap users to eaily (and hopefully transparently) migrate to swap tiers.

I am looking forward to the discussion on this interface!

To help boost the discussion and progress, I would like to share a few of my thoughts.
We could either introduce a new interface to trigger demotion/promotion,
or we could reuse the existing one (using tier just internally)

Based on the memcg interface currently proposed in swap_tier
(memory.swap.tiers, memory.swap.tiers.effective), I think it aligns well
with the current direction. It provides a foundation for selectively
targeting devices in tier order.

To summarize the discussions so far, the following points align well.

- Per-cgroup swap control, as I suggested.
- Proactive zswap writeback (Hao's usecase)
- Swap device target demotion(if it wants selective, then it is more better), as you mentioned:
  https://lore.kernel.org/linux-mm/aicZ-5GX9De3MAU7@linux.dev/
- Virtual Swap on/off in the future, as Nhat mentioned:
  https://lore.kernel.org/linux-mm/20260528212955.1912856-1-nphamcs@gmail.com/
- The memory.zswap.writeback alternative (no hierarchy model conflict)
- zswap is first swap tier.
- Promotion. (Also better for selectve usage)
- tier based swap policy (e.g round-robin...)

To accelerate this work, I believe we should reach a consensus and
merge the currently proposed swap_tier interface :)

If the above approach is difficult, I would like to suggest an
alternative for progress with the memcg interfaces removed:

1) We could make zswap the first tier and create
a use case where memory.zswap.writeback internally is handled by tier logic.

2) Or simply merge the swap_tier infrastructure itself first.

This would allow the swap_tier infrastructure to be merged and discussed
more easily.

If it takes longer to adopt swap_tier anyway, by doing so we progress next step
as a experimental feature.

- Apply per-cgroup swap as an experimental (debugfs) feature.
- Apply Hao's use case experimentally or as it is as Yosry suggested.
(future migration to swap tier)

How do you think?

(FYI: My emails to kernel.org are failing due to internal server issues.)

Thank you 
Youngjun Park

