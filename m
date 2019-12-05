Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2011404D
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2019 12:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfLELrz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Dec 2019 06:47:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21890 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729099AbfLELrz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Dec 2019 06:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575546473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=P17d4dfyUKSiPqNIIcb24EAHc4CxaqXdrPU59huJIaM=;
        b=ZuP32Fz5iQ/2SIMYl/Fjv4n5hRgodHwjZ4L2RiVZnkTtma1xCHMH4uJIxbtBBPaCCI7tfa
        RpLZwDG6RuxKUMFAZpe0rmT5gQtGi049+5Sl+vzGJp0bYnWmEvJtkU2DOaWIKw8tkiT5IQ
        mhVCN40kXY3ytEUzwECIdHdG9E5ItL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-r0ivcwmWOkejI_dKMPKR9w-1; Thu, 05 Dec 2019 06:47:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E61F5800D54;
        Thu,  5 Dec 2019 11:47:48 +0000 (UTC)
Received: from helium.redhat.com (unknown [10.36.118.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9029F60126;
        Thu,  5 Dec 2019 11:47:46 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     cgroups@vger.kernel.org
Cc:     mike.kravetz@oracle.com, tj@kernel.org, mkoutny@suse.com,
        lizefan@huawei.com, hannes@cmpxchg.org, gscrivan@redhat.com,
        almasrymina@google.com
Subject: [PATCH v4] mm: hugetlb controller for cgroups v2
Date:   Thu,  5 Dec 2019 12:47:39 +0100
Message-Id: <20191205114739.12294-1-gscrivan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: r0ivcwmWOkejI_dKMPKR9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In the effort of supporting cgroups v2 into Kubernetes, I stumped on
the lack of the hugetlb controller.

When the controller is enabled, it exposes three new files for each
hugetlb size on non-root cgroups:

- hugetlb.<hugepagesize>.current
- hugetlb.<hugepagesize>.max
- hugetlb.<hugepagesize>.events
- hugetlb.<hugepagesize>.events.local

The differences with the legacy hierarchy are in the file names and
using the value "max" instead of "-1" to disable a limit.

The file .limit_in_bytes is renamed to .max.

The file .usage_in_bytes is renamed to .usage.

.failcnt is not provided as a single file anymore, but its value can
be read through the new flat-keyed files .events and .events.local,
through the "max" key.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
v4:
  - fix .events file to record and notify all the events in the sub
    directories
  - add .events.local file to record events only in the current cgroup

v3: https://www.spinics.net/lists/cgroups/msg23922.html
  - simplify hugetlb_cgroup_read_u64_max and drop dead code
  - notify changes to the .events file

v2: https://www.spinics.net/lists/cgroups/msg23917.html
  - dropped max_usage_in_bytes and renamed .stats::failcnt to .events::max

v1: https://www.spinics.net/lists/cgroups/msg23893.html

Documentation/admin-guide/cgroup-v2.rst |  29 ++++
 include/linux/hugetlb.h                 |   3 +-
 mm/hugetlb_cgroup.c                     | 194 ++++++++++++++++++++++--
 3 files changed, 214 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 0636bcb60b5a..3f801461f0f3 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -61,6 +61,8 @@ v1 is available under Documentation/admin-guide/cgroup-v1=
/.
      5-6. Device
      5-7. RDMA
        5-7-1. RDMA Interface Files
+     5-8. HugeTLB
+       5.8-1. HugeTLB Interface Files
      5-8. Misc
        5-8-1. perf_event
      5-N. Non-normative information
@@ -2056,6 +2058,33 @@ RDMA Interface Files
 =09  mlx4_0 hca_handle=3D1 hca_object=3D20
 =09  ocrdma1 hca_handle=3D1 hca_object=3D23
=20
+HugeTLB
+-------
+
+The HugeTLB controller allows to limit the HugeTLB usage per control group=
 and
+enforces the controller limit during page fault.
+
+HugeTLB Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~
+
+  hugetlb.<hugepagesize>.current
+=09Show current usage for "hugepagesize" hugetlb.  It exists for all
+=09the cgroup except root.
+
+  hugetlb.<hugepagesize>.max
+=09Set/show the hard limit of "hugepagesize" hugetlb usage.
+=09The default value is "max".  It exists for all the cgroup except root.
+
+  hugetlb.<hugepagesize>.events
+=09A read-only flat-keyed file which exists on non-root cgroups.
+
+=09  max
+=09=09The number of allocation failure due to HugeTLB limit
+
+  hugetlb.<hugepagesize>.events.local
+=09Similar to hugetlb.<hugepagesize>.events but the fields in the file
+=09are local to the cgroup i.e. not hierarchical. The file modified event
+=09generated on this file reflects only the local events.
=20
 Misc
 ----
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 31d4920994b9..1e897e4168ac 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -432,7 +432,8 @@ struct hstate {
 =09unsigned int surplus_huge_pages_node[MAX_NUMNODES];
 #ifdef CONFIG_CGROUP_HUGETLB
 =09/* cgroup control files */
-=09struct cftype cgroup_files[5];
+=09struct cftype cgroup_files_dfl[5];
+=09struct cftype cgroup_files_legacy[5];
 #endif
 =09char name[HSTATE_NAME_LEN];
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
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2.1 of the GNU Lesser General Public License
  * as published by the Free Software Foundation.
@@ -19,12 +23,27 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>
=20
+enum hugetlb_memory_event {
+=09HUGETLB_MAX,
+=09HUGETLB_NR_MEMORY_EVENTS,
+};
+
 struct hugetlb_cgroup {
 =09struct cgroup_subsys_state css;
+
 =09/*
 =09 * the counter to account for hugepages from hugetlb.
 =09 */
 =09struct page_counter hugepage[HUGE_MAX_HSTATE];
+
+=09atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
+=09atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
+
+=09/* Handle for "hugetlb.events" */
+=09struct cgroup_file events_file[HUGE_MAX_HSTATE];
+
+=09/* Handle for "hugetlb.events.local" */
+=09struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
 };
=20
 #define MEMFILE_PRIVATE(x, val)=09(((x) << 16) | (val))
@@ -178,6 +197,19 @@ static void hugetlb_cgroup_css_offline(struct cgroup_s=
ubsys_state *css)
 =09} while (hugetlb_cgroup_have_usage(h_cg));
 }
=20
+static inline void hugetlb_event(struct hugetlb_cgroup *hugetlb, int idx,
+=09=09=09=09 enum hugetlb_memory_event event)
+{
+=09atomic_long_inc(&hugetlb->events_local[idx][event]);
+=09cgroup_file_notify(&hugetlb->events_local_file[idx]);
+
+=09do {
+=09=09atomic_long_inc(&hugetlb->events[idx][event]);
+=09=09cgroup_file_notify(&hugetlb->events_file[idx]);
+=09} while ((hugetlb =3D parent_hugetlb_cgroup(hugetlb)) &&
+=09=09 !hugetlb_cgroup_is_root(hugetlb));
+}
+
 int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 =09=09=09=09 struct hugetlb_cgroup **ptr)
 {
@@ -202,8 +234,11 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned lon=
g nr_pages,
 =09}
 =09rcu_read_unlock();
