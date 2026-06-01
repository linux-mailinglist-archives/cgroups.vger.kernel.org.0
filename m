Return-Path: <cgroups+bounces-16531-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OeUOajXHWpsfQkAu9opvQ
	(envelope-from <cgroups+bounces-16531-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 21:04:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F4662464E
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 21:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7C7F305025A
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 19:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A27135AC3C;
	Mon,  1 Jun 2026 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/pq7ADO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5B2F39CE;
	Mon,  1 Jun 2026 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340579; cv=none; b=A9QJpR1qpeMrlEBgLzokHI+3K3WMOS1J0qzCqy97bf5a1BctppsiccHaljW7qgEj9nQP1GLqjFvHv6aGS87KzR44/V9rKAZJEMtiI8Df1cCmybK5wyL5bY5ZAA4YaIf4v3MgFPAuEJ9pwRYRgDeQNmyPMZiviyO16NpBloYzBO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340579; c=relaxed/simple;
	bh=WOqIVd/ZvHO5404p6xduQSJuK41oLmkbBdSKSHXGL4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Stsb9B9aRk4Z8LQMH+5hyke5jX0bL/DKUDYNANrd3UWHz+Wy71KaOqXtZnIg+ycrKvzIgU8JYnBG8UXeVCf3ihMNAzRZxgVo3IE39oWZBxtH4PYKg9ugjOQETGxqnuufn48aKuG+Zuk8EpPwOQeSOclsTPQRKG16t2eWDFwPsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/pq7ADO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2A01F00893;
	Mon,  1 Jun 2026 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780340577;
	bh=ZFKDIpriCRdLoKoooJoVJuWw2QBzWw5MXJG2IFVmKdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V/pq7ADOmieuKmYHsMLMO/RQehkBlDHyhdCw95jj37JrbbYT9PaJRZRud779A0jHt
	 W4RRoJlkLqfvQ+seTjTVm2njL92M0mNNriAqmKLMhHFKUNtsacq1ajpcOb6JWWMJfx
	 UYiDZbR8Gl0/gvTXDH6Op+xJjPacR80AQR/Rl3ThS5+MusGZeqM5j8bDcPhiPK+V8V
	 Yz6ZecwgHlpuzDZ2CAKcQlK0GJKIP6I9jGYObAZ4qCLqXb3vRsQHew72vMCmblRAT2
	 +Fd9Nj6YxgAGrYDmeWXMg/6NNkpOmwwuAjBRy3LYhgUvudDSrSm1FpGgUbMeZaAgpx
	 tWTTLwvgXlXPA==
From: Tejun Heo <tj@kernel.org>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Bert Karwatzki <spasswolf@web.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Malat <oss@malat.biz>,
	kernel test robot <oliver.sang@intel.com>,
	Martin Pitt <martin@piware.de>,
	Aishwarya.TCV@arm.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] cgroup: Migrate tasks to the root css when a controller is rebound
Date: Mon,  1 Jun 2026 09:02:56 -1000
Message-ID: <20260601190256.1815778-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <a9f6c0bcd262e764453b95eb7397871825e11559.camel@web.de>
References: <a9f6c0bcd262e764453b95eb7397871825e11559.camel@web.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,web.de,cmpxchg.org,suse.com,linutronix.de,malat.biz,intel.com,piware.de,arm.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16531-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 66F4662464E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cgroup_apply_control_disable() defers kill_css_finish() while a css is
still populated, relying on css_update_populated() to fire the deferred
kill once the populated count reaches zero.

This deadlocks when a controller is rebound out of a hierarchy. Mounting
an implicit_on_dfl controller such as perf_event as a v1 hierarchy steals
it off the default hierarchy, and rebind_subsystems() kills its
per-cgroup csses while they are still populated. The migration run in the
same step keeps the old css for a controller no longer in the hierarchy's
mask, so no task is migrated off the dying csses. Their populated count
never reaches zero, the deferred kill_css_finish() never fires, and the
next cgroup_lock_and_drain_offline() hangs forever under cgroup_mutex.

