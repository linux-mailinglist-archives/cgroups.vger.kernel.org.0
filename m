Return-Path: <cgroups+bounces-17819-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4dCMIXseV2pJFgEAu9opvQ
	(envelope-from <cgroups+bounces-17819-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 07:45:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 248C575ABCC
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 07:45:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17819-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17819-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6564D303F2B4
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 05:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8338733C192;
	Wed, 15 Jul 2026 05:45:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184843603DD
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 05:45:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094323; cv=none; b=dfC0ngqM31M8z5ctTzpE7rUwUFZon80kJZoAeOHWJ7gaRjlHQW02yhiPg/GkSdNGZHpUtApPIxsm9cVdWXq79asPExpnBGZz4tzHhSqlOG8rWy2A7+rRnpR2nHF1lRWop0bH5Za9XuaQbsE5xazxvImiM5kq5WYPc8OS7PFNHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094323; c=relaxed/simple;
	bh=Hm28BIe/+uU9DHL2MN8bkkIP3QkbTize3Ism2MWR+1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJFnamCfZnzBCW3OW29/uf+DRdHbopSVE2XlmfD9Pdyp6joCUBzj4uplSyT5xrD/hYJALfcrjW4vKqvLLnGfk2vorwtGka7rLjlQD2d4Gq4is6iJLr0KaixjlUeQiC8HVf7BYZv6vhuCU8xRP0JeD8RkEubU/falEODICxg7vZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.51
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
	by 156.147.23.51 with ESMTP; 15 Jul 2026 14:45:16 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: youngjun.park@lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.1.127 with ESMTP; 15 Jul 2026 14:45:16 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Wed, 15 Jul 2026 14:45:16 +0900
From: Youngjun Park <youngjun.park@lge.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yosry Ahmed <yosry@kernel.org>, akpm@linux-foundation.org,
	chrisl@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kasong@tencent.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	baoquan.he@linux.dev, baohua@kernel.org, joshua.hahnjy@gmail.com,
	gunho.lee@lge.com, taejoon.song@lge.com, hyungjun.cho@lge.com,
	baver.bae@lge.com, her0gyugyu@gmail.com
Subject: Re: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
Message-ID: <alcebHobUCUyO70k@yjaykim-PowerEdge-T330>
References: <20260713025644.170839-1-youngjun.park@lge.com>
 <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
 <alUK8DWRy4LPxTpY@yjaykim-PowerEdge-T330>
 <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
 <alUQ0ksPP00PVwew@yjaykim-PowerEdge-T330>
 <alae-LIRwEFUjgs1@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alae-LIRwEFUjgs1@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17819-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shakeel.butt@linux.dev,m:yosry@kernel.org,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,lge.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 248C575ABCC

On Tue, Jul 14, 2026 at 01:44:28PM -0700, Shakeel Butt wrote:
> Hi Youngjun,
> 
> Thanks for keep pushing this effort.

Hi Shakeel
Huge thanks again for suggestion.

> > Right, that's the plan.
> > 
> > > but I would check all
> > > user-visible behaviors related to zswap (e.g. interaction with other
> > > zswap interfaces) to make sure nothing breaks or changes in a
> > > meaningful way when zswap is introduced as a tier later.

At now, the answer is there are nothing breaks or changes as a first review.
I think it'll be better to introduce zswap tier after this patch.
(Details are going on the below)

> > Fair point. Let me review this more and get back to you!
> 
> Please do report back what you find.
> 
> Yosry, what is needed to enable zswap as a swap tier? What will be the minimum
> requirements for that? If that is not too much, we can make that part of this
> series.
> 
> Shakeel

I tried to verify what changes once the zswap tier is introduced.
Please correct me if I'm wrong!

First observation: before the zswap tier is introduced, some of this
is already possible today:

  - a "zswap-only" tier equivalent on cgroup: memory.zswap.writeback = 0
  - disabling zswap entirely on cgroup: memory.zswap.max = 0
  - disabling swap (and zswap) entirely on cgroup: memory.swap.max = 0

Given that, my take is that introducing the tier concept itself
doesn't change any user-visible zswap behavior, since on/off control
for the zswap tier is basically already possible today through other
knobs. So this isn't really a user-facing problem; it's more
something we need to think through carefully in the patch that
introduces the tier concept itself. That's what the points below are
about.

The cgroup interface knobs and the zswap-global knobs need a
different kind of review, so let's start with the global ones. The
zswap-global knobs (compressor, max_pool_percent,
accept_threshold_percent, shrinker_enabled) look fine with tiers.
They're zswap-internal tuning, orthogonal to the tier concept, so
tiers shouldn't change their behavior. The remaining one, "enabled",
does overlap in spirit with the tier on/off knob: enabled = false is
basically the same as disabling zswap for every cgroup. But like the
other overlaps below, this doesn't look like a real problem.

The part that needs more thought is the overlap between
memory.zswap.max / memory.zswap.writeback, memory.swap.max, and the
new tier on/off knob. Since all of the above is already possible
today, adding a tier on top means we should make sure it doesn't
create confusing overlap.

1) memory.swap.max vs. tier on/off

   memory.swap.max = 0 disables swap (and zswap) entirely, and
   memory.swap.max = max leaves everything enabled, so one knob can
   make the other a no-op. I don't think this is confusing in
   practice; they're just two independent ways to reach the same end
   state.

   Conceptually, the tier knob controls on/off/auto-scale, while
   memory.swap.max controls pure quantity, so they cover different
   concerns and can coexist. Even if the tier knob later takes a
   numeric value, that number would apply per tier, while swap.max is
   a total budget that doesn't care how the tiers split it up, so
   they still shouldn't step on each other.

