Return-Path: <cgroups+bounces-2187-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF4E88F0F3
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 22:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FE91F2B1DB
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B433153BC3;
	Wed, 27 Mar 2024 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lwdOBKp2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56615382D
	for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575096; cv=none; b=IGMl64WwufIhPDzh+9bAhwZarJdsFkFigkdPBamITZnILnT9C2jNX0fJIvEArqK4oLJ1WZ8ku3noAHtqMGks6W0kB/nJter2UyLavm1G8MtlflccwE07h4oyjHFxA13czXtyiXE2bKpa/23xmsGILB91BwoTXWKyBR/r82++zwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575096; c=relaxed/simple;
	bh=KqgfMalJg5cK1sr8buPi1WIykQp4gPgm8sgWmVBbZUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULSR5S+NJXqMf11lfwRusUq/YXTRXpe7Fz/OH+XdVm4FSB4RsLMjs6buTMtT3Dt20r1Dkvw7aflvjKNlxBVhfPrey59s/VbzWe8c9xGAMVed82/DxPsrfp38aaioClPXJm7C8UZtsWRIDK+mHJAxbSUrDjzQVArrJGm7zwR/ipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lwdOBKp2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a4ee41269so6002757b3.0
        for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 14:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575094; x=1712179894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CyJDixqg00pkxMZu+nlTfhoUxwjhkmzgxYkGofwS92E=;
        b=lwdOBKp2D+xsoAkZgdowY+DOxtuZ/liBSA1+2PnITIp8eHaJDOP20+AmH7lUlwsgyt
         /0gOTAy711kMxJKmT9B9ytGZEwda25NwYYTArSqlWBvt7vrgc8IsfNvX1APXn9yTL/AE
         aaBKh7D6GBBIxxWwYL2T8yv/CCFX7BAXVErCQl/Si+oKou10BunaMOtm3pds86LrpN/F
         6ryGKAI8z+cnt9lVE/Ve/0hjmkWvHWQ4RMbpJjG4sT37Tmixco2Du6saN8jktO/AgA++
         hz8d5P0XrUF6+9ufJ+6PR+7gs/gzkICNcX6ysXmS4RwgiKcXlom0j6DTItEbtE65qVin
         Ewsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575094; x=1712179894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CyJDixqg00pkxMZu+nlTfhoUxwjhkmzgxYkGofwS92E=;
        b=gH5jqbN1B6nbkYtt6u3d9UY6LEWzk8wugIgn2tmwqzciqBOIf3Skygub/LYkKFoj+j
         SNMcZGso+E1ZGOiMnbpF8evkYEu37lI5iaZnkeeYfG+uaJEY1gDn8haHLm/zg2xXtk27
         QYfv7XxEYEr83C1kim+deo2fMEey4xMpRx5rzx1IjmWu5yWb9SYqK3pxeotT8BP1Fwkz
         WfjYF66tqpkBPKX2K/EfF2k9lfrzMHETbcQO4paaKwwN8qpn8s5+rWL5kK0BFbI0Ix5d
         dhEfXuZOnOvOfjt0rVyvIXXTfkdzUAHGhSvLsD0XM7p6iZELc+EMmzbmh1zsgV/4Fqju
         HV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz5QpFtaef/wq1SsjCVPh05mi+mmqnehbbxG4S8yRwjnJT/XcFiSbtLZQtskXlStrauF5w9e2d5md2UXzwJp2M21R766m8yg==
X-Gm-Message-State: AOJu0YyTogHWt4LlePXjBNkjixYuWkbmeQWRcwbLh4uSSb7iEBRV3N0j
	jPKq1R1yu4Bzbwoxtbn8l9C8BOOywex2JKO7L1Ir3fQgQ2Pxs8RVTJu8C+hzb5/4GZ7l+vZ1JxU
	pBY34tQ==
X-Google-Smtp-Source: AGHT+IGSGqv5KUSJmM8bk0cJQQF7BQEKotxJoozxsxA3rktWM2RtKyv04koLrGenDZXEe0nH0BWimglXW+HF
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:6df3:ef42:a58e:a6b1])
 (user=yuanchu job=sendgmr) by 2002:a0d:ca8b:0:b0:60a:e67:2ed0 with SMTP id
 m133-20020a0dca8b000000b0060a0e672ed0mr212398ywd.9.1711575094066; Wed, 27 Mar
 2024 14:31:34 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:31:02 -0700
