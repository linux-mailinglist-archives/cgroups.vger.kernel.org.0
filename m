Return-Path: <cgroups+bounces-12676-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 241A7CDC708
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 14:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAEEE309C076
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF8354AC2;
	Wed, 24 Dec 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuY1u8Rz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE3352FAD;
	Wed, 24 Dec 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584129; cv=none; b=nzksGueAMhaZr2qFm/ebbKCCCx6Kb7cAOlyfhPfBtacEaXskshb+mzW8jk3I0rzXI/L0kFz65S2Y8M+mx497dLKHXmHilVTSN6phkaiP0rIERqmXo202x1R3ZBWI2BMObO8o2KsW33yXoMLPOK64yxQRZftspRl3pUIR3wtTsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584129; c=relaxed/simple;
	bh=A8T9Nt5SRDhTjWCk2XTP9uMmIZ8k8WhHtELVSGlUK7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSWG4b1gJQ5bhDEULGwki4fT9kN1hXa/YfmIS8Cej7S/KJd9VvbIgbOstPauzVWGCTscjnHDHsJM6csQIBf1cuy2TjqSwQPSbSL9lEDNHIWQqmO7XMtwQRuDTWtNwUO9pJKtYzJI2dvfBNZ2R1S8LED/jA15wbgCiGjVgpL4Qyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuY1u8Rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DE6C4CEFB;
	Wed, 24 Dec 2025 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766584128;
	bh=A8T9Nt5SRDhTjWCk2XTP9uMmIZ8k8WhHtELVSGlUK7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KuY1u8Rz/vaDMQjR2MduOKoqcP3JJ9dZEbloX6lhXdXVpmxWAzJIaQm3eFg/D27zU
	 lUafuPB2AoUO60eHIuJvuu/m6OXX7ZEEz1Oq8bxROsWzYSdKvSUuUK/5HO71jIMixa
	 4QGfLZwXMeDTLbl/ZR5f7UsqA0/+3ilmlN3S0gTkCDQusqv50zQ6QFshATbiWqw2Id
	 xMidRdd8Ofj9Le4qh6i/2QdArks8ocuNp1MNGmE26zBEUzp9CT8I0OkWU4qpszM38g
	 BYupaN2e+pTopKIZqnKPL7f+wpgqeZV1/GK2kbN2pGJTpTuA6NiJbtWnPELGFGbMF2
	 LnjLg5nkSaQug==
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
Subject: [PATCH 23/33] PCI: Remove superfluous HK_TYPE_WQ check
Date: Wed, 24 Dec 2025 14:45:10 +0100
Message-ID: <20251224134520.33231-24-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251224134520.33231-1-frederic@kernel.org>
References: <20251224134520.33231-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It doesn't make sense to use nohz_full without also isolating the
related CPUs from the domain topology, either through the use of
isolcpus= or cpuset isolated partitions.

And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.

This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_WQ is only an
alias) should always be a subset of HK_TYPE_DOMAIN.

Therefore sane configurations verify:

	HK_TYPE_KERNEL_NOISE | HK_TYPE_DOMAIN == HK_TYPE_DOMAIN

Simplify the PCI probe target election accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/pci/pci-driver.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d87f781e5ce9..a9590601835a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -384,16 +384,9 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	    pci_physfn_is_probed(dev)) {
 		error = local_pci_probe(&ddi);
 	} else {
-		cpumask_var_t wq_domain_mask;
 		struct pci_probe_arg arg = { .ddi = &ddi };
 
 		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
-
-		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
-			error = -ENOMEM;
-			goto out;
-		}
-
 		/*
 		 * The target election and the enqueue of the work must be within
 		 * the same RCU read side section so that when the workqueue pool
@@ -402,12 +395,9 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 		 * targets.
 		 */
 		rcu_read_lock();
-		cpumask_and(wq_domain_mask,
-			    housekeeping_cpumask(HK_TYPE_WQ),
-			    housekeeping_cpumask(HK_TYPE_DOMAIN));
-
 		cpu = cpumask_any_and(cpumask_of_node(node),
-				      wq_domain_mask);
+				      housekeeping_cpumask(HK_TYPE_DOMAIN));
+
 		if (cpu < nr_cpu_ids) {
 			struct workqueue_struct *wq = pci_probe_wq;
 
@@ -422,10 +412,9 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			error = local_pci_probe(&ddi);
 		}
 
-		free_cpumask_var(wq_domain_mask);
 		destroy_work_on_stack(&arg.work);
 	}
-out:
+
 	dev->is_probed = 0;
 	cpu_hotplug_enable();
 	return error;
-- 
2.51.1


