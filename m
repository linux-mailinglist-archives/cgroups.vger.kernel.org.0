Return-Path: <cgroups+bounces-9594-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14551B3F380
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 06:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE261658F6
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 04:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19462E0B68;
	Tue,  2 Sep 2025 04:11:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F652E0939
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756786313; cv=none; b=X8pBtMasCbD8012T3gQWBF10ng1rSYFXD0S7QgpH5q3aPFCQ1m7d1SOmwuFAE1pllUZU3qhHfT4YcqcxEW/7CtVdiTGB+sVPOHCTMkEWJcNsWMpprJ9Pm4xe/OPItZSYFmulqB/2PIAPKH7hnR3yDMLjWU3puWo5fYxI7T+fEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756786313; c=relaxed/simple;
	bh=hTbp2e9w4Jz4WCnBIRUYqGkFeeWI/olPHWLfTdT0jJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IlPnr8x9VyoHyyQ3/qV9PBtxQrOQ2iWch1717vGoJ7AobmsSMo3+T6DdP+P1VCC939HZfGLHG47C9fO6j6/31A0vIE5BSfkTeTwvy9M961m2t8KA8Nn0ysxrnpAh0mR6jY4VlBCrMCG6yTsRxlkvTLqnkkQzKb927BiryZS8DpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-22L6s4zLPKKsvcObfIikGg-1; Tue,
 02 Sep 2025 00:11:48 -0400
X-MC-Unique: 22L6s4zLPKKsvcObfIikGg-1
X-Mimecast-MFC-AGG-ID: 22L6s4zLPKKsvcObfIikGg_1756786306
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0F0D1800357;
	Tue,  2 Sep 2025 04:11:46 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 308D130001A2;
	Tue,  2 Sep 2025 04:11:39 +0000 (UTC)
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
Subject: [PATCH 09/15] ttm/pool: initialise the shrinker earlier
Date: Tue,  2 Sep 2025 14:06:48 +1000
Message-ID: <20250902041024.2040450-10-airlied@gmail.com>
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
X-Mimecast-MFC-PROC-ID: VSwxF85vBlCOUaWe0Xs5_J7SYrXoHI68tAKLZK_VUFU_1756786306
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

From: Dave Airlie <airlied@redhat.com>

Later memcg enablement needs the shrinker initialised before the list lru,
Just move it for now.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.=
c
index 9a8b4f824bc1..2c9969de7517 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1381,6 +1381,17 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 =09spin_lock_init(&shrinker_lock);
 =09INIT_LIST_HEAD(&shrinker_list);
=20
+=09mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
+=09if (!mm_shrinker)
+=09=09return -ENOMEM;
+
+=09mm_shrinker->count_objects =3D ttm_pool_shrinker_count;
+=09mm_shrinker->scan_objects =3D ttm_pool_shrinker_scan;
+=09mm_shrinker->batch =3D TTM_SHRINKER_BATCH;
+=09mm_shrinker->seeks =3D 1;
+
+=09shrinker_register(mm_shrinker);
+
 =09for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
 =09=09ttm_pool_type_init(&global_write_combined[i], NULL,
 =09=09=09=09   ttm_write_combined, i);
@@ -1403,17 +1414,6 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 #endif
 #endif
=20
-=09mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
-=09if (!mm_shrinker)
-=09=09return -ENOMEM;
-
-=09mm_shrinker->count_objects =3D ttm_pool_shrinker_count;
-=09mm_shrinker->scan_objects =3D ttm_pool_shrinker_scan;
-=09mm_shrinker->batch =3D TTM_SHRINKER_BATCH;
-=09mm_shrinker->seeks =3D 1;
-
-=09shrinker_register(mm_shrinker);
-
 =09return 0;
 }
=20
--=20
2.50.1


