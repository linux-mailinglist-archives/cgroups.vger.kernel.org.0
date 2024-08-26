Return-Path: <cgroups+bounces-4479-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D8A95FD94
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 00:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2901F22F84
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 22:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E1019DF59;
	Mon, 26 Aug 2024 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpPL83Fk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202719DF40;
	Mon, 26 Aug 2024 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713110; cv=none; b=QCApQyhNJ4mf9PPWPS+y5a4fBvp373d6HcJObgRQYSkqtXTGS2HTI3RX+LSb2LWBCtll+cXaOolr1nLgxYGBjuMmgj2xL7AIfqWdxNAbXCpm7JzJLUboESqsnM4Rue8lF/bclXEIrJm2Q58Ccffto67ibwbww5AmPvcsVoxaEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713110; c=relaxed/simple;
	bh=I3k6YAZ91BYDLI2UUuYS4a8e1ArFLm609UjFnw52Kpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8/Fr1DpfNshaNFfG9/GaVaWmqKU/1p1pxKawD7Bq2/u80h+3T023uFMTmB+U1BI71gp+LVOX0urOiEYCaX0vfG6ATWwKFDobXos7v/TkvsZmgW8PoluQwIyDxAnKXDq8BqrunxlqXwBQD/DFshJCCY6/eH/e0QzMZL56oGAtYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpPL83Fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8808AC8B7B2;
	Mon, 26 Aug 2024 22:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724713109;
	bh=I3k6YAZ91BYDLI2UUuYS4a8e1ArFLm609UjFnw52Kpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpPL83FkwPZOOFnfuZ9tKapalaUlfZ5ySS6esreAwHpAkcK3I+s2C45SC22srxONl
	 5kpAZyQE4vS0UR3yLWsudTATY0LZ7ralH3yuHI4a4Zk6KXv7Wq0HinmHGdsXtaFJ94
	 JkFm++qxmhmioe1WVRoZ3kHKe05ymwrvplRD7hvQrcadDRe7aLMZaopuNn0TxLAK40
	 5v8n3XzqYgSpGi59QIbMfyVzWqY+Uiz2xkrDG3Idb+PsT8h9uVh2RtoxxLRQgA7gJF
	 LiWuJ59ZQSB+oXuO2KUMAxMXF7vomOU67WJEwlQcaqLsgoUyxuhJ5dbXXiYn0+hdbB
	 GWDub6VZVwimA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: cgroups@vger.kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] sched: Make cpu_shares_read_u64() use tg_weight()
Date: Mon, 26 Aug 2024 12:57:40 -1000
Message-ID: <20240826225822.791578-3-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826225822.791578-1-tj@kernel.org>
References: <20240826225822.791578-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move tg_weight() upward and make cpu_shares_read_u64() use it too. This
makes the weight retrieval shared between cgroup v1 and v2 paths and will be
used to implement cgroup support for sched_ext.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a59ac9b11e3b..4de62872a346 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9209,6 +9209,11 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+static unsigned long tg_weight(struct task_group *tg)
+{
+	return scale_load_down(tg->shares);
+}
+
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
 {
@@ -9220,9 +9225,7 @@ static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
 {
-	struct task_group *tg = css_tg(css);
-
-	return (u64) scale_load_down(tg->shares);
+	return tg_weight(css_tg(css));
 }
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -9724,11 +9727,6 @@ static int cpu_local_stat_show(struct seq_file *sf,
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
-static unsigned long tg_weight(struct task_group *tg)
-{
-	return scale_load_down(tg->shares);
-}
-
 static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
 {
-- 
2.46.0


