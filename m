Return-Path: <cgroups+bounces-11619-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C52C37DE0
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1B9B4F0906
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392F35028B;
	Wed,  5 Nov 2025 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIVpOBpq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486E34B1AE;
	Wed,  5 Nov 2025 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376713; cv=none; b=LpqocLgt4gBucOC8y8YcePaejDMluBglBghKXYF+ML8q5DlA/vjYAEWDhjg1p8vDMlRonfNOC7KY0ElhOyX4R8rFZAu8LDnjOWwuq3ByDWUZ9UKcAy9nHvgGClnZ/WMbANJkj6p7+Fnxm7ZPku1DNrcC0NNvtxEvtjFeVzZSEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376713; c=relaxed/simple;
	bh=9PqeZuz2EE5nGKqtZVUtfHjP+RBKx+k8UZ4YoNv5ao8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2+hfeLpBKDm9BqYj4k7pqhKdE2MHAKtpKyHkv2yooLoYbvB2lvXZh3q/SrQZ12+7DfYYrK2gmsmvmTrPcpOd5MVqWalM6b0lbusoTJfuKctHI8/YYcGiFjzfVdmy7jjKx0oIFM3rdjLZFK5sBpzTCnk6iPqDBdAZfEfzzHt7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIVpOBpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C8DC116B1;
	Wed,  5 Nov 2025 21:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376713;
	bh=9PqeZuz2EE5nGKqtZVUtfHjP+RBKx+k8UZ4YoNv5ao8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIVpOBpqfmDE5JQSQL6FKNplt/gJBikhmp1UFRydi+QdTh8oOUYJQlGiB4XmWUTH+
	 Vqr9dPoZ1kcgFGocAY+e2Wx9dvdHV5fLeJdsh/b30bGh3/fnHbgkXpEqxNce/04c6R
	 DyLBgJ2XOfusrMjIL8NhE2/aR01FlDQSc9QdkYFnrLh3UayYn6US9vZO5mM2muRRM2
	 y0sUBgROywsAL3lRHGT/BtiVj7xh/6lhWY4kslHyoee8mxsAoMZhQuf9SVDiUh5iIX
	 PuYTBP3315vJsPvAkzANuVXMu+SqS8chEInT75TJVn1gTfvUqrAJADrwdphmm2YvUb
	 rPFeAsWq/Uc6w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 09/31] block: Protect against concurrent isolated cpuset change
Date: Wed,  5 Nov 2025 22:03:25 +0100
Message-ID: <20251105210348.35256-10-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105210348.35256-1-frederic@kernel.org>
References: <20251105210348.35256-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block subsystem prevents running the workqueue to isolated CPUs,
including those defined by cpuset isolated partitions. Since
HK_TYPE_DOMAIN will soon contain both and be subject to runtime
modifications, synchronize against housekeeping using the relevant lock.

For full support of cpuset changes, the block subsystem may need to
propagate changes to isolated cpumask through the workqueue in the
future.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..7a6137b15dee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4240,12 +4240,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		/*
 		 * Rule out isolated CPUs from hctx->cpumask to avoid
-		 * running block kworker on isolated CPUs
+		 * running block kworker on isolated CPUs.
+		 * FIXME: cpuset should propagate further changes to isolated CPUs
+		 * here.
 		 */
+		rcu_read_lock();
 		for_each_cpu(cpu, hctx->cpumask) {
 			if (cpu_is_isolated(cpu))
 				cpumask_clear_cpu(cpu, hctx->cpumask);
 		}
+		rcu_read_unlock();
 
 		/*
 		 * Initialize batch roundrobin counts
-- 
2.51.0


