Return-Path: <cgroups+bounces-14595-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNCGEt7lp2mrlAAAu9opvQ
	(envelope-from <cgroups+bounces-14595-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 08:57:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFF21FC103
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 08:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4B6C301FD55
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6EF382392;
	Wed,  4 Mar 2026 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wlZBNds4"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF738229B
	for <cgroups@vger.kernel.org>; Wed,  4 Mar 2026 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611033; cv=none; b=cB2D/EDUrFa6pnVSeRxt6Eu2OVU/vghyVbcpgpBSPrLGECbBr6ciYSL4h/JmLaWeSzfzZpooxS+7wd2qTU+sfPN6YMHsyMIUma9sjY77XIvWfCMhFWnUoZX4eCRh/Ncc/MtM6vcyKwfE9v0E9GREYzByBDVJZlpp3dQvUtD4K4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611033; c=relaxed/simple;
	bh=NYvgmVEPVqJpMktYRAJcFrsAXgwcFN2WWgSKOfbC4u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctX7DZzXbeyXZxiJASLhq5P4VBDjZugtKoKTbdB3soJbJXXOEGyfYsMQShuh8o//GYHQirRFyGEIXMBxMBzK0CYAt6EV+IbkhLZgj2wLyinf2Eta6eLN8au2DzEV9PLzjCcwrwtsfJvLAdcXm0RYCZNkqzwYJCRrKDeEnbaqPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wlZBNds4; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22cca07c-49e0-42e8-b937-7b1c7c51e78d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772611022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wxg6GIXIH8uLxcQfONk38hh7L7sVBupdSl5vFBvM5SQ=;
	b=wlZBNds45RPL+f9seOq7a5KQ7y5VLXKGsWCiOOWx8FHPsXmersXA8amDXXN96FxktICPic
	4qDcTzFPWmMz+UV0Bd9QlCvQ3njIvh3/y+zDpoajhQ5hLsP57xvEEZT5uje+SNchsfDJTu
	HJKn0Fxr7iZVqcsNXJSmcuf4ti+Kl4U=
Date: Wed, 4 Mar 2026 15:56:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 update 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: Yosry Ahmed <yosry@kernel.org>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com,
 usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <20260228072556.31793-1-qi.zheng@linux.dev>
 <CAO9r8zNYFvNnz_oTu10kPBYL6=1ZewKUMRYcMmcMdSqbro_miA@mail.gmail.com>
 <de1476aa-20a3-420e-9cd7-9238efd3c85f@linux.dev>
 <46bgg2vwqvmex7wtk2fkvf454tqgaychb7l4odnnrx7svci5ha@vy4b4ophm763>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <46bgg2vwqvmex7wtk2fkvf454tqgaychb7l4odnnrx7svci5ha@vy4b4ophm763>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8BFF21FC103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14595-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,bytedance.com:email]
X-Rspamd-Action: no action



On 3/3/26 10:56 PM, Yosry Ahmed wrote:
> On Tue, Mar 03, 2026 at 11:08:56AM +0800, Qi Zheng wrote:
>> Hi Yosry,
> [..]
>>>
>>> I don't think we should end up with two copies of
>>> __mod_memcg_state/mod_memcg_state() and
>>> __mod_memcg_lruvec_state/mod_memcg_lruvec_state(). I meant to refactor
>>> mod_memcg_state() to call __mod_memcg_state(), where the latter does
>>> not call get_non_dying_memcg_{start/end}(). Same for
>>> mod_memcg_lruvec_state().
>>
>> Okay, like the following? But this would require modifications to
>> [PATCH v5 31/32]. If there are no problems, I will send the updated
>> patch to [PATCH v5 29/32] and [PATCH v5 31/32].
> 
> I cannot apply the diff, seems a bit corrupted.
> 
> But ideally, instead of a @reparent argument, we just have
> __mod_memcg_lruvec_state() and __mod_memcg_state() do the work without
> getting parent of dead memcgs, and then mod_memcg_lruvec_state() and
> mod_memcg_state() just call them after get_non_dying_memcg_start().
> 
> What about this (untested), it should apply on top of 'mm: memcontrol:
> eliminate the problem of dying memory cgroup for LRU folios' in mm-new,
> so maybe it needs to be broken down across different patches:
> 

I applied  and tested it, so the final updated patches is as follows,
If there are no problems, I will send out the official patches.

[PATCH v5 update v2 29/32]:
```
Author: Qi Zheng <zhengqi.arch@bytedance.com>
Date:   Mon Jan 5 19:59:28 2026 +0800

     mm: memcontrol: prepare for reparenting non-hierarchical stats

     To resolve the dying memcg issue, we need to reparent LRU folios of 
child
     memcg to its parent memcg. This could cause problems for 
non-hierarchical
     stats.

     As Yosry Ahmed pointed out:

     ```
     In short, if memory is charged to a dying cgroup at the time of
     reparenting, when the memory gets uncharged the stats updates will 
