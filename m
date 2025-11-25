Return-Path: <cgroups+bounces-12187-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4880EC833A5
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 04:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B5A3AA975
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 03:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC494224B01;
	Tue, 25 Nov 2025 03:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLC2CZrN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546D22129B
	for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041254; cv=none; b=KonBeG75bqOb6R+4eVlj4YupB8elhrT6KuAQ/e94l+XnQrrV4fzPNQxWJePf/wFLTSc3cYWXDvnXjc053fcBrh1eqYjftxFuRa5HNIYV02+L26QG2E5mjkTZg5rU8jr5k9JT2LxXXt5y4Usu8HPrMWnyI4TA5KHx5LepCqpLRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041254; c=relaxed/simple;
	bh=h7mCSWTQpuCI4RSJH9UzA51HK8Wx/pM5TBF+mW4PgpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIj3plbzYBawkVjltm31LmDdcg1iBn3EwFZkt0pzXhEAyAZK39NNnKyTXkK6l9/Sf7E1xUTNKwJSVCuYv3SQ4JJ52m42KoXTmxz6iVE7Tt1MRyfhsfyY2bBCqY2mkluuOWjQJcZIh0iaa3roFQlviDgPBItLAvgSZHDCDDHdtgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLC2CZrN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764041250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llKPeMrc3a3b4pVUXikJKLTSZCViQMaMelczXSPyCWQ=;
	b=aLC2CZrN6x7eHX2tcUyBbm7SDn3t0zV/sGI6HxyuanOTbyZubYw4FyesSpzCpKrB5hdifk
	nNMl/hbrBvEztCUEsetVfQ19nkKpM5kHQdvRoUhNjjX1pKbJeaQCUjb1Zo2YktkTjQKyN2
	HJdKUPat14dqQVuGFSgErYdqvME8x1k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-iSo7tWqcMpyY_aCvQ4lzKQ-1; Mon,
 24 Nov 2025 22:27:27 -0500
X-MC-Unique: iSo7tWqcMpyY_aCvQ4lzKQ-1
X-Mimecast-MFC-AGG-ID: iSo7tWqcMpyY_aCvQ4lzKQ_1764041245
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE4EB1954204;
	Tue, 25 Nov 2025 03:27:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54A2E3003761;
	Tue, 25 Nov 2025 03:27:15 +0000 (UTC)
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
Subject: [PATCHv2 2/2] sched/deadline: Fix potential race in dl_add_task_root_domain()
Date: Tue, 25 Nov 2025 11:26:30 +0800
Message-ID: <20251125032630.8746-3-piliu@redhat.com>
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

The access rule for local_cpu_mask_dl requires it to be called on the
local CPU with preemption disabled. However, dl_add_task_root_domain()
currently violates this rule.

Without preemption disabled, the following race can occur:

1. ThreadA calls dl_add_task_root_domain() on CPU 0
2. Gets pointer to CPU 0's local_cpu_mask_dl
3. ThreadA is preempted and migrated to CPU 1
4. ThreadA continues using CPU 0's local_cpu_mask_dl
5. Meanwhile, the scheduler on CPU 0 calls find_later_rq() which also
   uses local_cpu_mask_dl (with preemption properly disabled)
6. Both contexts now corrupt the same per-CPU buffer concurrently

Fix this by moving the local_cpu_mask_dl access to the preemption
disabled section.

Closes: https://lore.kernel.org/lkml/aSBjm3mN_uIy64nz@jlelli-thinkpadt14gen4.remote.csb
Fixes: 318e18ed22e8 ("sched/deadline: Walk up cpuset hierarchy to decide root domain when hot-unplug")
Reported-by: Juri Lelli <juri.lelli@redhat.com>
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
 kernel/sched/deadline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0b6646259bcd7..65c8539b468a2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2944,7 +2944,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct rq *rq;
 	struct dl_bw *dl_b;
 	unsigned int cpu;
-	struct cpumask *msk = this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
+	struct cpumask *msk;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
@@ -2952,6 +2952,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 		return;
 	}
 
+	msk = this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
 	dl_get_task_effective_cpus(p, msk);
 	cpu = cpumask_first_and(cpu_active_mask, msk);
 	BUG_ON(cpu >= nr_cpu_ids);
-- 
2.49.0


