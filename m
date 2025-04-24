Return-Path: <cgroups+bounces-7812-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39591A9BACC
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 00:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0329F9A1380
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 22:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE95B224B1E;
	Thu, 24 Apr 2025 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLsZkWAf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F41F8730
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745534010; cv=none; b=c4NqxqEh8q88iHp7zkCSTQptydReliAFc4U1CxQDp8eOSBz7uK9o6Y4otwhfpXCxO/acGnZR+kyCfhPusubCrvKlKhci9YEhym/mobnVff5IGLM2Z+wA9vFu4z/wG8Vt3AHDcBQk3BReQqwjiGwbDDKH/PkJFLaILrrLiyRqDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745534010; c=relaxed/simple;
	bh=zomNnsq4MsaGCQsrSebnFKdmD63FlCoHwAdaLyqTj5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKVWw5Ur8tvOxs2GY4Gfqdofj00OyehZ0V5eU4G+K3+zSacy506B+BtsN6cXceLZ05Mcer/Ym2h6UOErgmeHlx6M0WhlwAVBRho9ce02LE7vEOrTdfmbdNv+KHI9ysYbKcpC4vRYAnWL4+dqZJbbACvr2/U43LqEVyU58OP3NkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLsZkWAf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745534007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UBnlZ15iRFsPHl5PsW20DUMO/a0bOB7UNxRRbwZg5Ik=;
	b=QLsZkWAf4Pz6t49dczgqlBnKTCwVG3t1AWt8tXZfHTEolXoahhw4JIX9yCIs9w/A5Vbavb
	ZK88Vl4uXehmUDYIwqJKGP764OTxVjmuBXzGS4xCvk/7dhgWNbAdU5TPIIwyCvaoePdaK4
	U3OmbVc72gZxItNvwdFEydJ7L5aaiyo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-v5UPUSufPCWjN2c5tDGFmQ-1; Thu,
 24 Apr 2025 18:33:25 -0400
X-MC-Unique: v5UPUSufPCWjN2c5tDGFmQ-1
X-Mimecast-MFC-AGG-ID: v5UPUSufPCWjN2c5tDGFmQ_1745534004
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 118DE1956086;
	Thu, 24 Apr 2025 22:33:24 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CAEC1956095;
	Thu, 24 Apr 2025 22:33:22 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/rstat: Improve cgroup_rstat_push_children() documentation
Date: Thu, 24 Apr 2025 18:33:08 -0400
Message-ID: <20250424223308.770393-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The cgroup_rstat_push_children() function converts a set of
updated_children lists from different cgroups into a single ordered
list of cgroups to be flushed via the rstat_flush_next pointer.
The algorithm used isn't that well illustrated and it takes time to
grasp what it is doing. Improve the embedded documentation and variable
names to better illustrate the transformation process and make the code
easier to understand.

Also add a warning if one of the updated_children lists is NULL
terminated like that reported in [1].

[1] https://lore.kernel.org/lkml/BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com/

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/rstat.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index b2239156b7de..ac2046f427eb 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -134,30 +134,47 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
  * @head: current head of the list (= subtree root)
  * @child: first child of the root
  * @cpu: target cpu
- * Return: A new singly linked list of cgroups to be flush
+ * Return: A new singly linked list of cgroups to be flushed
  *
  * Iteratively traverse down the cgroup_rstat_cpu updated tree level by
  * level and push all the parents first before their next level children
- * into a singly linked list built from the tail backward like "pushing"
- * cgroups into a stack. The root is pushed by the caller.
+ * into a singly linked list via the rstat_flush_next pointer built from the
+ * tail backward like "pushing" cgroups into a stack. The root is pushed by
+ * the caller.
  */
 static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
 						 struct cgroup *child, int cpu)
 {
-	struct cgroup *chead = child;	/* Head of child cgroup level */
+	struct cgroup *cnext = child;	/* Next head of child cgroup level */
 	struct cgroup *ghead = NULL;	/* Head of grandchild cgroup level */
 	struct cgroup *parent, *grandchild;
 	struct cgroup_rstat_cpu *crstatc;
 
 	child->rstat_flush_next = NULL;
 
+	/*
+	 * Notation: -> updated_next pointer
+	 *	     => rstat_flush_next pointer
+	 *
+	 * Assuming the following sample updated_children lists:
+	 *  P: C1 -> C2 -> P
+	 *  C1: G11 -> G12 -> C1
+	 *  C2: G21 -> G22 -> C2
+	 *
+	 * After 1st iteration:
+	 *  head => C2 => C1 => NULL
+	 *  ghead => G21 => G11 => NULL
+	 *
+	 * After 2nd iteration:
+	 *  head => G12 => G11 => G22 => G21 => C2 => C1 => NULL
+	 */
 next_level:
-	while (chead) {
-		child = chead;
-		chead = child->rstat_flush_next;
+	while (cnext) {
+		child = cnext;
+		cnext = child->rstat_flush_next;
 		parent = cgroup_parent(child);
 
-		/* updated_next is parent cgroup terminated */
+		/* updated_next is parent cgroup terminated if !NULL */
 		while (child != parent) {
 			child->rstat_flush_next = head;
 			head = child;
@@ -171,11 +188,13 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
 			}
 			child = crstatc->updated_next;
 			crstatc->updated_next = NULL;
+			if (WARN_ON_ONCE(!child))
+				break;
 		}
 	}
 
 	if (ghead) {
-		chead = ghead;
+		cnext = ghead;
 		ghead = NULL;
 		goto next_level;
 	}
-- 
2.49.0


