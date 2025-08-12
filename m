Return-Path: <cgroups+bounces-9091-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BB8B2261C
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 13:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA7B84E071F
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC62EE5E9;
	Tue, 12 Aug 2025 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kKehlt9/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9859A285CBD
	for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999456; cv=none; b=VzQ3EXHYWcPPwmSvOdd1z8huoHZd6EYFPE/zw7jQogjlBAaIg3NMRHKx8JTUs2hBq/CzFAyTLjjDRlvG5JDTRe195Fy9M+PiTfFEsaHCM5/QtWHk9qVYlMl8IGG7rnO4HHabM1jAKTh5PWaIsorSQHUW0kr/3jwwOOh1ziWRTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999456; c=relaxed/simple;
	bh=NFfWRTDODCDUk5WW8uog6Bb6GS31TOQeGTGmHGcvMXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BzmdlVPssLkjojQi3BTYjwwHXmrvd5EyC1+xRWAqHyXj3kwc8U1eBElnHBgym2cRUvjmxy8UmqXUskrF811Wzfn+NKXUEk3CvP7wa15E5W9W3chUO7rAz8TqfYF5HRLwVjz+j5rE8aezDXUXMr925aXNgjp6F72LXa9KNlKWlMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kKehlt9/; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754999450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PirPw+GVWpi/MLEhYVWbJJwnZ/N/h/SZAHA9CAQfDQ8=;
	b=kKehlt9//uCQ9kzzkZDUKXrH9B2JnALFIwF4JaOixVqXKIPYWMCDX1zwOimVVoatCq0XkY
	OrO+XfAJbvS+dIB1xMV7O25GVxigEia8hhJ7OCJgXXpD3rEUy0a6e6NjvzwlONv7lOsynO
	OECIVNLn67RbL/KGoXjo+7jb4rKroyk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup: Replace deprecated strcpy() with strscpy()
Date: Tue, 12 Aug 2025 13:50:35 +0200
Message-ID: <20250812115036.118407-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/cgroup/cgroup-v1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fa24c032ed6f..b551d9f47af5 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -10,6 +10,7 @@
 #include <linux/sched/task.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <linux/delayacct.h>
 #include <linux/pid_namespace.h>
@@ -1129,7 +1130,7 @@ int cgroup1_reconfigure(struct fs_context *fc)
 
 	if (ctx->release_agent) {
 		spin_lock(&release_agent_path_lock);
-		strcpy(root->release_agent_path, ctx->release_agent);
+		strscpy(root->release_agent_path, ctx->release_agent);
 		spin_unlock(&release_agent_path_lock);
 	}
 
-- 
2.50.1


