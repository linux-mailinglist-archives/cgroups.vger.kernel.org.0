Return-Path: <cgroups+bounces-7980-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11531AA697C
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 05:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06B93BA18F
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 03:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D64186E40;
	Fri,  2 May 2025 03:41:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BBD4400
	for <cgroups@vger.kernel.org>; Fri,  2 May 2025 03:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746157299; cv=none; b=AwHXHjEQIks5yQD2wrSsrtapQWTyTIHeXY7hJW19jiRWQU2/L02Mea7mCQZyguWkzDrKOYvf8Pg6kBxhz1pDTjn+2JqjFJG5zsvxEIxH8f3oohTx65/u260r1zZnVMrXSbVNrEwU7vz+40eu2JsYy/03emSaVpB9qRZLvRs82Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746157299; c=relaxed/simple;
	bh=iM+Ehssksiwqs3V/UXzissQZ3lgYVY7hEZ/rM9UC73Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ON504I3UNAp9AUdQ2PlWNw9/eQvyQeRl9B9L89SeO6EsbOkSxtWsYP5fUT17ccSa+eN0v02++AatTFGnOyRiIp9uRXzbq3wVja9XN55BoGF5UujCvVYFzZNXUDnx5DvvY0XzZht9TAjSzq9pBiROK5KVmIjv2rztGuGBlq71zag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-gq6agVSPMkmwvGK2n9Sfiw-1; Thu,
 01 May 2025 23:41:32 -0400
X-MC-Unique: gq6agVSPMkmwvGK2n9Sfiw-1
X-Mimecast-MFC-AGG-ID: gq6agVSPMkmwvGK2n9Sfiw_1746157291
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E510D1955DCC;
	Fri,  2 May 2025 03:41:30 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.64.136.70])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 202661800871;
	Fri,  2 May 2025 03:41:25 +0000 (UTC)
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
Subject: [PATCH 5/5] nouveau: add memcg integration
Date: Fri,  2 May 2025 13:36:04 +1000
Message-ID: <20250502034046.1625896-6-airlied@gmail.com>
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
X-Mimecast-MFC-PROC-ID: BVIRV4Jrg_iZDPn_Bzt2nIGN1MQIhMNsc020Aq3pJ48_1746157291
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

From: Dave Airlie <airlied@redhat.com>

This just adds the memcg init and account_op support.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c  | 1 +
 drivers/gpu/drm/nouveau/nouveau_gem.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau=
/nouveau_bo.c
index 2016c1e7242f..8e2da4d48ce3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -350,6 +350,7 @@ nouveau_bo_init(struct nouveau_bo *nvbo, u64 size, int =
align, u32 domain,
 =09struct ttm_operation_ctx ctx =3D {
 =09=09.interruptible =3D false,
 =09=09.no_wait_gpu =3D false,
+=09=09.account_op =3D true,
 =09=09.resv =3D robj,
 =09};
=20
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouvea=
u/nouveau_gem.c
index 67e3c99de73a..56899c89bdd8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -87,6 +87,7 @@ nouveau_gem_object_del(struct drm_gem_object *gem)
 =09=09return;
 =09}
=20
+=09mem_cgroup_put(nvbo->bo.memcg);
 =09ttm_bo_put(&nvbo->bo);
=20
 =09pm_runtime_mark_last_busy(dev);
@@ -254,6 +255,7 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int =
align, uint32_t domain,
 =09if (IS_ERR(nvbo))
 =09=09return PTR_ERR(nvbo);
=20
+=09nvbo->bo.memcg =3D get_mem_cgroup_from_mm(current->mm);
 =09nvbo->bo.base.funcs =3D &nouveau_gem_object_funcs;
 =09nvbo->no_share =3D domain & NOUVEAU_GEM_DOMAIN_NO_SHARE;
=20
--=20
2.49.0


