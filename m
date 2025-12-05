Return-Path: <cgroups+bounces-12273-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B07CA5F10
	for <lists+cgroups@lfdr.de>; Fri, 05 Dec 2025 03:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D417230F3848
	for <lists+cgroups@lfdr.de>; Fri,  5 Dec 2025 02:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914CF2D8777;
	Fri,  5 Dec 2025 02:57:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9B47E0E8;
	Fri,  5 Dec 2025 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764903463; cv=none; b=KXBaT1WGkGGFe1ciYyWKmyWAsdE+fisoaRiJywNzhCUPIAoyjNE+n7n85192Tu3WJ7Id1jX27ZUIptcUlsCTF9722W93uwgr2rR64o+k8lHIOunBD7j/FcP467KPH0Uh6hBZjoIbhbadsISZNH1bh2gggMvS2pSbPz7AjPN2P5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764903463; c=relaxed/simple;
	bh=ksRE/Eot9adIEuoFc4/CEzjMdBR7uCYLc4WbEYhYkIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBJYxAkDawdrqcBWj0UTHQxfJiEK59czglBZBjl1JK6ZrpuPgDcIiI9d83sel3blnlC2+1fQmEvnYI63Cac2lXUHMn/Gala+SsaPq+imLIUJvlXXnOT3qXpCNvx8t8ds2qG70SVTqDY8TW9GfCPgvba/tBDy+7sQ3vOuqgH3ZN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4dMww86G3JzYkxrJ;
	Fri,  5 Dec 2025 10:55:04 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 5 Dec
 2025 10:57:32 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 5 Dec
 2025 10:57:32 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <hannes@cmpxchg.org>
CC: <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>,
	<axelrasmussen@google.com>, <cgroups@vger.kernel.org>,
	<chenridong@huawei.com>, <chenridong@huaweicloud.com>, <corbet@lwn.net>,
	<david@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <lujialin4@huawei.com>, <mhocko@suse.com>,
	<muchun.song@linux.dev>, <roman.gushchin@linux.dev>, <rppt@kernel.org>,
	<shakeel.butt@linux.dev>, <surenb@google.com>, <vbabka@suse.cz>,
	<weixugc@google.com>, <yuanchu@google.com>, <yuzhao@google.com>,
	<zhengqi.arch@bytedance.com>
Subject: Re: [RFC PATCH -next 1/2] mm/mglru: use mem_cgroup_iter for global reclaim
Date: Fri, 5 Dec 2025 10:57:27 +0800
Message-ID: <20251205025727.8324-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251204183437.GB481418@cmpxchg.org>
References: <20251204183437.GB481418@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a018.hihonor.com
 (10.68.17.250)

> From: Chen Ridong <chenridong@huawei.com>
> 
> The memcg LRU was originally introduced for global reclaim to enhance
> scalability. However, its implementation complexity has led to performance
> regressions when dealing with a large number of memory cgroups [1].
> 
> As suggested by Johannes [1], this patch adopts mem_cgroup_iter with
> cookie-based iteration for global reclaim, aligning with the approach
> already used in shrink_node_memcgs. This simplification removes the
> dedicated memcg LRU tracking while maintaining the core functionality.
> 
> It performed a stress test based on Zhao Yu's methodology [2] on a
> 1 TB, 4-node NUMA system. The results are summarized below:
> 
> 					memcg LRU    memcg iter
> stddev(pgsteal) / mean(pgsteal)            91.2%         75.7%
> sum(pgsteal) / sum(requested)             216.4%        230.5%

Are there more data available? For example, the load of kswapd or the refault values.

I am concerned about these two data points because Yu Zhao's implementation controls
the fairness of aging through memcg gen (get_memcg_gen). This helps reduce excessive
aging for certain cgroups, which is beneficial for kswapd's power consumption.

At the same time, pages that age earlier can be considered colder pages (in the entire system),
so reclaiming them should also help with the refault values.

> The new implementation demonstrates a significant improvement in
> fairness, reducing the standard deviation relative to the mean by
> 15.5 percentage points. While the reclaim accuracy shows a slight
> increase in overscan (from 85086871 to 90633890, 6.5%).
> 
> The primary benefits of this change are:
> 1. Simplified codebase by removing custom memcg LRU infrastructure
> 2. Improved fairness in memory reclaim across multiple cgroups
> 3. Better performance when creating many memory cgroups
> 
> [1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
> [2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

