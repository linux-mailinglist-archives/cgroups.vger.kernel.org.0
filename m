Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0119A41709E
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 13:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245163AbhIXLJO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 07:09:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:63202 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244623AbhIXLJO (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 24 Sep 2021 07:09:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="287720823"
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="287720823"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 04:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="485352891"
Received: from shbuild999.sh.intel.com ([10.239.146.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Sep 2021 04:07:38 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>
Subject: [PATCH v4] mm/page_alloc: detect allocation forbidden by cpuset and bail out early
Date:   Fri, 24 Sep 2021 19:07:37 +0800
Message-Id: <1632481657-68112-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There was report that starting an Ubuntu in docker while using cpuset
to bind it to movable nodes (a node only has movable zone, like a node
for hotplug or a Persistent Memory  node in normal usage) will fail
due to memory allocation failure, and then OOM is involved and many
other innocent processes got killed. It can be reproduced with command:
$docker run -it --rm  --cpuset-mems 4 ubuntu:latest bash -c
"grep Mems_allowed /proc/self/status" (node 4 is a movable node)

  runc:[2:INIT] invoked oom-killer: gfp_mask=0x500cc2(GFP_HIGHUSER|__GFP_ACCOUNT), order=0, oom_score_adj=0
  CPU: 8 PID: 8291 Comm: runc:[2:INIT] Tainted: G        W I E     5.8.2-0.g71b519a-default #1 openSUSE Tumbleweed (unreleased)
  Hardware name: Dell Inc. PowerEdge R640/0PHYDR, BIOS 2.6.4 04/09/2020
  Call Trace:
   dump_stack+0x6b/0x88
   dump_header+0x4a/0x1e2
   oom_kill_process.cold+0xb/0x10
   out_of_memory.part.0+0xaf/0x230
   out_of_memory+0x3d/0x80
   __alloc_pages_slowpath.constprop.0+0x954/0xa20
   __alloc_pages_nodemask+0x2d3/0x300
   pipe_write+0x322/0x590
   new_sync_write+0x196/0x1b0
   vfs_write+0x1c3/0x1f0
   ksys_write+0xa7/0xe0
   do_syscall_64+0x52/0xd0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

  Mem-Info:
  active_anon:392832 inactive_anon:182 isolated_anon:0
   active_file:68130 inactive_file:151527 isolated_file:0
   unevictable:2701 dirty:0 writeback:7
   slab_reclaimable:51418 slab_unreclaimable:116300
   mapped:45825 shmem:735 pagetables:2540 bounce:0
   free:159849484 free_pcp:73 free_cma:0
  Node 4 active_anon:1448kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
  Node 4 Movable free:130021408kB min:9140kB low:139160kB high:269180kB reserved_highatomic:0KB active_anon:1448kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:130023424kB managed:130023424kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:292kB local_pcp:84kB free_cma:0kB
  lowmem_reserve[]: 0 0 0 0 0
  Node 4 Movable: 1*4kB (M) 0*8kB 0*16kB 1*32kB (M) 0*64kB 0*128kB 1*256kB (M) 1*512kB (M) 1*1024kB (M) 0*2048kB 31743*4096kB (M) = 130021156kB

  oom-kill:constraint=CONSTRAINT_CPUSET,nodemask=(null),cpuset=docker-9976a269caec812c134fa317f27487ee36e1129beba7278a463dd53e5fb9997b.scope,mems_allowed=4,global_oom,task_memcg=/system.slice/containerd.service,task=containerd,pid=4100,uid=0
  Out of memory: Killed process 4100 (containerd) total-vm:4077036kB, anon-rss:51184kB, file-rss:26016kB, shmem-rss:0kB, UID:0 pgtables:676kB oom_score_adj:0
  oom_reaper: reaped process 8248 (docker), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
  oom_reaper: reaped process 2054 (node_exporter), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
  oom_reaper: reaped process 1452 (systemd-journal), now anon-rss:0kB, file-rss:8564kB, shmem-rss:4kB
  oom_reaper: reaped process 2146 (munin-node), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
  oom_reaper: reaped process 8291 (runc:[2:INIT]), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB

The reason is, in the case, the target cpuset nodes only have movable
zone, while the creation of an OS in docker sometimes needs to allocate
memory in non-movable zones (dma/dma32/normal) like GFP_HIGHUSER, and
the cpuset limit forbids the allocation, then out-of-memory killing is
involved even when normal nodes and movable nodes both have many free
memory.

The OOM killer cannot help to resolve the situation as there is no
usable memory for the request in the cpuset scope. The only reasonable
measure to take is to fail the allocation right away and have the caller
to deal with it.

So add a check for cases like this in the slowpath of allocation, and
bail out early returning NULL for the allocation.

As page allocation is one of the hottest path in kernel, this check
will hurt all users with sane cpuset configuration, add a static branch
check and detect the abnormal config in cpuset memory binding setup so
that the extra check cost in page allocation is not paid by everyone.

[thanks to Micho Hocko and David Rientjes for suggesting not handle
 it inside OOM code, adding cpuset check, refining comments]

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>

---
Changelog:

  v4:
  * add the cpuset check for mem hotplug case (David Rientjes)
  * add ack-by info and some comment
    
  v3:
  * refine the movable_only_nodes() and the nodemask check
    in cpuset code (Michal Hocko)
  * fix a compiling problem (0day test robot)

  v2:
  * add a static branch detection in cpuset code to reduce
    the overhead in allocation hotpath (Michal Hocko)

  v1 (since RFC):
  * move the handling from oom code to page allocation 
    path (Michal/David)


 include/linux/cpuset.h | 17 +++++++++++++++++
 include/linux/mmzone.h | 22 ++++++++++++++++++++++
 kernel/cgroup/cpuset.c | 23 +++++++++++++++++++++++
 mm/page_alloc.c        | 13 +++++++++++++
 4 files changed, 75 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d2b9c41..d58e047 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -34,6 +34,8 @@
  */
 extern struct static_key_false cpusets_pre_enable_key;
 extern struct static_key_false cpusets_enabled_key;
+extern struct static_key_false cpusets_insane_config_key;
+
 static inline bool cpusets_enabled(void)
 {
 	return static_branch_unlikely(&cpusets_enabled_key);
@@ -51,6 +53,19 @@ static inline void cpuset_dec(void)
 	static_branch_dec_cpuslocked(&cpusets_pre_enable_key);
 }
 
+/*
+ * This will get enabled whenever a cpuset configuration is considered
+ * unsupportable in general. E.g. movable only node which cannot satisfy
+ * any non movable allocations (see update_nodemask). Page allocator
+ * needs to make additional checks for those configurations and this
+ * check is meant to guard those checks without any overhead for sane
+ * configurations.
+ */
+static inline bool cpusets_insane_config(void)
+{
+	return static_branch_unlikely(&cpusets_insane_config_key);
+}
+
 extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
@@ -167,6 +182,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 
 static inline bool cpusets_enabled(void) { return false; }
 
+static inline bool cpusets_insane_config(void) { return false; }
+
 static inline int cpuset_init(void) { return 0; }
 static inline void cpuset_init_smp(void) {}
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6a1d79d..609fd30 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1220,6 +1220,28 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 #define for_each_zone_zonelist(zone, z, zlist, highidx) \
 	for_each_zone_zonelist_nodemask(zone, z, zlist, highidx, NULL)
 
+/* Whether the 'nodes' are all movable nodes */
+static inline bool movable_only_nodes(nodemask_t *nodes)
+{
+	struct zonelist *zonelist;
+	struct zoneref *z;
+	int nid;
+
+	if (nodes_empty(*nodes))
+		return false;
+
+	/*
+	 * We can chose arbitrary node from the nodemask to get a
+	 * zonelist as they are interlinked. We just need to find
+	 * at least one zone that can satisfy kernel allocations.
+	 */
+	nid = first_node(*nodes);
+	zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
+	z = first_zones_zonelist(zonelist, ZONE_NORMAL,	nodes);
+	return (!z->zone) ? true : false;
+}
+
+
 #ifdef CONFIG_SPARSEMEM
 #include <asm/sparsemem.h>
 #endif
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index df1ccf4..4f08a91 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -69,6 +69,13 @@
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
 
+/*
+ * There could be abnormal cpuset configurations for cpu or memory
+ * node binding, add this key to provide a quick low-cost judgement
+ * of the situation.
+ */
+DEFINE_STATIC_KEY_FALSE(cpusets_insane_config_key);
+
 /* See "Frequency meter" comments, below. */
 
 struct fmeter {
@@ -370,6 +377,17 @@ static DECLARE_WORK(cpuset_hotplug_work, cpuset_hotplug_workfn);
 
 static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
 
+static inline void check_insane_mems_config(nodemask_t *nodes)
+{
+	if (!cpusets_insane_config() &&
+		movable_only_nodes(nodes)) {
+		static_branch_enable(&cpusets_insane_config_key);
+		pr_info("Unsupported (movable nodes only) cpuset configuration detected (nmask=%*pbl)!\n"
+			"Cpuset allocations might fail even with a lot of memory available.\n",
+			nodemask_pr_args(nodes));
+	}
+}
+
 /*
  * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
  * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
@@ -1868,6 +1886,8 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval < 0)
 		goto done;
 
+	check_insane_mems_config(&trialcs->mems_allowed);
+
 	spin_lock_irq(&callback_lock);
 	cs->mems_allowed = trialcs->mems_allowed;
 	spin_unlock_irq(&callback_lock);
@@ -3171,6 +3191,9 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	cpus_updated = !cpumask_equal(&new_cpus, cs->effective_cpus);
 	mems_updated = !nodes_equal(new_mems, cs->effective_mems);
 
+	if (mems_updated)
+		check_insane_mems_config(&new_mems);
+
 	if (is_in_v2_mode())
 		hotplug_update_tasks(cs, &new_cpus, &new_mems,
 				     cpus_updated, mems_updated);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c..a7e0854 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4914,6 +4914,19 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (!ac->preferred_zoneref->zone)
 		goto nopage;
 
+	/*
+	 * Check for insane configurations where the cpuset doesn't contain
+	 * any suitable zone to satisfy the request - e.g. non-movable
+	 * GFP_HIGHUSER allocations from MOVABLE nodes only.
+	 */
+	if (cpusets_insane_config() && (gfp_mask & __GFP_HARDWALL)) {
+		struct zoneref *z = first_zones_zonelist(ac->zonelist,
+					ac->highest_zoneidx,
+					&cpuset_current_mems_allowed);
+		if (!z->zone)
+			goto nopage;
+	}
+
 	if (alloc_flags & ALLOC_KSWAPD)
 		wake_all_kswapds(order, gfp_mask, ac);
 
-- 
2.7.4

