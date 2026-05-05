Return-Path: <cgroups+bounces-15598-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJHjIRo/+WkZ7QIAu9opvQ
	(envelope-from <cgroups+bounces-15598-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 02:51:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B24C58E9
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 02:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 508EC300BC92
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 00:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDDB336883;
	Tue,  5 May 2026 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGCJkb/L"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C742313E34;
	Tue,  5 May 2026 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942285; cv=none; b=j0Ezqt9nDNwH+67VvSvmESCeaFRQq8/QwEwHMdTHRPj725MecDNJ2GihGcNPoRnZ7zL7VwiDNIUsGCgPjywAmbvw3NuLVy2KkAqCdaYKuVnVu/EchUrZXULoi016aFi+o5EQ7DkkrQWkmqWaTv8+XML4DTkkOntxbIDeBZsOmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942285; c=relaxed/simple;
	bh=AqN86WWJ49tR4XlpxNprWLp+7YutwiCs9Yca+jUaAWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlU7OP8OHEMzscWz2Iurj4Oxyb/Igetc3Agremltr88FLR7F/vldlhjDsnc9pTNDXREJY9kmnt0Uok4uOPG/3M91cT8+pAOGry0gpIQWPtctB4ogUuY9u+eoIzKNycug59l/1tnu6Waxm/paYgKvX2zTKMEVELGbyPxytIUZTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGCJkb/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A50C2BCB9;
	Tue,  5 May 2026 00:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777942285;
	bh=AqN86WWJ49tR4XlpxNprWLp+7YutwiCs9Yca+jUaAWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGCJkb/LFodHChZYNtztkwr1MWIBRibk0wm2RnPav7BwFQfs4VTJTBbUXiXLbRrFz
	 4HRTTskHgkXxIH0Fvxl9K22LekE38oCACZ+iupZls+ocj19+YpLO+Qosn7fY3Es05J
	 lauKURMtUVlLHL23xi5E0VoL7f+ZqI0COqD+IVNasCnwWZyCUPQtnwgUXeDkKCZtc3
	 7BuiMIWrIGf/AEDhCyYwV9BCM0KKQ9OdsLIxv1K8zKKomQsMJO4vRRhX4S68tOZuxJ
	 6DErDacK3ADuVCQXV2jEfT+DAavseu6rkWDIza2b5LlDbaoa7H6WtlRl24I/44bLti
	 edDXpSmyYmOxw==
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Malat <oss@malat.biz>,
	Bert Karwatzki <spasswolf@web.de>,
	kernel test robot <oliver.sang@intel.com>,
	Martin Pitt <martin@piware.de>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] cgroup: Move populated counters to cgroup_subsys_state
