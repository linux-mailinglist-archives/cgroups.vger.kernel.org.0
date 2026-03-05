Return-Path: <cgroups+bounces-14677-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOkQGm7fqWm4GgEAu9opvQ
	(envelope-from <cgroups+bounces-14677-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 20:54:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B97217D23
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 20:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B946830440B2
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 19:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDC33E5ED8;
	Thu,  5 Mar 2026 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImAxkDOn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965A3C3BF9
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740430; cv=none; b=S1V+qTypVquTyDfJ7TJv5aIRUt5ejCrflARf89K2qV7MexDSWXWxsndkIJ0rI+VgMxVWx/ZOV6SL7rhDuWbTY6GfV4SlBOunwh2UZKhuMlOqDZiYSPMnADxHAX4hAZoFbkOS63/UrKQxhFhBpaUUrJu6GqCHFyPkdD9ozSugKZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740430; c=relaxed/simple;
	bh=U0xcJjrpeWeCz6JcshJ4kwihw/IrwhIHDkNVlpUMSAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trBA5YilO+3bYpeS/M5WofFQBR9eO39QVRqI/GyGq1nC8YOhfmT6B7eeyDFLTcISKPt/99v5tTSqHPvYmVoiv0rDd08A+XolXcp+yzgnfqiVPnZll59IZKV8D6laWYwSAlhzQRfheE6DxwQUwz3388CDhdDcm+1/P+BC1MwspDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImAxkDOn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772740428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cMUMu0KtXPOEGnfV1oHqnwxPip1bDhNZtmQHZ2TGiRY=;
	b=ImAxkDOn7anwTtaX4fKQ18f+c6q5bBzyZJESLXB1Mntdww/agFQ0cOWD05L3uzzNRcfEM/
	ItBQ0T9ODPcibP2AGAqB6Dk8aj9zHortqYiqLgxZure/WsAVMHQohRtwfIC6moMwgqPGOS
	+yGgFU9+eQjv+SfRa212cPmbDWDKvc4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-tQem2QxvN3u35khqi6cWbw-1; Thu,
 05 Mar 2026 14:53:46 -0500
X-MC-Unique: tQem2QxvN3u35khqi6cWbw-1
X-Mimecast-MFC-AGG-ID: tQem2QxvN3u35khqi6cWbw_1772740425
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF32A195605A;
	Thu,  5 Mar 2026 19:53:44 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.171])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 728281958DC5;
	Thu,  5 Mar 2026 19:53:42 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>
Subject: [PATCH v2] cgroup/cpuset: Call rebuild_sched_domains() directly in hotplug
Date: Thu,  5 Mar 2026 14:53:29 -0500
Message-ID: <20260305195329.282556-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: C0B97217D23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14677-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huaweicloud.com:email]
X-Rspamd-Action: no action

