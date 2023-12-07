Return-Path: <cgroups+bounces-891-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69999808970
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 14:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF531F21439
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E573EA77;
	Thu,  7 Dec 2023 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGNd25T8"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CADD54
	for <cgroups@vger.kernel.org>; Thu,  7 Dec 2023 05:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701956791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xICLJqbrK65stKoTdC9zWPAAFCF9WJ2JOuG2uZTX2Bg=;
	b=hGNd25T84/dlThhjxlH+7yGUKT321pOBoIyphJqjQdtgajW7gVXWLlfPyumdFwT52CYrVq
	j3Gy0IN2WdLmAzuFA5xL1nRTSKZOgLEL+8eNYJFALVL33MrJYj+yoDPRerSzfBSDL3om0X
	+oruW1/rJrl9MlPHz2WBhjPJbyJ3+IU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-s18BKpLhPquqfPMDwGyRVA-1; Thu, 07 Dec 2023 08:46:25 -0500
X-MC-Unique: s18BKpLhPquqfPMDwGyRVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D3FA185A785;
	Thu,  7 Dec 2023 13:46:25 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.209])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 821CB2166B35;
	Thu,  7 Dec 2023 13:46:24 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yafang Shao <laoar.shao@gmail.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Yosry Ahmed <yosryahmed@google.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v2] cgroup: Move rcu_head up near the top of cgroup_root
Date: Thu,  7 Dec 2023 08:46:14 -0500
Message-Id: <20231207134614.882991-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
for freeing the cgroup_root.

The current implementation of kvfree_rcu(), however, has the limitation
that the offset of the rcu_head structure within the larger data
structure must be less than 4096 or the compilation will fail. See the
macro definition of __is_kvfree_rcu_offset() in include/linux/rcupdate.h
for more information.

By putting rcu_head below the large cgroup structure, any change to the
cgroup structure that makes it larger run the risk of causing build
failure under certain configurations. Commit 77070eeb8821 ("cgroup:
Avoid false cacheline sharing of read mostly rstat_cpu") happens to be
the last straw that breaks it. Fix this problem by moving the rcu_head
structure up before the cgroup structure.

Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU safe")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20231207143806.114e0a74@canb.auug.org.au/
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/cgroup-defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 5a97ea95b564..ea48c861cd36 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -562,6 +562,10 @@ struct cgroup_root {
 	/* Unique id for this hierarchy. */
 	int hierarchy_id;
 
+	/* A list running through the active hierarchies */
+	struct list_head root_list;
+	struct rcu_head rcu;	/* Must be near the top */
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


