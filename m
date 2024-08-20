Return-Path: <cgroups+bounces-4365-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EA2957BCA
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 05:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674D11C23BCC
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 03:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1BF13A86A;
	Tue, 20 Aug 2024 03:09:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7050285;
	Tue, 20 Aug 2024 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123356; cv=none; b=TiWcK2RGd5JOneL1QTi4p93paCBXt0X76XN2BSpiDX9nPk/INQAUuZgXTZMh0qOcubRz4qgYAiyNIFpQnCj01doNcIsI0IjBs1ceCU5+6l/52YZtRLrPEsBGTIKKUERUVSfEThgAzru4WH3autJUfmsBEyT0Ud8Sst3pB9FzH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123356; c=relaxed/simple;
	bh=x/dQjt+SI5PYEpMKAmX6f5FN1RZaX99JafDnT5L77gw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgWpur8it3Y5MMo2viBeGj2B3A8FRHjithTDI2s2PXd14i24bjCS9J44QihNJesHva5quBzazOq8Bbw+AWKufBGX6vBDkDX03uajqwIsuLzzFsi8MKrUgoWKVRP1JTu9dd8djobZXcEJOE13vJddDywp6MqI6YqSCZZ2qXyjcck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WnvSp1vzyz20m1v;
	Tue, 20 Aug 2024 11:04:26 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 769C71A016C;
	Tue, 20 Aug 2024 11:09:06 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 20 Aug
 2024 11:09:05 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next 2/3] cgroup/cpuset: remove fetch_xcpus
Date: Tue, 20 Aug 2024 03:01:25 +0000
Message-ID: <20240820030126.236997-3-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820030126.236997-1-chenridong@huawei.com>
References: <20240820030126.236997-1-chenridong@huawei.com>
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

Both fetch_xcpus and user_xcpus functions are used to retrieve the value
of exclusive_cpus. If exclusive_cpus is not set, cpus_allowed is the
implicit value used as exclusive in a local partition. I can not imagine
a scenario where effective_xcpus is not empty when exclusive_cpus is
empty. Therefore, I suggest removing the fetch_xcpus function.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0ae68e0e5733..92e79ddc8188 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -771,13 +771,6 @@ static inline bool xcpus_empty(struct cpuset *cs)
 	       cpumask_empty(cs->exclusive_cpus);
 }
 
-static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
-{
-	return !cpumask_empty(cs->exclusive_cpus) ? cs->exclusive_cpus :
-	       cpumask_empty(cs->effective_xcpus) ? cs->cpus_allowed
-						  : cs->effective_xcpus;
-}
-
 /*
  * cpusets_are_exclusive() - check if two cpusets are exclusive
  *
@@ -785,8 +778,8 @@ static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
  */
 static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
 {
-	struct cpumask *xcpus1 = fetch_xcpus(cs1);
-	struct cpumask *xcpus2 = fetch_xcpus(cs2);
+	struct cpumask *xcpus1 = user_xcpus(cs1);
+	struct cpumask *xcpus2 = user_xcpus(cs2);
 
 	if (cpumask_intersects(xcpus1, xcpus2))
 		return false;
@@ -2585,7 +2578,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		invalidate = true;
 		rcu_read_lock();
 		cpuset_for_each_child(cp, css, parent) {
-			struct cpumask *xcpus = fetch_xcpus(trialcs);
+			struct cpumask *xcpus = user_xcpus(trialcs);
 
 			if (is_partition_valid(cp) &&
 			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
-- 
2.34.1


