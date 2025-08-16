Return-Path: <cgroups+bounces-9245-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B0B28FA9
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 18:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C55A272D3
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AAA2FDC34;
	Sat, 16 Aug 2025 16:56:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD323A562
	for <cgroups@vger.kernel.org>; Sat, 16 Aug 2025 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755363398; cv=none; b=eo08JeFWsfzEbfDhR66DprBkOVfn0M+4QVpaDwIodhu8Jda/rrvQ9SNFtJliKzOmEU6+ouJ9iYbEQLs+CT3lszQYzlRx/uLEfvElnxJDe/9lZkfcK7lqTX4Y7MWINPBxLMGAWYEJKACi74Gx1Ue4ZIPwJ8gtXlRppgXJVIqaknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755363398; c=relaxed/simple;
	bh=gwq3PKEhGGK0MsT2WId9LhPxs55e1rq00kIIyB3bGdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doVmRPhAmA0gD+IUpxvogVWRW7o5de4p3jsMIcqGr9i/2h5M/hDxAUks6xY9Y5sZl9Y86ra9DXWDEVKxseu0Y49y1nNEV9MHumdRw5hV/lzB4CRZ0KubH+me0SXR2gPbjebguvXNb7et8RdGfeZzEVU2WfZhDgc6w+N88HjZcV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 17 Aug 2025 01:41:34 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sun, 17 Aug 2025 01:41:34 +0900
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
Message-ID: <aKC0vrr0vIdRV/Ob@yjaykim-PowerEdge-T330>
References: <20250716202006.3640584-1-youngjun.park@lge.com>
 <20250716202006.3640584-2-youngjun.park@lge.com>
 <jrkh2jy2pkoxgsxgsstpmijyhbzzyige6ubltvmvwl6fwkp3s7@kzc24pj2tcko>
 <aH+apAbBCmkMGPlO@yjaykim-PowerEdge-T330>
 <aH/baxIgrBI3Z1Hl@yjaykim-PowerEdge-T330>
 <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>

On Thu, Aug 14, 2025 at 04:03:36PM +0200, Michal Koutný wrote:
> On Wed, Jul 23, 2025 at 03:41:47AM +0900, YoungJun Park <youngjun.park@lge.com> wrote:

> Let me share my mental model in order to help forming the design.

First of all, thank you very much for your detailed reply. As Friday was a
public holiday in Korea and I had some personal commitments over the weekend,
I only got to check your email late — I hope you can kindly excuse the delayed
response.

For the points that require deeper consideration, I will provide detailed
answers later. For now, let me share some quick feedback on the parts I can
respond to right away.

> I find these per-cgroup swap priorities similar to cpuset -- instead of
> having a configured cpumask (bitmask) for each cgroup, you have
> weight-mask for individual swap devices (or distribution over the
> devices, I hope it's not too big deviation from priority ranking).
> Then you have the hierarchy, so you need a method how to combine
> child+parent masks (or global/root) to obtain effective weight-mask (and
> effective ranking) for each cgroup.
> 
> Furthermore, there's the NUMA autobinding which adds another weight-mask
> to the game but this time it's not configured but it depends on "who is
> asking". (Tasks running on node N would have autobind shifted towards
> devices associated to node N. Is that how autobinding works?)

Yes, your description indeed captures the core concept of how autobinding
works.
 
> From the hierarchy point of view, you have to compound weight-masks in
> top-down preference (so that higher cgroups can override lower) and
> autobind weight-mask that is only conceivable at the very bottom
> (not a cgroup but depending on the task's NUMA placement).
> 
> There I see conflict between the ends a tad. I think the attempted
> reconciliation was to allow emptiness of a single slot in the
> weight-mask but it may not be practical for the compounding (that's why
> you came up with the four variants). So another option would be to allow
> whole weight-mask being empty (or uniform) so that it'd be identity in
> the compounding operation.
> The conflict exists also in the current non-percg priorities -- there
> are the global priorities and autobind priorities. IIUC, the global
> level either defines a weight (user prio) or it is empty (defer to NUMA
> autobinding).
> 
> [I leveled rankings and weight-masks of devices but I left a loophole of
> how the empty slots in the latter would be converted to (and from)
> rankings. This e-mail is already too long.]

Yes. A single slot emptiness is enemy..
The problem arises from two aspects: (1) allowing per-device priorities
inherently leads to the possibility of single-slot emptiness, and (2)
depending on swapon configuration, empty slots may be inevitable. That’s
why the compounding rules ended up allowing this complexity. I’ll review
your suggestions carefully and share soon how we might simplify this
direction.

> 
> An very different alternative that comes to my mind together with
> autobinding and leveraging that to your use case:
> - define virtual NUMA nodes [1],
> - associate separate swap devices to those nodes,
> - utilize task (or actual (mem)cpuset) affinity to those virtual NUMA
>   nodes based on each process's swap requirements,
> - NUMA autobinding would then yield the device constraints you sought.

Creative. I have understood the overall concept for now.

Thank you as always for your valuable insights.

Best regards,  
YoungJun

