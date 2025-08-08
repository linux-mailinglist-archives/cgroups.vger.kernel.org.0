Return-Path: <cgroups+bounces-9042-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B27B1EBA4
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771F41AA325D
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3687283FF8;
	Fri,  8 Aug 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUeydMlR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27789283FE6
	for <cgroups@vger.kernel.org>; Fri,  8 Aug 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666439; cv=none; b=evGktzru3rCMeRZKXrD9jaCfMMOrO9w1eme+hw2GtT4Y6zqIenawpO9TfUCgP9a0AsVqdaBx61vkwZkluawUH49uS+w6Dz1/WHV5ii1cGsgqbyTyZGLvPtBIcggWnVi7tMJuwEsBkw8C725G6GCFP/ul8wlGUrLmx6YoRe3buys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666439; c=relaxed/simple;
	bh=XH0Af+hJDBkCAuw5puHAq55b47h+GZUhJtnbmXxuG6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dF76OMPBqnIktE6EsooRJWN5NI10VIbi+F3usJzg2vUdr8ed/dS83KLtNTwKYmLoIQ17xQ9SrON5sKRqeU4FfCEhDt4AsJBL43XuDPkrcgJr8rKLdND+bJeID8Yf/0GvnGz4SkrUAhfDA56nSZwCMJIcLRZfq5lVdUIrNgOQKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUeydMlR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754666437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WLvzJ5WiuMjAOAmYSD8iakpWVzO3E6xQqHPmy68LCM=;
	b=iUeydMlR2vN4JZe7V2sieyCsqfIt5O3kN4Cg7rLUUVbmJLUoAVxSx8GqyXmyEjPcOxj02L
	oTT5U0V4WjmFJkjRuCAflOsfimQ3g1NJ3QK3g8a43ewJlx+uShyUvkYRedeSMF8moXTsw+
	AEgXCJ73psWV1WG7Z27P54H1viv0e6I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-vUyb1KdwOIq-OmnUSqoLsA-1; Fri,
 08 Aug 2025 11:20:31 -0400
X-MC-Unique: vUyb1KdwOIq-OmnUSqoLsA-1
X-Mimecast-MFC-AGG-ID: vUyb1KdwOIq-OmnUSqoLsA_1754666421
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65E30180028C;
	Fri,  8 Aug 2025 15:20:21 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5657C1800294;
	Fri,  8 Aug 2025 15:20:14 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 10/18] sched/core: Ignore DL BW deactivation error if in cpuhp_offline_cb_mode
Date: Fri,  8 Aug 2025 11:19:53 -0400
Message-ID: <20250808152001.20245-1-longman@redhat.com>
In-Reply-To: <20250808151053.19777-1-longman@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

With the new strategy of using CPU hotplug to improve CPU isolation
and the optimization of delaying sched domain rebuild until the whole
process completes, we can run into a problem in shutting down the last
CPU of a partition and a -EBUSY error may be returned. This -EBUSY
error is caused by failing the DL BW check in dl_bw_deactivate().

As the CPU deactivation is only temporary and it will be brought back
up again in a short moment, there is no point in failing the operation
because of this DL BW error in this transitioning period. Fix this
problem by ignoring this error when in CPU hotplug offline callback mode
(cpuhp_offline_cb_mode is on).

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9f02c047e25b..78f4ba73a9f2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8469,7 +8469,11 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	ret = dl_bw_deactivate(cpu);
 
-	if (ret)
+	/*
+	 * Ignore DL BW error if in cpuhp offline callback mode as CPU
+	 * deactivation is only temporary.
+	 */
+	if (ret && !cpuhp_offline_cb_mode)
 		return ret;
 
 	/*
-- 
2.50.0


