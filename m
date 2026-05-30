Return-Path: <cgroups+bounces-16482-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APa+GKImG2qf/ggAu9opvQ
	(envelope-from <cgroups+bounces-16482-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 20:04:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CEB610EC4
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 20:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41152301E9AA
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D263BA232;
	Sat, 30 May 2026 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHw2cGuC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271A33F5A0
	for <cgroups@vger.kernel.org>; Sat, 30 May 2026 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164137; cv=pass; b=p3wX14ZW3S+rpc9+DkfB5bAovgySGPsK6RGU9nuKeB3pHBEaKkJP7dnlKB7+WKN4F8EXDsOseLjr01JzmYIgNrlMfBmCyxxHK5NXNc4fGKam4+dNIuF956VN6D1ket0DGIS3CMLsWkkiYtCO7L1IYJ6wx9xnT18XHN8JaOEVAoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164137; c=relaxed/simple;
	bh=WZ6UimSYjE+HxBSTft/L7g+IPOEOLUK/a9+Q+mVUk6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9qUH+X9BBbp2bY/ZzhDsc2MgSxi8XH/0LHB+QgcQQm9IBeUtEaShFxVA1guSco9Ofct/DuQnxaOksMgd0rTSsiFWXy66P4Mnr0yT7mzRpR1H09DdpGtF+FhO9iArU9h2jIZSkgsoWzFz+YhcvAa0SwNnxQfDJ3D+S6WtpYCKuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHw2cGuC; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a7a9f81bso63425e9.1
        for <cgroups@vger.kernel.org>; Sat, 30 May 2026 11:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780164135; cv=none;
        d=google.com; s=arc-20240605;
        b=G3r7HvP6SsSF7Z7NcJFy99es8kl9vp4OtjeSx1eEAAgcrkiDwyL3TYxjxecUyaaEwH
         sknTPViOyWSuIUtDC6Sx+6QG1D1GZ5OzboJK3VWt7wfO6ni0oCJlP/cMFeMQNik0nYyN
         8nGXJb34Gq5FwS4cgDUWEke8RvWxCm4QvwaPSWJpmhlVcqwL2rKiH4RrFNePu9hq26AF
         8+dS/sNi+LkUh7avk+/NTaxRO+RhkyLjWksXqXQfpKqmw9pRPPh3mHoQJe29/sqQ8b6V
         /4cZ4RN4d8x9WKR13laUI7iy4ildfq2kyzroI9rDF6lMxgC6e360XrbDgygMH877kNB4
         ljrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+ga18sFo9W9MUc2fn4OlM42GAS8XhXOzY2C140cpNYs=;
        fh=XHnG7UC1fcEo1wNCD/F8ZFb/nQExqPdEDDBhSyjzaD0=;
        b=S0M8Y1pvbVBQIY89OLYsYUO08K8PMdRnVOt+0C7etj1LwPRbIy3cdXa/afy408dQzU
         JhapHTxQBfGNRpJsuNYZ1OG5KHxf/t+ZNGwmjm+E3V++scFTX5ZxQmqeyjlrUjlnWBbz
         1XocRYpdK1TW7nChgsdTZyOJbEPo7LbX1dnpUY6hgYG42MVBC+kZxs1MdRPiclBaPFe+
         33VIopC+HpVCA/AC44/tphxZWlIQFvNoezbQE6OJ3tRDyGxFl+JDuJmKylA8jsor/GBV
         Uj9Eh1pwlG83P8eE4u/opIihUZftEx5KzErdDTL2qIm7Gz7b44g0mGy4bayMzQzvVFTI
         shsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780164135; x=1780768935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ga18sFo9W9MUc2fn4OlM42GAS8XhXOzY2C140cpNYs=;
        b=sHw2cGuCtTRhBchv/9EoK8GV4PI0SZQT64avt9pGPEWqGcH0ukGqyvPMuJUFqPXENp
         4yS22dJWrAqjYs49miWBIwuO700WAFnL7BPCtpQ0KZjeyWl0cq/ilgL/LAojPV0YKA4f
         JUtjXXcLfwy/73O1cfSvoUD1lFQB1pYtrPC9FdJkNHFEbx7lWK0/4hCCt3jXBUD0Bme8
         NcAELG18QTH62r9XK8e4L4wUjuv8VwXDjwYTtXBLDCjb3P05k6ztjj92g1O+Aj69qN+w
         0L5az2qV2HB/TbVEsPnDjilNvOyK06wmZLG7pqLT/I0OB9QHJdsxn7esMMRq5Fb+RR/i
         eHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780164135; x=1780768935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ga18sFo9W9MUc2fn4OlM42GAS8XhXOzY2C140cpNYs=;
        b=UAfGryGV7tL6eBXlkBnOlrYwFEEwF/TsLa+ZAMqRg3Ec1lFQAb/U53cyhYhgRAXqBT
         E7Hp+0niyDzZqtFIbZih4vfaKHd/zmK4U0LIdVu2/HE+kGrpVR7J629K4Sk2T23+HRxU
         BRxuFTPiOCSUrvqGBRR6fvpHuXwc62IRdP+Q1jNrMx1CCKe3BE9099AOUMaX01wr91CS
         2TiFlz8jYU852h3w8O25VlWYHOpvaEWpZ5kLp6ErhYYREXTOBElm6RCzr4RnzbXYAP8G
         6kRPmVDmVClVGmcINNG2NSxxgVZTihfB3RfTDmjuzKzc/thkcPVI4PNUO8i90q4GXbwA
         u79A==
X-Forwarded-Encrypted: i=1; AFNElJ/FVL5YtCPg628HGYRuDpShHDHHSDtv9YjUsLv4r/QCRy5USQhUOFQPxhxw2ntwXinRQaj/Y+Im@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHN5zCHSWtgFrnGEK0u5aZtj1c1AlvAp6qTcLMZfDRqjnxsZ4
	M0QFSdhh/aHxUx4CCkcHaA3rivVJOjulyI+y6RQiOnrRVCoXVzeLsYxPuolOOX5yimdHIJY3j2E
	YBUZWj/mtCFg1OLSRkh6I5NsrqneXzuA=
X-Gm-Gg: Acq92OGcaa0Xy6PrQmqOSyijrYWkMqqWncOfTAMGjUgFeV704igl4wSz39XS66bCwzY
	brVD0pP2F9FlFn7ylNmtVnOqu5rQU1Uaryh66yb95zRFEvkf4X01onxla2+tDOifPq1dXHQ7JaY
	L6m1dLWnNReAJ5J9OHSJxby5LuZtMeSrgVF+OF85jROA1YmVk0xpgyJ4zAdHez58RJb8KB2d7Rg
	w40klp3DbHISCA2RKGK095WSaSXwVLmWy1a0cB49ZPt6/UOmBOAK5VPE+vFhx9KBW3jq6AdytXx
	GWMj/R/AdGcDLMt4fBsfuewDdBCf+Y78x/LAmFLm1pM9CxcIOQ==
X-Received: by 2002:a05:600c:37c3:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-490a2a2713bmr55746815e9.7.1780164134577; Sat, 30 May 2026
 11:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527062247.3440692-1-youngjun.park@lge.com>
In-Reply-To: <20260527062247.3440692-1-youngjun.park@lge.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 30 May 2026 11:02:03 -0700
X-Gm-Features: AVHnY4LlgsaObV8OzPDPf_LpIqaNKpOQFAb8yvCAbXMYYoaNetnSwkLdSigY-MI
Message-ID: <CAKEwX=PkiWdgNtoHberaXafQDoDngw5kycfaXeU22MnrXBoAXQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] mm: swap: introduce swap tier infrastructure
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	baoquan.he@linux.dev, baohua@kernel.org, gunho.lee@lge.com, 
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com, 
	baver.bae@lge.com, matia.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16482-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lge.com:email]
