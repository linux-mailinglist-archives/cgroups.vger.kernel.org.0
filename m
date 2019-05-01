Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D286A108AB
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2019 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfEAODF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 May 2019 10:03:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:3043 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfEAODF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 1 May 2019 10:03:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 07:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,417,1549958400"; 
   d="scan'208";a="145141406"
Received: from nperf12.hd.intel.com ([10.127.88.161])
  by fmsmga008.fm.intel.com with ESMTP; 01 May 2019 07:03:03 -0700
From:   Brian Welty <brian.welty@intel.com>
To:     cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        ChunMing Zhou <David1.Zhou@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [RFC PATCH 3/5] memcg: Add per-device support to memory cgroup subsystem
Date:   Wed,  1 May 2019 10:04:36 -0400
Message-Id: <20190501140438.9506-4-brian.welty@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501140438.9506-1-brian.welty@intel.com>
References: <20190501140438.9506-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Here we update memory cgroup to enable the newly introduced per-device
framework.  As mentioned in the prior patch, the intent here is to allow
drivers to have their own private cgroup controls (such as memory limit)
to be applied to device resources instead of host system resources.

In summary, to enable device registration for memory cgroup subsystem:
  *  set .allow_devices to true
  *  add new exported device register and device unregister functions
     to register a device with the cgroup subsystem
  *  implement the .device_css_alloc callback to create device
     specific cgroups_subsys_state within a cgroup

As cgroup is created and for current registered devices, one will see in
the cgroup filesystem these additional files:
  mount/<cgroup_name>/memory.devices/<dev_name>/<mem_cgrp attributes>

Registration of a new device is performed in device drivers using new
mem_cgroup_device_register(). This will create above files in existing
cgroups.

And for runtime charging to the cgroup, we add the following:
  *  add new routine to lookup the device-specific cgroup_subsys_state
     which is within the task's cgroup (mem_cgroup_device_from_task)
  *  add new functions for device specific 'direct' charging

The last point above involves adding new mem_cgroup_try_charge_direct
and mem_cgroup_uncharge_direct functions.  The 'direct' name is to say
that we are charging the specified cgroup state directly and not using
any associated page or mm_struct.  We are called within device specific
memory management routines, where the device driver will track which
cgroup to charge within its own private data structures.

With this initial submission, support for memory accounting and charging
is functional.  Nested cgroups will correctly maintain the parent for
device-specific state as well, such that hierarchial charging to device
files is supported.

Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org
Cc: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Brian Welty <brian.welty@intel.com>
---
 include/linux/memcontrol.h |  10 ++
 mm/memcontrol.c            | 183 ++++++++++++++++++++++++++++++++++---
 2 files changed, 178 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dbb6118370c1..711669b613dc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -348,6 +348,11 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
 		bool compound);
 void mem_cgroup_uncharge(struct page *page);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
+/* direct charging to mem_cgroup is primarily for device driver usage */
+int mem_cgroup_try_charge_direct(struct mem_cgroup *memcg,
+				 unsigned long nr_pages);
+void mem_cgroup_uncharge_direct(struct mem_cgroup *memcg,
+				unsigned long nr_pages);
 
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
 
@@ -395,6 +400,11 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
 bool task_in_mem_cgroup(struct task_struct *task, struct mem_cgroup *memcg);
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
+struct mem_cgroup *mem_cgroup_device_from_task(unsigned long id,
+					       struct task_struct *p);
+int mem_cgroup_device_register(struct device *dev, unsigned long *dev_id);
+void mem_cgroup_device_unregister(unsigned long dev_id);
+
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
 struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 81a0d3914ec9..2c8407aed0f5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -823,6 +823,47 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 }
 EXPORT_SYMBOL(mem_cgroup_from_task);
 
