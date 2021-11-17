Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9555454E5B
	for <lists+cgroups@lfdr.de>; Wed, 17 Nov 2021 21:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbhKQUV3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Nov 2021 15:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbhKQUV3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Nov 2021 15:21:29 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED22C061764
        for <cgroups@vger.kernel.org>; Wed, 17 Nov 2021 12:18:30 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 184-20020a6217c1000000b0049f9aad0040so2230010pfx.21
        for <cgroups@vger.kernel.org>; Wed, 17 Nov 2021 12:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=O1MBWZP0gt+HyX3gR4kF20oCHY3X34xFMoS30x4+TOQ=;
        b=HCyuPxvnDsccHswcSq8py7b/w3/edCWqAuT/irPlq3tdfyg07izoqP9cB/9D1P4zIs
         QzXljnZqzQ5MdhGis+qBqjNfwkFZ2tNerCdcgHrG2Bi8alDfWR870Fk0umojap0W/sC1
         X9VMm6rmTZ6/iq8SUu86cpln4Jlw51VoRs9Zy7ybkHzuPvGRXcuyKcqDnsbVbSJ8nikb
         mmfzwbTVTJswVgjWu05VZkExaYh+aQN2qG/6isL3LbRM1qP9seWm7mJ/aiUnWfCk+LIE
         aGFZHbYD5bWfOKc9mVC2gnx44CPIP6BdedZ8yOEF55BhtYnR6bYKlwkVapUddobMa67C
         7ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=O1MBWZP0gt+HyX3gR4kF20oCHY3X34xFMoS30x4+TOQ=;
        b=P5HM4jgq0fMH223D85aXjPzatcOHcaeGn4bM0DJVy/ZzLuSN7V+6ZySlqqhPBUa1R2
         8sN6MXzUpyxxvPhmfguhg9oIPrFhIU6+4+AZk0ruFIU5M3S3Ra8opFPqM3Ga4TtZDvtj
         AY1MQHtXpP/DSSj8b8t0yms5oxdYIwa1dx5EWeB80psQxq3+fWd1K1C5u9icWY5J2kZv
         oeZQ+ZEip5ywQyZgFavxf2xRiKW3mlwHZc7FNyLEjs4gW5AThUnlhBevBcpWPPVw2Bee
         iQ3nPFwudy9UPmOILtFronjmm8VZ+zg+8pp0gyMTNNDYOLL9oip16HStdz/4RpIAPfr+
         Q1DA==
X-Gm-Message-State: AOAM530a26hSCsSCADvOot2AWdxpnqKXMgTtanfsEa8jiKyqXw7E9dx1
        FB5gKYIgRe2JRgnZp66GtiAGc1M5Rcu0hzRDLQ==
X-Google-Smtp-Source: ABdhPJxap32fuc2coP7O/PtWU08w/OaCRAj+mDuctUf4Hr0/WOpvXSe/XFI27WjGk9oXNFKsxi4Uc6HyoNUR/omf5Q==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:ab13:f492:fd91:a37d])
 (user=almasrymina job=sendgmr) by 2002:a17:902:db01:b0:141:ea12:2176 with
 SMTP id m1-20020a170902db0100b00141ea122176mr59446374plx.44.1637180309537;
 Wed, 17 Nov 2021 12:18:29 -0800 (PST)
Date:   Wed, 17 Nov 2021 12:18:24 -0800
Message-Id: <20211117201825.429650-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v7] hugetlb: Add hugetlb.*.numa_stat file
From:   Mina Almasry <almasrymina@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, Jue Wang <juew@google.com>,
        Yang Yao <ygyao@google.com>, Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For hugetlb backed jobs/VMs it's critical to understand the numa
information for the memory backing these jobs to deliver optimal
performance.

Currently this technically can be queried from /proc/self/numa_maps, but
there are significant issues with that. Namely:
1. Memory can be mapped or unmapped.
2. numa_maps are per process and need to be aggregated across all
   processes in the cgroup. For shared memory this is more involved as
   the userspace needs to make sure it doesn't double count shared
   mappings.
3. I believe querying numa_maps needs to hold the mmap_lock which adds
   to the contention on this lock.

For these reasons I propose simply adding hugetlb.*.numa_stat file,
which shows the numa information of the cgroup similarly to
memory.numa_stat.

