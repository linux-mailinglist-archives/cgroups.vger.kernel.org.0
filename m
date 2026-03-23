Return-Path: <cgroups+bounces-15006-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCsXLIujwWknUQQAu9opvQ
	(envelope-from <cgroups+bounces-15006-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 21:33:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 701172FD501
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 21:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DABF2308C831
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882D363C65;
	Mon, 23 Mar 2026 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbO8WRc5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FFF23B62B;
	Mon, 23 Mar 2026 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297710; cv=none; b=LBLweTzRrVZRFQYuSmXC9vglCLLfVaCv4Q+Gh4/vJBwSeyuqaidYEUaIX4ipjiVXd91+Uc68IG3xiHV9wkQPlKNuER/1xHkvN7KYQQ/tm+bMGIqFiS5wCllxHxOXwuE6DhmdzCJQjaghICd7wWvGfB2LoaHeAdKWwRs/rsIghhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297710; c=relaxed/simple;
	bh=4HmpqGCnc/JeGi5fqb9LLF+uG4EQxB9xOBgK4+WfF/Q=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Q2FTqcYXEim5/s9j4DOpcWMA68JK8fKj5BLQwk/Vo8wcA9DjcohSFq/AnaYW30Xn+36nhh/+qEdOjIPBFFS4n8NWgzZlfcr4ss5V2KosrBEDZugnVW1mBqToTsVivtnRM1cZ6LLN/VnXD2JCmYC1xHoZKD/1biqIJSv9eeNavTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbO8WRc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB64C4CEF7;
	Mon, 23 Mar 2026 20:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774297710;
	bh=4HmpqGCnc/JeGi5fqb9LLF+uG4EQxB9xOBgK4+WfF/Q=;
	h=Date:From:To:Cc:Subject:From;
	b=jbO8WRc5iz9Eo5OTfuqyOljM7W6kP6Mk/j12QzvCor9p18ZUCweZ2PfRvPAZ8hF6P
	 d815C2G8YJhQoQUdKf/f4f7U7BiZDwcpkWGXoCC5OCuhR0K4hQ2B0fuzsoVZnk8Yfn
	 PCghewzpikBWv8HzumKtmAWnrxM23acdFjvtaKW3m6gIguDmZyLEjLRTQLzh87Njq3
	 pNNkXxK5mSUzA1icj53Y1hLA4nUPYL2luwMRXOW6dgy9oPR7eORHLGiBTXwHEbQ3t0
	 Lf+2fXhBykBmBhn7sg4Q16o82vNecUQm2xn7OI7iujZ8arcqZnepTSdFoCdpIJsyRG
	 NYpL3fZrUbcSg==
Date: Mon, 23 Mar 2026 10:28:29 -1000
Message-ID: <49dca9aa15c6c46de60f1ba4ef2b25d0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Christian Brauner <brauner@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: [PATCH cgroup/for-7.0-fixes] selftests/cgroup: Don't test populated
 synchrony against task exit
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15006-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cgroup.events:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 701172FD501
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

test_cgcore_populated (test_core) and test_cgkill_{simple,tree,forkbomb}
(test_kill) check cgroup.events "populated 0" immediately after reaping
child tasks with waitpid(). This used to work because cgroup_task_exit() in
do_exit() unlinked tasks from css_sets before exit_notify() woke up
waitpid().

d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done
switching out") moved the unlink to cgroup_task_dead() in
finish_task_switch(), which runs after exit_notify(). The populated counter
is now decremented after the parent's waitpid() can return, so there is no
longer a synchronous ordering guarantee. On PREEMPT_RT, where
cgroup_task_dead() is further deferred through lazy irq_work, the race
window is even larger.

The synchronous populated transition was never part of the cgroup interface
contract - it was an implementation artifact. Use cg_read_strcmp_wait() which
retries for up to 1 second, matching what these tests actually need to
verify: that the cgroup eventually becomes unpopulated after all tasks exit.

Fixes: d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done switching out")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: cgroups@vger.kernel.org
---
 tools/testing/selftests/cgroup/lib/cgroup_util.c         | 15 +++++++++++++++
 tools/testing/selftests/cgroup/lib/include/cgroup_util.h |  2 ++
 tools/testing/selftests/cgroup/test_core.c               |  3 ++-
 tools/testing/selftests/cgroup/test_kill.c               |  7 ++++---
 4 files changed, 23 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -123,6 +123,21 @@ int cg_read_strcmp(const char *cgroup, c
 	return ret;
 }

+int cg_read_strcmp_wait(const char *cgroup, const char *control,
+			    const char *expected)
+{
+	int i, ret;
+
+	for (i = 0; i < 100; i++) {
+		ret = cg_read_strcmp(cgroup, control, expected);
+		if (!ret)
+			return ret;
+		usleep(10000);
+	}
+
+	return ret;
+}
+
 int cg_read_strstr(const char *cgroup, const char *control, const char *needle)
 {
 	char buf[PAGE_SIZE];
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -61,6 +61,8 @@ extern int cg_read(const char *cgroup, c
 		   char *buf, size_t len);
 extern int cg_read_strcmp(const char *cgroup, const char *control,
 			  const char *expected);
+extern int cg_read_strcmp_wait(const char *cgroup, const char *control,
+				   const char *expected);
 extern int cg_read_strstr(const char *cgroup, const char *control,
 			  const char *needle);
 extern long cg_read_long(const char *cgroup, const char *control);
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -233,7 +233,8 @@ static int test_cgcore_populated(const c
 	if (err)
 		goto cleanup;

-	if (cg_read_strcmp(cg_test_d, "cgroup.events", "populated 0\n"))
+	if (cg_read_strcmp_wait(cg_test_d, "cgroup.events",
+				   "populated 0\n"))
 		goto cleanup;

 	/* Remove cgroup. */
--- a/tools/testing/selftests/cgroup/test_kill.c
+++ b/tools/testing/selftests/cgroup/test_kill.c
@@ -86,7 +86,7 @@ cleanup:
 		wait_for_pid(pids[i]);

 	if (ret == KSFT_PASS &&
-	    cg_read_strcmp(cgroup, "cgroup.events", "populated 0\n"))
+	    cg_read_strcmp_wait(cgroup, "cgroup.events", "populated 0\n"))
 		ret = KSFT_FAIL;

 	if (cgroup)
@@ -190,7 +190,8 @@ cleanup:
 		wait_for_pid(pids[i]);

 	if (ret == KSFT_PASS &&
-	    cg_read_strcmp(cgroup[0], "cgroup.events", "populated 0\n"))
+	    cg_read_strcmp_wait(cgroup[0], "cgroup.events",
+				   "populated 0\n"))
 		ret = KSFT_FAIL;

 	for (i = 9; i >= 0 && cgroup[i]; i--) {
@@ -251,7 +252,7 @@ cleanup:
 		wait_for_pid(pid);

 	if (ret == KSFT_PASS &&
-	    cg_read_strcmp(cgroup, "cgroup.events", "populated 0\n"))
+	    cg_read_strcmp_wait(cgroup, "cgroup.events", "populated 0\n"))
 		ret = KSFT_FAIL;

 	if (cgroup)

