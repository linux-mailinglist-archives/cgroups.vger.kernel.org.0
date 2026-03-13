Return-Path: <cgroups+bounces-14802-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP3sKMn3s2nYdgAAu9opvQ
	(envelope-from <cgroups+bounces-14802-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:40:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4717D2825A9
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B553E302B1A8
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0D1385501;
	Fri, 13 Mar 2026 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="MVMuzy7e"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8B37B011
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402055; cv=none; b=VipbhwcJySXI6U4GL7vxaVVgbPTtM2QRoHwblB6vgkb0WzhWf8fQ8E9YOnf5fCdFW+Jgu8/4fk6yjCnkgn9RPWX4xYNzl6St2obWZpT+KLdjJMyzAAVA0p36j61ngsfmZNbaWJkXcZ/1v19QSBQG0BoAh1ZMu31jJbzhDq4AWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402055; c=relaxed/simple;
	bh=5O2KX1gWlM9iBbtvN+pk5KYmjUBfDReWPmj++Dy74Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cuvPOMQhgFR3RfPtRPyi5Pee2X4WUaqah4fFcWLeArJ4nq/1XZawn/RVG3MF/nfUhEGPHlYxrg76nfJE1bGU0DHn2hkUYVEkSzYEVbkc6xPXvw1as4rce8lNXRMV3DS8htExNLplO3sfUMEPEK9OSIckOuz+jjWHyLg0IdWrWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=MVMuzy7e; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773402039; x=1774006839; i=natalie.vock@gmx.de;
	bh=jyxNsWjQUwN88wBWiD0lRivRZ9t0VJu7d0gxymunrJo=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MVMuzy7eOaxuOwUZW3GT1wKqR3jbCt9GUcop8o6IPO/Rkdi9gH7zDgXxXqJSVYVq
	 v7TQRe0LB8d0YCWFwqmsWm351IRVbbu9ttdVMyawnDmlWeM6+o4LOJG4p6sfZYQcf
	 p1tlwKKxkeNqA0eq/r6akwMxBbOWT3hqxHXNo9mAGVpfmw2xqvpEpTsjMgcLtB+uX
	 Uw9n2dhN288IJdeNCNiwsXtGRdJVPPWeHlyHCuZvwFTJ1bcnE+8oaAU13FPdBJpE0
	 lhtREeYBXyPrkC22CepgrHrWyCYIylSiAoVoUMq+cC+L/yoKCEJR3bb11wWasuUh+
	 LTKSMUyrapLxqAtGQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1vtYku2wgd-00B6wn; Fri, 13
 Mar 2026 12:40:39 +0100
From: Natalie Vock <natalie.vock@gmx.de>
Date: Fri, 13 Mar 2026 12:40:01 +0100
Subject: [PATCH v6 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260313-dmemcg-aggressive-protect-v6-2-7c71cc1492db@gmx.de>
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
X-Provags-ID: V03:K1:qPsCUhfxHJm/95r5qCnHSNK3M6ewd00PXh4ItfNabnAeEY8Peyq
 0gR4N1rgAKINA848AI7iYa8mWHNyMJhDqjv9BFRByKMpj9Zo+piSOQ7fhxQk85F51+8Ijsj
 QUOEerAkQdTgpLIwiU/4G924en31kzVR9mPZj0vmiBdEeTWUQFGLnKz4WR9c39ueL2xns0F
 HOCi3ycgfPBR1YbwJGB7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ix9fUxQAnVI=;n2ZFRaxlLCK9iogaSSDSCqLZgFa
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14802-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4717D2825A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This helps to find a common subtree of two resources, which is important
when determining whether it's helpful to evict one resource in favor of
another.

To facilitate this, add a common helper to find the ancestor of two
cgroups using each cgroup's ancestor array.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 include/linux/cgroup.h      | 21 +++++++++++++++++++++
 include/linux/cgroup_dmem.h |  9 +++++++++
 kernel/cgroup/dmem.c        | 28 ++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index bc892e3b37eea..560ae995e3a54 100644
=2D-- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -561,6 +561,27 @@ static inline struct cgroup *cgroup_ancestor(struct c=
group *cgrp,
 	return cgrp->ancestors[ancestor_level];
 }
=20
+/**
+ * cgroup_common_ancestor - find common ancestor of two cgroups
+ * @a: first cgroup to find common ancestor of
+ * @b: second cgroup to find common ancestor of
+ *
+ * Find the first cgroup that is an ancestor of both @a and @b, if it exi=
sts
+ * and return a pointer to it. If such a cgroup doesn't exist, return NUL=
L.
+ *
+ * This function is safe to call as long as both @a and @b are accessible=
.
+ */
+static inline struct cgroup *cgroup_common_ancestor(struct cgroup *a,
+						    struct cgroup *b)
+{
+	int level;
+
+	for (level =3D min(a->level, b->level); level >=3D 0; level--)
+		if (a->ancestors[level] =3D=3D b->ancestors[level])
+			return a->ancestors[level];
+	return NULL;
+}
+
 /**
  * task_under_cgroup_hierarchy - test task's membership of cgroup ancestr=
y
  * @task: the task to be tested
diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index 1a88cd0c9eb00..9d72457c4cb9d 100644
=2D-- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -28,6 +28,8 @@ bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state=
 *root,
 			   struct dmem_cgroup_pool_state *test);
 bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
 			   struct dmem_cgroup_pool_state *test);
+struct dmem_cgroup_pool_state *dmem_cgroup_get_common_ancestor(struct dme=
m_cgroup_pool_state *a,
+							       struct dmem_cgroup_pool_state *b);
=20
 void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
 #else
@@ -75,6 +77,13 @@ static inline bool dmem_cgroup_below_low(struct dmem_cg=
roup_pool_state *root,
 	return false;
 }
=20
+static inline
+struct dmem_cgroup_pool_state *dmem_cgroup_get_common_ancestor(struct dme=
m_cgroup_pool_state *a,
+							       struct dmem_cgroup_pool_state *b)
+{
+	return NULL;
+}
+
 static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_sta=
te *pool)
 { }
=20
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 28227405f7cfe..9ae085a7fcb73 100644
=2D-- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -756,6 +756,34 @@ bool dmem_cgroup_below_low(struct dmem_cgroup_pool_st=
ate *root,
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_below_low);
=20
+/**
+ * dmem_cgroup_get_common_ancestor(): Find the first common ancestor of t=
wo pools.
+ * @a: First pool to find the common ancestor of.
+ * @b: First pool to find the common ancestor of.
+ *
+ * Return: The first pool that is a parent of both @a and @b, or NULL if =
either @a or @b are NULL,
+ * or if such a pool does not exist. A reference to the returned pool is =
grabbed and must be
+ * released by the caller when it is done using the pool.
+ */
+struct dmem_cgroup_pool_state *dmem_cgroup_get_common_ancestor(struct dme=
m_cgroup_pool_state *a,
+							       struct dmem_cgroup_pool_state *b)
+{
+	struct cgroup *ancestor_cgroup;
+	struct cgroup_subsys_state *ancestor_css;
+
+	if (!a || !b)
+		return NULL;
+
+	ancestor_cgroup =3D cgroup_common_ancestor(a->cs->css.cgroup, b->cs->css=
.cgroup);
+	if (!ancestor_cgroup)
+		return NULL;
+
+	ancestor_css =3D cgroup_e_css(ancestor_cgroup, &dmem_cgrp_subsys);
+
+	return get_cg_pool_unlocked(css_to_dmemcs(ancestor_css), a->region);
+}
+EXPORT_SYMBOL_GPL(dmem_cgroup_get_common_ancestor);
+
 static int dmem_cgroup_region_capacity_show(struct seq_file *sf, void *v)
 {
 	struct dmem_cgroup_region *region;

=2D-=20
2.53.0


