Return-Path: <cgroups+bounces-3078-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABAF8FA81E
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 04:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0170E1F25C2D
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 02:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1F13DDD7;
	Tue,  4 Jun 2024 02:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCspLKne"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B32013D602
	for <cgroups@vger.kernel.org>; Tue,  4 Jun 2024 02:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466775; cv=none; b=QSrNsW8p5SKLoyYGVhrHOPsOffAxfKlZ7pXwfi4PKF/GBM2nO0xYjSsQ2CEHfg58yvDkkbiMlZBxoUC9xR5ZVf4/K7nFSrothBhV72AMgDaLTMlGyHsSCklFUkOSAkOPu3x0R2hRBa4iLc9nrrU3rCi3osdueu/zbXsH5edLHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466775; c=relaxed/simple;
	bh=fth2mh5hLwZQ+6IzfCTKsQwbyjH8dDmVn+u6o0NiQiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=odDBWNCFOXp8DMS6j9cPK409NCvYx+fTogk+EtSx1wmREJ4dvPmC2zzuhsMVAJQuHvkcSNm7hClBRA16Pu2t52MtXExSsFVIlpL7+7pi+F7bMv5UoaC8qv4jCOALRWpIj45XO49HfHSgF44W/r8vzcem+48R+SYovS1UWF3ry2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCspLKne; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa61b0b163so7972795276.3
        for <cgroups@vger.kernel.org>; Mon, 03 Jun 2024 19:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717466772; x=1718071572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTOg/v4agW4t4UIoB+YneZrty+w+zSP5tjy7abHeLhs=;
        b=jCspLKneDnH+idREYlO67FAi3+wE4vd8Jfq2IhxHwrPsqIS32F9zj/RbRdHvwxamwT
         Mi0CeLnfWoCrqrNWlvZ1FbotXhb8JVwsArJ8ypAibCmOC5pW6IAR6AwmqFOJkO6bQ7je
         QTSUVAHjetrJ+VzR1ybIQTlNfwQkGJnyWhP0e6sGn73CdoYv4yJD3UfhMgF82ShVD6DR
         HmsU+sThhR+ZPtpGy1+xF32KBn2TngHFbOZ11kS0hXI2rceqwfGd9+nmRmsBzQZakpGo
         gJCEnfQHa599ZqwogsTdStYQC7JCgtYvss9EwytDm1RDcPEaPNJp7qEHvR9uGCYbsNm/
         aGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717466772; x=1718071572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTOg/v4agW4t4UIoB+YneZrty+w+zSP5tjy7abHeLhs=;
        b=bz/LhlKwl3wXDKQg+Q+f3P40vV5zCMaTG3TsL2GU5SjXRFt9cp3tvDFV4dqcNmeBtR
         47xUyI72ropfkAJ8nar8JZ6kVZDkK9rNOf9f2qptBU54OepqDDjef3wfqXyz9XyAVIX6
         +gip+rbzcYTTtROmbO1LcLO3+w3kObxJRDstfP/Dt+tX6cab9P3LglXHj9aT1vPEsrc0
         N6vkPDYWSiQKqumqPKHqqrY/YElVekEzpKgdCbD0DJ07t0QvsTq+kAvbJzWUusa6kwpL
         fu0EyFSBdSmPHGHhSPaAvr5RobamlWk2KHtPiD4moHwa56rYWQh2Iwcc1vHzzviD9rve
         VE+A==
X-Forwarded-Encrypted: i=1; AJvYcCUZAjnGEIAr/szuqUIGFm5YDwMOWpKZ2NIVjBo3+WyzuWBtmSvPNsN3QqDOsI+iGPqodkuqCQoVMV7b8csdDhIQPE2ggQ/ROg==
X-Gm-Message-State: AOJu0Yz1+9Eoa+hGl6a/Cye2l7bxN4A/enhKMp9KOAmIo8ATqN6egJN5
	zrZ3E8o7r02i6r4zus4f9Bu+6ccY8K1j1g0jLWCCkRsVjjFU+bneJhvhUmKmxWhX30cxI+gSWrY
	0bqlxCQ==
X-Google-Smtp-Source: AGHT+IF3oIyaAWYZ8ktE5GFmyMb/f4z4VLJcbawoHVR7E/BZJtA687NFWcmcqqxVcMJp0b3YvGvnhH6eb1O6
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:367f:7387:3dd2:73f1])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:2d42:b0:df7:83fa:2736 with SMTP
 id 3f1490d57ef6-dfa73dbc831mr913449276.11.1717466772327; Mon, 03 Jun 2024
 19:06:12 -0700 (PDT)
Date: Mon,  3 Jun 2024 19:05:44 -0700
In-Reply-To: <20240604020549.1017540-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240604020549.1017540-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240604020549.1017540-4-yuanchu@google.com>
Subject: [PATCH v2 3/8] mm: use refresh interval to rate-limit workingset
 report aggregation
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The refresh interval is a rate limiting factor to workingset page age
histogram reads. When a workingset report is generated, a timestamp
is noted, and the same report will be read until it expires beyond
the refresh interval, at which point a new report is generated.