=20
-=09if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages, &counter))
+=09if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages,
+=09=09=09=09     &counter)) {
 =09=09ret =3D -ENOMEM;
+=09=09hugetlb_event(h_cg, idx, HUGETLB_MAX);
+=09}
 =09css_put(&h_cg->css);
 done:
 =09*ptr =3D h_cg;
@@ -283,10 +318,45 @@ static u64 hugetlb_cgroup_read_u64(struct cgroup_subs=
ys_state *css,
 =09}
 }
=20
+static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
+{
+=09int idx;
+=09u64 val;
+=09struct cftype *cft =3D seq_cft(seq);
+=09unsigned long limit;
+=09struct page_counter *counter;
+=09struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_css(seq));
+
+=09idx =3D MEMFILE_IDX(cft->private);
+=09counter =3D &h_cg->hugepage[idx];
+
+=09limit =3D round_down(PAGE_COUNTER_MAX,
+=09=09=09   1 << huge_page_order(&hstates[idx]));
+
+=09switch (MEMFILE_ATTR(cft->private)) {
+=09case RES_USAGE:
+=09=09val =3D (u64)page_counter_read(counter);
+=09=09seq_printf(seq, "%llu\n", val * PAGE_SIZE);
+=09=09break;
+=09case RES_LIMIT:
+=09=09val =3D (u64)counter->max;
+=09=09if (val =3D=3D limit)
+=09=09=09seq_puts(seq, "max\n");
+=09=09else
+=09=09=09seq_printf(seq, "%llu\n", val * PAGE_SIZE);
+=09=09break;
+=09default:
+=09=09BUG();
+=09}
+
+=09return 0;
+}
+
 static DEFINE_MUTEX(hugetlb_limit_mutex);
