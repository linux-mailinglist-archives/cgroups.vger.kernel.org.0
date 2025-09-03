Return-Path: <cgroups+bounces-9675-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94463B4255F
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3563585B37
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DFE27A127;
	Wed,  3 Sep 2025 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GLQ9RTqx"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2D27144A;
	Wed,  3 Sep 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913032; cv=none; b=HBoCfJrXOkr12nCJQQnYfNF1jqwGa3tj8db3q8fRY1e70sFFkJsn/XuMflipJ2hX5DRBRml2QRUwSBs8ITUiFVwEot1J0SPOBs7DFEgPskVw1YiqED0aNp/Wbc0it6MHxfkIPexuuiP4v19vdNATKLEiOxK4If+/fATxUusOA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913032; c=relaxed/simple;
	bh=TamCyHl0ZOiVASNWgf/mhgMnD+zHQlYuJOEVxB8C+tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaRAtbB75SZUzNQTpZpQFlzYHXu8xtpjGzysNPqSxu2AWb4exZFz48q1omBZ70n1vyYVxiDuR1qF12Q81hTXc+yDz9h6hnSWv0dRUcnvQLJDHhjXMZaXWi0yI7ndaAaNGfSg/kHKAkBmft9f0zpC2cf4qzO7bPQM3WaHOMry7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GLQ9RTqx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CLwx/0TzVEyIzWF6Q4ej0j1todm89w8SJx6+nTsjHVA=; b=GLQ9RTqx6pt9xEBn5zSNUBaIft
	/iTBtUcKJsBr6FLqrsR0imNkDoLvHZqgJZSrKSlJ4C67VbstzJe75wwnolzddpPIOwIl68LtogE4e
	vrJhVATeLTD49/L/wDztDhswns+h9fJT9dxoqqPZeg/gExMMatpK7xDolF9TPB4NCFFxKD6DkT/76
	9B/Qej6NVfZXdwmsv7MA9foMs5jum341fXlC8JMY0qe9Jb+S4/vo5t9Y/VR4inHqBWi4zbB2GoPH5
	XKn//oY9Bno/58fHBQfyso8ak/4ZFHXL0BEWmrt09cFr/UrHY0DPih7cuSiX6jykOe0nSjI3uN9kT
	gzZgJXug==;
Received: from [84.66.36.92] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utpKr-006Gbk-P4; Wed, 03 Sep 2025 17:23:45 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	intel-xe@lists.freedesktop.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 20/21] drm/xe: Allow changing GuC scheduling priority
Date: Wed,  3 Sep 2025 16:23:26 +0100
Message-ID: <20250903152327.66002-21-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
References: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently queue priority is fixed at the queue creation and communicated
to the GuC together with the other scheduling parameters. The upcoming
integration with the DRM scheduling cgroup controller will however want to
override it (the priority).

Add a new sideband message which allows communicating just the scheduling
priority to the GuC.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h |  1 +
 drivers/gpu/drm/xe/xe_guc_submit.c          | 41 ++++++++++++++++++---
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h b/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
index 6731b13da8bb..ebe7dcef0ccd 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler_types.h
@@ -23,6 +23,7 @@ struct xe_sched_msg {
 	void				*private_data;
 	/** @opcode: opcode of message (backend defined) */
 	unsigned int			opcode;
+	unsigned int			value;
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 1185b23b1384..86daf6f4728f 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -448,6 +448,21 @@ static void init_policies(struct xe_guc *guc, struct xe_exec_queue *q)
 		       __guc_exec_queue_policy_action_size(&policy), 0, 0);
 }
 
+static void init_prio(struct xe_guc *guc, struct xe_exec_queue *q,
+		      enum xe_exec_queue_priority prio)
+{
+	struct exec_queue_policy policy;
+
+	xe_gt_assert(guc_to_gt(guc), exec_queue_registered(q));
+
+	__guc_exec_queue_policy_start_klv(&policy, q->guc->id);
+	__guc_exec_queue_policy_add_priority(&policy,
+					     xe_exec_queue_prio_to_guc[prio]);
+
+	xe_guc_ct_send(&guc->ct, (u32 *)&policy.h2g,
+		       __guc_exec_queue_policy_action_size(&policy), 0, 0);
+}
+
 static void set_min_preemption_timeout(struct xe_guc *guc, struct xe_exec_queue *q)
 {
 	struct exec_queue_policy policy;
@@ -1437,6 +1452,16 @@ static void __guc_exec_queue_process_msg_set_sched_props(struct xe_sched_msg *ms
 	kfree(msg);
 }
 
+static void __guc_exec_queue_process_msg_set_sched_prio(struct xe_sched_msg *msg)
+{
+	struct xe_exec_queue *q = msg->private_data;
+	struct xe_guc *guc = exec_queue_to_guc(q);
+
+	if (guc_exec_queue_allowed_to_change_state(q))
+		init_prio(guc, q, msg->value);
+	kfree(msg);
+}
+
 static void __suspend_fence_signal(struct xe_exec_queue *q)
 {
 	if (!q->guc->suspend_pending)
@@ -1503,8 +1528,9 @@ static void __guc_exec_queue_process_msg_resume(struct xe_sched_msg *msg)
 
 #define CLEANUP		1	/* Non-zero values to catch uninitialized msg */
 #define SET_SCHED_PROPS	2
-#define SUSPEND		3
-#define RESUME		4
+#define SET_SCHED_PRIO	3
+#define SUSPEND		4
+#define RESUME		5
 #define OPCODE_MASK	0xf
 #define MSG_LOCKED	BIT(8)
 
@@ -1521,6 +1547,9 @@ static void guc_exec_queue_process_msg(struct xe_sched_msg *msg)
 	case SET_SCHED_PROPS:
 		__guc_exec_queue_process_msg_set_sched_props(msg);
 		break;
+	case SET_SCHED_PRIO:
+		__guc_exec_queue_process_msg_set_sched_prio(msg);
+		break;
 	case SUSPEND:
 		__guc_exec_queue_process_msg_suspend(msg);
 		break;
@@ -1667,16 +1696,16 @@ static int guc_exec_queue_set_priority(struct xe_exec_queue *q,
 {
 	struct xe_sched_msg *msg;
 
-	if (q->sched_props.priority == priority ||
-	    exec_queue_killed_or_banned_or_wedged(q))
+	if (exec_queue_killed_or_banned_or_wedged(q))
 		return 0;
 
 	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
-	q->sched_props.priority = priority;
-	guc_exec_queue_add_msg(q, msg, SET_SCHED_PROPS);
+	msg->value = priority;
+
+	guc_exec_queue_add_msg(q, msg, SET_SCHED_PRIO);
 
 	return 0;
 }
-- 
2.48.0


