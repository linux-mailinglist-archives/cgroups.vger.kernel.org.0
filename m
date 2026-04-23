Return-Path: <cgroups+bounces-15481-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MAGJ3mG6mmP0QIAu9opvQ
	(envelope-from <cgroups+bounces-15481-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:52:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 314484575E9
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CE63302836B
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179AF33BBCC;
	Thu, 23 Apr 2026 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx89kRCS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC972D0C7E
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776977283; cv=none; b=JE19LwXVA7GEClmMVPvM5DWpSVTA2o9i/JkExNAPwFClwFGK6c+JDbuw4uKq5+x+YaGKe8xOb2WYzkHeDC0jeQAkBNfMw7aKQy1hTPD2h1RCN+4GBZFbQaQemqg5V/bZ3J31MNlLbozUwKR5UH+BmCAA33WnFj0gkgLzO+jAPTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776977283; c=relaxed/simple;
	bh=jZDdlWnnmZL0XkbmLmxoEnk709HEQgmgR/yJgX91nRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFQH4oKrxMl3vV5+aEN43Q9+r6wX9mUEbQTZMHEvKsQyhnSzLzm+9LWbNCXDJMMdeyGkOEJK2kHx2/NZuHPtLzufg+0A8Y7i6iZTBDJlFQCCzoOKDnzGU3A+TCHaqR1HNQWC9LteuFEGRSjZDtRn3AUHDNDA9knZ5YKG/GYMl6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx89kRCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790A5C2BCFC
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 20:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776977283;
	bh=jZDdlWnnmZL0XkbmLmxoEnk709HEQgmgR/yJgX91nRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rx89kRCSlMrd7yHaiWXgQNZ6WFzc+/CKBSqW6tv6BpFT+A/XF9LFoVuRmekZJCcrW
	 PucoZ+X0h55vGSz9jfRis3+KCvMSGCNSz9d+5It5kj3mDn/0Lxh+DK6iVMDORGNcke
	 aXsxJBoQ49XvPZLLdxUiYoJ5kF2I5hTANUyf6QqSx22z9Ym8DmMOYvNwgQdbRS8v/Q
	 m8izcosAHWgz/ZY6Mc5154h2tsCRHenWgtEmselaULHpCVGDLHOTix8xjAPEy4oIZZ
	 oS79eyKyxiTPY2mWKPU3eVuO8lKJ+WF9QfF0VJEdaYEFuj/xwKjsdE6N9NL1k3Vzsk
	 16A0t+tpNvBQg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6788838d543so2018054a12.1
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 13:48:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+JahoWJk0HOsniMtpGYkm6hJhnudOUZniY5RPQ/pMxVXcmxU2Zq76RWtDMAB1OohmuuwOlq9hS@vger.kernel.org
X-Gm-Message-State: AOJu0YykQld1ANl22934jAQh6flS4x9jAVvURGtqK7FSfdcVkd0Eyjua
	ojz8WVjQb0xNQRU2QMjHXu0teb2hCy4vsPYG/dTCbFuGEk6FALEIdiqFxi65yD6H3Gv2Nxm1sZt
	tWByyzwGjKzHlmprvc4qJNwfWhmHH8lw=
X-Received: by 2002:a17:907:3c90:b0:bac:7f7d:2bf8 with SMTP id
 a640c23a62f3a-bac7f7d3864mr226153866b.0.1776977282033; Thu, 23 Apr 2026
 13:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
 <aektdlD4npMVThu3@google.com> <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
In-Reply-To: <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 23 Apr 2026 13:47:50 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
X-Gm-Features: AQROBzCGOvAuB5Pa5DHTHxdTW2aSpPlTxrehClW5Vv-d-Qe-2m8TRnW986l3LBY
Message-ID: <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	corbet@lwn.net, david@kernel.org, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TAGGED_FROM(0.00)[bounces-15481-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 314484575E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > > Yes, this absolutely works. In fact, I previously posted a working RFC
> > > based on this idea. In that series, clusters are dynamically
> > > allocated, allowing the swap space to be dynamically sized
> > > (essentially infinite) while reusing all the existing infrastructure:
> > > https://lore.kernel.org/all/20260220-swap-table-p4-v1-0-104795d19815@tencent.com/
> >
> > There are a few aspects that I don't agree with in this RFC, and I think
> > Nhat and Johannes raised most of them. Mostly that I don't want to
> > expose ghost swapfiles or similar to userspace.
> >
> > I think userspace's view of swapfiles should remain the same and reflect
> > the physical swap slots. The virtual swap layer should be completely
> > transparent in this case. Userspace shouldn't need to configure it in
> > any way.
>
> That approach is definitely doable. For example, with that RFC we
> could simply drop the interface I introduced and enable it via a
> different knob, and that would be very close to it. :)
>
> Using a swapfile to represent the virtual layer externally just made
> it more flexible.

I think it makes it less flexible to be honest. Once it's exposed to
userspace there's little we can change about it, and userspace needs
to set it up.

> I agree that the RFC design was a bit confusing and
> could be improved. There is no technical difficulty in hiding it from
> userspace; it's mostly a design choice. And even if we don't use a
> swapfile to represent it internally, all the other infrastructure can
> still be reused without much modification.

Yeah that's what I was getting at. It doesn't even need to be a
swapfile in the kernel, at the very least it should be named
differently to avoid confusion with actual swapfiles.

> Using a swapfile does have its benefits, though. For example, the
> virtual layer could act as an ordinary tier following YoungJun's
> design:
> https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.park@lge.com/

Hmm I didn't look too closely at this but I don't understand how
making it a swapfile helps with tiering? If anything, I think it makes
tiering more difficult. For tiering to work, we need an
abstraction/redirection layer, such that we don't need to update the
page tables (or shmem pagecache) if we demote/promote pages. That is
exactly the use case for a virtual swap layer. The page tables point
at a virtual swap ID and the backend could change transparently (e.g.
for zswap writeback, or tiering).

If we make the virtual layer a swapfile, how do we demote/promote
without updating page tables?

IOW, I think the whole reason we want a virtual layer is to separate
the backends, which would facilitate tiering. If the virtual layer is
itself a swapfile, wouldn't it become one of the tiers?

> It also means we wouldn't need to introduce things like a new,
> virtual-specific swapoff mechanism.

We don't *need* to introduce this, at least not initially. Only if we
have a good use case for it.

> > In an ideal world, the only noticeable change from userspace is that
> > with zswap, compressed pages would stop using slots in the swapfile and
> > charging the memcg for them -- and that zswap would work even without a
> > swapfile, by just enabling it. This is admittedly a user-visible
> > behavioral change, but I am hoping that's a good one that we can live
> > with.
>
> Totally agree with the ideal end goal for zswap. just not sure if
> that's the right place to start for this usage, zswap doesn't always
> apply. For instance, we have SSDs with built-in compression,
> software-based storage stacks with built-in compression and
> deduplication, swap over RDMA, and, most notably, ZRAM users. They
> don't necessarily need zswap or a virtual layer, and the upper layer
> better be as much simplified as possible.

Right, it's not necessarily zswap at all. As I mentioned above, the
same logic applies for swap tiering. You can actually consider zswap
one of the tiers (more-or-less). If you have one swapfile (or one
tier) like the ones you mention above, the virtual layer just always
points to a single backend (e.g. the slot in the swapfile). There
might be some additional overhead, but I think it would be minimal if
we use the cluster-based approach you have been pushing to eliminate
static overhead and make it all dynamic based on actual usage.

At a high-level, if we have a single tier/swapfile, I think the only
additional overhead would be the reverse mapping from the swap slot to
the virtual swap layer, which would be 8 bytes or so for every swapped
out entry, right?

I think this was discussed before but I still wonder if we really need
a reverse mapping, if it's only to optimize swapoff then I don't think
it's a requirement. We can still scan the virtual swap layer to look
for slots to swapin. It would still be better than scanning the page
tables as we do today. But I think there were other use cases for the
reverse mapping, I just forgot what they were.

