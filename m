Return-Path: <cgroups+bounces-3553-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F8928FD6
	for <lists+cgroups@lfdr.de>; Sat,  6 Jul 2024 02:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4751F22432
	for <lists+cgroups@lfdr.de>; Sat,  6 Jul 2024 00:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549CA5695;
	Sat,  6 Jul 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duYDoBHG"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152C23A9
	for <cgroups@vger.kernel.org>; Sat,  6 Jul 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720227404; cv=none; b=Kebadt3msqaubK//aeDsg0wRFzX0BSQ2vqd0fsXc69TitUQuFbLfNTEjeXrqfHnH4fDH0hqOO+2+uTOB8irUIwjWgyidMkZUwn7tEh9XCQHm67ptBOUigttAcoTRXCrzI2nTA35xGOQUGbxN9AKLC2NCpvECZEmh8LHnMSXSrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720227404; c=relaxed/simple;
	bh=hdyPAIau/0lbwqY666TtHYrohV4Hg9om8b+SvUB7ONE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ix2dsGqHlJVUCW2DcOD+8+5rcwfwdxjxtSUrJ/OFa3Fd+mD15bltFQu12JNe9FVt/EtkqB1BatJE7hejd5M259AljZq0Zs9OB9l641BFZcGkK0YQCN9UDTbkQWU2sfhqnK1DQ+SQnYluY56WkPLWUVdeaXgJ2qpEEU0KVRmaITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duYDoBHG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720227401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qgX67LTMOKLJFawZhybZAOqvckQnbxp+1tbcBNs/q8c=;
	b=duYDoBHGStVynf7TSTxQdELSVeJ0VokwcG/fI6NEC/ra8SdXx5c1/rnPtj7hbu5YnuvOo8
	TrTBxop02itk34MDNxgEuaVoR2lXtv60zd6Ues5/J9setrzhXV3bkPHou1wwhK2CEg0IuR
	atC8PUqOew1WEEmkXtu0xxakSKowfPg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-WeUnhkUUOUC7aXr6k-nYow-1; Fri,
 05 Jul 2024 20:56:37 -0400
X-MC-Unique: WeUnhkUUOUC7aXr6k-nYow-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54888195608A;
	Sat,  6 Jul 2024 00:56:36 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.212])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 774673000184;
	Sat,  6 Jul 2024 00:56:34 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 1/2] cgroup: Show # of subsystem CSSes in /proc/cgroups
Date: Fri,  5 Jul 2024 20:56:21 -0400
Message-Id: <20240706005622.2003606-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The /proc/cgroups file shows the number of cgroups for each of the
subsystems.  With cgroup v1, the number of CSSes is the same as the
number of cgroups. That is not the case anymore with cgroup v2. The
/proc/cgroups file cannot show the actual number of CSSes for the
subsystems that are bound to cgroup v2.

So if a v2 cgroup subsystem is leaking cgroups (typically memory
cgroup), we can't tell by looking at /proc/cgroups which cgroup
subsystems may be responsible.  This patch adds a css counter in the
cgroup_subsys structure to keep track of the number of CSSes for each
of the cgroup subsystems.

The proc_cgroupstats_show() function is modified to show the number
of CSSes instead. This will help us pinpoint which subsystem may be
responsible for the increasing number of dying but still allocated
cgroups.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h | 3 +++
 kernel/cgroup/cgroup-v1.c   | 2 +-
 kernel/cgroup/cgroup.c      | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index b36690ca0d3f..522ab77f0406 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -776,6 +776,9 @@ struct cgroup_subsys {
 	 * specifies the mask of subsystems that this one depends on.
 	 */
 	unsigned int depends_on;
+
+	/* Number of CSSes, used only for /proc/cgroups */
+	atomic_t nr_csses;
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index b9dbf6bf2779..56c2b030cd00 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -678,7 +678,7 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	for_each_subsys(ss, i)
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
-			   atomic_read(&ss->root->nr_cgrps),
+			   atomic_read(&ss->nr_csses),
 			   cgroup_ssid_enabled(i));
 
 	return 0;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c8e4b62b436a..4a818192950f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5375,6 +5375,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 		int id = css->id;
 
 		ss->css_free(css);
+		atomic_dec(&ss->nr_csses);
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
 
@@ -5567,6 +5568,7 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 	if (IS_ERR(css))
 		return css;
 
+	atomic_inc(&ss->nr_csses);
 	init_and_link_css(css, ss, cgrp);
 
 	err = percpu_ref_init(&css->refcnt, css_release, 0, GFP_KERNEL);
@@ -6005,6 +6007,8 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	/* Create the root cgroup state for this subsystem */
 	ss->root = &cgrp_dfl_root;
 	css = ss->css_alloc(NULL);
+	atomic_set(&ss->nr_csses, 1);
+
 	/* We don't handle early failures gracefully */
 	BUG_ON(IS_ERR(css));
 	init_and_link_css(css, ss, &cgrp_dfl_root.cgrp);
-- 
2.39.3


