Return-Path: <cgroups+bounces-14050-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFdBN3v3l2k4+wIAu9opvQ
	(envelope-from <cgroups+bounces-14050-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 06:56:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20587164DC8
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 06:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B5503014928
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 05:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF7532E744;
	Fri, 20 Feb 2026 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvvK9z35"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF432E138
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566923; cv=none; b=Q4cJAQnlde1cQrbsbdsqL+ZHBefrZNffCwzXqkcEZOls7lVsRjFCmjm85vdOtVT0cAAI0ITK46hVPp5kKQsUdqgWH63BzRvGlS5oYHdQfncVxyefD9FgWsimnt0XR8XvNTSkP+aq8Zh631XZFGrH0JNmr1OEYDbZuJA28JV342k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566923; c=relaxed/simple;
	bh=ymKrZvnn1wXoX3MO7tLDPSCDvegTjqhP4f2VwqTSGPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J+IyoDGa4o8UfQAmGh5N2TIa7DgpTgNHIKVJMKaNK3lusKcatZVbcblFJHv8hPt9isiAW2ouMg2ZYOsT0fy0HqBeE8z434TLZ78JtYYEryi402QTsBu7ia5c+1Q5na8EERdA3bez/QFp7u6RJ81WsC5EDtN/oba4GsvOZjoyJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XvvK9z35; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c44bf176so1699786a91.0
        for <cgroups@vger.kernel.org>; Thu, 19 Feb 2026 21:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771566922; x=1772171722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLezOUj++5KtU+iy76kNFYSHOIOxW3z9n/oglLgyr0s=;
        b=XvvK9z3505mugn+OFk5vRK0PeXyyHS3SoBc1LZPu+8cqwFxy9MMW+kYvNulm3BBOJ6
         DiNn37woVS2EsgwigDMLm2kWjN8FF96sEeRnpGRSxKfRX5cl3lH8FeLpcgCzrEx3vmys
         k5lQ4+OC3W+VO8b0eNBaLHkXB8v3gXR+ASkhQdFB4AXPcljgSr3U8wKo1551VH0kGWhJ
         0riqvduSIVwYi7le9CrsKhf1mSVsNwUpZVcHLIo8jzqwCmcnSQmYidbwJWxA571zCaAL
         Ea4kqJag7fOCtinNADc+e45trP6k9bOYUtjJWfVqSbfh9BejsYdEGtJKauCOwlektk3e
         uLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771566922; x=1772171722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLezOUj++5KtU+iy76kNFYSHOIOxW3z9n/oglLgyr0s=;
        b=DTEPuyyp9+yJD+dT4btARnTWgp+FkIC4IzfJfz/Au3WQgWDzcxhiT+OT14m2XwMtcX
         nI3iDyYAKFly+sn9vfOAW7N2fo+ShTqSsG7P+6/7xEzkrniw6h/zIpUoGtX0Ec2XK/rO
         k+8X1286uAFxYxY111d2jkVwFP3Jy0Ujl8gdNdNe+ayl+6MeOLaA4hklQhuWHm9f7ZRk
         il3S/EW+LFDxDzfIsnQqjB3z/7rdbDWCIlq1gGmWsjkc5dFXbpoAXAwgZ/hsvir0Xdpj
         tGn0KYmFGv4JlufnJp3h4NuFs9oPDOdhBvbf7B2BSVveNWaNK9qTxl21zSJ7Ny6pFUck
         uHRw==
X-Forwarded-Encrypted: i=1; AJvYcCUbYjruVRxtRx5D+Tjs7ntOH3x9dOPPQ8P1edP6woA//NwX75ryL1jN3DzkBqadZrBh4LRPrvII@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcg/wS33BJmvZLyNkUyj1/NQ61SgSKyfrkILmmNGB4bcyE2t62
	klSZnvFALyZ2qn6urCmTTcJZOBLa5zShcomeXKSsIvWENLyPjQQ3qUxGi0ydZH7tfho6B5yl32W
	NFVS5o8tsbFOV+2+LkA==
X-Received: from pjmm7.prod.google.com ([2002:a17:90b:5807:b0:349:8a6d:dfd1])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:274c:b0:343:c3d1:8b9b with SMTP id 98e67ed59e1d1-35844f85b15mr17487949a91.19.1771566921614;
 Thu, 19 Feb 2026 21:55:21 -0800 (PST)
Date: Thu, 19 Feb 2026 21:54:48 -0800
In-Reply-To: <20260220055449.3073-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260220055449.3073-4-tjmercier@google.com>
Subject: [PATCH v4 3/3] selftests: memcg: Add tests for IN_DELETE_SELF and IN_IGNORED
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14050-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 20587164DC8
X-Rspamd-Action: no action

Add two new tests that verify inotify events are sent when memcg files
or directories are removed with rmdir.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 .../selftests/cgroup/test_memcontrol.c        | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 4e1647568c5b..57726bc82757 100644
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
@@ -1625,6 +1626,115 @@ static int test_memcg_oom_group_score_events(const char *root)
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
+	char *memcg = NULL;
+	int fd, wd;
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
+static int test_memcg_inotify_delete_dir(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg = NULL;
+	int fd, wd;
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
+	wd = inotify_add_watch(fd, memcg, IN_DELETE_SELF);
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
@@ -1644,6 +1754,8 @@ struct memcg_test {
 	T(test_memcg_oom_group_leaf_events),
 	T(test_memcg_oom_group_parent_events),
 	T(test_memcg_oom_group_score_events),
+	T(test_memcg_inotify_delete_file),
+	T(test_memcg_inotify_delete_dir),
 };
 #undef T
 
-- 
2.53.0.414.gf7e9f6c205-goog


