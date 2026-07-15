Return-Path: <cgroups+bounces-17817-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NM2EFJwEV2pYEQEAu9opvQ
	(envelope-from <cgroups+bounces-17817-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 05:55:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC43375A608
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 05:55:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ZlxNdZWy;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17817-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17817-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 579713010BD6
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 03:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8873B3BE6;
	Wed, 15 Jul 2026 03:55:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B103AD52A
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 03:55:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784087704; cv=none; b=QtdRhvbwzqqBLjgzOAF/iDUjGxU6zgB7QQBwm65/xEqySXu37yYxnX/Bcldd3Ke5kYA9tZwJk/hq3bowFk93YwxOS2waMQao5wwdn8R5ZBlDiI1+rGEfQaFF+MSEBmQaI5S9DDiS7vVdtvVK0Je/wbue4z9FM5XkyV8Jk2D6Xmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784087704; c=relaxed/simple;
	bh=ewdPb56xBjFmrnI7fXaoa7wPaFo1hdQQpES79KxD2+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQIAtMep6Me6vX+6aOgFySOTd1IkTAxmDZmGBz7aPV7vri6bsRDDL77yTn2OANChk5lqfKBRpUX2TnM/A8H6PJwx2nDYDmffq5tlSx2qbILhRdlez/tLT+PBjK30cXrePTvjPqutmiwEXzmwZn+M8Sbo7WDf8SOErPBDb+SP7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlxNdZWy; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784087701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GmK/PKs9sAs6/cDg4W7d1yX1cAFZHAmC6KiaUiX97ac=;
	b=ZlxNdZWyQRpKDcK5hL2FsCnk+cXTdztpQojJ8utJwGKILMUM45vdxtVEClEMM8DsjWzs7v
	gFpUhnp7aJGaLtJOxQTmVyHr03irsYP3Z0xk4AGK6WRg2ohzIa3bhjpAsd+T29rtOS/0G9
	sNKHvEP2EW/7iqyoCJOS/qrskbK6m1k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-Nqb5ZOT6P26dU6isF68nVQ-1; Tue,
 14 Jul 2026 23:54:59 -0400
X-MC-Unique: Nqb5ZOT6P26dU6isF68nVQ-1
X-Mimecast-MFC-AGG-ID: Nqb5ZOT6P26dU6isF68nVQ_1784087697
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 892741956089;
	Wed, 15 Jul 2026 03:54:57 +0000 (UTC)
Received: from llong-thinkpadp1gen5.rmtusnh.csb (unknown [10.22.89.63])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A402A30001A2;
	Wed, 15 Jul 2026 03:54:55 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] selftests/cgroup: Fix intermittent test_cgfreezer_ptrace test failures
Date: Tue, 14 Jul 2026 23:54:46 -0400
Message-ID: <20260715035446.565625-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17817-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC43375A608

It is found that the test_cgfreezer_ptrace test of test_freezer can
intermittently fail on some architectures like arm64 and ppc64.

After further tracing of the mechanics of the test_cgfreezer_ptrace test,
it is found that the ptrace(PTRACE_DETACH) call will spawn another process
to perform the detach by temporarily unfreezes the cgroup and then freezes
it again afterward during the detaching process. The reading of the
frozen flag from cgroup.events is done by the main test_freezer process
running probably on a different CPU. As a result, racing is possible and
the intermediate unfrozen state can be read leading to occasional test
failures especially on architectures with a weak memory model like arm64.

Fix that by using the cg_prepare_for_wait() and cg_wait_for() helpers to
wait until frozen state is set or it times out. A suppress_debug_msg flag
is added to suppress the printing of debug message when cg_check_frozen()
is used during this waiting process.

By running test_freezer 100 times in a loop, there were 28
test_cgfreezer_ptrace failures out of 100 on an arm64 test system before
the patch. After applying the patch, there was no test failure at all
in 100 runs of test_freezer.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/test_freezer.c | 41 +++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index 0569e93fa6b0..9edb2d34658c 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -14,9 +14,11 @@
 #include "kselftest.h"
 #include "cgroup_util.h"
 
+static bool suppress_debug_msg;
+
 #define DEBUG
 #ifdef DEBUG
-#define debug(args...) fprintf(stderr, args)
+#define debug(args...) do { if (!suppress_debug_msg) fprintf(stderr, args); } while (0)
 #else
 #define debug(args...)
 #endif
@@ -585,7 +587,8 @@ static int test_cgfreezer_ptrace(const char *root)
 	int ret = KSFT_FAIL;
 	char *cgroup = NULL;
 	siginfo_t siginfo;
-	int pid;
+	int fd = -1, pid, retries;
+	bool frozen;
 
 	cgroup = cg_name(root, "cg_test_ptrace");
 	if (!cgroup)
@@ -622,15 +625,47 @@ static int test_cgfreezer_ptrace(const char *root)
 	if (ptrace(PTRACE_GETSIGINFO, pid, NULL, &siginfo))
 		goto cleanup;
 
+	/*
+	 * The ptrace(PTRACE_DETACH) call spawns a different a process to
+	 * temporarily unfreeze the cgroup and then freeze it again in the
+	 * detaching process. The reading of the frozen flag from cgroup.events
+	 * is done by the main test process running probably on a different CPU.
+	 * As a result, racing is possible and the intermediate unfrozen state
+	 * can be read leading to occasional test failure especially on
+	 * architectures with a weak memory model like arm64.
+	 *
+	 * This intermittent test failure can be avoided by using the
+	 * cg_prepare_for_wait() and cg_wait_for() helpers to wait for change
+	 * in the frozen state if necessary.
+	 */
+	fd = cg_prepare_for_wait(cgroup);
+	if (fd < 0)
+		goto cleanup;
+
 	if (ptrace(PTRACE_DETACH, pid, NULL, NULL))
 		goto cleanup;
 
-	if (cg_check_frozen(cgroup, true))
+	suppress_debug_msg = true;
+	frozen = !cg_check_frozen(cgroup, true);
+	if (!frozen) {
+		/* Attempt to wait until frozen */
+		for (retries = 0; retries < 3; retries++) {
+			if (cg_wait_for(fd))
+				break;
+			frozen = !cg_check_frozen(cgroup, true);
+			if (frozen)
+				break;
+		}
+	}
+	suppress_debug_msg = false;
+	if (!frozen)
 		goto cleanup;
 
 	ret = KSFT_PASS;
 
 cleanup:
+	if (fd >= 0)
+		close(fd);
 	if (cgroup)
 		cg_destroy(cgroup);
 	free(cgroup);
-- 
2.55.0


