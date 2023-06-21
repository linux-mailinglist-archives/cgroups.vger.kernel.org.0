Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADF3738E5D
	for <lists+cgroups@lfdr.de>; Wed, 21 Jun 2023 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjFUSRQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jun 2023 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjFUSRK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Jun 2023 14:17:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CF11716
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:17:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacd408046cso8115885276.3
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687371428; x=1689963428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JGsVX34HhPuQXT4BLiLEOz1NiuPLfb2cVh6HwJxK4o=;
        b=70Qxbud8HFNvNvLOmD566LbrpApTrbrxWsMSM6HF6QmoZGg/FBnAyX88slUMpumiBi
         diNbZcJERvs0V2VffNaDCVaHMJOzaVrBEkAe5EZ1O6A/hh0O9H5aZf8H2BB6Mlok5pwi
         Qp29oWTYIUZtuSy9RX7gPmQXkCw4QFn5nNaIbxnoUmOxwFKIDY0cBb8w/oEdrOysTyGI
         QKa8UsiA1/jCdjbbwtNfphxGUkYaFoXgqKIEitSaRhd8zSW01LwtJliel8Hudvgi30AS
         X/k6OhQGaUKb6QuOPuutfW8riQaepGTB5XzW87kgVWm7FTNzPsJL/a16RJ7U5XR1IOzX
         77wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371428; x=1689963428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JGsVX34HhPuQXT4BLiLEOz1NiuPLfb2cVh6HwJxK4o=;
        b=gsgmLHJZ8AoT5J4EQ1QOvqHSv8+rJVQgtBVZXM5U3ojoBcJHp7ibVe0yPpIfdJsyFl
         7L5qbfonGmOyXZ8ITnSzq4N2E3/8vGxlynVZOhIN27aG0ewzMAgE57KpWrnpMl3mtano
         S/lrw+zsSVZoM37l8aFMxHm9puwXTqp6DfmY+WrKQyNwFpS2S5zhATP0H0wALVPcbbPa
         IxvMzCzIiORTE7ahR9hazr/4mImVRS+5L3vxtkhF6TgjbMyOUz/qyQUn/klpDYC4V6gv
         /6vcImyTtPprzYkHcT8CYf8TUyiVgqQzz2Xp42hJHIsj2zX8WBGwGIn+rYz+lZojEazR
         +6lA==
X-Gm-Message-State: AC+VfDwVwsewi9tZxJNAkez0bUVXNykb8Tx8xfzSj9FBzP5i8SciqgEP
        ScchT6O10gQrJfcgfMNOBtlxRKX+ubDr
X-Google-Smtp-Source: ACHHUZ7lRjBP8EMwiQd1c1PX3iz3BwdoE/2T4JCNISwvB2v6amjWmLe2IOsvdnoC6x+fSso2MhIxsYXQ7Fqr
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4024])
 (user=yuanchu job=sendgmr) by 2002:a25:ab28:0:b0:bc5:2869:d735 with SMTP id
 u37-20020a25ab28000000b00bc52869d735mr6204196ybi.13.1687371428609; Wed, 21
 Jun 2023 11:17:08 -0700 (PDT)
Date:   Wed, 21 Jun 2023 18:04:51 +0000
In-Reply-To: <20230621180454.973862-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20230621180454.973862-1-yuanchu@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621180454.973862-4-yuanchu@google.com>
Subject: [RFC PATCH v2 3/6] mm: report working set when under memory pressure
From:   Yuanchu Xie <yuanchu@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kairui Song <kasong@tencent.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yuanchu Xie <yuanchu@google.com>,
        "T . J . Alumbaugh" <talumbau@google.com>
Cc:     Wei Xu <weixugc@google.com>, SeongJae Park <sj@kernel.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        kai.huang@intel.com, hch@lst.de, jon@nutanix.com,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a system is under memory pressure and kswapd kicks in,
a working set report is produced. The userspace program
polling on the histogram file is notified of the new report.

The report threshold acts as a rate-limiting mechanism to
prevent the system from generating reports too frequently.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/wsr.h |  2 ++
 mm/vmscan.c         | 37 +++++++++++++++++++++++++++++++++++++
 mm/wsr.c            | 29 +++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/include/linux/wsr.h b/include/linux/wsr.h
