Return-Path: <cgroups+bounces-2188-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D88088F0F9
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 22:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441D229D794
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 21:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC18154422;
	Wed, 27 Mar 2024 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WD1KDZmJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C8153BC9
	for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575099; cv=none; b=DCmPExAN9eH4q8Z4UDkq3c+Q+aqqRQX8CIDKKr+ZhIV1gB/sjcUTQ3y4E7ng1RXfv5zLTiIzhXZXcu7ad5TxHwAl12my2gXNWVUrcYMwZfNV9LDxR5TIDc66JUAUFAUHL+ibJL5fqJYxnxwFp7LKAHJc5Majig0YvKxBCX+xlF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575099; c=relaxed/simple;
	bh=YVxkh2DGqIrC+tRI7u6jcPwoHLc5KJBc+Hr3yy4569I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JH3Q9CX9pkjWgqNvPTo18mNsC6iAviGVr5g9KaWDxrdHuKyBKuMN48RS8V1O0O3E/wPyhMUKnsnyZyL/EixbBFdubZ1p8yHVaHVFbc+ZukgKmbUgAXRREXbAyB/Es1oweaphrA62UmFPJ9mYdSWUCiw1kA2DovvCARXU2w3MSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WD1KDZmJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc746178515so434836276.2
        for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 14:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575096; x=1712179896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LB+v0i5rcgoLcT2egvPDfe+7I6p18e+cGMfRHtt3nUw=;
        b=WD1KDZmJFIJtqMBnYSm7A5H60Wc92/GFSsGyehydFXl4VUmvpZmn380dwIuLNsoNKv
         Ou+rxoeXHXa9cNR/Pa293XuIOrrLUD5DwSL3BZO9XcL4sDc/D+63nBAwhkw4p1XskKJs
         IkoMemLzfvkPgter0LPhiJbEtu9D6GNcKMJnAyhFACnebFS8ZCOmxBwEyOpoRkg6TfGT
         tE7/e9xg7PdueqH58kbezuuokO5yBTttpqTQFvJ6EOm45beGelCm4gsFbCLQytTKGMXA
         J2UThlH33d9tZK8cd5Bu1xHG+HkvZAOUztzYkjAjg3TWiW9OSdDIB9gyA8nDvgHnwiCX
         PY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575096; x=1712179896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LB+v0i5rcgoLcT2egvPDfe+7I6p18e+cGMfRHtt3nUw=;
        b=BM8o+KngbIcxfZXgfBXER8RRWNrpF3eUQeuIg50Acp6NnwKkNwCAjjqTGvtvyb52FG
         72VcqZGnkj7eqTCM7dY5r/ur+xRk/Rmcrm/I61cck8s0ZkvfOidCtRQhNLyb2nw8TMMR
         eq5XVI+QyUhxF/93AtWa03a6PNQrNRypc3a0vULRz5qR7m1Q0+qE1+w8EcRNppoAxdeR
         zP0MUiJbXNarYviXGU9aB6W1ezyqJhgq6zxzHgtmfNyuGyx1ZBzTnehI5uqDV0AExDLA
         qUVMiI9cWSK6yQzyr9pzyhyCrWhmZfYs+yGGAu6aCwwbRuGOOQd4mmtNUzCHF1Hd4ywF
         66Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX90dSopXP5PW1mZfqqHbLnLU8ftt5usjXx2NnyjVXMd9cXNGcSzYxjZ67xn02qDckrEVtmLroJfBfs7UGo+NNWfb/OVbtCjQ==
X-Gm-Message-State: AOJu0YyVx6Vd3GrUyF4Ey3pte6leJYcb5h0RwhJhRCz66HwG6P+osJuZ
	cTcRpj3o58FMP0f4ZcJOulXTftWYKNvp6CfmgiZYqStFkpW0xrSfvc8GLuevCvZfi2E2KRtcsBH
	/tKs0Ew==
X-Google-Smtp-Source: AGHT+IHMceXyiMQRNVP1E9sG9l7GvMJZx9fuMZnRf4fjgo+ewu4QirMYVr1TGSmtvsHYoxnOh9k/JVnZeT/d
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:6df3:ef42:a58e:a6b1])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:2183:b0:dc6:53c3:bcbd with SMTP
 id dl3-20020a056902218300b00dc653c3bcbdmr314870ybb.7.1711575095837; Wed, 27
 Mar 2024 14:31:35 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:31:03 -0700
In-Reply-To: <20240327213108.2384666-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327213108.2384666-1-yuanchu@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327213108.2384666-5-yuanchu@google.com>
Subject: [RFC PATCH v3 4/8] mm: report workingset during memory pressure
 driven scanning
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>
Cc: Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, Kairui Song <kasong@tencent.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
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
 mm/internal.h                     |  6 +++++
 mm/vmscan.c                       | 44 +++++++++++++++++++++++++++++++
 mm/workingset_report.c            | 39 +++++++++++++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index 23d2ae747a31..589d240d6251 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -35,7 +35,11 @@ struct wsr_page_age_histo {
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
index 151f09c6983e..36480c7ac0dd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -209,8 +209,14 @@ extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason
 /*
  * in mm/wsr.c
  */
+void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat);
 /* Requires wsr->page_age_lock held */
 void wsr_refresh_scan(struct lruvec *lruvec, unsigned long refresh_interval);
+#else
+static inline void notify_workingset(struct mem_cgroup *memcg,
+				     struct pglist_data *pgdat)
+{
+}
 #endif
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5f04a04f5261..c6acd5265b3f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2535,6 +2535,15 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
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
@@ -3936,6 +3945,8 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	if (!min_ttl || sc->order || sc->priority == DEF_PRIORITY)
 		return;
 
+	try_to_report_workingset(pgdat, sc);
+
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
@@ -5650,6 +5661,36 @@ void wsr_refresh_scan(struct lruvec *lruvec, unsigned long refresh_interval)
 		}
 	}
 }
+
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
 #endif /* CONFIG_WORKINGSET_REPORT */
 
 #else /* !CONFIG_LRU_GEN */
@@ -6177,6 +6218,9 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
+
+		if (!sc->proactive)
+			try_to_report_workingset(zone->zone_pgdat, sc);
 		shrink_node(zone->zone_pgdat, sc);
 	}
 
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index 370e7d355604..3ed3b0e8f8ad 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -269,6 +269,33 @@ static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
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
@@ -412,6 +439,7 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 static struct kobj_attribute page_age_attr = __ATTR_RO(page_age);
 
 static struct attribute *workingset_report_attrs[] = {
+	&report_threshold_attr.attr,
 	&refresh_interval_attr.attr,
 	&page_age_intervals_attr.attr,
 	&page_age_attr.attr,
@@ -437,6 +465,9 @@ void wsr_register_node(struct node *node)
 		pr_warn("WSR failed to created group");
 		return;
 	}
+
+	wsr->page_age_sys_file =
+		kernfs_walk_and_get(kobj->sd, "workingset_report/page_age");
 }
 EXPORT_SYMBOL_GPL(wsr_register_node);
 
@@ -450,6 +481,14 @@ void wsr_unregister_node(struct node *node)
 
 	wsr = kobj_to_wsr(kobj);
 	sysfs_remove_group(kobj, &workingset_report_attr_group);
+	kernfs_put(wsr->page_age_sys_file);
 	wsr_destroy(mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj)));
 }
 EXPORT_SYMBOL_GPL(wsr_unregister_node);
+
+void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat)
+{
+	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
+
+	kernfs_notify(wsr->page_age_sys_file);
+}
-- 
2.44.0.396.g6e790dbe36-goog


