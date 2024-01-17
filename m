Return-Path: <cgroups+bounces-1149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D97B830AC1
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 17:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2451F29CDC
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 16:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED8C224C4;
	Wed, 17 Jan 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGlSJQ3j"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8632232D;
	Wed, 17 Jan 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508108; cv=none; b=CmuX8E3oEmtTzKUEa0W+/PU6zJ/rZgPT+RqH6dqU139jKH9yNknlx/8GoYkIvkgytNgTVAONp3MqJ+haY3aj25+eZC0lT0PsZSoYEOVpxhnB4LwUBfTNfKU5nU2ERK3aVrtxgmbcoIDya3MgAUzE9Nl1xYAxYt2LiGRV9NwaMpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508108; c=relaxed/simple;
	bh=eP1aE7eGJrI56wu/JUZuR/oHJxD8hIQm2thQjg7z0tE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=dT6BBTW2j2GO4hOlOpxYOEwh4LpSIeek2gfL5Q0CBrYwT/Th7OhMK9HyeTaMwU/PNS0Tz1TmsboLYw2tywGFWzWnEvSqwmiyNfKWqQ+4Iq6IFtBBVGUt8l4rDUV9gYrUFNGHO6rMEgzsIn/fKka4FbNInsFH1rVR4dgYNExP6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGlSJQ3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED50C43394;
	Wed, 17 Jan 2024 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705508108;
	bh=eP1aE7eGJrI56wu/JUZuR/oHJxD8hIQm2thQjg7z0tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGlSJQ3jQyZPQFC++EdqLNjVx8Yadpn7xElFro4BLyKUqFFpQuAncr1EOLlt3uyuI
	 +sxXmuKxtLjUOA+r4tkrjzwa0w2fXlZGffuba9K/H5yHuoLqmQz6tLk8/uuRsnNwvp
	 0OESLveyoKN0OwCncqn6LD6mHP7NTY6OGGx7qOg0g8puA1fNuqUsAJCkH0E6nK2ru8
	 j4UkgHz40xh0P0O1yVFYkRg0lALH6UXwp8Ff3UgZgnlfnXSn/RGd8P6ZwFHx957AUc
	 3JfjzKdG1G9q/wZM6RZ1qlXsBSPYbFSAjWGhKG1QGsZTEw1T2W7rDmqsCvi4cGD8dl
	 B1HUqFkOztYmA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Shakeel Butt <shakeelb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Vasily Averin <vasily.averin@linux.dev>,
	Michal Koutny <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Jiri Kosina <jikos@kernel.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
Date: Wed, 17 Jan 2024 08:14:43 -0800
Message-ID: <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705507931.git.jpoimboe@kernel.org>
References: <cover.1705507931.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A container can exceed its memcg limits by allocating a bunch of file
locks.

This bug was originally fixed by commit 0f12156dff28 ("memcg: enable
accounting for file lock caches"), but was later reverted by commit
3754707bcc3e ("Revert "memcg: enable accounting for file lock caches"")
due to performance issues.

Unfortunately those performance issues were never addressed and the bug
has remained unfixed for over two years.

Fix it by default but allow users to disable it with a cmdline option
(flock_accounting=off).

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 17 +++++++++++
 fs/locks.c                                    | 30 +++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6ee0f9a5da70..91987b06bc52 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1527,6 +1527,23 @@
 			See Documentation/admin-guide/sysctl/net.rst for
 			fb_tunnels_only_for_init_ns
 
+	flock_accounting=
+			[KNL] Enable/disable accounting for kernel
+			memory allocations related to file locks.
+			Format: { on | off }
+			Default: on
+			on:	Enable kernel memory accounting for file
+				locks.  This prevents task groups from
+				exceeding their memcg allocation limits.
+				However, it may cause slowdowns in the
+				flock() system call.
+			off:	Disable kernel memory accounting for
+				file locks.  This may allow a rogue task
+				to DoS the system by forcing the kernel
+				to allocate memory beyond the task
+				group's memcg limits.  Not recommended
+				unless you have trusted user space.
+
 	floppy=		[HW]
 			See Documentation/admin-guide/blockdev/floppy.rst.
 
diff --git a/fs/locks.c b/fs/locks.c
index cc7c117ee192..235ac56c557d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2905,15 +2905,41 @@ static int __init proc_locks_init(void)
 fs_initcall(proc_locks_init);
 #endif
 
+static bool flock_accounting __ro_after_init = true;
+
+static int __init flock_accounting_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off"))
+		flock_accounting = false;
+	else if (!strcmp(str, "on"))
+		flock_accounting = true;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("flock_accounting", flock_accounting_cmdline);
+
+#define FLOCK_ACCOUNTING_MSG "WARNING: File lock accounting is disabled, container-triggered host memory exhaustion possible!\n"
+
 static int __init filelock_init(void)
 {
 	int i;
+	slab_flags_t flags = SLAB_PANIC;
+
+	if (!flock_accounting)
+		pr_err(FLOCK_ACCOUNTING_MSG);
+	else
+		flags |= SLAB_ACCOUNT;
 
 	flctx_cache = kmem_cache_create("file_lock_ctx",
-			sizeof(struct file_lock_context), 0, SLAB_PANIC, NULL);
+			sizeof(struct file_lock_context), 0, flags, NULL);
 
 	filelock_cache = kmem_cache_create("file_lock_cache",
-			sizeof(struct file_lock), 0, SLAB_PANIC, NULL);
+			sizeof(struct file_lock), 0, flags, NULL);
 
 	for_each_possible_cpu(i) {
 		struct file_lock_list_struct *fll = per_cpu_ptr(&file_lock_list, i);
-- 
2.43.0


