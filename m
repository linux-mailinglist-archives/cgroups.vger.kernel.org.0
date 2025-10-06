Return-Path: <cgroups+bounces-10550-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71B9BBDBEC
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8FB3B740D
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F2C25CC4D;
	Mon,  6 Oct 2025 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gsdPOHYX"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047316EB42;
	Mon,  6 Oct 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747560; cv=none; b=g3dGviZH0Ho2qGi82cv4foRYOqPJXPLzH8mHluB/3ScXx1h/pCAm2b9U2n9TP5qJGY5ScFNoTrQ8nzuBDkV0ZWV4cdmrAGYSaWSOJWM6/z+4DZGxMBTsn8WnmvpIKX5G3gVSbfOEkn/b2IiLLlU3eGL4hmMF5vgmTuQATSiBw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747560; c=relaxed/simple;
	bh=MXTMcR9YZX0DfzxJOhZPMSsGeJkLOquRCKrvD4CNy4s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Gp5oL8K2DCvc/WeQuMYR+eazMiilpf8ExaKKJgXnHIRpTZ0kF38MoIuxDudIqcYw8sn01c70hWQXFpsbvmyO5f3wHLXoqounRQuXBGe4Ygmcb1lBV0JpS5LqmGEXS5IZ2gpswqCXmrS3lJHHFiWbwMLIsheGpAfxq+mo6lDibgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gsdPOHYX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=c5AKA1Ul7x9P1KOonIgzBsVrilkhe+QAcdwdwNnhhOc=; b=gsdPOHYXR0mS2XtAnzCkc6Zd9o
	kfGRotyBCA5cph+HhI4FuQcUMCtiGUXYsTeG/qR6UI0zuMEsZgbliaP/xCmAklw6QnYFRI4mv2EiH
	tssIcUgXEIXON5rylbwczUnlowLqNNPTL55gnfAPOUFXBCjFt8BZZkb9Tt9uTuR25A+/lYwsQpd1L
	EmiCDb0tF8Oyi5uZlN3aW1+DfrQVgOy9V3QSkRKz9paw08Yaut1VRoFqTeUeQ7GCvv4XTGnZxKPFR
	BpTpfE6v0ZJ7m8PZ+DcYCdsw3Q4K2brVX4OZJDoE3vrK4jzcMkJxokzpMjKVqNI7MHiTS3hDYw3LZ
	E+bs/8Aw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iix-00000009yac-0Rta;
	Mon, 06 Oct 2025 10:45:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id C370A30039F; Mon, 06 Oct 2025 12:45:47 +0200 (CEST)
Message-ID: <20251006104526.729048003@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:44:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@kernel.org,
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
Subject: [PATCH 02/12] sched: Re-arrange the {EN,DE}QUEUE flags
References: <20251006104402.946760805@infradead.org>
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
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/sched.h |   45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2362,27 +2362,30 @@ extern const u32		sched_prio_to_wmult[40
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
 



