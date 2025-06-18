Return-Path: <cgroups+bounces-8588-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF02ADEB75
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 14:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35653A8CE3
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33DD2C3258;
	Wed, 18 Jun 2025 12:07:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14C82BEC3F
	for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248476; cv=none; b=RsY0Wrs7sXXYn3cq52RL13T8lL6ZouuTljoK8VVz9VRYUdHKy1tN5c8D/aNnMX1o1wn5P3isTr80fFGmmyiPZAR2vgs5vGyDZZ1toy+UYOuvvTe0mmQBJK5SjW+1BB0C9AGlYbqY6XcnL1N4ng28tJq4LktPpoMz05RaCW3GmXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248476; c=relaxed/simple;
	bh=5E1cCuT6tbhbu1mMp4hHXWSFXwrZ703PlzIaNow0uJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmgXF2cst6ZeWvKo/lu7MreZKo1kNUSPnMxd7wqY+6IPzY+NNKVlJ4sKGWAWqZgradX2aQESWn1toHiJEDc5ZsDI/wOStXe34ErbTwb1t+9F888GBoC8kr4+VxK/9A20SizcN+1Twsf6/qS0qyLiw2xP3sa8uaqtH187sr6JsS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 18 Jun 2025 21:07:51 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Wed, 18 Jun 2025 21:07:51 +0900
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
Message-ID: <aFKsF9GaI3tZL7C+@yjaykim-PowerEdge-T330>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-2-youngjun.park@lge.com>
 <pcji4n5tjsgjwbp7r65gfevkr3wyghlbi2vi4mndafzs4w7zs4@2k4citaugdz2>
 <aFIJDQeHmTPJrK57@yjaykim-PowerEdge-T330>
 <rivwhhhkuqy7p4r6mmuhpheaj3c7vcw4w4kavp42avpz7es5vp@hbnvrmgzb5tr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rivwhhhkuqy7p4r6mmuhpheaj3c7vcw4w4kavp42avpz7es5vp@hbnvrmgzb5tr>

On Wed, Jun 18, 2025 at 11:11:32AM +0200, Michal Koutný wrote:
> On Wed, Jun 18, 2025 at 09:32:13AM +0900, YoungJun Park <youngjun.park@lge.com> wrote:
> > What issue is the question assuming the existence of competitors in two
> > cgroups trying to address? Could you explain it a bit more specifically?
> 
> I'm after how this mechanism is supposed to honor hierarchical
> structure. (I thought the numeric example was the most specific.)
> 
> > 
> > To answer your question for now,
> > Each cgroup just prefers devices according to their priority values.
> > until swap device is exhausted.
> > 
> > cg1 prefer /dev/sda than /dev/sdb.
> > cg2 prefer /dev/sdb than /dev/sda.
> > cg3 prefer /dev/sdb than /dev/sda.
> > cg4 prefer /dev/sda than /dev/sdb.
> 
> Hm, than means the settigs from cg1 (or cg2) don't apply to descendant
> cg3 (or cg4) :-/

I've been thinking about whether the use case I suggested aligns with the
philosophy of cgroups, and I believe there are two feasible directions
could take (This still needs some detailed refinement.)

Bascially on two strategies, child inherits parent setting.

1. Preserve the order of priorities and type of swap devices
when a child cgroup inherits values from 
its parent. the inherited order must be strictly maintained

e.g 

1.1 possible case.
1.1.1
cgroupA (swapA-swapB-swapC)
	' cgroupB (swapA-swapC)

1.1.2 
cgroupA (swapA-swapB-swapC)
	' cgroupB (swapA-swapC)

after time, modify it (swapD add on cgroupA)

cgroupA (swapA-swapB-swapC-swapD)
	' cgroupB (swapA-swapC)

1.2.impossible case.

1.2.1 violate the order of priorities rule.
cgroupA (swapA-swapB-swapC)
	' cgroupB  (swapC-swapA-swapB)

1.2.2 violate the type of swap devices rule.
cgroupA (swapA-swapB-swapC)
	' cgroupB  (swapD)

2. Restrict child cgroups to only use values inherited from the parent,
without allowing them to define their own setting.

e.g
cgroupA (swapA-swapB-swapC)
	' cgroupB (swapA-swapB-swapC)

after time, modify it (swapD add on cgroupA)

cgroupA (swapA-swapB-swapC-swapD)
	' cgroupB (swapA-swapB-swapC-swapD)

it is different from 1.1.2 case swapD propagated. 
(because child and parent must be same)

> When referring to that document
> (Documentation/admin-guide/cgroup-v2.rst) again, which of the "Resource
> Distribution Models" do you find the most fitting for this scenario?

I initially submitted the RFC from the perspective that each in-use
swap device must explicitly have a priority assigned, including propagation
at swapon time. (for avoiding swap-fail by using this mechanism)

However, condisering the resource distribution model you mentioned, 
I now see that not requiring all swap devices to have an explicitly defined 
priority aligns better with the broader cgroup "limit distribution" philosophy,
particularly in terms of limiting and distributing resources.

This is because cgroups can still restrict swap device usage and control 
device order without requiring explicit priorities for all devices.
In this view, the cgroup interface serves more as a limit or preference 
mechanism across the full set of available swap devices, rather than
requiring full enumeration and configuration.
 
Regards,
Youngjun Park

