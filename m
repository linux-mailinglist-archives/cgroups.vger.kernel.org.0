Return-Path: <cgroups+bounces-6622-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5878A3E18D
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 17:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 178BC7A7357
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A3121325D;
	Thu, 20 Feb 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="li1GhPji"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7E2116F6
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070434; cv=none; b=Ht1B4kv9DdEbBrDzfW+sCZ3xR2cfA+MIiDxwaDN1ofqmPXR1fWRoMAKAGYseFMGXmhHAKA/C0fPpvAWAio/mT9kDpgfXcH0RbISl85AUlGzavpymsjyYlgbEw3FsgALP4DGwcNlIq/UeCKU7d1dkiz3QH6asJ5l1C0zEKs17kyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070434; c=relaxed/simple;
	bh=kV5v/xok/fEqcAxXknAn6bC7iXWDsO4NtycnzJs40sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUwoT2WtvRSAn+nWY0Ybl8x6M+yIjyZy648Wv4xqBFny0lKf7PT0tQUhE7tXvIrHWjgdzIk2YoNFexExIpK+I8Eg8A60F+lEzbfkEtiUV8CqlP0jDVwsGLyhOwyP3x+xDPKC89y/+4I/VwT6v+moTBGMRh3X7qay2TlxbrpKOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=li1GhPji; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 16:53:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740070429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BN9a67ew2xkxLArhOKgNEo4qqfDq1lcFzFd75Yb27g=;
	b=li1GhPjicEESF/SK9GMY0a8fGXlA3miatnY2Ops1O8eqGvtOBBLiX1LTN9X6u5dGAnQxgv
	4s6Wu+t29rKSiZWoEdJ/SxqpvfaGSyn1n8Gx2OCGtWDMNAKmY7TkVcBydIy6rNFnelkURS
	wTvwB9p4z/bstOIPSHz/I4Zx0ywxiOM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, tj@kernel.org, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 01/11] cgroup: move rstat pointers into struct of their
 own
