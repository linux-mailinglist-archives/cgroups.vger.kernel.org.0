Return-Path: <cgroups+bounces-7627-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19D2A92B9A
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 21:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2291735F3
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F89202987;
	Thu, 17 Apr 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RX8X/8e9"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719561E25EB;
	Thu, 17 Apr 2025 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917372; cv=none; b=nfRuU9yc+y6bGLRyzzfz+oZu4K89UW3G9hLgCufOKBrYruvc6kRRa+fxibmvHYDbMt1yK/mRkVRK8mTU/nAqtTXlsckSRoj0Yekq9zgIQcotPE9J6CTvILcmtvP4EjbwBnYtxLGUxgQGZhpgkE/5YdbpJf71LEFtTksZY9LyacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917372; c=relaxed/simple;
	bh=6OFO1rGsOJwF4Mq+VfRLSXT6Vuhlav1fGJ9e4jQcoaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGFOIZgMeFPM/LazNZo3kaBStNLqsDxZFlRL3pzBZVTjTOviOtHyLd9kyWDEK8Mq0a0tlEO9uOxdaLTh05pvjf9SFoYzgqvM49rx2Jel4P5KNEG0D15H7pf1TNMPCbphiia0irwB6OlJjpdV8BrjuIZjTb+7TeCCUsEyuMMLaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RX8X/8e9; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGN9je019595;
	Thu, 17 Apr 2025 19:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=oaLLO
	QyAdzNV1ia1vpeLlJJqh9+s76ZEHltuLEq32B8=; b=RX8X/8e9aGXlcw79tThRA
	CU6gh+WS8TL4sN8JWGYADc4TpWvkvBuS1TWM9nDGjpn2ICjxPDDkGMd/PPRKh1qE
	plCt0hGRhwUsRxdDHPLNt0YLjWpGXQerbyDrBjkBHq6l7tvkgZXJ1KyFGvGG6bUf
	AE4TpWhmzTYjDUlg+zto/X6tKN+3c/Wh5S0VD3Ajo9OWtP7ndgu/3P6smBRjngd1
	or21CoSzubP8vpDzWIrouiH0NUGjW2NyrFIbNr+NnjF2O8cIRQizkOym6e/9Edu5
	5iijERrNm/y/I4aBwr16PvQuFrDxC55h4NGQ9WoEheOFtVOgHO+besTNktxXvnOm
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4618rd72ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 19:15:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HIFHOu009252;
	Thu, 17 Apr 2025 19:15:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d3npdax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 19:15:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53HJFjRu037615;
	Thu, 17 Apr 2025 19:15:48 GMT
Received: from clb-2-bm-ad2.osdevelopmeniad.oraclevcn.com (clb-2-bm-ad2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 460d3npd8k-2;
	Thu, 17 Apr 2025 19:15:48 +0000
From: Libo Chen <libo.chen@oracle.com>
To: peterz@infradead.org, mgorman@suse.de, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tj@kernel.org,
        akpm@linux-foundation.org, rostedt@goodmis.org, llong@redhat.com
Cc: kprateek.nayak@amd.com, raghavendra.kt@amd.com, yu.c.chen@intel.com,
        tim.c.chen@intel.com, vineethr@linux.ibm.com, chris.hyser@oracle.com,
        daniel.m.jordan@oracle.com, lorenzo.stoakes@oracle.com,
        mkoutny@suse.com, Dhaval.Giani@amd.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] sched/numa: Skip VMA scanning on memory pinned to one NUMA node via cpuset.mems
Date: Thu, 17 Apr 2025 12:15:42 -0700
Message-ID: <20250417191543.1781862-2-libo.chen@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250417191543.1781862-1-libo.chen@oracle.com>
References: <20250417191543.1781862-1-libo.chen@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170141
X-Proofpoint-ORIG-GUID: ZyaR5JAppByLe5Dq9KXpY-wBxcOEGe1W
X-Proofpoint-GUID: ZyaR5JAppByLe5Dq9KXpY-wBxcOEGe1W

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
---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e43993a4e5807..c9903b1b39487 100644
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


