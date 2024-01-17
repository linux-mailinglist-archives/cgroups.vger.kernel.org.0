Return-Path: <cgroups+bounces-1151-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3857C830AC7
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 17:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABAE41F215DB
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7422EED;
	Wed, 17 Jan 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maEHAzHm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403822638;
	Wed, 17 Jan 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508111; cv=none; b=PIgYJawRp8KGcLl1nPR7I2ndMWRaRL/807XYJOcQWTgOYaxXm6OMH593HvTt1fXQuxTpoa7GLJDVrEHBmCn44k62d/PAD/crmO9O1mDkj8X3eimWJUcE0MlPjKoH/0VWV7oN9jYsY1R/fwiS5DqmKR1LGApfl1B/i2v29PC8vhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508111; c=relaxed/simple;
	bh=jDzObRYwRkapJySKK0oWQtxYQUq2OVssGctw+1duV94=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=OTy5/2m4f+xv2yh+ryQzqaccw+hp68wgY/9EtZWhg0sTteIdBN/I5H8GxkpCiLGIA40I3M0jYzKfwCae7O28tf9/HwJdss9yiHHRqeB8Fyp10OeH72/8qRf2SJ8JSmNdgopbTXxe/TBFXdpY5/qnbalzwhh9o76Y37YXfPsuo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maEHAzHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1BAC43609;
	Wed, 17 Jan 2024 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705508110;
	bh=jDzObRYwRkapJySKK0oWQtxYQUq2OVssGctw+1duV94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maEHAzHmX242xFhjDsTXdUbPh+/313gooww6/wGhfud2C6V+ivwG3IIUyyDsblUjI
	 05Cfc0FLTgiLtets7cdvt9U1BAaDYytmPqjoHp9v4TnGh8hJFgappYvNSadYIZD/lD
	 Ma/df36cpC/lrmGPKu+YGfwmLsCZBQVQEtwaL1F7tdtCu8EBEZBhvc7RrCn1L8LYwJ
	 fvIikk7HgNpBwTIlWV3cNxJgTC0GW6JTKfU1AfajNo4VedSGPAITaQkqyC23exjI6M
	 Yll3SXrambsT2BAdjL4GzfrmGfa7A3h8IX0XJECuRirErY6rcQYAcJ2Vo4ChBB1lwD
	 Yw7CgleyUXxhg==
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
Subject: [PATCH RFC 4/4] mitigations: Add flock cache accounting to 'mitigations=off'
Date: Wed, 17 Jan 2024 08:14:46 -0800
Message-ID: <3e803d5aee5dd1f4c738f0de1e839e6cfcb9dc41.1705507931.git.jpoimboe@kernel.org>
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

Allow flock cache accounting to be disabled with 'mitigations=off', as
it fits the profile for that option: trusted user space combined with a
performance-impacting mitigation.

Also, for consistency with the other CONFIG_MITIGATION_* options, rename
CONFIG_FLOCK_ACCOUNTING to CONFIG_MITIGATION_FLOCK_ACCOUNTING.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 fs/Kconfig                                      | 2 +-
 fs/locks.c                                      | 5 +++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 24e873351368..b31fe7433b48 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3427,6 +3427,10 @@
 					       ssbd=force-off [ARM64]
 					       tsx_async_abort=off [X86]
 
+					       Software mitigations:
+					       ---------------------
+					       flock_accounting=off [KNL]
+
 				Exceptions:
 					       This does not have any effect on
 					       kvm.nx_huge_pages when
diff --git a/fs/Kconfig b/fs/Kconfig
index 591f54a03059..4345b79d3b40 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -129,7 +129,7 @@ config FILE_LOCKING
           for filesystems like NFS and for the flock() system
           call. Disabling this option saves about 11k.
 
-config FLOCK_ACCOUNTING
+config MITIGATION_FLOCK_ACCOUNTING
 	bool "Enable kernel memory accounting for file locks" if EXPERT
 	depends on FILE_LOCKING
 	default y
diff --git a/fs/locks.c b/fs/locks.c
index e2799a18c4e8..fd4157ccd504 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -64,6 +64,7 @@
 #include <linux/hashtable.h>
 #include <linux/percpu.h>
 #include <linux/sysctl.h>
+#include <linux/mitigations.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/filelock.h>
@@ -2905,7 +2906,7 @@ static int __init proc_locks_init(void)
 fs_initcall(proc_locks_init);
 #endif
 
-static bool flock_accounting __ro_after_init = IS_ENABLED(CONFIG_FLOCK_ACCOUNTING);
+static bool flock_accounting __ro_after_init = IS_ENABLED(CONFIG_MITIGATION_FLOCK_ACCOUNTING);
 
 static int __init flock_accounting_cmdline(char *str)
 {
@@ -2930,7 +2931,7 @@ static int __init filelock_init(void)
 	int i;
 	slab_flags_t flags = SLAB_PANIC;
 
-	if (!flock_accounting)
+	if (mitigations_off() || !flock_accounting)
 		pr_err(FLOCK_ACCOUNTING_MSG);
 	else
 		flags |= SLAB_ACCOUNT;
-- 
2.43.0


