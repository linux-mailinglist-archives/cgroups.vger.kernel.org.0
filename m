Return-Path: <cgroups+bounces-11616-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5DCC37D9E
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1461A3B875D
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AED34F257;
	Wed,  5 Nov 2025 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3jxBxnc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38ED34CFDE;
	Wed,  5 Nov 2025 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376689; cv=none; b=tsEY1RVZoAhpBsda0qqh7WM8Jjt7wXe/yQccMurwZvKsFW4lKtJOSxywfrh1UbOULkmLIoYavfewcnEipaLqRwsW8sybdaZTxCbH/KdstCDTOsSH8Abv4B2OTBom+1OAjQMF542BqnjoVFmu81Fm3vAPvQHevATnyvisI312/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376689; c=relaxed/simple;
	bh=4bRWbV0YuzmDy1B/sRgCWln6RMh7KL9GReKc3Nnqm6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2gNhtYbD5ljrqABwfFyEx8DTZpRfo81JX/vfif6i33AzcCg9C1cI3GUMbJKetQRt0aoa/qPT2m6o4BeJb+taMVoMhLI7Fmdtkz4uE2JrucyM7Mevo/27/TPPFfLtTijMbZANgJAFbIGYWTLoYbWqFwH0m0IqzmCn3aeyXdKHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3jxBxnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24B5C4CEF5;
	Wed,  5 Nov 2025 21:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376689;
	bh=4bRWbV0YuzmDy1B/sRgCWln6RMh7KL9GReKc3Nnqm6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3jxBxnchXPJZKH2so0QCGrjyVavB6XgcFLZnwbf0ylrkboEezz9X/2eMG8q91HHH
	 IAy92pFmbbdtvG33O3dU7hzjvMro+XMvvQrNO/4OHnD9UvLBMJlxfs33g9qiYG2hYK
	 Z0ilCk2hxybBfgiC79MXfe3wp5DcBV55tZ8C2OtTr6lrdTxYZyW0YhSWQqXLYhiguS
	 KJRtlYb248Pfs9ZOvisxol44RbREaI0m1UwUFynnMWwx9v9jprD0lSiNDM6UD69QkS
	 z51fmf04HQKK4hqG5yCwVC8LmdU7H4H6mQNm+oJwCuT4iwU5cBY2Mo98ASdwndibIo
	 jTUvvHb6LCGVg==
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
Subject: [PATCH 06/31] cpuset: Convert boot_hk_cpus to use HK_TYPE_DOMAIN_BOOT
Date: Wed,  5 Nov 2025 22:03:22 +0100
Message-ID: <20251105210348.35256-7-frederic@kernel.org>
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


