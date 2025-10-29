Return-Path: <cgroups+bounces-11314-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8D4C186DD
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 07:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64FB34FF965
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17EC30103A;
	Wed, 29 Oct 2025 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxEWG3wT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3753054C4;
	Wed, 29 Oct 2025 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718762; cv=none; b=R96cxzkLokxD/2i8ozygMjiAUVA4UB6ZdQkvNL9Bo2rW+rl6dsD43DATkW9s8Zk69aRW+SS4A+bCD4Lmkja4i84jwIsxWjgAOpj/RV8jGhvbFNPkFhK0+20+hbtRRCoPFmRC8wBFZMFqZBXTRsjbp2YJ6DerKmnwZMHb2wzX3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718762; c=relaxed/simple;
	bh=XzeVoaPc910Xm2v51aZRYTeEk9V5KoYE2WHLmEwNqPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/gmmVBRgi3rvAcsOuaDW2MRCpB2kQpjOdWBTliS4s2QewpeplEOkTVky3YSQS3+2jnTyEDIGunbJ/ODKnMfVg53liKnbFptzJGLHlFS/fzPQPbVVP/M1CkHoZqTWjrh72xkGKsK0anMeTBJ5AiYY1a8RZyhPaZjx502tmc/zzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxEWG3wT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142B2C4CEFB;
	Wed, 29 Oct 2025 06:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761718762;
	bh=XzeVoaPc910Xm2v51aZRYTeEk9V5KoYE2WHLmEwNqPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxEWG3wTlPw5KjzdDPeaBKsN3m9om2D+jDDm+ez9RyOG4xYbGBADRSI28sEHBjCEN
	 YoyIz+zuxHMTBi7mDymICBp0afu3Z7U0GTeoiF+VTmswjEZU+gIgzwsmn4R2k/LgNB
	 ntP8b2ahx//sOqmeBQZ1qXBMKtvVVWgb6eOH9ex+h0CTNCxknHBJ0Scvj15aD5UprG
	 CcoF+5bQvydWT3o8SBXUeKje5Ldb/GuATZ421egaZv6o/UdVpC3xF5IPvvEdDLt1qx
	 bJXY1HjsVYKse28YMuIMDXB4GHKkdh6u2ArhT1/S+ltDn1l9sPivi3B8ZuIzCuO6VW
	 Glq9PBJHxHGGA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] cgroup: Move dying_tasks cleanup from cgroup_task_release() to cgroup_task_free()
Date: Tue, 28 Oct 2025 20:19:16 -1000
Message-ID: <20251029061918.4179554-3-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251029061918.4179554-1-tj@kernel.org>
References: <20251029061918.4179554-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, cgroup_task_exit() adds thread group leaders with live member
threads to their css_set's dying_tasks list (so cgroup.procs iteration can
still see the leader), and cgroup_task_release() later removes them with
list_del_init(&task->cg_list).

An upcoming patch will defer the dying_tasks list addition, moving it from
cgroup_task_exit() (called from do_exit()) to a new function called from
finish_task_switch(). However, release_task() (which calls
cgroup_task_release()) can run either before or after finish_task_switch(),
creating a race where cgroup_task_release() might try to remove the task from
dying_tasks before or while it's being added.

Move the list_del_init() from cgroup_task_release() to cgroup_task_free() to
fix this race. cgroup_task_free() runs from __put_task_struct(), which is
always after both paths, making the cleanup safe.

Cc: Dan Schatzberg <dschatzberg@meta.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cgroup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 826b7fd2f85d..b3c27900c5d2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -7019,6 +7019,11 @@ void cgroup_task_release(struct task_struct *task)
 	do_each_subsys_mask(ss, ssid, have_release_callback) {
 		ss->release(task);
 	} while_each_subsys_mask();
+}
+
+void cgroup_task_free(struct task_struct *task)
+{
+	struct css_set *cset = task_css_set(task);
 
 	if (!list_empty(&task->cg_list)) {
 		spin_lock_irq(&css_set_lock);
@@ -7026,11 +7031,7 @@ void cgroup_task_release(struct task_struct *task)
 		list_del_init(&task->cg_list);
 		spin_unlock_irq(&css_set_lock);
 	}
-}
 
-void cgroup_task_free(struct task_struct *task)
-{
-	struct css_set *cset = task_css_set(task);
 	put_css_set(cset);
 }
 
-- 
2.51.1


