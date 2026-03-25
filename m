Return-Path: <cgroups+bounces-15043-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIuxNYkbxGnlwQQAu9opvQ
	(envelope-from <cgroups+bounces-15043-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 18:29:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C444329D1D
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 18:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06511301151A
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8A43FB7F6;
	Wed, 25 Mar 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1Wys8z9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D093D5248;
	Wed, 25 Mar 2026 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459430; cv=none; b=ZKKFh84mD0deQ0X/aNes0U06Rh5vOus3/eabNtxvj6+1e8rt/QJXZtJw0iOUW5P9a4JOhRqyWLjjKVqdOlaXVkqKQqwwX6JftnwxaggTlL/RL4Jcee4jcbokhbkBpbXVFeynl0zMBGeEiqcnPyQohjMq6x0TVpWma432F9RXK+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459430; c=relaxed/simple;
	bh=8wJPT9yaZ0Ie0imdNpOmrFNl47iUtzV3qr2E3YzJhsU=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=bC9rKx6B5R/wFi/0lWumVwcqHhM1XaLE+bTB2JYbqok1xaiMfvxPJt3lMIF+WHpHv2YLtEEdSGETm0NcskS1E6/bNIsn6DJUMlCPeakr3HZlDtB16s5X09HTKcKgx/SRaB/05U46o4yJo28q8a4AhlkEZWSiwSKvCZAsPhWS17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1Wys8z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FD1C4CEF7;
	Wed, 25 Mar 2026 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774459429;
	bh=8wJPT9yaZ0Ie0imdNpOmrFNl47iUtzV3qr2E3YzJhsU=;
	h=Date:From:To:Cc:Subject:From;
	b=D1Wys8z9tPo6qqOKYr6h9WZyj95dqKd143BgmPzuEjs8vHeWdkIrgov/xoPI8GXlp
	 lGP1kPJjs694llEUuYA8LgBetRe+d2Dy0/BZhGeFZu07M4g8TxASZVVmIP4fsxjNv0
	 fY/Ql4VIQV0T945c2k49gIij/zzQL/tFlsXJSI33e3R4r/m/1t/ReNikAV3Xayd4OT
	 mjKFQ4KrLNg2UeAAspPSu6XubiUPqlHFQjjv6MqUbpb85E+T54VOB7dRhV/hBqkE0b
	 d2AKGMhxRRpz90cU2Iyyz1FZUcJF7s3os/iQ7H/gfe/KhdCRby5/Mycy+lcBNqmOS7
	 mZGkdfyYtHwsg==
Date: Wed, 25 Mar 2026 07:23:48 -1000
Message-ID: <68d8881fd985a410c0f619f009334c28@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
 Michal Koutny <mkoutny@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v3 cgroup/for-7.0-fixes] cgroup: Fix cgroup_drain_dying()
 testing the wrong condition
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[web.de,suse.com,cmpxchg.org,linutronix.de,intel.com];
	TAGGED_FROM(0.00)[bounces-15043-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 0C444329D1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cgroup_drain_dying() was using cgroup_is_populated() to test whether there are
dying tasks to wait for. cgroup_is_populated() tests nr_populated_csets,
nr_populated_domain_children and nr_populated_threaded_children, but
cgroup_drain_dying() only needs to care about this cgroup's own tasks - whether
there are children is cgroup_destroy_locked()'s concern.

This caused hangs during shutdown. When systemd tried to rmdir a cgroup that had
no direct tasks but had a populated child, cgroup_drain_dying() would enter its
wait loop because cgroup_is_populated() was true from
nr_populated_domain_children. The task iterator found nothing to wait for, yet
the populated state never cleared because it was driven by live tasks in the
child cgroup.

Fix it by using cgroup_has_tasks() which only tests nr_populated_csets.

v3: Fix cgroup_is_populated() -> cgroup_has_tasks() (Sebastian).

v2: https://lore.kernel.org/r/20260323200205.1063629-1-tj@kernel.org

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: 1b164b876c36 ("cgroup: Wait for dying tasks to leave on rmdir")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cgroup.c |   42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6229,20 +6229,22 @@ static int cgroup_destroy_locked(struct
  * cgroup_drain_dying - wait for dying tasks to leave before rmdir
  * @cgrp: the cgroup being removed
  *
- * The PF_EXITING filter in css_task_iter_advance() hides exiting tasks from
- * cgroup.procs so that userspace (e.g. systemd) doesn't see tasks that have
- * already been reaped via waitpid(). However, the populated counter
- * (nr_populated_csets) is only decremented when the task later passes through
+ * cgroup.procs and cgroup.threads use css_task_iter which filters out
+ * PF_EXITING tasks so that userspace doesn't see tasks that have already been
+ * reaped via waitpid(). However, cgroup_has_tasks() - which tests whether the
+ * cgroup has non-empty css_sets - is only updated when dying tasks pass through
  * cgroup_task_dead() in finish_task_switch(). This creates a window where
- * cgroup.procs appears empty but cgroup_is_populated() is still true, causing
- * rmdir to fail with -EBUSY.
+ * cgroup.procs reads empty but cgroup_has_tasks() is still true, making rmdir
+ * fail with -EBUSY from cgroup_destroy_locked() even though userspace sees no
+ * tasks.
  *
- * This function bridges that gap. If the cgroup is populated but all remaining
- * tasks have PF_EXITING set, we wait for cgroup_task_dead() to process them.
- * Tasks are removed from the cgroup's css_set in cgroup_task_dead() called from
- * finish_task_switch(). As the window between PF_EXITING and cgroup_task_dead()
- * is short, the number of PF_EXITING tasks on the list is small and the wait
- * is brief.
+ * This function aligns cgroup_has_tasks() with what userspace can observe. If
+ * cgroup_has_tasks() but the task iterator sees nothing (all remaining tasks are
+ * PF_EXITING), we wait for cgroup_task_dead() to finish processing them. As the
+ * window between PF_EXITING and cgroup_task_dead() is short, the wait is brief.
+ *
+ * This function only concerns itself with this cgroup's own dying tasks.
+ * Whether the cgroup has children is cgroup_destroy_locked()'s problem.
  *
  * Each cgroup_task_dead() kicks the waitqueue via cset->cgrp_links, and we
  * retry the full check from scratch.
@@ -6258,7 +6260,7 @@ static int cgroup_drain_dying(struct cgr

 	lockdep_assert_held(&cgroup_mutex);
 retry:
-	if (!cgroup_is_populated(cgrp))
+	if (!cgroup_has_tasks(cgrp))
 		return 0;

 	/* Same iterator as cgroup.threads - if any task is visible, it's busy */
@@ -6273,15 +6275,15 @@ retry:
 	 * All remaining tasks are PF_EXITING and will pass through
 	 * cgroup_task_dead() shortly. Wait for a kick and retry.
 	 *
-	 * cgroup_is_populated() can't transition from false to true while
-	 * we're holding cgroup_mutex, but the true to false transition
-	 * happens under css_set_lock (via cgroup_task_dead()). We must
-	 * retest and prepare_to_wait() under css_set_lock. Otherwise, the
-	 * transition can happen between our first test and
-	 * prepare_to_wait(), and we sleep with no one to wake us.
+	 * cgroup_has_tasks() can't transition from false to true while we're
+	 * holding cgroup_mutex, but the true to false transition happens
+	 * under css_set_lock (via cgroup_task_dead()). We must retest and
+	 * prepare_to_wait() under css_set_lock. Otherwise, the transition
+	 * can happen between our first test and prepare_to_wait(), and we
+	 * sleep with no one to wake us.
 	 */
 	spin_lock_irq(&css_set_lock);
-	if (!cgroup_is_populated(cgrp)) {
+	if (!cgroup_has_tasks(cgrp)) {
 		spin_unlock_irq(&css_set_lock);
 		return 0;
 	}

