Return-Path: <cgroups+bounces-10800-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B41BE1462
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 04:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E3184EDCD9
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 02:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C86B661;
	Thu, 16 Oct 2025 02:32:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD03AC39
	for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581954; cv=none; b=ivq3Bv72u7v7WbHBCt/j8GCD7G1ktBwjSYS6g5wc7KxH2cuVM2KU758vtgg4I6NznKOo64Nvj0gzTAiLG93r0Bj1sR9zOzpzCiFormvapYtTWOcy2/tWVkOL61cMQULkUFIzfWls1JZTOnUuZdEymIrb1FLfA6eiQuUfjO/0tSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581954; c=relaxed/simple;
	bh=5OABNApQLgG0OfgF5OLZt1m/fwcCfif4EGykrPvSkaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4gJVnbL0vefAwi5QzI7YFu/v2tBRN8QIiDhY4RqUZErErzOTvI9xu7xuvWEOGsR0V9uMBqiSm2eVZnsqp7cdMxQCN7LDf5VDLEYeL0uZOuUjaU2XJh6MK4put/0s8WMrCSeKWtdJzF8ff5oDLxJnuZviAy08XkVvhjkIplr3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-fKZdYgjlPx26DTailx4iqQ-1; Wed,
 15 Oct 2025 22:32:26 -0400
X-MC-Unique: fKZdYgjlPx26DTailx4iqQ-1
X-Mimecast-MFC-AGG-ID: fKZdYgjlPx26DTailx4iqQ_1760581945
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86C5B1954224;
	Thu, 16 Oct 2025 02:32:24 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.64])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80D791800353;
	Thu, 16 Oct 2025 02:32:16 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org,
	tj@kernel.org,
	christian.koenig@amd.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Waiman Long <longman@redhat.com>,
	simona@ffwll.ch
Subject: [PATCH 01/16] mm: add gpu active/reclaim per-node stat counters (v2)
Date: Thu, 16 Oct 2025 12:31:29 +1000
Message-ID: <20251016023205.2303108-2-airlied@gmail.com>
In-Reply-To: <20251016023205.2303108-1-airlied@gmail.com>
References: <20251016023205.2303108-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kvXFGGftvFxGAI-k27Cvv0uxfuMh8VXcRPc09ANHskQ_1760581945
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Dave Airlie <airlied@redhat.com>

While discussing memcg intergration with gpu memory allocations,
it was pointed out that there was no numa/system counters for
GPU memory allocations.

With more integrated memory GPU server systems turning up, and
more requirements for memory tracking it seems we should start
closing the gap.

Add two counters to track GPU per-node system memory allocations.

The first is currently allocated to GPU objects, and the second
is for memory that is stored in GPU page pools that can be reclaimed,
by the shrinker.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>

---

v2: add more info to the documentation on this memory.

I'd like to get acks to merge this via the drm tree, if possible,

Dave.
---
 Documentation/filesystems/proc.rst | 8 ++++++++
 drivers/base/node.c                | 5 +++++
 fs/proc/meminfo.c                  | 6 ++++++
 include/linux/mmzone.h             | 2 ++
 mm/show_mem.c                      | 8 ++++++--
 mm/vmstat.c                        | 2 ++
 6 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems=
/proc.rst
index 0b86a8022fa1..76e358274692 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1088,6 +1088,8 @@ Example output. You may not have all of these fields.
     CmaFree:               0 kB
     Unaccepted:            0 kB
     Balloon:               0 kB
+    GPUActive:             0 kB
+    GPUReclaim:            0 kB
     HugePages_Total:       0
     HugePages_Free:        0
     HugePages_Rsvd:        0
@@ -1268,6 +1270,12 @@ Unaccepted
               Memory that has not been accepted by the guest
 Balloon
               Memory returned to Host by VM Balloon Drivers
+GPUActive
+              System memory allocated to active GPU objects
+GPUReclaim
+              System memory stored in GPU pools for reuse. This memory is =
not
+              counted in GPUActive. It is shrinker reclaimable memory kept=
 in a reuse
+              pool because it has non-standard page table attributes, like=
 WC or UC.
 HugePages_Total, HugePages_Free, HugePages_Rsvd, HugePages_Surp, Hugepages=
