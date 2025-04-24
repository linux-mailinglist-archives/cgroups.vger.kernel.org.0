Return-Path: <cgroups+bounces-7772-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1BEA99C70
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 02:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480333B731E
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 00:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784E22701A8;
	Thu, 24 Apr 2025 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NQAR9p/2"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C817D2;
	Thu, 24 Apr 2025 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452938; cv=none; b=hmASyx1t9u5e3s4qqAMbtKSR/aSZEfL57ZnTfDzAZfgOvvfYKKngealQHWaDe+XW770OZXyqzLp2t0oh42/xB28a+ipvgOboKqdgS3PylVpMrtYvQtL4oqCX1HI7B9y1XEgL8lv3I4cIYuAR3NbMhvp0IVqL4ZNt/qIi4BDKDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452938; c=relaxed/simple;
	bh=NYUWSLy6QpMvRrzAdRxpnbaZep79ljUxsyBdwOU4Jwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJueuKfLuZJCs4puxEHYwDWwkJOj7K2UKF6gXfoSqw0wQtp+ipg3700TycKLk++VkeIhLTYAiwXmJKUuQBVC0t19eHeg/TFV94H2kaWtD+GMiGLbqf0AIegYsdYCxUUQb0zCaWUGmezgaULJFhbVY1i27355w6ToJ1Eqx1u32t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NQAR9p/2; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLMLH2017449;
	Thu, 24 Apr 2025 00:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=pokXB
	CX5Ded9Lnz+unOijz8gr7rZOR1qtecYySzC12Y=; b=NQAR9p/2W/KkC+/L86oEl
	gp2W1r13YQ5gUWtRnqdGRHu/EP4RnbmQcs/w4RbsnlgFTMUe7OcFHWJIpW6wd1TY
	zS6WIuNE4JhdpFNN+5GL11vuqnCeWkn94gm7q8ybtRzRfYO17fmKLO6EFfKsmpk/
	y/kMP+QLxjHID9Lkkx/rE/r6N808PTNxf5DMebIh3Aazf5nbGDbT+37tAVzuI7xW
	tEALVMCnOL8NPWicfjB8svv4dxoYIB/7rxlM6hYziDaWzmvngOeeG+e7aa7Itp74
	DF5tc5fUBu+asxuQb0cz1ui6IWYFBAngdFSVrCR0rMYuHouFesnqwsKSTB6iaAUV
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jh9jj2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 00:01:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NMSOma030859;
	Thu, 24 Apr 2025 00:01:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k06jr0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 00:01:53 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53O01oOm004345;
	Thu, 24 Apr 2025 00:01:52 GMT
Received: from clb-2-bm-ad2.osdevelopmeniad.oraclevcn.com (clb-2-bm-ad2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 466k06jqsh-2;
	Thu, 24 Apr 2025 00:01:52 +0000
From: Libo Chen <libo.chen@oracle.com>
To: akpm@linux-foundation.org, rostedt@goodmis.org, peterz@infradead.org,
        mgorman@suse.de, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tj@kernel.org, llong@redhat.com
Cc: sraithal@amd.com, venkat88@linux.ibm.com, kprateek.nayak@amd.com,
        raghavendra.kt@amd.com, yu.c.chen@intel.com, tim.c.chen@intel.com,
        vineethr@linux.ibm.com, chris.hyser@oracle.com,
        daniel.m.jordan@oracle.com, lorenzo.stoakes@oracle.com,
        mkoutny@suse.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] sched/numa: Skip VMA scanning on memory pinned to one NUMA node via cpuset.mems
Date: Wed, 23 Apr 2025 17:01:45 -0700
Message-ID: <20250424000146.1197285-2-libo.chen@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250424000146.1197285-1-libo.chen@oracle.com>
References: <20250424000146.1197285-1-libo.chen@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_12,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230161
X-Proofpoint-GUID: QJa0f7b4SHhahwcbDcCBKNa-1K40sAWG
X-Proofpoint-ORIG-GUID: QJa0f7b4SHhahwcbDcCBKNa-1K40sAWG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE2MSBTYWx0ZWRfXwDMISqLfLQot 5Y4msvxMFdbe+59/FcmyfBMPDCvmg5uq0tg8SQg5FHLqn66fO3y+IHLv61qH2ws58bGLHZJXMnv 71OKxolwbYBQzvmyFOLL+HRlTpJeZ2XCbsn37E/TwiZcgJ1IltDfks8jJKl/GTzrz/r2/40otO5
 igpd3KO+8JdVLSadOQoXBO4MYj0bYx+xungzI2Zxa7myTmqgsePSlvsRmW7/7ZHoaavcZqlVDnM kKL+zEasxUu2YiEK7CmoQeXkSnSNtXdTVbHgiK+tOA+PlJdn/baI4OxnTICJA2ZSZcyU/BrI7bO f3sPjdbuGQnmEjTN4ZRfyUaNb5fd3fLCh5iLXazMj18A6X96sZl4wIw/OT3USn+NHH7r80kLCMA QKeKJUVB

When the memory of the current task is pinned to one NUMA node by cgroup,
there is no point in continuing the rest of VMA scanning and hinting page
faults as they will just be overhead. With this change, there will be no
more unnecessary PTE updates or page faults in this scenario.

We have seen up to a 6x improvement on a typical java workload running on
VMs with memory and CPU pinned to one NUMA node via cpuset in a two-socket
AARCH64 system. With the same pinning, on a 18-cores-per-socket Intel
platform, we have seen 20% improvment in a microbench that creates a
30-vCPU selftest KVM guest with 4GB memory, where each vCPU reads 4KB
pages in a fixed number of loops.

Signed-off-by: Libo Chen <libo.chen@oracle.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e43993a4e580..c9903b1b3948 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3329,6 +3329,13 @@ static void task_numa_work(struct callback_head *work)
 	if (p->flags & PF_EXITING)
 		return;
 
+	/*
+	 * Memory is pinned to only one NUMA node via cpuset.mems, naturally
+	 * no page can be migrated.
+	 */
+	if (cpusets_enabled() && nodes_weight(cpuset_current_mems_allowed) == 1)
+		return;
+
 	if (!mm->numa_next_scan) {
 		mm->numa_next_scan = now +
 			msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
-- 
2.43.5


