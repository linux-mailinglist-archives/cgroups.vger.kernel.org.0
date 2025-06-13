Return-Path: <cgroups+bounces-8511-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EA1AD8367
	for <lists+cgroups@lfdr.de>; Fri, 13 Jun 2025 08:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFECE1897A85
	for <lists+cgroups@lfdr.de>; Fri, 13 Jun 2025 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0A25A2D2;
	Fri, 13 Jun 2025 06:56:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89804257AF2
	for <cgroups@vger.kernel.org>; Fri, 13 Jun 2025 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749797777; cv=none; b=L1mG0vVjpuBEDTNn83yGvkKQ1Mh6FiQdpg2zsfYgsr8f7zI2JXHWfhTYHw10pwzpFFetFxrxQrQbzc3XekvuV0Vt7fh/gXA4Gf+WSOk2gVFAYzR2PBDvmskcRkVMlWBbPiK2PwNiO397KE0JQss+vb3++wfySkZwet5qkyySyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749797777; c=relaxed/simple;
	bh=i4du00HGA9zb0ohT1cC/b0VFC6Vw65Lig03aEVDZji8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5fMzo5lPOBvD27FUZnJz0LDGHPrbUgqkzRdb4emaWrka0lFdnxNbyUSHTEtpRSjEPiYSLofn/QlyGcVcurE/tj7bZhBNANBG7AEytKqiACqVaTAXP37GOo5bFn+w/SxH940E9vqHBqi2LTQ/K5yWbWBDUby5oF8tpAy5yTzjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 13 Jun 2025 15:56:12 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 13 Jun 2025 15:56:12 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chrisl@kernel.org, muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com, gunho.lee@lge.com
Subject: Re: [RFC PATCH 0/2] mm/swap, memcg: Support per-cgroup swap device
 prioritization
Message-ID: <aEvLjEInMQC7hEyh@yjaykim-PowerEdge-T330>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <CAMgjq7BA_2-5iCvS-vp9ZEoG=1DwHWYuVZOuH8DWH9wzdoC00g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7BA_2-5iCvS-vp9ZEoG=1DwHWYuVZOuH8DWH9wzdoC00g@mail.gmail.com>

