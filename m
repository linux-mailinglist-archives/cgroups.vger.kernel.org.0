Return-Path: <cgroups+bounces-15186-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GPTOdU91WlY3AcAu9opvQ
	(envelope-from <cgroups+bounces-15186-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 19:24:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BFE3B254F
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 19:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 503903047BF6
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8F734404B;
	Tue,  7 Apr 2026 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bEZsVMgp"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF2DF59;
	Tue,  7 Apr 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582650; cv=none; b=nI/sM5f/Y8DL21w3yFVdJJoGRNdHO2WOONdJQmOXnw4A5k8738i+Cw+5p+iEHKPghF1FSh1yWJBxh4k13pgHcM6g+A6TLtZfswQ0lryFWf6XrrLJ51k01j9y38XPxr3H8YUje+nQd3FVBUB7cY/Sdlx068Qdvcotf8ubLZd8u6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582650; c=relaxed/simple;
	bh=0ChEibfugt9ooEFfObMhNJcu9ssdO+KEYfEesFeQmHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms5jLmlmuZmMA5mZTW6Mo5mwEen2zwnPzcGZ6JL8JxzCHg1ZW3tpLX97EUT5MvPPEeRV4NdeheT154n9ns4nDz0rm6Z41gpbtV72jPpO8N6YUPZtTw6VFNDWR9kZXYocWrf2qLIjzlZh32i10UTmOoVHlu1YG76h7llv/L0vo5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bEZsVMgp; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EKKsr880289;
	Tue, 7 Apr 2026 17:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=FXJOL
	X+tnf3ei6O8tNyIhzWFZZ5BsiV7/2F2CMS7IkY=; b=bEZsVMgprTp54GyLDyzLu
	gxIJ7RigEnnWIGmeOUN1+yPdrEzS2MS56W1TWt0MAmA6uCvGwLP/pU4LuRtDKV/J
	6UY7cJGw9bLmSmOvQWXj2SpMrgHFf9meH7OKWuy3x1LO2ywB2lWWSOdzpAKkA10K
	5MVREepvDPAe2FLgMXYnexNtl9ze973xC8k17TWPA6haP6up8XhvmP1BFIK0cBaB
	znBd2eTD5vWModKwTwYcscxH+EC4vtsmt/VKKGAAx/cymjfTucOMn/MkafeTDohT
	t6bakvy2rghEMoJuac/kJYRUnvW6TJMDeXVoIkqHN4H5hh7qpDqtHDQTAjyuIXHA
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqb1w2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Apr 2026 17:24:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 637FXQNO003587;
	Tue, 7 Apr 2026 17:24:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcn5vmt46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 07 Apr 2026 17:24:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 637HNxFh037379;
	Tue, 7 Apr 2026 17:23:59 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcn5vmsw4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 07 Apr 2026 17:23:59 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        cgroups@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, tj@kernel.org,
        hannes@cmpxchg.org, mkoutny@suse.com, tom.hromatka@oracle.com,
        kamalesh.babulal@oracle.com, prakash.sangappa@oracle.com
Subject: [RFC PATCH 1/1] netlink: Add Netlink process event for cgroup migration
Date: Tue,  7 Apr 2026 17:23:39 +0000
Message-ID: <20260407172339.2017158-2-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260407172339.2017158-1-prakash.sangappa@oracle.com>
References: <20260407172339.2017158-1-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604070157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE1NiBTYWx0ZWRfX1BHUYySU/o+v
 7vRrRKIQDEfHAH7HcTuj1ErN9oxDrueeGXBjW99JNPsDasqsujOQa+wX4n2BD2t+V3a3ySIpM3w
 VncNi3NFFLgsx6RhEBVnuWpe2zOUH8hPCrjKxckCPBGVA9G/QiOC1LdhjsVOmbUTNt8BiQdzx1R
 VFitpktrfus5w0JE2iy9kqnMYOyG93Laz5zivOVVH5mqwhfXHN23tF/if4XczXYGJiVqIuYnFS2
 bJlzIRRt/ANZ7Yid6Brd0j+CokdpTcCakWzvhMOHYoE+/BSEuKZlrYhovdcBNUBjXQJrK6HtJnX
 6KzWJiyBbp4BHfk/Ve52Q4rpNW3CpWiazZ4eMvRFyQa0Ue2pbPrA6PS6WtQXzIByBDigGU1EKae
 TSPGIYTcz9ARGvwllxGChciHfdsfF45eeQujadM5zLC0qs5v7nwHRGMfhqBZ4G3QGcLDtOTdrhH
 EG7n6MpfIExw3ZuW7eNfmR7Xc2moKaQWCDU5SQm0=
X-Proofpoint-ORIG-GUID: yx8wY0-8zcK9Sq_NY_ZaF_Wn7qNWvydZ
X-Proofpoint-GUID: yx8wY0-8zcK9Sq_NY_ZaF_Wn7qNWvydZ
X-Authority-Analysis: v=2.4 cv=cK7QdFeN c=1 sm=1 tr=0 ts=69d53db0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=nJjVhZaqNiP0mnMSE_UA:9 cc=ntf
 awl=host:12291
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15186-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prakash.sangappa@oracle.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[oracle.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A0BFE3B254F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce a netlink process event that gets generated
when a task migrates between cgroup. The process event
includes the task's pid,tgid and the initiator process
pid,tgid along with the destination cgroup id.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 drivers/connector/cn_proc.c  | 28 ++++++++++++++++++++++++++++
 include/linux/cn_proc.h      |  3 +++
 include/uapi/linux/cn_proc.h | 14 ++++++++++++--
 kernel/cgroup/cgroup-v1.c    |  7 ++++++-
 kernel/cgroup/cgroup.c       |  5 ++++-
 5 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 0056ab81fbc3..4a17572ae171 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -19,6 +19,7 @@
 
 #include <linux/cn_proc.h>
 #include <linux/local_lock.h>
+#include <linux/cgroup.h>
 
 /*
  * Size of a cn_msg followed by a proc_event structure.  Since the
@@ -355,6 +356,33 @@ void proc_exit_connector(struct task_struct *task)
 	send_msg(msg);
 }
 
+void proc_cgroup_migrate_connector(struct task_struct *task, struct cgroup *cgrp)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
+
+	if (atomic_read(&proc_event_num_listeners) < 1)
+		return;
+
+	msg = buffer_to_cn_msg(buffer);
+	ev = (struct proc_event *)msg->data;
+	memset(&ev->event_data, 0, sizeof(ev->event_data));
+	ev->timestamp_ns = ktime_get_ns();
+	ev->what = PROC_EVENT_CGRP_MIGRATE;
+	ev->event_data.cgrp.process_pid = task->pid;
+	ev->event_data.cgrp.process_tgid = task->tgid;
+	ev->event_data.cgrp.initiator_pid = current->pid;
+	ev->event_data.cgrp.initiator_tgid = current->tgid;
+	ev->event_data.cgrp.cgroup_id = cgroup_id(cgrp);
+
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
+	msg->len = sizeof(*ev);
+	msg->flags = 0; /* not used */
+	send_msg(msg);
+}
+
 /*
  * Send an acknowledgement message to userspace
  *
diff --git a/include/linux/cn_proc.h b/include/linux/cn_proc.h
index 1d5b02a96c46..9b16a0456af6 100644
--- a/include/linux/cn_proc.h
+++ b/include/linux/cn_proc.h
@@ -28,6 +28,7 @@ void proc_ptrace_connector(struct task_struct *task, int which_id);
 void proc_comm_connector(struct task_struct *task);
 void proc_coredump_connector(struct task_struct *task);
 void proc_exit_connector(struct task_struct *task);
+void proc_cgroup_migrate_connector(struct task_struct *task, struct cgroup *cgrp);
 #else
 static inline void proc_fork_connector(struct task_struct *task)
 {}
@@ -54,5 +55,7 @@ static inline void proc_coredump_connector(struct task_struct *task)
 
 static inline void proc_exit_connector(struct task_struct *task)
 {}
+static inline void proc_cgrp_migrate_connector(struct task_struct *task)
+{}
 #endif	/* CONFIG_PROC_EVENTS */
 #endif	/* CN_PROC_H */
diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index 18e3745b86cd..c202d7fdab28 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -33,7 +33,8 @@ enum proc_cn_mcast_op {
 #define PROC_EVENT_ALL (PROC_EVENT_FORK | PROC_EVENT_EXEC | PROC_EVENT_UID |  \
 			PROC_EVENT_GID | PROC_EVENT_SID | PROC_EVENT_PTRACE | \
 			PROC_EVENT_COMM | PROC_EVENT_NONZERO_EXIT |           \
-			PROC_EVENT_COREDUMP | PROC_EVENT_EXIT)
+			PROC_EVENT_COREDUMP | PROC_EVENT_EXIT | \
+			PROC_EVENT_CGRP_MIGRATE)
 
 /*
  * If you add an entry in proc_cn_event, make sure you add it in
@@ -51,7 +52,8 @@ enum proc_cn_event {
 	PROC_EVENT_SID  = 0x00000080,
 	PROC_EVENT_PTRACE = 0x00000100,
 	PROC_EVENT_COMM = 0x00000200,
-	/* "next" should be 0x00000400 */
+	PROC_EVENT_CGRP_MIGRATE = 0x00000400,
+	/* "next" should be 0x00000800 */
 	/* "last" is the last process event: exit,
 	 * while "next to last" is coredumping event
 	 * before that is report only if process dies
@@ -153,6 +155,14 @@ struct proc_event {
 			__kernel_pid_t parent_tgid;
 		} exit;
 
+		struct cgrp_proc_event {
+			__kernel_pid_t process_pid;
+			__kernel_pid_t process_tgid;
+			__kernel_pid_t initiator_pid;
+			__kernel_pid_t initiator_tgid;
+			__u64          cgroup_id;
+		} cgrp;
+
 	} event_data;
 };
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a4337c9b5287..9b07c9ad9b43 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -16,6 +16,8 @@
 #include <linux/pid_namespace.h>
 #include <linux/cgroupstats.h>
 #include <linux/fs_parser.h>
+#include <linux/cn_proc.h>
+
 
 #include <trace/events/cgroup.h>
 
@@ -147,8 +149,11 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 
 		if (task) {
 			ret = cgroup_migrate(task, false, &mgctx);
-			if (!ret)
+			if (!ret) {
+				proc_cgroup_migrate_connector(task, to);
 				TRACE_CGROUP_PATH(transfer_tasks, to, task, false);
+			}
+
 			put_task_struct(task);
 		}
 	} while (task && !ret);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 01fc2a93f3ef..4cac29d5c1b5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -59,6 +59,7 @@
 #include <linux/nstree.h>
 #include <linux/irq_work.h>
 #include <net/sock.h>
+#include <linux/cn_proc.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/cgroup.h>
@@ -3040,8 +3041,10 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 
 	cgroup_migrate_finish(&mgctx);
 
-	if (!ret)
+	if (!ret) {
+		proc_cgroup_migrate_connector(leader, dst_cgrp);
 		TRACE_CGROUP_PATH(attach_task, dst_cgrp, leader, threadgroup);
+	}
 
 	return ret;
 }
-- 
2.43.7