In-Reply-To: <20240327213108.2384666-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327213108.2384666-1-yuanchu@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327213108.2384666-4-yuanchu@google.com>
Subject: [RFC PATCH v3 3/8] mm: use refresh interval to rate-limit workingset
 report aggregation
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
 mm/internal.h                     |  2 +-
 mm/vmscan.c                       | 27 ++++++++------
 mm/workingset_report.c            | 58 ++++++++++++++++++++++++++-----
 4 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index 0de640cb1ef0..23d2ae747a31 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -35,6 +35,7 @@ struct wsr_page_age_histo {
 };
 
 struct wsr_state {
+	unsigned long refresh_interval;
 	/* breakdown of workingset by page age */
 	struct mutex page_age_lock;
 	struct wsr_page_age_histo *page_age;
diff --git a/mm/internal.h b/mm/internal.h
index 5e0caba64ee4..151f09c6983e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -210,7 +210,7 @@ extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason
  * in mm/wsr.c
  */
 /* Requires wsr->page_age_lock held */
-void wsr_refresh_scan(struct lruvec *lruvec);
+void wsr_refresh_scan(struct lruvec *lruvec, unsigned long refresh_interval);
 #endif
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b694d80ab2d1..5f04a04f5261 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5620,7 +5620,7 @@ late_initcall(init_lru_gen);
  *                          workingset reporting
  ******************************************************************************/
 #ifdef CONFIG_WORKINGSET_REPORT
-void wsr_refresh_scan(struct lruvec *lruvec)
+void wsr_refresh_scan(struct lruvec *lruvec, unsigned long refresh_interval)
 {
 	DEFINE_MAX_SEQ(lruvec);
 	struct scan_control sc = {
@@ -5633,15 +5633,22 @@ void wsr_refresh_scan(struct lruvec *lruvec)
 	};
 	unsigned int flags;
 
-	set_task_reclaim_state(current, &sc.reclaim_state);
-	flags = memalloc_noreclaim_save();
-	/*
-	 * setting can_swap=true and force_scan=true ensures
-	 * proper workingset stats when the system cannot swap.
-	 */
-	try_to_inc_max_seq(lruvec, max_seq, &sc, true, true);
-	memalloc_noreclaim_restore(flags);
-	set_task_reclaim_state(current, NULL);
+	if (refresh_interval) {
+		int gen = lru_gen_from_seq(max_seq);
+		unsigned long birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
+
+		if (time_is_before_jiffies(birth + refresh_interval)) {
+			set_task_reclaim_state(current, &sc.reclaim_state);
+			flags = memalloc_noreclaim_save();
+			/*
+			 * setting can_swap=true and force_scan=true ensures
+			 * proper workingset stats when the system cannot swap.
+			 */
+			try_to_inc_max_seq(lruvec, max_seq, &sc, true, true);
+			memalloc_noreclaim_restore(flags);
+			set_task_reclaim_state(current, NULL);
+		}
+	}
 }
 #endif /* CONFIG_WORKINGSET_REPORT */
 
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index 98cdaffcb6b4..370e7d355604 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -181,7 +181,8 @@ static void collect_page_age(struct wsr_page_age_histo *page_age,
 
 /* First step: hierarchically scan child memcgs. */
 static void refresh_scan(struct wsr_state *wsr, struct mem_cgroup *root,
-			 struct pglist_data *pgdat)
+			 struct pglist_data *pgdat,
+			 unsigned long refresh_interval)
 {
 	struct mem_cgroup *memcg;
 
@@ -189,7 +190,7 @@ static void refresh_scan(struct wsr_state *wsr, struct mem_cgroup *root,
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-		wsr_refresh_scan(lruvec);
+		wsr_refresh_scan(lruvec, refresh_interval);
 		cond_resched();
 	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
 }
@@ -231,16 +232,25 @@ static void refresh_aggregate(struct wsr_page_age_histo *page_age,
 bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
 			struct pglist_data *pgdat)
 {
-	struct wsr_page_age_histo *page_age;
+	struct wsr_page_age_histo *page_age = NULL;
+	unsigned long refresh_interval = READ_ONCE(wsr->refresh_interval);
 
 	if (!READ_ONCE(wsr->page_age))
 		return false;
 
-	refresh_scan(wsr, root, pgdat);
+	if (!refresh_interval)
+		return false;
+
 	mutex_lock(&wsr->page_age_lock);
 	page_age = READ_ONCE(wsr->page_age);
-	if (page_age)
-		refresh_aggregate(page_age, root, pgdat);
+	if (!page_age)
+		goto unlock;
+	if (time_is_after_jiffies(page_age->timestamp + refresh_interval))
+		goto unlock;
+	refresh_scan(wsr, root, pgdat, refresh_interval);
+	refresh_aggregate(page_age, root, pgdat);
+
+unlock:
 	mutex_unlock(&wsr->page_age_lock);
 	return !!page_age;
 }
@@ -259,6 +269,35 @@ static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
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
+	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(interval));
+
+	return len;
+}
+
+static struct kobj_attribute refresh_interval_attr =
+	__ATTR_RW(refresh_interval);
+
 static ssize_t page_age_intervals_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
 {
@@ -267,7 +306,7 @@ static ssize_t page_age_intervals_show(struct kobject *kobj,
 
 	mutex_lock(&wsr->page_age_lock);
 
-	if (!!wsr->page_age) {
+	if (wsr->page_age) {
 		int i;
 		int nr_bins = wsr->page_age->bins.nr_bins;
 
@@ -373,7 +412,10 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
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
2.44.0.396.g6e790dbe36-goog


