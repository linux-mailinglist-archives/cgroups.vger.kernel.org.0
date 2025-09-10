Return-Path: <cgroups+bounces-9863-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B93B50E9F
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 09:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE69560756
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 07:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7111F307482;
	Wed, 10 Sep 2025 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Vm/M8iJ2"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD853081C6;
	Wed, 10 Sep 2025 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487612; cv=none; b=PCiGoo/bOuezsdA0dI7jnxC2BDGq4NNIa6U79oC5T88IYoh2sUp0J5FFRStCjlxM129HXijiW6qSVMOMq9R+inahCLdNLOzJ1P5gkYIPmP/Jq4Uk6xHLiIPIHs6LSVBJYcd2BaVDbx/3UXWcj6MvBz7yOPtFvW/NrIlzf8f3mG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487612; c=relaxed/simple;
	bh=WmLagUY7b398zGCDLzTYzx1B047LtR/Qc0/Ux+WyOEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiShGHnPU2/gw3OlslNt/OCmpulji6YeIEHI+tjX+m7uqW/F7gXVvd4A74Lv83DOVHhh/Z+zT0BG9BDQr/ZHlYi6PV617LfLDUWIJAzV7zNcSo/Wyl+ASse9/dlfrJTq5kjS6TOA1UbLVTUNALRXY/jmml3GeMPbjzmnlDxVP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Vm/M8iJ2; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757487598; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FZg2oKhhQptVy6+gxiHuSObSCdlSV1TQIVwvfkvGA9k=;
	b=Vm/M8iJ2fvP6ls02qzPOOiJ/jFYjpVWmb3vjB6S0LZyReLzI40ErAw/ZOuapG6tlh6GHefSzUAumQHN32+lyRX9jSksan0NhXOEBSh+FROEbPYATllvspzM6LgTMl9DtlL76DJqW+xVw7QoFmRAzNI7QzpVsJ+9Cxnd59DKyX4Q=
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0Wnh6Fp6_1757487597 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 14:59:57 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] cgroup: relocate cgroup_attach_lock within cgroup_procs_write_start
Date: Wed, 10 Sep 2025 14:59:34 +0800
Message-Id: <324e2f62ed7a3666e28768d2c35b8aa957dd1651.1757486368.git.escape@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <cover.1757486368.git.escape@linux.alibaba.com>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com> <cover.1757486368.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Later patches will introduce a new parameter `task` to
cgroup_attach_lock, thus adjusting the position of cgroup_attach_lock
within cgroup_procs_write_start.

Between obtaining the threadgroup leader via PID and acquiring the
cgroup attach lock, the threadgroup leader may change, which could lead
to incorrect cgroup migration. Therefore, after acquiring the cgroup
attach lock, we check whether the threadgroup leader has changed, and if
so, retry the operation.

Signed-off-by: Yi Tao <escape@linux.alibaba.com>
---
 kernel/cgroup/cgroup.c | 61 ++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2b88c7abaa00..756807164091 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2994,29 +2994,13 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
 		return ERR_PTR(-EINVAL);
 
-	/*
-	 * If we migrate a single thread, we don't care about threadgroup
-	 * stability. If the thread is `current`, it won't exit(2) under our
-	 * hands or change PID through exec(2). We exclude
-	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
-	 * callers by cgroup_mutex.
-	 * Therefore, we can skip the global lock.
-	 */
-	lockdep_assert_held(&cgroup_mutex);
-
-	if (pid || threadgroup)
-		*lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
-	else
-		*lock_mode = CGRP_ATTACH_LOCK_NONE;
-
-	cgroup_attach_lock(*lock_mode);
-
+retry_find_task:
 	rcu_read_lock();
 	if (pid) {
 		tsk = find_task_by_vpid(pid);
 		if (!tsk) {
 			tsk = ERR_PTR(-ESRCH);
-			goto out_unlock_threadgroup;
+			goto out_unlock_rcu;
 		}
 	} else {
 		tsk = current;
@@ -3033,15 +3017,46 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	 */
 	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
 		tsk = ERR_PTR(-EINVAL);
-		goto out_unlock_threadgroup;
+		goto out_unlock_rcu;
 	}
 
 	get_task_struct(tsk);
-	goto out_unlock_rcu;
+	rcu_read_unlock();
+
+	/*
+	 * If we migrate a single thread, we don't care about threadgroup
+	 * stability. If the thread is `current`, it won't exit(2) under our
+	 * hands or change PID through exec(2). We exclude
+	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
+	 * callers by cgroup_mutex.
+	 * Therefore, we can skip the global lock.
+	 */
+	lockdep_assert_held(&cgroup_mutex);
+
+	if (pid || threadgroup)
+		*lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
+	else
+		*lock_mode = CGRP_ATTACH_LOCK_NONE;
+
+	cgroup_attach_lock(*lock_mode);
+
+	if (threadgroup) {
+		if (!thread_group_leader(tsk)) {
+			/*
+			 * a race with de_thread from another thread's exec()
+			 * may strip us of our leadership, if this happens,
+			 * there is no choice but to throw this task away and
+			 * try again; this is
+			 * "double-double-toil-and-trouble-check locking".
+			 */
+			cgroup_attach_unlock(*lock_mode);
+			put_task_struct(tsk);
+			goto retry_find_task;
+		}
+	}
+
+	return tsk;
 
-out_unlock_threadgroup:
-	cgroup_attach_unlock(*lock_mode);
-	*lock_mode = CGRP_ATTACH_LOCK_NONE;
 out_unlock_rcu:
 	rcu_read_unlock();
 	return tsk;
-- 
2.32.0.3.g01195cf9f


