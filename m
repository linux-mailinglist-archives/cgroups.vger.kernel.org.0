Return-Path: <cgroups+bounces-7785-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ECDA99EF0
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 04:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373CB7AE398
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 02:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3351A8F9A;
	Thu, 24 Apr 2025 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cHOotX4i"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC81A5BA0;
	Thu, 24 Apr 2025 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745462787; cv=none; b=MKMvhoG3nLkumdexIifGIszhcJMelxJ4DAJN/F3ia6AkCbYJNN9mAFrfIhTb2q+0h5HPlXx5BD7KAhwKUv4IqT8nZFqX2umPChyXRNMCPt9FQdiqabfBOJlXxpS9Ud/HEyPnAzK4AsitrfFRhOfksSKPrSPaZ4MMgrpT+JRfz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745462787; c=relaxed/simple;
	bh=NYUWSLy6QpMvRrzAdRxpnbaZep79ljUxsyBdwOU4Jwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3UetK2hCsHsgR22N/61bFI6sSrFHVPZXhwhZOTT7GUdNT4LVyy7ra12iJWDU95RHCJcqju0G6fPe1tivzGKBh45q50CJFE/F+CSNJpkOLbrIzVuZxGbpikob6n2RmZRsBv3kEJBFoE3WCB/DrppBCcF3H9n5dV9o2v+HsPcd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cHOotX4i; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLNBPF014981;
	Thu, 24 Apr 2025 02:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=pokXB
	CX5Ded9Lnz+unOijz8gr7rZOR1qtecYySzC12Y=; b=cHOotX4i+/1nJPgKroPJ3
	xb48u1cYS3R5NeZ+XxzCBNBoMJJEoWF/A4W9nt0/oSDILU2cWPkuW80T0HuNj3GN
	8+fdIK7sBm4rhSzU43wPeI4EUtd+AXxTUa3g8BItYp0yRv9+MHMegW2cpDCnKYEF
	q44/zoKjhoWSlb0UnQ74jt8b8yyUVuIeBGroABXHCBhzlSfS+2L+24zhe8GR0Cbp
	Dia/lVpb8KKBN5VHVCl868B1G3BxBhWKA2KvuorhmGYIVYSWSpvyCmjX8AuyDbae
	iNHACVxIpvxljYrzAHzMIeyUHrdoLK/zZQMB73lmu8xVTb5zyAcG61l1c1EkHdiv
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhdjuxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 02:45:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O1USYA028195;
	Thu, 24 Apr 2025 02:45:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx6xs0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 02:45:29 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53O2jQBH033048;
	Thu, 24 Apr 2025 02:45:29 GMT
Received: from clb-2-bm-ad2.osdevelopmeniad.oraclevcn.com (clb-2-bm-ad2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 466jx6xrxs-2;
	Thu, 24 Apr 2025 02:45:29 +0000
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
Subject: [PATCH v5 1/2] sched/numa: Skip VMA scanning on memory pinned to one NUMA node via cpuset.mems
Date: Wed, 23 Apr 2025 19:45:22 -0700
Message-ID: <20250424024523.2298272-2-libo.chen@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250424024523.2298272-1-libo.chen@oracle.com>
References: <20250424024523.2298272-1-libo.chen@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240015
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAxNSBTYWx0ZWRfX/7I4T7Soeja9 2p3LGOEagnXQCIiGZaHZXOHwRdjoTYWCt2hQGQ7C9/efi+15rPylAPUVP3fMf7X+rtAy/YtlOtr CgPd1zJ4UtcghHMAJwgZRNnW2224VviyjAPro/5x6TLP+LHrY9Oby/RrYqmenkA+i3I+Q8Mk/Xk
 6DukNzxROzM21a9hF5lKTblMRFmI8pSUlcnYxvJooydjEylwp21EL+a2KHyLKLW8b+BqaVg33vT NR0P6HAQCcqI0r88r8fPiGLEnncOv/hCdh0i2r3ojGTZq1nhanc7/905xhvKdLJS8AdN9ITaI9q aOVxIq0O6sQmteHgBYxom0l+rFpYWucgkhED+4DtMTPNtOmxtQ0Ph08doH8cYrHgwbRPQmK69U/ kcxBSfHB
X-Proofpoint-ORIG-GUID: CIIDRKJUiTeV3GCHxneGef8f3ZwrMuXL
X-Proofpoint-GUID: CIIDRKJUiTeV3GCHxneGef8f3ZwrMuXL

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


