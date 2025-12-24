Return-Path: <cgroups+bounces-12658-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF7CDC633
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 14:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEB02303D7E5
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E675233B974;
	Wed, 24 Dec 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htqHmciL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E023C503;
	Wed, 24 Dec 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766583975; cv=none; b=p9FvPK8arrLKpVmIdF7H1Uw+e7LXo6wH5NQbbG1k0tUXvQLMRgP3d/g9WCMcA6UyKYG8UPkS1OOqw/Rc174dBfcEeAR0mi1rw4RjqRo6LAejEJQqN+rBKZv36ToRmQ7CmS2sh4F3/VmYEV6V9K9NWfGowM5zXooxhF+kxMp1ur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766583975; c=relaxed/simple;
	bh=oYIDljVusPRyc5ygPH/YiE7a9Fhd9e2pU1qivro5W4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0sAsuMOMG+eUFePAimEBSWI+txm24meEKxjoS0NXAouafRd+gXvP/FuJnqA2Bps07W+Na4QoKFdxNsGVK0P/PVeaGj5EGFvAAHmC91uQrobHvVUv0ig+MZd+6TJ/dosVVgJm165equ+/7X6OXj8I+1RXZhkQkopSB/985S0TNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htqHmciL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6704AC116D0;
	Wed, 24 Dec 2025 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766583975;
	bh=oYIDljVusPRyc5ygPH/YiE7a9Fhd9e2pU1qivro5W4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=htqHmciLhDIlwaAafpUU2VX1XDfcCQEG/G/wYBGqRb079YKOzQ4bLKuDSO20ILSbT
	 x2ty2FrkhGcjZGmNhcNmU/XB8AIWGPf/OFBLStI85bMZdQFAmzFShHb3qUa+DBeXsL
	 5uUPDkZhhIXRn+GO1UNkvMkdEkkexiOP29/cwdP3Gid83GGZU3YG/Q0/T9P1LqjAKU
	 F1HAzDo2rY5jq99eUCywOkGr05yck1Ixww1LbBMc0+QCaK7qNicMaB53+WM1SMi1LB
	 MZmedPl3zj6CvYqKtcScMTcR2Amms6hosgoprArwalGEXKya77EoHgIlGEufV9r9EB
	 qCBxAiEKpDJQQ==
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
Subject: [PATCH 05/33] sched/isolation: Save boot defined domain flags
Date: Wed, 24 Dec 2025 14:44:52 +0100
Message-ID: <20251224134520.33231-6-frederic@kernel.org>
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

HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
but also cpuset isolated partitions.

Housekeeping still needs a way to record what was initially passed
to isolcpus= in order to keep these CPUs isolated after a cpuset
isolated partition is modified or destroyed while containing some of
them.

Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
---
 include/linux/sched/isolation.h | 4 ++++
 kernel/sched/isolation.c        | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index d8501f4709b5..109a2149e21a 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -7,8 +7,12 @@
 #include <linux/tick.h>
 
 enum hk_type {
+	/* Revert of boot-time isolcpus= argument */
+	HK_TYPE_DOMAIN_BOOT,
 	HK_TYPE_DOMAIN,
+	/* Revert of boot-time isolcpus=managed_irq argument */
 	HK_TYPE_MANAGED_IRQ,
+	/* Revert of boot-time nohz_full= or isolcpus=nohz arguments */
 	HK_TYPE_KERNEL_NOISE,
 	HK_TYPE_MAX,
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 3ad0d6df6a0a..11a623fa6320 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -11,6 +11,7 @@
 #include "sched.h"
 
 enum hk_flags {
+	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
 	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
@@ -239,7 +240,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 
 		if (!strncmp(str, "domain,", 7)) {
 			str += 7;
-			flags |= HK_FLAG_DOMAIN;
+			flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
 			continue;
 		}
 
@@ -269,7 +270,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 
 	/* Default behaviour for isolcpus without flags */
 	if (!flags)
-		flags |= HK_FLAG_DOMAIN;
+		flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
 
 	return housekeeping_setup(str, flags);
 }
-- 
2.51.1


