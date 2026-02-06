Return-Path: <cgroups+bounces-13753-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJs6BThRhmnQLwQAu9opvQ
	(envelope-from <cgroups+bounces-13753-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 21:38:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97732103295
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 21:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DEB2301B17A
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 20:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8330EF75;
	Fri,  6 Feb 2026 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWW1XZEq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD930E858
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410285; cv=none; b=cfyUP0KFLoHJSu7j9aZWPhOFlb/n5EjJrJMFrN2PNtBTdnr3aRRuA6Ssc2EniZlzspjXGRFMN+QbNcZC5zM+AoMcoyGbTdo4ZH4gRVr7bMSus5i5rpZoWuEW6DRt8y9mVG8Dj66fPNdQyZu83Nyaf8iKxoseYuTaBJP37Iyf10o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410285; c=relaxed/simple;
	bh=71S3ObAXFhgNJHPY1eqOrJoW7VXUnIJajfUjoJSe1yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrHG2JHfZFHwZvyftOhsEwD4/UmMMhD/ZP7Ddh/KdPyhhtM/KbuIH2OQN7UPGe8TWe3HrJJA27TSh5KeRq4kIsVbZDlzwm8KQZi90hcz0GRFcQHpfxQPwuBjpVQJAOVcNdfW579x3+vBhYJoAtj4EiF8mca06he/7sNQ1QT3LZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWW1XZEq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770410284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUME4hn48Lh+CEIYg2UpLJDShYrbNFkvPeAL4+NsAw8=;
	b=UWW1XZEqqVqdxPbOOkteARfa/1ePWpDj8TXfv3XDLDq/KztsXKOe1yyBVcbbCqELi0LBPO
	K+sNqmNL8nkuk0HXnWd2UotoqhUun+d7evVKXw0gCVL0065pcF0Gy9uYfM3AAntms7k/na
	lL0hMeIXq8aYcJOjbP3bTUZFtot5OUw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-RRQ9N5k2ONeO8GLTUDYibA-1; Fri,
 06 Feb 2026 15:37:55 -0500
X-MC-Unique: RRQ9N5k2ONeO8GLTUDYibA-1
X-Mimecast-MFC-AGG-ID: RRQ9N5k2ONeO8GLTUDYibA_1770410273
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95AE91955F0E;
	Fri,  6 Feb 2026 20:37:52 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EED8518003F6;
	Fri,  6 Feb 2026 20:37:48 +0000 (UTC)
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
Subject: [PATCH/for-next v4 4/4] cgroup/cpuset: Eliminate some duplicated rebuild_sched_domains() calls
Date: Fri,  6 Feb 2026 15:37:12 -0500
Message-ID: <20260206203712.1989610-5-longman@redhat.com>
In-Reply-To: <20260206203712.1989610-1-longman@redhat.com>
References: <20260206203712.1989610-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13753-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97732103295
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
index d26c77a726b2..e224df321e34 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -173,7 +173,11 @@ static bool		isolcpus_twork_queued;	/* T */
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
@@ -990,7 +994,7 @@ void rebuild_sched_domains_locked(void)
 
 	lockdep_assert_cpus_held();
 	lockdep_assert_cpuset_lock_held();
-	force_sd_rebuild = false;
+	sd_rebuild = SD_NO_REBUILD;
 
 	/* Generate domain masks and attrs */
 	ndoms = generate_sched_domains(&doms, &attr);
@@ -1377,6 +1381,9 @@ static void update_isolation_cpumasks(void)
 	else
 		isolated_cpus_updating = false;
 
+	/* Defer rebuild_sched_domains() to task_work or wq */
+	sd_rebuild = SD_DEFER_REBUILD;
+
 	/*
 	 * This function can be reached either directly from regular cpuset
 	 * control file write or via CPU hotplug. In the latter case, it is
@@ -3011,7 +3018,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	update_partition_sd_lb(cs, old_prs);
 
 	notify_partition_change(cs, old_prs);
-	if (force_sd_rebuild)
+	if (sd_rebuild == SD_REBUILD)
 		rebuild_sched_domains_locked();
 	free_tmpmasks(&tmpmask);
 	return 0;
@@ -3288,7 +3295,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	}
 
 	free_cpuset(trialcs);
-	if (force_sd_rebuild)
+	if (sd_rebuild == SD_REBUILD)
 		rebuild_sched_domains_locked();
 out_unlock:
 	cpuset_full_unlock();
@@ -3771,7 +3778,8 @@ hotplug_update_tasks(struct cpuset *cs,
 
 void cpuset_force_rebuild(void)
 {
-	force_sd_rebuild = true;
+	if (!sd_rebuild)
+		sd_rebuild = SD_REBUILD;
 }
 
 /**
@@ -3981,7 +3989,7 @@ static void cpuset_handle_hotplug(void)
 	}
 
 	/* rebuild sched domains if necessary */
-	if (force_sd_rebuild)
+	if (sd_rebuild == SD_REBUILD)
 		rebuild_sched_domains_cpuslocked();
 
 	free_tmpmasks(ptmp);
-- 
2.52.0


