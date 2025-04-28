Return-Path: <cgroups+bounces-7861-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B14A9E6BA
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 05:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99961898D53
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 03:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DFC202C38;
	Mon, 28 Apr 2025 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GFoHq5dc"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3CC1FFC5F
	for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811429; cv=none; b=mDzrX722pYVkqLGvCH6MdvE5ZuyudoHhN9287/4DTHnM9lSklUg1yvcegQ7BIdDEKf7hZrUFtC8WgBFH28O5pwoC899iv8ARDtV5zS8OjxSW68eIIeTRzdA12K3Za/llriK1FT8mtv0mh9NXD0Nqn77SE7VIZF2WDQt3shVRB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811429; c=relaxed/simple;
	bh=on/5upKDQwIlgDrR9xUu6MT+jGsYtVSbHMqkx2gvLKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpbJYhFZ8B5VuEAr+jeLWBq94bgg64qcGDdodQ9zgq/KnzQf3ngLf34cG7uyO17IK3HYl9cM60h1vi155OJhdU30CoSEOx1ld6HViSBoW/ntObdSy1kHgIbG8Tqavp8oRXSkK1d90QWLdSr8lCrfVGZoyRY0t74XMxuYlBYGqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GFoHq5dc; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745811426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msMOLWNhdsitkHxfB8eybUZIVkvsiA7kEk7v+r38KUo=;
	b=GFoHq5dcQ1uvGTDy7BA4uNFas/fMqvlMu3PTWRSM5Xpm+2VVDbazr2X5JguDEvw4nzBsJN
	m3P7yw1F2qUugoTIVwS1rrY6sr8wbZiP0L4rPyw7+TYng0tBEI1wSGnIn1L49RE86nT0xA
	khTj52Zjw6SCGhFYo3s7wNtbwSdohYY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 11/12] bpf: selftests: introduce open_cgroup_file() helper
Date: Mon, 28 Apr 2025 03:36:16 +0000
Message-ID: <20250428033617.3797686-12-roman.gushchin@linux.dev>
In-Reply-To: <20250428033617.3797686-1-roman.gushchin@linux.dev>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement the open_cgroup_file() helper which opens a cgroup
control file with the given flags and returns a file descriptor.

It's useful when a test needs to do something more sophisticated
than read/write, e.g. listen for poll events or keep the file
descriptor open.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 28 ++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 3ffd4b764f91..50dbe4f45cb1 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -125,6 +125,34 @@ int enable_controllers(const char *relative_path, const char *controllers)
 	return __enable_controllers(cgroup_path, controllers);
 }
 
+static int __open_cgroup_file(const char *cgroup_path, const char *file,
+			      int flags)
+{
+	char file_path[PATH_MAX + 1];
+
+	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
+	return open(file_path, flags);
+}
+
+/**
+ * open_cgroup_file() - Open a cgroup file
+ * @relative_path: The cgroup path, relative to the workdir
+ * @file: The name of the file in cgroupfs to open to
+ * @flags: Flags
+ *
+ * Open a file in the given cgroup's directory.
+ *
+ * If successful, fd is returned.
+ */
+int open_cgroup_file(const char *relative_path, const char *file,
+		     int flags)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return __open_cgroup_file(cgroup_path, file, flags);
+}
+
 static size_t __read_cgroup_file(const char *cgroup_path, const char *file,
 				 char *buf, size_t size)
 {
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 821cb76db1f7..f45007d5fea5 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -11,6 +11,7 @@
 
 /* cgroupv2 related */
 int enable_controllers(const char *relative_path, const char *controllers);
+int open_cgroup_file(const char *relative_path, const char *file, int flags);
 size_t read_cgroup_file(const char *relative_path, const char *file,
 			char *buf, size_t size);
 int write_cgroup_file(const char *relative_path, const char *file,
-- 
2.49.0.901.g37484f566f-goog


