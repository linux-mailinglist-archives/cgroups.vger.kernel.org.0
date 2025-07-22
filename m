Return-Path: <cgroups+bounces-8865-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99138B0E39A
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 20:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523361899830
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142BA28153C;
	Tue, 22 Jul 2025 18:41:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AA283124
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209711; cv=none; b=ht51T/Mu+ToX+YshxwSGrL0uf05ourWYVtGGsP3FaT22nJaYPLDmMiwTsOWkDSISTBRWg/F+sRNR8WKmX31FDWBpL3lwgnOOPP01gN+6jXjC0hImhhlGM6jLvvO1aAveTf5LPus1dcPJ16p8wLZ9N3/A2nwfgkDvSofKLznK+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209711; c=relaxed/simple;
	bh=a7pY1SbpPtY6jpfMyFC746YieoCkkdi/uW4ZpzCuINg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6KVhYibnlsqj0FH+PJHA3uZ1zEXe+mOZE7cwMqYi09jDi4VUIlwHNFsadrEzvjyBzhQBCeis0B+iDqsKWPZih6C29/PqcNzFsdvXZ6saDnv+CEGNoSKSgxnBO5u5nVGw4ZHvvPf+e22DOJeV43e8LX0r5zB+Eb8I5uE9ujJX7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 23 Jul 2025 03:41:47 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Wed, 23 Jul 2025 03:41:47 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chrisl@kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <aH/baxIgrBI3Z1Hl@yjaykim-PowerEdge-T330>
References: <20250716202006.3640584-1-youngjun.park@lge.com>
 <20250716202006.3640584-2-youngjun.park@lge.com>
 <jrkh2jy2pkoxgsxgsstpmijyhbzzyige6ubltvmvwl6fwkp3s7@kzc24pj2tcko>
 <aH+apAbBCmkMGPlO@yjaykim-PowerEdge-T330>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH+apAbBCmkMGPlO@yjaykim-PowerEdge-T330>

