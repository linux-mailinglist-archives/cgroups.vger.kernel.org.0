Return-Path: <cgroups+bounces-1150-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342FF830AC3
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 17:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E401F29D25
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7A2224F6;
	Wed, 17 Jan 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfNGTXOD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DBF224F1;
	Wed, 17 Jan 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508109; cv=none; b=m9HtLf3m8BEEchxTR20AnzzlAljwO9hlnDRHRxweU/ynMpd26mGvzc0XsafnJDYMiv/4mDhuadyMl1ma8vM3DUHD7fIXH2fS06KmKyqgX0RpNpvB0h73m667JinST7wGcTtSz998axQvwjof1s3bGKyMQ11pfsSWwDPZadop9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508109; c=relaxed/simple;
	bh=9hto33msnD5StAxQOT593RifYAulOEFb566w3+Gvz0Y=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=BfgtHBsGva4jA7vsuuJh8FHGCEB+hPTC7kKKiMrCzhVPbCZ5I4Cg/zQECofbGgJsoPGy7uIWj/VHpFrXq50rTUo0femiyoLEYN2/JXng/rIFiu3/WjpkEChpSXjvH0QxvFg9wc3TTb4lZjB/JlLrlhTJtYnQ4wwichVrhG2GJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfNGTXOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCCFC433A6;
	Wed, 17 Jan 2024 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705508108;
	bh=9hto33msnD5StAxQOT593RifYAulOEFb566w3+Gvz0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GfNGTXODLFiLsBVDsLJVvkfO5IV9m3xe3V1IyY9QDAunprrLmIybo1nR4EASgkYNV
	 ZxPQIlNRhxCRwAxYGZDieP3mteI7PlVqT6M6G9/8gAEmGLFszo/GkHXoVWxEhGCbWB
	 GfAdkBo2+ABWF5lVOu8hwXqwdmT5VxzE/6yKc717wIJmBUW6jziYmNUNHzx6b4t2EG
	 y0+BwYYFdCGNNt9/M+0W+hwybVBy5e4GnXZisSfO8fNh6gu7uDHmNFncKLj9IOS9av
	 RSGF7dBcaoqCcC/8kIJ8oaGkf89HJAPGrnkfu1IZJpIDSD/joHHVrBLAX3SfSL/BGF
	 v7PL8XppMBEmg==
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
Subject: [PATCH RFC 2/4] fs/locks: Add CONFIG_FLOCK_ACCOUNTING
Date: Wed, 17 Jan 2024 08:14:44 -0800
Message-ID: <e3e0323c6291c3ceab18f9e39bf772d98b29f81e.1705507931.git.jpoimboe@kernel.org>
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

Allow flock cache accounting to be disabled at build time.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 fs/Kconfig | 15 +++++++++++++++
 fs/locks.c |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index a3159831ba98..591f54a03059 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -129,6 +129,21 @@ config FILE_LOCKING
           for filesystems like NFS and for the flock() system
           call. Disabling this option saves about 11k.
 
+config FLOCK_ACCOUNTING
+	bool "Enable kernel memory accounting for file locks" if EXPERT
+	depends on FILE_LOCKING
+	default y
+	help
+	  This option enables kernel memory accounting for file locks.  This
+	  prevents task groups from exceeding their memcg allocation limits.
+	  However, it may cause slowdowns in the flock() system call.
+
+	  Disabling this option is not recommended as it may allow a rogue task
+	  to DoS the system by forcing the kernel to allocate memory beyond the
+	  task group's memcg limits.
+
+	  If unsure, say Y.
+
 source "fs/crypto/Kconfig"
 
 source "fs/verity/Kconfig"
diff --git a/fs/locks.c b/fs/locks.c
index 235ac56c557d..e2799a18c4e8 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2905,7 +2905,7 @@ static int __init proc_locks_init(void)
 fs_initcall(proc_locks_init);
 #endif
 
-static bool flock_accounting __ro_after_init = true;
+static bool flock_accounting __ro_after_init = IS_ENABLED(CONFIG_FLOCK_ACCOUNTING);
 
 static int __init flock_accounting_cmdline(char *str)
 {
-- 
2.43.0


