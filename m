Return-Path: <cgroups+bounces-14805-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJugEJ34s2nYdgAAu9opvQ
	(envelope-from <cgroups+bounces-14805-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:44:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B08328265A
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFE07322F3DE
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 11:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EC73321D4;
	Fri, 13 Mar 2026 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="DJFmCkAh"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACDE37F8CF
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402060; cv=none; b=iX+7XfvygJhr7R6HVoJQmvWMyYeKXK1hHNM+wqORYKChgeFtPZibvQqCRSNZQ/CTA5OTtKYkRYtULXPiksFRT73eHSF6i+44oNgrMQsTPhSz36rkD3TMuvHyfNsux0Xo6PVlKBuzme9Obm1p3BamX5bMGr/TboIh5b2/MydsU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402060; c=relaxed/simple;
	bh=sp5BDGjdd8iCRhBIHh/LU0TAGdskzbUpHTKqakzqADc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7OiFsk+eiX8sFcly0djozE+pK21iSeiDM4OSo2Yf5WXW5Atu1KI4ukAc+InxfZ2XOCEOQ93prHly1u5eXlQ2SHSR4OVUHUUfpI+/8NfXLkIrSOCbFQEv/8dXFlpjS9UKzWfb/IkHENCIMnLygJpMDWYQYKI4S8AmSQVmBuHeP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=DJFmCkAh; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773402039; x=1774006839; i=natalie.vock@gmx.de;
	bh=SGJNX4Qkk79IEgQD6sd68YtMQ/20ZfHySZcdsK9WfCk=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DJFmCkAh1VP6LQVV/GDNYUGlWkhyhM5yK02BsBBKxy4DRHZWLvgYbTgqJp2K6qK6
	 q6X85h+DIPuf3rtEjNdez74lBKbYc4O2J8jD8gqpyqp1ny3Y16Pe/GJkWpQUAkeG4
	 TYCl6zzyeC31LcF0AhR4sf/fe5Rb+XGUVuDThy/55lMxKIbMM7ukGaSdvR/+iXwDc
	 ds6qFB0YDwFlp6H/S+TQpfE5CHdE8f3Wc8TZrzrjqA15a6Adn8ovhh7Jhz/oGIgWR
	 Ees9Ef/HlEDKqtBOtFwqqZcKI5YuGGprdyV2vO23MmX0HD7TkS84MIuMTjWZD6o98
	 Q/VMo/MiNQ/76//trA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1vr4B835wq-00HSbC; Fri, 13
 Mar 2026 12:40:38 +0100
From: Natalie Vock <natalie.vock@gmx.de>
Date: Fri, 13 Mar 2026 12:40:00 +0100
Subject: [PATCH v6 1/6] cgroup/dmem: Add queries for protection values
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260313-dmemcg-aggressive-protect-v6-1-7c71cc1492db@gmx.de>
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Natalie Vock <natalie.vock@gmx.de>
X-Mailer: b4 0.14.3
X-Provags-ID: V03:K1:VFFZeV8T5nNWn0JJo1L/v5/jY1g5meLNIFNDoAMXIsHgCK/ygRK
 VvER0htUvMTjvCNgjTymDkgV2GVF/CqYh5bYMFvh2jqsgj1veKeRZO3ctPqHH98LeyhJmGi
 3PTvBJsmNgCXNkscGuTU2/+qy8/3BcjLAwS2gIsZLsFCEtKZze/9pocObAwoOg8ZmBFud5V
 lUKoOO8kUHb8Ou9k7cAIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SvTxRTqbNMU=;35SF/lGP+MjygSkMqyoVRFZAlUh
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14805-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B08328265A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Callers can use this feedback to be more aggressive in making space for
allocations of a cgroup if they know it is protected.

These are counterparts to memcg's mem_cgroup_below_{min,low}.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 include/linux/cgroup_dmem.h | 16 ++++++++++++
 kernel/cgroup/dmem.c        | 62 ++++++++++++++++++++++++++++++++++++++++=
+++++
 2 files changed, 78 insertions(+)

diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736e..1a88cd0c9eb00 100644
=2D-- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -24,6 +24,10 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state=
 *pool, u64 size);
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limi=
t_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
 				      bool ignore_low, bool *ret_hit_low);
+bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
+			   struct dmem_cgroup_pool_state *test);
+bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
+			   struct dmem_cgroup_pool_state *test);
=20
 void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
 #else
@@ -59,6 +63,18 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgrou=
p_pool_state *limit_pool,
 	return true;
 }
=20
+static inline bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *r=
oot,
+					 struct dmem_cgroup_pool_state *test)
+{
+	return false;
+}
+
+static inline bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *r=
oot,
+					 struct dmem_cgroup_pool_state *test)
+{
+	return false;
+}
+
 static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_sta=
te *pool)
 { }
=20
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 9d95824dc6fa0..28227405f7cfe 100644
=2D-- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -694,6 +694,68 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region =
*region, u64 size,
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_try_charge);
=20
+/**
+ * dmem_cgroup_below_min() - Tests whether current usage is within min li=
mit.
+ *
+ * @root: Root of the subtree to calculate protection for, or NULL to cal=
culate global protection.
+ * @test: The pool to test the usage/min limit of.
+ *
+ * Return: true if usage is below min and the cgroup is protected, false =
otherwise.
+ */
+bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
+			   struct dmem_cgroup_pool_state *test)
+{
+	if (root =3D=3D test || !pool_parent(test))
+		return false;
+
+	if (!root) {
+		for (root =3D test; pool_parent(root); root =3D pool_parent(root))
+			{}
+	}
+
+	/*
+	 * In mem_cgroup_below_min(), the memcg pendant, this call is missing.
+	 * mem_cgroup_below_min() gets called during traversal of the cgroup tre=
e, where
+	 * protection is already calculated as part of the traversal. dmem cgrou=
p eviction
+	 * does not traverse the cgroup tree, so we need to recalculate effectiv=
e protection
+	 * here.
+	 */
+	dmem_cgroup_calculate_protection(root, test);
+	return page_counter_read(&test->cnt) <=3D READ_ONCE(test->cnt.emin);
+}
+EXPORT_SYMBOL_GPL(dmem_cgroup_below_min);
+
+/**
+ * dmem_cgroup_below_low() - Tests whether current usage is within low li=
mit.
+ *
+ * @root: Root of the subtree to calculate protection for, or NULL to cal=
culate global protection.
+ * @test: The pool to test the usage/low limit of.
+ *
+ * Return: true if usage is below low and the cgroup is protected, false =
otherwise.
+ */
+bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
+			   struct dmem_cgroup_pool_state *test)
+{
+	if (root =3D=3D test || !pool_parent(test))
+		return false;
+
+	if (!root) {
+		for (root =3D test; pool_parent(root); root =3D pool_parent(root))
+			{}
+	}
+
+	/*
+	 * In mem_cgroup_below_low(), the memcg pendant, this call is missing.
+	 * mem_cgroup_below_low() gets called during traversal of the cgroup tre=
e, where
+	 * protection is already calculated as part of the traversal. dmem cgrou=
p eviction
+	 * does not traverse the cgroup tree, so we need to recalculate effectiv=
e protection
+	 * here.
+	 */
+	dmem_cgroup_calculate_protection(root, test);
+	return page_counter_read(&test->cnt) <=3D READ_ONCE(test->cnt.elow);
+}
+EXPORT_SYMBOL_GPL(dmem_cgroup_below_low);
+
 static int dmem_cgroup_region_capacity_show(struct seq_file *sf, void *v)
 {
 	struct dmem_cgroup_region *region;

=2D-=20
2.53.0


