Return-Path: <cgroups+bounces-5690-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989E9DA0D4
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2024 03:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA448B25197
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2024 02:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB60A13CA8A;
	Wed, 27 Nov 2024 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEPWqO4R"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83213A27D
	for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676271; cv=none; b=aZIV+m2GjIGU9E7F8yNt0aOJhZRyXicIwZgpCVnnsgIU/v6lSc1JhrZF981H5kViEykOqFNvpHKac1qhLkGzyJHE6IiNQTLe73/R7A9D6R+G++qkjDx8+184Cw9lSK8WJIwQBUz2gfDwPTVoy+ebzTLjF6gEccoJR8tkHNEVCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676271; c=relaxed/simple;
	bh=WTcNbuwg+h1080/4gOPGJLMDusJrVSUsnxgGAyu/+1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VnnfAwh2hdysrbLN4232XFstSHiT6Bbb72+6ESmz8VO/aMkxnlbiRvdIyTZERwz4Nv3XmNwpDLBk9pZuEODiCpTWW5mJu0AC/OzY0Nxk2eLkf9Qlsu1XFDx/6AC7IClyoHE625W/hTFN7zb/mSDiGadjohSxZG654tM06YMxqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEPWqO4R; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-5f1d3fb6bb0so2102014eaf.1
        for <cgroups@vger.kernel.org>; Tue, 26 Nov 2024 18:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732676268; x=1733281068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJsIXJ522dse8Oa1czRmZ0i3siB+gYc3GobTJqrZlLM=;
        b=ZEPWqO4RFiM4Siq8DtlQ30RZGjaTvJms0NJYyGmhnO5CGL0JK7gaXbeL9SMtFb3XZI
         yd4T/4Hbd7XeuW4+9ue88/rTEbeCm0JHyHIU8/Q2+XrhhDgguDXrYvnu8WIvTssaEtSj
         wHNCBdSHj3w4mZipDZUzpjwThs1sodFtY2clPewXCShAlGznqL0PfPUR5nwkztw7f6rH
         PT/Lb36D4PNO2PBuFjDLbEUCusdET7GB2nY2lVk0jdN5xUdsCcxs+o6heGrQhkYnuoHV
         bCct8s2oQ/ndzcewBDatA8cJpGRyzWoyE9yAOOrmyBVniEliU1VwF9FJcSqg5Ed5vdYL
         hrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676268; x=1733281068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJsIXJ522dse8Oa1czRmZ0i3siB+gYc3GobTJqrZlLM=;
        b=Kl6YT8QOU5grcgpKumJOjrwM2uXDNRwAxhsB88+Vu4G1HVzR5c1Su3yfiyZK9RbJQ1
         QklpCeyu7oZ5sg31wonXC7NM6LzYVE+tFWSOjBcl33HT2xF9BQGHXXd11sng1tE252NZ
         XEjW8/5o8ShfTM2lvqwLODDeqdbb2NJwKQMOV4mCjGlpkD6UtxpmJ5Up+nh82kKOgSg5
         Tz1Hc7TkkZhbdA6RSzFI5dgcuh9QttS2+OKiCGAXzky900Onk7XQOMNQPg0/yalSbHpU
         ToxadfvACT8UkNLRslf0COwp/LApkUwFRccX/pDU6zIB7g/OxN7Vvd3G15Yi/AGrtq1h
         quRA==
X-Forwarded-Encrypted: i=1; AJvYcCW1UhKfDuqFnb0tpsINMWiNbL1dOUBJvIVN4QJdeMtJlE7ROWUeSL2/oGxpNxqFxOpqW87tkQLf@vger.kernel.org
X-Gm-Message-State: AOJu0YzHCfrwpPGisQzNSU6JltznajokEK9KQfLIO6YkkBfaoF5JyDkW
	+f8T41tCI65Fux5mGzQP1XyWlO+sPx6xfWc1oTzM8ao8hYoqt8o5kf7SZveR+FPvN9RUXOpGcqA
	JI7Gx4A==
X-Google-Smtp-Source: AGHT+IHpxh9NC9fR/Y+VVMw56gHiKhQb3M845RK+LO+TsitSupQfuVS+RxLJBMoZkNtQHfRh61ZaI/968chM
X-Received: from oabxa1.prod.google.com ([2002:a05:6870:7f01:b0:295:f4c4:2bdd])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:9a98:b0:297:27c6:d50f
 with SMTP id 586e51a60fabf-29dc3f9ee1emr1306226fac.2.1732676268691; Tue, 26
 Nov 2024 18:57:48 -0800 (PST)
Date: Tue, 26 Nov 2024 18:57:22 -0800
In-Reply-To: <20241127025728.3689245-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127025728.3689245-4-yuanchu@google.com>
Subject: [PATCH v4 3/9] mm: report workingset during memory pressure driven scanning
From: Yuanchu Xie <yuanchu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, Yuanchu Xie <yuanchu@google.com>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a node reaches its low watermarks and wakes up kswapd, notify all
userspace programs waiting on the workingset page age histogram of the
memory pressure, so a userspace agent can read the workingset report in
time and make policy decisions, such as logging, oom-killing, or
migration.

