Return-Path: <cgroups+bounces-12961-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8609D01076
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 06:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A67A30285E9
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 05:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0732D23A4;
	Thu,  8 Jan 2026 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQNMbCmB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E82D0C7A;
	Thu,  8 Jan 2026 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767848404; cv=none; b=fjhPVaALbvXDkHJsYJICH6vnOkf056W7rtMqTqJ55ajddo+C4niM3vF6PeS+9a5IZMtCM41ZCJUabfe8Ie8pqxbekqAjv6IZeJd6XGdGwO4gfdnzbBzBMJA+uu9i2rxTo0Zoeh+UVo8dfQXMhCXUIVNDXT+wquGfDOcNTctU/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767848404; c=relaxed/simple;
	bh=1B3KdBEHnVGrwHaFJwXfUoo0ljW4nYwZYlVoHlNtMbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpPrexarPhXPYuB0K6wtLvcThU1Fo8uvn8hyJlbgdU6XbTAQKN5AXCKziCCt6YtX8iHS1qRo1pWh0e2975foAP3gN3WQw2+ZXZiyVAEzS5atk8ZDc2IH1LClnvcJOnnrETOZWe6rXU4RCBAe40/krpR3iMfUPY/SZTrGqiUnX2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQNMbCmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8A6C116C6;
	Thu,  8 Jan 2026 05:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767848404;
	bh=1B3KdBEHnVGrwHaFJwXfUoo0ljW4nYwZYlVoHlNtMbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQNMbCmBM9WpAmQhgaPJlGrgLfeeGSplgIBSGEGP6VX90OUNEZ3Ioun9kY5r6qB1S
	 d4QlsO3fYjjFIjM3iLTiHpBuqdNY/3811RGlnhZ68pBR7ElHNt7dkbjsD2JKdpTzNl
	 igdlHBIafM+F+kZjqS0tBRHWmJrOVSMtg665Gks9Y+VZhAy3hrIHYBqJAOTiHlzaYj
	 iXYFMD08wjVySlCJ360/9ZG2vHol3zJRMu+q7JOP6PHkdt+72DvIiK5CUeqLALQuyc
	 cqJ/MPq8UQuy3HsLjtQwUspDb2MiFjdSu7K0zjUduWIyuiSPIqHlFnMTg6ERugEqVw
	 iXCFGyxISnQqg==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] memcg: rename mem_cgroup_ino() to mem_cgroup_id()
Date: Wed,  7 Jan 2026 20:59:53 -0800
Message-ID: <20260108045954.78552-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251225232116.294540-9-shakeel.butt@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Dec 2025 15:21:16 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Rename mem_cgroup_ino() to mem_cgroup_id() and mem_cgroup_get_from_ino()
> to mem_cgroup_get_from_id(). These functions now use cgroup IDs (from
> cgroup_id()) rather than inode numbers, so the names should reflect that.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

I left trivial comments below.  Because those are only trivial,

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  include/linux/memcontrol.h |  8 ++++----
>  mm/damon/core.c            |  2 +-
>  mm/damon/ops-common.c      |  2 +-
>  mm/damon/sysfs-schemes.c   |  2 +-
>  mm/memcontrol.c            |  2 +-
>  mm/shrinker_debug.c        | 10 +++++-----
>  mm/vmscan.c                |  6 +++---
>  7 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3e7d69020b39..5a1161cadb8d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
[...]
> -struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino);
> +struct mem_cgroup *mem_cgroup_get_from_id(u64 ino);

Nit.  How about renaming the argument from 'ino' to 'id'?

[...]
> -static inline struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino)
> +static inline struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)

Ditto.

[...]
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3615,7 +3615,7 @@ struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id)
>  	return xa_load(&mem_cgroup_private_ids, id);
>  }
>  
> -struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino)
> +struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)

Ditto.


Thanks,
SJ

[...]

