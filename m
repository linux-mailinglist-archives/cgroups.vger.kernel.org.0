Return-Path: <cgroups+bounces-17247-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +THAAT39O2q6hggAu9opvQ
	(envelope-from <cgroups+bounces-17247-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 17:52:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 514796BFCC7
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 17:52:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=LiyBVKWL;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17247-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17247-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 543E0300EAA4
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED603DA5A9;
	Wed, 24 Jun 2026 15:51:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3830C62D
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 15:51:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316285; cv=none; b=tc1WXA4JRtTDLthmNiKWybauRun4Adlpg6yWqysufvktYoGRFNSDS8nA6MdZx35nEMntr+4eEjNmfYmjeKbHH/x942sPi7efx0VvdzxpjneJqFEe3+jM4hWzjpF7JIuIPDh8ZEXYVqqxhxbYdbHL70BTXvtntniz1h7e89x8ZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316285; c=relaxed/simple;
	bh=SPSyKGFNqUlE00c799wH7mnKP2DkeNW0J3KraDUXkq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga0sn3bnhwAvCcQjsalSxqZFrGt+oByNymSvvSVAGNOBgJ3nKOSKHdtIdCwnJTM3QMcqgutIhzTx7tQGEaiey+3Vctft0uQ/ItKiydPMopHzLnWEtXnpqAWwybZh1yWe17n3zDktMmT6aI4ce5/2Mxvl/E0WWZy7cCAuakFjcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LiyBVKWL; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4624a44e152so1035167f8f.2
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782316282; x=1782921082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lDMWkskmjjy58meVllaXju4HrZ/TNfRubZ9JnOoUZ2A=;
        b=LiyBVKWLBI8pBAwACVffiHCkIZApUG7dh9d9D1GmybNJ6WaVll8qrREvPsXoPOVYkz
         vRxH+VuugeqE7znLmvocTBr4p0T//AEFxaQqb0FPKC5k320ixIZAO3iKqjWZuVFm4af4
         dDbbFEi5Mr0CCI3ei/EYJyv0glo56/PnowOZpDS9buHW+96ZLzooVFVUxXQA7QFB0f9t
         98xM4irEqyjNkV1CHYNAhL/3sXQXmo1EwVZ2xh/mqBA9WTNjo0g+3PWN/gbw+co4Ff7d
         tssa4FcldnN+jJ/LmVlTMPWnYEn9yx0UWMgxFu658ZsmWTIvDS9RXzeI1KDB90MWgtfK
         s0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782316282; x=1782921082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDMWkskmjjy58meVllaXju4HrZ/TNfRubZ9JnOoUZ2A=;
        b=hw34t8ZWyL4rc/5/kKXUrSDujSSR4KBt4o/C2uV18YL90WEABez9NytmTnuLLKHgDS
         0b7n63NPbH7p/bLglHX/tIxWEeNXHmjd/LQlYzJ53Jr81bkvZ78/L3z2lfn+apA/3bOb
         w13JngKTFaoxcubAX9QNN5ye33Ed+BQjFXo2GphSZFmrxiYI2fZCftaiJCQYlOvAobEp
         ey6BWLuGb4t5EglQorQceO8ToqX0FKldIHNgpOpsyzCoGVUUk2hSBMaOqsrRml877SOz
         2mGXQA/IzHfnxaFGhtDGy6PeGWxFCz1IjcVfICPr1ZFv28ZfhgnPa+k5e3Qz6mrSLDRl
         0vRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SclF8i0g5/43pXQ7e1a5ScdU1XjYIGS1ZMcDFaP/ViHDe85r8bey+VzQ8DpChmdIix1UyOid3@vger.kernel.org
X-Gm-Message-State: AOJu0YzgrprA4nKf0KdufKBY7SLIpA92Mvjt1nt13yGxvRBLNbkJMQ8W
	VgCBddeEEUFy391T/Kfz5fN9T/N2keeB7MN/qoBQ7zFkGrbWG/dkvvVT6rdMkx1hJS4=
X-Gm-Gg: AfdE7cn274kUhTqpWWwh6H9uaZXEYAsQgZU8bioCqjOQnPPqYMsGqyYtD2zLxBKjox2
	EeijpDvtq6XYv9W31Z1UM0Ja90mvLdYTgzW5xEfMsbyEq2EC/fPEanTYIEiHQWdgjA4Ghryso6J
	7TzVlfoeAQUsCaG+6wv/eRaHzyvhUmQzaIq3Zul1FDRk5Q17BaEmpVQzpdN/LxIu8+ENlcBw4Oe
	XfG8HLUpM4vGA7Nxtp2DP0ac4MH78XQMs7n3iz1oJ4XEOjDlMjgf8MaqK0T+Hk4MSRRvgWixzev
	zAJ3JtfP2UIoXTPbmHB3ejNBlas2xMvLYs9OyRLQsw6ljLMfke16v31VZnXVcqGcsO+Ou5Ub+17
	0H9Gc3+TI4qOHS6AZ6a2hxzVy6Mm+J0BELDsHV9ntO8ALOTQOlJIxd4R/ucN6V4Zbx/pdVdsSIf
	rAf+z8Q/fnm6tVAtWeDKxNllH0wTZG
X-Received: by 2002:a05:600c:e547:20b0:490:e19b:bd99 with SMTP id 5b1f17b1804b1-49260875a6emr44031825e9.30.1782316282320;
        Wed, 24 Jun 2026 08:51:22 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49264011f6fsm1890835e9.2.2026.06.24.08.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 08:51:21 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:51:20 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>, 
	Guopeng Zhang <guopeng.zhang@linux.dev>
Subject: Re: [PATCH-next v5 0/6] cgroup/cpuset: Support multiple
 source/destination cpusets for cpuset_*attach()
Message-ID: <ajv79c9bTlrGThdF@localhost.localdomain>
References: <20260602023203.248077-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u2eod7infvpbk4wg"
Content-Disposition: inline
In-Reply-To: <20260602023203.248077-1-longman@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17247-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:chenridong@huaweicloud.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:from_mime,vger.kernel.org:from_smtp,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 514796BFCC7


--u2eod7infvpbk4wg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH-next v5 0/6] cgroup/cpuset: Support multiple
 source/destination cpusets for cpuset_*attach()
