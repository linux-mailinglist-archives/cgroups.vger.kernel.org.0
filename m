Return-Path: <cgroups+bounces-8633-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E9AEA614
	for <lists+cgroups@lfdr.de>; Thu, 26 Jun 2025 21:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB6F4A47CB
	for <lists+cgroups@lfdr.de>; Thu, 26 Jun 2025 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EE82EF9B7;
	Thu, 26 Jun 2025 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AcakhpBk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30EE2EF9AC
	for <cgroups@vger.kernel.org>; Thu, 26 Jun 2025 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964791; cv=none; b=hX6MbOAtY8OUL+Rb+GXnhNT7GufYYJ7SWL2qOf+3THMCLNy82YZqhYTaloYmETrHu8kwcEGq5wZBQRbhZjyl5pT8504VT2qlXG0rWArFLblxzOJ278nGBZAQXRruCkJiGvbmPgRJdzdQmRKV6r27Wfj05uMFKRxwZgJdqY7i8WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964791; c=relaxed/simple;
	bh=94wujlprhlS029mcra36E0Dntwgq9FBtExTdO7unzTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bxsgau3zb644WOqqEoyLsEOLwyAYA/qF1meJOkH6poxLbKlGambsexWpOjNBr0l3tjCehkkNgQr9/LjL1Y0JS9HbERfZwiLPoNrWTFjAgp4XydrQD7UMvBZ4Cg2M+jNW9jTwwSZ+JL1JsFKBAmnbokRxEi+zM0QILyVBQL+geKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AcakhpBk; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750964776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hRYA/eQeT9TuSYBJimjQD+4XXaxvKbVaBpqOU6qP1mI=;
	b=AcakhpBkj96bUgTOzuoxqLIfIAc9ZQjOnqODJB0v3sF4JcbkR8FrCvNkH9Uz2of8AFDTx5
	+VR1ghYe3Z1RWI0fzCI4gs3L1ykEp5+Z5qHA40jYNUtFHSehdlhINjCSqv7YLUkDDte/VN
	IcPoTknOiDN34LvkQ/hDJqUpWu/n2fM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] llist: add [READ|WRITE]_ONCE tags for llist_node
Date: Thu, 26 Jun 2025 12:05:50 -0700
Message-ID: <20250626190550.4170599-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Before the commit 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi
safe"), the struct llist_node is expected to be private to the one
inserting the node to the lockless list or the one removing the node
from the lockless list. After the mentioned commit, the llist_node in
the rstat code is per-cpu shared between the stacked contexts i.e.
process, softirq, hardirq & nmi.

KCSAN reported the following race:

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 60 UID: 0 PID: 5425 ... 6.16.0-rc3-next-20250626 #1 NONE
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: ...
 ==================================================================
 ==================================================================
 BUG: KCSAN: data-race in css_rstat_flush / css_rstat_updated
 write to 0xffffe8fffe1c85f0 of 8 bytes by task 1061 on cpu 1:
  css_rstat_flush+0x1b8/0xeb0
  __mem_cgroup_flush_stats+0x184/0x190
  flush_memcg_stats_dwork+0x22/0x50
  process_one_work+0x335/0x630
  worker_thread+0x5f1/0x8a0
  kthread+0x197/0x340
  ret_from_fork+0xd3/0x110
  ret_from_fork_asm+0x11/0x20
 read to 0xffffe8fffe1c85f0 of 8 bytes by task 3551 on cpu 15:
  css_rstat_updated+0x81/0x180
  mod_memcg_lruvec_state+0x113/0x2d0
  __mod_lruvec_state+0x3d/0x50
  lru_add+0x21e/0x3f0
  folio_batch_move_lru+0x80/0x1b0
  __folio_batch_add_and_move+0xd7/0x160
  folio_add_lru_vma+0x42/0x50
  do_anonymous_page+0x892/0xe90
  __handle_mm_fault+0xfaa/0x1520
  handle_mm_fault+0xdc/0x350
  do_user_addr_fault+0x1dc/0x650
  exc_page_fault+0x5c/0x110
  asm_exc_page_fault+0x22/0x30
 value changed: 0xffffe8fffe18e0d0 -> 0xffffe8fffe1c85f0

$ ./scripts/faddr2line vmlinux css_rstat_flush+0x1b8/0xeb0
css_rstat_flush+0x1b8/0xeb0:
init_llist_node at include/linux/llist.h:86
(inlined by) llist_del_first_init at include/linux/llist.h:308
(inlined by) css_process_update_tree at kernel/cgroup/rstat.c:148
(inlined by) css_rstat_updated_list at kernel/cgroup/rstat.c:258
(inlined by) css_rstat_flush at kernel/cgroup/rstat.c:389

$ ./scripts/faddr2line vmlinux css_rstat_updated+0x81/0x180
css_rstat_updated+0x81/0x180:
css_rstat_updated at kernel/cgroup/rstat.c:90 (discriminator 1)

These are expected race and a simple READ_ONCE/WRITE_ONCE resolves these
reports.

Fixes: 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/llist.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 27b17f64bcee..607b2360c938 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -83,7 +83,7 @@ static inline void init_llist_head(struct llist_head *list)
  */
 static inline void init_llist_node(struct llist_node *node)
 {
-	node->next = node;
+	WRITE_ONCE(node->next, node);
 }
 
 /**
@@ -97,7 +97,7 @@ static inline void init_llist_node(struct llist_node *node)
  */
 static inline bool llist_on_list(const struct llist_node *node)
 {
-	return node->next != node;
+	return READ_ONCE(node->next) != node;
 }
 
 /**
@@ -220,7 +220,7 @@ static inline bool llist_empty(const struct llist_head *head)
 
 static inline struct llist_node *llist_next(struct llist_node *node)
 {
-	return node->next;
+	return READ_ONCE(node->next);
 }
 
 /**
-- 
2.47.1


