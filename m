Return-Path: <cgroups+bounces-17261-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HZcWBG5FPGrdlwgAu9opvQ
	(envelope-from <cgroups+bounces-17261-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 23:00:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C016C1504
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 23:00:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=AYmG58KS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17261-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17261-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D308A300530A
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 21:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D303E5593;
	Wed, 24 Jun 2026 21:00:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF53383325
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 21:00:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334824; cv=none; b=gqGvu3Zkr6yhracqaetXLiCVE7vMu0H8nTGUrbhSF9e2bZ6HO7AZ3JDAMN0h2FU7YDrmd0wx2IbAbyFU9PVlU3aYNz17BdKak3itiPLhGpFcg0QAVIzs7/hst1kJENsKCTTP1DBFVdDOXZvIrSgtB5F+WQQ4OBcLBnK5U8VolQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334824; c=relaxed/simple;
	bh=oOzPfQ8MU/00LFm2r7y8jWt9hKtlQVtAxsDlbvTxWRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQRTS7+f4WE6dLVDuZZWYn6bw/ae3kaprwMGeC2az2+KO2WOr/V5hG3JqrJ5nlhTHlI+R7J5Ec3uE9G5g9hosp1ZCMMTQfwySBKiLwoqaPPxhKYHET5UHe7TDsj7MHzjF6K7b00jK/HBUECdCBDgmGztxJaQRF7cIrPhxRjxIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYmG58KS; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782334820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMQ0nznM8wN1stkcYCNXm7R4jfCmbMh7KKmvvxFD1ug=;
	b=AYmG58KSZaXbzhfSrys6z1Wrfe0o4gxgdQC0NUL5AERCSn58JkcZlSvJwWU0605USmk/vV
	OSK9H7T2AKFy+NqYCGjWuOSyPBCTI1pVCgWT2F3mt3FrIZo5h65QaRKtdNomOH+czkv3gD
	ye2thSrAalccwcbbuD94lH79J+PrWb8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-WDUMaqmaMuWPeQtF28-ckw-1; Wed,
 24 Jun 2026 17:00:16 -0400
X-MC-Unique: WDUMaqmaMuWPeQtF28-ckw-1
X-Mimecast-MFC-AGG-ID: WDUMaqmaMuWPeQtF28-ckw_1782334814
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56C9119540DF;
	Wed, 24 Jun 2026 21:00:13 +0000 (UTC)
Received: from [10.2.16.72] (unknown [10.2.16.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E67F01956041;
	Wed, 24 Jun 2026 21:00:09 +0000 (UTC)
Message-ID: <7fd8696e-c558-4050-b638-9416bef47722@redhat.com>
Date: Wed, 24 Jun 2026 17:00:08 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v5 0/6] cgroup/cpuset: Support multiple
 source/destination cpusets for cpuset_*attach()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260602023203.248077-1-longman@redhat.com>
 <ajv79c9bTlrGThdF@localhost.localdomain>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ajv79c9bTlrGThdF@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17261-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:chenridong@huaweicloud.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2C016C1504


On 6/24/26 11:51 AM, Michal Koutný wrote:
> On Mon, Jun 01, 2026 at 10:31:57PM -0400, Waiman Long <longman@redhat.com> wrote:
>> Patch 6 makes the necessary changes to enable the support of multiple
>> source and destination cpusets by keeping all the source and destination
>> cpusets found during task iterations in two singly linked lists for
>> source and destination cpusets respectively.
> Thanks for looking into this!
> I've played with a coding assistant and produced the following selftest
> (it (expectedly) fails on my machine), feel free to include in the
> series (if it validates the fix).

Thank for the provided selftest update. Will include that in the next 
version.

Cheers,
Longman

>
> -- 8< --
>  From ed4e6cf91413bb4b64befb1c15412c8cfd205d73 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
> Date: Wed, 24 Jun 2026 16:39:30 +0200
> Subject: [PATCH] selftests/cgroup: Add test for cpuset affinity on controller
>   disable
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> Add a new selftest that exposes a bug in cpuset_attach() where thread
> CPU affinity is not properly updated when the cpuset controller is
> disabled in a threaded cgroup hierarchy.
>
> The test creates a threaded cgroup hierarchy with two child cgroups
> (A and B) having different cpuset.cpus constraints:
> - Parent: cpuset.cpus=0-1
> - Child A: cpuset.cpus=0-1
> - Child B: cpuset.cpus=1 (restricted to CPU 1 only)
>
> A multithreaded process is created with threads placed in different
> cgroups. When the cpuset controller is disabled on the parent, thread
> affinities should be updated to match the parent's cpuset.
>
> Expected behavior:
> - thread_a affinity: {0-1} before and after (unchanged)
> - thread_b affinity: {1} before, {0-1} after (expanded)
>
> Current buggy behavior:
> - thread_b affinity remains {1} after controller disable
>
> Assisted-by: Claude:claude-sonnet-4-5
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   tools/testing/selftests/cgroup/test_cpuset.c | 243 +++++++++++++++++++
>   1 file changed, 243 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/test_cpuset.c b/tools/testing/selftests/cgroup/test_cpuset.c
> index c5cf8b56ceb8f..1d72a199ca552 100644
> --- a/tools/testing/selftests/cgroup/test_cpuset.c
> +++ b/tools/testing/selftests/cgroup/test_cpuset.c
> @@ -1,7 +1,13 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> +#define _GNU_SOURCE
> +#include <assert.h>
>   #include <linux/limits.h>
> +#include <pthread.h>
> +#include <sched.h>
>   #include <signal.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
>   
>   #include "kselftest.h"
>   #include "cgroup_util.h"
> @@ -232,6 +238,242 @@ static int test_cpuset_perms_subtree(const char *root)
>   	return ret;
>   }
>   
> +static int get_cpu_affinity(cpu_set_t *mask)
> +{
> +	CPU_ZERO(mask);
> +	return sched_getaffinity(0, sizeof(*mask), mask);
> +}
> +
> +static int cpu_set_equal(cpu_set_t *dst, unsigned long mask)
> +{
> +	cpu_set_t expected;
> +
> +	CPU_ZERO(&expected);
> +	assert(sizeof(mask) < CPU_SETSIZE);
> +
> +	for (int cpu = 0; cpu < sizeof(mask); ++cpu)
> +		if ((1UL << cpu) & mask)
> +			CPU_SET(cpu, &expected);
> +	
> +	return CPU_EQUAL(&expected, dst);
> +}
> +
> +enum test_phase {
> +	AFFINITY_SETUP,
> +	AFFINITY_THREAD_A_READY,
> +	AFFINITY_THREADS_READY,
> +	AFFINITY_CONTROLLER_DISABLED,
> +	AFFINITY_COMPLETE,
> +	AFFINITY_ERROR
> +};
> +
> +struct thread_args {
> +	const char *cgroup;
> +	cpu_set_t *affinity_before;
> +	cpu_set_t *affinity_after;
> +	enum test_phase ready_phase;
> +};
> +
> +static pthread_mutex_t test_mutex = PTHREAD_MUTEX_INITIALIZER;
> +static pthread_cond_t test_cond = PTHREAD_COND_INITIALIZER;
> +static enum test_phase test_phase;
> +
> +static void *affinity_thread_fn(void *arg)
> +{
> +	struct thread_args *args = (struct thread_args *)arg;
> +
> +	if (cg_enter_current_thread(args->cgroup))
> +		goto fail;
> +
> +	if (get_cpu_affinity(args->affinity_before) != 0)
> +		goto fail;
> +
> +	pthread_mutex_lock(&test_mutex);
> +	if (test_phase < args->ready_phase)
> +		test_phase = args->ready_phase;
> +	pthread_cond_broadcast(&test_cond);
> +
> +	while (test_phase < AFFINITY_CONTROLLER_DISABLED)
> +		pthread_cond_wait(&test_cond, &test_mutex);
> +	pthread_mutex_unlock(&test_mutex);
> +
> +	if (get_cpu_affinity(args->affinity_after) != 0)
> +		goto fail;
> +
> +
> +	return NULL;
> +
> +fail:
> +	pthread_mutex_lock(&test_mutex);
> +	test_phase = AFFINITY_ERROR;
> +	pthread_cond_broadcast(&test_cond);
> +	pthread_mutex_unlock(&test_mutex);
> +	return NULL;
> +}
> +
> +/*
> + * Test that disabling cpuset controller properly updates thread affinity.
> + *
> + * This test exposes a bug in cpuset_attach() where threads in child cgroups
> + * don't get their affinity updated when the cpuset controller is disabled.
> + *
> + * Setup:
> + * - Create parent cgroup with cpuset.cpus=0-1
> + * - Create child A with cpuset.cpus=0-1
> + * - Create child B with cpuset.cpus=1
> + * - Place multithreaded process: group leader + thread_a in A, thread_b in B
> + * - Disable cpuset controller on parent
> + *
> + * Expected: thread_b's affinity should expand from {1} to {0-1}
> + * Buggy: thread_b's affinity remains {1}
> + */
> +static int test_cpuset_affinity_on_controller_disable(const char *root)
> +{
> +	char *parent = NULL, *child_a = NULL, *child_b = NULL;
> +	pthread_t thread_a, thread_b;
> +	int thread_a_created = 0, thread_b_created = 0;
> +	cpu_set_t affinity_a_before, affinity_a_after;
> +	cpu_set_t affinity_b_before, affinity_b_after;
> +	int ret = KSFT_FAIL;
> +
> +	parent = cg_name(root, "cpuset_affinity_test");
> +	if (!parent)
> +		goto cleanup;
> +	if (cg_create(parent))
> +		goto cleanup;
> +	if (cg_write(parent, "cgroup.type", "threaded"))
> +		goto cleanup;
> +
> +	child_a = cg_name(parent, "A");
> +	if (!child_a)
> +		goto cleanup;
> +	if (cg_create(child_a))
> +		goto cleanup;
> +	if (cg_write(child_a, "cgroup.type", "threaded"))
> +		goto cleanup;
> +
> +	child_b = cg_name(parent, "B");
> +	if (!child_b)
> +		goto cleanup;
> +	if (cg_create(child_b))
> +		goto cleanup;
> +	if (cg_write(child_b, "cgroup.type", "threaded"))
> +		goto cleanup;
> +
> +	/* Now enable cpuset controller in parent */
> +	if (cg_write(parent, "cgroup.subtree_control", "+cpuset")) {
> +		ret = KSFT_SKIP;
> +		goto cleanup;
> +	}
> +
> +	/* Set CPU affinity constraints */
> +	if (cg_write(parent, "cpuset.cpus", "0-1"))
> +		goto cleanup;
> +	if (cg_write(child_a, "cpuset.cpus", "0-1"))
> +		goto cleanup;
> +	if (cg_write(child_b, "cpuset.cpus", "1"))
> +		goto cleanup;
> +
> +	/* Move group leader (main thread) to child A */
> +	if (cg_enter_current(child_a))
> +		goto cleanup;
> +
> +	/* Create threads - they will move themselves to their respective cgroups */
> +	test_phase = AFFINITY_SETUP;
> +
> +	struct thread_args args_a = {
> +		.cgroup = child_a,
> +		.affinity_before = &affinity_a_before,
> +		.affinity_after = &affinity_a_after,
> +		.ready_phase = AFFINITY_THREAD_A_READY,
> +	};
> +	if (pthread_create(&thread_a, NULL, affinity_thread_fn, &args_a))
> +		goto cleanup;
> +	thread_a_created = 1;
> +
> +	struct thread_args args_b = {
> +		.cgroup = child_b,
> +		.affinity_before = &affinity_b_before,
> +		.affinity_after = &affinity_b_after,
> +		.ready_phase = AFFINITY_THREADS_READY,
> +	};
> +	if (pthread_create(&thread_b, NULL, affinity_thread_fn, &args_b))
> +		goto cleanup_threads;
> +	thread_b_created = 1;
> +
> +	pthread_mutex_lock(&test_mutex);
> +	while (test_phase < AFFINITY_THREADS_READY)
> +		pthread_cond_wait(&test_cond, &test_mutex);
> +
> +	/* If a thread failed during setup, bail out */
> +	if (test_phase == AFFINITY_ERROR) {
> +		pthread_mutex_unlock(&test_mutex);
> +		goto cleanup_threads;
> +	}
> +	pthread_mutex_unlock(&test_mutex);
> +
> +	if (!cpu_set_equal(&affinity_a_before, 0x3)) {
> +		ksft_print_msg("FAIL: thread_a initial affinity incorrect\n");
> +		goto cleanup_threads;
> +	}
> +
> +	if (!cpu_set_equal(&affinity_b_before, 0x2)) {
> +		ksft_print_msg("FAIL: thread_b initial affinity incorrect\n");
> +		goto cleanup_threads;
> +	}
> +
> +	/* Disable cpuset controller - this should trigger affinity update */
> +	if (cg_write(parent, "cgroup.subtree_control", "-cpuset"))
> +		goto cleanup_threads;
> +
> +	/* Signal threads to save their final affinity and exit */
> +	pthread_mutex_lock(&test_mutex);
> +	test_phase = AFFINITY_CONTROLLER_DISABLED;
> +	pthread_cond_broadcast(&test_cond);
> +	pthread_mutex_unlock(&test_mutex);
> +
> +	pthread_join(thread_a, NULL);
> +	pthread_join(thread_b, NULL);
> +
> +	/* Verify thread affinities AFTER disabling controller */
> +	if (!cpu_set_equal(&affinity_a_after, 0x3)) {
> +		ksft_print_msg("FAIL: thread_a final affinity incorrect\n");
> +		goto cleanup;
> +	}
> +
> +	if (!cpu_set_equal(&affinity_b_after, 0x3)) {
> +		ksft_print_msg("FAIL: thread_b affinity did not expand to {0-1}\n");
> +		goto cleanup;
> +	}
> +
> +	ret = KSFT_PASS;
> +	goto cleanup;
> +
> +cleanup_threads:
> +	pthread_mutex_lock(&test_mutex);
> +	test_phase = AFFINITY_COMPLETE;
> +	pthread_cond_broadcast(&test_cond);
> +	pthread_mutex_unlock(&test_mutex);
> +
> +	if (thread_a_created)
> +		pthread_join(thread_a, NULL);
> +	if (thread_b_created)
> +		pthread_join(thread_b, NULL);
> +
> +cleanup:
> +	/* Move back to root before cleanup */
> +	cg_enter_current(root);
> +
> +	cg_destroy(child_b);
> +	free(child_b);
> +	cg_destroy(child_a);
> +	free(child_a);
> +	cg_destroy(parent);
> +	free(parent);
> +
> +	return ret;
> +}
> +
>   
>   #define T(x) { x, #x }
>   struct cpuset_test {
> @@ -241,6 +483,7 @@ struct cpuset_test {
>   	T(test_cpuset_perms_object_allow),
>   	T(test_cpuset_perms_object_deny),
>   	T(test_cpuset_perms_subtree),
> +	T(test_cpuset_affinity_on_controller_disable),
>   };
>   #undef T
>   