Besides deferring the call to housekeeping_update(), commit 6df415aa46ec
("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug
to workqueue") also defers the rebuild_sched_domains() call to
the workqueue. So a new offline CPU may still be in a sched domain
or new online CPU not showing up in the sched domains for a short
transition period. That could be a problem in some corner cases and
can be the cause of a reported test failure[1]. Fix it by calling
rebuild_sched_domains_cpuslocked() directly in hotplug as before. If
isolated partition invalidation or recreation is being done, the
housekeeping_update() call to update the housekeeping cpumasks will
still be deferred to a workqueue.

In commit 3bfe47967191 ("cgroup/cpuset: Move
housekeeping_update()/rebuild_sched_domains() together"),
housekeeping_update() is called before rebuild_sched_domains() because
it needs to access the HK_TYPE_DOMAIN housekeeping cpumask. That is now
changed to use the static HK_TYPE_DOMAIN_BOOT cpumask as HK_TYPE_DOMAIN
cpumask is now changeable at run time.  As a result, we can move the
rebuild_sched_domains() call before housekeeping_update() with
the slight advantage that it will be done in the same cpus_read_lock
critical section without the possibility of interference by a concurrent
cpu hot add/remove operation.

As it doesn't make sense to acquire cpuset_mutex/cpuset_top_mutex after
calling housekeeping_update() and immediately release them again, move
the cpuset_full_unlock() operation inside update_hk_sched_domains()
and rename it to cpuset_update_sd_hk_unlock() to signify that it will
release the full set of locks.

[1] https://lore.kernel.org/lkml/1a89aceb-48db-4edd-a730-b445e41221fe@nvidia.com

Fixes: 6df415aa46ec ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue")
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 59 ++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 271bb99b1b9d..f7657b325490 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -881,7 +881,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	/*
 	 * Cgroup v2 doesn't support domain attributes, just set all of them
 	 * to SD_ATTR_INIT. Also non-isolating partition root CPUs are a
-	 * subset of HK_TYPE_DOMAIN housekeeping CPUs.
+	 * subset of HK_TYPE_DOMAIN_BOOT housekeeping CPUs.
 	 */
 	for (i = 0; i < ndoms; i++) {
 		/*
@@ -890,7 +890,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 		 */
 		if (!csa || csa[i] == &top_cpuset)
 			cpumask_and(doms[i], top_cpuset.effective_cpus,
-				    housekeeping_cpumask(HK_TYPE_DOMAIN));
+				    housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
 		else
 			cpumask_copy(doms[i], csa[i]->effective_cpus);
 		if (dattr)
@@ -1331,17 +1331,22 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 }
 
 /*
- * update_hk_sched_domains - Update HK cpumasks & rebuild sched domains
+ * cpuset_update_sd_hk_unlock - Rebuild sched domains, update HK & unlock
  *
- * Update housekeeping cpumasks and rebuild sched domains if necessary.
- * This should be called at the end of cpuset or hotplug actions.
+ * Update housekeeping cpumasks and rebuild sched domains if necessary and
+ * then do a cpuset_full_unlock().
+ * This should be called at the end of cpuset operation.
  */
-static void update_hk_sched_domains(void)
+static void cpuset_update_sd_hk_unlock(void)
+	__releases(&cpuset_mutex)
+	__releases(&cpuset_top_mutex)
 {
+	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
+	if (force_sd_rebuild)
+		rebuild_sched_domains_locked();
+
 	if (update_housekeeping) {
-		/* Updating HK cpumasks implies rebuild sched domains */
 		update_housekeeping = false;
-		force_sd_rebuild = true;
 		cpumask_copy(isolated_hk_cpus, isolated_cpus);
 
 		/*
@@ -1352,22 +1357,19 @@ static void update_hk_sched_domains(void)
 		mutex_unlock(&cpuset_mutex);
 		cpus_read_unlock();
 		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus));
-		cpus_read_lock();
-		mutex_lock(&cpuset_mutex);
+		mutex_unlock(&cpuset_top_mutex);
+	} else {
+		cpuset_full_unlock();
 	}
-	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
-	if (force_sd_rebuild)
-		rebuild_sched_domains_locked();
 }
 
 /*
- * Work function to invoke update_hk_sched_domains()
+ * Work function to invoke cpuset_update_sd_hk_unlock()
  */
 static void hk_sd_workfn(struct work_struct *work)
 {
 	cpuset_full_lock();
-	update_hk_sched_domains();
-	cpuset_full_unlock();
+	cpuset_update_sd_hk_unlock();
 }
 
 /**
@@ -3232,8 +3234,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 
 	free_cpuset(trialcs);
 out_unlock:
-	update_hk_sched_domains();
-	cpuset_full_unlock();
+	cpuset_update_sd_hk_unlock();
 	if (of_cft(of)->private == FILE_MEMLIST)
 		schedule_flush_migrate_mm();
 	return retval ?: nbytes;
@@ -3340,8 +3341,7 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 	cpuset_full_lock();
 	if (is_cpuset_online(cs))
 		retval = update_prstate(cs, val);
-	update_hk_sched_domains();
-	cpuset_full_unlock();
+	cpuset_update_sd_hk_unlock();
 	return retval ?: nbytes;
 }
 
@@ -3515,8 +3515,7 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
 	/* Reset valid partition back to member */
 	if (is_partition_valid(cs))
 		update_prstate(cs, PRS_MEMBER);
-	update_hk_sched_domains();
-	cpuset_full_unlock();
+	cpuset_update_sd_hk_unlock();
 }
 
 static void cpuset_css_free(struct cgroup_subsys_state *css)
@@ -3925,11 +3924,13 @@ static void cpuset_handle_hotplug(void)
 		rcu_read_unlock();
 	}
 
-
 	/*
-	 * Queue a work to call housekeeping_update() & rebuild_sched_domains()
-	 * There will be a slight delay before the HK_TYPE_DOMAIN housekeeping
-	 * cpumask can correctly reflect what is in isolated_cpus.
+	 * rebuild_sched_domains() will always be called directly if needed
+	 * to make sure that newly added or removed CPU will be reflected in
+	 * the sched domains. However, if isolated partition invalidation
+	 * or recreation is being done (update_housekeeping set), a work item
+	 * will be queued to call housekeeping_update() to update the
+	 * corresponding housekeeping cpumasks after some slight delay.
 	 *
 	 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work item that
 	 * is still pending. Before the pending bit is cleared, the work data
@@ -3938,8 +3939,10 @@ static void cpuset_handle_hotplug(void)
 	 * previously queued work. Since hk_sd_workfn() doesn't use the work
 	 * item at all, this is not a problem.
 	 */
-	if (update_housekeeping || force_sd_rebuild)
-		queue_work(system_unbound_wq, &hk_sd_work);
+	if (force_sd_rebuild)
+		rebuild_sched_domains_cpuslocked();
+	if (update_housekeeping)
+		queue_work(system_dfl_wq, &hk_sd_work);
 
 	free_tmpmasks(ptmp);
 }
-- 
2.53.0