occur
     at the parent. This will update both hierarchical and non-hierarchical
     stats of the parent, which would corrupt the parent's non-hierarchical
     stats (because those counters were never incremented when the 
memory was
     charged).
     ```

     Now we have the following two types of non-hierarchical stats, and they
     are only used in CONFIG_MEMCG_V1:

     a. memcg->vmstats->state_local[i]
     b. pn->lruvec_stats->state_local[i]

     To ensure that these non-hierarchical stats work properly, we need to
     reparent these non-hierarchical stats after reparenting LRU folios. To
     this end, this commit makes the following preparations:

     1. implement reparent_state_local() to reparent non-hierarchical stats
     2. make css_killed_work_fn() to be called in rcu work, and implement
        get_non_dying_memcg_start() and get_non_dying_memcg_end() to 
avoid race
        between mod_memcg_state()/mod_memcg_lruvec_state()
        and reparent_state_local()

     Co-developed-by: Yosry Ahmed <yosry@kernel.org>
     Signed-off-by: Yosry Ahmed <yosry@kernel.org>
     Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
     Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index be1d71dda3179..74344e3931743 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6044,8 +6044,8 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, 
const char *name, umode_t mode)
   */
  static void css_killed_work_fn(struct work_struct *work)
  {
-       struct cgroup_subsys_state *css =
-               container_of(work, struct cgroup_subsys_state, 
destroy_work);
+       struct cgroup_subsys_state *css = container_of(to_rcu_work(work),
+                               struct cgroup_subsys_state, destroy_rwork);

         cgroup_lock();

@@ -6066,8 +6066,8 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
                 container_of(ref, struct cgroup_subsys_state, refcnt);

         if (atomic_dec_and_test(&css->online_cnt)) {
-               INIT_WORK(&css->destroy_work, css_killed_work_fn);
-               queue_work(cgroup_offline_wq, &css->destroy_work);
+               INIT_RCU_WORK(&css->destroy_rwork, css_killed_work_fn);
+               queue_rcu_work(cgroup_offline_wq, &css->destroy_rwork);
         }
  }

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index fe42ef664f1e1..51fb4406f45cf 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1897,6 +1897,22 @@ static const unsigned int memcg1_events[] = {
         PGMAJFAULT,
  };

+void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct 
mem_cgroup *parent)
+{
+       int i;
+
+       for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++)
+               reparent_memcg_state_local(memcg, parent, memcg1_stats[i]);
+}
+
+void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, 
struct mem_cgroup *parent)
+{
+       int i;
+
+       for (i = 0; i < NR_LRU_LISTS; i++)
+               reparent_memcg_lruvec_state_local(memcg, parent, i);
+}
+
  void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
  {
         unsigned long memory, memsw;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 4041b5027a94b..05e6ff40f7556 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -77,6 +77,13 @@ void memcg1_uncharge_batch(struct mem_cgroup *memcg, 
unsigned long pgpgout,
                            unsigned long nr_memory, int nid);

  void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
+void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct 
mem_cgroup *parent);
+void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, 
struct mem_cgroup *parent);
+
+void reparent_memcg_state_local(struct mem_cgroup *memcg,
+                               struct mem_cgroup *parent, int idx);
+void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
+                                      struct mem_cgroup *parent, int idx);

  void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages);
  static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5929e397c3c31..b0519a16f5684 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -226,6 +226,34 @@ static inline struct obj_cgroup 
*__memcg_reparent_objcgs(struct mem_cgroup *memc
         return objcg;
  }

+#ifdef CONFIG_MEMCG_V1
+static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force);
+
+static inline void reparent_state_local(struct mem_cgroup *memcg, 
struct mem_cgroup *parent)
+{
+       if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+               return;
+
+       /*
+        * Reparent stats exposed non-hierarchically. Flush @memcg's 
stats first
+        * to read its stats accurately , and conservatively flush @parent's
+        * stats after reparenting to avoid hiding a potentially large stat
+        * update (e.g. from callers of 
mem_cgroup_flush_stats_ratelimited()).
+        */
+       __mem_cgroup_flush_stats(memcg, true);
+
+       /* The following counts are all non-hierarchical and need to be 
reparented. */
+       reparent_memcg1_state_local(memcg, parent);
+       reparent_memcg1_lruvec_state_local(memcg, parent);
+
+       __mem_cgroup_flush_stats(parent, true);
+}
+#else
+static inline void reparent_state_local(struct mem_cgroup *memcg, 
struct mem_cgroup *parent)
+{
+}
+#endif
+
  static inline void reparent_locks(struct mem_cgroup *memcg, struct 
mem_cgroup *parent)
  {
         spin_lock_irq(&objcg_lock);
@@ -473,6 +501,30 @@ unsigned long lruvec_page_state_local(struct lruvec 
*lruvec,
         return x;
  }

+#ifdef CONFIG_MEMCG_V1
+static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
+                                    enum node_stat_item idx, int val);
+
+void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
+                                      struct mem_cgroup *parent, int idx)
+{
+       int nid;
+
+       for_each_node(nid) {
+               struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, 
NODE_DATA(nid));
+               struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, 
NODE_DATA(nid));
+               unsigned long value = 
lruvec_page_state_local(child_lruvec, idx);
+               struct mem_cgroup_per_node *child_pn, *parent_pn;
+
+               child_pn = container_of(child_lruvec, struct 
mem_cgroup_per_node, lruvec);
+               parent_pn = container_of(parent_lruvec, struct 
mem_cgroup_per_node, lruvec);
+
+               __mod_memcg_lruvec_state(child_pn, idx, -value);
+               __mod_memcg_lruvec_state(parent_pn, idx, value);
+       }
+}
+#endif
+
  /* Subset of vm_event_item to report for memcg event stats */
  static const unsigned int memcg_vm_event_stat[] = {
  #ifdef CONFIG_MEMCG_V1
@@ -718,21 +770,48 @@ static int memcg_state_val_in_pages(int idx, int val)
                 return max(val * unit / PAGE_SIZE, 1UL);
  }

-/**
- * mod_memcg_state - update cgroup memory statistics
- * @memcg: the memory cgroup
- * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
- * @val: delta to add to the counter, can be negative
+#ifdef CONFIG_MEMCG_V1
+/*
+ * Used in mod_memcg_state() and mod_memcg_lruvec_state() to avoid race 
with
+ * reparenting of non-hierarchical state_locals.
   */
-void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
-                      int val)
+static inline struct mem_cgroup *get_non_dying_memcg_start(struct 
mem_cgroup *memcg)
  {
-       int i = memcg_stats_index(idx);
-       int cpu;
+       if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+               return memcg;

-       if (mem_cgroup_disabled())
+       rcu_read_lock();
+
+       while (memcg_is_dying(memcg))
+               memcg = parent_mem_cgroup(memcg);
+
+       return memcg;
+}
+
+static inline void get_non_dying_memcg_end(void)
+{
+       if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
                 return;

+       rcu_read_unlock();
+}
+#else
+static inline struct mem_cgroup *get_non_dying_memcg_start(struct 
mem_cgroup *memcg)
+{
+       return memcg;
+}
+
+static inline void get_non_dying_memcg_end(void)
+{
+}
+#endif
+
+static void __mod_memcg_state(struct mem_cgroup *memcg,
+                             enum memcg_stat_item idx, int val)
+{
+       int i = memcg_stats_index(idx);
+       int cpu;
+
         if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", 
__func__, idx))
                 return;

@@ -746,6 +825,21 @@ void mod_memcg_state(struct mem_cgroup *memcg, enum 
memcg_stat_item idx,
         put_cpu();
  }

+/**
+ * mod_memcg_state - update cgroup memory statistics
+ * @memcg: the memory cgroup
+ * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
+ * @val: delta to add to the counter, can be negative
+ */
+void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
+                      int val)
+{
+       if (mem_cgroup_disabled())
+               return;
+
+       __mod_memcg_state(memcg, idx, val);
+}
+
  #ifdef CONFIG_MEMCG_V1
  /* idx can be of type enum memcg_stat_item or node_stat_item. */
  unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
@@ -763,23 +857,27 @@ unsigned long memcg_page_state_local(struct 
mem_cgroup *memcg, int idx)
  #endif
         return x;
  }
+
+void reparent_memcg_state_local(struct mem_cgroup *memcg,
+                               struct mem_cgroup *parent, int idx)
+{
+       unsigned long value = memcg_page_state_local(memcg, idx);
+
+       __mod_memcg_state(memcg, idx, -value);
+       __mod_memcg_state(parent, idx, value);
+}
  #endif

-static void mod_memcg_lruvec_state(struct lruvec *lruvec,
-                                    enum node_stat_item idx,
-                                    int val)
+static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
+                                    enum node_stat_item idx, int val)
  {
-       struct mem_cgroup_per_node *pn;
-       struct mem_cgroup *memcg;
+       struct mem_cgroup *memcg = pn->memcg;
         int i = memcg_stats_index(idx);
         int cpu;

         if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", 
__func__, idx))
                 return;

-       pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-       memcg = pn->memcg;
-
         cpu = get_cpu();

         /* Update memcg */
@@ -795,6 +893,17 @@ static void mod_memcg_lruvec_state(struct lruvec 
*lruvec,
         put_cpu();
  }

+static void mod_memcg_lruvec_state(struct lruvec *lruvec,
+                                    enum node_stat_item idx,
+                                    int val)
+{
+       struct mem_cgroup_per_node *pn;
+
+       pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+
+       __mod_memcg_lruvec_state(pn, idx, val);
+}
+
  /**
   * mod_lruvec_state - update lruvec memory statistics
   * @lruvec: the lruvec
```