On cgroup-v2:
   cat /sys/fs/cgroup/unified/test/hugetlb.2MB.numa_stat
   total=3D2097152 N0=3D2097152 N1=3D0

On cgroup-v1:
   cat /sys/fs/cgroup/hugetlb/test/hugetlb.2MB.numa_stat
   total=3D2097152 N0=3D2097152 N1=3D0
   hierarichal_total=3D2097152 N0=3D2097152 N1=3D0

This patch was tested manually by allocating hugetlb memory and querying
the hugetlb.*.numa_stat file of the cgroup and its parents.
=EF=BF=BC
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Jue Wang <juew@google.com>
Cc: Yang Yao <ygyao@google.com>
Cc: Joanna Li <joannali@google.com>
Cc: Cannon Matthews <cannonmatthews@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v7:
- Converted back usage to unsigned long + READ_ONCE/WRITE_ONCE rather
than atomic_long_t

Changes in v6:
- Changed usage from unsigned long to atomic_long_t

Changes in v5:
- Fixed commit message typo.
- Fixed per node usage documentation to be in pages.
- Removed unnecessary h_cg check.

Changes in v4:
- Removed unnecessary braces.
- usage is now counted in pages instead of bytes.
- Reverted unneeded changes to write_to_hugetlbfs.c

Changes in v3:
- Fixed typos (sorry!)
- Used conventional locations for cgroups mount points in docs/commit
message.
- Updated docs.
- Handle kzalloc_node failure, and proper deallocation of per node data.
- Use struct_size() to calculate the struct size.
- Use nr_node_ids instead of MAX_NUMNODES.
- Updated comments per multi-line comment pattern.

Changes in v2:
- Fix warning Reported-by: kernel test robot <lkp@intel.com>
---
 .../admin-guide/cgroup-v1/hugetlb.rst         |   4 +
 Documentation/admin-guide/cgroup-v2.rst       |   5 +
 include/linux/hugetlb.h                       |   4 +-
 include/linux/hugetlb_cgroup.h                |   7 +
 mm/hugetlb_cgroup.c                           | 132 ++++++++++++++++--
 5 files changed, 140 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentatio=
n/admin-guide/cgroup-v1/hugetlb.rst
index 338f2c7d7a1c..0fa724d82abb 100644
--- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
+++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
@@ -29,12 +29,14 @@ Brief summary of control files::
  hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hugepag=
esize" hugetlb  usage recorded
  hugetlb.<hugepagesize>.usage_in_bytes                 # show current usag=
e for "hugepagesize" hugetlb
  hugetlb.<hugepagesize>.failcnt                        # show the number o=
f allocation failure due to HugeTLB usage limit
+ hugetlb.<hugepagesize>.numa_stat                      # show the numa inf=
ormation of the hugetlb memory charged to this cgroup

 For a system supporting three hugepage sizes (64k, 32M and 1G), the contro=
l
 files include::

   hugetlb.1GB.limit_in_bytes
   hugetlb.1GB.max_usage_in_bytes
+  hugetlb.1GB.numa_stat
   hugetlb.1GB.usage_in_bytes
   hugetlb.1GB.failcnt
   hugetlb.1GB.rsvd.limit_in_bytes
@@ -43,6 +45,7 @@ files include::
   hugetlb.1GB.rsvd.failcnt
   hugetlb.64KB.limit_in_bytes
   hugetlb.64KB.max_usage_in_bytes
+  hugetlb.64KB.numa_stat
   hugetlb.64KB.usage_in_bytes
   hugetlb.64KB.failcnt
   hugetlb.64KB.rsvd.limit_in_bytes
@@ -51,6 +54,7 @@ files include::
   hugetlb.64KB.rsvd.failcnt
   hugetlb.32MB.limit_in_bytes
   hugetlb.32MB.max_usage_in_bytes
+  hugetlb.32MB.numa_stat
   hugetlb.32MB.usage_in_bytes
   hugetlb.32MB.failcnt
   hugetlb.32MB.rsvd.limit_in_bytes
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 4d8c27eca96b..356847f8f008 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2252,6 +2252,11 @@ HugeTLB Interface Files
 	are local to the cgroup i.e. not hierarchical. The file modified event
 	generated on this file reflects only the local events.

