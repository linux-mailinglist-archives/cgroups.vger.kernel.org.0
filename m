Return-Path: <cgroups+bounces-16918-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cxF2JglzLmqIwAQAu9opvQ
	(envelope-from <cgroups+bounces-16918-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2026 11:23:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E5680BBF
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2026 11:23:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16918-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16918-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F5533001B43
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2026 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B0338AC99;
	Sun, 14 Jun 2026 09:23:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA03955E0
	for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 09:23:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781428996; cv=none; b=Q8X/9kaSwvhHAYLItg6dUU2Z2HeK4W8jV13EXx0dlA1JTz+Ydl3JKcqUI9R/oHVnHDt5KY/gwPZ0WRG1bRQjHqUEIFCb1YkpIfR8+xr/NA/fVl+KLTBpkPPSMjG8WoA+/zG3j/S35PY38S3yxz5A6CgYurjyL56CQhPEHNTEwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781428996; c=relaxed/simple;
	bh=ld+wVFU2oJQmVv/sNSfBsHnWdT8YxnJkps1+6Uwbkzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0yGPl4IuKM+geVWHlcjpJf+Kd7WJQjq9IeLMmK97jDApZBYhueBTgFlXh6Q5kfuzkcpYIjy/KH+suerRtatNVHE4AGCJgf9fJgiRWKBob7PUpGJFe2Ob71atRbeE8RLZl3/sE5YJO1VUrC8uzknJrYOV1LELqEjECypzgY3DQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 14 Jun 2026 18:23:03 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sun, 14 Jun 2026 18:23:03 +0900
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
	kasong@tencent.com, baoquan.he@linux.dev, joshua.hahnjy@gmail.com
Subject: Re: [swap tier discussion] Re: [PATCH v3 2/4] mm/zswap: Implement
 proactive writeback
Message-ID: <ai5y923elCSZp41j@yjaykim-PowerEdge-T330>
References: <aicJBVT4pBvmyooT@linux.dev>
 <aicZ-5GX9De3MAU7@linux.dev>
 <CAO9r8zNBJ-BsXyKFveA92jbwMu63uFVTY5CuT4fRHTBVcOjhPw@mail.gmail.com>
 <aictKA0XWMWbxFdN@linux.dev>
 <CAO9r8zPvCaCqvoUhPdAN5Oi_Sj0mK-t7DJhOOz3Xf1DT-Wrgcw@mail.gmail.com>
 <aieUQUBHI+E3uNPW@yjaykim-PowerEdge-T330>
 <airzE7jD9UtyR17J@google.com>
 <aisEWnb3pzmVC4dl@linux.dev>
 <aiu06fbV7rWqY0Bm@yjaykim-PowerEdge-T330>
 <aiw2p5ANjsQUCIHA@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiw2p5ANjsQUCIHA@linux.dev>
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
	FORGED_RECIPIENTS(0.00)[m:shakeel.butt@linux.dev,m:yosry@kernel.org,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:roman.gushchin@linux.dev,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:joshua.hahnjy@gmail.com,m:jiahaokernel@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16918-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 199E5680BBF

....
> >Based on the memcg interface currently proposed in swap_tier
> > (memory.swap.tiers, memory.swap.tiers.effective), I think it aligns well
> > with the current direction. It provides a foundation for selectively
> > targeting devices in tier order.
> 
> Here instead of cpuset like interface, we may want more zswap like interface
> where you can put limit on the usage i.e. memory.swap.tier*.max. We can start
> with allowing only two values i.e. 0 and max which effectively will be the
> same as what you need.
>

Good idea, and it's certainly feasible. When I considered this a while
ago, the reasons I didn't take this direction were:

1. There's no real-world usage for adjusting the swap tier amount (it's
   either 0 or MAX). That said, your suggestion to initially allow only
   0 and max is the killing point, and it's making me reconsider.

2. The implementation cost seems high. The current implementation
   handles this at runtime via simple masking.

3. Relationship with swap.max:
   - If we tie it to the current interface, wouldn't limiting the swap
     amount within a selected tier already be possible? I wonder if
     that alone is enough.
   - If we add tier.max, it would need to be a subset of swap.max.
     (Any other complexities here?)

4. vswap enable/disable: vswap doesn't seem to have an amount-control
   aspect, so an on/off semantic would be clearer.
   https://lore.kernel.org/linux-mm/ai5kOOmR1LPTWs1J@yjaykim-PowerEdge-T330/T/#m8831ec057bf9387978d3bd698f51920600e09a04

In that case, the internal logic could stay roughly the same rather
than counting via a page counter. Something like:

1. Change the interface shell: tier.*.max — allow only 0 ~ max.
2. Keep the internal logic as is: 0 disables the mask (child memcgs
   off too), max enables it (child memcgs on too).
3. memory.zswap.max integrates naturally (it's memory."tier_name".max).
4. Extend later if use cases arise.

On balance I still lean toward the current interface, but if a per-tier
max is the better fit for memcg's direction and others feel the same,
I'm happy to switch. I'd like to hear Shakeel's thoughts again, and I'm
curious about others' opinions too.

A few more perspectives on the points below.

> I will respond to your other points later when I have time.

> > 
> > To summarize the discussions so far, the following points align well.
> > 
> > - Per-cgroup swap control, as I suggested.
> > - Proactive zswap writeback (Hao's usecase)
> > - Swap device target demotion(if it wants selective, then it is more better), as you mentioned:
> >   https://lore.kernel.org/linux-mm/aicZ-5GX9De3MAU7@linux.dev/
> > - Virtual Swap on/off in the future, as Nhat mentioned:
> >   https://lore.kernel.org/linux-mm/20260528212955.1912856-1-nphamcs@gmail.com/
> > - The memory.zswap.writeback alternative (no hierarchy model conflict)
> > - zswap is first swap tier.
> > - Promotion. (Also better for selectve usage)
> > - tier based swap policy (e.g round-robin...)
> > 
> > To accelerate this work, I believe we should reach a consensus and
> > merge the currently proposed swap_tier interface :)
> > 
> > If the above approach is difficult, I would like to suggest an
> > alternative for progress with the memcg interfaces removed:
> > 
> > 1) We could make zswap the first tier and create
> > a use case where memory.zswap.writeback internally is handled by tier logic.
> > 
> > 2) Or simply merge the swap_tier infrastructure itself first.
> > 
> > This would allow the swap_tier infrastructure to be merged and discussed
> > more easily.
> > 
> > If it takes longer to adopt swap_tier anyway, by doing so we progress next step
> > as a experimental feature.
> > 
> > - Apply per-cgroup swap as an experimental (debugfs) feature.
> > - Apply Hao's use case experimentally or as it is as Yosry suggested.
> > (future migration to swap tier)
> > 
> > How do you think?
> > 
> > (FYI: My emails to kernel.org are failing due to internal server issues.)
> > 
> > Thank you 
> > Youngjun Park

Let me clarify a part I wrote confusingly. Handling
memory.zswap.writeback via tiers is possible, but I don't think the
interface itself would be replaced even if memory.swap.tiers is adopted.

Selecting only zswap in memory.swap.tiers would not just disable
writeback.it would also block regular swap entirely, which differs
slightly from the current semantic. (... "Per the cgroup v2 docs: a
zswap-only tier setting is subtly different from setting
memory.swap.max to 0, since it still allows pages to be written to the
zswap pool; this has no effect if zswap is disabled, and swapping is
allowed unless memory.swap.max is set to 0.")

So the interface itself needs to be retained, and it could be extended
toward selective writeback — e.g., passing a desired tier into
memory.zswap.writeback so writeback targets only that tier. Currently
it only controls on/off. Other tiers probably don't need this. demotion
based on the selected tier should be enough.

Thanks,
Youngjun Park