[PATCH v5 update 31/32]:

```
commit d5db0b0193c02231bb3d7938245cfd00d25a3bb4
Author: Muchun Song <songmuchun@bytedance.com>
Date:   Tue Apr 15 10:45:31 2025 +0800

     mm: memcontrol: eliminate the problem of dying memory cgroup for 
LRU folios

     Now that everything is set up, switch folio->memcg_data pointers to
     objcgs, update the accessors, and execute reparenting on cgroup death.

     Finally, folio->memcg_data of LRU folios and kmem folios will always
     point to an object cgroup pointer. The folio->memcg_data of slab
     folios will point to an vector of object cgroups.

     Signed-off-by: Muchun Song <songmuchun@bytedance.com>
     Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
     Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 57d86decf2830..1b0dbc70c6b08 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -370,9 +370,6 @@ enum objext_flags {
  #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)

  #ifdef CONFIG_MEMCG
-
-static inline bool folio_memcg_kmem(struct folio *folio);
-
  /*
   * After the initialization objcg->memcg is always pointing at
   * a valid memcg, but can be atomically swapped to the parent memcg.
@@ -386,43 +383,19 @@ static inline struct mem_cgroup 
*obj_cgroup_memcg(struct obj_cgroup *objcg)
  }

  /*
- * __folio_memcg - Get the memory cgroup associated with a non-kmem folio
- * @folio: Pointer to the folio.
- *
- * Returns a pointer to the memory cgroup associated with the folio,
- * or NULL. This function assumes that the folio is known to have a
- * proper memory cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios or
- * kmem folios.
- */
-static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
-{
-       unsigned long memcg_data = folio->memcg_data;
-
-       VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-       VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
-       VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
-
-       return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
-}
-
-/*
- * __folio_objcg - get the object cgroup associated with a kmem folio.
+ * folio_objcg - get the object cgroup associated with a folio.
   * @folio: Pointer to the folio.
   *
   * Returns a pointer to the object cgroup associated with the folio,
   * or NULL. This function assumes that the folio is known to have a
- * proper object cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios or
- * LRU folios.
+ * proper object cgroup pointer.
   */
-static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
+static inline struct obj_cgroup *folio_objcg(struct folio *folio)
  {
         unsigned long memcg_data = folio->memcg_data;

         VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
         VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
-       VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);

         return (struct obj_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
  }
@@ -436,21 +409,30 @@ static inline struct obj_cgroup 
*__folio_objcg(struct folio *folio)
   * proper memory cgroup pointer. It's not safe to call this function
   * against some type of folios, e.g. slab folios or ex-slab folios.
   *
- * For a non-kmem folio any of the following ensures folio and memcg 
binding
- * stability:
+ * For a folio any of the following ensures folio and objcg binding 
stability:
   *
   * - the folio lock
   * - LRU isolation
   * - exclusive reference
   *
- * For a kmem folio a caller should hold an rcu read lock to protect memcg
- * associated with a kmem folio from being released.
+ * Based on the stable binding of folio and objcg, for a folio any of the
+ * following ensures folio and memcg binding stability:
+ *
+ * - cgroup_mutex
+ * - the lruvec lock
+ *
+ * If the caller only want to ensure that the page counters of memcg are
+ * updated correctly, ensure that the binding stability of folio and objcg
+ * is sufficient.
+ *
+ * Note: The caller should hold an rcu read lock or cgroup_mutex to protect
+ * memcg associated with a folio from being released.
   */
  static inline struct mem_cgroup *folio_memcg(struct folio *folio)
  {
-       if (folio_memcg_kmem(folio))
-               return obj_cgroup_memcg(__folio_objcg(folio));
-       return __folio_memcg(folio);
+       struct obj_cgroup *objcg = folio_objcg(folio);
+
+       return objcg ? obj_cgroup_memcg(objcg) : NULL;
  }

  /*
@@ -474,15 +456,10 @@ static inline bool folio_memcg_charged(struct 
folio *folio)
   * has an associated memory cgroup pointer or an object cgroups vector or
   * an object cgroup.
   *
- * For a non-kmem folio any of the following ensures folio and memcg 
binding
- * stability:
+ * The page and objcg or memcg binding rules can refer to folio_memcg().
   *
- * - the folio lock
- * - LRU isolation
- * - exclusive reference
- *
- * For a kmem folio a caller should hold an rcu read lock to protect memcg
- * associated with a kmem folio from being released.
+ * A caller should hold an rcu read lock to protect memcg associated with a
+ * page from being released.
   */
  static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
  {
@@ -491,18 +468,14 @@ static inline struct mem_cgroup 
*folio_memcg_check(struct folio *folio)
          * for slabs, READ_ONCE() should be used here.
          */
         unsigned long memcg_data = READ_ONCE(folio->memcg_data);
+       struct obj_cgroup *objcg;

         if (memcg_data & MEMCG_DATA_OBJEXTS)
                 return NULL;

-       if (memcg_data & MEMCG_DATA_KMEM) {
-               struct obj_cgroup *objcg;
-
-               objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
-               return obj_cgroup_memcg(objcg);
-       }
+       objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);

-       return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
+       return objcg ? obj_cgroup_memcg(objcg) : NULL;
  }

  static inline struct mem_cgroup *page_memcg_check(struct page *page)
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 51fb4406f45cf..427cc45c3c369 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -613,6 +613,7 @@ void memcg1_commit_charge(struct folio *folio, 
struct mem_cgroup *memcg)
  void memcg1_swapout(struct folio *folio, swp_entry_t entry)
  {
         struct mem_cgroup *memcg, *swap_memcg;
+       struct obj_cgroup *objcg;
         unsigned int nr_entries;

         VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
@@ -624,12 +625,13 @@ void memcg1_swapout(struct folio *folio, 
swp_entry_t entry)
         if (!do_memsw_account())
                 return;

-       memcg = folio_memcg(folio);
-
-       VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
-       if (!memcg)
+       objcg = folio_objcg(folio);
+       VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
+       if (!objcg)
                 return;

+       rcu_read_lock();
+       memcg = obj_cgroup_memcg(objcg);
         /*
          * In case the memcg owning these pages has been offlined and 
doesn't
          * have an ID allocated to it anymore, charge the closest online
@@ -644,7 +646,7 @@ void memcg1_swapout(struct folio *folio, swp_entry_t 
entry)
         folio_unqueue_deferred_split(folio);
         folio->memcg_data = 0;

-       if (!mem_cgroup_is_root(memcg))
+       if (!obj_cgroup_is_root(objcg))
                 page_counter_uncharge(&memcg->memory, nr_entries);

         if (memcg != swap_memcg) {
@@ -665,7 +667,8 @@ void memcg1_swapout(struct folio *folio, swp_entry_t 
entry)
         preempt_enable_nested();
         memcg1_check_events(memcg, folio_nid(folio));

-       css_put(&memcg->css);
+       rcu_read_unlock();
+       obj_cgroup_put(objcg);
  }

  /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e31c58bc89188..992a3f5caa62b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -255,13 +255,17 @@ static inline void reparent_state_local(struct 
mem_cgroup *memcg, struct mem_cgr
  }
  #endif

-static inline void reparent_locks(struct mem_cgroup *memcg, struct 
mem_cgroup *parent)
+static inline void reparent_locks(struct mem_cgroup *memcg, struct 
mem_cgroup *parent, int nid)
  {
         spin_lock_irq(&objcg_lock);
+       spin_lock_nested(&mem_cgroup_lruvec(memcg, 
NODE_DATA(nid))->lru_lock, 1);
+       spin_lock_nested(&mem_cgroup_lruvec(parent, 
NODE_DATA(nid))->lru_lock, 2);
  }

-static inline void reparent_unlocks(struct mem_cgroup *memcg, struct 
mem_cgroup *parent)
+static inline void reparent_unlocks(struct mem_cgroup *memcg, struct 
mem_cgroup *parent, int nid)
  {
+       spin_unlock(&mem_cgroup_lruvec(parent, NODE_DATA(nid))->lru_lock);
+       spin_unlock(&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->lru_lock);
         spin_unlock_irq(&objcg_lock);
  }

@@ -272,14 +276,31 @@ static void memcg_reparent_objcgs(struct 
mem_cgroup *memcg)
         int nid;

         for_each_node(nid) {
-               reparent_locks(memcg, parent);
+retry:
+               if (lru_gen_enabled())
+                       max_lru_gen_memcg(parent, nid);
+
+               reparent_locks(memcg, parent, nid);
+
+               if (lru_gen_enabled()) {
+                       if (!recheck_lru_gen_max_memcg(parent, nid)) {
+                               reparent_unlocks(memcg, parent, nid);
+                               cond_resched();
+                               goto retry;
+                       }
+                       lru_gen_reparent_memcg(memcg, parent, nid);
+               } else {
+                       lru_reparent_memcg(memcg, parent, nid);
+               }

                 objcg = __memcg_reparent_objcgs(memcg, parent, nid);

-               reparent_unlocks(memcg, parent);
+               reparent_unlocks(memcg, parent, nid);

                 percpu_ref_kill(&objcg->refcnt);
         }
+
+       reparent_state_local(memcg, parent);
  }

  /*
@@ -824,6 +845,7 @@ static void __mod_memcg_state(struct mem_cgroup *memcg,
         this_cpu_add(memcg->vmstats_percpu->state[i], val);
         val = memcg_state_val_in_pages(idx, val);
         memcg_rstat_updated(memcg, val, cpu);
+
         trace_mod_memcg_state(memcg, idx, val);

         put_cpu();
@@ -841,7 +863,9 @@ void mod_memcg_state(struct mem_cgroup *memcg, enum 
memcg_stat_item idx,
         if (mem_cgroup_disabled())
                 return;

+       memcg = get_non_dying_memcg_start(memcg);
         __mod_memcg_state(memcg, idx, val);
+       get_non_dying_memcg_end();
  }

  #ifdef CONFIG_MEMCG_V1
@@ -901,11 +925,17 @@ static void mod_memcg_lruvec_state(struct lruvec 
*lruvec,
                                      enum node_stat_item idx,
                                      int val)
  {
+       struct pglist_data *pgdat = lruvec_pgdat(lruvec);
         struct mem_cgroup_per_node *pn;
+       struct mem_cgroup *memcg;

         pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+       memcg = get_non_dying_memcg_start(pn->memcg);
+       pn = memcg->nodeinfo[pgdat->node_id];

         __mod_memcg_lruvec_state(pn, idx, val);
+
+       get_non_dying_memcg_end();
  }

  /**
@@ -1128,6 +1158,8 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
  /**
   * get_mem_cgroup_from_folio - Obtain a reference on a given folio's 
memcg.
   * @folio: folio from which memcg should be extracted.
+ *
+ * See folio_memcg() for folio->objcg/memcg binding rules.
   */
  struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
  {
@@ -2769,17 +2801,17 @@ static inline int try_charge(struct mem_cgroup 
*memcg, gfp_t gfp_mask,
         return try_charge_memcg(memcg, gfp_mask, nr_pages);
  }

-static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
+static void commit_charge(struct folio *folio, struct obj_cgroup *objcg)
  {
         VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
         /*
-        * Any of the following ensures page's memcg stability:
+        * Any of the following ensures folio's objcg stability:
          *
          * - the page lock
          * - LRU isolation
          * - exclusive reference
          */
-       folio->memcg_data = (unsigned long)memcg;
+       folio->memcg_data = (unsigned long)objcg;
  }

  #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
@@ -2893,6 +2925,17 @@ static struct obj_cgroup 
*__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
         return NULL;
  }

+static inline struct obj_cgroup *get_obj_cgroup_from_memcg(struct 
mem_cgroup *memcg)
+{
+       struct obj_cgroup *objcg;
+
+       rcu_read_lock();
+       objcg = __get_obj_cgroup_from_memcg(memcg);
+       rcu_read_unlock();
+
+       return objcg;
+}
+
  static struct obj_cgroup *current_objcg_update(void)
  {
         struct mem_cgroup *memcg;
@@ -2994,17 +3037,10 @@ struct obj_cgroup 
*get_obj_cgroup_from_folio(struct folio *folio)
  {
         struct obj_cgroup *objcg;

-       if (!memcg_kmem_online())
-               return NULL;
-
-       if (folio_memcg_kmem(folio)) {
-               objcg = __folio_objcg(folio);
+       objcg = folio_objcg(folio);
+       if (objcg)
                 obj_cgroup_get(objcg);
-       } else {
-               rcu_read_lock();
-               objcg = __get_obj_cgroup_from_memcg(__folio_memcg(folio));
-               rcu_read_unlock();
-       }
+
         return objcg;
  }

@@ -3520,7 +3556,7 @@ void folio_split_memcg_refs(struct folio *folio, 
unsigned old_order,
                 return;

         new_refs = (1 << (old_order - new_order)) - 1;
-       css_get_many(&__folio_memcg(folio)->css, new_refs);
+       obj_cgroup_get_many(folio_objcg(folio), new_refs);
  }

  static void memcg_online_kmem(struct mem_cgroup *memcg)
@@ -4949,16 +4985,20 @@ void mem_cgroup_calculate_protection(struct 
mem_cgroup *root,
  static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
                         gfp_t gfp)
  {
-       int ret;
-
-       ret = try_charge(memcg, gfp, folio_nr_pages(folio));
-       if (ret)
-               goto out;
+       int ret = 0;
+       struct obj_cgroup *objcg;

-       css_get(&memcg->css);
-       commit_charge(folio, memcg);
+       objcg = get_obj_cgroup_from_memcg(memcg);
+       /* Do not account at the root objcg level. */
+       if (!obj_cgroup_is_root(objcg))
+               ret = try_charge_memcg(memcg, gfp, folio_nr_pages(folio));
+       if (ret) {
+               obj_cgroup_put(objcg);
+               return ret;
+       }
+       commit_charge(folio, objcg);
         memcg1_commit_charge(folio, memcg);
-out:
+
         return ret;
  }

@@ -5044,7 +5084,7 @@ int mem_cgroup_swapin_charge_folio(struct folio 
*folio, struct mm_struct *mm,
  }

  struct uncharge_gather {
-       struct mem_cgroup *memcg;
+       struct obj_cgroup *objcg;
         unsigned long nr_memory;
         unsigned long pgpgout;
         unsigned long nr_kmem;
@@ -5058,58 +5098,52 @@ static inline void uncharge_gather_clear(struct 
uncharge_gather *ug)

  static void uncharge_batch(const struct uncharge_gather *ug)
  {
+       struct mem_cgroup *memcg;
+
+       rcu_read_lock();
+       memcg = obj_cgroup_memcg(ug->objcg);
         if (ug->nr_memory) {
-               memcg_uncharge(ug->memcg, ug->nr_memory);
+               memcg_uncharge(memcg, ug->nr_memory);
                 if (ug->nr_kmem) {
-                       mod_memcg_state(ug->memcg, MEMCG_KMEM, 
-ug->nr_kmem);
-                       memcg1_account_kmem(ug->memcg, -ug->nr_kmem);
+                       mod_memcg_state(memcg, MEMCG_KMEM, -ug->nr_kmem);
+                       memcg1_account_kmem(memcg, -ug->nr_kmem);
                 }
-               memcg1_oom_recover(ug->memcg);
+               memcg1_oom_recover(memcg);
         }

-       memcg1_uncharge_batch(ug->memcg, ug->pgpgout, ug->nr_memory, 
ug->nid);
+       memcg1_uncharge_batch(memcg, ug->pgpgout, ug->nr_memory, ug->nid);
+       rcu_read_unlock();

         /* drop reference from uncharge_folio */
-       css_put(&ug->memcg->css);
+       obj_cgroup_put(ug->objcg);
  }

  static void uncharge_folio(struct folio *folio, struct uncharge_gather 
*ug)
  {
         long nr_pages;
-       struct mem_cgroup *memcg;
         struct obj_cgroup *objcg;

         VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);

         /*
          * Nobody should be changing or seriously looking at
-        * folio memcg or objcg at this point, we have fully
-        * exclusive access to the folio.
+        * folio objcg at this point, we have fully exclusive
+        * access to the folio.
          */
-       if (folio_memcg_kmem(folio)) {
-               objcg = __folio_objcg(folio);
-               /*
-                * This get matches the put at the end of the function and
-                * kmem pages do not hold memcg references anymore.
-                */
-               memcg = get_mem_cgroup_from_objcg(objcg);
-       } else {
-               memcg = __folio_memcg(folio);
-       }
-
-       if (!memcg)
+       objcg = folio_objcg(folio);
+       if (!objcg)
                 return;

-       if (ug->memcg != memcg) {
-               if (ug->memcg) {
+       if (ug->objcg != objcg) {
+               if (ug->objcg) {
                         uncharge_batch(ug);
                         uncharge_gather_clear(ug);
                 }
-               ug->memcg = memcg;
+               ug->objcg = objcg;
                 ug->nid = folio_nid(folio);

-               /* pairs with css_put in uncharge_batch */
-               css_get(&memcg->css);
+               /* pairs with obj_cgroup_put in uncharge_batch */
+               obj_cgroup_get(objcg);
         }

         nr_pages = folio_nr_pages(folio);
@@ -5117,20 +5151,17 @@ static void uncharge_folio(struct folio *folio, 
struct uncharge_gather *ug)
         if (folio_memcg_kmem(folio)) {
                 ug->nr_memory += nr_pages;
                 ug->nr_kmem += nr_pages;
-
-               folio->memcg_data = 0;
-               obj_cgroup_put(objcg);
         } else {
                 /* LRU pages aren't accounted at the root level */
-               if (!mem_cgroup_is_root(memcg))
+               if (!obj_cgroup_is_root(objcg))
                         ug->nr_memory += nr_pages;
                 ug->pgpgout++;

                 WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
-               folio->memcg_data = 0;
         }

-       css_put(&memcg->css);
+       folio->memcg_data = 0;
+       obj_cgroup_put(objcg);
  }

  void __mem_cgroup_uncharge(struct folio *folio)
@@ -5154,7 +5185,7 @@ void __mem_cgroup_uncharge_folios(struct 
folio_batch *folios)
         uncharge_gather_clear(&ug);
         for (i = 0; i < folios->nr; i++)
                 uncharge_folio(folios->folios[i], &ug);
-       if (ug.memcg)
+       if (ug.objcg)
                 uncharge_batch(&ug);
  }

@@ -5171,6 +5202,7 @@ void __mem_cgroup_uncharge_folios(struct 
folio_batch *folios)
  void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
  {
         struct mem_cgroup *memcg;
+       struct obj_cgroup *objcg;
         long nr_pages = folio_nr_pages(new);

         VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
@@ -5185,21 +5217,24 @@ void mem_cgroup_replace_folio(struct folio *old, 
struct folio *new)
         if (folio_memcg_charged(new))
                 return;

-       memcg = folio_memcg(old);
-       VM_WARN_ON_ONCE_FOLIO(!memcg, old);
-       if (!memcg)
+       objcg = folio_objcg(old);
+       VM_WARN_ON_ONCE_FOLIO(!objcg, old);
+       if (!objcg)
                 return;

+       rcu_read_lock();
+       memcg = obj_cgroup_memcg(objcg);
         /* Force-charge the new page. The old one will be freed soon */
-       if (!mem_cgroup_is_root(memcg)) {
+       if (!obj_cgroup_is_root(objcg)) {
                 page_counter_charge(&memcg->memory, nr_pages);
                 if (do_memsw_account())
                         page_counter_charge(&memcg->memsw, nr_pages);
         }

-       css_get(&memcg->css);
-       commit_charge(new, memcg);
+       obj_cgroup_get(objcg);
+       commit_charge(new, objcg);
         memcg1_commit_charge(new, memcg);
+       rcu_read_unlock();
  }

  /**
@@ -5215,7 +5250,7 @@ void mem_cgroup_replace_folio(struct folio *old, 
struct folio *new)
   */
  void mem_cgroup_migrate(struct folio *old, struct folio *new)
  {
-       struct mem_cgroup *memcg;
+       struct obj_cgroup *objcg;

         VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
         VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
@@ -5226,18 +5261,18 @@ void mem_cgroup_migrate(struct folio *old, 
struct folio *new)
         if (mem_cgroup_disabled())
                 return;

-       memcg = folio_memcg(old);
+       objcg = folio_objcg(old);
         /*
-        * Note that it is normal to see !memcg for a hugetlb folio.
+        * Note that it is normal to see !objcg for a hugetlb folio.
          * For e.g, it could have been allocated when 
memory_hugetlb_accounting
          * was not selected.
          */
-       VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(old) && !memcg, old);
-       if (!memcg)
+       VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(old) && !objcg, old);
+       if (!objcg)
                 return;

-       /* Transfer the charge and the css ref */
-       commit_charge(new, memcg);
+       /* Transfer the charge and the objcg ref */
+       commit_charge(new, objcg);

         /* Warning should never happen, so don't worry about refcount 
non-0 */
         WARN_ON_ONCE(folio_unqueue_deferred_split(old));
@@ -5420,22 +5455,27 @@ int __mem_cgroup_try_charge_swap(struct folio 
*folio, swp_entry_t entry)
         unsigned int nr_pages = folio_nr_pages(folio);
         struct page_counter *counter;
         struct mem_cgroup *memcg;
+       struct obj_cgroup *objcg;

         if (do_memsw_account())
                 return 0;

-       memcg = folio_memcg(folio);
-
-       VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
-       if (!memcg)
+       objcg = folio_objcg(folio);
+       VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
+       if (!objcg)
                 return 0;

+       rcu_read_lock();
+       memcg = obj_cgroup_memcg(objcg);
         if (!entry.val) {
                 memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
+               rcu_read_unlock();
                 return 0;
         }

         memcg = mem_cgroup_private_id_get_online(memcg, nr_pages);
+       /* memcg is pined by memcg ID. */
+       rcu_read_unlock();

         if (!mem_cgroup_is_root(memcg) &&
             !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
```



