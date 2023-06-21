Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB74738E60
	for <lists+cgroups@lfdr.de>; Wed, 21 Jun 2023 20:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjFUSRS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jun 2023 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFUSRO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Jun 2023 14:17:14 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7A719A6
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:17:12 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b516cb26c9so47566325ad.0
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687371432; x=1689963432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHNe3JpSW3qQzxOEOwM65k3PJvHd1TN91bqMS64mhVU=;
        b=MVxoxG2UJlFie+EE1fYVqH+HX9TC4DlWD+BHaHeLLJHx6Jxtu/DFPoB7LMunGaFsjp
         //1r8XRL5aRB7zBg/F9i2/UzJRwBnWI703NA2RibkRlg3moTohk16JYHt+4fDzmFU/lF
         J9YtXBEapHmbZvYFfm/TI8AJIbFeBlyUEi/8WTkJDyLh1QqStF5YuF45YeCkuAvBUg6q
         NXcwAJutswIyTGJSIujATExtb/Ttp52WLyhCNKELa/UsjoeripP+vytdkFYr7Yz97nyD
         KqivdIfLL9LXaMZgmLAkFXoY67oftZj07I4GBXIVmzIBpBgPbNV47l4Y63aZ1yUYhhRO
         y9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371432; x=1689963432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHNe3JpSW3qQzxOEOwM65k3PJvHd1TN91bqMS64mhVU=;
        b=YD02fI36PciNyCW1X+prmX7DyyVd1FKPrPlC2Q7OaEs8yeY/KjAoH1ikxs9pD3RrwL
         M5BouaGuaBvYg0VdVZH8K2We7b2/sgy/UhvnYRW7NYHU7+Bubyhue52E1Y2os/kr3FHM
         frmDMX2tUgWFaTdW8cKkGiugsuEehPwMlc99A/dRH+HJQfTLV9BYjMDdBBNB9q24I3Yp
         kUywI+2qCKeqL28Qd8CF0QjhVWbRFpuuG6nVdAcwpo0hLl0P7Bvnss7xfhoblpDi2u/F
         jH+g6zIROeIA6fAzSaRlnvl+GUFK+ciKCjsWhE6kg5Nw0HQQaHf3w4cPZAKFFRdB0tm0
         aR/A==
X-Gm-Message-State: AC+VfDzuoy4x5WVPMgi4MMlW+ZVhXWD1VcBw0hEvCTuSCH66lhhaLJOC
        JCOS08RKgoAxG9EXu70/zSlVGEVsfmRN
X-Google-Smtp-Source: ACHHUZ4KOLt5QOgx4FB1LIr7plEmFPeCuljE0b32YnY15ZVuYdQlAh+psvGrpKhQXH2ap2Bx2Nfl0jTMoIC/
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4024])
 (user=yuanchu job=sendgmr) by 2002:a17:902:efd1:b0:1b3:d6be:4680 with SMTP id
 ja17-20020a170902efd100b001b3d6be4680mr2304661plb.13.1687371432115; Wed, 21
 Jun 2023 11:17:12 -0700 (PDT)
Date:   Wed, 21 Jun 2023 18:04:53 +0000
In-Reply-To: <20230621180454.973862-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20230621180454.973862-1-yuanchu@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621180454.973862-6-yuanchu@google.com>
Subject: [RFC PATCH v2 5/6] mm: add per-memcg reaccess histogram
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

A reaccess refers to detecting an access on a page via refault
or access bit harvesting after the initial access. Similar to
the working set histogram, the reaccess histogram breaks down
reaccesses into user-defined bins.

Currently it only tracks reaccesses from access bit harvesting,
and the plan is to include refaults in the same histogram
by pulling information from folio->mapping->i_pages shadow entry
for swapped out pages.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/wsr.h |   9 +++-
 mm/memcontrol.c     |  89 ++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c         |   6 ++-
 mm/wsr.c            | 101 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+), 2 deletions(-)

diff --git a/include/linux/wsr.h b/include/linux/wsr.h
index d45f7cc0672ac..68246734679cd 100644
--- a/include/linux/wsr.h
+++ b/include/linux/wsr.h
@@ -26,11 +26,14 @@ struct ws_bin {
 struct wsr {
 	/* protects bins */
 	struct mutex bins_lock;
+	/* protects reaccess_bins */
+	struct mutex reaccess_bins_lock;
 	struct kernfs_node *notifier;
 	unsigned long timestamp;
 	unsigned long report_threshold;
 	unsigned long refresh_threshold;
 	struct ws_bin bins[MAX_NR_BINS];
+	struct ws_bin reaccess_bins[MAX_NR_BINS];
 };
 
 void wsr_register_node(struct node *node);
@@ -48,6 +51,7 @@ ssize_t wsr_intervals_ms_parse(char *src, struct ws_bin *bins);
  */
 void wsr_refresh(struct wsr *wsr, struct mem_cgroup *root,
 		 struct pglist_data *pgdat);
+void report_reaccess(struct lruvec *lruvec, struct lru_gen_mm_walk *walk);
 void report_ws(struct pglist_data *pgdat, struct scan_control *sc);
 #else
 struct ws_bin;
@@ -71,7 +75,10 @@ static inline ssize_t wsr_intervals_ms_parse(char *src, struct ws_bin *bins)
 	return -EINVAL;
 }
 static inline void wsr_refresh(struct wsr *wsr, struct mem_cgroup *root,
-		 struct pglist_data *pgdat)
+			       struct pglist_data *pgdat)
+{
+}
+static inline void report_reaccess(struct lruvec *lruvec, struct lru_gen_mm_walk *walk)
 {
 }
 static inline void report_ws(struct pglist_data *pgdat, struct scan_control *sc)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index edf5bb31bb19c..b901982d659d2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6736,6 +6736,56 @@ static ssize_t memory_wsr_intervals_ms_write(struct kernfs_open_file *of,
 	return err ?: nbytes;
 }
 
