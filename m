Return-Path: <cgroups+bounces-7784-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA49A99EEE
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 04:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AF25A52D2
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 02:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325151A5BB2;
	Thu, 24 Apr 2025 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AT40zU61"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626CB19CD16;
	Thu, 24 Apr 2025 02:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745462785; cv=none; b=kdn0PGwNzKvmOD1ilnQMr1aIQ5eldzZO+B148xN+sk68wyr6soW4ZX/CyEZ3vwFca7k2UWgypYJvbvhVqg8Ey0PnBV9ynjfLLrku0RahxzD7WW8wrQmtzEFQK44gBU3C59A6h+lnM9Y0PPyTjkd4l0dTV8NYl59jwrD20RAK+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745462785; c=relaxed/simple;
	bh=Cogpddh8rHZuYXSXacYjBxtq1MmshXR/AYf1FJv6fbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9rEQ/84oEc5MI0j/wSVrIPQhFURCW23fxzqY7ne/QuicCej53QLVAK9VvqtkHLNPy1QaZpnSLSAYJ+kb9Nmnxrp9feY7UUkWHFZXAGQkXQKjMWPlW3obvI7BrLBXYgJ+yxsuyLMj0FPpM6L9V+6+z99vicYvxdZDQZKcfZaRJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AT40zU61; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLNA0C018126;
	Thu, 24 Apr 2025 02:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Jfi9W
	scH0qLUANjDVKHfTqmq+k7m7mKeWTnbq5WqGO8=; b=AT40zU610csFqG+AzOG2D
	p8gCLX9z6uShmEYlLRJJ7P/h+pg1oACEXNoValFx0lVdhL897NCl2HB7a7Rdg4Ks
	rxNmxJFIvzS5WeUF0Pjm2i1/OQdoClzsCmnhs7tlaPIny0Nd1ZWG91no6Y33OXYR
	01QRxTFa8VtmpUq7EfrbC2DofXK/9lMJ1EDdB1zu5y6RVjq2n3NhM4LCBNEf/jsA
	hQNiWuCobwMYJsn66FCL8I7KN4dkw4HIncQ6fTzhO2RZzHMDB8JfpJ/oSqrGe+nZ
	vyTd+zkkx9JgqxLZdlsjp67z601AQoINOqKeKOBWkjWsaUbVgV3W/xLDKlFaVumP
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jkjjx76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 02:45:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0PRJO028392;
	Thu, 24 Apr 2025 02:45:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx6xs1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 02:45:32 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53O2jQBJ033048;
	Thu, 24 Apr 2025 02:45:31 GMT
Received: from clb-2-bm-ad2.osdevelopmeniad.oraclevcn.com (clb-2-bm-ad2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 466jx6xrxs-3;
	Thu, 24 Apr 2025 02:45:31 +0000
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
Subject: [PATCH v5 2/2] sched/numa: Add tracepoint that tracks the skipping of numa balancing due to cpuset memory pinning
Date: Wed, 23 Apr 2025 19:45:23 -0700
Message-ID: <20250424024523.2298272-3-libo.chen@oracle.com>
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
X-Proofpoint-GUID: YrgbO1E1Q_jUOnOXG6PcmF1dYKwo32ZK
X-Proofpoint-ORIG-GUID: YrgbO1E1Q_jUOnOXG6PcmF1dYKwo32ZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAxNSBTYWx0ZWRfX8dIR9yw8bpy9 c0LC0QHXzTrdODkEDOAKnqPISHngM5Fsg4AHxbfBQl6TF60xJqJInowMf4R6VyB2f07NYwmXNj4 ncH34QhqenxIDY/YF8ACC5CdE2bRAm2WOu2EU857V7uy7ENICejPwsjMsWlsyH9W0HEX2+sltkH
 wapMiAoWX+bhNvRDSVIbamcyoWAdPbLIDlqEONuo1zpR/fXYUVeFKk2vZ1HObbvy0/EdlFF6Mck dlGLxmGUR/iwloRqZOz6hvMyeVdHj8Hf8zrDP9sSR88NTwzXlx9EErA+kfr+3YVo45p0ZxkCSGB sX1CdCrOMgMUNArI2Q58htmmQyb458EyOWqhI8kIBC0hEcz/p035ToUSXBoS0A7vSKqz6p49+1w 0XbuUUqs

Unlike sched_skip_vma_numa tracepoint which tracks skipped VMAs, this
tracks the task subjected to cpuset.mems pinning and prints out its
allowed memory node mask.

Signed-off-by: Libo Chen <libo.chen@oracle.com>
---
 include/trace/events/sched.h | 33 +++++++++++++++++++++++++++++++++
 kernel/sched/fair.c          |  4 +++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 8994e97d86c1..ff3990318aec 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -745,6 +745,39 @@ TRACE_EVENT(sched_skip_vma_numa,
 		  __entry->vm_end,
 		  __print_symbolic(__entry->reason, NUMAB_SKIP_REASON))
 );
+
+TRACE_EVENT(sched_skip_cpuset_numa,
+
+	TP_PROTO(struct task_struct *tsk, nodemask_t *mem_allowed_ptr),
+
+	TP_ARGS(tsk, mem_allowed_ptr),
+
+	TP_STRUCT__entry(
+		__array( char,		comm,		TASK_COMM_LEN		)
+		__field( pid_t,		pid					)
+		__field( pid_t,		tgid					)
+		__field( pid_t,		ngid					)
+		__array( unsigned long, mem_allowed, BITS_TO_LONGS(MAX_NUMNODES))
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__entry->pid		 = task_pid_nr(tsk);
+		__entry->tgid		 = task_tgid_nr(tsk);
+		__entry->ngid		 = task_numa_group_id(tsk);
+		BUILD_BUG_ON(sizeof(nodemask_t) != \
+			     BITS_TO_LONGS(MAX_NUMNODES) * sizeof(long));
+		memcpy(__entry->mem_allowed, mem_allowed_ptr->bits,
+		       sizeof(__entry->mem_allowed));
+	),
+
+	TP_printk("comm=%s pid=%d tgid=%d ngid=%d mem_nodes_allowed=%*pbl",
+		  __entry->comm,
+		  __entry->pid,
+		  __entry->tgid,
+		  __entry->ngid,
+		  MAX_NUMNODES, __entry->mem_allowed)
+);
 #endif /* CONFIG_NUMA_BALANCING */
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c9903b1b3948..cc892961ce15 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3333,8 +3333,10 @@ static void task_numa_work(struct callback_head *work)
 	 * Memory is pinned to only one NUMA node via cpuset.mems, naturally
 	 * no page can be migrated.
 	 */
-	if (cpusets_enabled() && nodes_weight(cpuset_current_mems_allowed) == 1)
+	if (cpusets_enabled() && nodes_weight(cpuset_current_mems_allowed) == 1) {
+		trace_sched_skip_cpuset_numa(current, &cpuset_current_mems_allowed);
 		return;
+	}
 
 	if (!mm->numa_next_scan) {
 		mm->numa_next_scan = now +
-- 
2.43.5