X-Rspamd-Queue-Id: D7CEB610EC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:23=E2=80=AFPM Youngjun Park <youngjun.park@lge.c=
om> wrote:
>
> This is v7 of the swap tier series addressing review feedback.
> The cover letter has been simplified.
>
> I revisited the design (see Design Rationale). Since our use case
> fits best with a memcg-based model, the implementation remains
> within memcg and preserves its resource accounting semantics.
>
> Alternatives considered:
>
> 1. A separate sysfs interface under swap. (Workable. But, it would still
>    need to reference memcg paths, and fully decoupling it would add
>    swap-layer logic to manage memcgs, making it secondary option.)
>
> 2. Making the feature non-default.
>
> Other interfaces were also reviewed. Aside from sysfs and BPF,
> the options involve trade-offs and are largely design choices.
> BPF was excluded due to possible disablement on our embedded
> platform, though future extension remains possible.
>
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> Swap Tiers group swap devices into performance classes (e.g. NVMe,
> HDD, Network) and allow per-memcg selection of which tiers to use.
> This mechanism was suggested by Chris Li.
>
> Design Rationale
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Swap tier selection is attached to memcg. A child cgroup may select a
> subset of the parent's allowed tiers.
>
> This
> - Preserves cgroup inheritance semantics (boundary at parent,
>   refinement at child).
> - Reuses memcg, which already groups processes and enforces
>   hierarchical memory limits.
> - Aligns with existing memcg swap controls (e.g. swap.max, zswap.writebac=
k)
> - Avoids introducing a parallel swap control hierarchy.
>
> Placing tier control outside memcg (e.g., via BPF, syscalls, or
> madvise) would allow swap preference to diverge from the memcg
> hierarchy. Integrating it into memcg keeps the swap policy
> consistent with existing memory ownership semantics. There are
> also real use cases built around memcg.
>
> In the future, this can be extended to other interfaces to cover
> additional use cases.
>
> I believe a memcg-based swap control is a good starting point
> before such extensions.
>
> Use Cases
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> #1: Latency separation (our primary deployment scenario)
>   [ / ]
>      |
>      +-- latency-sensitive workload  (fast tier)
>      +-- background workload         (slow tier)
>
> The parent defines the memory boundary.
> Each workload selects a swap tier via memory.swap.tiers according to
> latency requirements.
>
> This prevents latency-sensitive workloads from being swapped to
> slow devices used by background workloads.
>
> #2: Per-VM swap selection (Chris Li's deployment scenario)
>   [ / ]
>      |
>      +-- [ Job on VM ]              (tiers: zswap, SSD)
>             |
>             +-- [ VMM guest memory ]  (tiers: SSD)
>
> The parent (job) has access to both zswap and SSD tiers.
> The child (VMM guest memory) selects SSD as its swap tier via
> memory.swap.tiers. In this deployment, swap device selection
> happens at the child level from the parent's available set.
>
> #3: Tier isolation for reduced contention (hypothetical)
>   [ / ]                    (tiers: A, B)
>      |
>      +-- workload X        (tiers: A)
>      +-- workload Y        (tiers: B)
>
> Each child uses a different tier. Since swap paths are separated
> per tier, synchronization overhead between the two workloads is
> reduced.
>
> Future extension
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> #1: Intra-tier distribution policy:
>   Currently, swap devices with the same priority are allocated in a
>   round-robin fashion. Per-tier policy files under
>   /sys/kernel/mm/swap/tiers/ can control how devices within a tier
>   are selected (e.g. round-robin, weighted).
>
> #2: Inter-tier promotion and demotion:
>   Promotion and demotion apply between tiers, not within a single
>   tier. The current interface defines only tier assignment; it does
>   not yet define when or how pages move between tiers. Two triggering
>   models are possible:
>
>   (a) User-triggered: userspace explicitly initiates migration between
>       tiers (e.g. via a new interface or existing move_pages semantics).
>   (b) Kernel-triggered: the kernel moves pages between tiers at
>       appropriate points such as reclaim or refault.
>
> #3: Per-VMA, per-process swap and BPF:
>   Not just for memcg based swap, possible to extend Per-VMA or per-proces=
s swap.
>   Or we can use it as BPF program.
>
> Experimentation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Tested on our internal platform using NBD as a separate swap tier.
> Our first production's simple usecase.
>
> Without tiers:
> - No selective control over flash wear
> - Cannot selectively assign NBD to specific applications
>
> Cold launch improvement (preloaded vs. baseline):
> - App A: 13.17s -> 4.18s (68%)
> - App B: 5.60s -> 1.12s (80%)
> - App C: 10.25s -> 2.00s (80%)
>
> Performance impact with no tiers configured:
> <1% regression in kernel build and vm-scalability benchmarks
>

Bit late to the party - working on my review backlog right now :)

I see some parallels with this and memory tiering work being done. One
future line of work could be considering how to ensure fairness when
multiple cgroups share same tiers:

https://lwn.net/Articles/1073400/

I can imagine a scenario where one noisy neighbor eagerly swaps first
and occupy all the space in the faster tier(s), pushing the other
colocated tenants to the slower tier(s). We might need to figure out a
way to ensure fairness here (while letting cgroups occupy fast swap
backends opportunistically if there is no resources scarcity).

