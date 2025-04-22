Return-Path: <cgroups+bounces-7717-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C5A96A38
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 14:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BD8189F6C8
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC127D76A;
	Tue, 22 Apr 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R9zA1AGK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FED12F5A5
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325557; cv=none; b=Pd1lshGxGmQI7dnvgVlwY7xrrOOqQblNTpvo+9If4t23OgimV2/UIB/bmTlhZO5XFXP7Xkc7r/n219QqDAjPHmdKvHhZUxyX/cM6K8FhniFnHbfYSSE1xfu5VCLVBf/12rpLSLfo1Kf3k34Yb81Ek0JRqVdJhzF2IxqXZhijcog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325557; c=relaxed/simple;
	bh=i5VnXW9R0oaS0HdeA2ZGXnIgs63lLofaYYf0kU5gQg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3UigV2W1UvFAZAfWtEmMB5PopgPS229eEyFv81zEBeEq9yuTWxq2EJjRPVi/cdqcMXezi6oPZjEYJew8hBEr6wjkpyClgK2UkaxpDvh3BIy5xuRzVT7cyfuqjVlzHtn/EDESX/UIO/Wg3QdWf8123JMUCY/AAj1HL1mBG4r96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R9zA1AGK; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 05:39:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745325552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzWMaBkQgXvqygLl2B6be6LqiITXFJ6CTmy66vVzN1A=;
	b=R9zA1AGKoYzDhcMcBt/hpF9tbDu80KiRsmjJYvLFVLVdKZ5Lg42JM76PSSRm2UMNfjaXPA
	pUFHZeSNmi08F11pqNFOv6CaqaOrntXFNMbWTE0geglMVKsKEKs0JYkLDFI2GDiTMMTwuq
	hyS1LCwtY2oINGZjZ0kTGgJFhLe886M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
	mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 3/5] cgroup: change rstat function signatures from
 cgroup-based to css-based
Message-ID: <aAeN5ArzRyvaUE9K@Asmaa.>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-4-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404011050.121777-4-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 03, 2025 at 06:10:48PM -0700, JP Kobryn wrote:
> This non-functional change serves as preparation for moving to
> subsystem-based rstat trees. To simplify future commits, change the
> signatures of existing cgroup-based rstat functions to become css-based and
> rename them to reflect that.
> 
> Though the signatures have changed, the implementations have not. Within
> these functions use the css->cgroup pointer to obtain the associated cgroup
> and allow code to function the same just as it did before this patch. At
> applicable call sites, pass the subsystem-specific css pointer as an
> argument or pass a pointer to cgroup::self if not in subsystem context.
> 
> Note that cgroup_rstat_updated_list() and cgroup_rstat_push_children()
> are not altered yet since there would be a larger amount of css to
> cgroup conversions which may overcomplicate the code at this
> intermediate phase.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  block/blk-cgroup.c                            |  6 +-
>  include/linux/cgroup-defs.h                   |  2 +-
>  include/linux/cgroup.h                        |  4 +-
>  kernel/cgroup/cgroup-internal.h               |  4 +-
>  kernel/cgroup/cgroup.c                        | 30 ++++---
>  kernel/cgroup/rstat.c                         | 83 +++++++++++--------
>  mm/memcontrol.c                               |  4 +-
>  .../bpf/progs/cgroup_hierarchical_stats.c     |  9 +-
>  8 files changed, 80 insertions(+), 62 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 5905f277057b..0560ea402856 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1144,7 +1144,7 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>  /*
>   * We source root cgroup stats from the system-wide stats to avoid
>   * tracking the same information twice and incurring overhead when no
> - * cgroups are defined. For that reason, cgroup_rstat_flush in
> + * cgroups are defined. For that reason, css_rstat_flush in
>   * blkcg_print_stat does not actually fill out the iostat in the root
>   * cgroup's blkcg_gq.
>   *
> @@ -1253,7 +1253,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
>  	if (!seq_css(sf)->parent)
>  		blkcg_fill_root_iostats();
>  	else
> -		cgroup_rstat_flush(blkcg->css.cgroup);
> +		css_rstat_flush(&blkcg->css);
>  
>  	rcu_read_lock();
>  	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
> @@ -2243,7 +2243,7 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	}
>  
>  	u64_stats_update_end_irqrestore(&bis->sync, flags);
> -	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
> +	css_rstat_updated(&blkcg->css, cpu);
>  	put_cpu();
>  }
>  
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 6d177f770d28..e4a9fb00b228 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -536,7 +536,7 @@ struct cgroup {
>  	/*
>  	 * A singly-linked list of cgroup structures to be rstat flushed.
>  	 * This is a scratch field to be used exclusively by
> -	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
> +	 * css_rstat_flush_locked() and protected by cgroup_rstat_lock.

Also, I believe this function does not exist anymore.

