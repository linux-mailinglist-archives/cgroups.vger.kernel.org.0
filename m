Return-Path: <cgroups+bounces-10673-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DF4BD61BA
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 22:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC7554F3CEF
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 20:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E630B530;
	Mon, 13 Oct 2025 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhGBkZi9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167430B522;
	Mon, 13 Oct 2025 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387566; cv=none; b=mjjqkMJprOvzXITkkoYzTev0bbaOcaQ56D0mn0ngnGZX8N5SGtGSa1G33jGQZ8hdAy+6Mp0eOGZKc1mH3XVAWvoUYJSVdoURswtHyaxan/NaZVfge/tWP0XCeYHZI+hfpyDdar4g1WgTRG2JM2GI+zfm7x45Dl/y8HQqNJB7Lh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387566; c=relaxed/simple;
	bh=4bRWbV0YuzmDy1B/sRgCWln6RMh7KL9GReKc3Nnqm6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgEQ5AGpc2msOBEL8JqTkYhMHAhIq8iceLjR7c+tSKimDbUmaHvnEiqpbzWWhFvtpc+/J+/4SCVKwSAWaYSc1YrpchBO2Cx+uL0fC2HTgYgWXmEHMegT1MEX4y6rmX8/0O9g/lIEIJYPj2Ow8jJFzIpyPITn3oChQqD3f4+jnqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhGBkZi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A89C4CEF8;
	Mon, 13 Oct 2025 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387565;
	bh=4bRWbV0YuzmDy1B/sRgCWln6RMh7KL9GReKc3Nnqm6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhGBkZi9MnxwjOJytxqClEHKzOENZfbkLSvQ1M4jP6Ka7W01jMwLORp33hXCTK/0F
	 lpF3bG3AY7QGUgYRotUsYLwasL8N1/87VeZZFTtlK/hw1DZyy+/hqdCPqRGd4jTz3G
	 PX1K9DMq5s229QMH06atQ5/UI6Kuz0UkIuw0GW+jCbCav8mNJfoDkzNQnR8LUaUsfb
	 DNroVXWCOkC4MrF3I0FPBreVOB6lcD+LSqvld84xyUr8SbcgH5A54O4RB3ZlCNJs8G
	 EQQfG/Di4fw9Y5LjFyLO6+KN8H3lRJPpw5aqjBqr7RCC+btrcBwDa+wITykTmbgLJ9
	 72q3ebLomqdRw==
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
Subject: [PATCH 06/33] cpuset: Convert boot_hk_cpus to use HK_TYPE_DOMAIN_BOOT
Date: Mon, 13 Oct 2025 22:31:19 +0200
Message-ID: <20251013203146.10162-7-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013203146.10162-1-frederic@kernel.org>
References: <20251013203146.10162-1-frederic@kernel.org>
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
---
 kernel/cgroup/cpuset.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a..8595f1eadf23 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -81,12 +81,6 @@ static cpumask_var_t	subpartitions_cpus;
  */
 static cpumask_var_t	isolated_cpus;
 
-/*
- * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
- */
-static cpumask_var_t	boot_hk_cpus;
-static bool		have_boot_isolcpus;
-
 /* List of remote partition root children */
 static struct list_head remote_children;
 
@@ -1686,15 +1680,16 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
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
@@ -3824,12 +3819,9 @@ int __init cpuset_init(void)
 
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
2.51.0


