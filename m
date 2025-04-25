Return-Path: <cgroups+bounces-7824-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6BCA9BD2E
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 05:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531394C15D9
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 03:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524313DBB1;
	Fri, 25 Apr 2025 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fG32usgw"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351184C6E
	for <cgroups@vger.kernel.org>; Fri, 25 Apr 2025 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745551047; cv=none; b=DD0HW9wdsu5YtFlV6I5kNt+pC+nzgZihljsq4/3mMlErz4XQil4u26e6nc/9XCcp9a3EvT/GfBUh2RU6/DgF9ORZRvb7ZAsTcSUn2zGSF1lYTwBe5SBS+D8rdJbGsAhaX+fQ8v5RvQa3P4SguGGWyt/rsXE5QHzJWdcBfHziRcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745551047; c=relaxed/simple;
	bh=4blZG7dlw9MZgEsr+Bx9bLxPoM0jAPRP13/yu3GhLyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bq1ufpHI6TSbJvQ8HiMxIMjSr7boImyd9K8B7r6ewJgymAN/mUFgBknjg1CIka0+W8yeyuxYHSgAckHWR4ePKMgMeZ5/QnpcVe7sBROcls6Ah8EfkBtjSblZBEn/3n30Zqvyj72Fzk0JLF4gAHyNlhzumLfGJYP9KUVQ2mQmrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fG32usgw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745551043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WUIHQYnDfqvtQjbPv6jYfcvJ+nZpaJh/ZQwwMDo1W0E=;
	b=fG32usgwUQpgGh/viLVJVgPmk6TmVwy3XB4EqkPDlEi4oSS7siuu9Bv0CO2mB+N1LiqpE+
	JsfgvvfHgvJ4PO4DsHE889CNdDkBdgwTuTuiYjKO7oYNHD1bKHzQ7SbhKMMgxQ1PiaLZQg
	PVaTRCdJ8BUYBc3MNLv4klBOmIKI3e0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-gDOQxU87P16zfwDZ1hBu7g-1; Thu,
 24 Apr 2025 23:17:21 -0400
X-MC-Unique: gDOQxU87P16zfwDZ1hBu7g-1
X-Mimecast-MFC-AGG-ID: gDOQxU87P16zfwDZ1hBu7g_1745551040
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 597ED180034A;
	Fri, 25 Apr 2025 03:17:20 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44B93180047F;
	Fri, 25 Apr 2025 03:17:18 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v2] cgroup/rstat: Improve cgroup_rstat_push_children() documentation
Date: Thu, 24 Apr 2025 23:16:55 -0400
Message-ID: <20250425031656.790645-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The cgroup_rstat_push_children() function converts a set of
updated_children lists from different cgroups into a single ordered
list of cgroups to be flushed via the rstat_flush_next pointer.
The algorithm used isn't that well illustrated and it takes time to
grasp what it is doing. Improve the embedded documentation and variable
names to better illustrate the transformation process and make the code
easier to understand.

Also cgroup_rstat_lock must be held for the whole duration
from where the rstat_flush_next list is being constructed in
cgroup_rstat_push_children() to when it is consumed later in
css_rstat_flush(). Otherwise, list corruption can happen leading to
system crash as reported in [1]. In this particular case, the branch
being used has commit 093c8812de2d ("cgroup: rstat: Cleanup flushing
functions and locking") which breaks this rule, but is missing the fix
commit 7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list
with cgroup_rstat_lock") that fixes it.

This patch has no functional change.

[1] https://lore.kernel.org/lkml/BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com/

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/rstat.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 4d5fd8d12bdd..357c538d14da 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -144,30 +144,54 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
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
+	 * The cgroup_rstat_lock must be held for the whole duration from
+	 * here as the rstat_flush_next list is being constructed to when
+	 * it is consumed later in css_rstat_flush().
+	 */
+	lockdep_assert_held(&cgroup_rstat_lock);
+
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
@@ -185,7 +209,7 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
 	}
 
 	if (ghead) {
-		chead = ghead;
+		cnext = ghead;
 		ghead = NULL;
 		goto next_level;
 	}
-- 
2.49.0