=20
 static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
-=09=09=09=09    char *buf, size_t nbytes, loff_t off)
+=09=09=09=09    char *buf, size_t nbytes, loff_t off,
+=09=09=09=09    const char *max)
 {
 =09int ret, idx;
 =09unsigned long nr_pages;
@@ -296,7 +366,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_=
file *of,
 =09=09return -EINVAL;
=20
 =09buf =3D strstrip(buf);
-=09ret =3D page_counter_memparse(buf, "-1", &nr_pages);
+=09ret =3D page_counter_memparse(buf, max, &nr_pages);
 =09if (ret)
 =09=09return ret;
=20
@@ -316,6 +386,18 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open=
_file *of,
 =09return ret ?: nbytes;
 }
=20
+static ssize_t hugetlb_cgroup_write_legacy(struct kernfs_open_file *of,
+=09=09=09=09=09   char *buf, size_t nbytes, loff_t off)
+{
+=09return hugetlb_cgroup_write(of, buf, nbytes, off, "-1");
+}
+
+static ssize_t hugetlb_cgroup_write_dfl(struct kernfs_open_file *of,
+=09=09=09=09=09char *buf, size_t nbytes, loff_t off)
+{
+=09return hugetlb_cgroup_write(of, buf, nbytes, off, "max");
+}
+
 static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 =09=09=09=09    char *buf, size_t nbytes, loff_t off)
 {
@@ -350,7 +432,36 @@ static char *mem_fmt(char *buf, int size, unsigned lon=
g hsize)
 =09return buf;
 }