That migration is already a no-op pass over the rebound subtree. Add
cgroup_rebind_ss_mask so find_existing_css_set() resolves the leaving
controllers to the root css. Their tasks are migrated there, the
per-cgroup csses depopulate, and cgroup_apply_control_disable() kills
them synchronously. The deferral stays correct for the rmdir and
controller-disable paths it was meant for.

Fixes: 1dffd95575eb ("cgroup: Defer kill_css_finish() in cgroup_apply_control_disable()")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/41cd159c-54e5-45e0-81df-eaf36a6c028e@sirena.org.uk/
Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/all/4e986b4ed7e16547805d54b6e67d09120bc4d2f2.camel@web.de/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello, and thanks a lot for all the reproduction information. It made this
much easier to track down.

Bert, Mark, would you mind giving this a try on your setups?

 kernel/cgroup/cgroup.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index bdc8deedb4f7..7f4861109e48 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -197,6 +197,14 @@ static u32 cgrp_dfl_implicit_ss_mask;
 /* some controllers can be threaded on the default hierarchy */
 static u32 cgrp_dfl_threaded_ss_mask;
 
+/*
+ * Set across rebind_subsystems() to the controllers leaving a hierarchy.
+ * Guarded by cgroup_mutex. Makes find_existing_css_set() resolve them to the
+ * root css so the affected tasks are migrated there before
+ * cgroup_apply_control_disable() kills the per-cgroup csses.
+ */
+static u32 cgroup_rebind_ss_mask;
+
 /* The list of hierarchy roots */
 LIST_HEAD(cgroup_roots);
 static int cgroup_root_count;
@@ -1083,7 +1091,15 @@ static struct css_set *find_existing_css_set(struct css_set *old_cset,
 	 * won't change, so no need for locking.
 	 */
 	for_each_subsys(ss, i) {
-		if (root->subsys_mask & (1UL << i)) {
+		if (unlikely(cgroup_rebind_ss_mask & (1UL << i))) {
+			/*
+			 * @ss is leaving this hierarchy and its per-cgroup
+			 * csses are about to be killed. Resolve to the
+			 * surviving root css so the tasks are migrated there.
+			 */
+			template[i] = cgroup_css(&root->cgrp, ss);
+			WARN_ON_ONCE(!template[i]);
+		} else if (root->subsys_mask & (1UL << i)) {
 			/*
 			 * @ss is in this hierarchy, so we want the
 			 * effective css from @cgrp.
@@ -1853,11 +1869,17 @@ int rebind_subsystems(struct cgroup_root *dst_root, u32 ss_mask)
 		struct cgroup *scgrp = &cgrp_dfl_root.cgrp;
 
 		/*
-		 * Controllers from default hierarchy that need to be rebound
-		 * are all disabled together in one go.
+		 * Controllers leaving the default hierarchy are disabled
+		 * together. cgroup_rebind_ss_mask makes cgroup_apply_control()
+		 * migrate their tasks to the root css, so the per-cgroup csses
+		 * are unpopulated when cgroup_finalize_control() kills them.
+		 * Clear it before cgroup_finalize_control(), which does no
+		 * css_set lookup.
 		 */
 		cgrp_dfl_root.subsys_mask &= ~dfl_disable_ss_mask;
+		cgroup_rebind_ss_mask = dfl_disable_ss_mask;
 		WARN_ON(cgroup_apply_control(scgrp));
+		cgroup_rebind_ss_mask = 0;
 		cgroup_finalize_control(scgrp, 0);
 	}
 
@@ -1871,9 +1893,14 @@ int rebind_subsystems(struct cgroup_root *dst_root, u32 ss_mask)
 		WARN_ON(!css || cgroup_css(dcgrp, ss));
 
 		if (src_root != &cgrp_dfl_root) {
-			/* disable from the source */
+			/*
+			 * Disable from the source, migrating its tasks to the
+			 * root css first (see cgroup_rebind_ss_mask).
+			 */
 			src_root->subsys_mask &= ~(1 << ssid);
+			cgroup_rebind_ss_mask = 1 << ssid;
 			WARN_ON(cgroup_apply_control(scgrp));
+			cgroup_rebind_ss_mask = 0;
 			cgroup_finalize_control(scgrp, 0);
 		}
 
-- 
2.54.0


