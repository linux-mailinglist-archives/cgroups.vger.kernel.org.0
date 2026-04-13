Return-Path: <cgroups+bounces-15264-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMTnCYaf3GkEUgkAu9opvQ
	(envelope-from <cgroups+bounces-15264-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:47:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C05623E87CA
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 536AD300CA2F
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585723A0EBB;
	Mon, 13 Apr 2026 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtNutOjz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6AC200C2
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066336; cv=none; b=jQMTq7cN0cKYYsexOxD090xj9sMaw565XAurtNHhEPLuuHpwsOVA2WuKLWfvNJj3And6N9/tSnlKmhW7ddrZ4lkgr+qimj/z8gZLcB/fH4SR5mr8Z0Rcn2Rls4itZYzCeLVIBqPoJMORR1Gb7B+mhxwxq6xBGXEPG1NTZqjwKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066336; c=relaxed/simple;
	bh=haYoKxwnQ4IkliWshHCYCJwKmzDfLZJY0fIFa30X7D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpAAQsC0f8qr9d8Sm2YYew0x9HtdNSUcHxWeIh22erlxShZgRJf8f2GKW3ovqywNwfYH2ZKpqNURLpfZrp7IfMoN/DbLnHirj6au7SNv60/qG5WsmQd2Gp6z5eXwSCmhnFUgUAB/qvIOAy+Sk26UdzL+glepbdbMVEdNJrBbk5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtNutOjz; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c287eb77fso3958963c88.1
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066334; x=1776671134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5M3+b2z7keZbGNN1L4pc5gbCusIv4rK3WbERlRAtRw=;
        b=JtNutOjzO9oL5iDsdBC2WRURLvOza8Hnh48XnYRktcHQj0XMOlIFZv7BP4/GAv1p9d
         jzUctCWVdvbcpeoHI/bSYVebPKQVNJE8+AnoT8b3T7ENh8N2A0IhXRHLgXUS7/y1akHG
         m5KfcN4WQYfa/WEVarvT9NSh51qmOQbT8m6xpP/RbJcHDxgYfbet1z14ouOv9HN3UbvD
         LlAqgrsVcUXQHURb6mlYqNeO9lAYdMCmiNYvkUnfof05zveFEfF8VFiVLxuqYHy99dhH
         SMEaWYH4zOvN70tMNyrh+no03GZUN1b9/5zXWtU6XjkeGVk9hgQwuU+8MdGN11BJSq5E
         a4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066334; x=1776671134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5M3+b2z7keZbGNN1L4pc5gbCusIv4rK3WbERlRAtRw=;
        b=g+K55e9AGcJ9Bo3yXUeFIW6154MBa0fJNipZI8gMz06pGU/8qRugwa56DOW9f7RELW
         yXx8yEQHdC33FPSAFPuV4Y/UMlmkH8JGLJu0xFfj7nmdFLZdi0KSOQN4ULi3bGgeAZpl
         9k9Lj07XpFtvm8uiE4OL6+yG5fc7ssUYTQjHrA7Uu/QJX6aLWarloc5NG9Nlt+AE6687
         sWVSwmbc+f0NFGGl0HPf81xMFxFfA6dyrqs+hDKwdxtrPA2v2F7jwIEnvjS7aOfI0ZnQ
         ge6ajAZD6culd7Wk/hKZk8KHaSS6rucxd0h3Aw/8+qH9ePpr4ddG/6KrNcM77rt5nkDi
         eCZw==
X-Forwarded-Encrypted: i=1; AFNElJ+N9gzvA/3G2YJ0Pr6+uxHmzMFgqz5Uqqk87sujBUNkbRBI5WYS1fey9ShfuZ/VIJXeJ/IBTuE7@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpwTS1ycwGUfwaOpXeQaHysds/t7kj8cWiP1axCa2Qof7fWJH
	ihCygiwWa5A/X2K0sgD6vhUDdVvDJdLbFZregPE2kkrl4Y6tColRCaUw
X-Gm-Gg: AeBDievc7NmfJuMxkKJkS44CuU+YCrzBzuYCsvpiS99EOk8AKwXvY2I7Szkik3yHAKF
	Upcz91JXkbC2JL3RftTIuQ3OQTPyj5N+Nos9kJF1W3Cvr/MCoz7oba0L9utaC64h1F1GNeYsxYR
	LDs+aXanW7AoTY01KjWaiFgwG6Sc50mzofMq4vL5yalZT5WE15Wj6iVYWkBtkLxW6GwMJH6vFJa
	U3tqvfpzRwZQ0ue5Oj9S0t2vWO5v17kxu0lWoVhl27U2LdwjuPRPA5m+P3kOa4a0nGSED65k4L8
	8eqqzb+yK4s6c/7+tCxCCmwNAaLKHTN9033k1d2UyLC2CLbinZxMCYT19UBhBcKSf2FfJsOPn0r
	NZMP7xTXEKBxMFGOB19Ngh2Rt589m59ZK6ioFRPTmfy8qG0VTDLroiB8Zr8I/6kVz+5Qxq4fSLm
	a+Gwb3W+jejvzEyf1L
X-Received: by 2002:a05:7022:e1b:b0:128:d107:da0f with SMTP id a92af1059eb24-12c34ea9471mr6689826c88.10.1776066333988;
        Mon, 13 Apr 2026 00:45:33 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:45:33 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:18 +0800
Subject: [PATCH v2 12/12] selftests: cgroup: Add functional tests for
 dynamic housekeeping
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-12-06df21caba5d@gmail.com>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
In-Reply-To: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15264-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C05623E87CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This extends the cgroup v2 testing framework in selftests to validate the
newly added Dynamic Housekeeping Management (DHM) cpuset interface:
`cpuset.housekeeping.cpus` and `cpuset.housekeeping.smt_aware`.

The `test_cpuset_housekeeping` functional test verifies:
- Validation of DHM's SMT safety guard (`cpuset.housekeeping.smt_aware`)
  by ensuring writing to it behaves as expected.
- Basic read and write capabilities of `cpuset.housekeeping.cpus` using
  the base CPU mask.

If the DHM functionality is not present in the kernel, the selftest skips gracefully.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 tools/testing/selftests/cgroup/test_cpuset.c | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_cpuset.c b/tools/testing/selftests/cgroup/test_cpuset.c
index c5cf8b56ceb8f..b2a032be4407a 100644
--- a/tools/testing/selftests/cgroup/test_cpuset.c
+++ b/tools/testing/selftests/cgroup/test_cpuset.c
@@ -232,6 +232,41 @@ static int test_cpuset_perms_subtree(const char *root)
 	return ret;
 }
 
