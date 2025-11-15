Return-Path: <cgroups+bounces-11999-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1493EC608E0
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 17:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89D5635E332
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A4D2FDC3F;
	Sat, 15 Nov 2025 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0fBrSOT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED4A257843;
	Sat, 15 Nov 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763225808; cv=none; b=u8ANWIIpThFIyoKjcomV1cuvdzpbSX9dOg/3DUhhJ2HFOiA3pgdh6oDsSAB2uwhlU7uGESKz9t/wLBH+B5UF2ysdAmVl/BjLkupiwl2URscmba4+uzn/665BI/4OZKGtHeRKMrtdmro1rnwCAhYeUFi47iCiXV4FK9N9HyoHfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763225808; c=relaxed/simple;
	bh=/gOkGsj7raAQD06iajDMIoQCwWI8rwh1FUuNxXNRiDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ra6uE3L461g/03ODHprKD52dd9zbZp5TAbVcB43JUUh74Yw7mox2PPHv1a4+ewdrpJjJWnZXPnwqhd+aZKpagVfIqCH+JuzBD1uon3W2r4hbIFLtFu5fSx5N0tqeBk0lN/PRUnH4U6FPlnvlz6cZxTDymGyNaWB6PS4CgKgiGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0fBrSOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96E7C4CEF5;
	Sat, 15 Nov 2025 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763225806;
	bh=/gOkGsj7raAQD06iajDMIoQCwWI8rwh1FUuNxXNRiDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0fBrSOTYwuz2F3C7hEG+BNNJ4ANuNHg5MF4ShyVzawn6gUZ2cv+mqh67Kmp4OfqC
	 bEMV1qF0avBOwaTJWdmPQ63m4NnPD+GQABzOF8GZN4GfZ9Wx7LVgNlWwvn6vSiXYf4
	 9ZuWxsvvwd3y5ICUVwyIWwNLpf5XzFSqOMy1ihbWGKajOU8O1GhBlMMaUx4UI/7m1Z
	 xGk/emq5jpa8fmE9d9mZHp5OzgnkVE5MyKqkNwl3Uh+IU73uI0AIEzNlyyrEeAM0cn
	 Lc+9MePZszKDSsvlerpFA4E1e4fYpvJnJpoKif0m8edPq6ei27KhYck9PkDzgvzXeY
	 S2faeXhLNG90w==
From: SeongJae Park <sj@kernel.org>
To: YoungJun Park <youngjun.park@lge.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	gunho.lee@lge.com,
	taejoon.song@lge.com
Subject: Re: [RFC] mm/swap, memcg: Introduce swap tiers for cgroup based swap control
Date: Sat, 15 Nov 2025 08:56:35 -0800
Message-ID: <20251115165637.82966-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aRhLmEKixuKGCUJX@yjaykim-PowerEdge-T330>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 15 Nov 2025 18:44:56 +0900 YoungJun Park <youngjun.park@lge.com> wrote:

> On Fri, Nov 14, 2025 at 05:22:45PM -0800, SeongJae Park wrote:
> > On Sun,  9 Nov 2025 21:49:44 +0900 Youngjun Park <youngjun.park@lge.com> wrote:
> > 
> > > Hi all,
> > > 
> > > In constrained environments, there is a need to improve workload
> > > performance by controlling swap device usage on a per-process or
> > > per-cgroup basis. For example, one might want to direct critical
> > > processes to faster swap devices (like SSDs) while relegating
> > > less critical ones to slower devices (like HDDs or Network Swap).
> > > 
> > > Initial approach was to introduce a per-cgroup swap priority
> > > mechanism [1]. However, through review and discussion, several
> > > drawbacks were identified:
> > > 
> > > a. There is a lack of concrete use cases for assigning a fine-grained,
> > >    unique swap priority to each cgroup. 
> > > b. The implementation complexity was high relative to the desired
> > >    level of control.
> > > c. Differing swap priorities between cgroups could lead to LRU
> > >    inversion problems.
> > > 
> > > To address these concerns, I propose the "swap tiers" concept, 
> > > originally suggested by Chris Li [2] and further developed through 
> > > collaborative discussions. I would like to thank Chris Li and 
> > > He Baoquan for their invaluable contributions in refining this 
> > > approach, and Kairui Song, Nhat Pham, and Michal KoutnÃ½ for their 
> > > insightful reviews of earlier RFC versions.
> > 
> > I think the tiers concept is a nice abstraction.  I'm also interested in how
> > the in-kernel control mechanism will deal with tiers management, which is not
> > always simple.  I'll try to take a time to read this series thoroughly.  Thank
> > you for sharing this nice work!
> 
> Hi SeongJae,
> 
> Thank you for your feedback and interest in the swap tiers concept
> I appreciate your willingness to review this series.
> 
> Regarding your question about simpler approaches using memory.reclaim,
> MADV_PAGEOUT, or DAMOS_PAGEOUT with swap device specification - I've
> looked into this perspective after reading your comments. This approach
> would indeed be one way to enable per-process swap device selection
> from a broader standpoint.
> 
> > Nevertheless, I'm curious if there is simpler and more flexible ways to achieve
> > the goal (control of swap device to use).  For example, extending existing
> > proactive pageout features, such as memory.reclaim, MADV_PAGEOUT or
> > DAMOS_PAGEOUT, to let users specify the swap device to use.  Doing such
> > extension for MADV_PAGEOUT may be challenging, but it might be doable for
> > memory.reclaim and DAMOS_PAGEOUT.  Have you considered this kind of options?
> 
> Regarding your question about simpler approaches using memory.reclaim,
> MADV_PAGEOUT, or DAMOS_PAGEOUT with swap device specification - I've
> looked into this perspective after reading your comments. This approach
> would indeed be one way to enable per-process swap device selection
> from a broader standpoint.
> 
> However, for our use case, per-process granularity feels too fine-grained,
> which is why we've been focusing more on the cgroup-based approach.

Thank you for kindly sharing your opinion.  That all makes sense.  Nonetheless,
I think the limitation is only for MADV_PAGEOUT.

MADV_PAGEOUT would indeed have a limitation at applying it on cgroup level.  In
case of memory.reclaim and DAMOS_PAGEOUT, however, I think it can work in
cgroup level, since memory.reclaim exists per cgroup, and DAMOS_PAGEOUT has
knobs for cgroup level controls, including cgroup based DAMOS filters and
per-node per-cgroup memory usage based DAMOS quota goal.  Also, if needed for
swap tiers, extending DAMOS seems doable, to my perspective.

> 
> That said, if we were to aggressively consider the per-process approach
> as well in the future, I'm thinking about how we might integrate it with
> the tier concept(not just indivisual swap device). During discussions with Chris Li, we also talked about
> potentially tying this to per-VMA control (see the discussion at
> https://lore.kernel.org/linux-mm/CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com/).
> This concept could go beyond just selection at the cgroup layer.

Sounds interesting.  I once thought extending DAMOS for vma level control
(e.g., asking some DAMOS actions to target only vmas of specific names) could
be useful, in the past.  I have no real plan to do that at the moment due to
the absence of expected usage.  But if that could be used for swap tiers, I
would be happy to help.


Thanks,
SJ

[...]