Message-ID: <Z7deFViKJYXWj8nf@google.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-2-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 17, 2025 at 07:14:38PM -0800, JP Kobryn wrote:
> The rstat infrastructure makes use of pointers for list management.
> These pointers only exist as fields in the cgroup struct, so moving them
> into their own struct will allow them to be used elsewhere. The base
> stat entities are included with them for now.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  include/linux/cgroup-defs.h                   | 90 +-----------------
>  include/linux/cgroup_rstat.h                  | 92 +++++++++++++++++++
>  kernel/cgroup/cgroup.c                        |  3 +-
>  kernel/cgroup/rstat.c                         | 27 +++---
>  .../selftests/bpf/progs/btf_type_tag_percpu.c |  4 +-
>  5 files changed, 112 insertions(+), 104 deletions(-)
>  create mode 100644 include/linux/cgroup_rstat.h
> 
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 1b20d2d8ef7c..6b6cc027fe70 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -17,7 +17,7 @@
>  #include <linux/refcount.h>
>  #include <linux/percpu-refcount.h>
>  #include <linux/percpu-rwsem.h>
> -#include <linux/u64_stats_sync.h>
> +#include <linux/cgroup_rstat.h>
>  #include <linux/workqueue.h>
>  #include <linux/bpf-cgroup-defs.h>
>  #include <linux/psi_types.h>
> @@ -321,78 +321,6 @@ struct css_set {
>  	struct rcu_head rcu_head;
>  };
>  
> -struct cgroup_base_stat {
> -	struct task_cputime cputime;
> -
> -#ifdef CONFIG_SCHED_CORE
> -	u64 forceidle_sum;
> -#endif
> -	u64 ntime;
> -};
> -
> -/*
> - * rstat - cgroup scalable recursive statistics.  Accounting is done
> - * per-cpu in cgroup_rstat_cpu which is then lazily propagated up the
> - * hierarchy on reads.
> - *
> - * When a stat gets updated, the cgroup_rstat_cpu and its ancestors are
> - * linked into the updated tree.  On the following read, propagation only
> - * considers and consumes the updated tree.  This makes reading O(the
> - * number of descendants which have been active since last read) instead of
> - * O(the total number of descendants).
> - *
> - * This is important because there can be a lot of (draining) cgroups which
> - * aren't active and stat may be read frequently.  The combination can
> - * become very expensive.  By propagating selectively, increasing reading
> - * frequency decreases the cost of each read.
> - *
> - * This struct hosts both the fields which implement the above -
> - * updated_children and updated_next - and the fields which track basic
> - * resource statistics on top of it - bsync, bstat and last_bstat.
> - */
> -struct cgroup_rstat_cpu {
> -	/*
> -	 * ->bsync protects ->bstat.  These are the only fields which get
> -	 * updated in the hot path.
> -	 */
> -	struct u64_stats_sync bsync;
> -	struct cgroup_base_stat bstat;
> -
> -	/*
> -	 * Snapshots at the last reading.  These are used to calculate the
> -	 * deltas to propagate to the global counters.
> -	 */
> -	struct cgroup_base_stat last_bstat;
> -
> -	/*
> -	 * This field is used to record the cumulative per-cpu time of
> -	 * the cgroup and its descendants. Currently it can be read via
> -	 * eBPF/drgn etc, and we are still trying to determine how to
> -	 * expose it in the cgroupfs interface.
> -	 */
> -	struct cgroup_base_stat subtree_bstat;
> -
> -	/*
> -	 * Snapshots at the last reading. These are used to calculate the
> -	 * deltas to propagate to the per-cpu subtree_bstat.
> -	 */
> -	struct cgroup_base_stat last_subtree_bstat;
> -
> -	/*
> -	 * Child cgroups with stat updates on this cpu since the last read
> -	 * are linked on the parent's ->updated_children through
> -	 * ->updated_next.
> -	 *
> -	 * In addition to being more compact, singly-linked list pointing
> -	 * to the cgroup makes it unnecessary for each per-cpu struct to
> -	 * point back to the associated cgroup.
> -	 *
> -	 * Protected by per-cpu cgroup_rstat_cpu_lock.
> -	 */
> -	struct cgroup *updated_children;	/* terminated by self cgroup */
> -	struct cgroup *updated_next;		/* NULL iff not on the list */
> -};
> -
>  struct cgroup_freezer_state {
>  	/* Should the cgroup and its descendants be frozen. */
>  	bool freeze;
> @@ -517,23 +445,9 @@ struct cgroup {
>  	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
>  
>  	/* per-cpu recursive resource statistics */
> -	struct cgroup_rstat_cpu __percpu *rstat_cpu;
> +	struct cgroup_rstat rstat;
>  	struct list_head rstat_css_list;
>  
> -	/*
> -	 * Add padding to separate the read mostly rstat_cpu and
> -	 * rstat_css_list into a different cacheline from the following
> -	 * rstat_flush_next and *bstat fields which can have frequent updates.
> -	 */
> -	CACHELINE_PADDING(_pad_);
> -
> -	/*
> -	 * A singly-linked list of cgroup structures to be rstat flushed.
> -	 * This is a scratch field to be used exclusively by
> -	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
> -	 */
> -	struct cgroup	*rstat_flush_next;
> -
>  	/* cgroup basic resource statistics */
>  	struct cgroup_base_stat last_bstat;
>  	struct cgroup_base_stat bstat;
> diff --git a/include/linux/cgroup_rstat.h b/include/linux/cgroup_rstat.h
> new file mode 100644
> index 000000000000..f95474d6f8ab
> --- /dev/null
> +++ b/include/linux/cgroup_rstat.h
> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_RSTAT_H
> +#define _LINUX_RSTAT_H
> +
> +#include <linux/u64_stats_sync.h>
> +
> +struct cgroup_rstat_cpu;

Why do we need the forward declaration instead of just defining struct
cgroup_rstat_cpu first? Also, why do we need a new header for these
definitions rather than just adding struct cgroup_rstat to
cgroup-defs.h?

> +
> +/*
> + * rstat - cgroup scalable recursive statistics.  Accounting is done
> + * per-cpu in cgroup_rstat_cpu which is then lazily propagated up the
> + * hierarchy on reads.
> + *
> + * When a stat gets updated, the cgroup_rstat_cpu and its ancestors are
> + * linked into the updated tree.  On the following read, propagation only
> + * considers and consumes the updated tree.  This makes reading O(the
> + * number of descendants which have been active since last read) instead of
> + * O(the total number of descendants).
> + *
> + * This is important because there can be a lot of (draining) cgroups which
> + * aren't active and stat may be read frequently.  The combination can
> + * become very expensive.  By propagating selectively, increasing reading
> + * frequency decreases the cost of each read.
> + *
> + * This struct hosts both the fields which implement the above -
> + * updated_children and updated_next - and the fields which track basic
> + * resource statistics on top of it - bsync, bstat and last_bstat.
> + */
> +struct cgroup_rstat {
> +	struct cgroup_rstat_cpu __percpu *rstat_cpu;
> +
> +	/*
> +	 * Add padding to separate the read mostly rstat_cpu and
> +	 * rstat_css_list into a different cacheline from the following
> +	 * rstat_flush_next and containing struct fields which can have
> +	 * frequent updates.
> +	 */
> +	CACHELINE_PADDING(_pad_);
> +	struct cgroup *rstat_flush_next;
> +};
> +
> +struct cgroup_base_stat {
> +	struct task_cputime cputime;
> +
> +#ifdef CONFIG_SCHED_CORE
> +	u64 forceidle_sum;
> +#endif
> +	u64 ntime;
> +};
> +
> +struct cgroup_rstat_cpu {
> +	/*
> +	 * Child cgroups with stat updates on this cpu since the last read
> +	 * are linked on the parent's ->updated_children through
> +	 * ->updated_next.
> +	 *
> +	 * In addition to being more compact, singly-linked list pointing
> +	 * to the cgroup makes it unnecessary for each per-cpu struct to
> +	 * point back to the associated cgroup.
> +	 */
> +	struct cgroup *updated_children;	/* terminated by self */
> +	struct cgroup *updated_next;		/* NULL if not on the list */
> +
> +	/*
> +	 * ->bsync protects ->bstat.  These are the only fields which get
> +	 * updated in the hot path.
> +	 */
> +	struct u64_stats_sync bsync;
> +	struct cgroup_base_stat bstat;
> +
> +	/*
> +	 * Snapshots at the last reading.  These are used to calculate the
> +	 * deltas to propagate to the global counters.
> +	 */
> +	struct cgroup_base_stat last_bstat;
> +
> +	/*
> +	 * This field is used to record the cumulative per-cpu time of
> +	 * the cgroup and its descendants. Currently it can be read via
> +	 * eBPF/drgn etc, and we are still trying to determine how to
> +	 * expose it in the cgroupfs interface.
> +	 */
> +	struct cgroup_base_stat subtree_bstat;
> +
> +	/*
> +	 * Snapshots at the last reading. These are used to calculate the
> +	 * deltas to propagate to the per-cpu subtree_bstat.
> +	 */
> +	struct cgroup_base_stat last_subtree_bstat;
> +};
> +
> +#endif	/* _LINUX_RSTAT_H */

