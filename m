Return-Path: <cgroups+bounces-13820-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIFgFER+imnVLAAAu9opvQ
	(envelope-from <cgroups+bounces-13820-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 01:39:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E19115B2E
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 01:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53472303D673
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 00:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA26C265629;
	Tue, 10 Feb 2026 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Wbbg7Tp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6413F262808
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683919; cv=none; b=aIczzvw7cRq2keUs2SqI/TCZfa5rv8Dz9lDoQDB14UbEduNHtMsVvuSJXlW4j+x/B5F98wnz3z353bN9CEineajYqT8gYZ1jqeCsuCCFESUxvNA8/zNPYlA5O7FUspsyT0DsWpJR9j6f/lpi7Sim9QS7JDwDtkE+XN0WFdY2MUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683919; c=relaxed/simple;
	bh=1Qt94GB4G3IwGLclm8KcPaUi5sZ/Z6HPS+sk0iKFMzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oP1VXYVcNvzEfOg8+BhCl3sBkcmW9mXw4sHrrwlda/42Z8DErxleicEszV7wNRd1+nldrCxPOQZWNUkMsAtiFd2EeIE8oP1OvZ/vYg+3xxkrlabRqrolcPfJINW/CIR0WnuBl68uz1yWO0vPUBWdjsXgwv6QpvCCuJhAWOu42o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Wbbg7Tp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a944e6336eso7134815ad.0
        for <cgroups@vger.kernel.org>; Mon, 09 Feb 2026 16:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770683917; x=1771288717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0Pi0e7p+zApj87fVsFVxZlxRDj171oPkvxq1iRYRTY=;
        b=3Wbbg7TpK9Xu4R+smXq77Pzb8HFn3IhHQdo3ZV6vAs6likXrwBjBK41dNcCVDkh58z
         cP1nOCEVVxGa/wYoKfmOSEq024dYBTfezNYay4tVcZAHaq13u+ZrB+93HuMInfMiPBff
         Pga/Xacrj6YtpL5AjD0qzbrNHWz6wiMYD66jURzTKaON83LLmk4a23K5U60NMqXMBya0
         6LFGIovsI9sWyL2Vnt3P4UFDEWbDIxMBAV+vnxMPHrgfMEpsH1tpXvPLkb1d2wwXtnGo
         ZxkP/glCnhawW9n7i9rDxB2H4IBQ/AITXwts2NCj7cb3rAfmMWmmiYsS1I0ulnt0tPH7
         090A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683917; x=1771288717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0Pi0e7p+zApj87fVsFVxZlxRDj171oPkvxq1iRYRTY=;
        b=pGXyfuqZCtor9kgyrrS25xyRZdXZL/l4DLdQGlIhq1n0WzJDPgAGWcPRpTJJadCrgN
         ih98M57fvA1a/GuPqiGmXOrtCneiiXFw3AcKaMVuw6DPoUF71c8kL9YsWdmEk7x0o3oc
         DFq+eeZygRVa3AHZiB0dekrwzmm1nlRlXcdlKRVqSp9KX9plAMUwa5zjpDxpdRjgycJQ
         XFubvGa+6VJQ2l6IM13Xdhtx+w7XfHVt6913ZIxXMazUQEHF5fNNlYPdGocX3SoYklap
         n1M019TNZqtrEXiHohOYApcjCk/Trbjm3PkTKwmHyGRRSfdRoXwQKHZ/BFgFFPttVDFx
         zF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbXAbT7EKMhIlAr6K57X1Vi9pXa8KOlKlCQIVFUSbvTspVKwr9kT3AlFXTkKjQXkb7EUMP6vZI@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkjsvOcovAPcCGKhahk0DlhSQY9He4fP5mjvSll053W7v/r0c
	/OY/BxNahUSWLQIFxBEucTsrpKvCHuRnqe47Xedwo21xeY4lmb69dbf0jtQ/zYLxegd14tHhAOZ
	6bJ00YALboor+jOJjaw==
X-Received: from plzv5.prod.google.com ([2002:a17:902:b7c5:b0:2a8:759b:173d])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e744:b0:2a1:3cd9:a737 with SMTP id d9443c01a7336-2a95194698fmr165463975ad.36.1770683916818;
 Mon, 09 Feb 2026 16:38:36 -0800 (PST)
Date: Mon,  9 Feb 2026 16:38:01 -0800
In-Reply-To: <20260210003801.2834976-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260210003801.2834976-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210003801.2834976-4-tjmercier@google.com>
Subject: [PATCH 3/3] selftests: memcg: Add tests IN_DELETE_SELF and IN_IGNORED
 on memory.events
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13820-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3E19115B2E
X-Rspamd-Action: no action

Add two new tests that verify inotify events are sent when memcg files
are removed.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 .../selftests/cgroup/test_memcontrol.c        | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 4e1647568c5b..25a495347f7c 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -10,6 +10,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <sys/inotify.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
 #include <arpa/inet.h>
@@ -1625,6 +1626,129 @@ static int test_memcg_oom_group_score_events(const char *root)
 	return ret;
 }
 
