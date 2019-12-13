Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6535811E1EC
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2019 11:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfLMK22 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Dec 2019 05:28:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34361 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725793AbfLMK22 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Dec 2019 05:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576232905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8bEmPdGfyuP5ONFLMQ/uHt7JDK6XfGr1ZIGIZZdyWjE=;
        b=CypW3fNDvC+I9eSem1paC/2EkzP7GqeKl0TcFcZaFQJXaiGyrXVMMIg4ZnSkSAS+d69xob
        rr+7ptsY+DhrI3JG4ALsCPbYqVL6m5U3rkS5IvJ3+5Cq94qJGqNmrqebFZcndKYplRdcc5
        9Zs1lD4O0+xO3WBuE62/h3NnEH7ToFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-v_q3xmlrOGqyAqXmt86KUg-1; Fri, 13 Dec 2019 05:28:22 -0500
X-MC-Unique: v_q3xmlrOGqyAqXmt86KUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A6E01800D63;
        Fri, 13 Dec 2019 10:28:20 +0000 (UTC)
Received: from helium.redhat.com (ovpn-116-111.ams2.redhat.com [10.36.116.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A24060148;
        Fri, 13 Dec 2019 10:28:17 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     cgroups@vger.kernel.org
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com, tj@kernel.org,
        mkoutny@suse.com, lizefan@huawei.com, hannes@cmpxchg.org,
        gscrivan@redhat.com, almasrymina@google.com
Subject: [PATCH v5] mm: hugetlb controller for cgroups v2
Date:   Fri, 13 Dec 2019 11:28:08 +0100
Message-Id: <20191213102808.295966-1-gscrivan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In the effort of supporting cgroups v2 into Kubernetes, I stumped on
the lack of the hugetlb controller.

When the controller is enabled, it exposes four new files for each
hugetlb size on non-root cgroups:

- hugetlb.<hugepagesize>.current
- hugetlb.<hugepagesize>.max
- hugetlb.<hugepagesize>.events
- hugetlb.<hugepagesize>.events.local

The differences with the legacy hierarchy are in the file names and
using the value "max" instead of "-1" to disable a limit.

The file .limit_in_bytes is renamed to .max.

The file .usage_in_bytes is renamed to .current.

.failcnt is not provided as a single file anymore, but its value can
be read through the new flat-keyed files .events and .events.local,
through the "max" key.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v5:
  - fix some nits in the commit message

v4: https://www.spinics.net/lists/cgroups/msg23948.html
  - fix .events semantic to notify all the events in the sub directories
  - add .events.local file to record events only in the current cgroup

v3: https://www.spinics.net/lists/cgroups/msg23922.html
  - simplify hugetlb_cgroup_read_u64_max and drop dead code
  - notify changes to the .events file

v2: https://www.spinics.net/lists/cgroups/msg23917.html
  - dropped max_usage_in_bytes and renamed .stats::failcnt to .events::ma=
x

v1: https://www.spinics.net/lists/cgroups/msg23893.html

Documentation/admin-guide/cgroup-v2.rst |  29 ++++
 include/linux/hugetlb.h                 |   3 +-
 mm/hugetlb_cgroup.c                     | 194 ++++++++++++++++++++++--
 3 files changed, 214 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
index 0636bcb60b5a..3f801461f0f3 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -61,6 +61,8 @@ v1 is available under Documentation/admin-guide/cgroup-=
v1/.
      5-6. Device
      5-7. RDMA
        5-7-1. RDMA Interface Files
+     5-8. HugeTLB
+       5.8-1. HugeTLB Interface Files
      5-8. Misc
        5-8-1. perf_event
      5-N. Non-normative information
@@ -2056,6 +2058,33 @@ RDMA Interface Files
 	  mlx4_0 hca_handle=3D1 hca_object=3D20
 	  ocrdma1 hca_handle=3D1 hca_object=3D23
=20
+HugeTLB
+-------
+
+The HugeTLB controller allows to limit the HugeTLB usage per control gro=
up and
+enforces the controller limit during page fault.
+
+HugeTLB Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~
+
+  hugetlb.<hugepagesize>.current
+	Show current usage for "hugepagesize" hugetlb.  It exists for all
+	the cgroup except root.
+
+  hugetlb.<hugepagesize>.max
+	Set/show the hard limit of "hugepagesize" hugetlb usage.
+	The default value is "max".  It exists for all the cgroup except root.
+
+  hugetlb.<hugepagesize>.events
+	A read-only flat-keyed file which exists on non-root cgroups.
+
+	  max
+		The number of allocation failure due to HugeTLB limit
+
+  hugetlb.<hugepagesize>.events.local
+	Similar to hugetlb.<hugepagesize>.events but the fields in the file
+	are local to the cgroup i.e. not hierarchical. The file modified event
+	generated on this file reflects only the local events.
=20
 Misc
 ----
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 31d4920994b9..1e897e4168ac 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -432,7 +432,8 @@ struct hstate {
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
-	struct cftype cgroup_files[5];
+	struct cftype cgroup_files_dfl[5];
+	struct cftype cgroup_files_legacy[5];
 #endif
 	char name[HSTATE_NAME_LEN];
 };
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 2ac38bdc18a1..0a46cb2d18ff 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -3,6 +3,10 @@
  * Copyright IBM Corporation, 2012
  * Author Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
  *
+ * Cgroup v2
+ * Copyright (C) 2019 Red Hat, Inc.
+ * Author: Giuseppe Scrivano <gscrivan@redhat.com>
+ *
  * This program is free software; you can redistribute it and/or modify =
it
  * under the terms of version 2.1 of the GNU Lesser General Public Licen=
se
  * as published by the Free Software Foundation.
@@ -19,12 +23,27 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>
=20
+enum hugetlb_memory_event {
+	HUGETLB_MAX,
+	HUGETLB_NR_MEMORY_EVENTS,
+};
+
 struct hugetlb_cgroup {
 	struct cgroup_subsys_state css;
+
 	/*
 	 * the counter to account for hugepages from hugetlb.
 	 */
 	struct page_counter hugepage[HUGE_MAX_HSTATE];
+
+	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
+	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
+
+	/* Handle for "hugetlb.events" */
+	struct cgroup_file events_file[HUGE_MAX_HSTATE];
+
+	/* Handle for "hugetlb.events.local" */
+	struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
 };
=20
 #define MEMFILE_PRIVATE(x, val)	(((x) << 16) | (val))
@@ -178,6 +197,19 @@ static void hugetlb_cgroup_css_offline(struct cgroup=
_subsys_state *css)
 	} while (hugetlb_cgroup_have_usage(h_cg));
 }
