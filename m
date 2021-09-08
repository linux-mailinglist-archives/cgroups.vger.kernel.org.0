Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827534033BA
	for <lists+cgroups@lfdr.de>; Wed,  8 Sep 2021 07:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhIHFZw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Sep 2021 01:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhIHFZs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Sep 2021 01:25:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CAAC061575;
        Tue,  7 Sep 2021 22:24:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id bb10so590944plb.2;
        Tue, 07 Sep 2021 22:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4QwjGo86SexE23jmdGh0fNWJgw/M3xzYU7zrtMYZd5A=;
        b=X15788MJeqt3PwNwegkTci1L+iIKbHbqqgf4ZqPCyulBivyW91J43YAzU6kUQZxJot
         2wddoz15H6m653ZYtJtcctX4mMbcR/cW+77QkYEauPkNbpPGAEow0F7gIDoMRvsnPecr
         AJEuWyL1bGpySI+I+x2JPSJUuxNWA/QrJoH0TVzG5KVBgzZMzIguhB0n/2eAsHDZPKrG
         S4/2WUjdwwMLDk7F+iK88UttbGbD8n17dxiGeU6Aj1N02YHgSRu3IZYtrdr/chPj44JC
         YpI00lVRElm3RQi/WCpgeWQPw8A+ve1HVmY3haVQ1NbqjSvsRBeTeQpmbVdmm1mAT5gZ
         1Zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4QwjGo86SexE23jmdGh0fNWJgw/M3xzYU7zrtMYZd5A=;
        b=0wpN/j+KU4Zm6fd/9UrPo2trHvjRiZJce4qCLJPrCJYE3TPAIIkehhVRoz5iJ+3R6f
         GLMEGan4r96c/rgloQSU6tbAYhGs81PX4Oylwra1cdpAlcqtZLVhaDqrAY/5DB0AOs7G
         gTDFKGhjsfIj5kuTbrgvLxuepb1+Z+YwMBzl5PvywZibzR/1qzfJjJpoRA8KIREWGWb4
         0g56zzulmFnuMutq/ybHxo+ne62S9boCem+E265LlDAu0HGWSO9ueKc3fb0fsXDGhwwR
         eoZ5P/e7y9AuAzEFeAFblrjr5MbLX5yc2exu2+IGshikZRGUYTTs77kkgsSqm+JN3yR5
         2WgA==
X-Gm-Message-State: AOAM532NarGMjzqbuXW9EoIYJAvTG8G+cXyRXoq4dzcXOYAmd2vwvKxu
        AvwbXaYhdo+I/kK9N6t67Fw=
X-Google-Smtp-Source: ABdhPJwU+L9QK+ftCuC9yk/ud1iCo5LBQiJzx+9cKY30Cvfi126QIuezNc9U0QomdqT/zH3WSkYzAQ==
X-Received: by 2002:a17:902:e8ce:b0:132:b140:9540 with SMTP id v14-20020a170902e8ce00b00132b1409540mr1489915plg.28.1631078680353;
        Tue, 07 Sep 2021 22:24:40 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id k190sm769674pfd.211.2021.09.07.22.24.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:24:40 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [RFC PATCH 1/3] misc_cgroup: introduce misc.events and misc_events.local
Date:   Wed,  8 Sep 2021 13:24:34 +0800
Message-Id: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Introduce misc.events and misc.events.local to make it easier for
us to understand the pressure of resources. The main idea comes
from mem_cgroup.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/misc_cgroup.h |  9 +++++++
 kernel/cgroup/misc.c        | 50 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index da2367e2ac1e..d29f1743fae9 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -46,6 +46,15 @@ struct misc_res {
  */
 struct misc_cg {
 	struct cgroup_subsys_state css;
+
+	/* misc.events */
+	atomic_long_t events[MISC_CG_RES_TYPES];
+	struct cgroup_file events_file;
+
+	/* misc.events.local */
+	atomic_long_t events_local[MISC_CG_RES_TYPES];
+	struct cgroup_file events_local_file;
+
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index ec02d963cad1..2a3d14be21e5 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -140,7 +140,7 @@ static void misc_cg_cancel_charge(enum misc_res_type type, struct misc_cg *cg,
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 		       unsigned long amount)
 {
-	struct misc_cg *i, *j;
+	struct misc_cg *i, *j, *k;
 	int ret;
 	struct misc_res *res;
 	int new_usage;
@@ -171,6 +171,16 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 	return 0;
 
 err_charge:
+	if (cgroup_subsys_on_dfl(misc_cgrp_subsys)) {
+		atomic_long_inc(&i->events_local[type]);
+		cgroup_file_notify(&i->events_local_file);
+
+		for (k = i; k; k = parent_misc(k)) {
+			atomic_long_inc(&k->events[type]);
+			cgroup_file_notify(&k->events_file);
+		}
+	}
+
 	for (j = cg; j != i; j = parent_misc(j))
 		misc_cg_cancel_charge(type, j, amount);
 	misc_cg_cancel_charge(type, i, amount);
@@ -335,6 +345,32 @@ static int misc_cg_capacity_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static int misc_events_show(struct seq_file *sf, void *v)
+{
+	struct misc_cg *cg = css_misc(seq_css(sf));
+	unsigned long count, i;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		count = atomic_long_read(&cg->events[i]);
+		if (READ_ONCE(misc_res_capacity[i]) || count)
+			seq_printf(sf, "%s %lu\n", misc_res_name[i], count);
+	}
+	return 0;
+}
+
+static int misc_events_local_show(struct seq_file *sf, void *v)
+{
+	struct misc_cg *cg = css_misc(seq_css(sf));
+	unsigned long count, i;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		count = atomic_long_read(&cg->events_local[i]);
+		if (READ_ONCE(misc_res_capacity[i]) || count)
+			seq_printf(sf, "%s %lu\n", misc_res_name[i], count);
+	}
+	return 0;
+}
+
 /* Misc cgroup interface files */
 static struct cftype misc_cg_files[] = {
 	{
@@ -353,6 +389,18 @@ static struct cftype misc_cg_files[] = {
 		.seq_show = misc_cg_capacity_show,
 		.flags = CFTYPE_ONLY_ON_ROOT,
 	},
+	{
+		.name = "events",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.file_offset = offsetof(struct misc_cg, events_file),
+		.seq_show = misc_events_show,
+	},
+	{
+		.name = "events.local",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.file_offset = offsetof(struct misc_cg, events_local_file),
+		.seq_show = misc_events_local_show,
+	},
 	{}
 };
 
-- 
2.30.0

