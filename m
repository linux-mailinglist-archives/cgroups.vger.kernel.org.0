Return-Path: <cgroups+bounces-8662-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C942AEFA78
	for <lists+cgroups@lfdr.de>; Tue,  1 Jul 2025 15:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6304E3B59
	for <lists+cgroups@lfdr.de>; Tue,  1 Jul 2025 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54276278768;
	Tue,  1 Jul 2025 13:23:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86427466D
	for <cgroups@vger.kernel.org>; Tue,  1 Jul 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376231; cv=none; b=IKWt51YR2O1VEHX9t/GwzUi/78tavX6V3HdLKUqTfLTKEFSQvN+h9Bc0ivm8JF1mqGTDMjcXs9Y2nsqx7kgItW9yY6tjSyzUYRYFK2yOdwUlUZlAQemjON7Pn9sg7rls4SUziS3SQy9oYC+Ct8xf02fnz4jsgTM/iH09+qbUCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376231; c=relaxed/simple;
	bh=r0Qq+d5yiYc+tQ/JPUYcbNQRbrbArG3O8z/RqToMgaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIviYU3/SJD53A6Au/Z0SBh7pi6lLp/mbFs+kkho/X7N0Dcyb/crxkFYNVJmcswg3gUethorP/8+z9BzK2FBwwUbHrb5YMPTlXZGI+A2yawfqIeRBsWlz7peL6aJXuTx1766KdHyzEo4S3J2/8yrbgBu2JW59NhIY/cpuYE1bC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 1 Jul 2025 22:08:46 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 1 Jul 2025 22:08:46 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
	muchun.song@linux.dev, iamjoonsoo.kim@lge.com, taejoon.song@lge.com,
	gunho.lee@lge.com
Subject: Re: [RFC PATCH 1/2] mm/swap, memcg: basic structure and logic for
 per cgroup swap priority control
Message-ID: <aGPd3hIuEVF2Ykoy@yjaykim-PowerEdge-T330>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-2-youngjun.park@lge.com>
 <pcji4n5tjsgjwbp7r65gfevkr3wyghlbi2vi4mndafzs4w7zs4@2k4citaugdz2>
 <aFIJDQeHmTPJrK57@yjaykim-PowerEdge-T330>
 <rivwhhhkuqy7p4r6mmuhpheaj3c7vcw4w4kavp42avpz7es5vp@hbnvrmgzb5tr>
 <aFKsF9GaI3tZL7C+@yjaykim-PowerEdge-T330>
 <bhcx37fve7sgyod3bxsky5wb3zixn4o3dwuiknmpy7fsbqgtli@rmrxmvjro4ht>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bhcx37fve7sgyod3bxsky5wb3zixn4o3dwuiknmpy7fsbqgtli@rmrxmvjro4ht>

On Mon, Jun 30, 2025 at 07:39:47PM +0200, Michal Koutný wrote:
> On Wed, Jun 18, 2025 at 09:07:51PM +0900, YoungJun Park <youngjun.park@lge.com> wrote:
> > This is because cgroups can still restrict swap device usage and control 
> > device order without requiring explicit priorities for all devices.
> > In this view, the cgroup interface serves more as a limit or preference 
> > mechanism across the full set of available swap devices, rather than
> > requiring full enumeration and configuration.

Hello Michal,

Thank you very much for your thoughtful review and for sharing your
insights.

I’d like to share my thoughts and the reasoning behind my current
direction, including some points I considered in relation to your
suggestions.

> I was wondering whether your use cases would be catered by having
> memory.swap.max limit per device (essentially disable swap to undesired
> device(s) for given group). The disadvantage is that memory.swap.max is
> already existing as scalar. Alternatively, remapping priorities to

I did consider implementing this kind of control.
In that design, it would work similarly to memory.swap.max but per
device: the implementation would iterate through the swap devices in
priority order and maintain per-cgroup counters for each device’s usage.
It would also need to handle proper counter cleanup after use, and
ensure that usage checks also happen on the fastpath where per-CPU
caches for swap device clusters come into play.

From a runtime behavior perspective, the priority-based approach seemed
preferable, as it allows more flexible control: the configured cgroup
can strongly prefer the desired device and benefit from faster selection
at allocation time.

I also considered how this would coexist with the existing swap.max
interface, but given the additional implementation and runtime overhead
this would introduce, I decided to hold it back and chose a priority-based
approach instead.

> already existing as scalar. Alternatively, remapping priorities to
> memory.swap.weight -- with sibling vs sibling competition and children
> treated with weight of parent when approached from the top. I find this
> weight semantics little weird as it'd clash with other .weight which are
> dual to this (cgroups compete over one device vs cgroup is choosing
> between multiple devices).