=20
-static void __init __hugetlb_cgroup_file_init(int idx)
+static int __hugetlb_events_show(struct seq_file *seq, bool local)
+{
+=09int idx;
+=09long max;
+=09struct cftype *cft =3D seq_cft(seq);
+=09struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_css(seq));
+
+=09idx =3D MEMFILE_IDX(cft->private);
+
+=09if (local)
+=09=09max =3D atomic_long_read(&h_cg->events_local[idx][HUGETLB_MAX]);
+=09else
+=09=09max =3D atomic_long_read(&h_cg->events[idx][HUGETLB_MAX]);
+
+=09seq_printf(seq, "max %lu\n", max);
+
+=09return 0;
+}
+
+static int hugetlb_events_show(struct seq_file *seq, void *v)
+{
+=09return __hugetlb_events_show(seq, false);
+}
+
+static int hugetlb_events_local_show(struct seq_file *seq, void *v)
+{
+=09return __hugetlb_events_show(seq, true);
+}
+
+static void __init __hugetlb_cgroup_file_dfl_init(int idx)
 {
 =09char buf[32];
 =09struct cftype *cft;
@@ -360,38 +471,93 @@ static void __init __hugetlb_cgroup_file_init(int idx=
)
 =09mem_fmt(buf, 32, huge_page_size(h));
=20
 =09/* Add the limit file */
-=09cft =3D &h->cgroup_files[0];
+=09cft =3D &h->cgroup_files_dfl[0];
+=09snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max", buf);
+=09cft->private =3D MEMFILE_PRIVATE(idx, RES_LIMIT);
+=09cft->seq_show =3D hugetlb_cgroup_read_u64_max;
+=09cft->write =3D hugetlb_cgroup_write_dfl;
+=09cft->flags =3D CFTYPE_NOT_ON_ROOT;
+
+=09/* Add the current usage file */
+=09cft =3D &h->cgroup_files_dfl[1];
+=09snprintf(cft->name, MAX_CFTYPE_NAME, "%s.current", buf);
+=09cft->private =3D MEMFILE_PRIVATE(idx, RES_USAGE);
+=09cft->seq_show =3D hugetlb_cgroup_read_u64_max;
+=09cft->flags =3D CFTYPE_NOT_ON_ROOT;
+
+=09/* Add the events file */
+=09cft =3D &h->cgroup_files_dfl[2];
+=09snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
+=09cft->private =3D MEMFILE_PRIVATE(idx, 0);
+=09cft->seq_show =3D hugetlb_events_show;
+=09cft->file_offset =3D offsetof(struct hugetlb_cgroup, events_file[idx]),
+=09cft->flags =3D CFTYPE_NOT_ON_ROOT;
+
+=09/* Add the events.local file */
+=09cft =3D &h->cgroup_files_dfl[3];
+=09snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events.local", buf);
+=09cft->private =3D MEMFILE_PRIVATE(idx, 0);
+=09cft->seq_show =3D hugetlb_events_local_show;
+=09cft->file_offset =3D offsetof(struct hugetlb_cgroup,
+=09=09=09=09    events_local_file[idx]),
+=09cft->flags =3D CFTYPE_NOT_ON_ROOT;
+
+=09/* NULL terminate the last cft */
+=09cft =3D &h->cgroup_files_dfl[4];
+=09memset(cft, 0, sizeof(*cft));
+
+=09WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
+=09=09=09=09       h->cgroup_files_dfl));
+}
+
+static void __init __hugetlb_cgroup_file_legacy_init(int idx)
+{
+=09char buf[32];
+=09struct cftype *cft;
+=09struct hstate *h =3D &hstates[idx];
+
+=09/* format the size */
+=09mem_fmt(buf, 32, huge_page_size(h));
+
+=09/* Add the limit file */
+=09cft =3D &h->cgroup_files_legacy[0];
 =09snprintf(cft->name, MAX_CFTYPE_NAME, "%s.limit_in_bytes", buf);
 =09cft->private =3D MEMFILE_PRIVATE(idx, RES_LIMIT);
 =09cft->read_u64 =3D hugetlb_cgroup_read_u64;
-=09cft->write =3D hugetlb_cgroup_write;
+=09cft->write =3D hugetlb_cgroup_write_legacy;
=20
 =09/* Add the usage file */
-=09cft =3D &h->cgroup_files[1];
+=09cft =3D &h->cgroup_files_legacy[1];
 =09snprintf(cft->name, MAX_CFTYPE_NAME, "%s.usage_in_bytes", buf);
 =09cft->private =3D MEMFILE_PRIVATE(idx, RES_USAGE);
 =09cft->read_u64 =3D hugetlb_cgroup_read_u64;
=20
 =09/* Add the MAX usage file */
-=09cft =3D &h->cgroup_files[2];
+=09cft =3D &h->cgroup_files_legacy[2];
 =09snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max_usage_in_bytes", buf);
 =09cft->private =3D MEMFILE_PRIVATE(idx, RES_MAX_USAGE);
 =09cft->write =3D hugetlb_cgroup_reset;
 =09cft->read_u64 =3D hugetlb_cgroup_read_u64;
=20
 =09/* Add the failcntfile */
-=09cft =3D &h->cgroup_files[3];
+=09cft =3D &h->cgroup_files_legacy[3];
 =09snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
 =09cft->private  =3D MEMFILE_PRIVATE(idx, RES_FAILCNT);
 =09cft->write =3D hugetlb_cgroup_reset;
 =09cft->read_u64 =3D hugetlb_cgroup_read_u64;
=20
 =09/* NULL terminate the last cft */
-=09cft =3D &h->cgroup_files[4];
+=09cft =3D &h->cgroup_files_legacy[4];
 =09memset(cft, 0, sizeof(*cft));
=20
 =09WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
-=09=09=09=09=09  h->cgroup_files));
+=09=09=09=09=09  h->cgroup_files_legacy));
+}
+
+static void __init __hugetlb_cgroup_file_init(int idx)
+{
+=09__hugetlb_cgroup_file_dfl_init(idx);
+=09__hugetlb_cgroup_file_legacy_init(idx);
 }
=20
 void __init hugetlb_cgroup_file_init(void)
@@ -433,8 +599,14 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, str=
uct page *newhpage)
 =09return;
 }
=20
+static struct cftype hugetlb_files[] =3D {
+=09{} /* terminate */
+};
+
 struct cgroup_subsys hugetlb_cgrp_subsys =3D {
 =09.css_alloc=09=3D hugetlb_cgroup_css_alloc,
 =09.css_offline=09=3D hugetlb_cgroup_css_offline,
 =09.css_free=09=3D hugetlb_cgroup_css_free,
+=09.dfl_cftypes=09=3D hugetlb_files,
+=09.legacy_cftypes=09=3D hugetlb_files,
 };
--=20
2.23.0

