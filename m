Return-Path: <cgroups+bounces-11679-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAAEC424A9
	for <lists+cgroups@lfdr.de>; Sat, 08 Nov 2025 03:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 549114E5306
	for <lists+cgroups@lfdr.de>; Sat,  8 Nov 2025 02:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711D29A31C;
	Sat,  8 Nov 2025 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StlgWGzx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8422576E;
	Sat,  8 Nov 2025 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762568807; cv=none; b=ZgguQQN3Rc4n2AV2mGXt5RWypN6RC3ZlWdIksniCVr11Fvmsq2XWTsJxiaCN/hw/qqBqo1Nl/ZgEvutVTjIaz4F+5kJdAgnEaT8BJws5DIiKzRL+yrEjf86jjvXCKA9+zFXtelTZStFBMb+NlW8aZh9bjZypMHwFy+RsJtcRFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762568807; c=relaxed/simple;
	bh=oA3CoxR0bDnOkhkDCPr2By20i9HybBASnRQLHnaJ/FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qe9MaKwOdkd/srpki3TmKvsNwN/GAjEbke1z/+F/BPVh56DQRkdfvahwK35nZ43dz3JgMrN/6XYg5mN/Tgm7IkC+X1RZcJJ5dmKQPI4HLj1MnKnJXPnCkLIkEwMOANKN/EGDiHBLOzaQjriZ2O8N3i4i2FQwNsSi6FFhN2Ifz90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StlgWGzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19C5C4CEF8;
	Sat,  8 Nov 2025 02:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762568807;
	bh=oA3CoxR0bDnOkhkDCPr2By20i9HybBASnRQLHnaJ/FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StlgWGzxh3Q5DpZyFtP8lWwkxECa64WL/fWIcFXzrQeNc/2uRF4+obZx3jrZsFvyh
	 LLOY56R7R8HgxNpmwzpdUgH6/l7Q+EUDlw8Au8pRms2qNGiMrN1oaCf4WP1uZRo7EP
	 COJpzSE/RpIBNE/+8EteQ9MreKrxxzF1jv1h7CcdIsLlBQ1lCiV+DdvXQdHXynzqGy
	 1ykg4kmeHKMDJYAveCMIl9mDaQAjpDyqhBuK3/Cx+6l1dcBSyntP27KUNm4ViDchCp
	 D/EqlxVk3EKWMPQO+swcxZMSI6reze83hzRx5Gub5WrEOc4XF09UDjhFVTm303Omnz
	 qoV/PyTp1I1Ww==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: memcg: dump memcg protection info on oom or alloc failures
Date: Fri,  7 Nov 2025 18:26:38 -0800
Message-ID: <20251108022639.73734-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251107234041.3632644-1-shakeel.butt@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  7 Nov 2025 15:40:41 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Currently kernel dumps memory state on oom and allocation failures. One
> of the question usually raised on those dumps is why the kernel has not
> reclaimed the reclaimable memory instead of triggering oom. One
> potential reason is the usage of memory protection provided by memcg.
> So, let's also dump the memory protected by the memcg in such reports to
> ease the debugging.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
[...]
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c34029e92bab..623446821b00 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5636,3 +5636,16 @@ bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
>  {
>  	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
>  }
> +
> +void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
> +{
> +	if (mem_cgroup_disabled() || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		return;
> +
> +	if (!memcg)
> +		memcg = root_mem_cgroup;
> +
> +	pr_warn("Memory cgroup min protection %lukB -- low protection %lukB",
> +		K(atomic_long_read(&memcg->memory.children_min_usage)*PAGE_SIZE),
> +		K(atomic_long_read(&memcg->memory.children_low_usage)*PAGE_SIZE));
> +}

I didn't expect this function is showing the information by calling pr_warn().
To me, "show" feels like something for file operations, like memory_min_show().

What about s/show/dump/ on the name?  It makes it more consistent with the
subject of this patch, and other similar functions like dump_page() ?

No strong opinion.  The current name is also ok for me, but I'm just curious your thought.


Thanks,
SJ

[...]

