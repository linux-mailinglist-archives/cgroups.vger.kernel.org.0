Return-Path: <cgroups+bounces-16984-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KlCBDuGgMGqPVgUAu9opvQ
	(envelope-from <cgroups+bounces-16984-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 03:03:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42D568B27F
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 03:03:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16984-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16984-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E05FD301DC26
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 01:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89C2E7367;
	Tue, 16 Jun 2026 01:03:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872CA1D5CFB
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 01:03:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571800; cv=none; b=kOFEyPOa/5gyK8t1Qt5GqzVVWe+PPFdbGqTjR7DyPzrItcKpwyb7OZ0vJFSzkaimGLFoEb1qZ8SVGDGv+QibEH/T1jH9O5IpgKEtHoHKX9B/2BOZjpmGQON8SE87hmvIPhJQcHw4zcUKpMygdSpRkqiyZvmykFxCLj3wsIsT5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571800; c=relaxed/simple;
	bh=jX1mm1IOeJgFXgCq9BYe2NIXn5ungu7YN8snXelcbu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rreFPRwA+YQij6xMgeW/YLw9JoDbDHwSisJeDwqhC1WN6zdYCMmNIIvzrMeMoKxzJZJQYesKKxXSdaTkzWCrT8OQR4sc0QzUROyjifS2DiPXqwceIvh0rJTLZu0vwAcE4kellM0akIbwmiSYuL2Xr75Otiebk9wffczcApQHCm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 16 Jun 2026 10:03:09 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 16 Jun 2026 10:03:08 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Hao Jia <jiahao.kernel@gmail.com>,
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
Message-ID: <ajCgzNIPLhjTRSXR@yjaykim-PowerEdge-T330>
References: <CAO9r8zNBJ-BsXyKFveA92jbwMu63uFVTY5CuT4fRHTBVcOjhPw@mail.gmail.com>
 <aictKA0XWMWbxFdN@linux.dev>
 <CAO9r8zPvCaCqvoUhPdAN5Oi_Sj0mK-t7DJhOOz3Xf1DT-Wrgcw@mail.gmail.com>
 <aieUQUBHI+E3uNPW@yjaykim-PowerEdge-T330>
 <airzE7jD9UtyR17J@google.com>
 <aisEWnb3pzmVC4dl@linux.dev>
 <aiu06fbV7rWqY0Bm@yjaykim-PowerEdge-T330>
 <aiw2p5ANjsQUCIHA@linux.dev>
 <ai5y923elCSZp41j@yjaykim-PowerEdge-T330>
 <CAO9r8zOVqbJEaBqTHw=r2bYw7Lm1tO0TU9QuG+eH1rfqcTAJJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zOVqbJEaBqTHw=r2bYw7Lm1tO0TU9QuG+eH1rfqcTAJJQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:shakeel.butt@linux.dev,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:roman.gushchin@linux.dev,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:joshua.hahnjy@gmail.com,m:jiahaokernel@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16984-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,cmpxchg.org,kernel.org,suse.com,linux-foundation.org,vger.kernel.org,kvack.org,lixiang.com,tencent.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A42D568B27F

On Mon, Jun 15, 2026 at 12:55:09PM -0700, Yosry Ahmed wrote:
> > In that case, the internal logic could stay roughly the same rather
> > than counting via a page counter. Something like:
> >
> > 1. Change the interface shell: tier.*.max — allow only 0 ~ max.
> 
> What about a single interface as I suggested to remain consistent with
> memory tiering?

Hello Yosry!

I agree. As I was implementing the interface for seeing feasibility
, I reconsidered it. Since swap tiers can be added or removed at runtime, 
having static memory."tier_name".max files seems unnatural.

A single interface like `swap.tiers.max` would be better. We can use a
flat-keyed format (similar to io.weight. same as you suggested)

echo ["tier_name"] ["0 or max"] > swap.tiers.max

I am now leaning towards this is a better direction than what I initially
suggested (memory.swap.tiers and memory.swap.tiers.effective).

Considering other reviews and Shakeel's reply, I will update my swap tier
patch accordingly.

> > 2. Keep the internal logic as is: 0 disables the mask (child memcgs
> >    off too), max enables it (child memcgs on too).
> 
> I think a child should be able to disable a swap tier enabled by the
> parent, but not vice versa.

Yes, we are on the same page. I missed a part in my explanation. I meant
that the child's selected tiers should be a subset of the parent's (which
is how the current swap tier suggestion works). 
A child cannot enable a tier that the parent has disabled.

> > 3. memory.zswap.max integrates naturally (it's memory."tier_name".max).
> 
> Not really. memory.zswap.max is in terms of memory usage (compressed
> size), not swap usage (uncompressed size).

I see, memory.zswap.max needs to be maintained separately. I will look
closer into its semantics. I might have misunderstood this part!

> [..]
> > Let me clarify a part I wrote confusingly. Handling
> > memory.zswap.writeback via tiers is possible, but I don't think the
> > interface itself would be replaced even if memory.swap.tiers is adopted.
> >
> > Selecting only zswap in memory.swap.tiers would not just disable
> > writeback.it would also block regular swap entirely, which differs
> > slightly from the current semantic. (... "Per the cgroup v2 docs: a
> > zswap-only tier setting is subtly different from setting
> > memory.swap.max to 0, since it still allows pages to be written to the
> > zswap pool; this has no effect if zswap is disabled, and swapping is
> > allowed unless memory.swap.max is set to 0.")
> 
> I don't understand. How is disabling zswap writeback not equivalent to
> only enabling zswap as a tier?

Isn't there a case where zswap_store() fails and pages fall back to the
backing swap device?

- "zswap tier only": Only zswap is allowed. Fallback to other swap is
  blocked.
- "zswap writeback disabled": zswap is allowed, but if zswap_store()
  fails, pages can still fall back to other swap devices.

Because of this slight semantic difference, I thought they couldn't be
fully unified. If my understanding is correct, we could extend the zswap
tier to select the target swap device for writeback, but replacing the
writeback interface entirely might be difficult.

> Do you just mean the fact that disabling zswap writeback is a noop of
> zswap is disabled? It's a different interface so I think a small

Yes, I think so too.

> semantic difference is okay. In practice, I doubt that zswap is being
> disabled at runtime.

I thought disabling zswap at runtime might have some use cases, but we
can discuss this further when we talk about the patch extending the
zswap tier.

Best regards,
Youngjun

