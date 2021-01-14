Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3D72F6139
	for <lists+cgroups@lfdr.de>; Thu, 14 Jan 2021 13:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbhANMpX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Jan 2021 07:45:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:50188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbhANMpW (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 14 Jan 2021 07:45:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610628275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQyI62Ts2y3vpFgTZP2ClEtzkdY49hYrxY8Mhozx6ZM=;
        b=XAL1/7+PnbWKJjPsHK2l1e7zdnCyCA6cNoVLhsOcIv/DDJm4AK7WHj9S2Arzd5PCFYJSn+
        xxO+/a0tZw/Lteq0FAH8cR6bcfPpiajZOAief4od7tLB3lar/3SgZRX/3zADC460uN+jAy
        lA4NzgX15rJriC50h7F2Ix71Z1UCkGs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3EE7FB80C;
        Thu, 14 Jan 2021 12:44:35 +0000 (UTC)
Date:   Thu, 14 Jan 2021 13:44:27 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Remove unnecessary call to strstrip()
Message-ID: <YAA8qyBUAurgCeEz@blackbook>
References: <20210103024846.GA15337@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210103024846.GA15337@haolee.github.io>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Sun, Jan 03, 2021 at 02:50:01AM +0000, Hao Lee <haolee.swjtu@gmail.com> wrote:
> The string buf will be stripped in cgroup_procs_write_start() before it
> is converted to int, so remove this unnecessary call to strstrip().
Good catch, Hao.

Perhaps the code be then simplified a bit

-- >8 --
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Date: Thu, 14 Jan 2021 13:23:39 +0100
Subject: [PATCH] cgroup: cgroup.{procs,threads} factor out common parts
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The functions cgroup_threads_start and cgroup_procs_start are almost
identical. In order to reduce duplication, factor out the common code in
similar fashion we already do for other threadgroup/task functions. No
functional changes are intended.

Suggested-by: Hao Lee <haolee.swjtu@gmail.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 55 +++++++++++-------------------------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 613845769103c..f6279df507f4b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4726,8 +4726,8 @@ static int cgroup_attach_permissions(struct cgroup *src_cgrp,
 	return ret;
 }
 
-static ssize_t cgroup_procs_write(struct kernfs_open_file *of,
-				  char *buf, size_t nbytes, loff_t off)
+static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
+				    bool threadgroup)
 {
 	struct cgroup *src_cgrp, *dst_cgrp;
 	struct task_struct *task;
@@ -4738,7 +4738,7 @@ static ssize_t cgroup_procs_write(struct kernfs_open_file *of,
 	if (!dst_cgrp)
 		return -ENODEV;
 
-	task = cgroup_procs_write_start(buf, true, &locked);
+	task = cgroup_procs_write_start(buf, threadgroup, &locked);
 	ret = PTR_ERR_OR_ZERO(task);
 	if (ret)
 		goto out_unlock;
@@ -4748,19 +4748,26 @@ static ssize_t cgroup_procs_write(struct kernfs_open_file *of,
 	src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
 	spin_unlock_irq(&css_set_lock);
 
+	/* process and thread migrations follow same delegation rule */
 	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
-					of->file->f_path.dentry->d_sb, true);
+					of->file->f_path.dentry->d_sb, threadgroup);
 	if (ret)
 		goto out_finish;
 
-	ret = cgroup_attach_task(dst_cgrp, task, true);
+	ret = cgroup_attach_task(dst_cgrp, task, threadgroup);
 
 out_finish:
 	cgroup_procs_write_finish(task, locked);
 out_unlock:
 	cgroup_kn_unlock(of->kn);
 
-	return ret ?: nbytes;
+	return ret;
+}
+
+static ssize_t cgroup_procs_write(struct kernfs_open_file *of,
+				  char *buf, size_t nbytes, loff_t off)
+{
+	return __cgroup_procs_write(of, buf, true) ?: nbytes;
 }
 
 static void *cgroup_threads_start(struct seq_file *s, loff_t *pos)
@@ -4771,41 +4778,7 @@ static void *cgroup_threads_start(struct seq_file *s, loff_t *pos)
 static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
-	struct cgroup *src_cgrp, *dst_cgrp;
-	struct task_struct *task;
-	ssize_t ret;
-	bool locked;
-
-	buf = strstrip(buf);
-
-	dst_cgrp = cgroup_kn_lock_live(of->kn, false);
-	if (!dst_cgrp)
-		return -ENODEV;
-
-	task = cgroup_procs_write_start(buf, false, &locked);
-	ret = PTR_ERR_OR_ZERO(task);
-	if (ret)
-		goto out_unlock;
-
-	/* find the source cgroup */
-	spin_lock_irq(&css_set_lock);
-	src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
-	spin_unlock_irq(&css_set_lock);
-
-	/* thread migrations follow the cgroup.procs delegation rule */
-	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
-					of->file->f_path.dentry->d_sb, false);
-	if (ret)
-		goto out_finish;
-
-	ret = cgroup_attach_task(dst_cgrp, task, false);
-
-out_finish:
-	cgroup_procs_write_finish(task, locked);
-out_unlock:
-	cgroup_kn_unlock(of->kn);
-
-	return ret ?: nbytes;
+	return __cgroup_procs_write(of, buf, false) ?: nbytes;
 }
 
 /* cgroup core interface files for the default hierarchy */
-- 
2.29.2

