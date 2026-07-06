Return-Path: <cgroups+bounces-17520-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vP+cLxc8S2oROAEAu9opvQ
	(envelope-from <cgroups+bounces-17520-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 07:24:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4F970C92C
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 07:24:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=gmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17520-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17520-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6F1A300D953
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 05:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266D33AF650;
	Mon,  6 Jul 2026 05:24:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D23AFCED
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 05:24:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315458; cv=none; b=WYT8L+POkMGY3pvw8KDdDILO8pDdqQ/2gtCT3EoLjyJ7mDuXxtE0dNRC8hBAi2BASdQ2Z5wsJfxsvs3ZOMwa+GlIoBqwttqQ/9A4iHyHva/vgDTWsKO7/6xFPMWy2dTT734LRX0+Wzssb4tdY0zDE3p/9te7iv8Ny0fl/dNLsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315458; c=relaxed/simple;
	bh=6GD6kYrGkwCnryo6ivYzv4TbjPbURd2MfS1i9ixpSZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AzOID/DIK6UVOqUZwnsX9fehYtZbpF49aagmlP1DaOWYh3HSo2xgQZnzCYfFzctdpiOW7h8DW2pTb1Sun1Qd4hRVOz/6rLIfXjFl2OPWZkXZOlwuJbg4U79nBaaGdv71OP8d+U/7EVKhILVD144zusaq/8xZ1cnkxjhQf6dLkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-MLg5nHZZM62rScpqGLTFBQ-1; Mon,
 06 Jul 2026 01:24:12 -0400
X-MC-Unique: MLg5nHZZM62rScpqGLTFBQ-1
X-Mimecast-MFC-AGG-ID: MLg5nHZZM62rScpqGLTFBQ_1783315450
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EF48180266B;
	Mon,  6 Jul 2026 05:24:10 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBEF31956096;
	Mon,  6 Jul 2026 05:24:02 +0000 (UTC)
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
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 03/10] ttm/pool: initialise the shrinker earlier (v2)
Date: Mon,  6 Jul 2026 15:22:32 +1000
Message-ID: <20260706052330.1110909-4-airlied@gmail.com>
In-Reply-To: <20260706052330.1110909-1-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DdSHGfK6NZ0ZDV60uY-tg7Oia9cddIgAbkBNWPh-JfI_1783315450
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dri-devel@lists.freedesktop.org,m:tj@kernel.org,m:christian.koenig@amd.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:thomas.hellstrom@linux.intel.com,m:longman@redhat.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17520-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C4F970C92C

From: Dave Airlie <airlied@redhat.com>

Later memcg enablement needs the shrinker initialised before the list lru,
Just move it for now, but also handle the list being uninitialised.

Signed-off-by: Dave Airlie <airlied@redhat.com>

---
v2: sashiko identified a problem with the list handling.
---
 drivers/gpu/drm/ttm/ttm_pool.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.=
c
index e4dbf4c93091..f12b68812081 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -440,10 +440,14 @@ static unsigned int ttm_pool_shrink(int nid, unsigned=
 long num_to_free)
=20
 =09down_read(&pool_shrink_rwsem);
 =09spin_lock(&shrinker_lock);
-=09pt =3D list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
-=09list_move_tail(&pt->shrinker_list, &shrinker_list);
+=09pt =3D list_first_entry_or_null(&shrinker_list, typeof(*pt), shrinker_l=
ist);
+=09if (pt)
+=09=09list_move_tail(&pt->shrinker_list, &shrinker_list);
 =09spin_unlock(&shrinker_lock);
=20
+=09if (!pt)
+=09=09return 0;
+
 =09num_pages =3D list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_=
list, &dispose, &num_to_free);
 =09num_pages *=3D 1 << pt->order;
=20
@@ -1402,6 +1406,17 @@ int ttm_pool_mgr_init(unsigned long num_pages)
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
@@ -1424,17 +1439,6 @@ int ttm_pool_mgr_init(unsigned long num_pages)
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
2.54.0