+static int memory_reaccess_intervals_ms_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wsr *wsr;
+		struct ws_bin *bin;
+
+		wsr = lruvec_wsr(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+		mutex_lock(&wsr->reaccess_bins_lock);
+		seq_printf(m, "N%d=", nid);
+		for (bin = wsr->reaccess_bins; bin->idle_age != -1; bin++)
+			seq_printf(m, "%u,", jiffies_to_msecs(bin->idle_age));
+		mutex_unlock(&wsr->reaccess_bins_lock);
+
+		seq_printf(m, "%lld ", LLONG_MAX);
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static ssize_t memory_reaccess_intervals_ms_write(struct kernfs_open_file *of,
+						  char *buf, size_t nbytes,
+						  loff_t off)
+{
+	unsigned int nid;
+	int err;
+	struct wsr *wsr;
+	struct ws_bin *bins;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	bins = kzalloc(sizeof(wsr->reaccess_bins), GFP_KERNEL);
+	if (!bins)
+		return -ENOMEM;
+
+	err = memory_wsr_intervals_ms_parse(of, buf, nbytes, &nid, bins);
+	if (err)
+		goto failed;
+
+	wsr = lruvec_wsr(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+	mutex_lock(&wsr->reaccess_bins_lock);
+	memcpy(wsr->reaccess_bins, bins, sizeof(wsr->reaccess_bins));
+	mutex_unlock(&wsr->reaccess_bins_lock);
+failed:
+	kfree(bins);
+	return err ?: nbytes;
+}
+
 static int memory_wsr_refresh_ms_show(struct seq_file *m, void *v)
 {
 	int nid;
@@ -6874,6 +6924,34 @@ __poll_t memory_wsr_histogram_poll(struct kernfs_open_file *of,
 		return DEFAULT_POLLMASK | EPOLLPRI;
 	return DEFAULT_POLLMASK;
 }
+
+static int memory_reaccess_histogram_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wsr *wsr =
+			lruvec_wsr(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+		struct ws_bin *bin;
+
+		seq_printf(m, "N%d\n", nid);
+
+		mutex_lock(&wsr->reaccess_bins_lock);
+		wsr_refresh(wsr, memcg, NODE_DATA(nid));
+		for (bin = wsr->reaccess_bins; bin->idle_age != -1; bin++)
+			seq_printf(m, "%u anon=%lu file=%lu\n",
+				   jiffies_to_msecs(bin->idle_age),
+				   bin->nr_pages[0], bin->nr_pages[1]);
+
+		seq_printf(m, "%lld anon=%lu file=%lu\n", LLONG_MAX,
+			   bin->nr_pages[0], bin->nr_pages[1]);
+
+		mutex_unlock(&wsr->reaccess_bins_lock);
+	}
+
+	return 0;
+}
 #endif
 
 static struct cftype memory_files[] = {
@@ -6969,6 +7047,17 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_wsr_histogram_show,
 		.poll = memory_wsr_histogram_poll,
 	},
+	{
+		.name = "reaccess.intervals_ms",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_reaccess_intervals_ms_show,
+		.write = memory_reaccess_intervals_ms_write,
+	},
+	{
+		.name = "reaccess.histogram",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_reaccess_histogram_show,
+	},
 #endif
 	{} /* terminate */
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ba254b6e91e19..bc8c026ceef0d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4226,6 +4226,7 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 		mem_cgroup_unlock_pages();
 
 		if (walk->batched) {
+			report_reaccess(lruvec, walk);
 			spin_lock_irq(&lruvec->lru_lock);
 			reset_batch_size(lruvec, walk);
 			spin_unlock_irq(&lruvec->lru_lock);
@@ -5079,11 +5080,14 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		sc->nr_scanned -= folio_nr_pages(folio);
 	}
 
+	walk = current->reclaim_state->mm_walk;
+	if (walk && walk->batched)
+		report_reaccess(lruvec, walk);
+
 	spin_lock_irq(&lruvec->lru_lock);
 
 	move_folios_to_lru(lruvec, &list);
 
-	walk = current->reclaim_state->mm_walk;
 	if (walk && walk->batched)
 		reset_batch_size(lruvec, walk);
 
diff --git a/mm/wsr.c b/mm/wsr.c
index cd045ade5e9ba..a63d678e64f8b 100644
--- a/mm/wsr.c
+++ b/mm/wsr.c
@@ -23,8 +23,10 @@ void wsr_init(struct lruvec *lruvec)
 	struct wsr *wsr = lruvec_wsr(lruvec);
 
 	mutex_init(&wsr->bins_lock);
+	mutex_init(&wsr->reaccess_bins_lock);
 	wsr->bins[0].idle_age = -1;
 	wsr->notifier = NULL;
+	wsr->reaccess_bins[0].idle_age = -1;
 }
 
 void wsr_destroy(struct lruvec *lruvec)
@@ -32,6 +34,7 @@ void wsr_destroy(struct lruvec *lruvec)
 	struct wsr *wsr = lruvec_wsr(lruvec);
 
 	mutex_destroy(&wsr->bins_lock);
+	mutex_destroy(&wsr->reaccess_bins_lock);
 	memset(wsr, 0, sizeof(*wsr));
 }
 
