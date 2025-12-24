Return-Path: <cgroups+bounces-12635-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2700CCDB61B
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 06:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A682F3017F2A
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 05:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38962E2665;
	Wed, 24 Dec 2025 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVRlH+oy"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90929E11D;
	Wed, 24 Dec 2025 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766553716; cv=none; b=d8dytQCaGDqFLDj734+UN7xEiKdR4q8SeVPAmohXxK8s3CVH/QJbEGrBlcTE/+rSGmyxLDZyb1V8aTD92ZLmpRSUokrr70LF1vCB+HH5dGc6Yn5CRtRShlrH9yatLi0SWFhpONAYffJIp+WMTvRRTEJC4KjchG4UysZip+6Lxco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766553716; c=relaxed/simple;
	bh=1i0AGvXVVrHdy9xcXcgBlco2Ngv8dnUQED7TtSQCPlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8upnW3BjSywq/qk9Tv7Umbc4G8ZtY7DTYfGWl2VvX6JTZwSBUGFtOWebKZZnj+PT2IcwzhLADEZnZ2olvEv5n3shAWc+QzJ8WAUs53rmqjVGgO3gNcZzgL5ffBnZyV3EZs4km20FfknyJzSF7qG3qDJAgLtPxcGvhyC1+QHhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVRlH+oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D318EC4CEFB;
	Wed, 24 Dec 2025 05:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766553716;
	bh=1i0AGvXVVrHdy9xcXcgBlco2Ngv8dnUQED7TtSQCPlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVRlH+oykfekemzk2FwHD+HxDBl/P+HAohM82+BUGVn3Xs2qbZKAzgevGU3mQSa4A
	 bFPC3hkGmyKkS2YKWZIKn5u0FHtrUW1ClsbyboFV/cyFQn/snsEN+c8bN9lvZlq1Kb
	 qo69DA5iAGcoKvAHy2Z4sZkZROgvbNkh7rOkdwjmkxwJ7ZjulRSxC1mqICtfBJnpou
	 yMtW4jiO+qspAv8tFpozGD7E/Pq7M3DPfvFJ6Q/cYG7Mlw0X1Oa3j4DWOQETieS8Nk
	 eUZCrNtHGv8AVtfQ1SGw/flpI0A+AyX1ESZ9syiYQum5luL2nagBZGYOvOfhfF7+C9
	 oRe1bFeQR+KaQ==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: damon: get memcg reference before access
Date: Tue, 23 Dec 2025 21:21:47 -0800
Message-ID: <20251224052148.68796-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224034527.3751306-1-shakeel.butt@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Dec 2025 19:45:27 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> The commit b74a120bcf507 ("mm/damon/core: implement
> DAMOS_QUOTA_NODE_MEMCG_USED_BP") added accesses to memcg structure
> without getting reference to it. This is unsafe. Let's get the reference
> before accessing the memcg.

Thank you for catching and fixing this!

Nit.  On the subject, could we use 'mm/damon/core:' prefix instead of 'memcg:
damon:' for keeping the file's commit log subjects consistent?

> 
> Fixes: b74a120bcf507 ("mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP")

I was firsty thinking we might need to Cc: stable@.  But I realized the broken
commit has merged into 6.19-rc1.  So Cc: stable@ is not needed.

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Other than the tirivial subject prefix inconsistency, looks good to me.

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4ad5f290d382..89982e0229f0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2051,13 +2051,15 @@ static unsigned long damos_get_node_memcg_used_bp(
>  
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_id(goal->memcg_id);
> -	rcu_read_unlock();
> -	if (!memcg) {
> +	if (!memcg || !mem_cgroup_tryget(memcg)) {

For this part, I was thinking '!memcg' part seems not technically needed
because mem_cgroup_tryget() does the check.  But I think that's just trivial,
so this also looks good to me.

> +		rcu_read_unlock();
>  		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
>  			return 0;
>  		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
>  			return 10000;
>  	}
> +	rcu_read_unlock();
> +
>  	mem_cgroup_flush_stats(memcg);
>  	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(goal->nid));
>  	used_pages = lruvec_page_state(lruvec, NR_ACTIVE_ANON);
> @@ -2065,6 +2067,8 @@ static unsigned long damos_get_node_memcg_used_bp(
>  	used_pages += lruvec_page_state(lruvec, NR_ACTIVE_FILE);
>  	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_FILE);
>  
> +	mem_cgroup_put(memcg);
> +
>  	si_meminfo_node(&i, goal->nid);
>  	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
>  		numerator = used_pages;
> -- 
> 2.47.3


Thanks,
SJ

[...]