=20
+static inline void hugetlb_event(struct hugetlb_cgroup *hugetlb, int idx=
,
+				 enum hugetlb_memory_event event)
+{
+	atomic_long_inc(&hugetlb->events_local[idx][event]);
+	cgroup_file_notify(&hugetlb->events_local_file[idx]);
+
+	do {
+		atomic_long_inc(&hugetlb->events[idx][event]);
+		cgroup_file_notify(&hugetlb->events_file[idx]);
+	} while ((hugetlb =3D parent_hugetlb_cgroup(hugetlb)) &&
+		 !hugetlb_cgroup_is_root(hugetlb));
+}
+
 int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 				 struct hugetlb_cgroup **ptr)
 {
@@ -202,8 +234,11 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned l=
ong nr_pages,
 	}
 	rcu_read_unlock();
=20
-	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages, &counter))
+	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages,
+				     &counter)) {
 		ret =3D -ENOMEM;
+		hugetlb_event(h_cg, idx, HUGETLB_MAX);
+	}
 	css_put(&h_cg->css);
 done:
 	*ptr =3D h_cg;
@@ -283,10 +318,45 @@ static u64 hugetlb_cgroup_read_u64(struct cgroup_su=
bsys_state *css,
 	}
 }
=20
+static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
+{
+	int idx;
+	u64 val;
+	struct cftype *cft =3D seq_cft(seq);
+	unsigned long limit;
+	struct page_counter *counter;
+	struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_css(seq));
+
+	idx =3D MEMFILE_IDX(cft->private);
+	counter =3D &h_cg->hugepage[idx];
+
+	limit =3D round_down(PAGE_COUNTER_MAX,
+			   1 << huge_page_order(&hstates[idx]));
+
+	switch (MEMFILE_ATTR(cft->private)) {
+	case RES_USAGE:
+		val =3D (u64)page_counter_read(counter);
+		seq_printf(seq, "%llu\n", val * PAGE_SIZE);
+		break;
+	case RES_LIMIT:
+		val =3D (u64)counter->max;
+		if (val =3D=3D limit)
+			seq_puts(seq, "max\n");
+		else
+			seq_printf(seq, "%llu\n", val * PAGE_SIZE);
+		break;
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
 static DEFINE_MUTEX(hugetlb_limit_mutex);
=20
 static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
-				    char *buf, size_t nbytes, loff_t off)
+				    char *buf, size_t nbytes, loff_t off,
+				    const char *max)
 {
 	int ret, idx;
 	unsigned long nr_pages;
@@ -296,7 +366,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_ope=
n_file *of,
 		return -EINVAL;
=20
 	buf =3D strstrip(buf);
-	ret =3D page_counter_memparse(buf, "-1", &nr_pages);
+	ret =3D page_counter_memparse(buf, max, &nr_pages);
 	if (ret)
 		return ret;
=20
@@ -316,6 +386,18 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_op=
en_file *of,
 	return ret ?: nbytes;
 }
