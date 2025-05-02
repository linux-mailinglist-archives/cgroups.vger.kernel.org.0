Return-Path: <cgroups+bounces-7982-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9204AA697E
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 05:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF294A7512
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 03:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10D019049A;
	Fri,  2 May 2025 03:42:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950244400
	for <cgroups@vger.kernel.org>; Fri,  2 May 2025 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746157351; cv=none; b=dyMtkFYofAKtXebUDpvWC7ikOnRVMVCPpp4TVwLyBMjHoqIrO/QHrNFWFxS7NtDHG6L/ji8uJxLuS8EOKpmPNNIMEBZ/LCZrRPEdbQjHArlzBI/bKeyFpeAuBp1I46Pb8PWA23KQAfGXeHyCeBr/PC4PuqV/JGt0ulP2BVa0kHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746157351; c=relaxed/simple;
	bh=WupTgDMa3mYRrcSzZv7VDGQx/jYR2QyCOgpESp6Of+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BfNjz0AaV1RQwk19L0tEDIgZZXiVT3n/ofPljxXYIIG8+c1rcklEwOPO3u7NWFlfEp8aPbw2VrKPDSYjsnBIqjF86e9qp7yocuCHfEflAmRJLGxYdbI1WFdCI0sWNkE8RKnploUeoK+AO88tZII4jawZgrzJKPwrWZS1vKLMCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-i-VgQIe-Ntm_K8F2R2BCUw-1; Thu,
 01 May 2025 23:41:16 -0400
X-MC-Unique: i-VgQIe-Ntm_K8F2R2BCUw-1
X-Mimecast-MFC-AGG-ID: i-VgQIe-Ntm_K8F2R2BCUw_1746157274
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 268A91800264;
	Fri,  2 May 2025 03:41:14 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.64.136.70])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BB681800115;
	Fri,  2 May 2025 03:41:09 +0000 (UTC)
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
Subject: [PATCH 2/5] memcg: add hooks for gpu memcg charging/uncharging.
Date: Fri,  2 May 2025 13:36:01 +1000
Message-ID: <20250502034046.1625896-3-airlied@gmail.com>
In-Reply-To: <20250502034046.1625896-1-airlied@gmail.com>
References: <20250502034046.1625896-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vord0QTe6E7X3NhLVS-5aQdPGnsagSG3ShRfupCiCg0_1746157274
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

From: Dave Airlie <airlied@redhat.com>

As per the socket hooks, just adds two APIs to charge GPU pages
to the memcg and uncharge them.

Suggested by Waiman.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 include/linux/memcontrol.h |  5 +++++
 mm/memcontrol.c            | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4058d4bd94ed..f74b7db89f00 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1618,6 +1618,11 @@ struct sock;
 bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pag=
es,
 =09=09=09     gfp_t gfp_mask);
 void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_p=
ages);
+
+bool mem_cgroup_charge_gpu(struct mem_cgroup *memcg, unsigned int nr_pages=
,
+=09=09=09   gfp_t gfp_mask);
+void mem_cgroup_uncharge_gpu(struct mem_cgroup *memcg, unsigned int nr_pag=
es);
+
 #ifdef CONFIG_MEMCG
 extern struct static_key_false memcg_sockets_enabled_key;
 #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_e=
nabled_key)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 25471a0fd0be..76a0ec34b7dc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4958,6 +4958,40 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *me=
mcg, unsigned int nr_pages)
 =09refill_stock(memcg, nr_pages);
 }
=20
+/**
+ * mem_cgroup_charge_gpu - charge GPU memory
+ * @memcg: memcg to charge
+ * @nr_pages: number of pages to charge
+ * @gfp_mask: reclaim mode
+ *
+ * Charges @nr_pages to @memcg. Returns %true if the charge fit within
+ * @memcg's configured limit, %false if it doesn't.
+ */
+bool mem_cgroup_charge_gpu(struct mem_cgroup *memcg, unsigned int nr_pages=
,
+=09=09=09   gfp_t gfp_mask)
+{
+=09if (try_charge_memcg(memcg, gfp_mask, nr_pages) =3D=3D 0) {
+=09=09mod_memcg_state(memcg, MEMCG_GPU, nr_pages);
+=09=09return true;
+=09}
+
+=09return false;
+}
+EXPORT_SYMBOL_GPL(mem_cgroup_charge_gpu);
+
+/**
+ * mem_cgroup_uncharge_gpu - uncharge GPU memory
+ * @memcg: memcg to uncharge
+ * @nr_pages: number of pages to uncharge
+ */
+void mem_cgroup_uncharge_gpu(struct mem_cgroup *memcg, unsigned int nr_pag=
es)
+{
+=09mod_memcg_state(memcg, MEMCG_GPU, -nr_pages);
+
+=09refill_stock(memcg, nr_pages);
+}
+EXPORT_SYMBOL_GPL(mem_cgroup_uncharge_gpu);
+
 static int __init cgroup_memory(char *s)
 {
 =09char *token;
--=20
2.49.0