+int mem_cgroup_device_register(struct device *dev, unsigned long *dev_id)
+{
+	return cgroup_device_register(&memory_cgrp_subsys, dev, dev_id);
+}
+EXPORT_SYMBOL(mem_cgroup_device_register);
+
+void mem_cgroup_device_unregister(unsigned long dev_id)
+{
+	cgroup_device_unregister(&memory_cgrp_subsys, dev_id);
+}
+EXPORT_SYMBOL(mem_cgroup_device_unregister);
+
+/**
+ * mem_cgroup_device_from_task: Lookup device-specific memcg
+ * @id: device-specific id returned from mem_cgroup_device_register
+ * @p: task to lookup the memcg
+ *
+ * First use mem_cgroup_from_task to lookup and obtain a reference on
+ * the memcg associated with this task @p.  Within this memcg, find the
+ * device-specific one associated with @id.
+ * However if mem_cgroup is disabled, NULL is returned.
+ */
+struct mem_cgroup *mem_cgroup_device_from_task(unsigned long id,
+					       struct task_struct *p)
+{
+	struct mem_cgroup *memcg;
+	struct mem_cgroup *dev_memcg = NULL;
+
+	if (mem_cgroup_disabled())
+		return NULL;
+
+	rcu_read_lock();
+	memcg  = mem_cgroup_from_task(p);
+	if (memcg)
+		dev_memcg = idr_find(&memcg->css.device_css_idr, id);
+	rcu_read_unlock();
+
+	return dev_memcg;
+}
+EXPORT_SYMBOL(mem_cgroup_device_from_task);
+
 /**
  * get_mem_cgroup_from_mm: Obtain a reference on given mm_struct's memcg.
  * @mm: mm from which memcg should be extracted. It can be NULL.
@@ -2179,13 +2220,31 @@ void mem_cgroup_handle_over_high(void)
 	current->memcg_nr_pages_over_high = 0;
 }
 
+static bool __try_charge(struct mem_cgroup *memcg, unsigned int nr_pages,
+			 struct mem_cgroup **mem_over_limit)
+{
+	struct page_counter *counter;
+
+	if (!do_memsw_account() ||
+	    page_counter_try_charge(&memcg->memsw, nr_pages, &counter)) {
+		if (page_counter_try_charge(&memcg->memory, nr_pages, &counter))
+			return true;
+		if (do_memsw_account())
+			page_counter_uncharge(&memcg->memsw, nr_pages);
+		*mem_over_limit = mem_cgroup_from_counter(counter, memory);
+	} else {
+		*mem_over_limit = mem_cgroup_from_counter(counter, memsw);
+	}
+
+	return false;
+}
+
 static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		      unsigned int nr_pages)
 {
 	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
 	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
-	struct page_counter *counter;
 	unsigned long nr_reclaimed;
 	bool may_swap = true;
 	bool drained = false;
@@ -2198,17 +2257,10 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (consume_stock(memcg, nr_pages))
 		return 0;
 
-	if (!do_memsw_account() ||
-	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
-		if (page_counter_try_charge(&memcg->memory, batch, &counter))
-			goto done_restock;
-		if (do_memsw_account())
-			page_counter_uncharge(&memcg->memsw, batch);
-		mem_over_limit = mem_cgroup_from_counter(counter, memory);
-	} else {
-		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
-		may_swap = false;
-	}
+	if (__try_charge(memcg, batch, &mem_over_limit))
+		goto done_restock;
+	else
+		may_swap = !do_memsw_account();
 
 	if (batch > nr_pages) {
 		batch = nr_pages;
@@ -2892,6 +2944,9 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 {
 	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
 
+	if (memcg->css.device)
+		return 0;
+
 	/* we call try-to-free pages for make this cgroup empty */
 	lru_add_drain_all();
 
@@ -4496,7 +4551,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 }
 
 static struct cgroup_subsys_state * __ref
-mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
+__mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css, bool is_device)
 {
 	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
 	struct mem_cgroup *memcg;
@@ -4530,11 +4585,13 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		 * much sense so let cgroup subsystem know about this
 		 * unfortunate state in our controller.
 		 */
-		if (parent != root_mem_cgroup)
+		if (!is_device && parent != root_mem_cgroup)
 			memory_cgrp_subsys.broken_hierarchy = true;
 	}
 
-	/* The following stuff does not apply to the root */
+	/* The following stuff does not apply to devices or the root */
+	if (is_device)
+		return &memcg->css;
 	if (!parent) {
 		root_mem_cgroup = memcg;
 		return &memcg->css;
@@ -4554,6 +4611,34 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	return ERR_PTR(-ENOMEM);
 }
 
