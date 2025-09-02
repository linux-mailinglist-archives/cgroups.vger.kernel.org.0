Return-Path: <cgroups+bounces-9595-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA8BB3F382
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 06:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009E23BE144
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 04:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549F2E0B6C;
	Tue,  2 Sep 2025 04:11:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B622E0939
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 04:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756786319; cv=none; b=uS5Nu3gNbBbkTviYAHCpASvAfoosAG12IfDmXmZgZi6qodHh7pDFUNfxMMEwvKOu0YeJnRbrpQ65GfyX6t69tFHb3XmehR1kBYgkT2unI3DngKQXUv2UTQ14/QAvZ+LuxVctJvbbR87NGlh9iTpMW1vUo4opEwUZCWV2AtSuRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756786319; c=relaxed/simple;
	bh=iAEErz0HKYnEGVdgI4e3w6uvF5c7G8bLnSpEHEVlpjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Mq7ZdGfXH6TaA5mVfHGZdESETzWCGE0aPyKuI7ukUVqbpW5E+KyimI9pHwe2y4yzlyGEH9p92jBMsLVo2wdpUstGablX0NjAyz136GuarafS59heoHyAZT8oouTaxI89jItSjoJxqSPFMbdUHpiU21ucekEBa73J8YeAFg5o9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-_LEizNMwO769FWQ-pGvjRw-1; Tue,
 02 Sep 2025 00:11:56 -0400
X-MC-Unique: _LEizNMwO769FWQ-pGvjRw-1
X-Mimecast-MFC-AGG-ID: _LEizNMwO769FWQ-pGvjRw_1756786314
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6140A18003FC;
	Tue,  2 Sep 2025 04:11:54 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACEE430001A2;
	Tue,  2 Sep 2025 04:11:47 +0000 (UTC)
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
Subject: [PATCH 10/15] ttm: add objcg pointer to bo and tt
Date: Tue,  2 Sep 2025 14:06:49 +1000
Message-ID: <20250902041024.2040450-11-airlied@gmail.com>
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
X-Mimecast-MFC-PROC-ID: 2cF5FUA1YKyGrfMkxRxAXx7VlTQ3QfN04vjsn2i9Rtc_1756786314
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

From: Dave Airlie <airlied@redhat.com>

This just adds the obj cgroup pointer to the bo and tt structs,
and sets it between them.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_tt.c | 1 +
 include/drm/ttm/ttm_bo.h     | 6 ++++++
 include/drm/ttm/ttm_tt.h     | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 8f38de3b2f1c..0c54d5e2bfdd 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -162,6 +162,7 @@ static void ttm_tt_init_fields(struct ttm_tt *ttm,
 =09ttm->caching =3D caching;
 =09ttm->restore =3D NULL;
 =09ttm->backup =3D NULL;
+=09ttm->objcg =3D bo->objcg;
 }
=20
 int ttm_tt_init(struct ttm_tt *ttm, struct ttm_buffer_object *bo,
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 6edff0ec9b72..c33b3667ae76 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -135,6 +135,12 @@ struct ttm_buffer_object {
 =09 * reservation lock.
 =09 */
 =09struct sg_table *sg;
+
+=09/**
+=09 * @objcg: object cgroup to charge this to if it ends up using system m=
emory.
+=09 * NULL means don't charge.
+=09 */
+=09struct obj_cgroup *objcg;
 };
=20
 #define TTM_BO_MAP_IOMEM_MASK 0x80
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index 15d4019685f6..c13fea4c2915 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -126,6 +126,8 @@ struct ttm_tt {
 =09enum ttm_caching caching;
 =09/** @restore: Partial restoration from backup state. TTM private */
 =09struct ttm_pool_tt_restore *restore;
+=09/** @objcg: Object cgroup for this TT allocation */
+=09struct obj_cgroup *objcg;
 };
=20
 /**
--=20
2.50.1