MIME-Version: 1.0

On Mon, Jun 01, 2026 at 10:31:57PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Patch 6 makes the necessary changes to enable the support of multiple
> source and destination cpusets by keeping all the source and destination
> cpusets found during task iterations in two singly linked lists for
> source and destination cpusets respectively.

Thanks for looking into this!
I've played with a coding assistant and produced the following selftest
(it (expectedly) fails on my machine), feel free to include in the
series (if it validates the fix).

-- 8< --
=46rom ed4e6cf91413bb4b64befb1c15412c8cfd205d73 Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Michal=3D20Koutn=3DC3=3DBD?=3D <mkoutny@suse.com>
Date: Wed, 24 Jun 2026 16:39:30 +0200
Subject: [PATCH] selftests/cgroup: Add test for cpuset affinity on controll=
er
 disable
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Add a new selftest that exposes a bug in cpuset_attach() where thread
CPU affinity is not properly updated when the cpuset controller is
disabled in a threaded cgroup hierarchy.

The test creates a threaded cgroup hierarchy with two child cgroups
(A and B) having different cpuset.cpus constraints:
- Parent: cpuset.cpus=3D0-1
- Child A: cpuset.cpus=3D0-1
- Child B: cpuset.cpus=3D1 (restricted to CPU 1 only)

A multithreaded process is created with threads placed in different
cgroups. When the cpuset controller is disabled on the parent, thread
affinities should be updated to match the parent's cpuset.

Expected behavior:
- thread_a affinity: {0-1} before and after (unchanged)
- thread_b affinity: {1} before, {0-1} after (expanded)

Current buggy behavior:
- thread_b affinity remains {1} after controller disable

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Michal Koutn=FD <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/test_cpuset.c | 243 +++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_cpuset.c b/tools/testing/s=
elftests/cgroup/test_cpuset.c
index c5cf8b56ceb8f..1d72a199ca552 100644
--- a/tools/testing/selftests/cgroup/test_cpuset.c
+++ b/tools/testing/selftests/cgroup/test_cpuset.c
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
=20
+#define _GNU_SOURCE
+#include <assert.h>
 #include <linux/limits.h>
+#include <pthread.h>
+#include <sched.h>
 #include <signal.h>
+#include <sys/syscall.h>
+#include <unistd.h>
=20
 #include "kselftest.h"
 #include "cgroup_util.h"
@@ -232,6 +238,242 @@ static int test_cpuset_perms_subtree(const char *root)
 	return ret;
 }
