Return-Path: <cgroups+bounces-13904-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OenIaQFjmnO+gAAu9opvQ
	(envelope-from <cgroups+bounces-13904-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:53:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 265EA12FB11
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB7593038F70
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7FF35DD05;
	Thu, 12 Feb 2026 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DemolHdK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0435E548
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914913; cv=none; b=TgPGXhhlZhd0iZR/veXvuljGPg14OdHBPKGdN10sAtHqHE606zIqEgIAADOFQ/sVd3uFhnBCtyzbq6KCGgzaI4ynTD98kfVmCdovpbGOaJzej7OKF5Xc2B9TyxTH+XZ7CK8oh7OmAgprkJVfNwNv5k7RuqbFDb940speeMsZEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914913; c=relaxed/simple;
	bh=+IASX15SHJQl3uo84DSZeDBh3tIvYlqzv39AOczHBjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQPLPNHL0Sa4dmTuegdSbwQ12IZRipjTt7GEmRAg6KrJqjhiuw3sn++EQfPksI+TXZkBiqHYrw7eZWIP/cWQsis9iG6snfXe/2wIyW5gTFRUzywDYoBg/tAijcoJ3oNXyZolQgEOljsg0iJW/akY3OBKnu9ON5Dz11LA0oyC9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DemolHdK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770914909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OakEBTRc4ktVpI3ZptxUvVQZ9LjX5pa6Y5FedYN8EUM=;
	b=DemolHdKp19jXWyBBZwhK77R8dyxjRLo6BXgADLpi8E07mY54B3X/hmzIPl2R9h97VKrHW
	yRzmGTZbTgfGegszMvwgUYjtrYpTWrImkHVq++4IGeBrAsR7UtjT9eIwHXLsIPGeUYd6Zd
	+huzvPASIb0zH8xXq8nisPmlYUCmiYE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-sGST7Oq4N7uhQoTziKEN-g-1; Thu,
 12 Feb 2026 11:48:25 -0500
X-MC-Unique: sGST7Oq4N7uhQoTziKEN-g-1
X-Mimecast-MFC-AGG-ID: sGST7Oq4N7uhQoTziKEN-g_1770914903
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D74418002C2;
	Thu, 12 Feb 2026 16:48:22 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BECB418003F5;
	Thu, 12 Feb 2026 16:48:18 +0000 (UTC)
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
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v5 6/6] cgroup/cpuset: Eliminate some duplicated rebuild_sched_domains() calls
Date: Thu, 12 Feb 2026 11:46:40 -0500
Message-ID: <20260212164640.2408295-7-longman@redhat.com>
In-Reply-To: <20260212164640.2408295-1-longman@redhat.com>
References: <20260212164640.2408295-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13904-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 265EA12FB11
X-Rspamd-Action: no action

Now that we are going to defer any changes to the HK_TYPE_DOMAIN
housekeeping cpumasks to either task_work or workqueue
where rebuild_sched_domains() call will be issued. The current
rebuild_sched_domains_locked() call near the end of the cpuset critical
section can be removed in such cases.

Currently, a boolean force_sd_rebuild flag is used to decide if
rebuild_sched_domains_locked() call needs to be invoked. To allow
deferral that like, we change it to a tri-state sd_rebuild enumaration
type.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c6a97956a991..426949363ca7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -178,7 +178,11 @@ static bool		isolcpus_twork_queued;	/* T */
  * Note that update_relax_domain_level() in cpuset-v1.c can still call
  * rebuild_sched_domains_locked() directly without using this flag.
  */
-static bool force_sd_rebuild;			/* RWCS */
+static enum {
+	SD_NO_REBUILD = 0,
+	SD_REBUILD,
+	SD_DEFER_REBUILD,
+} sd_rebuild;					/* RWCS */
 
 /*
  * Partition root states:
@@ -1023,7 +1027,7 @@ void rebuild_sched_domains_locked(void)
 
 	lockdep_assert_cpus_held();
 	lockdep_assert_cpuset_lock_held();
-	force_sd_rebuild = false;
+	sd_rebuild = SD_NO_REBUILD;
 
 	/* Generate domain masks and attrs */
 	ndoms = generate_sched_domains(&doms, &attr);
@@ -1408,6 +1412,9 @@ static void update_isolation_cpumasks(void)
 	else
 		isolated_cpus_updating = false;
 
+	/* Defer rebuild_sched_domains() to task_work or wq */
+	sd_rebuild = SD_DEFER_REBUILD;
+
 	/*
 	 * CPU hotplug shouldn't set isolated_cpus_updating.
 	 *
@@ -3053,7 +3060,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	update_partition_sd_lb(cs, old_prs);
 
 	notify_partition_change(cs, old_prs);
-	if (force_sd_rebuild)
+	if (sd_rebuild == SD_REBUILD)
 		rebuild_sched_domains_locked();
 	free_tmpmasks(&tmpmask);
 	return 0;
@@ -3330,7 +3337,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	}
 
 	free_cpuset(trialcs);
-	if (force_sd_rebuild)
+	if (sd_rebuild == SD_REBUILD)
 		rebuild_sched_domains_locked();
 out_unlock:
 	cpuset_full_unlock();
@@ -3815,7 +3822,8 @@ hotplug_update_tasks(struct cpuset *cs,
 
 void cpuset_force_rebuild(void)
 {
-	force_sd_rebuild = true;
+	if (!sd_rebuild)
+		sd_rebuild = SD_REBUILD;
 }
 
 /**
@@ -4025,7 +4033,7 @@ static void cpuset_handle_hotplug(void)
 	}
 
 	/* rebuild sched domains if necessary */
-	if (force_sd_rebuild)
+	if (sd_rebuild == SD_REBUILD)
 		rebuild_sched_domains_cpuslocked();
 
 	free_tmpmasks(ptmp);
-- 
2.52.0


