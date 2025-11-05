Return-Path: <cgroups+bounces-11613-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B2C37D6E
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0E724E80B0
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5D34DB78;
	Wed,  5 Nov 2025 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTjEW+Lp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA0034CFB4;
	Wed,  5 Nov 2025 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376665; cv=none; b=IB+4Cbb9YzAihstGX0zL0B0xhmKF1pbwPQ0wRmufMEjDZWloH9bb3Pru+Lr3Wt1Ei39YBNj2/oTB6pBj60tBOQmkzbT3x5WIbQjph6DHtB8CqsHJeaFx+9KBiItqeoWhb0Y45HJexbnr7HLoGZiXfVlwkF+eNmQjuhDl4SZtGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376665; c=relaxed/simple;
	bh=QDY6OFwPCpaj5eQjhmw6Wwop/7HtBl8sFRDTAL/mseY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pm86ySoCua8W7eMkjc0ZnBgq7dfCO+mXO3r56zBYd0i497b4PpQrL9aUeHyEQhRl7OKWzNPTAGX83Aa4lkCC540B/D61C52Wst89PcvXGWJjs3jmxR4jOF9PEMLnhWPmmA0cvWeBlqTI9CH8F07ES6C8yXabVCJ1OFa2rINr9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTjEW+Lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C864C116B1;
	Wed,  5 Nov 2025 21:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376665;
	bh=QDY6OFwPCpaj5eQjhmw6Wwop/7HtBl8sFRDTAL/mseY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTjEW+LpKe78Iwb5IpUCFicQk91WKrouEhNOVkCIWNJWT/IUfA+/1BuMRMTE/GSNf
	 +H7F8egVjXkx/lSP96kC+SuuJLTGF/8XU6ILZHU9JyBzgy3HxvUFPliaEIO6h0Pw4Q
	 NVPHhj8BuptnLIKmapcvKpE/aGeO4jSutNhuT0C4PABWjnpD9Q5cuNIdyWXg3giORC
	 Fi9PFedNEfYKwdFXqkXdRc0iWC1GJiQi2RRoWyt+ov+H9uiPm/BOjklQPfkM6OtIbG
	 I2NCBOxhuNhTQcrNQ8aEH7WXQtqQYaJPe3rmjJTxzn9fdSN39b2M5jDqPW6Yafqx0c
	 MhWXAmuKuHXaw==
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
Subject: [PATCH 03/31] memcg: Prepare to protect against concurrent isolated cpuset change
Date: Wed,  5 Nov 2025 22:03:19 +0100
Message-ID: <20251105210348.35256-4-frederic@kernel.org>
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

The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
runtime. In order to synchronize against memcg workqueue to make sure
that no asynchronous draining is pending or executing on a newly made
isolated CPU, target and queue a drain work under the same RCU critical
section.

Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a memcg
workqueue flush will also be issued in a further change to make sure
that no work remains pending after a CPU has been made isolated.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/memcontrol.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f4..1033e52ab6cf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1971,6 +1971,13 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
 	return flush;
 }
 
+static void schedule_drain_work(int cpu, struct work_struct *work)
+{
+	guard(rcu)();
+	if (!cpu_is_isolated(cpu))
+		schedule_work_on(cpu, work);
+}
+
 /*
  * Drains all per-CPU charge caches for given root_memcg resp. subtree
  * of the hierarchy under it.
@@ -2000,8 +2007,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				      &memcg_st->flags)) {
 			if (cpu == curcpu)
 				drain_local_memcg_stock(&memcg_st->work);
-			else if (!cpu_is_isolated(cpu))
-				schedule_work_on(cpu, &memcg_st->work);
+			else
+				schedule_drain_work(cpu, &memcg_st->work);
 		}
 
 		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
@@ -2010,8 +2017,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				      &obj_st->flags)) {
 			if (cpu == curcpu)
 				drain_local_obj_stock(&obj_st->work);
-			else if (!cpu_is_isolated(cpu))
-				schedule_work_on(cpu, &obj_st->work);
+			else
+				schedule_drain_work(cpu, &obj_st->work);
 		}
 	}
 	migrate_enable();
-- 
2.51.0


