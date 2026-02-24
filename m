Return-Path: <cgroups+bounces-14182-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLrcC2AInWk7MgQAu9opvQ
	(envelope-from <cgroups+bounces-14182-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:09:36 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C997D180DB0
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34CBD302FFEA
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 02:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B533523EA8D;
	Tue, 24 Feb 2026 02:09:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121323EA83
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898971; cv=none; b=raxjDQuSfqaMhe82Nzg9iYUCoTZDllqw6EKFz3pQrjhKD37Zw/Wr0rHidtuBCC85zqcHPtb4aQyq5V1LjhpPB6q3SDJzsKgf99Sbx6e43gu08pikjbnUPaGDnya38V9jcMCuy+DvhvO5i7ZtwxbBom9uSOBxiGYQDptuWjpIkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898971; c=relaxed/simple;
	bh=uE/ueCU1MVGP8LlI+rR03jlLtzCn0Uuwfp90UyKV2xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APwV3JxdsuoX9c+Rayfv3N5X9voYG9N/IWMYpZKqzHM31hdA9mTO7n+bwiNWRZ1miOHaipecqu65yWyvM+vif2mIL+B9v1KHqiRk6nd9YnfaE7X0QHMy+Kz7ycfNQJ8IoDlWtG0J8f4VN9mR7cy0P+Fmo2+TjT7fbXyb8FwZiv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-PBWt6mehN1SC1_bVkPrOxw-1; Mon,
 23 Feb 2026 21:09:23 -0500
X-MC-Unique: PBWt6mehN1SC1_bVkPrOxw-1
X-Mimecast-MFC-AGG-ID: PBWt6mehN1SC1_bVkPrOxw_1771898962
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 960D21800259;
	Tue, 24 Feb 2026 02:09:21 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2F7230001BB;
	Tue, 24 Feb 2026 02:09:14 +0000 (UTC)
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
Subject: [PATCH 02/16] drm/ttm: use gpu mm stats to track gpu memory allocations. (v4)
Date: Tue, 24 Feb 2026 12:06:19 +1000
Message-ID: <20260224020854.791201-3-airlied@gmail.com>
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
X-Mimecast-MFC-PROC-ID: 0TFV0qAOWreNYtSMnyUKLsKKbT4nnqwXEX6KF7t4dO4_1771898962
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14182-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,amd.com:email,intel.com:email,cmpxchg.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C997D180DB0
X-Rspamd-Action: no action

From: Dave Airlie <airlied@redhat.com>

This uses the newly introduced per-node gpu tracking stats,
to track GPU memory allocated via TTM and reclaimable memory in
the TTM page pools.

These stats will be useful later for system information and
later when mem cgroups are integrated.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>

---
v2: add reclaim parameters and adjust the right counters.
v3: drop the nid helper and get it from page.
v4: use mod_lruvec_page_state (Shakeel)
---
 drivers/gpu/drm/ttm/ttm_pool.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.=
c
index c0d95559197c..6891776cad75 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -159,8 +159,10 @@ static struct page *ttm_pool_alloc_page(struct ttm_poo=
l *pool, gfp_t gfp_flags,
=20
 =09if (!ttm_pool_uses_dma_alloc(pool)) {
 =09=09p =3D alloc_pages_node(pool->nid, gfp_flags, order);
-=09=09if (p)
+=09=09if (p) {
 =09=09=09p->private =3D order;
+=09=09=09mod_lruvec_page_state(p, NR_GPU_ACTIVE, 1 << order);
+=09=09}
 =09=09return p;
 =09}
=20
@@ -195,7 +197,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool=
 *pool, gfp_t gfp_flags,
=20
 /* Reset the caching and pages of size 1 << order */
 static void ttm_pool_free_page(struct ttm_pool *pool, enum ttm_caching cac=
hing,
-=09=09=09       unsigned int order, struct page *p)
+=09=09=09       unsigned int order, struct page *p, bool reclaim)
 {
 =09unsigned long attr =3D DMA_ATTR_FORCE_CONTIGUOUS;
 =09struct ttm_pool_dma *dma;
@@ -210,6 +212,8 @@ static void ttm_pool_free_page(struct ttm_pool *pool, e=
num ttm_caching caching,
 #endif
=20
 =09if (!pool || !ttm_pool_uses_dma_alloc(pool)) {
+=09=09mod_lruvec_page_state(p, reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE,
+=09=09=09=09      -(1 << order));
 =09=09__free_pages(p, order);
 =09=09return;
 =09}
@@ -297,6 +301,9 @@ static void ttm_pool_type_give(struct ttm_pool_type *pt=
, struct page *p)
 =09list_add(&p->lru, &pt->pages);
 =09spin_unlock(&pt->lock);
 =09atomic_long_add(1 << pt->order, &allocated_pages);
+
+=09mod_lruvec_page_state(p, NR_GPU_ACTIVE, -num_pages);
+=09mod_lruvec_page_state(p, NR_GPU_RECLAIM, num_pages);
 }
=20
 /* Take pages from a specific pool_type, return NULL when nothing availabl=
e */
@@ -308,6 +315,8 @@ static struct page *ttm_pool_type_take(struct ttm_pool_=
type *pt)
 =09p =3D list_first_entry_or_null(&pt->pages, typeof(*p), lru);
 =09if (p) {
 =09=09atomic_long_sub(1 << pt->order, &allocated_pages);
+=09=09mod_lruvec_page_state(p, NR_GPU_ACTIVE, (1 << pt->order));
+=09=09mod_lruvec_page_state(p, NR_GPU_RECLAIM, -(1 << pt->order));
 =09=09list_del(&p->lru);
 =09}
 =09spin_unlock(&pt->lock);
@@ -340,7 +349,7 @@ static void ttm_pool_type_fini(struct ttm_pool_type *pt=
)
 =09spin_unlock(&shrinker_lock);
=20
 =09while ((p =3D ttm_pool_type_take(pt)))
-=09=09ttm_pool_free_page(pt->pool, pt->caching, pt->order, p);
+=09=09ttm_pool_free_page(pt->pool, pt->caching, pt->order, p, true);
 }
=20
 /* Return the pool_type to use for the given caching and order */
@@ -392,7 +401,7 @@ static unsigned int ttm_pool_shrink(void)
=20
 =09p =3D ttm_pool_type_take(pt);
 =09if (p) {
-=09=09ttm_pool_free_page(pt->pool, pt->caching, pt->order, p);
+=09=09ttm_pool_free_page(pt->pool, pt->caching, pt->order, p, true);
 =09=09num_pages =3D 1 << pt->order;
 =09} else {
 =09=09num_pages =3D 0;
@@ -484,7 +493,7 @@ static pgoff_t ttm_pool_unmap_and_free(struct ttm_pool =
*pool, struct page *page,
 =09if (pt)
 =09=09ttm_pool_type_give(pt, page);
 =09else
-=09=09ttm_pool_free_page(pool, caching, order, page);
+=09=09ttm_pool_free_page(pool, caching, order, page, false);
=20
 =09return nr;
 }
@@ -789,7 +798,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, stru=
ct ttm_tt *tt,
 =09return 0;
=20
 error_free_page:
-=09ttm_pool_free_page(pool, page_caching, order, p);
+=09ttm_pool_free_page(pool, page_caching, order, p, false);
=20
 error_free_all:
 =09if (tt->restore)
--=20
2.52.0


