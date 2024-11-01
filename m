Return-Path: <cgroups+bounces-5360-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013A9B888D
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 02:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB1B1C21A94
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 01:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3277355C29;
	Fri,  1 Nov 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GpuWICIL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9C1A28C;
	Fri,  1 Nov 2024 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424855; cv=none; b=AxmfDEbrnmKOrgZJFNFyDBQ3cXkXSyodznN8rr2MtuEFDI6U7WWQmfoN1/KVOJzStVRTCDIeTUK99QzTIX8nyasRecnZhVOZwcPtP53HmNukBoZh9+f8ZcoKTZj9pyWzy+nV3hQpNCnj90AuvK23CXIPbPM+RhzY0WW05Menmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424855; c=relaxed/simple;
	bh=iuRrKWaA7cQTIyPCJ6yJTE+QtMeoAL4LZfUWuyrYEsE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OAThwe9Xkm5i0GNVG9rMlXB+o0B/DydIa8u8Ouk5OklsAx7271Y6U3twtpP7ml2MhkpBXQBJ82WQ+CETUxwRt/GpzAJq5EWzJl8e7bJE6y4y8LBndQIT+13HRw/dF+teSqy3HsvsTmFXgcK5vvoHB/h9ln0QHpM5OAv6B6ek+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GpuWICIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C871DC4CEC3;
	Fri,  1 Nov 2024 01:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730424854;
	bh=iuRrKWaA7cQTIyPCJ6yJTE+QtMeoAL4LZfUWuyrYEsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GpuWICIL+Q/CLeMoNRVbEARwd89pPGZ7xUCRu3cWVupQ6FST+77g34uuO/ZGFt77C
	 3L7u8bU287h7xhes3x2bSVREFmPHuxmutMmV7rv9SW+Nn5KAdMGUuxEmWCgoc9BymO
	 MCnKk23Hfox75P0Hb1QKLPrAn3/CdIJpqPqBAgc8=
Date: Thu, 31 Oct 2024 18:34:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 nphamcs@gmail.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
 mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-Id: <20241031183413.bb0bc34e8354cc14cdfc3c29@linux-foundation.org>
In-Reply-To: <CAN+CAwMioguv6itTSYVUO9__kQVv6HZO2-i0NWt10-x7f6JVSQ@mail.gmail.com>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
	<ZyIZ_Sq9D_v5v43l@tiehlicka>
	<20241030150102.GA706616@cmpxchg.org>
	<ZyJQaXAZSMKkFVQ2@tiehlicka>
	<20241030183044.GA706387@cmpxchg.org>
	<CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>
	<ZyM7_i1HFnFfUmIR@tiehlicka>
	<CAN+CAwMioguv6itTSYVUO9__kQVv6HZO2-i0NWt10-x7f6JVSQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 15:03:34 -0400 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Andrew -- I am sorry to ask again, but do you think you can replace
> the 3rd section in the patch (3. Implementation Details) with the
> following paragraphs?

No problem.

: This patch introduces a new counter to memory.stat that tracks hugeTLB
: usage, only if hugeTLB accounting is done to memory.current.  This feature
: is enabled the same way hugeTLB accounting is enabled, via the
: memory_hugetlb_accounting mount flag for cgroupsv2.
: 
: 1. Why is this patch necessary?
: Currently, memcg hugeTLB accounting is an opt-in feature [1] that adds
: hugeTLB usage to memory.current.  However, the metric is not reported in
: memory.stat.  Given that users often interpret memory.stat as a breakdown
: of the value reported in memory.current, the disparity between the two
: reports can be confusing.  This patch solves this problem by including the
: metric in memory.stat as well, but only if it is also reported in
: memory.current (it would also be confusing if the value was reported in
: memory.stat, but not in memory.current)
: 
: Aside from the consistency between the two files, we also see benefits in
: observability.  Userspace might be interested in the hugeTLB footprint of
: cgroups for many reasons.  For instance, system admins might want to
: verify that hugeTLB usage is distributed as expected across tasks: i.e. 
: memory-intensive tasks are using more hugeTLB pages than tasks that don't
: consume a lot of memory, or are seen to fault frequently.  Note that this
: is separate from wanting to inspect the distribution for limiting purposes
: (in which case, hugeTLB controller makes more sense).
: 
: 2.  We already have a hugeTLB controller.  Why not use that?  It is true
: that hugeTLB tracks the exact value that we want.  In fact, by enabling
: the hugeTLB controller, we get all of the observability benefits that I
: mentioned above, and users can check the total hugeTLB usage, verify if it
: is distributed as expected, etc.
: 
: 3.  Implementation Details:
: In the alloc / free hugetlb functions, we call lruvec_stat_mod_folio
: regardless of whether memcg accounts hugetlb.  mem_cgroup_commit_charge
: which is called from alloc_hugetlb_folio will set memcg for the folio
: only if the CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING cgroup mount option is
: used, so lruvec_stat_mod_folio accounts per-memcg hugetlb counters only
: if the feature is enabled.  Regardless of whether memcg accounts for
: hugetlb, the newly added global counter is updated and shown in
: /proc/vmstat.
: 
: The global counter is added because vmstats is the preferred framework
: for cgroup stats.  It makes stat items consistent between global and
: cgroups.  It also provides a per-node breakdown, which is useful. 
: Because it does not use cgroup-specific hooks, we also keep generic MM
: code separate from memcg code.
: 
: With this said, there are 2 problems:
: (a) They are still not reported in memory.stat, which means the
:     disparity between the memcg reports are still there.
: (b) We cannot reasonably expect users to enable the hugeTLB controller
:     just for the sake of hugeTLB usage reporting, especially since
:     they don't have any use for hugeTLB usage enforcing [2].
: 
: [1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com/
: [2] Of course, we can't make a new patch for every feature that can be
:     duplicated. However, since the existing solution of enabling the
:     hugeTLB controller is an imperfect solution that still leaves a
:     discrepancy between memory.stat and memory.curent, I think that it
:     is reasonable to isolate the feature in this case.


