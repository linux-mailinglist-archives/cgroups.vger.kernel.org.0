Return-Path: <cgroups+bounces-8135-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E86A7AB2F7F
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 08:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F12172A80
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 06:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D9255E30;
	Mon, 12 May 2025 06:21:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868C2550DE
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030864; cv=none; b=mjm4272v1a6HPbuMDWIgaERmTekv1eBokIowcQX4GC4InC75Ai0dKZfG9hV9QYyi3ziLNOTvMVqAaOMk0wzBbzGauC//4XSy+4Lf4S6OMIpcGGni/EWAz3/WQG4ejh4h7b/O0oKAtwrQFpjF+BrCe3kjq/Nhwsumg4LoQjD0N6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030864; c=relaxed/simple;
	bh=WupTgDMa3mYRrcSzZv7VDGQx/jYR2QyCOgpESp6Of+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OPVbrThf8VuJyKYyv7R30qMtsInSAW2K9nLHLIPi8++Q9hC19ap43WGl3Y2hXGNXfhlfTP2MO1cDHSAYuvPQLthYvErh9Z210M4GexgjLlhKp55sOEri//g5a7bFYyzXb0oNVkniK3LYNWHBkK50sYYEDiLwHx8Cze1Lo5Qwz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-z4hkNpxbP4mNgJZQpn-W3g-1; Mon,
 12 May 2025 02:19:47 -0400
X-MC-Unique: z4hkNpxbP4mNgJZQpn-W3g-1
X-Mimecast-MFC-AGG-ID: z4hkNpxbP4mNgJZQpn-W3g_1747030786
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B8041800877;
	Mon, 12 May 2025 06:19:46 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.64.136.70])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EF0E19560B0;
	Mon, 12 May 2025 06:19:40 +0000 (UTC)
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
Subject: [PATCH 4/7] memcg: add hooks for gpu memcg charging/uncharging.
Date: Mon, 12 May 2025 16:12:10 +1000
Message-ID: <20250512061913.3522902-5-airlied@gmail.com>
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
X-Mimecast-MFC-PROC-ID: Nf-IRRzMQ7wFeg1FKGkGAfIYxDcjTvL49avJYRheXQM_1747030786
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


