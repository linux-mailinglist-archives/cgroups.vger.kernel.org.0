Return-Path: <cgroups+bounces-15597-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCs9KzQ/+WkZ7QIAu9opvQ
	(envelope-from <cgroups+bounces-15597-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 02:52:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C264C5906
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 02:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2269830315EB
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 00:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28C31E827;
	Tue,  5 May 2026 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZoPJ0zT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CD318EE7;
	Tue,  5 May 2026 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942284; cv=none; b=NAb+YuX6bqf0zbDoRP5YhKxz8pWiTH7CglWHSC7Ow7wW7z4mY27rQ0s9db9aWyrBv5oq6W4oYfmQ22SB5wDg7aIVFd67wN5tAp4mbtfW3aou0+Mo4oZSPIv9QZY7fnfTaYBudC6ONJY+UlXLQfMze/9oF50CEmTaWgzhzdFvOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942284; c=relaxed/simple;
	bh=DtrBlvqdL0fgPM9BGE9rDQhtn11sstA3B6qmzhBTOag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxZYycTW+gg4nWEGAOIlCKSvnBIZHZmbafeSTR4DSLDIKY7DfrI9Ncg+mO0L3+VZKqqbLlz6kAlLAS1KAOEXjn8GcXqxhb5dJotv5CAa6iYQUgHAVctOv5iNNcWj+Iw7HbUMNSURdS6Js5neNR5ym+yGQ9ha1LSApZBDw7nxmpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZoPJ0zT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134E7C2BCB8;
	Tue,  5 May 2026 00:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777942284;
	bh=DtrBlvqdL0fgPM9BGE9rDQhtn11sstA3B6qmzhBTOag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZoPJ0zTQEktuhLTYDUZlMh0ZBoYQ5twykVtwcRvYc/h5qynXpO6b1+gNY7p8kgO6
	 imy60z+LICn6F5J3TQx2soJWtazvDIDZEIue5FDfglYXQJZ2q1n8nNiwcUsvGWGuN2
	 66ycXFPq50NN2VWVo3E4j/kfl4QTMhL3Wo54wnH3KorZJLZhCnuM/DIWz5Rr6McoAf
	 T8fiYjBFUSpaA4+B4Fmixw61Uq8lLD15cpT0Oics/wwNfwAlP9Ld9N1rcO2tudo/r9
	 BjSNKDwkTixQmSQZN7eCpybTRTj19bqEq54J5u17YNVhrVtdYKLzaeJMVMrFKQeRZ0
	 7Z4ijBnL/9rrw==
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
Subject: [PATCH 2/5] cgroup: Annotate unlocked nr_populated_* accesses with READ_ONCE/WRITE_ONCE
Date: Mon,  4 May 2026 14:51:18 -1000
Message-ID: <20260505005121.1230198-3-tj@kernel.org>
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
X-Rspamd-Queue-Id: 34C264C5906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,malat.biz,web.de,intel.com,piware.de,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-15597-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

cgroup_update_populated() updates nr_populated_csets,
nr_populated_domain_children, and nr_populated_threaded_children under
css_set_lock, but cgroup_has_tasks(), cgroup_is_populated(), and
cgroup_can_be_thread_root() read them without holding it. Use
READ_ONCE/WRITE_ONCE.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h | 21 +++++++++++++++++----
 kernel/cgroup/cgroup.c | 11 +++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index ceb87507667e..9f8bef8f3a60 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -639,16 +639,29 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 	return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
 }
 
+/*
+ * Populated counters: writes happen under css_set_lock. The accessors below
+ * may read unlocked. What an unpopulated result means depends on context:
+ *
+ * - No lock held. Just a snapshot. May race with concurrent updates and is
+ *   useful only as a hint.
+ *
+ * - cgroup_mutex held. Migration into the cgroup is blocked, so an observed
+ *   !populated stays !populated until cgroup_mutex is dropped.
+ *
+ * - CSS_DYING set. The css can no longer be repopulated, so !populated is
+ *   sticky once observed.
+ */
 static inline bool cgroup_has_tasks(struct cgroup *cgrp)
 {
-	return cgrp->nr_populated_csets;
+	return READ_ONCE(cgrp->nr_populated_csets);
 }
 
-/* no synchronization, the result can only be used as a hint */
 static inline bool cgroup_is_populated(struct cgroup *cgrp)
 {
-	return cgrp->nr_populated_csets + cgrp->nr_populated_domain_children +
-		cgrp->nr_populated_threaded_children;
+	return READ_ONCE(cgrp->nr_populated_csets) +
+		READ_ONCE(cgrp->nr_populated_domain_children) +
+		READ_ONCE(cgrp->nr_populated_threaded_children);
 }
 
 /* returns ino associated with a cgroup */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 7a94c2ea1036..d1395784871a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -404,7 +404,7 @@ static bool cgroup_can_be_thread_root(struct cgroup *cgrp)
 		return false;
 
 	/* can only have either domain or threaded children */
-	if (cgrp->nr_populated_domain_children)
+	if (READ_ONCE(cgrp->nr_populated_domain_children))
 		return false;
 
 	/* and no domain controllers can be enabled */
@@ -783,12 +783,15 @@ static void cgroup_update_populated(struct cgroup *cgrp, bool populated)
 		bool was_populated = cgroup_is_populated(cgrp);
 
 		if (!child) {
-			cgrp->nr_populated_csets += adj;
+			WRITE_ONCE(cgrp->nr_populated_csets,
+				   cgrp->nr_populated_csets + adj);
 		} else {
 			if (cgroup_is_threaded(child))
-				cgrp->nr_populated_threaded_children += adj;
+				WRITE_ONCE(cgrp->nr_populated_threaded_children,
+					   cgrp->nr_populated_threaded_children + adj);
 			else
-				cgrp->nr_populated_domain_children += adj;
+				WRITE_ONCE(cgrp->nr_populated_domain_children,
+					   cgrp->nr_populated_domain_children + adj);
 		}
 
 		if (was_populated == cgroup_is_populated(cgrp))
-- 
2.54.0


