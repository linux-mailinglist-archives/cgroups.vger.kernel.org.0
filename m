Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB610A4F3
	for <lists+cgroups@lfdr.de>; Tue, 26 Nov 2019 20:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfKZT4U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Nov 2019 14:56:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25855 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726036AbfKZT4U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Nov 2019 14:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574798178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XKszn4m78YkhgLWdA6/NpfrvaKDnj1PyuK3E1ikNQUg=;
        b=CV5hDmeZv7bBgEFgw8nP+wK4dGxuq6OqcJGgzzdrue9RfI15T5opBEdtpkDIqiriQ+p7mU
        R0a4BP1xKNiimO5lUHGWujeAE8TkO/wKN03mCxn81ytvxPdsAB2pTYyMJuEo49+89l+1Fc
        NleJvVAiPpQtJ9xH/b+Zepek/+8Rjl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-HXAOR-pqPJ6ySKwbKOToZg-1; Tue, 26 Nov 2019 14:56:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E75D380183D;
        Tue, 26 Nov 2019 19:56:10 +0000 (UTC)
Received: from helium.redhat.com (unknown [10.36.118.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C06A5600C8;
        Tue, 26 Nov 2019 19:56:08 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     cgroups@vger.kernel.org
Cc:     mike.kravetz@oracle.com, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, gscrivan@redhat.com, almasrymina@google.com
Subject: [PATCH v2] mm: hugetlb controller for cgroups v2
Date:   Tue, 26 Nov 2019 20:56:00 +0100
Message-Id: <20191126195600.1453143-1-gscrivan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HXAOR-pqPJ6ySKwbKOToZg-1
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

The differences with the legacy hierarchy are in the file names and
using the value "max" instead of "-1" to disable a limit.

The file .limit_in_bytes is renamed to .max.

The file .usage_in_bytes is renamed to .usage.

.failcnt is not provided as a single file anymore, but its value can
be read in the new flat-keyed file .events, through the "max" key.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
v2: dropped max_usage_in_bytes and renamed .stats::failcnt to .events::max

v1: https://www.spinics.net/lists/cgroups/msg23893.html

Documentation/admin-guide/cgroup-v2.rst |  24 ++++
 include/linux/hugetlb.h                 |   3 +-
 mm/hugetlb_cgroup.c                     | 140 ++++++++++++++++++++++--
 3 files changed, 156 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 5361ebec3361..5e08a202da2a 100644
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
@@ -2050,6 +2052,28 @@ RDMA Interface Files
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
=20
 Misc
 ----
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 53fc34f930d0..1c2bacbca044 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -340,7 +340,8 @@ struct hstate {
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
index 2ac38bdc18a1..5a6b381e9b92 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -283,10 +283,55 @@ static u64 hugetlb_cgroup_read_u64(struct cgroup_subs=
ys_state *css,
 =09}
 }
=20
+static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
+{
+=09int idx;
+=09u64 val;
+=09bool write_raw =3D false;
+=09struct cftype *cft =3D seq_cft(seq);
+=09unsigned long limit;
+=09struct page_counter *counter;
+=09struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_css(seq));
+
+=09idx =3D MEMFILE_IDX(cft->private);
+=09counter =3D &h_cg->hugepage[idx];
+
+=09switch (MEMFILE_ATTR(cft->private)) {
+=09case RES_USAGE:
+=09=09val =3D (u64)page_counter_read(counter);
+=09=09break;
+=09case RES_LIMIT:
+=09=09val =3D (u64)counter->max;
+=09=09break;
+=09case RES_MAX_USAGE:
+=09=09val =3D (u64)counter->watermark;
+=09=09break;
+=09case RES_FAILCNT:
+=09=09val =3D counter->failcnt;
+=09=09write_raw =3D true;
+=09=09break;
+=09default:
+=09=09BUG();
+=09}
+
+=09limit =3D round_down(PAGE_COUNTER_MAX,
+=09=09=09   1 << huge_page_order(&hstates[idx]));
+
+=09if (val =3D=3D limit && !write_raw)
+=09=09seq_puts(seq, "max\n");
+=09else if (write_raw)
+=09=09seq_printf(seq, "%llu\n", val);
+=09else
+=09=09seq_printf(seq, "%llu\n", val * PAGE_SIZE);
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
@@ -296,7 +341,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_=
file *of,
 =09=09return -EINVAL;
=20
 =09buf =3D strstrip(buf);
-=09ret =3D page_counter_memparse(buf, "-1", &nr_pages);
+=09ret =3D page_counter_memparse(buf, max, &nr_pages);
 =09if (ret)
 =09=09return ret;
=20
@@ -316,6 +361,18 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open=
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
@@ -350,7 +407,58 @@ static char *mem_fmt(char *buf, int size, unsigned lon=
g hsize)
 =09return buf;
 }
=20
-static void __init __hugetlb_cgroup_file_init(int idx)
+static int hugetlb_events_show(struct seq_file *seq, void *v)
+{
+=09struct page_counter *counter;
+=09struct cftype *cft =3D seq_cft(seq);
+=09struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_css(seq));
+
+=09counter =3D &h_cg->hugepage[MEMFILE_IDX(cft->private)];
+
+=09seq_printf(seq, "max %lu\n", counter->failcnt);
+
+=09return 0;
+}
+
+static void __init __hugetlb_cgroup_file_dfl_init(int idx)
+{
+=09char buf[32];
+=09struct cftype *cft;
+=09struct hstate *h =3D &hstates[idx];
+
+=09/* format the size */
+=09mem_fmt(buf, 32, huge_page_size(h));
+
+=09/* Add the limit file */
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
+=09cft->seq_show =3D hugetlb_events_show;
+=09cft->flags =3D CFTYPE_NOT_ON_ROOT;
+
+=09/* NULL terminate the last cft */
+=09cft =3D &h->cgroup_files_dfl[3];
+=09memset(cft, 0, sizeof(*cft));
+
+=09WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
+=09=09=09=09       h->cgroup_files_dfl));
+}
+
+static void __init __hugetlb_cgroup_file_legacy_init(int idx)
 {
 =09char buf[32];
 =09struct cftype *cft;
@@ -360,38 +468,44 @@ static void __init __hugetlb_cgroup_file_init(int idx=
)
 =09mem_fmt(buf, 32, huge_page_size(h));
=20
 =09/* Add the limit file */
-=09cft =3D &h->cgroup_files[0];
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
@@ -433,8 +547,14 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, str=
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

