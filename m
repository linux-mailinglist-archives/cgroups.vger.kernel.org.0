Return-Path: <cgroups+bounces-1159-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15338830B48
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 17:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3287290721
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A424A03;
	Wed, 17 Jan 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFhCbP9B"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE724203
	for <cgroups@vger.kernel.org>; Wed, 17 Jan 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509386; cv=none; b=Xc9SGso9M8REP4GCSWAPCev9YeetY8bcdHglKsvPqMGJA9kj4ldsqLridvCgOp6/JS28MpKlFO1wy1YSKTZREF3VU8/OaRjiF+GowVEhmyMXml2riDDv6DAApBBuNmzr9q+UEt5opowcMi/slBvTdJX5VgqgTIALKK2Cflq1hPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509386; c=relaxed/simple;
	bh=RIu0wCoHEEwmwrWrI4fk2QwIf3Z4+DNKewqmZMfVEmc=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=bVMBG5+fo+PcBoJuGePunlbd8VPFM+y4uCQ025J9XKL4J7gqebSFFQOa5OYrFglJY/VpQW1rDx3tupz4/DmnUA+/bzlhwDt+W0qGCmqfdFzTBRwCjK418mnA3F6dsBUF4tZYULI1zSeY4XYVbFgzrKjFaR4c7v+1tw/jLdiEqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFhCbP9B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705509383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwiZxk2/LIns0OuqqkiNPgLv6/0v49jXf5KKeW3bftU=;
	b=RFhCbP9Bw2q/k2W09n2n0ioxQGwRyi92gtp+IXb7Adnl5n8E8jCH6c0UYU5Oi8DQEyqFTs
	1iLxgZx9t+CR8RkYyX3dTKyoqCaT3nOb86Hir/Ie3bzRm8GQ5TWR7v0Xg6KqcoQxZvWgJk
	R1rNnf7KOyaoUIGFEe2Xo+Z6zrXkKmU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-Ry1xxOizP6KjrjiwrnqQ_w-1; Wed, 17 Jan 2024 11:36:16 -0500
X-MC-Unique: Ry1xxOizP6KjrjiwrnqQ_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEFDB81DA88;
	Wed, 17 Jan 2024 16:36:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 272321121306;
	Wed, 17 Jan 2024 16:36:13 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Alex Gladkov <agladkov@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 6/8] cgroup/cpuset: Enable dynamic rcu_nocb mode on isolated CPUs
Date: Wed, 17 Jan 2024 11:35:09 -0500
Message-Id: <20240117163511.88173-7-longman@redhat.com>
In-Reply-To: <20240117163511.88173-1-longman@redhat.com>
References: <20240117163511.88173-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The patch adds RCU no-callback isolation mode dynamically to isolated
CPUs within isolated partitions when the full CPU isolation mode is
enabled. This isolation feature will only be available for use by cpuset
if the "rcu_nocb" boot command line option is specified in the kernel
command line with or without the optional CPU list argument.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d1d4ce213979..40bbb0a9cb84 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -218,6 +218,11 @@ enum isolated_cpus_modifiers {
  */
 static cpumask_var_t	isolated_cpus;
 
+/*
+ * rcu_nocb_mask set up at boot time.
+ */
+static cpumask_var_t	rcu_nocb_mask_preset;
+
 /*
  * Enable full CPU isolation in isolated partitions, if set.
  */
@@ -229,15 +234,26 @@ static bool isolation_full;
 static int isolation_flags;
 
 enum cpuset_isolation_types {
+	ISOL_TYPE_RCU,	/* RCU no-callback CPU mode */
 	ISOL_TYPE_MAX,
 };
 
+enum cpuset_isolation_flags {
+	ISOL_FLAG_RCU = BIT(ISOL_TYPE_RCU),
+};
+
 static const char * const isolation_type_names[ISOL_TYPE_MAX] = {
+	[ISOL_TYPE_RCU] = "rcu_nocbs",
 };
 
 /* Detect the cpuset isolation modes that can be enabled */
 static __init int set_isolation_flags(void)
 {
+	if (rcu_nocb_enabled(NULL)) {
+		BUG_ON(!zalloc_cpumask_var(&rcu_nocb_mask_preset, GFP_KERNEL));
+		(void)rcu_nocb_enabled(rcu_nocb_mask_preset);
+		isolation_flags |= ISOL_FLAG_RCU;
+	}
 	return 0;
 }
 late_initcall(set_isolation_flags);
@@ -1554,6 +1570,7 @@ static int partition_xcpus_del(int old_prs, struct cpuset *parent,
 static int update_isolation_cpumasks(struct cpumask *mask, int modifier)
 {
 	int err;
+	bool enable = (modifier == ISOL_CPUS_ADD);
 
 	lockdep_assert_cpus_held();
 
@@ -1569,6 +1586,25 @@ static int update_isolation_cpumasks(struct cpumask *mask, int modifier)
 	if (WARN_ON_ONCE(cpumask_empty(mask)))
 		return -EINVAL;
 
+	err = 0;
+	if (isolation_flags & ISOL_FLAG_RCU) {
+		/*
+		 * When disabling rcu_nocb, make sure that we don't touch any
+		 * CPUs that have already been set in rcu_nocb_mask_preset.
+		 */
+		if (!enable && cpumask_intersects(mask, rcu_nocb_mask_preset)) {
+			cpumask_var_t tmp_mask;
+
+			if (WARN_ON_ONCE(!alloc_cpumask_var(&tmp_mask, GFP_KERNEL)))
+				return -ENOMEM;
+			if (cpumask_andnot(tmp_mask, mask, rcu_nocb_mask_preset))
+				err = rcu_nocb_cpumask_update(tmp_mask, enable);
+			free_cpumask_var(tmp_mask);
+		} else {
+			err = rcu_nocb_cpumask_update(mask, enable);
+		}
+	}
+	WARN_ON_ONCE(err);
 	return err;
 }
 
-- 
2.39.3


