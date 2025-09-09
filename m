Return-Path: <cgroups+bounces-9814-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD98B4A44F
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 09:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF74A189A229
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15D4236435;
	Tue,  9 Sep 2025 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NbaTnNJ/"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354CF23F424;
	Tue,  9 Sep 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404547; cv=none; b=URObs3LV7lL0HA4kU+RqtU8q+ztMfSD/wpm3eaYDgnWQQASqbGHv9vp8n4/DFtvArCZryoPnfZazAD1uIDHA6e0P21Vgq9Sx3gpFfOKNwrg08VzvY1jsdhKa4dpEdJTdnONeDG6u9a0u2cFSLlUzHfh5Ubi+BFcw+2C0wfmGnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404547; c=relaxed/simple;
	bh=5ukJ70+msLFnHkJnhJrjSsIaO24ya9JEx5Q9+SlptnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnJLQJu2fQWOLKBAeqMeFeptPYj+buMjMg5if7zG2yElzWHoiGeRRwbYS0jQ7G/j8ReL+QilU9bHZTHX8wN3dSbXpZkuu+dPxnvRoBAgmjJKxyOZfU9Nw9NKtQCAV9xjNstmTwNyJt4YsesFm3aKKGaa9ONI0iwjAJkK2yLDu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NbaTnNJ/; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757404536; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4509FaEFYAcgeZjV/u4axpDC6hpPPjtTioO+fvPx73s=;
	b=NbaTnNJ/GWFSbI+WwoGMQ89SUoDcMuxB5B3N/5tg9brrLZlsvNEu5f9ZSS3/15aW2p3QLuj+ApctOlaUsL1GgmwBFXR6iDLBPH92dVW4vTWEFQiuOgT+0HQt+ks1m2q177KCC/xGPLcsFYC3mjuwy1c4YWgd/+BoZjgxqCcEO/o=
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WndDsJ4_1757404535 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 15:55:36 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] cgroup: retry find task if threadgroup leader changed
Date: Tue,  9 Sep 2025 15:55:29 +0800
Message-Id: <42b7b9b12a65e7b1a8e58ce055240ad63f93bf6b.1757403652.git.escape@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <cover.1757403652.git.escape@linux.alibaba.com>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com> <cover.1757403652.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Between obtaining the threadgroup leader via PID and acquiring the
cgroup attach lock, the threadgroup leader may change, which could lead
to incorrect cgroup migration. Therefore, after acquiring the cgroup
attach lock, we check whether the threadgroup leader has changed, and if
so, retry the operation.

Signed-off-by: Yi Tao <escape@linux.alibaba.com>
---
 kernel/cgroup/cgroup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b53ae8fd9681..6e90b79e8fa3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3010,6 +3010,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
 		return ERR_PTR(-EINVAL);
 
+retry_find_task:
 	rcu_read_lock();
 	if (pid) {
 		tsk = find_task_by_vpid(pid);
@@ -3051,6 +3052,21 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 
 	cgroup_attach_lock(*threadgroup_locked, tsk);
 
+	if (threadgroup) {
+		if (!thread_group_leader(tsk)) {
+			/*
+			 * a race with de_thread from another thread's exec()
+			 * may strip us of our leadership, if this happens,
+			 * there is no choice but to throw this task away and
+			 * try again; this is
+			 * "double-double-toil-and-trouble-check locking".
+			 */
+			cgroup_attach_unlock(*threadgroup_locked, tsk);
+			put_task_struct(tsk);
+			goto retry_find_task;
+		}
+	}
+
 	return tsk;
 
 out_unlock_rcu:
-- 
2.32.0.3.g01195cf9f