+  hugetlb.<hugepagesize>.numa_stat
+	Similar to memory.numa_stat, it shows the numa information of the
+        hugetlb pages of <hugepagesize> in this cgroup.  Only active in
+        use hugetlb pages are included.  The per-node values are in bytes.
+
 Misc
 ----

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1faebe1cd0ed..0445faaa636e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -613,8 +613,8 @@ struct hstate {
 #endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
-	struct cftype cgroup_files_dfl[7];
-	struct cftype cgroup_files_legacy[9];
+	struct cftype cgroup_files_dfl[8];
+	struct cftype cgroup_files_legacy[10];
 #endif
 	char name[HSTATE_NAME_LEN];
 };
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.=
h
index c137396129db..0f6cd28558d7 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -36,6 +36,11 @@ enum hugetlb_memory_event {
 	HUGETLB_NR_MEMORY_EVENTS,
 };

+struct hugetlb_cgroup_per_node {
+	/* hugetlb usage in pages over all hstates. */
+	unsigned long usage[HUGE_MAX_HSTATE];
+};
+
 struct hugetlb_cgroup {
 	struct cgroup_subsys_state css;

@@ -57,6 +62,8 @@ struct hugetlb_cgroup {

 	/* Handle for "hugetlb.events.local" */
 	struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
+
+	struct hugetlb_cgroup_per_node *nodeinfo[];
 };

 static inline struct hugetlb_cgroup *
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 5383023d0cca..9d7fcd21a6c0 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -126,29 +126,58 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup=
 *h_cgroup,
 	}
 }

+static void hugetlb_cgroup_free(struct hugetlb_cgroup *h_cgroup)
+{
+	int node;
+
+	for_each_node(node)
+		kfree(h_cgroup->nodeinfo[node]);
+	kfree(h_cgroup);
+}
+
 static struct cgroup_subsys_state *
 hugetlb_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct hugetlb_cgroup *parent_h_cgroup =3D hugetlb_cgroup_from_css(parent=
_css);
 	struct hugetlb_cgroup *h_cgroup;
+	int node;
+
+	h_cgroup =3D kzalloc(struct_size(h_cgroup, nodeinfo, nr_node_ids),
+			   GFP_KERNEL);

-	h_cgroup =3D kzalloc(sizeof(*h_cgroup), GFP_KERNEL);
 	if (!h_cgroup)
 		return ERR_PTR(-ENOMEM);

 	if (!parent_h_cgroup)
 		root_h_cgroup =3D h_cgroup;

+	/*
+	 * TODO: this routine can waste much memory for nodes which will
+	 * never be onlined. It's better to use memory hotplug callback
+	 * function.
+	 */
+	for_each_node(node) {
+		/* Set node_to_alloc to -1 for offline nodes. */
+		int node_to_alloc =3D
+			node_state(node, N_NORMAL_MEMORY) ? node : -1;
+		h_cgroup->nodeinfo[node] =3D
+			kzalloc_node(sizeof(struct hugetlb_cgroup_per_node),
+				     GFP_KERNEL, node_to_alloc);
+		if (!h_cgroup->nodeinfo[node])
+			goto fail_alloc_nodeinfo;
+	}
+
 	hugetlb_cgroup_init(h_cgroup, parent_h_cgroup);
 	return &h_cgroup->css;
+
+fail_alloc_nodeinfo:
+	hugetlb_cgroup_free(h_cgroup);
+	return ERR_PTR(-ENOMEM);
 }

 static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
 {
-	struct hugetlb_cgroup *h_cgroup;
-
-	h_cgroup =3D hugetlb_cgroup_from_css(css);
-	kfree(h_cgroup);
+	hugetlb_cgroup_free(hugetlb_cgroup_from_css(css));
 }

 /*
@@ -288,11 +317,21 @@ static void __hugetlb_cgroup_commit_charge(int idx, u=
nsigned long nr_pages,
 					   struct hugetlb_cgroup *h_cg,
 					   struct page *page, bool rsvd)
 {
+	unsigned long *usage;
+
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;

 	__set_hugetlb_cgroup(page, h_cg, rsvd);
-	return;
+	if (!rsvd) {
+		usage =3D &h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
+		/*
+		 * This write is not atomic due to fetching *usage and writing
+		 * to it, but that's fine because we call this with
+		 * hugetlb_lock held anyway.
+		 */
+		WRITE_ONCE(*usage, *usage + nr_pages);
+	}
 }

 void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
