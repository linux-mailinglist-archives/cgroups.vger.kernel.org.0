Return-Path: <cgroups+bounces-15397-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF/jIAjt5mnF1wEAu9opvQ
	(envelope-from <cgroups+bounces-15397-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:20:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E476E43605D
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE336303FFBA
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA4638839F;
	Tue, 21 Apr 2026 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROlz3vKd"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901537C0E6
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740846; cv=none; b=T+UL+ZNLEWFUJ818hdDdsbMLWRR11mmed1uu3Fpy0MVwQCRyTZZRJ+PNl8ZxLdhbYJL+532d//DRoeSYgwT69yX2moy7YR/dPhSnl1M+dOSz0F0b5g8HH6GhFg0JbLVMjGEeP5E/st/CMcOmsIyVlVKQafZH9ZePhmkAn8YI/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740846; c=relaxed/simple;
	bh=aF/UkhCs2sXjpLZZ8EJMXj3n8vqyVnU6ma6HupdSaMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtdcXnwWG213jbaZn7HoFGHgKcn+4u/Fs8kcZbY+QpozsSZEudJ3v37nOJsptYClK3Y09l5JWQnvlrgT8pzSTgvf40kbNdNh2qL5thjNzENi8TIgm+9hwrBIEYgFe3+jBxyzHQD9j0axrO7WJ4g9FLuEF0o31c8bTeVeBAFZftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROlz3vKd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqkCB8gg1IaUA29GIqPtEMXErOagjLMO2tdDX2wDRaY=;
	b=ROlz3vKdVda7VYJdoWm6Lbe2Rn2DMW9SZxnAbSZ9I5p4OtTebMLVn6lvPXQVzd+jlZ7Wu4
	LRVRAEdbfmmOyOS71etJy3zFTpencUJ9SePB1iaoXyt0Xlv+vaGS75inqPor+whmmyx6vO
	v1rNzQ1HjcO8qPMN5aW6sSuRDYqmb2I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-0aQeQXPvOxGsYdnzx6me9Q-1; Mon,
 20 Apr 2026 23:07:19 -0400
X-MC-Unique: 0aQeQXPvOxGsYdnzx6me9Q-1
X-Mimecast-MFC-AGG-ID: 0aQeQXPvOxGsYdnzx6me9Q_1776740834
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37476195608E;
	Tue, 21 Apr 2026 03:07:14 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D92F19560AB;
	Tue, 21 Apr 2026 03:07:06 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>,
	Qiliang Yuan <realwujing@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 19/23] cgroup/cpuset: Improve check for calling housekeeping_update()
Date: Mon, 20 Apr 2026 23:03:47 -0400
Message-ID: <20260421030351.281436-20-longman@redhat.com>
In-Reply-To: <20260421030351.281436-1-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15397-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[53];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E476E43605D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

By making sure that isolated_hk_cpus matches isolated_cpus at boot time,
we can more accurately determine if calling housekeeping_update()
is needed by comparing if the two cpumasks are equal. The
update_housekeeping flag still have a use in cpuset_handle_hotplug()
to determine if a work function should be queued to invoke
cpuset_update_sd_hk_unlock() as it is not supposed to look at
isolated_hk_cpus without holding cpuset_top_mutex.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a4eccb0ec0d1..1b0c50b46a49 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1339,26 +1339,29 @@ static void cpuset_update_sd_hk_unlock(void)
 	__releases(&cpuset_mutex)
 	__releases(&cpuset_top_mutex)
 {
+	update_housekeeping = false;
+
 	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
 	if (force_sd_rebuild)
 		rebuild_sched_domains_locked();
 
-	if (update_housekeeping) {
-		update_housekeeping = false;
-		cpumask_copy(isolated_hk_cpus, isolated_cpus);
-
-		/*
-		 * housekeeping_update() is now called without holding
-		 * cpus_read_lock and cpuset_mutex. Only cpuset_top_mutex
-		 * is still being held for mutual exclusion.
-		 */
-		mutex_unlock(&cpuset_mutex);
-		cpus_read_unlock();
-		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus, BIT(HK_TYPE_DOMAIN)));
-		mutex_unlock(&cpuset_top_mutex);
-	} else {
+	if (cpumask_equal(isolated_hk_cpus, isolated_cpus)) {
+		/* No housekeeping cpumask update needed */
 		cpuset_full_unlock();
+		return;
 	}
+
+	cpumask_copy(isolated_hk_cpus, isolated_cpus);
+
+	/*
+	 * housekeeping_update() is now called without holding
+	 * cpus_read_lock and cpuset_mutex. Only cpuset_top_mutex
+	 * is still being held for mutual exclusion.
+	 */
+	mutex_unlock(&cpuset_mutex);
+	cpus_read_unlock();
+	WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus, BIT(HK_TYPE_DOMAIN)));
+	mutex_unlock(&cpuset_top_mutex);
 }
 
 /*
@@ -3692,10 +3695,11 @@ int __init cpuset_init(void)
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
-	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
+	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT)) {
 		cpumask_andnot(isolated_cpus, cpu_possible_mask,
 			       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
-
+		cpumask_copy(isolated_hk_cpus, isolated_cpus);
+	}
 	return 0;
 }
 
-- 
2.53.0


