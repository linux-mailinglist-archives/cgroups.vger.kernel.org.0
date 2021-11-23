Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6473459902
	for <lists+cgroups@lfdr.de>; Tue, 23 Nov 2021 01:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhKWANb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Nov 2021 19:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhKWANb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Nov 2021 19:13:31 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F141C061714
        for <cgroups@vger.kernel.org>; Mon, 22 Nov 2021 16:10:24 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id e10-20020a17090301ca00b00141fbe2569dso8295341plh.14
        for <cgroups@vger.kernel.org>; Mon, 22 Nov 2021 16:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Wu75eSutr9igDdFIf9wsJ9DAcqgiM6dK+7xbG/f7f3o=;
        b=YpthjRBthKdZ/hw9GWXztt64QhE1RVwXFFTbwTBO72XDL/amT7FIG5iHCppfY+CDCS
         AgkYgrJifoYBFPIXa8SvWy47KCDmdWPuNy/Xu1afrjWlTKL8svEe2Ci6pNrBd4WFSU1n
         t7jqVXbyXKDnetx0pVroiwT5W2Jdto7zs2XHTepd6GXD6y0oQ5D9AVlrjx/RnosvoRSS
         dBhPuNIW0PZEuhfcmOzhQJxXCiXA21yvddvqpPH3urMTcycI6V3WDdhDlTQIgdBlK7ZA
         H/9SFCGgJXtjfYkzMtciGj9MKFqGMtDuKfFBPt0yMEhx0LOT/jy85nLfYj5AWb3LeofJ
         mI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Wu75eSutr9igDdFIf9wsJ9DAcqgiM6dK+7xbG/f7f3o=;
        b=Rb9iZwU6Tduxb8ILpCoc13gQRsUZdcnX+2+yoL9Q2MoV7K+kOjtCmSD+jjDrab/8st
         KFk96btQMTKEnXjVAB7GNEsCzHa+Cn8+wNvKdhoeIrFQSTIJnrVgEQ3Rr8WdJBHzKC6m
         6de5KcHZSZ5cAat6ag6e87mseq3dUkKUxK5AtG7X2rOCqFVlxqzDe2YN7N/M0LPAekgT
         dV54zb3RCZsaFB6IPhAVypSN3pkxmDAxq+5pPmZitKpzkm4Q0ASsfTQsLD73POV55b9U
         ifg0152nZGl+R58R1uvMO06wH6ZzElX69FoQ5BKhp9UdHlAXq2BH4OXTXGnXf+Cc4cBB
         qs3w==
X-Gm-Message-State: AOAM532ecLFucTxmZr9zCpzn+7JrYPRr9FJLLqQjTdmTyvly7v4Z/Njc
        wBPSS2PUMyZy5dJWzrP+QapOpfrM/qtwf+oUXw==
X-Google-Smtp-Source: ABdhPJwV02gCLlBEu5NSBAnTh2Cl/G2Agx5Bgsa4TJQZJxq5Cok1r3EkReYO9l4GkL8w5JWGrFa1joN/+g765+QN2A==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:2c06:26c4:bf33:6d15])
 (user=almasrymina job=sendgmr) by 2002:a05:6a00:2181:b0:44d:c18d:7af9 with
 SMTP id h1-20020a056a00218100b0044dc18d7af9mr1031037pfi.16.1637626223722;
 Mon, 22 Nov 2021 16:10:23 -0800 (PST)
Date:   Mon, 22 Nov 2021 16:10:19 -0800
Message-Id: <20211123001020.4083653-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v8] hugetlb: Add hugetlb.*.numa_stat file
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

Changes in v8:
- Do not use unsigned long *usage to WRITE_ONCE() new usage values.

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
 mm/hugetlb_cgroup.c                           | 133 ++++++++++++++++--
 5 files changed, 141 insertions(+), 12 deletions(-)

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
index 5383023d0cca..f590e6e14fe6 100644
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
@@ -292,7 +321,17 @@ static void __hugetlb_cgroup_commit_charge(int idx, un=
signed long nr_pages,
 		return;

 	__set_hugetlb_cgroup(page, h_cg, rsvd);
-	return;
+	if (!rsvd) {
+		unsigned long usage =3D
+			h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
+		/*
+		 * This write is not atomic due to fetching usage and writing
+		 * to it, but that's fine because we call this with
+		 * hugetlb_lock held anyway.
+		 */
+		WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx],
+			   usage + nr_pages);
+	}
 }

 void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
@@ -331,8 +370,17 @@ static void __hugetlb_cgroup_uncharge_page(int idx, un=
signed long nr_pages,

 	if (rsvd)
 		css_put(&h_cg->css);
-
-	return;
+	else {
+		unsigned long usage =3D
+			h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
+		/*
+		 * This write is not atomic due to fetching usage and writing
+		 * to it, but that's fine because we call this with
+		 * hugetlb_lock held anyway.
+		 */
+		WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx],
+			   usage - nr_pages);
+	}
 }

 void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
@@ -421,6 +469,59 @@ enum {
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
@@ -671,8 +772,14 @@ static void __init __hugetlb_cgroup_file_dfl_init(int =
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
@@ -742,8 +849,14 @@ static void __init __hugetlb_cgroup_file_legacy_init(i=
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