+static int test_cpuset_housekeeping(const char *root)
+{
+	char buf[PAGE_SIZE];
+	int ret = KSFT_FAIL;
+
+	/* If the kernel doesn't have DHM patch, skip */
+	if (cg_read(root, "cpuset.housekeeping.cpus", buf, sizeof(buf)))
+		return KSFT_SKIP;
+
+	/* Test writing 1 and 0 to smt_aware */
+	if (cg_write(root, "cpuset.housekeeping.smt_aware", "1"))
+		goto cleanup;
+
+	if (cg_read_strstr(root, "cpuset.housekeeping.smt_aware", "1"))
+		goto cleanup;
+
+	if (cg_write(root, "cpuset.housekeeping.smt_aware", "0"))
+		goto cleanup;
+
+	if (cg_read_strstr(root, "cpuset.housekeeping.smt_aware", "0"))
+		goto cleanup;
+
+	/* Read root cpuset.cpus.effective */
+	if (cg_read(root, "cpuset.cpus.effective", buf, sizeof(buf)))
+		goto cleanup;
+	
+	/* Write it back to housekeeping.cpus */
+	if (cg_write(root, "cpuset.housekeeping.cpus", buf))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	return ret;
+}
 
 #define T(x) { x, #x }
 struct cpuset_test {
@@ -241,6 +276,7 @@ struct cpuset_test {
 	T(test_cpuset_perms_object_allow),
 	T(test_cpuset_perms_object_deny),
 	T(test_cpuset_perms_subtree),
+	T(test_cpuset_housekeeping),
 };
 #undef T
 

-- 
2.43.0