+static struct cgroup_subsys_state * __ref
+mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
+{
+	return __mem_cgroup_css_alloc(parent_css, false);
+}
+
+/*
+ * For given @cgroup_css, we create and return new device-specific css.
+ *
+ * @device and @cgroup_css are unused here, but they are provided as other
+ * cgroup subsystems might require them.
+ */
+static struct cgroup_subsys_state * __ref
+mem_cgroup_device_css_alloc(struct device *device,
+			    struct cgroup_subsys_state *cgroup_css,
+			    struct cgroup_subsys_state *parent_device_css)
+{
+	/*
+	 * For hierarchial page counters to work correctly, we specify
+	 * parent here as the device-specific css from our parent css
+	 * (@parent_device_css).  In other words, for nested cgroups,
+	 * the device-specific charging structures are also nested.
+	 * Note, caller will itself set .device and .parent in returned
+	 * structure.
+	 */
+	return __mem_cgroup_css_alloc(parent_device_css, true);
+}
+
 static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -4613,6 +4698,9 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	if (css->device)
+		goto free_cgrp;
+
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
 
@@ -4624,6 +4712,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	mem_cgroup_remove_from_trees(memcg);
 	memcg_free_shrinker_maps(memcg);
 	memcg_free_kmem(memcg);
+free_cgrp:
 	mem_cgroup_free(memcg);
 }
 
@@ -5720,6 +5809,7 @@ static struct cftype memory_files[] = {
 
 struct cgroup_subsys memory_cgrp_subsys = {
 	.css_alloc = mem_cgroup_css_alloc,
+	.device_css_alloc = mem_cgroup_device_css_alloc,
 	.css_online = mem_cgroup_css_online,
 	.css_offline = mem_cgroup_css_offline,
 	.css_released = mem_cgroup_css_released,
@@ -5732,6 +5822,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.dfl_cftypes = memory_files,
 	.legacy_cftypes = mem_cgroup_legacy_files,
 	.early_init = 0,
+	.allow_devices = true,
 };
 
 /**
@@ -6031,6 +6122,68 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
 	cancel_charge(memcg, nr_pages);
 }
 
+/**
+ * mem_cgroup_try_charge_direct - try charging nr_pages to memcg
+ * @memcg: memcgto charge
+ * @nr_pages: number of pages to charge
+ *
+ * Try to charge @nr_pages to specified @memcg. This variant is intended
+ * where the memcg is known and can be directly charged, with the primary
+ * use case being in device drivers that have registered with the subsys.
+ * Device drivers that implement their own device-specific memory manager
+ * will use these direct charging functions to make charges against their
+ * device-private state (@memcg) within the cgroup.
+ *
+ * There is no separate mem_cgroup_commit_charge() in this use case, as the
+ * device driver is not using page structs. Reclaim is not needed internally
+ * here, as the caller can decide to attempt memory reclaim on error.
+ *
+ * Returns 0 on success.  Otherwise, an error code is returned.
+ *
+ * To uncharge (or cancel charge), call mem_cgroup_uncharge_direct().
+ */
+int mem_cgroup_try_charge_direct(struct mem_cgroup *memcg,
+				 unsigned long nr_pages)
+{
+	struct mem_cgroup *mem_over_limit;
+	int ret = 0;
+
+	if (!memcg || mem_cgroup_disabled() || mem_cgroup_is_root(memcg))
+		return 0;
+
+	if (__try_charge(memcg, nr_pages, &mem_over_limit)) {
+		css_get_many(&memcg->css, nr_pages);
+	} else {
+		memcg_memory_event(mem_over_limit, MEMCG_MAX);
+		ret = -ENOMEM;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(mem_cgroup_try_charge_direct);
+
+/**
+ * mem_cgroup_uncharge_direct - uncharge nr_pages to memcg
+ * @memcg: memcg to charge
+ * @nr_pages: number of pages to charge
+ *
+ * Uncharge @nr_pages to specified @memcg. This variant is intended
+ * where the memcg is known and can directly uncharge, with the primary
+ * use case being in device drivers that have registered with the subsys.
+ * Device drivers use these direct charging functions to make charges
+ * against their device-private state (@memcg) within the cgroup.
+ *
+ * Returns 0 on success.  Otherwise, an error code is returned.
+ */
+void mem_cgroup_uncharge_direct(struct mem_cgroup *memcg,
+				unsigned long nr_pages)
+{
+	if (!memcg || mem_cgroup_disabled())
+		return;
+
+	cancel_charge(memcg, nr_pages);
+}
+EXPORT_SYMBOL(mem_cgroup_uncharge_direct);
+
 struct uncharge_gather {
 	struct mem_cgroup *memcg;
 	unsigned long pgpgout;
-- 
2.21.0

