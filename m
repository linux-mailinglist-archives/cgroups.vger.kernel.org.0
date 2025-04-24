Return-Path: <cgroups+bounces-7774-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DF9A99C74
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 02:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB8E3BDAC8
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 00:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56108139B;
	Thu, 24 Apr 2025 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k/F9SLzn"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818EE286A9;
	Thu, 24 Apr 2025 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452943; cv=none; b=Mn81cynaG06FfJRzQLi/WY3MxYzW/Bv0AiCfQRHoKAqRMeag4YJ5KIE0k6hsDaJ7zHmaVMmj4E4sKxhBwUkOv4vIIAy5WqVACTHh2spq0RyOh2ugJENQhX0YTTVx1hjwf8wm1Vbd1cBVos/sdpvlPOAgMIgzg0mTzWFIbw+stTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452943; c=relaxed/simple;
	bh=DDZJyhCnuUQJLiomKa3FeAmx5tYOfkRvlXwy93sDAFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMJxTY9txKKOija7+VbMFLwpHXxONJHGjwCnpGfAbw4YGCt/fThNjiQUEAVlfkhCoE8RWrkCJDLr3RcChYWRVqgo+FfXR0qf+LfHIx/tZdNpMv7yies/oNNT01n/x+k4TL+wUk5k5OQBfJ8k/51pF5micCr5w4RtCeP1IrBofbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k/F9SLzn; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLN4ie014961;
	Thu, 24 Apr 2025 00:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Go1o3
	ngvTVVw3IQXesJpexykobr2NIWMz+GMtxtdK+c=; b=k/F9SLznWOw43H6O1jFo7
	JPbV56wanzM2gBsR4Sw6Bi0McNPxSV3l6WGZyOUp7xpgZIhemOizM+pt3cy39Q3K
	11ngVzhCyR+KYF2XtHuNR5L09/DJFZxsWo0ADimOnnY6srhiVX9DSSXmzWHFpi6o
	pF2UNEI/rJQl8j3Bdg9GQ8MsjbT+3izCqvB24cmcyLiUH7ziv0iRqgmiZd7PhgVr
	9G9s7r/XOhldKEwf48C9o9Bjm4y7NA5xhU5AdvRQLhfiru9J3gvrjxO65b8VL4+E
	7xAvzWJcT7lAGG6iM/CYtLrwEhJQe25aIbghyMrfPNQYdkUgGgWdud2kGmM65QeR
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhdjhws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 00:01:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLx2xS030989;
	Thu, 24 Apr 2025 00:01:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k06jr40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 00:01:56 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53O01oOo004345;
	Thu, 24 Apr 2025 00:01:55 GMT
Received: from clb-2-bm-ad2.osdevelopmeniad.oraclevcn.com (clb-2-bm-ad2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 466k06jqsh-3;
	Thu, 24 Apr 2025 00:01:55 +0000
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
Subject: [PATCH v4 2/2] sched/numa: Add tracepoint that tracks the skipping of numa balancing due to cpuset memory pinning
Date: Wed, 23 Apr 2025 17:01:46 -0700
Message-ID: <20250424000146.1197285-3-libo.chen@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE2MSBTYWx0ZWRfX3K39cFddEaSw J5oyY6Kvwthg3Sm5joJzJ9MVxLsPp7WXSPS8c0gUbzNAvwxLKmgAbb5AwaOnv2nV1H7+GXkJ6ZA knU22nKaGz2Dj5tfv6Dit5jNKkVPFe4/WNpWz05B5/R5gjaSrXZE5tRDElt2bhdY5X6K/8/BBxo
 tCpOeKX7x5fWKHVwW5od+FUNyGwUsnv8MVdoeVolX+aPIyH4Bk+yTgRWFeDbEA8rnFLrqt8AyNi xaFDSYaAwy95yipbI1Xdm/F1kSmtPfTv5PW4zJo9rpbpJUEvezR8iCZH5jpN0sZ3wsebHJXq7FG F5FFJgVksVxKWJShryZd3kaduB3MMW2UkZ6CyxwAlWUVpGzlsheklbPoPuzGDO3Udb7z0cNHo5Y nlhIDoql
X-Proofpoint-ORIG-GUID: opZWXMmBppisdzyOststAw_YWX0HnQeg
X-Proofpoint-GUID: opZWXMmBppisdzyOststAw_YWX0HnQeg

Unlike sched_skip_vma_numa tracepoint which tracks skipped VMAs, this
tracks the task subjected to cpuset.mems pinning and prints out its
allowed memory node mask.

Signed-off-by: Libo Chen <libo.chen@oracle.com>
---
 include/trace/events/sched.h | 31 +++++++++++++++++++++++++++++++
 kernel/sched/fair.c          |  4 +++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 8994e97d86c1..91f9dc177dad 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -745,6 +745,37 @@ TRACE_EVENT(sched_skip_vma_numa,
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