Sysfs interface:
/sys/devices/system/node/nodeX/workingset_report/report_threshold
	time in milliseconds that specifies how often the userspace
	agent can be notified for node memory pressure.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/workingset_report.h |  4 +++
 mm/internal.h                     | 12 ++++++++
 mm/vmscan.c                       | 46 +++++++++++++++++++++++++++++++
 mm/workingset_report.c            | 43 ++++++++++++++++++++++++++++-
 4 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index 8bae6a600410..2ec8b927b200 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -37,7 +37,11 @@ struct wsr_page_age_histo {
 };
 
 struct wsr_state {
+	unsigned long report_threshold;
 	unsigned long refresh_interval;
+
+	struct kernfs_node *page_age_sys_file;
+
 	/* breakdown of workingset by page age */
 	struct mutex page_age_lock;
 	struct wsr_page_age_histo *page_age;
diff --git a/mm/internal.h b/mm/internal.h
index bbd3c1501bac..508b7d9937d6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -479,6 +479,18 @@ bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq, bool can_swap,
 			bool force_scan);
 void set_task_reclaim_state(struct task_struct *task, struct reclaim_state *rs);
 
+#ifdef CONFIG_WORKINGSET_REPORT
+/*
+ * in mm/wsr.c
+ */
+void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat);
+#else
+static inline void notify_workingset(struct mem_cgroup *memcg,
+				     struct pglist_data *pgdat)
+{
+}
+#endif
+
 /*
  * in mm/rmap.c:
  */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 89da4d8dfb5f..2bca81271d15 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2578,6 +2578,15 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
 	return can_demote(pgdat->node_id, sc);
 }
 
+#ifdef CONFIG_WORKINGSET_REPORT
+static void try_to_report_workingset(struct pglist_data *pgdat, struct scan_control *sc);
+#else
+static inline void try_to_report_workingset(struct pglist_data *pgdat,
+					    struct scan_control *sc)
+{
+}
+#endif
+
 #ifdef CONFIG_LRU_GEN
 
 #ifdef CONFIG_LRU_GEN_ENABLED
@@ -4004,6 +4013,8 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 
 	set_initial_priority(pgdat, sc);
 
+	try_to_report_workingset(pgdat, sc);
+
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
@@ -5649,6 +5660,38 @@ static int __init init_lru_gen(void)
 };
 late_initcall(init_lru_gen);
 
+#ifdef CONFIG_WORKINGSET_REPORT
+static void try_to_report_workingset(struct pglist_data *pgdat,
+				     struct scan_control *sc)
+{
+	struct mem_cgroup *memcg = sc->target_mem_cgroup;
+	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
+	unsigned long threshold = READ_ONCE(wsr->report_threshold);
+
+	if (sc->priority == DEF_PRIORITY)
+		return;
+
+	if (!threshold)
+		return;
+
+	if (!mutex_trylock(&wsr->page_age_lock))
+		return;
+
+	if (!wsr->page_age) {
+		mutex_unlock(&wsr->page_age_lock);
+		return;
+	}
+
+	if (time_is_after_jiffies(wsr->page_age->timestamp + threshold)) {
+		mutex_unlock(&wsr->page_age_lock);
+		return;
+	}
+
+	mutex_unlock(&wsr->page_age_lock);
+	notify_workingset(memcg, pgdat);
+}
+#endif /* CONFIG_WORKINGSET_REPORT */
+
 #else /* !CONFIG_LRU_GEN */
 
 static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
@@ -6200,6 +6243,9 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
+
+		if (!sc->proactive)
+			try_to_report_workingset(zone->zone_pgdat, sc);
 		shrink_node(zone->zone_pgdat, sc);
 	}
 
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index 8678536ccfc7..bbefb0046669 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -320,6 +320,33 @@ static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
 	return &mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj))->wsr;
 }
 
+static ssize_t report_threshold_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+	unsigned int threshold = READ_ONCE(wsr->report_threshold);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(threshold));
+}
+
+static ssize_t report_threshold_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t len)
+{
+	unsigned int threshold;
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+
+	if (kstrtouint(buf, 0, &threshold))
+		return -EINVAL;
+
+	WRITE_ONCE(wsr->report_threshold, msecs_to_jiffies(threshold));
+
+	return len;
+}
+
+static struct kobj_attribute report_threshold_attr =
+	__ATTR_RW(report_threshold);
+
 static ssize_t refresh_interval_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
@@ -474,6 +501,7 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 static struct kobj_attribute page_age_attr = __ATTR_RO(page_age);
 
 static struct attribute *workingset_report_attrs[] = {
+	&report_threshold_attr.attr,
 	&refresh_interval_attr.attr,
 	&page_age_intervals_attr.attr,
 	&page_age_attr.attr,
@@ -495,8 +523,13 @@ void wsr_init_sysfs(struct node *node)
 
 	wsr = kobj_to_wsr(kobj);
 
-	if (sysfs_create_group(kobj, &workingset_report_attr_group))
+	if (sysfs_create_group(kobj, &workingset_report_attr_group)) {
 		pr_warn("Workingset report failed to create sysfs files\n");
+		return;
+	}
+
+	wsr->page_age_sys_file =
+		kernfs_walk_and_get(kobj->sd, "workingset_report/page_age");
 }
 EXPORT_SYMBOL_GPL(wsr_init_sysfs);
 
@@ -509,6 +542,14 @@ void wsr_remove_sysfs(struct node *node)
 		return;
 
 	wsr = kobj_to_wsr(kobj);
+	kernfs_put(wsr->page_age_sys_file);
 	sysfs_remove_group(kobj, &workingset_report_attr_group);
 }
 EXPORT_SYMBOL_GPL(wsr_remove_sysfs);
+
+void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat)
+{
+	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
+
+	kernfs_notify(wsr->page_age_sys_file);
+}
-- 
2.47.0.338.g60cca15819-goog


