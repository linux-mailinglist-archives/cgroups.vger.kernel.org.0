Return-Path: <cgroups+bounces-12855-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1CDCED666
	for <lists+cgroups@lfdr.de>; Thu, 01 Jan 2026 23:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A69F300B80A
	for <lists+cgroups@lfdr.de>; Thu,  1 Jan 2026 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE572701DA;
	Thu,  1 Jan 2026 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwXUOgHh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394223E350;
	Thu,  1 Jan 2026 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767305703; cv=none; b=CbaVqkGknD0PiARFUcLhfhA2UQ58U5DKtUj+j3aB0AMdS4SImwttMQCl05JiYsrsCe8ftIFDKj09thQYDgeTTMinh57Yfxm6DKedjxEOLrOSpeq5FSfI3Bl4pawWohozJO7XIjEMIqL1HArcKE+3IJ1z9V6ExtoTS62vTd31bxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767305703; c=relaxed/simple;
	bh=pTB9cNPcvPakmWV9jutt30tCCHfCDIAA9k4V/apVATM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tY9A/XL16rytjkGlgMQ50fCjDBf8t8Po78HbfyN+WIXgLseMbeBQ03Uxh9Ey7siyauuUridYUgvaL9ZUZgSFjuVjp2TuezYhyj66vc9/XiRnnITzXY0/KjZNP+KFcPbtBDUrl2EubsQ2wq+jzEKD8Pv2wIBV6OWrwCIkKadBlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwXUOgHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D948C19421;
	Thu,  1 Jan 2026 22:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767305702;
	bh=pTB9cNPcvPakmWV9jutt30tCCHfCDIAA9k4V/apVATM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwXUOgHh5SZusqdj1MuBOnHQSG66GUsBSUq9kZmTGHcPWpcV945zTsBbzfhh9gRwQ
	 5Ys00+vpPwfvVsflAum3U8GgE/7M7GFNZ3ZSAEWEl4wzQYn/4oZiHZNc16OWnHbhK6
	 09XASD6Q7S/OOE+tB2MgcECKmN4VNWfVTTkcncpOgr+ODrxDK+HfyLvp+mOWp+C8vB
	 vKwMCR2Q4jkz3xaDI9brAB9ZC+E9AEoFs6nNCBkXT5TDz+brTjkc2oXuPm73U0f0CM
	 IRipKFdDs+YRB//iQcq7lQCUWK36mljq2Bo1Kr/r3JWkqQrQyod2Pxijbt0Fx/qBsL
	 Zh21Loq+Sn1UA==
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
Subject: [PATCH 06/33] cpuset: Convert boot_hk_cpus to use HK_TYPE_DOMAIN_BOOT
Date: Thu,  1 Jan 2026 23:13:31 +0100
Message-ID: <20260101221359.22298-7-frederic@kernel.org>
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

boot_hk_cpus is an ad-hoc copy of HK_TYPE_DOMAIN_BOOT. Remove it and use
the official version.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6e6eb09b8db6..3afa72f8d579 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -88,12 +88,6 @@ static cpumask_var_t	isolated_cpus;
  */
 static bool isolated_cpus_updating;
 
-/*
- * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
- */
-static cpumask_var_t	boot_hk_cpus;
-static bool		have_boot_isolcpus;
-
 /*
  * A flag to force sched domain rebuild at the end of an operation.
  * It can be set in
@@ -1453,15 +1447,16 @@ static bool isolated_cpus_can_update(struct cpumask *add_cpus,
  * @new_cpus: cpu mask
  * Return: true if there is conflict, false otherwise
  *
- * CPUs outside of boot_hk_cpus, if defined, can only be used in an
+ * CPUs outside of HK_TYPE_DOMAIN_BOOT, if defined, can only be used in an
  * isolated partition.
  */
 static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 {
-	if (!have_boot_isolcpus)
+	if (!housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
 		return false;
 
-	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
+	if ((prstate != PRS_ISOLATED) &&
+	    !cpumask_subset(new_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT)))
 		return true;
 
 	return false;
@@ -3892,12 +3887,9 @@ int __init cpuset_init(void)
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
-	have_boot_isolcpus = housekeeping_enabled(HK_TYPE_DOMAIN);
-	if (have_boot_isolcpus) {
-		BUG_ON(!alloc_cpumask_var(&boot_hk_cpus, GFP_KERNEL));
-		cpumask_copy(boot_hk_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN));
-		cpumask_andnot(isolated_cpus, cpu_possible_mask, boot_hk_cpus);
-	}
+	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
+		cpumask_andnot(isolated_cpus, cpu_possible_mask,
+			       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
 
 	return 0;
 }
-- 
2.51.1


