Return-Path: <cgroups+bounces-9941-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2148CB51CD1
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084E0A019B2
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D8433A008;
	Wed, 10 Sep 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J6pLRmOQ"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A033472C;
	Wed, 10 Sep 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520045; cv=none; b=NUckWFP7Z+HM397h5iMMBBYxOjMVNFxLPbmZaMaXfk+094dog6WXlMe51jxxnQuAKdAKCr80TK0CB/wXHBIv7CDjXzr5pHUQwYvOyQYaWKNH6Us4FqDrIBNdR/lLmRunWwyO3/xq2q/NnQtdj0HC1TGBPNwc6pVOfWlRK0AjFrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520045; c=relaxed/simple;
	bh=+Xi+VxJz3QwD8xpd/CFUanD6QsGXGT7DYIQZlvWMsJ4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NjbqH619Ku2ItSKogXvjbVjkM5Iv3k2iRm86ZgUMkRiT35kqVwCd3Ta4V9UTEBeNtrPNct2mWIupMyvzHF+4LskEu9IFaWjpDdqiyX09K9FhG0deUHCQsMeatlVhon4ZZkS5qaPWSGpmiM1G1oed3ur4PodTH7v0pNgBiTtS/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J6pLRmOQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=BchCbAovlKyHntSnrXPDYCJXjw7uOf9GlTgQLA3hUug=; b=J6pLRmOQ97lWeC8GkFItwrD3Pu
	eIJ+08yCsKITPBZUebYJxIiwmZwG6V3aH9XmeQX/ZYAyR7ePRtHvzzVNeqOBFGtxpWOoeOnAkTa3O
	YImGNowOQ98Rf/MP8dYDsbRPtNy3NkaBcLmpcvFLCaLW0i8ZA2FF16fUixKVB9CWqQ+Gv9PHkglJ6
	+QpZUNAhsXo0qR+QMm2iD9Tv8pM4SYsjiq2y6OCASsr/aRD3T3q5jnzBN+ZoJ/DdLZfrWuFHl1Upq
	fokmeZd9UNqbse16KWXvGKsrtfLY4URqO7u46Jcz5eWNlEOxomG6UtAD21mQwsJDq1yyND0UuEZo6
	pJbJu26Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFG-00000005ufE-0S6d;
	Wed, 10 Sep 2025 16:00:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 7EA7A302D42; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155808.536785976@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 longman@redhat.com,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 cgroups@vger.kernel.org,
 sched-ext@lists.linux.dev,
 liuwenfang@honor.com,
 tglx@linutronix.de
Subject: [PATCH 02/14] sched: Re-arrange the {EN,DE}QUEUE flags
References: <20250910154409.446470175@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Ensure the matched flags are in the low word while the unmatched flags
go into the second word.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/sched.h |   45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2337,27 +2337,30 @@ extern const u32		sched_prio_to_wmult[40
  *
  */
 
-#define DEQUEUE_SLEEP		0x01 /* Matches ENQUEUE_WAKEUP */
-#define DEQUEUE_SAVE		0x02 /* Matches ENQUEUE_RESTORE */
-#define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
-#define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
-#define DEQUEUE_SPECIAL		0x10
-#define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
-#define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
-#define DEQUEUE_THROTTLE	0x800
-
-#define ENQUEUE_WAKEUP		0x01
-#define ENQUEUE_RESTORE		0x02
-#define ENQUEUE_MOVE		0x04
-#define ENQUEUE_NOCLOCK		0x08
-
-#define ENQUEUE_HEAD		0x10
-#define ENQUEUE_REPLENISH	0x20
-#define ENQUEUE_MIGRATED	0x40
-#define ENQUEUE_INITIAL		0x80
-#define ENQUEUE_MIGRATING	0x100
-#define ENQUEUE_DELAYED		0x200
-#define ENQUEUE_RQ_SELECTED	0x400
+#define DEQUEUE_SLEEP		0x0001 /* Matches ENQUEUE_WAKEUP */
+#define DEQUEUE_SAVE		0x0002 /* Matches ENQUEUE_RESTORE */
+#define DEQUEUE_MOVE		0x0004 /* Matches ENQUEUE_MOVE */
+#define DEQUEUE_NOCLOCK		0x0008 /* Matches ENQUEUE_NOCLOCK */
+
+#define DEQUEUE_MIGRATING	0x0010 /* Matches ENQUEUE_MIGRATING */
+#define DEQUEUE_DELAYED		0x0020 /* Matches ENQUEUE_DELAYED */
+
+#define DEQUEUE_SPECIAL		0x00010000
+#define DEQUEUE_THROTTLE	0x00020000
+
+#define ENQUEUE_WAKEUP		0x0001
+#define ENQUEUE_RESTORE		0x0002
+#define ENQUEUE_MOVE		0x0004
+#define ENQUEUE_NOCLOCK		0x0008
+
+#define ENQUEUE_MIGRATING	0x0010
+#define ENQUEUE_DELAYED		0x0020
+
+#define ENQUEUE_HEAD		0x00010000
+#define ENQUEUE_REPLENISH	0x00020000
+#define ENQUEUE_MIGRATED	0x00040000
+#define ENQUEUE_INITIAL		0x00080000
+#define ENQUEUE_RQ_SELECTED	0x00100000
 
 #define RETRY_TASK		((void *)-1UL)
 



