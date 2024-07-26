Return-Path: <cgroups+bounces-3913-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B836A93D014
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 11:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41034B221C4
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA1C177991;
	Fri, 26 Jul 2024 09:07:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAC1F951;
	Fri, 26 Jul 2024 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984827; cv=none; b=o5Lkh0uo7fUHpX0Fn9d75B+ldKbUUwQiECcpvBfu6/5U/9+JQyCdjKF5B8tJneUZKN7nCEbjIbAq/tz10BL9Bw0uYohYb3S06wm1sliXFSz9KDyteXnA1c81rCxBDfoEIC71/pPdEWTfDYQfrj/kwXoGZaACIIHoq3/0X09LEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984827; c=relaxed/simple;
	bh=2aDGoRg8fvKt7Yb70xVX1qYzzL161lif6nd/gd8dhBM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EM/SvDa5dYBdENm/KSD8zFzgqh/RRP2ZKv+gKu0LeItJYr1deiDWaxZv5d3bJUBcd7S2ws2Qeg6TMs9qBqHNl5VDKSAKTiTfxN3nwfqMrqj4Law2Sv3XfVe9bHmIlAeuD4TW5zBoIOxQ2cAsOqxRaUee81/fOeTqCq5/LiSZBh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WVhhV6n45z1L8sY;
	Fri, 26 Jul 2024 17:06:50 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F27B180102;
	Fri, 26 Jul 2024 17:06:55 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 26 Jul
 2024 17:06:54 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: reduce redundant comparisons for generating shecd domains
Date: Fri, 26 Jul 2024 08:59:46 +0000
Message-ID: <20240726085946.2243526-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)

In the generate_sched_domains function, it's unnecessary to start the
second for loop with zero, which leads redundant comparisons.
Simply start with i+1, as that is sufficient.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 40ec4abaf440..1c4c36db3d93 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1113,7 +1113,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 		struct cpuset *a = csa[i];
 		int apn = a->pn;
 
-		for (j = 0; j < csn; j++) {
+		for (j = i + 1; j < csn; j++) {
 			struct cpuset *b = csa[j];
 			int bpn = b->pn;
 
-- 
2.34.1


