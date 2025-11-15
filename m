Return-Path: <cgroups+bounces-11991-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E17DC602A0
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 10:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B57CD35345F
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C009274B53;
	Sat, 15 Nov 2025 09:45:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A9274B26
	for <cgroups@vger.kernel.org>; Sat, 15 Nov 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763199901; cv=none; b=JkY6hk4QJ8WO5nD/bQO5YLWR/5SCC4a+V3TUCts7CVi5E0W9ULTlho5IfviW9EtB3fFzTecnMXssFDj8i9y4vAzEMXIa73otO9hvh9Ld753sZzg5Jd+a8f+QJIDlhsslR+Nve2Jcx08EyFaIRYZgL+z8PcEQVXVRhM+tzdiTAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763199901; c=relaxed/simple;
	bh=zq0Ac+j0RUxhTwOJ6GIMq91+kc86F7f+Aj1EsX+WDKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpamYu6R9uweFT6G8axPV8a0iWbBAd6pMCyJsY8viGPlHV8gtvYHP6FKdn84wQv4E/vt81GmioWZE/NtPMK0YMmvZJJvsLx3PxxolxnD2A4wrleaHHxrtRqkkpOneLVsnNNPd9AdGFJCLKSRxjVySviSyV7roiTvy+KdCY9TC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 15 Nov 2025 18:44:56 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sat, 15 Nov 2025 18:44:56 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrisl@kernel.org, kasong@tencent.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, gunho.lee@lge.com, taejoon.song@lge.com
Subject: Re: [RFC] mm/swap, memcg: Introduce swap tiers for cgroup based swap
 control
Message-ID: <aRhLmEKixuKGCUJX@yjaykim-PowerEdge-T330>
References: <20251109124947.1101520-1-youngjun.park@lge.com>
 <20251115012247.78999-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251115012247.78999-1-sj@kernel.org>

On Fri, Nov 14, 2025 at 05:22:45PM -0800, SeongJae Park wrote:
> On Sun,  9 Nov 2025 21:49:44 +0900 Youngjun Park <youngjun.park@lge.com> wrote:
> 
> > Hi all,
> > 
> > In constrained environments, there is a need to improve workload
> > performance by controlling swap device usage on a per-process or
> > per-cgroup basis. For example, one might want to direct critical
> > processes to faster swap devices (like SSDs) while relegating
> > less critical ones to slower devices (like HDDs or Network Swap).
> > 
> > Initial approach was to introduce a per-cgroup swap priority
> > mechanism [1]. However, through review and discussion, several
> > drawbacks were identified:
> > 
> > a. There is a lack of concrete use cases for assigning a fine-grained,
> >    unique swap priority to each cgroup. 
> > b. The implementation complexity was high relative to the desired
> >    level of control.
> > c. Differing swap priorities between cgroups could lead to LRU
> >    inversion problems.
> > 
> > To address these concerns, I propose the "swap tiers" concept, 
> > originally suggested by Chris Li [2] and further developed through 
> > collaborative discussions. I would like to thank Chris Li and 
> > He Baoquan for their invaluable contributions in refining this 
> > approach, and Kairui Song, Nhat Pham, and Michal Koutný for their 
> > insightful reviews of earlier RFC versions.
> 
> I think the tiers concept is a nice abstraction.  I'm also interested in how
> the in-kernel control mechanism will deal with tiers management, which is not
> always simple.  I'll try to take a time to read this series thoroughly.  Thank
> you for sharing this nice work!

Hi SeongJae,

Thank you for your feedback and interest in the swap tiers concept
I appreciate your willingness to review this series.

Regarding your question about simpler approaches using memory.reclaim,
MADV_PAGEOUT, or DAMOS_PAGEOUT with swap device specification - I've
looked into this perspective after reading your comments. This approach
would indeed be one way to enable per-process swap device selection
from a broader standpoint.

> Nevertheless, I'm curious if there is simpler and more flexible ways to achieve
> the goal (control of swap device to use).  For example, extending existing
> proactive pageout features, such as memory.reclaim, MADV_PAGEOUT or
> DAMOS_PAGEOUT, to let users specify the swap device to use.  Doing such
> extension for MADV_PAGEOUT may be challenging, but it might be doable for
> memory.reclaim and DAMOS_PAGEOUT.  Have you considered this kind of options?

Regarding your question about simpler approaches using memory.reclaim,
MADV_PAGEOUT, or DAMOS_PAGEOUT with swap device specification - I've
looked into this perspective after reading your comments. This approach
would indeed be one way to enable per-process swap device selection
from a broader standpoint.

However, for our use case, per-process granularity feels too fine-grained,
which is why we've been focusing more on the cgroup-based approach.

That said, if we were to aggressively consider the per-process approach
as well in the future, I'm thinking about how we might integrate it with
the tier concept(not just indivisual swap device). During discussions with Chris Li, we also talked about
potentially tying this to per-VMA control (see the discussion at
https://lore.kernel.org/linux-mm/CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com/).
This concept could go beyond just selection at the cgroup layer.

Thanks,
YoungJun

