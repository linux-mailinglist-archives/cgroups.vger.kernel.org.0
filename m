Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00DD40F831
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 14:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhIQMpq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbhIQMpo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 08:45:44 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A78C061574;
        Fri, 17 Sep 2021 05:44:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so9957766pjr.1;
        Fri, 17 Sep 2021 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSzpO0eGAMHb0t+Lo/U/QAbo5rkAO22JEZ3SR4zIPhU=;
        b=F2twX6VgReOw1YqbdLwsv0Q5AKWCE1HmHVnz9MObbwagIuG7WHu0SkblkxjJcKmG4M
         fAPL52/v52E/3lS9Iyku3hmzBrW57ZsbWXd4k5prUjR1wJ00L0zAydCtnTZHmuOUa+RB
         FguENUUAqHmi1uoKxF6PulKMAp/HyO54/SbzzF6W7KY9rTMjNTV2AuqKnoHZ+ITF/a1+
         cWtf3rsA8/GWOTvdSZndYXXsNUULeO20IZIBF/n/WuSND7sZ95b/J0APgrxG0yNEQL1a
         hGo4NRYBBqpUCjbDIufI3vnHNPGEeGFo/l3bdaxVE3whW3Z9fgJVUo72Jq9q3D8AZTlZ
         k59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSzpO0eGAMHb0t+Lo/U/QAbo5rkAO22JEZ3SR4zIPhU=;
        b=x/V/KyL2HO4pzsfH8EXuqeN5P3JHpOyTystr7iunaZdlA2ckac1+iZ9qBTj1AIZ7uh
         OacTV4gd2tRcMel1gTRM6b5yoO/bpseJ/6mW5l1BXRQ4N1I08YebiSH1VYyRXW9rnMLk
         kFrq0hKBE/x9yFhUKBivyhH5WF7Mc2TAEmCC1gCMp8oaB1NMe/9Awo11SKDeUskmoh0l
         3h4I+9w/B49mSNLpkJfOE3NhiDRQScVTma8ZS4K22el5ebljYeLZBTemhLy+UhmNLZU8
         EyElp3rHgLfHNEDv2yDz7R0G4YgIi9unpGQ0l0r4AN+OAUbO5M+Jpt+jU+4raD6aHDLk
         7jbQ==
X-Gm-Message-State: AOAM530sCWoOdJWBxCSlfVsQ+VMs1z8Rz3dbBqHsKcNTQqjaTO3RvfdX
        9rlIWAn/rVcWnp+/5Q+25TU=
X-Google-Smtp-Source: ABdhPJzQ3Ug6J7niWxEloNTUHKEEErgNiMyODgetlkwucZ7KgLg5GfHYZpUnLgI8uPG71oVLuxCOYg==
X-Received: by 2002:a17:90a:1009:: with SMTP id b9mr12147441pja.184.1631882660813;
        Fri, 17 Sep 2021 05:44:20 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id n185sm6570299pfn.171.2021.09.17.05.44.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 05:44:20 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 1/3] misc_cgroup: introduce misc.events to count failures
Date:   Fri, 17 Sep 2021 20:44:14 +0800
Message-Id: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631881726.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Introduce misc.events to make it easier for us to understand
the pressure of resources. Currently only the 'max' event is
implemented, which indicates the times the resource is about
to exceeds the max limit.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
---
v3: remove misc.events.local
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