ize, Hugetlb
               See Documentation/admin-guide/mm/hugetlbpage.rst.
 DirectMap4k, DirectMap2M, DirectMap1G
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 83aeb0518e1d..c606b637f3f2 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -523,6 +523,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 #ifdef CONFIG_UNACCEPTED_MEMORY
 =09=09=09     "Node %d Unaccepted:     %8lu kB\n"
 #endif
+=09=09=09     "Node %d GPUActive:      %8lu kB\n"
+=09=09=09     "Node %d GPUReclaim:     %8lu kB\n"
 =09=09=09     ,
 =09=09=09     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
 =09=09=09     nid, K(node_page_state(pgdat, NR_WRITEBACK)),
@@ -556,6 +558,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 =09=09=09     ,
 =09=09=09     nid, K(sum_zone_node_page_state(nid, NR_UNACCEPTED))
 #endif
+=09=09=09     ,
+=09=09=09     nid, K(node_page_state(pgdat, NR_GPU_ACTIVE)),
+=09=09=09     nid, K(node_page_state(pgdat, NR_GPU_RECLAIM))
 =09=09=09    );
 =09len +=3D hugetlb_report_node_meminfo(buf, len, nid);
 =09return len;
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index a458f1e112fd..65ba49ec3a63 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -163,6 +163,12 @@ static int meminfo_proc_show(struct seq_file *m, void =
*v)
 =09show_val_kb(m, "Balloon:        ",
 =09=09    global_node_page_state(NR_BALLOON_PAGES));
=20
+=09show_val_kb(m, "GPUActive:      ",
+=09=09    global_node_page_state(NR_GPU_ACTIVE));
+
+=09show_val_kb(m, "GPUReclaim:     ",
+=09=09    global_node_page_state(NR_GPU_RECLAIM));
+
 =09hugetlb_report_meminfo(m);
=20
 =09arch_report_meminfo(m);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7fb7331c5725..8455551b93f6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -260,6 +260,8 @@ enum node_stat_item {
 #endif
 =09NR_BALLOON_PAGES,
 =09NR_KERNEL_FILE_PAGES,
+=09NR_GPU_ACTIVE,          /* Pages assigned to GPU objects */
+=09NR_GPU_RECLAIM,         /* Pages in shrinkable GPU pools */
 =09NR_VM_NODE_STAT_ITEMS
 };
=20
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 3a4b5207635d..fb99465616cf 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -254,7 +254,9 @@ static void show_free_areas(unsigned int filter, nodema=
sk_t *nodemask, int max_z
 =09=09=09" sec_pagetables:%lukB"
 =09=09=09" all_unreclaimable? %s"
 =09=09=09" Balloon:%lukB"
-=09=09=09"\n",
+=09=09        " gpu_active:%lukB"
+=09=09        " gpu_reclaim:%lukB"
+=09=09        "\n",
 =09=09=09pgdat->node_id,
 =09=09=09K(node_page_state(pgdat, NR_ACTIVE_ANON)),
 =09=09=09K(node_page_state(pgdat, NR_INACTIVE_ANON)),
@@ -280,7 +282,9 @@ static void show_free_areas(unsigned int filter, nodema=
sk_t *nodemask, int max_z
 =09=09=09K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
 =09=09=09str_yes_no(atomic_read(&pgdat->kswapd_failures) >=3D
 =09=09=09=09   MAX_RECLAIM_RETRIES),
-=09=09=09K(node_page_state(pgdat, NR_BALLOON_PAGES)));
+=09=09        K(node_page_state(pgdat, NR_BALLOON_PAGES)),
+=09=09        K(node_page_state(pgdat, NR_GPU_ACTIVE)),
+=09=09=09K(node_page_state(pgdat, NR_GPU_RECLAIM)));
 =09}
=20
 =09for_each_populated_zone(zone) {
diff --git a/mm/vmstat.c b/mm/vmstat.c
index bb09c032eecf..b4df2b85739f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1291,6 +1291,8 @@ const char * const vmstat_text[] =3D {
 #endif
 =09[I(NR_BALLOON_PAGES)]=09=09=09=3D "nr_balloon_pages",
 =09[I(NR_KERNEL_FILE_PAGES)]=09=09=3D "nr_kernel_file_pages",
+=09[I(NR_GPU_ACTIVE)]=09=09=09=3D "nr_gpu_active",
+=09[I(NR_GPU_RECLAIM)]=09=09=09=3D "nr_gpu_reclaim",
 #undef I
=20
 =09/* system-wide enum vm_stat_item counters */
--=20
2.51.0


