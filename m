Return-Path: <cgroups+bounces-886-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB2B807FBF
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 05:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6AF1C2087B
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 04:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5133417FE;
	Thu,  7 Dec 2023 04:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIEfo0ZR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B3110
	for <cgroups@vger.kernel.org>; Wed,  6 Dec 2023 20:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701923887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tGYuayIbjuzHLuEu82pkqtgPwJeMuDwkxBYxtZFsrRQ=;
	b=jIEfo0ZRJcwGhrI5/wQ+Zv9yYCWWUGZd23StJyZ4dvLaNaTJkcB2RseiLVmqv6Vi7IqHm6
	9MLknV5ExSz21gLTWUeaX9aaG6+8ur2D8n+JkEpP9gN3ZPzCyzWtKbKL8msMlbIo7J148y
	KKGxRLElywtcwlIAj1N18ovxVh0Zdvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-3EujIB-UPuOPPoDl20n5tQ-1; Wed, 06 Dec 2023 23:38:04 -0500
X-MC-Unique: 3EujIB-UPuOPPoDl20n5tQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 685FF83BA86;
	Thu,  7 Dec 2023 04:38:03 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7550D8CD0;
	Thu,  7 Dec 2023 04:38:02 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yafang Shao <laoar.shao@gmail.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup] cgroup: Move rcu_head up near the top of cgroup_root
Date: Wed,  6 Dec 2023 23:37:53 -0500
Message-Id: <20231207043753.876437-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
for freeing the cgroup_root.

The use of kvfree_rcu(), however, has the limitation that the offset of
the rcu_head structure within the larger data structure cannot exceed
4096 or the compilation will fail. By putting rcu_head below the cgroup
structure, any change to the cgroup structure that makes it larger has
the risk of build failure. Commit 77070eeb8821 ("cgroup: Avoid false
cacheline sharing of read mostly rstat_cpu") happens to be the commit
that breaks it even though it is not its fault. Fix it by moving the
rcu_head structure up before the cgroup structure.

Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU safe")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 5a97ea95b564..45359969d8cf 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -562,6 +562,10 @@ struct cgroup_root {
 	/* Unique id for this hierarchy. */
 	int hierarchy_id;
 
+	/* A list running through the active hierarchies */
+	struct list_head root_list;
+	struct rcu_head rcu;
+
 	/*
 	 * The root cgroup. The containing cgroup_root will be destroyed on its
 	 * release. cgrp->ancestors[0] will be used overflowing into the
@@ -575,10 +579,6 @@ struct cgroup_root {
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
 
-	/* A list running through the active hierarchies */
-	struct list_head root_list;
-	struct rcu_head rcu;
-
 	/* Hierarchy-specific flags */
 	unsigned int flags;
 
-- 
2.39.3


