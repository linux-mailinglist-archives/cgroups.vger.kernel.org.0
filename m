Return-Path: <cgroups+bounces-15383-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOu5Nqfq5mlx1wEAu9opvQ
	(envelope-from <cgroups+bounces-15383-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:10:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B89A435C8E
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2452B305B28F
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D0366DA3;
	Tue, 21 Apr 2026 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSNwVAhk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941B36606B
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740742; cv=none; b=pRaUi18dGDGuooGUNhIAfCHgHbEmdVac3Fh9a6vJiBpiF0iQtPMpLQfCFIvyvgXgIT7fiIWSLCdjZ7lEsMUP8IP9m33A+sE7tTxmd0IAXV/y1I+ijl6/V1DCFsSi03mA/HahsS8BEJQ85afOJO05l1xcqv4R0bxNZL+wUp2rqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740742; c=relaxed/simple;
	bh=1a0p9+mSm7V86W1Fk085amvC7d0rMa8bbbudBvOyyns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx3LF5sobxtJr1cqe0Ru1sKoVSdWBn9niHyL04XlnQQLOMj/K/ROCW9VzROD2nNdegRYGBN2wkv02eoYHQP1kiEsa46PTKV9X820LQYrYZmcH0dG5T8BVu+w/1s+LRvbYKP22FY71EntyugFVDfVCAG4NINEsxAqIf3gp+A/gP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSNwVAhk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvxrjlgvnWjaqR0yDbbq75WXz4VuqzuFoTUCXieYzlk=;
	b=OSNwVAhkR2RFHBRBjQOFz+v0L3cv8/dTa/gHDR2NJJ8PN1ZIcJ8I4hR6ftI+uHR+8radik
	X49ZprmZMfJJQlfcKYQ/lHCyTFJs5d3bnZDL7r2n5R2fWVMmO1rCFIUZ1IiMmNitIshCdS
	zIdgjiiHbEyPN6QLlueufHKpN0dk1dA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-yuc8Te4wOrS43YrXrrHjqw-1; Mon,
 20 Apr 2026 23:05:36 -0400
X-MC-Unique: yuc8Te4wOrS43YrXrrHjqw-1
X-Mimecast-MFC-AGG-ID: yuc8Te4wOrS43YrXrrHjqw_1776740731
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9730E1800352;
	Tue, 21 Apr 2026 03:05:31 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4466C19560B7;
	Tue, 21 Apr 2026 03:05:24 +0000 (UTC)
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
Subject: [PATCH 05/23] tick: Pass timer tick job to an online HK CPU in tick_cpu_dying()
Date: Mon, 20 Apr 2026 23:03:33 -0400
Message-ID: <20260421030351.281436-6-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15383-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 3B89A435C8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In tick_cpu_dying(), if the dying CPU is the current timekeeper,
it has to pass the job over to another CPU. The current code passes
it to another online CPU. However, that CPU may not be a timer tick
housekeeping CPU.  If that happens, another CPU will have to manually
take it over again later. Avoid this unnecessary work by directly
assigning an online housekeeping CPU.

Use READ_ONCE/WRITE_ONCE() to access tick_do_timer_cpu in case the
non-HK CPUs may not be in stop machine in the future.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/tick-common.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index d305d8521896..4834a1b9044b 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -17,6 +17,7 @@
 #include <linux/profile.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/sched/isolation.h>
 #include <trace/events/power.h>
 
 #include <asm/irq_regs.h>
@@ -394,12 +395,19 @@ int tick_cpu_dying(unsigned int dying_cpu)
 {
 	/*
 	 * If the current CPU is the timekeeper, it's the only one that can
-	 * safely hand over its duty. Also all online CPUs are in stop
-	 * machine, guaranteed not to be idle, therefore there is no
+	 * safely hand over its duty. Also all online housekeeping CPUs are
+	 * in stop machine, guaranteed not to be idle, therefore there is no
 	 * concurrency and it's safe to pick any online successor.
 	 */
-	if (tick_do_timer_cpu == dying_cpu)
-		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
+	if (READ_ONCE(tick_do_timer_cpu) == dying_cpu) {
+		unsigned int new_cpu;
+
+		guard(rcu)();
+		new_cpu = cpumask_first_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TICK));
+		if (WARN_ON_ONCE(new_cpu >= nr_cpu_ids))
+			new_cpu = cpumask_first(cpu_online_mask);
+		WRITE_ONCE(tick_do_timer_cpu, new_cpu);
+	}
 
 	/* Make sure the CPU won't try to retake the timekeeping duty */
 	tick_sched_timer_dying(dying_cpu);
-- 
2.53.0