2) memory.zswap.max vs. zswap tier on/off

   memory.zswap.max = 0 looks semantically equivalent to turning the
   zswap tier off. Could memory.zswap.max simply be folded into
   memory.<zswap_tier_name>.max?

   Yosry pointed out:

   > > memory.zswap.max integrates naturally (it's
   > > memory.<tier_name>.max).
   > Not really. memory.zswap.max is in terms of memory usage
   > (compressed size), not swap usage (uncompressed size).

   I'm not sure where the tier limit would actually apply here: is it
   checked in zswap_store() against the pre-compression size, while
   memory.zswap.max keeps tracking the compressed size? If so, once
   you give the tier limit a number, wouldn't its usage end up
   meaning basically the same thing as memory.zswap.max? For limit =
   0 the two already look identical to me (both just block zswap
   usage). I'd like to understand what benefit a non-zero tier limit
   (uncompressed) gives us over the existing memory.zswap.max
   (compressed), once tiers exist. Let me know if I'm missing
   something here.

   Also note the mixed states this creates:

     - memory.zswap.max has room, but the tier is off, so zswap can't
       be used.
     - memory.zswap.max = 0, but the tier is on, so zswap still can't
       be used.

   Both knobs can independently block zswap usage, which seems worth
   flagging even if it's not harmful by itself.

   On top of that, the tier knob is likely to stay on/off/auto-scale
   without a numeric limit, while memory.zswap.max only handles the
   numeric side, so the two should coexist as is. If the tier ever
   gains its own numeric limit, we'd need to revisit unifying it with
   memory.zswap.max.

3) memory.zswap.writeback vs. a "zswap-only" tier

   memory.zswap.writeback = 0 can act like a zswap-only tier today,
   because zswap still borrows a slot from the real swap device to
   store data; writeback = 0 just skips writing that data out to the
   device . A tier restriction works differently: it applies at
   allocation time, so a zswap-only tier would block allocating any
   slot from another device. Since zswap currently depends on that
   very slot to store anything, this would break zswap instead of
   giving us a working zswap-only mode, so the tier restriction can't
   substitute for memory.zswap.writeback here.

   With vswap, this changes: tier off and writeback = 0 converge to
   the same effect(right now the pure zswap only tier),
   since zswap no longer needs to borrow a slot from
   another device. Even so, memory.zswap.writeback still needs to
   stay, since vswap itself can be disabled at compile time or
   runtime, and we'd still need a way to express zswap-only behavior
   without it. I'd like to unify the two eventually, but for now they
   have to stay separate. I'll keep thinking about it.

How do you think?

thanks
Youngjun

