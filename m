Return-Path: <cgroups+bounces-5325-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A319B5DF1
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 09:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67948284615
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F32E1E1051;
	Wed, 30 Oct 2024 08:33:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C39A1E0E03;
	Wed, 30 Oct 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277226; cv=none; b=erl/eJjADogEioaAlSYNDHO5fjIugestGzIv/UmmP5JRlqiWQxHwdhOJ2kYwdWe39qv9MAUbsvfvkudya5GhmU4qab0wCHyyHuYCJRlVeLYI1ZHjked6klmfrvKbk6N5gU9BBiE9a9TeP6nNaxIKXWuRtt4tnj062vEAvHs+05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277226; c=relaxed/simple;
	bh=fIPFKRugFANiAETehkwkaz8Ylpefy6HEJTDnwnmVuc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IfTTjVwLPdvzzxTbb97i28brSlPPeGsdLU/JUq4NHYqLK1f5AcnSedy+OwGCmLwarp4FcEy9WqNwx0kAAYrDs0Pd4/qMqN1f/+D7WbXk0Okuw+omvTtGrWq33msILaT2tZP2FRJaeRXV7nIpjjlJPocnq9c3XH7rBLPfTSdxMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdgJK6rb8z6GFsL;
	Wed, 30 Oct 2024 16:28:49 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id C0FF8140A35;
	Wed, 30 Oct 2024 16:33:40 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 30 Oct 2024 11:33:40 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<baohua@kernel.org>, <willy@infradead.org>, <peterx@redhat.com>,
	<hannes@cmpxchg.org>, <hocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stepanov.anatoly@huawei.com>,
	<alexander.kozhevnikov@huawei-partners.com>, <guohanjun@huawei.com>,
	<weiyongjun1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<kang.sun@huawei.com>
Subject: [RFC PATCH 0/3] Cgroup-based THP control
Date: Wed, 30 Oct 2024 16:33:08 +0800
Message-ID: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Currently THP modes are set globally. It can be an overkill if only some
specific app/set of apps need to get benefits from THP usage. Moreover, various
apps might need different THP settings. Here we propose a cgroup-based THP
control mechanism.

THP interface is added to memory cgroup subsystem. Existing global THP control
semantics is supported for backward compatibility. When THP modes are set
globally all the changes are propagated to memory cgroups. However, when a
particular cgroup changes its THP policy, the global THP policy in sysfs remains
the same.

New memcg files are exposed: memory.thp_enabled and memory.thp_defrag, which
have completely the same format as global THP enabled/defrag.

Child cgroups inherit THP settings from parent cgroup upon creation. Particular
cgroup mode changes aren't propagated to child cgroups.

During the memory cgroup attachment stage, the correct slots
are added or removed to khugepaged according to the THP
policy.

Usage examples:

Set globally "madvise" mode:
# echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
# cat /sys/kernel/mm/transparent_hugepage/enabled
always [madvise] never

All the settings are propagated
# cat /sys/fs/cgroup/memory.thp_enabled
always [madvise] never

# cat /sys/fs/cgroup/test/memory.thp_enabled
always [madvise] never

Set "always" for some specific cgroup:
# echo always > /sys/fs/cgroup/test/memory.thp_enabled
# cat /sys/fs/cgroup/test/memory.thp_enabled
[always] madvise never

Root cgroup remains with "madvise" mode:
# cat /sys/fs/cgroup/memory.thp_enabled
always [madvise] never

When attempting to read global settings we get "mixed state" warning as the
THP-mode isn't the same for every cgroup:
# cat /sys/kernel/mm/transparent_hugepage/enabled
Mixed state: see particular memcg flags! 

Again, set THP mode globally, make sure everything works fine:
# echo never > /sys/kernel/mm/transparent_hugepage/enabled
# cat /sys/kernel/mm/transparent_hugepage/enabled
always madvise [never]

# cat /sys/fs/cgroup/memory.thp_enabled
always madvise [never]

# cat /sys/fs/cgroup/test/memory.thp_enabled
always madvise [never]

Here is a simple demo with a 
test which is doing anon. mmap() and a series of random reads.
System is rebooted between the cases.

Case 1: Global THP - always. No cgroup.

// Global THP stats:
AnonHugePages:    391168 kB
FileHugePages:    120832 kB
FilePmdMapped:     67584 kB

// THP stats from *smaps* of the testing process
AnonHugePages:     12288 kB

Case 2: Global THP - never. Cgroup - always.

// Global THP stats:
AnonHugePages:     12288 kB
FileHugePages:      2048 kB
FilePmdMapped:      2048 kB

// THP stats from *smaps* of the testing process
AnonHugePages:     12288 kB

// The cgroup THP stats
anon_thp 12582912
file_thp 2097152

Obviously there's a huge difference between the two in terms of global THP 
usage, thus showing the cgroup approach is beneficial for such cases, when a 
specific app/set of apps needs THP, but not willing to change anything in the 
app. code.

TODO list:

1. Anonymous mTHP
2. Fine-grained mode selection for different VMA types: "anon|exec|ro|file", to
   be able to support combinations as: "always + exec", "always + anon", etc.
3. Per-cgroup limit for the THP usage


Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
Reviewed-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>

Asier Gutierrez, Anatoly Stepanov (3):
  mm: Add thp_flags control for cgroup
  mm: Support for huge pages in cgroups
  mm: Add thp_defrag control for cgroup


 include/linux/huge_mm.h    |  23 +++-
 include/linux/khugepaged.h |   2 +-
 include/linux/memcontrol.h |  28 ++++
 mm/huge_memory.c           | 207 ++++++++++++++++++-----------
 mm/khugepaged.c            |   8 +-
 mm/memcontrol.c            | 262 +++++++++++++++++++++++++++++++++++++
 6 files changed, 449 insertions(+), 81 deletions(-)

-- 
2.34.1


