Return-Path: <cgroups+bounces-8136-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D569AB2F80
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 08:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38473BA798
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2C7255E31;
	Mon, 12 May 2025 06:21:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E9255247
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030864; cv=none; b=q1AdWMUfPcXA+sf990McULFWFh3WHIv3i4nJqGPPlsP22/i22ENalYJZAWORInf+F39Az+spkHud6WWYJ52qEsU2NlaLFULCg+0mWkEWdTOCq4zn/Q6WWwWzi5SnIDQs0WPCPrRCd3klx0JP3pb2sVtbczZcONbAxu2DoZ+goEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030864; c=relaxed/simple;
	bh=0nc0DGlGt8hogm/IujDfwDuE1GyXg7sqe/v3O2OIW4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AAsyHXmUqxJxHTJhu51FRW9+PlqfNKtA7nvAkrkbI7mh7ZGZAFgWFQxROgabLjHzy6bO/LiV3InFD77Js5Mlmfc1/BKVQQffXOl0roix6uhtu0aQ1OTLusTqvlS776geV0u86IjQwegMBfipuydNXRYGfA+TNxQraE0Y2PjMYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-vO3dQ7QiPH6D3fSX-D8sZA-1; Mon,
 12 May 2025 02:19:30 -0400
X-MC-Unique: vO3dQ7QiPH6D3fSX-D8sZA-1
X-Mimecast-MFC-AGG-ID: vO3dQ7QiPH6D3fSX-D8sZA_1747030769
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B70FB180045B;
	Mon, 12 May 2025 06:19:28 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.64.136.70])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACD7119560B9;
	Mon, 12 May 2025 06:19:23 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>,
	simona@ffwll.ch
Subject: [PATCH 1/7] mm: add gpu active/reclaim per-node stat counters
Date: Mon, 12 May 2025 16:12:07 +1000
Message-ID: <20250512061913.3522902-2-airlied@gmail.com>
In-Reply-To: <20250512061913.3522902-1-airlied@gmail.com>
References: <20250512061913.3522902-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ktduILwUaeBtgKa3MXu2e2Q5qEYlh-9Ze4HBqsL_pbQ_1747030769
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

From: Dave Airlie <airlied@redhat.com>

These will be used to track pages actively allocated to the GPU,
and unused pages in pools that can be reclaimed by the shrinker.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 Documentation/filesystems/proc.rst | 6 ++++++
 drivers/base/node.c                | 5 +++++
 fs/proc/meminfo.c                  | 6 ++++++
 include/linux/mmzone.h             | 2 ++
 mm/show_mem.c                      | 9 +++++++--
 mm/vmstat.c                        | 2 ++
 6 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems=
/proc.rst
index 2a17865dfe39..224b0568cf99 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1093,6 +1093,8 @@ Example output. You may not have all of these fields.
     CmaFree:               0 kB
     Unaccepted:            0 kB
     Balloon:               0 kB
+    GPUActive:             0 kB
+    GPUReclaim:            0 kB
     HugePages_Total:       0
     HugePages_Free:        0
     HugePages_Rsvd:        0
@@ -1271,6 +1273,10 @@ Unaccepted
               Memory that has not been accepted by the guest
 Balloon
               Memory returned to Host by VM Balloon Drivers
+GPUActive
+              Memory allocated to GPU objects
+GPUReclaim
+              Memory in GPU allocator pools that is reclaimable
 HugePages_Total, HugePages_Free, HugePages_Rsvd, HugePages_Surp, Hugepages=
ize, Hugetlb
               See Documentation/admin-guide/mm/hugetlbpage.rst.
 DirectMap4k, DirectMap2M, DirectMap1G
diff --git a/drivers/base/node.c b/drivers/base/node.c
index cd13ef287011..669b1e1968a2 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -454,6 +454,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 #ifdef CONFIG_UNACCEPTED_MEMORY
 =09=09=09     "Node %d Unaccepted:     %8lu kB\n"
 #endif
+=09=09=09     "Node %d GPUActive:      %8lu kB\n"
+=09=09=09     "Node %d GPUReclaim:     %8lu kB\n"
 =09=09=09     ,
 =09=09=09     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
 =09=09=09     nid, K(node_page_state(pgdat, NR_WRITEBACK)),
@@ -487,6 +489,9 @@ static ssize_t node_read_meminfo(struct device *dev,
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
index 83be312159c9..baf537044115 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -165,6 +165,12 @@ static int meminfo_proc_show(struct seq_file *m, void =
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
index 6ccec1bf2896..ddc1b9b2a5e3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -226,6 +226,8 @@ enum node_stat_item {
 =09NR_HUGETLB,
 #endif
 =09NR_BALLOON_PAGES,
+=09NR_GPU_ACTIVE,          /* GPU pages assigned to an object */
+=09NR_GPU_RECLAIM,         /* GPU pages in shrinkable pool */
 =09NR_VM_NODE_STAT_ITEMS
 };
=20
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 6af13bcd2ab3..fe8cd06a9143 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -261,7 +261,9 @@ static void show_free_areas(unsigned int filter, nodema=
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
@@ -287,7 +289,10 @@ static void show_free_areas(unsigned int filter, nodem=
ask_t *nodemask, int max_z
 =09=09=09K(node_page_state(pgdat, NR_PAGETABLE)),
 =09=09=09K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
 =09=09=09str_yes_no(pgdat->kswapd_failures >=3D MAX_RECLAIM_RETRIES),
-=09=09=09K(node_page_state(pgdat, NR_BALLOON_PAGES)));
+=09=09        K(node_page_state(pgdat, NR_BALLOON_PAGES)),
+=09=09        K(node_page_state(pgdat, NR_GPU_ACTIVE)),
+=09=09=09K(node_page_state(pgdat, NR_GPU_RECLAIM)));
+
 =09}
=20
 =09for_each_populated_zone(zone) {
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4c268ce39ff2..52bec6522220 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1282,6 +1282,8 @@ const char * const vmstat_text[] =3D {
 =09"nr_hugetlb",
 #endif
 =09"nr_balloon_pages",
+=09"nr_gpu_active",
+=09"nr_gpu_reclaim",
 =09/* system-wide enum vm_stat_item counters */
 =09"nr_dirty_threshold",
 =09"nr_dirty_background_threshold",
--=20
2.49.0


