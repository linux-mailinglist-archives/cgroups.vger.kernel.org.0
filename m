Return-Path: <cgroups+bounces-14181-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BkSLYoInWk7MgQAu9opvQ
	(envelope-from <cgroups+bounces-14181-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:10:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CC9180E33
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C59963101DF6
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 02:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE4A23D2A1;
	Tue, 24 Feb 2026 02:09:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03E207A20
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898964; cv=none; b=rsatn2IB3myvabBbjJi9eSdcra+eEzWlHxQ+Dc5W9eEVEUwIOROeeznrOu7ZxB0ysMcnO7k6WMeEek8tJ+OYUwgEub+GzLY6F+HHvmrvXTdWOu8vQ5nIpix/NLQQybQ63kDc5oZjKsG1zrbJJV6PY6WSHIzLtUzPRANKbTVwvRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898964; c=relaxed/simple;
	bh=S39yDLR7uqCb+VvCjVBqiB3NXUp4Aph4bSzQfSnXXDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pO/hvNKJ/jewhn713BPFhvRTRgNvf2CsBAjzWxoAozvd3/kw1wikIioqtDFhKMmPconV8gBwUr0cAUkmuNGLCCqtFyL/XCmouyiw1tUkQiqHU+QEW4g2Q2yBmARWm1Vo5GxftVodrso8/GU7Sud7E261bf99KKTWPPE/hIx4eO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-sJoZdL0pP5q7v0kxGrkf9g-1; Mon,
 23 Feb 2026 21:09:16 -0500
X-MC-Unique: sJoZdL0pP5q7v0kxGrkf9g-1
X-Mimecast-MFC-AGG-ID: sJoZdL0pP5q7v0kxGrkf9g_1771898954
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 170C819560B7;
	Tue, 24 Feb 2026 02:09:14 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B19030001BB;
	Tue, 24 Feb 2026 02:09:06 +0000 (UTC)
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
Date: Tue, 24 Feb 2026 12:06:18 +1000
Message-ID: <20260224020854.791201-2-airlied@gmail.com>
In-Reply-To: <20260224020854.791201-1-airlied@gmail.com>
References: <20260224020854.791201-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YZgP37U_tQ16q_woqQbou8wyqE_jEulBU-xBC_uzfcs_1771898954
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14181-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,cmpxchg.org:email,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kvack.org:email,intel.com:email,amd.com:email]
X-Rspamd-Queue-Id: 26CC9180E33
X-Rspamd-Action: no action

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
 mm/show_mem.c                      | 6 +++++-
 mm/vmstat.c                        | 2 ++
 6 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems=
/proc.rst
index b0c0d1b45b99..3acfdf785465 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1089,6 +1089,8 @@ Example output. You may not have all of these fields.
     CmaFree:               0 kB
     Unaccepted:            0 kB
     Balloon:               0 kB
+    GPUActive:             0 kB
+    GPUReclaim:            0 kB
     HugePages_Total:       0
     HugePages_Free:        0
     HugePages_Rsvd:        0
@@ -1269,6 +1271,12 @@ Unaccepted
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
index d7647d077b66..126f66aa2c3e 100644
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
index 3e51190a55e4..841b40031833 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -260,6 +260,8 @@ enum node_stat_item {
 #endif
 =09NR_BALLOON_PAGES,
 =09NR_KERNEL_FILE_PAGES,
+=09NR_GPU_ACTIVE,=09/* Pages assigned to GPU objects */
+=09NR_GPU_RECLAIM,=09/* Pages in shrinkable GPU pools */
 =09NR_VM_NODE_STAT_ITEMS
 };
=20
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 24078ac3e6bc..43aca5a2ac99 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -254,6 +254,8 @@ static void show_free_areas(unsigned int filter, nodema=
sk_t *nodemask, int max_z
 =09=09=09" sec_pagetables:%lukB"
 =09=09=09" all_unreclaimable? %s"
 =09=09=09" Balloon:%lukB"
+=09=09=09" gpu_active:%lukB"
+=09=09=09" gpu_reclaim:%lukB"
 =09=09=09"\n",
 =09=09=09pgdat->node_id,
 =09=09=09K(node_page_state(pgdat, NR_ACTIVE_ANON)),
@@ -279,7 +281,9 @@ static void show_free_areas(unsigned int filter, nodema=
sk_t *nodemask, int max_z
 =09=09=09K(node_page_state(pgdat, NR_PAGETABLE)),
 =09=09=09K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
 =09=09=09str_yes_no(kswapd_test_hopeless(pgdat)),
-=09=09=09K(node_page_state(pgdat, NR_BALLOON_PAGES)));
+=09=09=09K(node_page_state(pgdat, NR_BALLOON_PAGES)),
+=09=09=09K(node_page_state(pgdat, NR_GPU_ACTIVE)),
+=09=09=09K(node_page_state(pgdat, NR_GPU_RECLAIM)));
 =09}
=20
 =09for_each_populated_zone(zone) {
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 86b14b0f77b5..ac9affbe48b7 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1281,6 +1281,8 @@ const char * const vmstat_text[] =3D {
 #endif
 =09[I(NR_BALLOON_PAGES)]=09=09=09=3D "nr_balloon_pages",
 =09[I(NR_KERNEL_FILE_PAGES)]=09=09=3D "nr_kernel_file_pages",
+=09[I(NR_GPU_ACTIVE)]=09=09=09=3D "nr_gpu_active",
+=09[I(NR_GPU_RECLAIM)]=09=09=09=3D "nr_gpu_reclaim",
 #undef I
=20
 =09/* system-wide enum vm_stat_item counters */
--=20
2.52.0