Date: Mon,  4 May 2026 14:51:19 -1000
Message-ID: <20260505005121.1230198-4-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505005121.1230198-1-tj@kernel.org>
References: <20260505005121.1230198-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 750B24C58E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,malat.biz,web.de,intel.com,piware.de,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-15598-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Later patches replace the cgroup-level finish_destroy_work deferral added
by 93618edf7538 ("cgroup: Defer css percpu_ref kill on rmdir until cgroup
is depopulated") with a per-subsys-css deferral. That needs each subsystem
css to track its own populated count. Move the populated counters from
cgroup onto cgroup_subsys_state. cgroup->self is itself a
cgroup_subsys_state and self.parent walks the same chain as cgroup_parent(),
so cgroup_update_populated() generalizes to a single css_update_populated()
taking a css. The cgroup-side bookkeeping runs only when the walk started
from a self css.

Keep nr_populated_{domain,threaded}_children on cgroup. Both sum to
self.nr_populated_children, but staying as dedicated fields to allow readers
like cgroup_can_be_thread_root() unlocked access.

css_set_update_populated() also walks the per-subsys-css chain so each
subsystem css's hierarchical populated count is maintained. No reader
consumes those counts yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup-defs.h | 24 ++++++----
 include/linux/cgroup.h      | 11 +++--
 kernel/cgroup/cgroup.c      | 95 +++++++++++++++++++++----------------
 3 files changed, 76 insertions(+), 54 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 50a784da7a81..c4929f7bbe5a 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -253,6 +253,15 @@ struct cgroup_subsys_state {
 	 */
 	int nr_descendants;
 
+	/*
+	 * Hierarchical populated state. For cgroup->self, nr_populated_csets
+	 * counts populated csets linked via cgrp_cset_link.
+	 * nr_populated_children counts immediate-child csses whose own
+	 * populated state is nonzero. Protected by css_set_lock.
+	 */
+	int nr_populated_csets;
+	int nr_populated_children;
+
 	/*
 	 * A singly-linked list of css structures to be rstat flushed.
 	 * This is a scratch field to be used exclusively by
@@ -504,17 +513,12 @@ struct cgroup {
 	int max_descendants;
 
 	/*
-	 * Each non-empty css_set associated with this cgroup contributes
-	 * one to nr_populated_csets.  The counter is zero iff this cgroup
-	 * doesn't have any tasks.
-	 *
-	 * All children which have non-zero nr_populated_csets and/or
-	 * nr_populated_children of their own contribute one to either
-	 * nr_populated_domain_children or nr_populated_threaded_children
-	 * depending on their type.  Each counter is zero iff all cgroups
-	 * of the type in the subtree proper don't have any tasks.
+	 * Domain/threaded split of self.nr_populated_children: each counts
+	 * immediate-child cgroups whose subtree is populated and sums to
+	 * self.nr_populated_children. Kept as separate fields to allow readers
+	 * like cgroup_can_be_thread_root() unlocked access. Protected by
+	 * css_set_lock; updated by css_update_populated().
 	 */
-	int nr_populated_csets;
 	int nr_populated_domain_children;
 	int nr_populated_threaded_children;
 
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 9f8bef8f3a60..c2a8c38d8206 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -654,14 +654,17 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
  */
 static inline bool cgroup_has_tasks(struct cgroup *cgrp)
 {
-	return READ_ONCE(cgrp->nr_populated_csets);
+	return READ_ONCE(cgrp->self.nr_populated_csets);
+}
+
+static inline bool css_is_populated(struct cgroup_subsys_state *css)
+{
+	return READ_ONCE(css->nr_populated_csets) || READ_ONCE(css->nr_populated_children);
 }
 
 static inline bool cgroup_is_populated(struct cgroup *cgrp)
 {
-	return READ_ONCE(cgrp->nr_populated_csets) +
-		READ_ONCE(cgrp->nr_populated_domain_children) +
-		READ_ONCE(cgrp->nr_populated_threaded_children);
+	return css_is_populated(&cgrp->self);
 }
 
 /* returns ino associated with a cgroup */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d1395784871a..dd4ea9d83100 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -756,65 +756,70 @@ static bool css_set_populated(struct css_set *cset)
 }
 
 /**
- * cgroup_update_populated - update the populated count of a cgroup
- * @cgrp: the target cgroup
- * @populated: inc or dec populated count
- *
- * One of the css_sets associated with @cgrp is either getting its first
- * task or losing the last.  Update @cgrp->nr_populated_* accordingly.  The
- * count is propagated towards root so that a given cgroup's
- * nr_populated_children is zero iff none of its descendants contain any
- * tasks.
- *
- * @cgrp's interface file "cgroup.populated" is zero if both
- * @cgrp->nr_populated_csets and @cgrp->nr_populated_children are zero and
- * 1 otherwise.  When the sum changes from or to zero, userland is notified
- * that the content of the interface file has changed.  This can be used to
- * detect when @cgrp and its descendants become populated or empty.
+ * css_update_populated - update the populated state of a css and ancestors
+ * @css: leaf css whose own populated count is changing
+ * @populated: inc or dec
+ *
+ * One of the css_sets pinned by @css is getting its first task or losing the
+ * last. Propagate the transition up the parent chain so that a css's
+ * nr_populated_children is zero iff none of its descendants contain any tasks.
+ *
+ * For a cgroup->self walk, also runs cgroup-side bookkeeping at each level:
+ * domain/threaded child split, deferred-destroy trigger, and notification via
+ * "cgroup.populated" (zero iff cgrp->self has neither populated csets nor
+ * populated children; userland is notified on transitions).
  */
-static void cgroup_update_populated(struct cgroup *cgrp, bool populated)
+static void css_update_populated(struct cgroup_subsys_state *css, bool populated)
 {
-	struct cgroup *child = NULL;
+	struct cgroup_subsys_state *child = NULL;
 	int adj = populated ? 1 : -1;
 
 	lockdep_assert_held(&css_set_lock);
 
 	do {
-		bool was_populated = cgroup_is_populated(cgrp);
+		/* non-NULL only on the cgroup->self walk */
+		struct cgroup *cgrp = css_is_self(css) ? css->cgroup : NULL;
+		bool was_populated = css_is_populated(css);
 
 		if (!child) {
-			WRITE_ONCE(cgrp->nr_populated_csets,
-				   cgrp->nr_populated_csets + adj);
+			WRITE_ONCE(css->nr_populated_csets,
+				   css->nr_populated_csets + adj);
 		} else {
-			if (cgroup_is_threaded(child))
-				WRITE_ONCE(cgrp->nr_populated_threaded_children,
-					   cgrp->nr_populated_threaded_children + adj);
-			else
-				WRITE_ONCE(cgrp->nr_populated_domain_children,
-					   cgrp->nr_populated_domain_children + adj);
+			WRITE_ONCE(css->nr_populated_children,
+				   css->nr_populated_children + adj);
+			if (cgrp) {
+				if (cgroup_is_threaded(child->cgroup))
+					WRITE_ONCE(cgrp->nr_populated_threaded_children,
+						   cgrp->nr_populated_threaded_children + adj);
+				else
+					WRITE_ONCE(cgrp->nr_populated_domain_children,
+						   cgrp->nr_populated_domain_children + adj);
+			}
 		}
 
-		if (was_populated == cgroup_is_populated(cgrp))
+		if (was_populated == css_is_populated(css))
 			break;
 
 		/*
 		 * Subtree just emptied below an offlined cgrp. Fire deferred
 		 * destroy. The transition is one-shot.
 		 */
-		if (was_populated && !css_is_online(&cgrp->self)) {
+		if (cgrp && was_populated && !css_is_online(css)) {
 			cgroup_get(cgrp);
 			WARN_ON_ONCE(!queue_work(cgroup_offline_wq,
 						 &cgrp->finish_destroy_work));
 		}
 
-		cgroup1_check_for_release(cgrp);
-		TRACE_CGROUP_PATH(notify_populated, cgrp,
-				  cgroup_is_populated(cgrp));
-		cgroup_file_notify(&cgrp->events_file);
+		if (cgrp) {
+			cgroup1_check_for_release(cgrp);
+			TRACE_CGROUP_PATH(notify_populated, cgrp,
+					  cgroup_is_populated(cgrp));
+			cgroup_file_notify(&cgrp->events_file);
+		}
 
-		child = cgrp;
-		cgrp = cgroup_parent(cgrp);
-	} while (cgrp);
+		child = css;
+		css = css->parent;
+	} while (css);
 }
 
 /**
@@ -822,17 +827,27 @@ static void cgroup_update_populated(struct cgroup *cgrp, bool populated)
  * @cset: target css_set
  * @populated: whether @cset is populated or depopulated
  *
- * @cset is either getting the first task or losing the last.  Update the
- * populated counters of all associated cgroups accordingly.
+ * @cset is either getting the first task or losing the last. Update the
+ * populated counters along each linked cgroup's self chain and each
+ * subsystem css that @cset pins.
  */
 static void css_set_update_populated(struct css_set *cset, bool populated)
 {
 	struct cgrp_cset_link *link;
+	struct cgroup_subsys *ss;
+	int ssid;
 
 	lockdep_assert_held(&css_set_lock);
 
 	list_for_each_entry(link, &cset->cgrp_links, cgrp_link)
-		cgroup_update_populated(link->cgrp, populated);
+		css_update_populated(&link->cgrp->self, populated);
+
+	for_each_subsys(ss, ssid) {
+		struct cgroup_subsys_state *css = cset->subsys[ssid];
+
+		if (css)
+			css_update_populated(css, populated);
+	}
 }
 
 /*
@@ -2190,7 +2205,7 @@ int cgroup_setup_root(struct cgroup_root *root, u32 ss_mask)
 	hash_for_each(css_set_table, i, cset, hlist) {
 		link_css_set(&tmp_links, cset, root_cgrp);
 		if (css_set_populated(cset))
-			cgroup_update_populated(root_cgrp, true);
+			css_update_populated(&root_cgrp->self, true);
 	}
 	spin_unlock_irq(&css_set_lock);
 
@@ -6145,7 +6160,7 @@ static void kill_css_finish(struct cgroup_subsys_state *css)
  *
  * - cgroup_finish_destroy(): kicks the percpu_ref kill via kill_css_finish() on
  *   each subsystem css. Fires once @cgrp's subtree is fully drained, either
- *   inline here or from cgroup_update_populated().
+ *   inline here or from css_update_populated().
  *
  * - The percpu_ref kill chain: css_killed_ref_fn -> css_killed_work_fn ->
  *   ->css_offline() -> release/free.
-- 
2.54.0


