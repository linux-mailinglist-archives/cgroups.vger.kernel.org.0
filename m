Return-Path: <cgroups+bounces-17680-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1ZSWKcEpVGrdiwMAu9opvQ
	(envelope-from <cgroups+bounces-17680-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 01:56:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9007464D3
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 01:56:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YwkN511r;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17680-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17680-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D29A302F3BA
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 23:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC73038E8B1;
	Sun, 12 Jul 2026 23:55:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56B38E8A2
	for <cgroups@vger.kernel.org>; Sun, 12 Jul 2026 23:55:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783900536; cv=none; b=gSR1wRs/OlWd4o6Mjb9QIO6/vewLADbRoc4vhZKpxTk57Juv1eLSbhzjSIR+Yxw76g628Jvty3YKCfiBAxFTTHJCvj5OkzYZ4PtVePzAdYWiMxSJuwZsgKYxtbIrgwSAc+Urm/hGqOBX21ekDeCT2+NSMdSMRjkwcbOen9IgMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783900536; c=relaxed/simple;
	bh=U3XeUnEL+rDTz+vN8wgmKNKJy9pBXpmiepr3NAb/tR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1ROBYfY4JvgL2rqEbMjk748NO2/YsTHqui7NYT5fDiuTBo+gS9aSBAHz27vvaY5EsEJljYKLdNAQ0dtBdaR9evbqHejYzGg96ImuQYX2QGoOIiBMaQdyDmOxbTcIfr9aIkTpUVCJTFEtqxy5xYu+afX2cbWA9cgEoxweb87hAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwkN511r; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783900533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Qe+95+MXsZNLDf2pjnP57V9Q3yNl9VozQHNGuksZog=;
	b=YwkN511rsygTTr7Vr16OUUm2wNGLsaXFzEzrPMGuKiEQDO/KfATqKQVJH06CckWBaV7OOr
	Y3HQdrhcckp5FvgEFH7f0D3Ovxq+fUMqcYUujUn9iU1s7IGNU/Hw0u8QmpNOPafI6o9Kou
	MLEscewu316OhqBk6W+lASa147fhbc4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-wHXFajveP5GcYtICJqWLIw-1; Sun,
 12 Jul 2026 19:55:30 -0400
X-MC-Unique: wHXFajveP5GcYtICJqWLIw-1
X-Mimecast-MFC-AGG-ID: wHXFajveP5GcYtICJqWLIw_1783900528
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DD2A18002C3;
	Sun, 12 Jul 2026 23:55:28 +0000 (UTC)
Received: from llong-thinkpadp1gen5.rmtusnh.csb (unknown [10.22.80.43])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B52C1956053;
	Sun, 12 Jul 2026 23:55:26 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v3 3/3] selftests/cgroup: Add test for cpuset affinity on controller disable
Date: Sun, 12 Jul 2026 19:55:10 -0400
Message-ID: <20260712235510.373125-4-longman@redhat.com>
In-Reply-To: <20260712235510.373125-1-longman@redhat.com>
References: <20260712235510.373125-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17680-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C9007464D3

From: Michal Koutný <mkoutny@suse.com>

Add a new selftest that exposes a bug in cpuset_attach() where thread
CPU affinity is not properly updated when the cpuset controller is
disabled in a threaded cgroup hierarchy.

The test creates a threaded cgroup hierarchy with two child cgroups
(A and B) having different cpuset.cpus constraints:
- Parent: cpuset.cpus=0-1
- Child A: cpuset.cpus=0-1
- Child B: cpuset.cpus=1 (restricted to CPU 1 only)

A multithreaded process is created with threads placed in different
cgroups. When the cpuset controller is disabled on the parent, thread
affinities should be updated to match the parent's cpuset.

Expected behavior:
- thread_a affinity: {0-1} before and after (unchanged)
- thread_b affinity: {1} before, {0-1} after (expanded)

Current buggy behavior:
- thread_b affinity remains {1} after controller disable

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/test_cpuset.c | 243 +++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_cpuset.c b/tools/testing/selftests/cgroup/test_cpuset.c
index c5cf8b56ceb8..8b4c4a9dd78b 100644
--- a/tools/testing/selftests/cgroup/test_cpuset.c
+++ b/tools/testing/selftests/cgroup/test_cpuset.c
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define _GNU_SOURCE
+#include <assert.h>
 #include <linux/limits.h>
+#include <pthread.h>
+#include <sched.h>
 #include <signal.h>
