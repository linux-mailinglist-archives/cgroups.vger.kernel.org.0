Return-Path: <cgroups+bounces-4190-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB0594D98C
	for <lists+cgroups@lfdr.de>; Sat, 10 Aug 2024 02:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501531C215FB
	for <lists+cgroups@lfdr.de>; Sat, 10 Aug 2024 00:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C48DF53;
	Sat, 10 Aug 2024 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PaFTn8rC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF311E4A9
	for <cgroups@vger.kernel.org>; Sat, 10 Aug 2024 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723249711; cv=none; b=ubzePxHn2b2HMiTx9ZrKbY2f7o1olxcI6KxeNVvq5glyy432ZhDqfAT9uATD/gctGHbqv+tobGIRVIVNbbk3WTbNWfZkVyuKJSHoj/IXG5FNqckxEI8XPwo8MRQdk/s8QvaVAY6qWhmwXSNSBOkY7Q098vzdzykOmpB09xr0JXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723249711; c=relaxed/simple;
	bh=x1GOANqk/UOeN8tsVo1aPaxm7S+bnCcXfZtJh+ysY0E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XXGzCt9Fx38jN1xzNiqiHvkgB/sI69cg+lsDRzQodXtGtUEu54RvPqKfVu9AP9nbzfy83HqztYOIvUqvNRzNtEeV9SwIXNhSIk6sY9UMO2Qn8zoYvuvrUvYU7bfCTD+A/B/6v8H0xvJMKBM7JaLHFWXNXYTU80zbXtv/J6QwWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PaFTn8rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CEFC32782;
	Sat, 10 Aug 2024 00:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723249711;
	bh=x1GOANqk/UOeN8tsVo1aPaxm7S+bnCcXfZtJh+ysY0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PaFTn8rClPV4pCH9y6SKnYBW2LOcS8lLJVlAY4vCNxPZAxG5eqQr+RnltKSb7xGeJ
	 KAWYo4gROt10AoOUiAHVaymM3sLMSgq1HORF05m8tG6ElTyTZqkMyYruMgtPWrskQv
	 hqJo9rpWzBjPIODmZSxm6nce0tXjIBsQ/05OV4h8=
Date: Fri, 9 Aug 2024 17:28:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kaiyang2@cs.cmu.edu
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, mhocko@kernel.org,
 nehagholkar@meta.com, abhishekd@meta.com, hannes@cmpxchg.org
Subject: Re: [PATCH] mm,memcg: provide per-cgroup counters for NUMA
 balancing operations
Message-Id: <20240809172830.58bece856debebd46279fc9d@linux-foundation.org>
In-Reply-To: <20240809212115.59291-1-kaiyang2@cs.cmu.edu>
References: <20240809212115.59291-1-kaiyang2@cs.cmu.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Aug 2024 21:21:15 +0000 kaiyang2@cs.cmu.edu wrote:

> From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
> 
> The ability to observe the demotion and promotion decisions made by the
> kernel on a per-cgroup basis is important for monitoring and tuning
> containerized workloads on either NUMA machines or machines
> equipped with tiered memory.
> 
> Different containers in the system may experience drastically different
> memory tiering actions that cannot be distinguished from the global
> counters alone.
> 
> For example, a container running a workload that has a much hotter
> memory accesses will likely see more promotions and fewer demotions,
> potentially depriving a colocated container of top tier memory to such
> an extent that its performance degrades unacceptably.
> 
> For another example, some containers may exhibit longer periods between
> data reuse, causing much more numa_hint_faults than numa_pages_migrated.
> In this case, tuning hot_threshold_ms may be appropriate, but the signal
> can easily be lost if only global counters are available.
> 
> This patch set adds five counters to
> memory.stat in a cgroup: numa_pages_migrated, numa_pte_updates,
> numa_hint_faults, pgdemote_kswapd and pgdemote_direct.
> 
> count_memcg_events_mm() is added to count multiple event occurrences at
> once, and get_mem_cgroup_from_folio() is added because we need to get a
> reference to the memcg of a folio before it's migrated to track
> numa_pages_migrated. The accounting of PGDEMOTE_* is moved to
> shrink_inactive_list() before being changed to per-cgroup.
> 

Thanks.  I lack the operational experience to be able to judge the
usefulness of this - hopefully others can weigh in.

Meanwhile, the patch is simple enough - I'll queue it up for testing.