On Tue, Jul 22, 2025 at 11:05:24PM +0900, YoungJun Park wrote:
> On Tue, Jul 22, 2025 at 10:41:20AM +0200, Michal Koutný wrote:
> > On Thu, Jul 17, 2025 at 05:20:03AM +0900, Youngjun Park <youngjun.park@lge.com> wrote:
> > > +  memory.swap.priority
> > > +    A read-write flat-keyed file which exists on non-root cgroups.
> > > +    This interface allows you to set per-swap-device priorities for the current
> > > +    cgroup and to define how they differ from the global swap system.
> > > +
> > > +    To assign priorities or define specific behaviors for swap devices
> > > +    in the current cgroup, write one or more lines in the following
> > > +    formats:
> > > +
> > > +     - <swap_device_id> <priority>
> > > +     - <swap_device_id> disabled
> > > +     - <swap_device_id> none
> > > +     - default none
> > > +     - default disabled
> > > +
> > > +    Each <swap_device_id> refers to a unique swap device registered
> > > +    in the system. You can check the ID, device path, and current
> > > +    priority of active swap devices through the `/proc/swaps` file.
> > 
> > Do you mean row number as the ID? Or does this depend on some other
> > patches or API?
> 
> You're right to ask for clarification. The `<swap_device_id>` refers
> to a unique identifier added to each swap device entry in `/proc/swaps`.
> I will revise the documentation to make this clearer.
> 
> As a side note, I initially had concerns about breaking the existing ABI.
> However, the additional ID column does not significantly change the
> current output format and is gated behind `CONFIG_SWAP_CGROUP_PRIORITY`,
> so it should be safe and intuitive to expose it through `/proc/swaps
> 
> > > +    This provides a clear mapping between swap devices and the IDs
> > > +    used in this interface.
> > > +
> > > +    The 'default' keyword sets the fallback priority behavior rule for
> > > +    this cgroup. If no specific entry matches a swap device, this default
> > > +    applies.
> > > +
> > > +    * 'default none': This is the default if no configuration
> > > +      is explicitly written. Swap devices follow the system-wide
> > > +      swap priorities.
> > > +
> > > +    * 'default disabled': All swap devices are excluded from this cgroup’s
> > > +      swap priority list and will not be used by this cgroup.
> > 
> > This duplicates memory.swap.max=0. I'm not sure it's thus necessary.
> > At the same time you don't accept 'default <priority>' (that's sane).
> 
> That's a valid observation. While `memory.swap.max=0` controls the overall
> swap usage limit, the `default disabled` entry is intended to disable
> specific swap devices within the scope of this cgroup interface. The
> motivation was to offer more granular control over device selection
> rather than total swap usage.
> 
> > > +
> > > +    The priority semantics are consistent with the global swap system:
> > > +
> > > +      - Higher numerical values indicate higher preference.
> > > +      - See Documentation/admin-guide/mm/swap_numa.rst for details on
> > > +        swap NUMA autobinding and negative priority rules.
> > > +
> > > +    The handling of negative priorities in this cgroup interface
> > > +    has specific behaviors for assignment and restoration:
> > > +
> > > +    * Negative Priority Assignment
> > 
> > Even in Documentation/admin-guide/mm/swap_numa.rst it's part of "Implementation details".
> > I admit I'm daunted by this paragraphs. Is it important for this interface?
> 
> Thank you for pointing this out. My original philosophy was to preserve
> as much of the existing swap functionality as possible, including
> NUMA-aware behaviors.
> 
> However, I agree that the explanation is complex and also not be
> necessary for my proposed usage. After some reflection, I believe the
> implementation (and documentation) will be clearer and simpler without
> supporting negative priorities here. 
> 
> Unless further objections arise, I plan to drop this behavior in the next
> version of the patch, as you suggested. If compelling use cases emerge in
> the future, we can consider reintroducing the support at that time.
> 
> Thanks again for your helpful review!

I'd like to revisit the NUMA-aware swap priority behavior based on
further implementation consideration. After refining the idea 
, I realized there are potential issues
if we fully remove NUMA autobind behavior when cgroup priorities are
set.

For example, suppose the global swap device priorities are configured
as:

  swapA -2
  swapB -3
  swapC -4

If we update the per-cgroup priority of swapA to a positive value, it
feels natural that only swapA should be affected, and swapB/swapC
should remain subject to NUMA autobind as configured globally. In other
words, the presence of one overridden device shouldn't disable autobind
entirely.

Thus, it seems that we may still need to retain some internal structure
for honoring NUMA autobind even when swap cgroup priority is enabled,
at least for the devices not explicitly overridden.

This leaves us with a few design options:

1. Treat negative values as valid priorities. Once any device is
   assigned via `memory.swap.priority`, the NUMA autobind logic is
   entirely disabled.
   - Pros: Simplifies implementation; avoids exposing NUMA autobind via
     cgroup interface.
   - Cons: Overrides autobind for all devices even if only one is set.

2. Continue to treat negative values as NUMA autobind weights, without
   implicit shifting. If a user assigns `-3`, it is stored and used
   exactly as `-3`, and does not affect other devices.
   - Pros: Simple and intuitive; matches current implementation
     semantics.
   - Cons: Autobind semantics still need to be reasoned about when
     using the interface.

3. Disallow setting negative values via `memory.swap.priority`.
   Existing NUMA autobind config is preserved, but no new autobind
   configuration is possible from cgroup interface.
   - Pros: Keeps cgroup interface simple; no autobind manipulation.
   - Cons: Autobind infra remains partially active, increasing code
     complexity.

4. Keep the current design: allow setting negative values to express
   NUMA autobind weights explicitly. Devices without overridden values
   continue to follow NUMA-based dynamic selection.
   - Pros: Preserves current flexibility; gives users control per device.
   - Cons: Slightly more complex semantics; NUMA autobind remains a
     visible part of the interface.

After thinking through these tradeoffs, I'm inclined to think that
preserving the NUMA autobind option might be the better path forward.
What are your thoughts on this?

Thank you again for your helpful feedback.

Best regards,
Youngjun Park

