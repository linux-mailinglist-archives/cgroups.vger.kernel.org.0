Return-Path: <cgroups+bounces-9589-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF6BB3F377
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 06:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8F63BB495
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 04:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D16C2E092E;
	Tue,  2 Sep 2025 04:11:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970E1804A
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756786276; cv=none; b=kp6gM1ChFw2wpyEhfpk4kahSAb/qBI0AqkXZrFWtF7GB7MGkmWo3ySMwajMMZAqtZLnt/a2H2qiijirMDo5eCkC7VhaWYwhi94HqpJAw02bTtc1C/hSxJWu+nla0MUC2Z27aUj5NTaw0ptwR0j4u8HOoPHogx7zm5l6WdN64SOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756786276; c=relaxed/simple;
	bh=x5c2kVomiYPrfATm5PG9UVLJ4ehzbE3wwyUaGWTPAv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RlqC4BuNa5OPEDGTG9knSWzt92mi9EAmTmRNrF0hpESxaU/zMP3S+40kWxs1ofWO2VOjQll3EEceQwp6Fv3VtDU7upvgTNJNA0BgTo3gnT+g94wwMfir2xEWq2+z08FkLVYkUal+xC37O9Pfd4YQB37GB17O4O1TmhxnazsLbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-J3Bag4i1PwW9DsnTI-yD0g-1; Tue,
 02 Sep 2025 00:11:10 -0400
X-MC-Unique: J3Bag4i1PwW9DsnTI-yD0g-1
X-Mimecast-MFC-AGG-ID: J3Bag4i1PwW9DsnTI-yD0g_1756786268
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 755CA180035D;
	Tue,  2 Sep 2025 04:11:08 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6E1E30001A2;
	Tue,  2 Sep 2025 04:11:01 +0000 (UTC)
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
Subject: [PATCH 04/15] ttm/pool: drop numa specific pools
Date: Tue,  2 Sep 2025 14:06:43 +1000
Message-ID: <20250902041024.2040450-5-airlied@gmail.com>
In-Reply-To: <20250902041024.2040450-1-airlied@gmail.com>
References: <20250902041024.2040450-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8Db7eeojeeYQYu734ESvnbk59oYABigdEO8bWjjigQ0_1756786268
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

From: Dave Airlie <airlied@redhat.com>

The list_lru will now handle numa for us, so need to keep
separate pool types for it. Just consoldiate into the global ones.

This adds a debugfs change to avoid dumping non-existant orders due
to this change.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.=
c
index 8b0fe7a0164a..bc8a796201b4 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -396,17 +396,11 @@ static struct ttm_pool_type *ttm_pool_select_type(str=
uct ttm_pool *pool,
 #ifdef CONFIG_X86
 =09switch (caching) {
 =09case ttm_write_combined:
-=09=09if (pool->nid !=3D NUMA_NO_NODE)
-=09=09=09return &pool->caching[caching].orders[order];
-
 =09=09if (pool->use_dma32)
 =09=09=09return &global_dma32_write_combined[order];
=20
 =09=09return &global_write_combined[order];
 =09case ttm_uncached:
-=09=09if (pool->nid !=3D NUMA_NO_NODE)
-=09=09=09return &pool->caching[caching].orders[order];
-
 =09=09if (pool->use_dma32)
 =09=09=09return &global_dma32_uncached[order];
=20
@@ -1281,7 +1275,7 @@ int ttm_pool_debugfs(struct ttm_pool *pool, struct se=
q_file *m)
 {
 =09unsigned int i;
=20
-=09if (!pool->use_dma_alloc && pool->nid =3D=3D NUMA_NO_NODE) {
+=09if (!pool->use_dma_alloc) {
 =09=09seq_puts(m, "unused\n");
 =09=09return 0;
 =09}
@@ -1292,10 +1286,7 @@ int ttm_pool_debugfs(struct ttm_pool *pool, struct s=
eq_file *m)
 =09for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i) {
 =09=09if (!ttm_pool_select_type(pool, i, 0))
 =09=09=09continue;
-=09=09if (pool->use_dma_alloc)
-=09=09=09seq_puts(m, "DMA ");
-=09=09else
-=09=09=09seq_printf(m, "N%d ", pool->nid);
+=09=09seq_puts(m, "DMA ");
 =09=09switch (i) {
 =09=09case ttm_cached:
 =09=09=09seq_puts(m, "\t:");
--=20
2.50.1