Your point about the semantic mismatch is very valid. I agree that
reusing .weight semantics here could be confusing: .weight usually
expresses competition among siblings for a shared resource, whereas
here, the goal is to steer selection among multiple devices within a
single cgroup’s scope.

The swap priority concept already exists as an
independent mechanism, so mapping it into a .weight field might not
align well in practice.
 
> Please try to take the existing distribution models into account not to
> make something overly unidiomatic,

I also thought about possible alignment with existing mechanisms like
zswap.writeback. One alternative could be to adopt an on/off style mechanism
similar to zswap.writeback including propagation strategy. 
On implementation-wise, this could be handled by including
or excluding devices from the cgroup’s swap device priority list.
(The direction I suggested on)

However, this approach also has limitations in certain use cases. For
example, if we want to enforce a different ordering than the global
system swap priority, an on/off switch alone is not sufficient.

One possible example would be:
(Some cgroup use the slowest available swap device but with a larger capacity
avoiding swap failure.)

Global swap: A (fast) -> B (slower) -> C (slowest)
Cgroup swap: C (slowest) -> B (slower) -> A (fast)

This kind of configuration cannot be achieved only with an on/off
switch.

I think that priority approach might not map perfectly to the existing
major distribution models (like limit, weight, etc.),
I cautiously see this as an extension of the resource control interfaces, 
building on the solid foundation that the cgroup mechanism already provides.

I am working to ensure that the proposed interface and propagation
behavior integrate properly with parent cgroups and follow the same
interface style. Here is the current version I am working on now.
(It turned out a bit long, but I felt it might be useful to share it with you.)

  memory.swap.priority
        A read-write flat-keyed file which exists on non-root cgroups.

        Example: (after swapon)
          $ swapon
          NAME     TYPE      SIZE  USED PRIO
          /dev/sdb partition 300M   0B   10
          /dev/sdc partition 300M   0B    5
          /dev/sdd partition 300M   0B   -2

        To assign priorities to swap devices in the current cgroup,
        write one or more lines in the following format:

          <swap_device_unique_id> <priority>

        Example: (writing priorities)
          $ echo "1 4" > memory.swap.priority
          $ echo "2 -2" > memory.swap.priority
          $ echo "3 -1" > memory.swap.priority

        Example: (reading after write)
          $ cat memory.swap.priority
          1 4
          2 -2
          3 -1

        The priority semantics are consistent with the global swap
        system:

          - Higher values indicate higher preference.
          - See Documentation/admin-guide/mm/swap_numa.rst for swap numa
            autobinding.

        Note:
          A special value of -1 means the swap device is completely
          excluded from use by this cgroup. Unlike the global swap
          priority, where negative values simply lower the priority,
          setting -1 here disables allocation from that device for the
          current cgroup only.

        If any ancestor cgroup has set a swap priority configuration, it
        is inherited by all descendants. In that case, the child’s own
        configuration is ignored and the topmost configured ancestor
        determines the effective priority ordering.

  memory.swap.priority.effective
        A read-only file showing the effective swap priority ordering
        actually applied to this cgroup, after resolving inheritance
        from ancestors.

        If there is no configuration in the current cgroup and its
        ancestors, this file shows the global swap device priority from
        `swapon`, in the form of unique_id priority pairs.

        Example: (global only)
          $ swapon
          NAME     TYPE      SIZE  USED PRIO
          /dev/sdb partition 300M   0B   10
          /dev/sdc partition 300M   0B    5
          /dev/sdd partition 300M   0B   -2

          $ cat /sys/fs/cgroup/parent/child/memory.swap.priority.effective
          1 10
          2 5
          3 -2

        Example: (with parent override)
          # Parent cgroup configuration
          $ cat /sys/fs/cgroup/parent/memory.swap.priority
          1 4
          2 -2

          # Child cgroup configuration (ignored because parent overrides)
          $ cat /sys/fs/cgroup/parent/child/memory.swap.priority
          1 8
          2 5

          # Effective priority seen by the child
          $ cat /sys/fs/cgroup/parent/child/memory.swap.priority.effective
          1 4
          2 -2

        In this case:
          - If no cgroup sets any configuration, the output matches the
            global `swapon` priority.
          - If an ancestor has a configuration, the child inherits it
            and ignores its own setting.

I hope my explanation clarifies my intention, 
and I would truly appreciate your positive consideration 
and any further thoughts you might have.

Best regards, 
Youngjun Park