On Thu, Jun 12, 2025 at 08:24:08PM +0800, Kairui Song wrote:
> On Thu, Jun 12, 2025 at 6:38 PM <youngjun.park@lge.com> wrote:
> >
> > From: Youngjun Park <youngjun.park@lge.com>
> >
> > Introduction
> > ============
> > I am a kernel developer working on platforms deployed on commercial consumer devices.
> > Due to real-world product requirements, needed to modify the Linux kernel to support
> > a new swap management mechanism. The proposed mechanism allows assigning different swap
> > priorities to swap devices per cgroup.
> > I believe this mechanism can be generally useful for similar constrained-device scenarios
> > and would like to propose it for upstream inclusion and solicit feedback from the community.
> >
> > Motivation
> > ==========
> > Core requirement was to improve application responsiveness and loading time, especially
> > for latency critical applications, without increasing RAM or storage hardware resources.
> > Device constraints:
> >   - Linux-based embedded platform
> >   - Limited system RAM
> >   - Small local swap
> >   - No option to expand RAM or local swap
> > To mitigate this, we explored utilizing idle RAM and storage from nearby devices as remote
> > swap space. To maximize its effectiveness, we needed the ability to control which swap devices
> > were used by different cgroups:
> >   - Assign faster local swap devices to latency critical apps
> >   - Assign remote swap devices to background apps
> > However, current Linux kernel swap infrastructure does not support per-cgroup swap device
> > assignment.
> > To solve this, I propose a mechanism to allow each cgroup to specify its own swap device
> > priorities.
> >
> > Evaluated Alternatives
> > ======================
> > 1. **Per-cgroup dedicated swap devices**
> >    - Previously proposed upstream [1]
> >    - Challenges in managing global vs per-cgroup swap state
> >    - Difficult to integrate with existing memory.limit / swap.max semantics
> > 2. **Multi-backend swap device with cgroup-aware routing**
> >    - Considered sort of layering violation (block device cgroup awareness)
> >    - Swap devices are commonly meant to be physical block devices.
> >    - Similar idea mentioned in [2]
> > 3. **Per-cgroup swap device enable/disable with swap usage contorl**
> >    - Expand swap.max with zswap.writeback usage
> >    - Discussed in context of zswap writeback [3]
> >    - Cannot express arbitrary priority orderings
> >     (e.g. swap priority A-B-C on cgroup C-A-B impossible)
> >    - Less flexible than per-device priority approach
> > 4. **Per-namespace swap priority configuration**
> >    - In short, make swap namespace for swap device priority
> >    - Overly complex for our use case
> >    - Cgroups are the natural scope for this mechanism
> >
> > Based on these findings, we chose to prototype per-cgroup swap priority configuration
> > as the most natural, least invasive extension of the existing kernel mechanisms.
> >
> > Design and Semantics
> > ====================
> > - Each swap device gets a unique ID at `swapon` time
> > - Each cgroup has a `memory.swap.priority` interface:
> >   - Show unique ID by memory.swap.priority interface
> >   - Format: `unique_id:priority,unique_id:priority,...`
> >   - All currently-active swap devices must be listed
> >   - Priorities follow existing swap infrastructure semantics
> > - The interface is writeable and updatable at runtime
> > - A priority configuration can be reset via `echo "" > memory.swap.priority`
> > - Swap on/off events propagate to all cgroups with priority configurations
> >
> > Example Usage
> > -------------
> > # swap device on
> > $ swapon
> > NAME      TYPE      SIZE USED PRIO
> > /dev/sdb  partition 300M  0B   10
> > /dev/sdc  partition 300M  0B    5
> >
> > # assign custom priorities in a cgroup
> > $ echo "1:5,2:10" > memory.swap.priority
> > $ cat memory.swap.priority
> > Active
> > /dev/sdb  unique:1  prio:5
> > /dev/sdc  unique:2  prio:10
> >
> > # adding new swap device later
> > $ swapon /dev/sdd --priority -1
> > $ cat memory.swap.priority
> > Active
> > /dev/sdb  unique:1  prio:5
> > /dev/sdc  unique:2  prio:10
> > /dev/sdd  unique:3  prio:-2
> >
> > # reset cgroup priority
> > $ echo "" > memory.swap.priority
> > $ cat memory.swap.priority
> > Inactive
> > /dev/sdb  unique:1  prio:10
> > /dev/sdc  unique:2  prio:5
> > /dev/sdd  unique:3  prio:-2
> >
> > Implementation Notes
> > ====================
> > The items mentioned below are to be considered during the next patch work.
> >
> > - Workaround using per swap cpu cluster as before
> > - Priority propgation of child cgroup
> > - And other TODO, XXX
> > - Refactoring for reviewability and maintainability, comprehensive testing
> >   and performance evaluation
> 
> Hi Youngjun,
> 
> Interesting idea. For your current approach, I think all we need is
> per-cgroup swap meta info structures (and infrastures for maintaining
> and manipulating them).
> 
> So we have a global version and a cgroup version of "plist, next
> cluster list, and maybe something else", right? And then
> once the allocator is folio aware it can just prefer the cgroup ones
> (as I mentioned in another reply) reusing all the same other
> routines. Changes are minimal, the cgroup swap meta infos
> and control plane are separately maintained.
> 
> It seems aligned quite well with what I wanted to do, and can be done
> in a clean and easy to maintain way.
> 
> Meanwhile with virtual swap, things could be even more flexible, not
> only changing the priority at swapout time, it will also provide
> capabilities to migrate and balance devices adaptively, and solve long
> term issues like mTHP fragmentation and min-order swapout etc..
> 
> Maybe they can be combined, like maybe cgroup can be limited to use
> the virtual device or physical ones depending on priority. Seems all
> solvable. Just some ideas here.

I had been thinking about the work related to vswap and alignment,
so I'm glad to hear that they can harmonize.

> Vswap can cover the priority part too. I think we might want to avoid
> duplicated interfaces.
> 
> So I'm just imagining things now, will it be good if we have something
> like (following your design):
> 
> $ cat memcg1/memory.swap.priority
> Active
> /dev/vswap:(zram/zswap? with compression params?) unique:0 prio:5
> 
> $ cat memcg2/memory.swap.priority
> Active
> /dev/vswap:/dev/nvme1  unique:1  prio:5
> /dev/vswap:/dev/nvme2  unique:2  prio:10
> /dev/vswap:/dev/vda  unique:3  prio:15
> /dev/sda  unique:4  prio:20
> 
> $ cat memcg3/memory.swap.priority
> Active
> /dev/vda  unique:3  prio:5
> /dev/sda  unique:4  prio:15
> 
> Meaning memcg1 (high priority) is allowed to use compressed memory
> only through vswap, and memcg2 (mid priority) uses disks through vswap
> and fallback to HDD. memcg3 (low prio) is only allowed to use slow
> devices.
> 
> Global fallback just uses everything the system has. It might be over
> complex though?
 
Just looking at the example usage which you mention, 
it seems flexible and good.
I will think more about this in relation to it.

