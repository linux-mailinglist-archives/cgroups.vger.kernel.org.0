Return-Path: <cgroups+bounces-4032-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930B6942A73
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 11:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17374B22DF5
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56751AAE2F;
	Wed, 31 Jul 2024 09:28:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE0643ACB;
	Wed, 31 Jul 2024 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418102; cv=none; b=i72DAuvg7b1uprDeOwC8Py8ztdDeNfnlMTzLCa46js7FtCBSx7l9SHemdgEjjut1hShpXRfSAyiHVlv9RYlj1tbX8Nd/2qx335UqpvIAXyXweWviqepdDtGfjbyKXXk4+krtcUImpuFwRuy/IVtCrfUiIvsZoV61XU2h/tHyqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418102; c=relaxed/simple;
	bh=m9ybYCieBZjq7BVBviWIevcefmS2bXQGAuzliTHlPE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XinSt3qUW3M+yp06Volx0+/bDRgvp7H8KJPYUIyEpm9CKGXROQtR9kwyjPMnjtM0ZBvhCPIW2jDeM4qq+ku0QS2Yd3tDFmOYL/GYJh90zxFIuWahWrcB76O3EIt1GIwsne7u2FMFK4DG/dSpHHt4NJChtzNZV054t1cNEWUGhxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WYmtq1cvxzgYn3;
	Wed, 31 Jul 2024 17:26:27 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id ABEB818005F;
	Wed, 31 Jul 2024 17:28:17 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 31 Jul
 2024 17:28:17 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: Do not clear xcpus when clearing cpus
Date: Wed, 31 Jul 2024 09:21:02 +0000
Message-ID: <20240731092102.2369580-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)

After commit 737bb142a00d ("cgroup/cpuset: Make cpuset.cpus.exclusive
independent of cpuset.cpus"), cpuset.cpus.exclusive and cpuset.cpus
became independent. However we found that cpuset.cpus.exclusive.effective
is cleared when cpuset.cpus is clear. To fix this issue, just remove xcpus
clearing when cpuset.cpus is being cleared.

It can be reproduced as below:
cd /sys/fs/cgroup/
mkdir test
echo +cpuset > cgroup.subtree_control
cd test
echo 3 > cpuset.cpus.exclusive
cat cpuset.cpus.exclusive.effective
3
echo > cpuset.cpus
cat cpuset.cpus.exclusive.effective // was cleared

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a9b6d56eeffa..248c39bebbe9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2523,10 +2523,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 * that parsing.  The validate_change() call ensures that cpusets
 	 * with tasks have cpus.
 	 */
-	if (!*buf) {
+	if (!*buf)
 		cpumask_clear(trialcs->cpus_allowed);
-		cpumask_clear(trialcs->effective_xcpus);
-	} else {
+	else {
 		retval = cpulist_parse(buf, trialcs->cpus_allowed);
 		if (retval < 0)
 			return retval;
-- 
2.34.1


