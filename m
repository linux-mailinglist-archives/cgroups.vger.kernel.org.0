Return-Path: <cgroups+bounces-14096-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gELrM9L/mWliXwMAu9opvQ
	(envelope-from <cgroups+bounces-14096-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:56:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C2B16D999
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B025D3035882
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 18:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6BD3128A3;
	Sat, 21 Feb 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMEZMgdo"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F130F808
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771700119; cv=none; b=j6R5F6xVFqnI5YEwsEVDD/gnLp77a9HKWFYsWjUMabV9FkOWI5l2poxiiJph4lWZTvYAfM3xBE+V8Vk0l/7chsGzJk21ehSLoXzler679H/hW5UPrHwHzBYzoaFCSfoziNg4rfONAsTii7kPsR2keNVEzNUSJBeXW0C1Cxp94Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771700119; c=relaxed/simple;
	bh=Dm8ouI4wcPuZG9a1WrcqgvvWhTFB3pxL4rOFUvi12V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMmc9RPKm4ArWVDAZerYEWTUmo/r0cGjGMnnHx19Ci8g0UPo64wDrAD4UTJsMPkRG38iyeArF5dzqWc1LT9pd2RNwFSqHafO4F1EhRCgtKKV6PJnDlhthcwuErvYl3cm1Ehu6O8xeKrWgGKcvgArYLu9nR53Rl+zk+iKBeSpqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMEZMgdo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771700116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52VEDWZxrhdgx5iTzfOlzrgMprmkKIqMic5dXsBw/Oo=;
	b=VMEZMgdoBidUpLPDhre6tNxXiWOyes0cfDZ3hXjlEqKET+slP1cAV6uGEx/KG9tpF0231F
	RNOunTy25XtyNKh59Ons+QG5sTl6+Ls35DOHE/aPE2FtpkkUEjw+2QS4Zd11ofircxQYpb
	T2TRuq7ncurv9vFGDF089cv0wbuKPso=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-hDjBKlOUPs6aCv5cB5W2Cw-1; Sat,
 21 Feb 2026 13:55:13 -0500
X-MC-Unique: hDjBKlOUPs6aCv5cB5W2Cw-1
X-Mimecast-MFC-AGG-ID: hDjBKlOUPs6aCv5cB5W2Cw_1771700111
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 260EA19560A3;
	Sat, 21 Feb 2026 18:55:11 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9F891955D85;
	Sat, 21 Feb 2026 18:55:06 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v6 6/8] cgroup/cpuset: Move housekeeping_update()/rebuild_sched_domains() together
Date: Sat, 21 Feb 2026 13:54:16 -0500
Message-ID: <20260221185418.29319-7-longman@redhat.com>
In-Reply-To: <20260221185418.29319-1-longman@redhat.com>
References: <20260221185418.29319-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14096-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89C2B16D999
X-Rspamd-Action: no action

With the latest changes in sched/isolation.c, rebuild_sched_domains*()
requires the HK_TYPE_DOMAIN housekeeping cpumask to be properly
updated first, if needed, before the sched domains can be
rebuilt. So the two naturally fit together. Do that by creating a new
update_hk_sched_domains() helper to house both actions.

The name of the isolated_cpus_updating flag to control the
call to housekeeping_update() is now outdated. So change it to
update_housekeeping to better reflect its purpose. Also move the call
to update_hk_sched_domains() to the end of cpuset and hotplug operations
before releasing the cpuset_mutex.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 51 ++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 05adf6697030..3d0d18bf182f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -130,10 +130,9 @@ static cpumask_var_t	subpartitions_cpus;	/* RWCS */
 static cpumask_var_t	isolated_cpus;		/* CSCB */
 
 /*
- * Set if isolated_cpus is being updated in the current cpuset_mutex
- * critical section.
+ * Set if housekeeping cpumasks are to be updated.
  */
-static bool		isolated_cpus_updating;	/* RWCS */
+static bool		update_housekeeping;	/* RWCS */
 
 /*
  * A flag to force sched domain rebuild at the end of an operation.
@@ -1188,7 +1187,7 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
 			return;
 		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
 	}
-	isolated_cpus_updating = true;
+	update_housekeeping = true;
 }
 
 /*
@@ -1306,22 +1305,22 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 }
 
 /*
- * update_isolation_cpumasks - Update external isolation related CPU masks
+ * update_hk_sched_domains - Update HK cpumasks & rebuild sched domains
  *
- * The following external CPU masks will be updated if necessary:
- * - workqueue unbound cpumask
+ * Update housekeeping cpumasks and rebuild sched domains if necessary.
+ * This should be called at the end of cpuset or hotplug actions.
  */
-static void update_isolation_cpumasks(void)
+static void update_hk_sched_domains(void)
 {
-	int ret;
-
-	if (!isolated_cpus_updating)
-		return;
-
-	ret = housekeeping_update(isolated_cpus);
-	WARN_ON_ONCE(ret < 0);
-
-	isolated_cpus_updating = false;
+	if (update_housekeeping) {
+		/* Updating HK cpumasks implies rebuild sched domains */
+		WARN_ON_ONCE(housekeeping_update(isolated_cpus));
+		update_housekeeping = false;
+		force_sd_rebuild = true;
+	}
+	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
+	if (force_sd_rebuild)
+		rebuild_sched_domains_locked();
 }
 
 /**
@@ -1472,7 +1471,6 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	cs->remote_partition = true;
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks();
 	cpuset_force_rebuild();
 	cs->prs_err = 0;
 
@@ -1517,7 +1515,6 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	compute_excpus(cs, cs->effective_xcpus);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks();
 	cpuset_force_rebuild();
 
 	/*
@@ -1588,7 +1585,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks();
 	if (adding || deleting)
 		cpuset_force_rebuild();
 
@@ -1932,7 +1928,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		partition_xcpus_add(new_prs, parent, tmp->delmask);
 
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks();
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive_flag(cs, new_prs);
@@ -2900,7 +2895,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (isolcpus_updated)
 		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks();
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
@@ -3190,9 +3184,8 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	}
 
 	free_cpuset(trialcs);
-	if (force_sd_rebuild)
-		rebuild_sched_domains_locked();
 out_unlock:
+	update_hk_sched_domains();
 	cpuset_full_unlock();
 	if (of_cft(of)->private == FILE_MEMLIST)
 		schedule_flush_migrate_mm();
@@ -3300,6 +3293,7 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 	cpuset_full_lock();
 	if (is_cpuset_online(cs))
 		retval = update_prstate(cs, val);
+	update_hk_sched_domains();
 	cpuset_full_unlock();
 	return retval ?: nbytes;
 }
@@ -3474,6 +3468,7 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
 	/* Reset valid partition back to member */
 	if (is_partition_valid(cs))
 		update_prstate(cs, PRS_MEMBER);
+	update_hk_sched_domains();
 	cpuset_full_unlock();
 }
 
@@ -3881,10 +3876,12 @@ static void cpuset_handle_hotplug(void)
 		rcu_read_unlock();
 	}
 
-	/* rebuild sched domains if necessary */
-	if (force_sd_rebuild)
-		rebuild_sched_domains_cpuslocked();
 
+	if (update_housekeeping || force_sd_rebuild) {
+		mutex_lock(&cpuset_mutex);
+		update_hk_sched_domains();
+		mutex_unlock(&cpuset_mutex);
+	}
 	free_tmpmasks(ptmp);
 }
 
-- 
2.53.0


