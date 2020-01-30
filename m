Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDBB14DF6A
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2020 17:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgA3QrV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jan 2020 11:47:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36375 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA3QrV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jan 2020 11:47:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so3006040qto.3;
        Thu, 30 Jan 2020 08:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cRkmfZ70e1FN/dai6WJTy1Ty8v4BIDTiaHK0pQLcbpM=;
        b=msmlzcdjC+TyANKBhZKTl1h2yOagQ43WqHjcbrMtcNUrNzFU/gaLY2HBa5xN/2WODX
         h6+ZcRFdLaex3hEqFCWiVEGhC+QV99QFD9W9wOcspZRPS53Q3+iJe/MhBvWz94UMeViM
         vWjDkkpxkBSr7yDexhoHJoUGfy58IVK8w3Yd3eO3yVJtt8omAFB4Xxa90XCI8gjeDJpA
         0QKylSioDjUDa49oOuBRM6YPDiqfMHq3qM8OuqFeP4ZBOBtEMDDzrmlOAJYbGXc7vh93
         L+GzYcO2xV/5CnDlVJfq6hy5QoyR/BvcSzHOByrmhKlMurzLQ6JTBtemCSDu4yv7HRUn
         f4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=cRkmfZ70e1FN/dai6WJTy1Ty8v4BIDTiaHK0pQLcbpM=;
        b=Lmyhv5oVp4VY1rwefrlU44ZV+Lq+zctRSvZd9ulmDpXsi+zZhYB1iilKOWQBXeI6+k
         UCFrRCPMpxmiytDTAJIHCSooRfYoDhd8SYuUbdDaUK77wa7EbQ5YNYvoREcdb6ZunCrO
         ZUukNAxipg5K/OUMxvoE2ZEW9hqdh8m/4HwTvCuW08TyyAQT7RwYdiG1RP9eENVAXQoI
         cYCYtfwZiDLjpXlzmcFIbgaAQMuag5+kNGF+QbVIDpHBujn4BWBG2Y8cenfWh4HAZgqn
         O5k1UDLMiW075eHsWlLNQdBFa8wZGmZ7g7SaHdRS3tXGTeem4haPc4dnkRLgTi24GCmH
         VmVA==
X-Gm-Message-State: APjAAAXRvmWA+6vMzIWpH/yD0MPmYYnVXnJ57J2f0s9+hNb0Dk/rEAFq
        p+Zh6qZHkbGVNKhwwD5xQlY=
X-Google-Smtp-Source: APXvYqwrPTcNF2ywjVNYtwaeuLl+A5vMAx1dYlbTD+IMjVdAYmJyjIuPy0oCF2C5XcVNzkfDBTRzQQ==
X-Received: by 2002:ac8:7352:: with SMTP id q18mr5631408qtp.125.1580402838461;
        Thu, 30 Jan 2020 08:47:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::139])
        by smtp.gmail.com with ESMTPSA id b22sm2950594qka.121.2020.01.30.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 08:47:17 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:47:17 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH cgroup/for-5.6-fixes] cgroup: init_tasks shouldn't be linked
 to the root cgroup
Message-ID: <20200130164717.GE180576@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From 0cd9d33ace336bc424fc30944aa3defd6786e4fe Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 30 Jan 2020 11:37:33 -0500

5153faac18d2 ("cgroup: remove cgroup_enable_task_cg_lists()
optimization") removed lazy initialization of css_sets so that new
tasks are always lniked to its css_set. In the process, it incorrectly
ended up adding init_tasks to root css_set. They show up as PID 0's in
root's cgroup.procs triggering warnings in systemd and generally
confusing people.

Fix it by skip css_set linking for init_tasks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: https://github.com/joanbm
Link: https://github.com/systemd/systemd/issues/14682
Fixes: 5153faac18d2 ("cgroup: remove cgroup_enable_task_cg_lists() optimization")
Cc: stable@vger.kernel.org # v5.5+
---
 kernel/cgroup/cgroup.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b3744872263e..cf8a36bdf5c8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5932,11 +5932,14 @@ void cgroup_post_fork(struct task_struct *child)
 
 	spin_lock_irq(&css_set_lock);
 
-	WARN_ON_ONCE(!list_empty(&child->cg_list));
-	cset = task_css_set(current); /* current is @child's parent */
-	get_css_set(cset);
-	cset->nr_tasks++;
-	css_set_move_task(child, NULL, cset, false);
+	/* init tasks are special, only link regular threads */
+	if (likely(child->pid)) {
+		WARN_ON_ONCE(!list_empty(&child->cg_list));
+		cset = task_css_set(current); /* current is @child's parent */
+		get_css_set(cset);
+		cset->nr_tasks++;
+		css_set_move_task(child, NULL, cset, false);
+	}
 
 	/*
 	 * If the cgroup has to be frozen, the new task has too.  Let's set
-- 
2.24.1

