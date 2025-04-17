Return-Path: <cgroups+bounces-7626-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9BEA92B99
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 21:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330331B63105
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 19:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129D620013A;
	Thu, 17 Apr 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l3VAhCSU"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F98718DB01;
	Thu, 17 Apr 2025 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917371; cv=none; b=VILMi7oKKBVyJ3UvsvGSME2EQZafdoUgOwICN95C3jjRkBF7uoP/NcjdloLrloOY6NpIHMDP8WPglpgbqRjMILT/qp9/nax9zCQL+lu0yYeKyaDkhJGypGXgr+cXj24eBuWEgc/ISCYF3uu35WldeQvBEGE3fa20/u3iIrjauS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917371; c=relaxed/simple;
	bh=2JuP65do8lb7EiTUnzT47VTUH4uHNr1zQVm9hENsFRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nI1DCeVCUTIaukjHKWIADVUGXf0J8IoOdqHodyzOVFRyqhPp7QQrs27bvaeh8bi7ULu/TJrrIJhf62h0pUDmFUlwLOdYkCI/BHewJkaci5GThV6mU5M8lYuXYxG4nHE+iZwKSrayaOGvW3MsvDaHyi4TBIza3o73PR1VOAhBwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l3VAhCSU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMsu5023734;
	Thu, 17 Apr 2025 19:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=SHrmC
	YsPUPShQ8c1vOKVOXXLdHNL3i/pJra//kF4YaQ=; b=l3VAhCSUryBXco9DJ/Tgz
	IYgg3KWcxeQWoTKt8MYa/jHByBAaEDSmhD+xP69KWMr+sSNToPwmvasF0NSPGy4N
	Tf9JhxiICrhPJNoCGyAXi+sRwR/E+sF7nB6sD5UchYP4IpHzEWHUj4lNG+wfJcwS
	W3LV8ocCc8Tq2mt4lxnLlRuKp56Za/JTV6qs1VA6YZ8PkynZaqVC+t9uy2wCpfx6
	aOZBVUVu0ijyEh+zwNX/908aIHVZSpSmCOXQamvZ2d8JMF975rRC2b1UxB48PJK/
	RpUOV7M1/KS3eddbav1kHaDIuOFwtdlTC0DPpIP/0KnB7aYtDoucLhsx6DY90zsG
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4619446yxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 19:15:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HI4fOZ009194;
	Thu, 17 Apr 2025 19:15:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d3npdc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 19:15:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53HJFjRw037615;
	Thu, 17 Apr 2025 19:15:51 GMT
Received: from clb-2-bm-ad2.osdevelopmeniad.oraclevcn.com (clb-2-bm-ad2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 460d3npd8k-3;
	Thu, 17 Apr 2025 19:15:50 +0000
From: Libo Chen <libo.chen@oracle.com>
To: peterz@infradead.org, mgorman@suse.de, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tj@kernel.org,
        akpm@linux-foundation.org, rostedt@goodmis.org, llong@redhat.com
Cc: kprateek.nayak@amd.com, raghavendra.kt@amd.com, yu.c.chen@intel.com,
        tim.c.chen@intel.com, vineethr@linux.ibm.com, chris.hyser@oracle.com,
        daniel.m.jordan@oracle.com, lorenzo.stoakes@oracle.com,
        mkoutny@suse.com, Dhaval.Giani@amd.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] sched/numa: Add tracepoint that tracks the skipping of numa balancing due to cpuset memory pinning
Date: Thu, 17 Apr 2025 12:15:43 -0700
Message-ID: <20250417191543.1781862-3-libo.chen@oracle.com>
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
X-Proofpoint-GUID: 1kbh2zaaNz7PyBTYGp_lexWCAEVdSt_v
X-Proofpoint-ORIG-GUID: 1kbh2zaaNz7PyBTYGp_lexWCAEVdSt_v

Unlike sched_skip_vma_numa tracepoint which tracks skipped VMAs, this
tracks the task subjected to cpuset.mems pinning and prints out its
allowed memory node mask.

Signed-off-by: Libo Chen <libo.chen@oracle.com>
---
 include/trace/events/sched.h | 30 ++++++++++++++++++++++++++++++
 kernel/sched/fair.c          |  4 +++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 8994e97d86c13..25ee542fa0063 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -745,6 +745,36 @@ TRACE_EVENT(sched_skip_vma_numa,
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
+		__array( char,		comm,		TASK_COMM_LEN	)
+		__field( pid_t,		pid				)
+		__field( pid_t,		tgid				)
+		__field( pid_t,		ngid				)
+		__field( nodemask_t *,	mem_allowed_ptr			)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__entry->pid		 = task_pid_nr(tsk);
+		__entry->tgid		 = task_tgid_nr(tsk);
+		__entry->ngid		 = task_numa_group_id(tsk);
+		__entry->mem_allowed_ptr = mem_allowed_ptr;
+	),
+
+	TP_printk("comm=%s pid=%d tgid=%d ngid=%d mem_nodes_allowed=%*pbl",
+		  __entry->comm,
+		  __entry->pid,
+		  __entry->tgid,
+		  __entry->ngid,
+		  nodemask_pr_args(__entry->mem_allowed_ptr))
+);
 #endif /* CONFIG_NUMA_BALANCING */
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c9903b1b39487..cc892961ce157 100644
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


