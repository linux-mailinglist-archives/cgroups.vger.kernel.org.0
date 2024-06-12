Return-Path: <cgroups+bounces-3164-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E54579053EB
	for <lists+cgroups@lfdr.de>; Wed, 12 Jun 2024 15:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1191F267CB
	for <lists+cgroups@lfdr.de>; Wed, 12 Jun 2024 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477C117B4F9;
	Wed, 12 Jun 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ePJun8sf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A2178398;
	Wed, 12 Jun 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199503; cv=none; b=PB4q1y8zAqCwDDixIjf9l2cm9JDaBkqEIfP81wEiOqfZrLDdMUjljr/f+HLP2sQYFmdU17ywqBaSLT+TXOE0qsQQoHKmkVl4+x4M/Cq/DSlTtSw90uNZg44W7a8eN6oSESXouaMJHXlSJK5pfLEVTdbMzVWeTPxWpjOwNh85LME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199503; c=relaxed/simple;
	bh=19BoleewHlYCHFKQnLXkBsG1yHfDLMIbAb+2JgXiqXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzesXDyQenJNwGoPj/cYdwM3nAv460LkZpYbDOwexuPQCGnuURhvvY2UOZKdqIARzyO8Fv5z0/kPMg1WqvcndukdvcngpAONugwAUZezf5OplL2Qh6rfgXtUmy2yvjMocC4oZEzwi6Wd+hpowb11498lL4PSgyKFEOS8SRkf1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ePJun8sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00988C3277B;
	Wed, 12 Jun 2024 13:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718199502;
	bh=19BoleewHlYCHFKQnLXkBsG1yHfDLMIbAb+2JgXiqXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePJun8sfQIIWJDpB2iUOO1/g5/U2Q3YqARvQ2f+Ux2BMyElq0gi3ofJKm4yW8jAHf
	 H2bdBmNezKQZCJ22WpsZiLHrOPF+9rmTxIEbXZdkzDlNI22f/8ehxT4QrB37NMR1Bw
	 LEPUe1ylawVfZgALSajtoNwzX77j6yRk1KJy5wtQ=
Date: Wed, 12 Jun 2024 15:38:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: stable@vger.kernel.org, yosryahmed@google.com, shakeel.butt@linux.dev,
	tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
	cgroups@vger.kernel.org, longman@redhat.com, linux-mm@kvack.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH 6.6.y] mm: ratelimit stat flush from workingset shrinker
Message-ID: <2024061209-tubular-saline-5719@gregkh>
References: <171776806121.384105.7980809581420394573.stgit@firesoul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171776806121.384105.7980809581420394573.stgit@firesoul>

On Fri, Jun 07, 2024 at 03:48:06PM +0200, Jesper Dangaard Brouer wrote:
> From: Shakeel Butt <shakeelb@google.com>
> 
> commit d4a5b369ad6d8aae552752ff438dddde653a72ec upstream.
> 
> One of our workloads (Postgres 14 + sysbench OLTP) regressed on newer
> upstream kernel and on further investigation, it seems like the cause is
> the always synchronous rstat flush in the count_shadow_nodes() added by
> the commit f82e6bf9bb9b ("mm: memcg: use rstat for non-hierarchical
> stats").  On further inspection it seems like we don't really need
> accurate stats in this function as it was already approximating the amount
> of appropriate shadow entries to keep for maintaining the refault
> information.  Since there is already 2 sec periodic rstat flush, we don't
> need exact stats here.  Let's ratelimit the rstat flush in this code path.
> 
> Link: https://lkml.kernel.org/r/20231228073055.4046430-1-shakeelb@google.com
> Fixes: f82e6bf9bb9b ("mm: memcg: use rstat for non-hierarchical stats")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> ---
> On production with kernel v6.6 we are observing issues with excessive
> cgroup rstat flushing due to the extra call to mem_cgroup_flush_stats()
> in count_shadow_nodes() introduced in commit f82e6bf9bb9b ("mm: memcg:
> use rstat for non-hierarchical stats") that commit is part of v6.6.
> We request backport of commit d4a5b369ad6d ("mm: ratelimit stat flush
> from workingset shrinker") as it have a fixes tag for this commit.
> 
> IMHO it is worth explaining call path that makes count_shadow_nodes()
> cause excessive cgroup rstat flushing calls. Function shrink_node()
> calls mem_cgroup_flush_stats() on its own first, and then invokes
> shrink_node_memcgs(). Function shrink_node_memcgs() iterates over
> cgroups via mem_cgroup_iter() for each calling shrink_slab(). The
> shrink_slab() calls do_shrink_slab() that via shrinker->count_objects()
> invoke count_shadow_nodes(), and count_shadow_nodes() does
> a mem_cgroup_flush_stats() call, that seems unnecessary.
> 
> Backport differs slightly due to v6.6.32 doesn't contain commit
> 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing") from v6.8.

Now queued up, thanks.

greg k-h

