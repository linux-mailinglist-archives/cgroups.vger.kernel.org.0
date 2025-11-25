Return-Path: <cgroups+bounces-12186-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7DFC83399
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 04:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7883534C2FB
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 03:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA63322156B;
	Tue, 25 Nov 2025 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7QvslgY"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F0222585
	for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041243; cv=none; b=psEpq85lyYPDMNV5XhQc2WBv9gTH0G5okRKceeBX06IvB1iVJDZrn2yK3oplutq5UXoV20jOiUFtqYIw0NdVU1vemJYyTN21AgLsmlbRY3zlEvW0ANtewJZaLSWY6H6jJcafWkZXSJlXAUS7BozRCN4XcGCnY2n4yMSjXrB6Mcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041243; c=relaxed/simple;
	bh=/hsR3zuYvVWfg88WpWLt/kRZTVdjYH6OHFTkCj2tUD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lx3BxE6Gl4GT3pRYvkEkWm/6QALRfigec7MGCldYQth1uz+9DJVz0TQ0Wg0HOAwNysScB0mIybaUntEYsy0r4vVOTCFS2T06IyhzMvgYagYkj8tS6EtTnJTUQWzcdzJPPCNiR+IPDi7TLigzYZ4Lp0X0RgCoUMPGZe/IHwOVveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7QvslgY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764041241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9n4PdkywfT2V89/jL5nJ7OWHOEyn12fJUBABHG/tyc=;
	b=W7QvslgYRFJ8nxKDQKc3LmNJKfbIfGwj/75ecICuoQqeJ9rjVI8EtojXTJ61eFeZeFRdYy
	uEnopIL79iRMfdI9Fn+Fr48RdqwzeCBXcRxMFRCEKCSWbFqUfkwT/k7bVicy3QYBxSW93E
	gJMo8HXz3WNfeWjw25t5Ynfy8JFbxEM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-A_3pCBxTO0GnAI7cWQYUPQ-1; Mon,
 24 Nov 2025 22:27:17 -0500
X-MC-Unique: A_3pCBxTO0GnAI7cWQYUPQ-1
X-Mimecast-MFC-AGG-ID: A_3pCBxTO0GnAI7cWQYUPQ_1764041236
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A16FB19560B7;
	Tue, 25 Nov 2025 03:27:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12A183003761;
	Tue, 25 Nov 2025 03:27:07 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCHv2 1/2] sched/deadline: Remove unnecessary comment in dl_add_task_root_domain()
Date: Tue, 25 Nov 2025 11:26:29 +0800
Message-ID: <20251125032630.8746-2-piliu@redhat.com>
In-Reply-To: <20251125032630.8746-1-piliu@redhat.com>
References: <20251119095525.12019-3-piliu@redhat.com>
 <20251125032630.8746-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The comments above dl_get_task_effective_cpus() and
dl_add_task_root_domain() already explain how to fetch a valid
root domain and protect against races. There's no need to repeat
this inside dl_add_task_root_domain(). Remove the redundant comment
to keep the code clean.

No functional change.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
To: cgroups@vger.kernel.org
To: linux-kernel@vger.kernel.org
---
 kernel/sched/deadline.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 194a341e85864..0b6646259bcd7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2952,20 +2952,11 @@ void dl_add_task_root_domain(struct task_struct *p)
 		return;
 	}
 
-	/*
-	 * Get an active rq, whose rq->rd traces the correct root
-	 * domain.
-	 * Ideally this would be under cpuset reader lock until rq->rd is
-	 * fetched.  However, sleepable locks cannot nest inside pi_lock, so we
-	 * rely on the caller of dl_add_task_root_domain() holds 'cpuset_mutex'
-	 * to guarantee the CPU stays in the cpuset.
-	 */
 	dl_get_task_effective_cpus(p, msk);
 	cpu = cpumask_first_and(cpu_active_mask, msk);
 	BUG_ON(cpu >= nr_cpu_ids);
 	rq = cpu_rq(cpu);
 	dl_b = &rq->rd->dl_bw;
-	/* End of fetching rd */
 
 	raw_spin_lock(&dl_b->lock);
 	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
-- 
2.49.0