@@ -316,6 +355,7 @@ static void __hugetlb_cgroup_uncharge_page(int idx, uns=
igned long nr_pages,
 					   struct page *page, bool rsvd)
 {
 	struct hugetlb_cgroup *h_cg;
+	unsigned long *usage;

 	if (hugetlb_cgroup_disabled())
 		return;
@@ -331,8 +371,15 @@ static void __hugetlb_cgroup_uncharge_page(int idx, un=
signed long nr_pages,

 	if (rsvd)
 		css_put(&h_cg->css);
-
-	return;
+	else {
+		usage =3D &h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
+		/*
+		 * This write is not atomic due to fetching *usage and writing
+		 * to it, but that's fine because we call this with
+		 * hugetlb_lock held anyway.
+		 */
+		WRITE_ONCE(*usage, *usage - nr_pages);
+	}
 }

 void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
@@ -421,6 +468,59 @@ enum {
 	RES_RSVD_FAILCNT,
 };

+static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy=
)
+{
+	int nid;
+	struct cftype *cft =3D seq_cft(seq);
+	int idx =3D MEMFILE_IDX(cft->private);
+	bool legacy =3D MEMFILE_ATTR(cft->private);
+	struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_css(seq));
+	struct cgroup_subsys_state *css;
+	unsigned long usage;
+
+	if (legacy) {
+		/* Add up usage across all nodes for the non-hierarchical total. */
+		usage =3D 0;
+		for_each_node_state(nid, N_MEMORY)
+			usage +=3D READ_ONCE(h_cg->nodeinfo[nid]->usage[idx]);
+		seq_printf(seq, "total=3D%lu", usage * PAGE_SIZE);
+
+		/* Simply print the per-node usage for the non-hierarchical total. */
+		for_each_node_state(nid, N_MEMORY)
+			seq_printf(seq, " N%d=3D%lu", nid,
+				   READ_ONCE(h_cg->nodeinfo[nid]->usage[idx]) *
+					   PAGE_SIZE);
+		seq_putc(seq, '\n');
+	}
+
+	/*
+	 * The hierarchical total is pretty much the value recorded by the
+	 * counter, so use that.
+	 */
+	seq_printf(seq, "%stotal=3D%lu", legacy ? "hierarichal_" : "",
+		   page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE);
+
+	/*
+	 * For each node, transverse the css tree to obtain the hierarichal
+	 * node usage.
+	 */
+	for_each_node_state(nid, N_MEMORY) {
+		usage =3D 0;
+		rcu_read_lock();
+		css_for_each_descendant_pre(css, &h_cg->css) {
+			usage +=3D READ_ONCE(hugetlb_cgroup_from_css(css)
+						   ->nodeinfo[nid]
+						   ->usage[idx]);
+		}
+		rcu_read_unlock();
+		seq_printf(seq, " N%d=3D%lu", nid, usage * PAGE_SIZE);
+	}
+
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
 static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 				   struct cftype *cft)
 {
@@ -671,8 +771,14 @@ static void __init __hugetlb_cgroup_file_dfl_init(int =
idx)
 				    events_local_file[idx]);
 	cft->flags =3D CFTYPE_NOT_ON_ROOT;

-	/* NULL terminate the last cft */
+	/* Add the numa stat file */
 	cft =3D &h->cgroup_files_dfl[6];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
+	cft->seq_show =3D hugetlb_cgroup_read_numa_stat;
+	cft->flags =3D CFTYPE_NOT_ON_ROOT;
+
+	/* NULL terminate the last cft */
+	cft =3D &h->cgroup_files_dfl[7];
 	memset(cft, 0, sizeof(*cft));

 	WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
@@ -742,8 +848,14 @@ static void __init __hugetlb_cgroup_file_legacy_init(i=
nt idx)
 	cft->write =3D hugetlb_cgroup_reset;
 	cft->read_u64 =3D hugetlb_cgroup_read_u64;

+	/* Add the numa stat file */
+	cft =3D &h->cgroup_files_dfl[8];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
+	cft->private =3D MEMFILE_PRIVATE(idx, 1);
+	cft->seq_show =3D hugetlb_cgroup_read_numa_stat;
+
 	/* NULL terminate the last cft */
-	cft =3D &h->cgroup_files_legacy[8];
+	cft =3D &h->cgroup_files_legacy[9];
 	memset(cft, 0, sizeof(*cft));

 	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
--
2.34.0.rc2.393.gf8c9666880-goog