+#include <sys/syscall.h>
+#include <unistd.h>
 
 #include "kselftest.h"
 #include "cgroup_util.h"
@@ -232,6 +238,242 @@ static int test_cpuset_perms_subtree(const char *root)
 	return ret;
 }
 
+static int get_cpu_affinity(cpu_set_t *mask)
+{
+	CPU_ZERO(mask);
+	return sched_getaffinity(0, sizeof(*mask), mask);
+}
+
+static int cpu_set_equal(cpu_set_t *dst, unsigned long mask)
+{
+	cpu_set_t expected;
+
+	CPU_ZERO(&expected);
+	assert(sizeof(mask) < CPU_SETSIZE);
+
+	for (int cpu = 0; cpu < sizeof(mask); ++cpu)
+		if ((1UL << cpu) & mask)
+			CPU_SET(cpu, &expected);
+
+	return CPU_EQUAL(&expected, dst);
+}
+
+enum test_phase {
+	AFFINITY_SETUP,
+	AFFINITY_THREAD_A_READY,
+	AFFINITY_THREADS_READY,
+	AFFINITY_CONTROLLER_DISABLED,
+	AFFINITY_COMPLETE,
+	AFFINITY_ERROR
+};
+
+struct thread_args {
+	const char *cgroup;
+	cpu_set_t *affinity_before;
+	cpu_set_t *affinity_after;
+	enum test_phase ready_phase;
+};
+
+static pthread_mutex_t test_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t test_cond = PTHREAD_COND_INITIALIZER;
+static enum test_phase test_phase;
+
+static void *affinity_thread_fn(void *arg)
+{
+	struct thread_args *args = (struct thread_args *)arg;
+
+	if (cg_enter_current_thread(args->cgroup))
+		goto fail;
+
+	if (get_cpu_affinity(args->affinity_before) != 0)
+		goto fail;
+
+	pthread_mutex_lock(&test_mutex);
+	if (test_phase < args->ready_phase)
+		test_phase = args->ready_phase;
+	pthread_cond_broadcast(&test_cond);
+
+	while (test_phase < AFFINITY_CONTROLLER_DISABLED)
+		pthread_cond_wait(&test_cond, &test_mutex);
+	pthread_mutex_unlock(&test_mutex);
+
+	if (get_cpu_affinity(args->affinity_after) != 0)
+		goto fail;
+
+
+	return NULL;
+
+fail:
+	pthread_mutex_lock(&test_mutex);
+	test_phase = AFFINITY_ERROR;
+	pthread_cond_broadcast(&test_cond);
+	pthread_mutex_unlock(&test_mutex);
+	return NULL;
+}
+
+/*
+ * Test that disabling cpuset controller properly updates thread affinity.
+ *
+ * This test exposes a bug in cpuset_attach() where threads in child cgroups
+ * don't get their affinity updated when the cpuset controller is disabled.
+ *
+ * Setup:
+ * - Create parent cgroup with cpuset.cpus=0-1
+ * - Create child A with cpuset.cpus=0-1
+ * - Create child B with cpuset.cpus=1
+ * - Place multithreaded process: group leader + thread_a in A, thread_b in B
+ * - Disable cpuset controller on parent
+ *
+ * Expected: thread_b's affinity should expand from {1} to {0-1}
+ * Buggy: thread_b's affinity remains {1}
+ */
+static int test_cpuset_affinity_on_controller_disable(const char *root)
+{
+	char *parent = NULL, *child_a = NULL, *child_b = NULL;
+	pthread_t thread_a, thread_b;
+	int thread_a_created = 0, thread_b_created = 0;
+	cpu_set_t affinity_a_before, affinity_a_after;
+	cpu_set_t affinity_b_before, affinity_b_after;
+	int ret = KSFT_FAIL;
+
+	parent = cg_name(root, "cpuset_affinity_test");
+	if (!parent)
+		goto cleanup;
+	if (cg_create(parent))
+		goto cleanup;
+	if (cg_write(parent, "cgroup.type", "threaded"))
+		goto cleanup;
+
+	child_a = cg_name(parent, "A");
+	if (!child_a)
+		goto cleanup;
+	if (cg_create(child_a))
+		goto cleanup;
+	if (cg_write(child_a, "cgroup.type", "threaded"))
+		goto cleanup;
+
+	child_b = cg_name(parent, "B");
+	if (!child_b)
+		goto cleanup;
+	if (cg_create(child_b))
+		goto cleanup;
+	if (cg_write(child_b, "cgroup.type", "threaded"))
+		goto cleanup;
+
+	/* Now enable cpuset controller in parent */
+	if (cg_write(parent, "cgroup.subtree_control", "+cpuset")) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	/* Set CPU affinity constraints */
+	if (cg_write(parent, "cpuset.cpus", "0-1"))
+		goto cleanup;
+	if (cg_write(child_a, "cpuset.cpus", "0-1"))
+		goto cleanup;
+	if (cg_write(child_b, "cpuset.cpus", "1"))
+		goto cleanup;
+
+	/* Move group leader (main thread) to child A */
+	if (cg_enter_current(child_a))
+		goto cleanup;
+
+	/* Create threads - they will move themselves to their respective cgroups */
+	test_phase = AFFINITY_SETUP;
+
+	struct thread_args args_a = {
+		.cgroup = child_a,
+		.affinity_before = &affinity_a_before,
+		.affinity_after = &affinity_a_after,
+		.ready_phase = AFFINITY_THREAD_A_READY,
+	};
+	if (pthread_create(&thread_a, NULL, affinity_thread_fn, &args_a))
+		goto cleanup;
+	thread_a_created = 1;
+
+	struct thread_args args_b = {
+		.cgroup = child_b,
+		.affinity_before = &affinity_b_before,
+		.affinity_after = &affinity_b_after,
+		.ready_phase = AFFINITY_THREADS_READY,
+	};
+	if (pthread_create(&thread_b, NULL, affinity_thread_fn, &args_b))
+		goto cleanup_threads;
+	thread_b_created = 1;
+
+	pthread_mutex_lock(&test_mutex);
+	while (test_phase < AFFINITY_THREADS_READY)
+		pthread_cond_wait(&test_cond, &test_mutex);
+
+	/* If a thread failed during setup, bail out */
+	if (test_phase == AFFINITY_ERROR) {
+		pthread_mutex_unlock(&test_mutex);
+		goto cleanup_threads;
+	}
+	pthread_mutex_unlock(&test_mutex);
+
+	if (!cpu_set_equal(&affinity_a_before, 0x3)) {
+		ksft_print_msg("FAIL: thread_a initial affinity incorrect\n");
+		goto cleanup_threads;
+	}
+
+	if (!cpu_set_equal(&affinity_b_before, 0x2)) {
+		ksft_print_msg("FAIL: thread_b initial affinity incorrect\n");
+		goto cleanup_threads;
+	}
+
+	/* Disable cpuset controller - this should trigger affinity update */
+	if (cg_write(parent, "cgroup.subtree_control", "-cpuset"))
+		goto cleanup_threads;
+
+	/* Signal threads to save their final affinity and exit */
+	pthread_mutex_lock(&test_mutex);
+	test_phase = AFFINITY_CONTROLLER_DISABLED;
+	pthread_cond_broadcast(&test_cond);
+	pthread_mutex_unlock(&test_mutex);
+
+	pthread_join(thread_a, NULL);
+	pthread_join(thread_b, NULL);
+
+	/* Verify thread affinities AFTER disabling controller */
+	if (!cpu_set_equal(&affinity_a_after, 0x3)) {
+		ksft_print_msg("FAIL: thread_a final affinity incorrect\n");
+		goto cleanup;
+	}
+
+	if (!cpu_set_equal(&affinity_b_after, 0x3)) {
+		ksft_print_msg("FAIL: thread_b affinity did not expand to {0-1}\n");
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+	goto cleanup;
+
+cleanup_threads:
+	pthread_mutex_lock(&test_mutex);
+	test_phase = AFFINITY_COMPLETE;
+	pthread_cond_broadcast(&test_cond);
+	pthread_mutex_unlock(&test_mutex);
+
+	if (thread_a_created)
+		pthread_join(thread_a, NULL);
+	if (thread_b_created)
+		pthread_join(thread_b, NULL);
+
+cleanup:
+	/* Move back to root before cleanup */
+	cg_enter_current(root);
+
+	cg_destroy(child_b);
+	free(child_b);
+	cg_destroy(child_a);
+	free(child_a);
+	cg_destroy(parent);
+	free(parent);
+
+	return ret;
+}
+
 
 #define T(x) { x, #x }
 struct cpuset_test {
@@ -241,6 +483,7 @@ struct cpuset_test {
 	T(test_cpuset_perms_object_allow),
 	T(test_cpuset_perms_object_deny),
 	T(test_cpuset_perms_subtree),
+	T(test_cpuset_affinity_on_controller_disable),
 };
 #undef T
 
-- 
2.55.0