=20
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
+	for (int cpu =3D 0; cpu < sizeof(mask); ++cpu)
+		if ((1UL << cpu) & mask)
+			CPU_SET(cpu, &expected);
+=09
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
+static pthread_mutex_t test_mutex =3D PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t test_cond =3D PTHREAD_COND_INITIALIZER;
+static enum test_phase test_phase;
+
+static void *affinity_thread_fn(void *arg)
+{
+	struct thread_args *args =3D (struct thread_args *)arg;
+
+	if (cg_enter_current_thread(args->cgroup))
+		goto fail;
+
+	if (get_cpu_affinity(args->affinity_before) !=3D 0)
+		goto fail;
+
+	pthread_mutex_lock(&test_mutex);
+	if (test_phase < args->ready_phase)
+		test_phase =3D args->ready_phase;
+	pthread_cond_broadcast(&test_cond);
+
+	while (test_phase < AFFINITY_CONTROLLER_DISABLED)
+		pthread_cond_wait(&test_cond, &test_mutex);
+	pthread_mutex_unlock(&test_mutex);
+
+	if (get_cpu_affinity(args->affinity_after) !=3D 0)
+		goto fail;
+
+
+	return NULL;
+
+fail:
+	pthread_mutex_lock(&test_mutex);
+	test_phase =3D AFFINITY_ERROR;
+	pthread_cond_broadcast(&test_cond);
+	pthread_mutex_unlock(&test_mutex);
+	return NULL;
+}
+
+/*
+ * Test that disabling cpuset controller properly updates thread affinity.
+ *
+ * This test exposes a bug in cpuset_attach() where threads in child cgrou=
ps
+ * don't get their affinity updated when the cpuset controller is disabled.
+ *
+ * Setup:
+ * - Create parent cgroup with cpuset.cpus=3D0-1
+ * - Create child A with cpuset.cpus=3D0-1
+ * - Create child B with cpuset.cpus=3D1
+ * - Place multithreaded process: group leader + thread_a in A, thread_b i=
n B
+ * - Disable cpuset controller on parent
+ *
+ * Expected: thread_b's affinity should expand from {1} to {0-1}
+ * Buggy: thread_b's affinity remains {1}
+ */
+static int test_cpuset_affinity_on_controller_disable(const char *root)
+{
+	char *parent =3D NULL, *child_a =3D NULL, *child_b =3D NULL;
+	pthread_t thread_a, thread_b;
+	int thread_a_created =3D 0, thread_b_created =3D 0;
+	cpu_set_t affinity_a_before, affinity_a_after;
+	cpu_set_t affinity_b_before, affinity_b_after;
+	int ret =3D KSFT_FAIL;
+
+	parent =3D cg_name(root, "cpuset_affinity_test");
+	if (!parent)
+		goto cleanup;
+	if (cg_create(parent))
+		goto cleanup;
+	if (cg_write(parent, "cgroup.type", "threaded"))
+		goto cleanup;
+
+	child_a =3D cg_name(parent, "A");
+	if (!child_a)
+		goto cleanup;
+	if (cg_create(child_a))
+		goto cleanup;
+	if (cg_write(child_a, "cgroup.type", "threaded"))
+		goto cleanup;
+
+	child_b =3D cg_name(parent, "B");
+	if (!child_b)
+		goto cleanup;
+	if (cg_create(child_b))
+		goto cleanup;
+	if (cg_write(child_b, "cgroup.type", "threaded"))
+		goto cleanup;
+
+	/* Now enable cpuset controller in parent */
+	if (cg_write(parent, "cgroup.subtree_control", "+cpuset")) {
+		ret =3D KSFT_SKIP;
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
+	/* Create threads - they will move themselves to their respective cgroups=
 */
+	test_phase =3D AFFINITY_SETUP;
+
+	struct thread_args args_a =3D {
+		.cgroup =3D child_a,
+		.affinity_before =3D &affinity_a_before,
+		.affinity_after =3D &affinity_a_after,
+		.ready_phase =3D AFFINITY_THREAD_A_READY,
+	};
+	if (pthread_create(&thread_a, NULL, affinity_thread_fn, &args_a))
+		goto cleanup;
+	thread_a_created =3D 1;
+
+	struct thread_args args_b =3D {
+		.cgroup =3D child_b,
+		.affinity_before =3D &affinity_b_before,
+		.affinity_after =3D &affinity_b_after,
+		.ready_phase =3D AFFINITY_THREADS_READY,
+	};
+	if (pthread_create(&thread_b, NULL, affinity_thread_fn, &args_b))
+		goto cleanup_threads;
+	thread_b_created =3D 1;
+
+	pthread_mutex_lock(&test_mutex);
+	while (test_phase < AFFINITY_THREADS_READY)
+		pthread_cond_wait(&test_cond, &test_mutex);
+
+	/* If a thread failed during setup, bail out */
+	if (test_phase =3D=3D AFFINITY_ERROR) {
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
+	test_phase =3D AFFINITY_CONTROLLER_DISABLED;
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
+	ret =3D KSFT_PASS;
+	goto cleanup;
+
+cleanup_threads:
+	pthread_mutex_lock(&test_mutex);
+	test_phase =3D AFFINITY_COMPLETE;
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
=20
 #define T(x) { x, #x }
 struct cpuset_test {
@@ -241,6 +483,7 @@ struct cpuset_test {
 	T(test_cpuset_perms_object_allow),
 	T(test_cpuset_perms_object_deny),
 	T(test_cpuset_perms_subtree),
+	T(test_cpuset_affinity_on_controller_disable),
 };
 #undef T
=20
--=20
2.54.0


--u2eod7infvpbk4wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajv88BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjIfgD/RX8bciHelzyg++c57ZdH
S1tSujKe4zgEddyO3XI03mQBAJGdmjU/EMaF0iq8OhaCD1gDbvlqILuYUxdEAUQn
JGAA
=964Z
-----END PGP SIGNATURE-----

--u2eod7infvpbk4wg--

