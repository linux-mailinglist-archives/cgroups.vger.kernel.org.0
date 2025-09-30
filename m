Return-Path: <cgroups+bounces-10495-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2027BAC5CC
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 11:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D65B1926BF0
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6908D2F49E0;
	Tue, 30 Sep 2025 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c+O4UpPr"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543D2940D;
	Tue, 30 Sep 2025 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225908; cv=none; b=EENA4UuzwOT4e3oM0t2HGyZNc4zXEjQb9Q6rqOiSXUC499F4DGeR7fOdzM6lHgJBnCdvBZBcTRuguDzLHE9lEaxcoOmmQR8+rexiQ1+QsOIBdUQeVuIQg9mzFLuuTR5LlxsooVzMi5PQf0G+NK4jOQOtmqA8KLkO9m6Uw5MdA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225908; c=relaxed/simple;
	bh=xbfmMVSL6wwhn/IzpllDy2SHwNxnzDHK4m7wWtC1B4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aKiyrWVRaYLo6LzsNQjN8xn65QW9ejsnRkFMHy9ujgqfiG0/dz51s8ZHKbs710RhP4IAt6BXRTZ30bfvtWfrqqwMFqben7k7U5sdoDFBqmyQ/BqtzeHG+5pnF1aMwS082xbqMXHOXMWn97pmI2VGtewbOvPP4ugildXNKvA95U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c+O4UpPr; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GizEg22Mg6+RiL81DkQqIA+YMAqI0aaUg111Iq5e0TU=;
	b=c+O4UpPr94sF4l8VdnvgET6bP+Sf87UT6MM2UL5QeodikB5ajUSkeLAx6QIea5SHYYl1IH36W
	aPANWXHNx0GLZFrkfkJSzY7LYrKAgtdHjxAsnzDJL2XFc5DUZAd1c23zPGh+k4rmmUnBTL/+1YM
	k28zloCHkgytmDbIdp/kQFM=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cbYGn1D0KzpStY;
	Tue, 30 Sep 2025 17:51:13 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 19081140AE3;
	Tue, 30 Sep 2025 17:51:42 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Sep 2025 17:51:41 +0800
Received: from hulk-cxc.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Sep 2025 17:51:41 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <llong@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lujialin4@huawei.com>, <caixinchen1@huawei.com>
Subject: [PATCH -next RFC 0/2] cpuset: Add cpuset.mems.spread_page to cgroup v2 
Date: Tue, 30 Sep 2025 09:35:50 +0000
Message-ID: <20250930093552.2842885-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200017.china.huawei.com (7.202.195.228)

I encountered a scenario where a machine with 1.5TB of memory,
while testing the Spark TPCDS 3TB dataset, experienced a significant
concentration of page cache usage on one of the NUMA nodes.
I discovered that the DataNode process had requested a large amount
of page cache. most of the page cache was concentrated in one NUMA node,
ultimately leading to the exhaustion of memory in that NUMA node.
At this point, all other processes in that NUMA node have to alloc
memory across NUMA nodes, or even across sockets. This eventually
caused a degradation in the end-to-end performance of the Spark test.

I do not want to restart the Spark DataNode service during business
operations. This issue can be resolved by migrating the DataNode into
a cpuset, dropping the cache, and setting cpuset.memory_spread_page to
allow it to evenly request memory. The core business threads could still
allocate local numa memory. After using cpuset.memory_spread_page, the
performance in the tpcds-99 test is improved by 2%.

The key point is that the even distribution of page cache within the
DataNode process (rather than the current NUMA distribution) does not
significantly affect end-to-end performance. However, the allocation
of core business processes, such as Executors, to the same NUMA node
does have a noticeable impact on end-to-end performance.

However, I found that cgroup v2 does not provide this interface. I
believe this interface still holds value in addressing issues caused
by uneven distribution of page cache allocation among process groups.

Thus I add cpuset.mems.spread_page to cpuset v2 interface.

Cai Xinchen (2):
  cpuset: Move cpuset1_update_spread_flag to cpuset
  cpuset: Add spread_page interface to cpuset v2

 kernel/cgroup/cpuset-internal.h |  6 ++--
 kernel/cgroup/cpuset-v1.c       | 25 +----------------
 kernel/cgroup/cpuset.c          | 49 ++++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 29 deletions(-)

-- 
2.34.1


