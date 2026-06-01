Return-Path: <cgroups+bounces-16500-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIgVBMf/HGqOUwkAu9opvQ
	(envelope-from <cgroups+bounces-16500-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 05:43:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDEC619485
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 05:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20614301A92B
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 03:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BC32E0B5C;
	Mon,  1 Jun 2026 03:42:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB62626980F
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780285363; cv=none; b=gTSUcPzUp3HdNObpqR1sKUHTL9M5Jzucfh/sAYoa0XuswHzhtff6m2Fzx1Rpy/7Q5cooWrUBZg9TxOgwskpSVYHEX/wMXKDyBORh8fvMW/RYgMu2wFHDu5zGMWgVKsqyme8EJdX1pAwYJ3idrU5fhOBcuhk2SCfIzBpDimQ8+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780285363; c=relaxed/simple;
	bh=YBCR2RQomPE4IN891SgSOPjZ0P8M5tBxihEkdGWPOBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4gDfwb0wgtk0rUeyuMXfSCY6tlyy8lHW3f7Rkx7fWiDec88Cm1SAyVMyaVhafuj192B7ZSdsbypBuN2TNHt2+xuutrinuP+jP6tcnd03HWoUeFjzCWFlGFJUh2MemQEoc+Z+8rsHD5tUA669HujEObRPa4ohT23neyLdgHVgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 1 Jun 2026 12:42:32 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Mon, 1 Jun 2026 12:42:31 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	baoquan.he@linux.dev, baohua@kernel.org, gunho.lee@lge.com,
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com,
	baver.bae@lge.com, matia.kim@lge.com
Subject: Re: [PATCH v7 0/4] mm: swap: introduce swap tier infrastructure
Message-ID: <ahz/p7oE6vDvKnPx@yjaykim-PowerEdge-T330>
References: <20260527062247.3440692-1-youngjun.park@lge.com>
 <CAKEwX=PkiWdgNtoHberaXafQDoDngw5kycfaXeU22MnrXBoAXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=PkiWdgNtoHberaXafQDoDngw5kycfaXeU22MnrXBoAXQ@mail.gmail.com>
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16500-lists,cgroups=lfdr.de];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5EDEC619485
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 11:02:03AM -0700, Nhat Pham wrote:
> On Tue, May 26, 2026 at 11:23 PM Youngjun Park <youngjun.park@lge.com> wrote:
> >
> > This is v7 of the swap tier series addressing review feedback.
> > The cover letter has been simplified.
> >
> > I revisited the design (see Design Rationale). Since our use case
> > fits best with a memcg-based model, the implementation remains
> > within memcg and preserves its resource accounting semantics.
> >
> > Alternatives considered:
> >
> > 1. A separate sysfs interface under swap. (Workable. But, it would still
> >    need to reference memcg paths, and fully decoupling it would add
> >    swap-layer logic to manage memcgs, making it secondary option.)
> >
> > 2. Making the feature non-default.
> >
> > Other interfaces were also reviewed. Aside from sysfs and BPF,
> > the options involve trade-offs and are largely design choices.
> > BPF was excluded due to possible disablement on our embedded
> > platform, though future extension remains possible.
> >
> > Overview
> > ========
> >
> > Swap Tiers group swap devices into performance classes (e.g. NVMe,
> > HDD, Network) and allow per-memcg selection of which tiers to use.
> > This mechanism was suggested by Chris Li.
> >
> > Design Rationale
> > ================
> >
> > Swap tier selection is attached to memcg. A child cgroup may select a
> > subset of the parent's allowed tiers.
> >
> > This
> > - Preserves cgroup inheritance semantics (boundary at parent,
> >   refinement at child).
> > - Reuses memcg, which already groups processes and enforces
> >   hierarchical memory limits.
> > - Aligns with existing memcg swap controls (e.g. swap.max, zswap.writeback)
> > - Avoids introducing a parallel swap control hierarchy.
> >
> > Placing tier control outside memcg (e.g., via BPF, syscalls, or
> > madvise) would allow swap preference to diverge from the memcg
> > hierarchy. Integrating it into memcg keeps the swap policy
> > consistent with existing memory ownership semantics. There are
> > also real use cases built around memcg.
> >
> > In the future, this can be extended to other interfaces to cover
> > additional use cases.
> >
> > I believe a memcg-based swap control is a good starting point
> > before such extensions.
> >
> > Use Cases
> > =========
> >
> > #1: Latency separation (our primary deployment scenario)
> >   [ / ]
> >      |
> >      +-- latency-sensitive workload  (fast tier)
> >      +-- background workload         (slow tier)
> >
> > The parent defines the memory boundary.
> > Each workload selects a swap tier via memory.swap.tiers according to
> > latency requirements.
> >
> > This prevents latency-sensitive workloads from being swapped to
> > slow devices used by background workloads.
> >
> > #2: Per-VM swap selection (Chris Li's deployment scenario)
> >   [ / ]
> >      |
> >      +-- [ Job on VM ]              (tiers: zswap, SSD)
> >             |
> >             +-- [ VMM guest memory ]  (tiers: SSD)
> >
> > The parent (job) has access to both zswap and SSD tiers.
> > The child (VMM guest memory) selects SSD as its swap tier via
> > memory.swap.tiers. In this deployment, swap device selection
> > happens at the child level from the parent's available set.
> >
> > #3: Tier isolation for reduced contention (hypothetical)
> >   [ / ]                    (tiers: A, B)
> >      |
> >      +-- workload X        (tiers: A)
> >      +-- workload Y        (tiers: B)
> >
> > Each child uses a different tier. Since swap paths are separated
> > per tier, synchronization overhead between the two workloads is
> > reduced.
> >
> > Future extension
> > ================
> >
> > #1: Intra-tier distribution policy:
> >   Currently, swap devices with the same priority are allocated in a
> >   round-robin fashion. Per-tier policy files under
> >   /sys/kernel/mm/swap/tiers/ can control how devices within a tier
> >   are selected (e.g. round-robin, weighted).
> >
> > #2: Inter-tier promotion and demotion:
> >   Promotion and demotion apply between tiers, not within a single
> >   tier. The current interface defines only tier assignment; it does
> >   not yet define when or how pages move between tiers. Two triggering
> >   models are possible:
> >
> >   (a) User-triggered: userspace explicitly initiates migration between
> >       tiers (e.g. via a new interface or existing move_pages semantics).
> >   (b) Kernel-triggered: the kernel moves pages between tiers at
> >       appropriate points such as reclaim or refault.
> >
> > #3: Per-VMA, per-process swap and BPF:
> >   Not just for memcg based swap, possible to extend Per-VMA or per-process swap.
> >   Or we can use it as BPF program.
> >
> > Experimentation
> > ===============
> >
> > Tested on our internal platform using NBD as a separate swap tier.
> > Our first production's simple usecase.
> >
> > Without tiers:
> > - No selective control over flash wear
> > - Cannot selectively assign NBD to specific applications
> >
> > Cold launch improvement (preloaded vs. baseline):
> > - App A: 13.17s -> 4.18s (68%)
> > - App B: 5.60s -> 1.12s (80%)
> > - App C: 10.25s -> 2.00s (80%)
> >
> > Performance impact with no tiers configured:
> > <1% regression in kernel build and vm-scalability benchmarks
> >
> 
> Bit late to the party - working on my review backlog right now :)
> 
> I see some parallels with this and memory tiering work being done. One
> future line of work could be considering how to ensure fairness when
> multiple cgroups share same tiers:
> 
> https://lwn.net/Articles/1073400/

Hi Nhat,

Thanks for bringing this up. I took a quick look at the link, and I agree
with your point. We could probably use a similar proposed mechanism (e.g., setting
min/max limits per tier) to handle promotion and demotion in the future.

This also suggests that keeping the swap tier limits inside the memcg
interface is a reasonable approach. It aligns well with such future work.
If it were implemented in other layers (e.g., prctl, sysfs, or BPF), we
would likely have to revisit its integration with memcg someday anyway.

> and occupy all the space in the faster tier(s), pushing the other
> colocated tenants to the slower tier(s). We might need to figure out a
> way to ensure fairness here (while letting cgroups occupy fast swap
> backends opportunistically if there is no resources scarcity).

Agreed. Ensuring fairness will be essential when we eventually expand
the promotion and demotion mechanisms across swap tiers.

Thanks,
Youngjun

