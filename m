Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A1840BDAD
	for <lists+cgroups@lfdr.de>; Wed, 15 Sep 2021 04:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhIOCUO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 22:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhIOCUN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 22:20:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D8C061574;
        Tue, 14 Sep 2021 19:18:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y8so1239217pfa.7;
        Tue, 14 Sep 2021 19:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=KS/QwJbXlDtbJY8wk7S0QPKRodL4Gi6TNWnyfZqcUsc=;
        b=BDdRgNFnivHELsufZi5Y67KCRQ+turQ+ETLrOuZr31w/hlYiAT0q7e/AYlOXrHxoE3
         rsrb/r8rHzlc2qZhkWDmUGa+t2EAUUy+hcPMKjpR+k5mf84m69tZ+j89dDvJaQatO2Cy
         Jfs+RmDMtjwh+0iDgy+Xs51uz2DBusZJiUBg3Y2qU+spy1NpSXFgKKE5M6dC5ohyHq7m
         SxLdVt9KllK85H50K8ocVCS307En1WqpeGuVt8JHHvsLa8jb4eOsiYzvuNVxR9sYYavV
         yTAPll9Vr87kqtOou1/cUYNzBAvTW9ZeuMvOhs8nqSS+0QmV+/5HZxSz5gqcPkVSJ3rM
         IROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KS/QwJbXlDtbJY8wk7S0QPKRodL4Gi6TNWnyfZqcUsc=;
        b=snphWB7xjOY9WSgydayvQuG/hK3qMAMOyFd4Fjz3bqlRuMxeBMLJVIUW3HPqW9vJWz
         3D015GjoTs9aij+7sdksnCiOqPBgpqpT2cTBA/RzROslRI3U6TMXdFVoJL3sFvcxzDW4
         pcJwVv6+vFQWT2MfWBoDnYUrqGsXcZV/1djvnH85eQcw2fTG1b0Ntbj2H/fu/2ssv3cZ
         zT2RoGubpRT+xQfjosIQe7vM/ZpbYngHZJOXORH20uXlmXcmSaqn9tM0z/gzwL8NhxrA
         ykjb9SGKYhHcoUoRBRjEwo3DNDulI1Bh62P3ZA1JNzg8c2h+9646ZARcmbf6EvNVBWX8
         Tg/A==
X-Gm-Message-State: AOAM530iwTUXEVhArCb412aMioVzclouWP3IZiou0j30JV6xJ2rT5epT
        dwf0e3gcEpP0l8dhAXMAv/k=
X-Google-Smtp-Source: ABdhPJzUZcwL6uDC3czj/pf+r/1ZBWwMx8x/4XwL4Gu8uprMS7KbhWusOKuPD3SJWNx7xksHVmmJ1w==
X-Received: by 2002:a62:4e0f:0:b0:3ee:668d:b841 with SMTP id c15-20020a624e0f000000b003ee668db841mr7913717pfb.48.1631672335451;
        Tue, 14 Sep 2021 19:18:55 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id h4sm3297645pjc.28.2021.09.14.19.18.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 19:18:55 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 1/3] misc_cgroup: introduce misc.events to count failures
Date:   Wed, 15 Sep 2021 10:18:49 +0800
Message-Id: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Introduce misc.events to make it easier for us to understand
the pressure of resources. Currently only the 'max' event is
implemented, which indicates the times the resource is about
to exceeds the max limit.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---

v3: remove misc.events.local.
v2: remove cgroup v1 files.

 include/linux/misc_cgroup.h |  5 +++++
 kernel/cgroup/misc.c        | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index da2367e..091f2d2 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -36,6 +36,7 @@ enum misc_res_type {
 struct misc_res {
 	unsigned long max;
 	atomic_long_t usage;
+	atomic_long_t events;
 	bool failed;
 };
 
@@ -46,6 +47,10 @@ struct misc_res {
  */
 struct misc_cg {
 	struct cgroup_subsys_state css;
+
+	/* misc.events */
+	struct cgroup_file events_file;
+
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index ec02d96..4b2b492 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -171,6 +171,11 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 	return 0;
 
 err_charge:
+	for (j = i; j; j = parent_misc(j)) {
+		atomic_long_inc(&j->res[type].events);
+		cgroup_file_notify(&j->events_file);
+	}
+
 	for (j = cg; j != i; j = parent_misc(j))
 		misc_cg_cancel_charge(type, j, amount);
 	misc_cg_cancel_charge(type, i, amount);
@@ -335,6 +340,19 @@ static int misc_cg_capacity_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static int misc_events_show(struct seq_file *sf, void *v)
+{
+	struct misc_cg *cg = css_misc(seq_css(sf));
+	unsigned long events, i;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		events = atomic_long_read(&cg->res[i].events);
+		if (READ_ONCE(misc_res_capacity[i]) || events)
+			seq_printf(sf, "%s.max %lu\n", misc_res_name[i], events);
+	}
+	return 0;
+}
+
 /* Misc cgroup interface files */
 static struct cftype misc_cg_files[] = {
 	{
@@ -353,6 +371,12 @@ static int misc_cg_capacity_show(struct seq_file *sf, void *v)
 		.seq_show = misc_cg_capacity_show,
 		.flags = CFTYPE_ONLY_ON_ROOT,
 	},
+	{
+		.name = "events",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.file_offset = offsetof(struct misc_cg, events_file),
+		.seq_show = misc_events_show,
+	},
 	{}
 };
 
-- 
1.8.3.1

