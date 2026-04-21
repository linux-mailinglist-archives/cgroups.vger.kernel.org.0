Return-Path: <cgroups+bounces-15399-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM9BDpbr5mlx1wEAu9opvQ
	(envelope-from <cgroups+bounces-15399-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:14:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A370E435E9A
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6149C30045A9
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDBF3A0E95;
	Tue, 21 Apr 2026 03:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS7Q/wv7"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF639F173
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740859; cv=none; b=BFrQht8qcCo+/RvFU0Ah5wVZOQrhmWSDdAC0m3TJd926+wQt/cTx5V5ucazVhCmQ2FFO2F1L/7Fi4eGNCVsLBOBEjAGkKUcB2ZYpGLM7mk8iysVcTYsf66TQdNDRDIYRK7Nvyf7H9ZmLQattE58Dv3c89XTqQWs+yCCtVum1kMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740859; c=relaxed/simple;
	bh=KY9RWTeYpkME766HcWMc5adAT4G/1XXfate7fAfO6ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Otu/OBNK04bv4Bs7GorqZSJUPv3q0awU91ukFcIhw9rQ69AMmHLqMYHNRcYQZ2i/fCkyJp2WUd1OxfrMylhCXcPWkGXiR0md2REwD3eGXaCXBPeXkX5j6xCJE+eP7+9z0bPlAKlrsj+CiEIyRcK6z37foVyhe4gIA4AlDSKxztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JS7Q/wv7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PuhRkn96CiNoOus+r7NzZUWwV4LXmvzWiP5TcnJ3DQ=;
	b=JS7Q/wv74sQ99nr8jt7eLeMv7gnTV2xWPgITXxqJ2K7CUe0GK//PUSWEfi7mHYVnVnYl3z
	Og6K0zhQWsB5jGJtq65onOcfH6N5dQQ4B/UQs3hv+A9//zgVxnvEixu1SN3GREJIob5Jx6
	khe9n4Uf2YbTVB7WGiRXNbCgz7l8oZw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-vlbhX3RZO5W5EvKJ9lg_wg-1; Mon,
 20 Apr 2026 23:07:34 -0400
X-MC-Unique: vlbhX3RZO5W5EvKJ9lg_wg-1
X-Mimecast-MFC-AGG-ID: vlbhX3RZO5W5EvKJ9lg_wg_1776740849
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2586F195608B;
	Tue, 21 Apr 2026 03:07:29 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A8FA19560AB;
	Tue, 21 Apr 2026 03:07:21 +0000 (UTC)
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
Subject: [PATCH 21/23] cgroup/cpuset: Limit the side effect of using CPU hotplug on isolated partition
Date: Mon, 20 Apr 2026 23:03:49 -0400
Message-ID: <20260421030351.281436-22-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15399-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A370E435E9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CPU hotplug is used to facilitate the modification of the
HK_TYPE_KERNEL_NOISE and HK_TYPE_MANAGED_IRQ cpumasks. However, tearing
down and bringing up CPUs can impact the cpuset partition states
as well. For instance, tearing down the last CPU of a partition can
invalidate the partition with active tasks which will not happen if
CPU hotplug isn't used.

A workaround of this issue is disable the invalidation by pretending that
the partition has no task, and making the tasks within the partition
to the effective CPUs of its parent for a short while during the short
transition process where the CPUs will be teared down and the brought
up again.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a927b9cd4f71..5f6b4e67748f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -434,6 +434,13 @@ static inline bool partition_is_populated(struct cpuset *cs,
 	struct cpuset *cp;
 	struct cgroup_subsys_state *pos_css;
 
+	/*
+	 * Hack: In cpuhp_offline_cb_mode, pretend all partitions are empty
+	 * to prevent unnecessary partition invalidation.
+	 */
+	if (cpuhp_offline_cb_mode)
+		return false;
+
 	/*
 	 * We cannot call cs_is_populated(cs) directly, as
 	 * nr_populated_domain_children may include populated
@@ -3881,6 +3888,17 @@ hotplug_update_tasks(struct cpuset *cs,
 	cs->effective_mems = *new_mems;
 	spin_unlock_irq(&callback_lock);
 
+	/*
+	 * When cpuhp_offline_cb_mode is active, valid isolated partition
+	 * with tasks may have no online CPUs available for a short while.
+	 * In that case, we fall back to parent's effective CPUs temporarily
+	 * which will be reset back to their rightful value once the affected
+	 * CPUs are online again.
+	 */
+	if (cpuhp_offline_cb_mode && cpumask_empty(new_cpus) &&
+	   (cs->partition_root_state == PRS_ISOLATED))
+		cpumask_copy(new_cpus, parent_cs(cs)->effective_cpus);
+
 	if (cpus_updated)
 		cpuset_update_tasks_cpumask(cs, new_cpus);
 	if (mems_updated)
-- 
2.53.0