@@ -172,6 +175,104 @@ void refresh_wsr(struct wsr *wsr, struct mem_cgroup *root,
 		cond_resched();
 	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
 }
+
+static void collect_reaccess_locked(struct wsr *wsr,
+				    struct lru_gen_struct *lrugen,
+				    struct lru_gen_mm_walk *walk)
+{
+	int gen, type, zone;
+	unsigned long curr_timestamp = jiffies;
+	unsigned long max_seq = READ_ONCE(walk->max_seq);
+	unsigned long min_seq[ANON_AND_FILE] = {
+		READ_ONCE(lrugen->min_seq[LRU_GEN_ANON]),
+		READ_ONCE(lrugen->min_seq[LRU_GEN_FILE]),
+	};
+
+	for (type = 0; type < ANON_AND_FILE; type++) {
+		unsigned long seq;
+		struct ws_bin *bin = wsr->reaccess_bins;
+
+		lockdep_assert_held(&wsr->reaccess_bins_lock);
+		/* Skip max_seq because a reaccess moves a page from another seq
+		 * to max_seq. We use the negative change in page count from
+		 * other seqs to track the number of reaccesses.
+		 */
+		for (seq = max_seq - 1; seq + 1 > min_seq[type]; seq--) {
+			long error;
+			int next_gen;
+			unsigned long birth, gen_start;
+			long delta = 0;
+
+			gen = lru_gen_from_seq(seq);
+
+			for (zone = 0; zone < MAX_NR_ZONES; zone++) {
+				long nr_pages = walk->nr_pages[gen][type][zone];
+
+				if (nr_pages < 0)
+					delta += -nr_pages;
+			}
+
+			birth = READ_ONCE(lrugen->timestamps[gen]);
+			next_gen = lru_gen_from_seq(seq + 1);
+			gen_start = READ_ONCE(lrugen->timestamps[next_gen]);
+
+			/* ensure gen_start is within idle_age of bin */
+			while (bin->idle_age != -1 &&
+			       time_before(gen_start + bin->idle_age,
+					  curr_timestamp))
+				bin++;
+
+			error = delta;
+			/* gen exceeds the idle_age of bin */
+			while (bin->idle_age != -1 &&
+			       time_before(birth + bin->idle_age,
+					   curr_timestamp)) {
+				unsigned long proportion =
+					gen_start -
+					(curr_timestamp - bin->idle_age);
+				unsigned long gen_len = gen_start - birth;
+
+				if (!gen_len)
+					break;
+				if (proportion) {
+					unsigned long split_bin =
+						delta / gen_len * proportion;
+					bin->nr_pages[type] += split_bin;
+					error -= split_bin;
+				}
+				gen_start = curr_timestamp - bin->idle_age;
+				bin++;
+			}
+			bin->nr_pages[type] += error;
+		}
+	}
+}
+
+static void collect_reaccess(struct wsr *wsr,
+				   struct lru_gen_struct *lrugen,
+				   struct lru_gen_mm_walk *walk)
+{
+	if (READ_ONCE(wsr->reaccess_bins->idle_age) == -1)
+		return;
+
+	mutex_lock(&wsr->reaccess_bins_lock);
+	collect_reaccess_locked(wsr, lrugen, walk);
+	mutex_unlock(&wsr->reaccess_bins_lock);
+}
+
+void report_reaccess(struct lruvec *lruvec, struct lru_gen_mm_walk *walk)
+{
+	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+
+	while (memcg) {
+		collect_reaccess(lruvec_wsr(mem_cgroup_lruvec(
+					 memcg, lruvec_pgdat(lruvec))),
+				 lrugen, walk);
+		memcg = parent_mem_cgroup(memcg);
+	}
+}
+
 static struct pglist_data *kobj_to_pgdat(struct kobject *kobj)
 {
 	int nid = IS_ENABLED(CONFIG_NUMA) ? kobj_to_dev(kobj)->id :
-- 
2.41.0.162.gfafddb0af9-goog