index a86105468c710..85c901ce026b9 100644
--- a/include/linux/wsr.h
+++ b/include/linux/wsr.h
@@ -26,7 +26,9 @@ struct ws_bin {
 struct wsr {
 	/* protects bins */
 	struct mutex bins_lock;
+	struct kernfs_node *notifier;
 	unsigned long timestamp;
+	unsigned long report_threshold;
 	unsigned long refresh_threshold;
 	struct ws_bin bins[MAX_NR_BINS];
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 66c5df2a7f65b..c56fddcec88fb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4559,6 +4559,8 @@ static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc, unsigned
 	return true;
 }
 
+static void report_ws(struct pglist_data *pgdat, struct scan_control *sc);
+
 /* to protect the working set of the last N jiffies */
 static unsigned long lru_gen_min_ttl __read_mostly;
 
@@ -4570,6 +4572,8 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 
 	VM_WARN_ON_ONCE(!current_is_kswapd());
 
+	report_ws(pgdat, sc);
+
 	sc->last_reclaimed = sc->nr_reclaimed;
 
 	/*
@@ -5933,6 +5937,39 @@ void wsr_refresh(struct wsr *wsr, struct mem_cgroup *root,
 	}
 }
 
+static void report_ws(struct pglist_data *pgdat, struct scan_control *sc)
+{
+	static DEFINE_RATELIMIT_STATE(rate, HZ, 3);
+
+	struct mem_cgroup *memcg = sc->target_mem_cgroup;
+	struct wsr *wsr = lruvec_wsr(mem_cgroup_lruvec(memcg, pgdat));
+	unsigned long threshold;
+
+	threshold = READ_ONCE(wsr->report_threshold);
+
+	if (sc->priority == DEF_PRIORITY)
+		return;
+
+	if (READ_ONCE(wsr->bins->idle_age) == -1)
+		return;
+
+	if (!threshold || time_is_after_jiffies(wsr->timestamp + threshold))
+		return;
+
+	if (!__ratelimit(&rate))
+		return;
+
+	if (!mutex_trylock(&wsr->bins_lock))
+		return;
+
+	refresh_wsr(wsr, memcg, pgdat, sc, 0);
+	WRITE_ONCE(wsr->timestamp, jiffies);
+
+	mutex_unlock(&wsr->bins_lock);
+
+	if (wsr->notifier)
+		kernfs_notify(wsr->notifier);
+}
 #endif /* CONFIG_WSR */
 
 #else /* !CONFIG_LRU_GEN */
diff --git a/mm/wsr.c b/mm/wsr.c
index ee295d164461e..cd045ade5e9ba 100644
--- a/mm/wsr.c
+++ b/mm/wsr.c
@@ -24,6 +24,7 @@ void wsr_init(struct lruvec *lruvec)
 
 	mutex_init(&wsr->bins_lock);
 	wsr->bins[0].idle_age = -1;
+	wsr->notifier = NULL;
 }
 
 void wsr_destroy(struct lruvec *lruvec)
@@ -184,6 +185,30 @@ static struct wsr *kobj_to_wsr(struct kobject *kobj)
 	return lruvec_wsr(mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj)));
 }
 
+static ssize_t report_ms_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *buf)
+{
+	struct wsr *wsr = kobj_to_wsr(kobj);
+	unsigned long threshold = READ_ONCE(wsr->report_threshold);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(threshold));
+}
+
+static ssize_t report_ms_store(struct kobject *kobj, struct kobj_attribute *attr,
+			       const char *buf, size_t len)
+{
+	unsigned int msecs;
+	struct wsr *wsr = kobj_to_wsr(kobj);
+
+	if (kstrtouint(buf, 0, &msecs))
+		return -EINVAL;
+
+	WRITE_ONCE(wsr->report_threshold, msecs_to_jiffies(msecs));
+
+	return len;
+}
+
+static struct kobj_attribute report_ms_attr = __ATTR_RW(report_ms);
 
 static ssize_t refresh_ms_show(struct kobject *kobj, struct kobj_attribute *attr,
 			       char *buf)
@@ -290,6 +315,7 @@ static ssize_t histogram_show(struct kobject *kobj, struct kobj_attribute *attr,
 static struct kobj_attribute histogram_attr = __ATTR_RO(histogram);
 
 static struct attribute *wsr_attrs[] = {
+	&report_ms_attr.attr,
 	&refresh_ms_attr.attr,
 	&intervals_ms_attr.attr,
 	&histogram_attr.attr,
@@ -318,6 +344,8 @@ void wsr_register_node(struct node *node)
 		pr_warn("WSR failed to created group");
 		return;
 	}
+
+	wsr->notifier = kernfs_walk_and_get(kobj->sd, "wsr/histogram");
 }
 
 void wsr_unregister_node(struct node *node)
@@ -329,6 +357,7 @@ void wsr_unregister_node(struct node *node)
 		return;
 
 	wsr = kobj_to_wsr(kobj);
+	kernfs_put(wsr->notifier);
 	sysfs_remove_group(kobj, &wsr_attr_group);
 	wsr_destroy(mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj)));
 }
-- 
2.41.0.162.gfafddb0af9-goog