+static int read_event(int inotify_fd, int expected_event, int expected_wd)
+{
+	struct inotify_event event;
+	ssize_t len = 0;
+
+	len = read(inotify_fd, &event, sizeof(event));
+	if (len < (ssize_t)sizeof(event))
+		return -1;
+
+	if (event.mask != expected_event || event.wd != expected_wd) {
+		fprintf(stderr,
+			"event does not match expected values: mask %d (expected %d) wd %d (expected %d)\n",
+			event.mask, expected_event, event.wd, expected_wd);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int test_memcg_inotify_delete_file(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg, *child_memcg;
+	int fd, wd;
+	struct inotify_event event;
+	ssize_t len = 0;
+
+	memcg = cg_name(root, "memcg_test_0");
+
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_write(memcg, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	child_memcg = cg_name(memcg, "child");
+	if (!child_memcg)
+		goto cleanup;
+
+	if (cg_create(child_memcg))
+		goto cleanup;
+
+	fd = inotify_init1(0);
+	if (fd == -1)
+		goto cleanup;
+
+	wd = inotify_add_watch(fd, cg_control(child_memcg, "memory.events"), IN_DELETE_SELF);
+	if (wd == -1)
+		goto cleanup;
+
+	cg_write(memcg, "cgroup.subtree_control", "-memory");
+
+	if (read_event(fd, IN_DELETE_SELF, wd))
+		goto cleanup;
+
+	if (read_event(fd, IN_IGNORED, wd))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	if (child_memcg)
+		cg_destroy(child_memcg);
+	free(child_memcg);
+	if (memcg)
+		cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+static int test_memcg_inotify_delete_rmdir(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg;
+	int fd, wd;
+	struct inotify_event event;
+	ssize_t len = 0;
+
+	memcg = cg_name(root, "memcg_test_0");
+
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	fd = inotify_init1(0);
+	if (fd == -1)
+		goto cleanup;
+
+	wd = inotify_add_watch(fd, cg_control(memcg, "memory.events"), IN_DELETE_SELF);
+	if (wd == -1)
+		goto cleanup;
+
+	if (cg_destroy(memcg))
+		goto cleanup;
+	free(memcg);
+	memcg = NULL;
+
+	if (read_event(fd, IN_DELETE_SELF, wd))
+		goto cleanup;
+
+	if (read_event(fd, IN_IGNORED, wd))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	if (memcg)
+		cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct memcg_test {
 	int (*fn)(const char *root);
@@ -1644,6 +1768,8 @@ struct memcg_test {
 	T(test_memcg_oom_group_leaf_events),
 	T(test_memcg_oom_group_parent_events),
 	T(test_memcg_oom_group_score_events),
+	T(test_memcg_inotify_delete_file),
+	T(test_memcg_inotify_delete_rmdir),
 };
 #undef T
 
-- 
2.53.0.rc2.204.g2597b5adb4-goog


