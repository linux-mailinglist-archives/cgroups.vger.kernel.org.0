Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81FE4083A3
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 07:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhIMFCV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 01:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhIMFCV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 01:02:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20E5C061574;
        Sun, 12 Sep 2021 22:01:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so5593805pjq.1;
        Sun, 12 Sep 2021 22:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=p95e/fLIqizunh8aVzrIkU+lkS+VG6a/DFmD/UL31WA=;
        b=kWVAhqy7hBfobbxIHKiMtNj+2uESLvNw+6E5pBQDAE0r64WgxfwoYbp6DIlgJfBw7Q
         oDSkodBHPPv3nqm/n3MvDVgYC1oCeU9jl3fYGQfaJcIMbT2TTi2ZP9OGudk9TAwqrHUh
         NODRUAi7rrTrLCUWVGE/mG2qrrXnW6sGjZinPzomcn822l1YVhydCDWbHyVSKvybw0s8
         a8uieL7ycUtEJGh+ckikLsn7lpuMNV0ccaKm5xpFbufq/F36ACsIoH4qp5fU4coCDC0z
         ffi/wDiwruAKZw31hcvihcBtBHl3rmSg+hN88LEWIBM9oYXlTCv4G6NrdX5hrRchDiax
         ZL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p95e/fLIqizunh8aVzrIkU+lkS+VG6a/DFmD/UL31WA=;
        b=Vizza3gN+U3B8rsreW/B5+TZdm9zTWK5zgAikYXL1autzeRzClgAAmKdwdHiPoBGHR
         lTLkvslcMtX2wXqWgW07fjWbITKV9xX5xiO8uz8zWkJVQQxFfMoO2312DbXDt8PVZQoE
         7RGrq+vWtkI0fBR340+aA8B0I7PHTn1zau1U3ljzm6Bl6uNghpIP35KplCNJqVH9Rlg/
         3xhjJ1LXq3rohRC4v8O+FOSLpqevd5iXYi5dV4/TPJ5Bw+c0PSWs55ePzsi28vKkUXqQ
         9CFlbbg9zY/Go1xCgHgja0vQah1bOVNo3di8DwxW/yi+47qJCRmKxUh0ajrEqYd+RGgq
         LG5Q==
X-Gm-Message-State: AOAM532tLuKzFaQWWjSPiKHk+9nCifBJaYcq0wU7k39A/X9FPVJ+0X9a
        jB4DGjnHo/EhpoAKprpWlo8=
X-Google-Smtp-Source: ABdhPJwbqFYKFpm0cksps9AOYCq0/bPmPKWN2Kahppdy8hgkqxCUv3LHlzaBp4Hm4WMv35JIzlvpow==
X-Received: by 2002:a17:902:f68a:b0:13b:9142:5c5b with SMTP id l10-20020a170902f68a00b0013b91425c5bmr3994588plg.54.1631509265194;
        Sun, 12 Sep 2021 22:01:05 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id n38sm291879pfv.198.2021.09.12.22.01.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Sep 2021 22:01:04 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 1/3] misc_cgroup: introduce misc.events and misc_events.local
Date:   Mon, 13 Sep 2021 13:00:59 +0800
Message-Id: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Introduce misc.events and misc.events.local to make it easier for
us to understand the pressure of resources. The main idea comes
from mem_cgroup. Currently only the 'max' event is implemented,
which indicates the times the resource exceeds the limit.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/misc_cgroup.h | 13 ++++++++++
 kernel/cgroup/misc.c        | 58 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index da2367e..602fc11 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -21,6 +21,11 @@ enum misc_res_type {
 	MISC_CG_RES_TYPES
 };
 
+enum misc_event_type {
+	MISC_CG_EVENT_MAX,
+	MISC_CG_EVENT_TYPES
+};
+
 struct misc_cg;
 
 #ifdef CONFIG_CGROUP_MISC
@@ -36,6 +41,8 @@ enum misc_res_type {
 struct misc_res {
 	unsigned long max;
 	atomic_long_t usage;
+	atomic_long_t events[MISC_CG_EVENT_TYPES];
+	atomic_long_t events_local[MISC_CG_EVENT_TYPES];
 	bool failed;
 };
 
@@ -46,6 +53,12 @@ struct misc_res {
  */
 struct misc_cg {
 	struct cgroup_subsys_state css;
+
+	/* misc.events */
+	struct cgroup_file events_file;
+	/* misc.events.local */
+	struct cgroup_file events_local_file;
+
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index ec02d96..5f06b2a 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -26,6 +26,10 @@
 #endif
 };
 
+static const char *const misc_event_name[] = {
+	"max"
+};
+
 /* Root misc cgroup */
 static struct misc_cg root_cg;
 
@@ -140,7 +144,7 @@ static void misc_cg_cancel_charge(enum misc_res_type type, struct misc_cg *cg,
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 		       unsigned long amount)
 {
-	struct misc_cg *i, *j;
+	struct misc_cg *i, *j, *k;
 	int ret;
 	struct misc_res *res;
 	int new_usage;
@@ -171,6 +175,14 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 	return 0;
 
 err_charge:
+	atomic_long_inc(&i->res[type].events_local[MISC_CG_EVENT_MAX]);
+	cgroup_file_notify(&i->events_local_file);
+
+	for (k = i; k; k = parent_misc(k)) {
+		atomic_long_inc(&k->res[type].events[MISC_CG_EVENT_MAX]);
+		cgroup_file_notify(&k->events_file);
+	}
+
 	for (j = cg; j != i; j = parent_misc(j))
 		misc_cg_cancel_charge(type, j, amount);
 	misc_cg_cancel_charge(type, i, amount);
@@ -335,6 +347,38 @@ static int misc_cg_capacity_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static int misc_events_show(struct seq_file *sf, void *v)
+{
+	struct misc_cg *cg = css_misc(seq_css(sf));
+	unsigned long events, i, j;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		for (j = 0; j < MISC_CG_EVENT_TYPES; j++) {
+			events = atomic_long_read(&cg->res[i].events[j]);
+			if (READ_ONCE(misc_res_capacity[i]) || events)
+				seq_printf(sf, "%s.%s %lu\n", misc_res_name[i],
+					   misc_event_name[j], events);
+		}
+	}
+	return 0;
+}
+
+static int misc_events_local_show(struct seq_file *sf, void *v)
+{
+	struct misc_cg *cg = css_misc(seq_css(sf));
+	unsigned long events, i, j;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		for (j = 0; j < MISC_CG_EVENT_TYPES; j++) {
+			events = atomic_long_read(&cg->res[i].events_local[j]);
+			if (READ_ONCE(misc_res_capacity[i]) || events)
+				seq_printf(sf, "%s.%s %lu\n", misc_res_name[i],
+					   misc_event_name[j], events);
+		}
+	}
+	return 0;
+}
+
 /* Misc cgroup interface files */
 static struct cftype misc_cg_files[] = {
 	{
@@ -353,6 +397,18 @@ static int misc_cg_capacity_show(struct seq_file *sf, void *v)
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
1.8.3.1

