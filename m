Return-Path: <cgroups+bounces-4267-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FAC952441
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EAD1C21745
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 20:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870991C57AF;
	Wed, 14 Aug 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="u9QNpxPL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649D1D545
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668723; cv=none; b=T1qJAVcfblGSyFifdsil00CpQ244d4vZz+suIkM4jN33Cc1I/MIyk4sJGWYmzD8t7R/Cm+CPCUkFvNLdjoD5IwHcem8tYbc5lPq0SRkMvebJsMnZTxeyyrawSImEX2L2SFWbIOqQkcGdB8HuSfiAbPE3Em03hAxtizO28MSooEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668723; c=relaxed/simple;
	bh=+2uyCP79sVA3+SCyRIYroJ/LtfahWV9TyMiSxufHXQE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Zgb54Ho7SNUPNpi4f3HT20KNORxz3BXyLogyCN/mB92fR9BJy5XUIbCF93VasWMhv6YZYoLYsVvVZ095kRGQZLGs7raML4btl8MuYFqRlaTeF3KAdtZVzboLTVSf7bpjfgW2lKuIG9bXrThdgIhVbUL9Zi7+xfFDk6K3xJVi6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=u9QNpxPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8705FC116B1;
	Wed, 14 Aug 2024 20:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723668723;
	bh=+2uyCP79sVA3+SCyRIYroJ/LtfahWV9TyMiSxufHXQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u9QNpxPLHLOc2gJi93X48j9NR6/RexgsfDUppFD1aFwaShU/QiC3f2DzCnpyljCGL
	 sjjEQiDw+5mV/rXHWyig2SvkOmw3FnxY8MFGLiPuMkVGWUFHqT0k3Et9Qu+m3fV13o
	 RL4ixLTN1qIL3HTtUVIVKDdSeXTPw55hC2zWosA8=
Date: Wed, 14 Aug 2024 13:52:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kaiyang2@cs.cmu.edu
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, mhocko@kernel.org,
 nehagholkar@meta.com, abhishekd@meta.com, hannes@cmpxchg.org,
 weixugc@google.com, rientjes@google.com
Subject: Re: [PATCH v3] mm,memcg: provide per-cgroup counters for NUMA
 balancing operations
Message-Id: <20240814135201.58cd0760bbeab13fcea82c4a@linux-foundation.org>
In-Reply-To: <20240814174227.30639-1-kaiyang2@cs.cmu.edu>
References: <20240814174227.30639-1-kaiyang2@cs.cmu.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 17:42:27 +0000 kaiyang2@cs.cmu.edu wrote:

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
> This patch set adds seven counters to memory.stat in a cgroup:
> numa_pages_migrated, numa_pte_updates, numa_hint_faults, pgdemote_kswapd,
> pgdemote_khugepaged, pgdemote_direct and pgpromote_success. pgdemote_*
> and pgpromote_success are also available in memory.numa_stat.
> 
> count_memcg_events_mm() is added to count multiple event occurrences at
> once, and get_mem_cgroup_from_folio() is added because we need to get a
> reference to the memcg of a folio before it's migrated to track
> numa_pages_migrated. The accounting of PGDEMOTE_* is moved to
> shrink_inactive_list() before being changed to per-cgroup.
>
> ...
>
> @@ -1383,6 +1412,13 @@ static const struct memory_stat memory_stats[] = {
>  	{ "workingset_restore_anon",	WORKINGSET_RESTORE_ANON		},
>  	{ "workingset_restore_file",	WORKINGSET_RESTORE_FILE		},
>  	{ "workingset_nodereclaim",	WORKINGSET_NODERECLAIM		},
> +
> +	{ "pgdemote_kswapd",		PGDEMOTE_KSWAPD		},
> +	{ "pgdemote_direct",		PGDEMOTE_DIRECT		},
> +	{ "pgdemote_khugepaged",	PGDEMOTE_KHUGEPAGED	},
> +#ifdef CONFIG_NUMA_BALANCING
> +	{ "pgpromote_success",		PGPROMOTE_SUCCESS	},
> +#endif
>  };

Please document these in Documentation/admin-guide/cgroup-v2.rst


