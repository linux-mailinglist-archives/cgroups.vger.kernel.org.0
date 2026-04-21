Return-Path: <cgroups+bounces-15393-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICsHJn7r5mnF1wEAu9opvQ
	(envelope-from <cgroups+bounces-15393-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:14:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B204435E6E
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02BFD3037EFC
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCC6378817;
	Tue, 21 Apr 2026 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvIN1A7d"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90136B05C
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740816; cv=none; b=AYgaJF0nfQCseZySAytU/07j/uoWoGF1hshzJUCIMalHc46KV21YjGnnnubnk1zA8fV+VxNzA7G+N+FXGQNzkg8evFufu0ptIh+yHJEGy7qDNHjMIMtCQQZhOv0ej39nz9rOPtDGnAfSz+qO528Wy7L4Xhp4ikbaVJu377PQmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740816; c=relaxed/simple;
	bh=jlSzrdRoCk8O53BdpCgrGHVT1k8wkXcmtZiCQ2yPsTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTExXDmLP1+qkjaEZmy286B1C+eIpaaB1pE7JlbAL8vOPR5fX6haDQ7wQmL9oambxfw+i5v6Ro0kynePrxbUJw2xgMNr+279y3/t8XbtJl5MqE2WnH7xCfhd0HIdFji62WeOHDNrAKZwIUckITtW1b5fkGZd+R6gQi0SC2Fx3Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvIN1A7d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6fqD7LU2lkfHc9CGeiddofdvg6nvrDcuHa8qiOr5+o=;
	b=GvIN1A7ddXn3ENuPq25YXrByr/PpYLWDqP7IEnkqtiK3ihE/iDyF86RzDvodCui1W3p5CZ
	xRF/XEcWU/5J1UY1bTXAooBuZdHizP2qBUGVmElorjK/pFYwKwEmwhKukgqHTyQpEXaZhw
	bB1ZfxBguVIBgZUEgJGkRY7j58yL9hE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-3E8X-6EKONCGjFMgsGHa1w-1; Mon,
 20 Apr 2026 23:06:49 -0400
X-MC-Unique: 3E8X-6EKONCGjFMgsGHa1w-1
X-Mimecast-MFC-AGG-ID: 3E8X-6EKONCGjFMgsGHa1w_1776740805
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D587C18005AA;
	Tue, 21 Apr 2026 03:06:44 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7C5619560AB;
	Tue, 21 Apr 2026 03:06:37 +0000 (UTC)
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
Subject: [PATCH 15/23] Drivers: hv: Use RCU to protect access of HK_TYPE_MANAGED_IRQ cpumask
Date: Mon, 20 Apr 2026 23:03:43 -0400
Message-ID: <20260421030351.281436-16-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15393-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 3B204435E6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As HK_TYPE_MANAGED_IRQ cpumask is going to be changeable at run time,
use RCU to protect access to the cpumask. The memory allocation
alloc_cpumask_var() call is done before taking the rcu_read_lock()
as this call can be sleepable.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/hv/channel_mgmt.c | 15 +++++++++------
 drivers/hv/vmbus_drv.c    |  7 +++++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 84eb0a6a0b54..44441dafed90 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -752,13 +752,16 @@ static void init_vp_index(struct vmbus_channel *channel)
 	u32 i, ncpu = num_online_cpus();
 	cpumask_var_t available_mask;
 	struct cpumask *allocated_mask;
-	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
+	const struct cpumask *hk_mask;
 	u32 target_cpu;
 	int numa_node;
+	bool alloc_ok;
 
-	if (!perf_chn ||
-	    !alloc_cpumask_var(&available_mask, GFP_KERNEL) ||
-	    cpumask_empty(hk_mask)) {
+	alloc_ok = alloc_cpumask_var(&available_mask, GFP_KERNEL);
+	guard(rcu)();
+	hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
+
+	if (!perf_chn || !alloc_ok || cpumask_empty(hk_mask)) {
 		/*
 		 * If the channel is not a performance critical
 		 * channel, bind it to VMBUS_CONNECT_CPU.
@@ -770,7 +773,7 @@ static void init_vp_index(struct vmbus_channel *channel)
 		channel->target_cpu = VMBUS_CONNECT_CPU;
 		if (perf_chn)
 			hv_set_allocated_cpu(VMBUS_CONNECT_CPU);
-		return;
+		goto out_free;
 	}
 
 	for (i = 1; i <= ncpu + 1; i++) {
@@ -808,7 +811,7 @@ static void init_vp_index(struct vmbus_channel *channel)
 	}
 
 	channel->target_cpu = target_cpu;
-
+out_free:
 	free_cpumask_var(available_mask);
 }
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3faa74e49a6b..60c7a5ac15c0 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1763,8 +1763,11 @@ int vmbus_channel_set_cpu(struct vmbus_channel *channel, u32 target_cpu)
 	if (target_cpu >= nr_cpumask_bits)
 		return -EINVAL;
 
-	if (!cpumask_test_cpu(target_cpu, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
-		return -EINVAL;
+	scoped_guard(rcu) {
+		if (!cpumask_test_cpu(target_cpu,
+				      housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
+			return -EINVAL;
+	}
 
 	if (!cpu_online(target_cpu))
 		return -EINVAL;
-- 
2.53.0


