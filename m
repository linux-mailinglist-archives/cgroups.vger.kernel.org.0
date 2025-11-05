Return-Path: <cgroups+bounces-11630-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7488CC37EC7
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E161A24238
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBE53587AA;
	Wed,  5 Nov 2025 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTniV3S/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337E34F473;
	Wed,  5 Nov 2025 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376800; cv=none; b=rG7EUZPBUwMjIij553SG4UchbLhmOPupR3Khhzkf+CwR7xXXj0oUd7vhFxYRw4cd7HXCLtdXjJ7nuAY2NpjEXWXTUdDNrCpwKAq2F5pxmEgwP/46XvFU/tT1P0wtMNOsxSjVNAx8yEy6hu7LZDLCqBC4/jWxoqriT3MK0J5+oGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376800; c=relaxed/simple;
	bh=fIAIlX7FO5mGPQBGWuCynXC0SPKY4AIZnRPcce8YI4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgdkAZLfckvgIPtzxrG145BL+ebR/L0/V5NozohYD8nHJaRymNMzCBkzBXA1MIwWvLNzC8FKYCDDl6K772a28ORyEWDVGqFqcLCt1GB/G0Bi9/zDkV3WgE+0QYDkc2PNem09JF85mEvOrjKYhcUhgz/M1Iu3JKrvf0aPhYAnyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTniV3S/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA7FC4CEF5;
	Wed,  5 Nov 2025 21:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376800;
	bh=fIAIlX7FO5mGPQBGWuCynXC0SPKY4AIZnRPcce8YI4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTniV3S/EeJ80AND7KBDsXu8Xpe6JM7FMSiWlVLuYUSx1fZ5Es85QML/UqcAKlExj
	 TBu3d6jiTcVnPTUg6trXffi1yL6+pk2kHaXc967OfABBppOpNR5YB2toKuWySjNocr
	 1Ukzr9rUGpHh4p8j/EIRfYT7VJZihm/gISAZHj3geJ0Xs5YxKq6o19WtZqjCQ0TkpX
	 c51eNX+XGOtADtu9WKoX3bLS7Mi06TUMXagWf5Ke6icI1nHCDIn0D3kNee0ZMbEPHH
	 HWTE5hGnM2szJSqgHeTuViOa94S94x6lb8KEOyvrSQxjXsBjNj1jUHxi04XQhFi5Bm
	 DVfpNf5l6u1aw==
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
Subject: [PATCH 20/31] PCI: Remove superfluous HK_TYPE_WQ check
Date: Wed,  5 Nov 2025 22:03:36 +0100
Message-ID: <20251105210348.35256-21-frederic@kernel.org>
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
index ac86aaec8bcf..e731aaf28c76 100644
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
2.51.0


