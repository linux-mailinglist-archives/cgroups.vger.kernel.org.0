Return-Path: <cgroups+bounces-12858-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D092CED68D
	for <lists+cgroups@lfdr.de>; Thu, 01 Jan 2026 23:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA0BE30006CF
	for <lists+cgroups@lfdr.de>; Thu,  1 Jan 2026 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EF128B40E;
	Thu,  1 Jan 2026 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjJIQyPZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6B248F5A;
	Thu,  1 Jan 2026 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767305728; cv=none; b=CqLmemREAU9UhC5ZNU1K+zg9vNrzbli/RIEoTP/2UemA0DlKBZvH717jyumJbXSU9s6f0bLPRjHWfE15PlrXgz9vQY6fLeI+YJe2CB/5ohEeYPEN3hd9zbG3LbcLxutSyn6EnXwhq9Nyo6kKGetXOOGsYJEaHJLeXhFKh6nnkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767305728; c=relaxed/simple;
	bh=CSBqMHaVS4LYUH4nZYK0n1Q3mrGckGoVFLRQaFReEXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8E/5mnFS3BqM7hUQM7NrwqR/ADfc7o0U7Ed0eEK4P3WxvIH7JiF14G35vXztLl76ON1beo+PhJo216cjI6HzkV/dz+SsqBWGLKNjSIwUfiT3jVHyi72o+/w6uzeB3EmbSBTwQrBfr26BM3qilGWEuYw1Jy37rRMbD29ofjqy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjJIQyPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B51C4CEF7;
	Thu,  1 Jan 2026 22:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767305727;
	bh=CSBqMHaVS4LYUH4nZYK0n1Q3mrGckGoVFLRQaFReEXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjJIQyPZ3gNH+xw/gL3DNsTYhPXKrLZGi+D4wZQyD/V9H6meQ28ftUtJ322hNWm6R
	 5KdjwiHSktvOFFoVDCyBtYLnU9HjLsgFkaWgfhBfA2hcf29PmqGHSFCZ492lymdaj5
	 55ZgJnaLIL5LkrhelQb0w4bW/QTmDSGT6kndD4EuRqOLUBKqJZmcOhCgZ903eSxams
	 /TbBRyvx2meH/0HFPN546AYKBNER7m35Pbjlx1R/LHKVmP4MUyfEYZlHYfCYgB0T8p
	 DwjBvugnF9Y55uPBHcwYxhBnmLhu3yZKw0Wk4nZK8QmCVpCskJyWtXmhuh9oEZ39S6
	 2palunZI8oI9Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
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
Subject: [PATCH 09/33] block: Protect against concurrent isolated cpuset change
Date: Thu,  1 Jan 2026 23:13:34 +0100
Message-ID: <20260101221359.22298-10-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260101221359.22298-1-frederic@kernel.org>
References: <20260101221359.22298-1-frederic@kernel.org>
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
Acked-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1978eef95dca..0037af1216f3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4257,12 +4257,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
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
2.51.1