Sysfs interface
/sys/devices/system/node/nodeX/workingset_report/refresh_interval
	time in milliseconds specifying how long the report is valid for

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/workingset_report.h |  1 +
 mm/workingset_report.c            | 84 +++++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index d7c2ee14ec87..8bae6a600410 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -37,6 +37,7 @@ struct wsr_page_age_histo {
 };
 
 struct wsr_state {
+	unsigned long refresh_interval;
 	/* breakdown of workingset by page age */
 	struct mutex page_age_lock;
 	struct wsr_page_age_histo *page_age;
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index a4dcf62fcd96..fe553c0a653e 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -195,7 +195,8 @@ static void collect_page_age(struct wsr_page_age_histo *page_age,
 
 /* First step: hierarchically scan child memcgs. */
 static void refresh_scan(struct wsr_state *wsr, struct mem_cgroup *root,
-			 struct pglist_data *pgdat)
+			 struct pglist_data *pgdat,
+			 unsigned long refresh_interval)
 {
 	struct mem_cgroup *memcg;
 	unsigned int flags;
@@ -208,12 +209,15 @@ static void refresh_scan(struct wsr_state *wsr, struct mem_cgroup *root,
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq);
+		int gen = lru_gen_from_seq(max_seq);
+		unsigned long birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
 
 		/*
 		 * setting can_swap=true and force_scan=true ensures
 		 * proper workingset stats when the system cannot swap.
 		 */
-		try_to_inc_max_seq(lruvec, max_seq, true, true);
+		if (time_is_before_jiffies(birth + refresh_interval))
+			try_to_inc_max_seq(lruvec, max_seq, true, true);
 		cond_resched();
 	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
 
@@ -270,17 +274,25 @@ bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
 			struct pglist_data *pgdat)
 {
 	struct wsr_page_age_histo *page_age;
+	unsigned long refresh_interval = READ_ONCE(wsr->refresh_interval);
 
 	if (!READ_ONCE(wsr->page_age))
 		return false;
 
-	refresh_scan(wsr, root, pgdat);
+	if (!refresh_interval)
+		return false;
+
 	mutex_lock(&wsr->page_age_lock);
 	page_age = READ_ONCE(wsr->page_age);
-	if (page_age) {
-		copy_node_bins(pgdat, page_age);
-		refresh_aggregate(page_age, root, pgdat);
-	}
+	if (!page_age)
+		goto unlock;
+	if (page_age->timestamp &&
+	    time_is_after_jiffies(page_age->timestamp + refresh_interval))
+		goto unlock;
+	refresh_scan(wsr, root, pgdat, refresh_interval);
+	copy_node_bins(pgdat, page_age);
+	refresh_aggregate(page_age, root, pgdat);
+unlock:
 	mutex_unlock(&wsr->page_age_lock);
 	return !!page_age;
 }
@@ -299,6 +311,52 @@ static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
 	return &mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj))->wsr;
 }
 
+static ssize_t refresh_interval_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+	unsigned int interval = READ_ONCE(wsr->refresh_interval);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(interval));
+}
+
+static ssize_t refresh_interval_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t len)
+{
+	unsigned int interval;
+	int err;
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+
+	err = kstrtouint(buf, 0, &interval);
+	if (err)
+		return err;
+
+	mutex_lock(&wsr->page_age_lock);
+	if (interval && !wsr->page_age) {
+		struct wsr_page_age_histo *page_age =
+			kzalloc(sizeof(struct wsr_page_age_histo), GFP_KERNEL);
+
+		if (!page_age) {
+			err = -ENOMEM;
+			goto unlock;
+		}
+		wsr->page_age = page_age;
+	}
+	if (!interval && wsr->page_age) {
+		kfree(wsr->page_age);
+		wsr->page_age = NULL;
+	}
+
+	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(interval));
+unlock:
+	mutex_unlock(&wsr->page_age_lock);
+	return err ?: len;
+}
+
+static struct kobj_attribute refresh_interval_attr =
+	__ATTR_RW(refresh_interval);
+
 static ssize_t page_age_intervals_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
 {
@@ -382,13 +440,6 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 	int ret = 0;
 	struct wsr_state *wsr = kobj_to_wsr(kobj);
 
-
-	mutex_lock(&wsr->page_age_lock);
-	if (!wsr->page_age)
-		wsr->page_age =
-			kzalloc(sizeof(struct wsr_page_age_histo), GFP_KERNEL);
-	mutex_unlock(&wsr->page_age_lock);
-
 	wsr_refresh_report(wsr, NULL, kobj_to_pgdat(kobj));
 
 	mutex_lock(&wsr->page_age_lock);
@@ -414,7 +465,10 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 static struct kobj_attribute page_age_attr = __ATTR_RO(page_age);
 
 static struct attribute *workingset_report_attrs[] = {
-	&page_age_intervals_attr.attr, &page_age_attr.attr, NULL
+	&refresh_interval_attr.attr,
+	&page_age_intervals_attr.attr,
+	&page_age_attr.attr,
+	NULL
 };
 
 static const struct attribute_group workingset_report_attr_group = {
-- 
2.45.1.467.gbab1589fc0-goog