=20
+static ssize_t hugetlb_cgroup_write_legacy(struct kernfs_open_file *of,
+					   char *buf, size_t nbytes, loff_t off)
+{
+	return hugetlb_cgroup_write(of, buf, nbytes, off, "-1");
+}
+
+static ssize_t hugetlb_cgroup_write_dfl(struct kernfs_open_file *of,
+					char *buf, size_t nbytes, loff_t off)
+{
+	return hugetlb_cgroup_write(of, buf, nbytes, off, "max");
+}
+
 static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
@@ -350,7 +432,36 @@ static char *mem_fmt(char *buf, int size, unsigned l=
ong hsize)
 	return buf;
 }
=20
-static void __init __hugetlb_cgroup_file_init(int idx)
+static int __hugetlb_events_show(struct seq_file *seq, bool local)
+{
+	int idx;
+	long max;
+	struct cftype *cft =3D seq_cft(seq);
+	struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_css(seq));
+
+	idx =3D MEMFILE_IDX(cft->private);
+
+	if (local)
+		max =3D atomic_long_read(&h_cg->events_local[idx][HUGETLB_MAX]);
+	else
+		max =3D atomic_long_read(&h_cg->events[idx][HUGETLB_MAX]);
+
+	seq_printf(seq, "max %lu\n", max);
+
+	return 0;
+}
+
+static int hugetlb_events_show(struct seq_file *seq, void *v)
+{
+	return __hugetlb_events_show(seq, false);
+}
+
+static int hugetlb_events_local_show(struct seq_file *seq, void *v)
+{
+	return __hugetlb_events_show(seq, true);
+}
+
+static void __init __hugetlb_cgroup_file_dfl_init(int idx)
 {
 	char buf[32];
 	struct cftype *cft;
@@ -360,38 +471,93 @@ static void __init __hugetlb_cgroup_file_init(int i=
dx)
 	mem_fmt(buf, 32, huge_page_size(h));
=20
 	/* Add the limit file */
-	cft =3D &h->cgroup_files[0];
+	cft =3D &h->cgroup_files_dfl[0];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max", buf);
+	cft->private =3D MEMFILE_PRIVATE(idx, RES_LIMIT);
+	cft->seq_show =3D hugetlb_cgroup_read_u64_max;
+	cft->write =3D hugetlb_cgroup_write_dfl;
+	cft->flags =3D CFTYPE_NOT_ON_ROOT;
+
+	/* Add the current usage file */
+	cft =3D &h->cgroup_files_dfl[1];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.current", buf);
+	cft->private =3D MEMFILE_PRIVATE(idx, RES_USAGE);
+	cft->seq_show =3D hugetlb_cgroup_read_u64_max;
+	cft->flags =3D CFTYPE_NOT_ON_ROOT;
+
+	/* Add the events file */
+	cft =3D &h->cgroup_files_dfl[2];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
+	cft->private =3D MEMFILE_PRIVATE(idx, 0);
+	cft->seq_show =3D hugetlb_events_show;
+	cft->file_offset =3D offsetof(struct hugetlb_cgroup, events_file[idx]),
+	cft->flags =3D CFTYPE_NOT_ON_ROOT;
+
+	/* Add the events.local file */
+	cft =3D &h->cgroup_files_dfl[3];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events.local", buf);
+	cft->private =3D MEMFILE_PRIVATE(idx, 0);
+	cft->seq_show =3D hugetlb_events_local_show;
+	cft->file_offset =3D offsetof(struct hugetlb_cgroup,
+				    events_local_file[idx]),
+	cft->flags =3D CFTYPE_NOT_ON_ROOT;
+
+	/* NULL terminate the last cft */
+	cft =3D &h->cgroup_files_dfl[4];
+	memset(cft, 0, sizeof(*cft));
+
+	WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
+				       h->cgroup_files_dfl));
+}
+
+static void __init __hugetlb_cgroup_file_legacy_init(int idx)
+{
+	char buf[32];
+	struct cftype *cft;
+	struct hstate *h =3D &hstates[idx];
+
+	/* format the size */
+	mem_fmt(buf, 32, huge_page_size(h));
+
+	/* Add the limit file */
+	cft =3D &h->cgroup_files_legacy[0];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.limit_in_bytes", buf);
 	cft->private =3D MEMFILE_PRIVATE(idx, RES_LIMIT);
 	cft->read_u64 =3D hugetlb_cgroup_read_u64;
-	cft->write =3D hugetlb_cgroup_write;
+	cft->write =3D hugetlb_cgroup_write_legacy;
=20
 	/* Add the usage file */
-	cft =3D &h->cgroup_files[1];
+	cft =3D &h->cgroup_files_legacy[1];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.usage_in_bytes", buf);
 	cft->private =3D MEMFILE_PRIVATE(idx, RES_USAGE);
 	cft->read_u64 =3D hugetlb_cgroup_read_u64;
=20
 	/* Add the MAX usage file */
-	cft =3D &h->cgroup_files[2];
+	cft =3D &h->cgroup_files_legacy[2];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max_usage_in_bytes", buf);
 	cft->private =3D MEMFILE_PRIVATE(idx, RES_MAX_USAGE);
 	cft->write =3D hugetlb_cgroup_reset;
 	cft->read_u64 =3D hugetlb_cgroup_read_u64;
=20
 	/* Add the failcntfile */
-	cft =3D &h->cgroup_files[3];
+	cft =3D &h->cgroup_files_legacy[3];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
 	cft->private  =3D MEMFILE_PRIVATE(idx, RES_FAILCNT);
 	cft->write =3D hugetlb_cgroup_reset;
 	cft->read_u64 =3D hugetlb_cgroup_read_u64;
=20
 	/* NULL terminate the last cft */
-	cft =3D &h->cgroup_files[4];
+	cft =3D &h->cgroup_files_legacy[4];
 	memset(cft, 0, sizeof(*cft));
=20
 	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
-					  h->cgroup_files));
+					  h->cgroup_files_legacy));
+}
+
+static void __init __hugetlb_cgroup_file_init(int idx)
+{
+	__hugetlb_cgroup_file_dfl_init(idx);
+	__hugetlb_cgroup_file_legacy_init(idx);
 }
=20
 void __init hugetlb_cgroup_file_init(void)
@@ -433,8 +599,14 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, s=
truct page *newhpage)
 	return;
 }
=20
+static struct cftype hugetlb_files[] =3D {
+	{} /* terminate */
+};
+
 struct cgroup_subsys hugetlb_cgrp_subsys =3D {
 	.css_alloc	=3D hugetlb_cgroup_css_alloc,
 	.css_offline	=3D hugetlb_cgroup_css_offline,
 	.css_free	=3D hugetlb_cgroup_css_free,
+	.dfl_cftypes	=3D hugetlb_files,
+	.legacy_cftypes	=3D hugetlb_files,
 };
--=20
2.23.0

