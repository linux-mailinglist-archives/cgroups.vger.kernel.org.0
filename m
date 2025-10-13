Return-Path: <cgroups+bounces-10672-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09CBD61AB
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 22:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F9E421EB8
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 20:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A2309F1D;
	Mon, 13 Oct 2025 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y74oHsMC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3463093CD;
	Mon, 13 Oct 2025 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387558; cv=none; b=o1DLaNuEEQO7bGDNfqPi41A8OGEFEPQXMMsegYtMKjbaOhlwd3YDtUeacA5rGE6/WDtiraFSMa6vClpPdDOLzCrT1pLfekzc+sBIlLsziS39Ad3aSSTMUR5GO9JBaV3McQ6WpYwfHQAXirpAUJArkeRbr3+zOxDLnEPJ8IgKIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387558; c=relaxed/simple;
	bh=0DsWfneCzpjIl5WbzWDNydymwnwOLTzShyRdiw34zDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgfX6rnM80PFl/qU+OObsny7xcUmmUHlcCZAKBwixFBTQLc4oizhmiieBUuRqHBJ2UiiVTddIxKMsc4Lfu/QYz1TyAAw+aVG14gSRUyCJKvkxXTenFm4FzJF5ydHN0L1FRVCgWPpHtL+8lnJ8uo3pImyctv9nwkMJdEH8/Fgq/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y74oHsMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCA9C4CEE7;
	Mon, 13 Oct 2025 20:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387557;
	bh=0DsWfneCzpjIl5WbzWDNydymwnwOLTzShyRdiw34zDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y74oHsMCUCu7xOUlp9LjQm6NP3nUM+9L06MxVNQbTC49iOQPzY3C7M9sVklCKROT5
	 fNk3jHeO+EYTF+wNfi97wYtL6cD7is4C47Xjld+LW5m2+8AmghpZuErpsufnn7JYtz
	 0Eh7+vvIb3tpv6FKaaajFXK5oCF8Nc4efzes0xyaxQQqt+QbXch9Tizl4KJb/5a6CX
	 XuLKEUq59kRyITBcpG5J+NZQUMhZz2W9EFcqsqLoZjYbkuSOwZGc19LtJk698QFUjP
	 gz22SoQuMWCIQYRcP1zFr1BfDhIiTIMDLOSDnEzXuTOPOvzt4GVDU+kFULF/8BtWYb
	 i9U3ltzfA02vw==
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
Subject: [PATCH 05/33] sched/isolation: Save boot defined domain flags
Date: Mon, 13 Oct 2025 22:31:18 +0200
Message-ID: <20251013203146.10162-6-frederic@kernel.org>
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
 include/linux/sched/isolation.h | 1 +
 kernel/sched/isolation.c        | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index d8501f4709b5..da22b038942a 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -7,6 +7,7 @@
 #include <linux/tick.h>
 
 enum hk_type {
+	HK_TYPE_DOMAIN_BOOT,
 	HK_TYPE_DOMAIN,
 	HK_TYPE_MANAGED_IRQ,
 	HK_TYPE_KERNEL_NOISE,
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a4cf17b1fab0..8690fb705089 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -11,6 +11,7 @@
 #include "sched.h"
 
 enum hk_flags {
+	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
 	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
@@ -216,7 +217,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 
 		if (!strncmp(str, "domain,", 7)) {
 			str += 7;
-			flags |= HK_FLAG_DOMAIN;
+			flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
 			continue;
 		}
 
@@ -246,7 +247,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 
 	/* Default behaviour for isolcpus without flags */
 	if (!flags)
-		flags |= HK_FLAG_DOMAIN;
+		flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
 
 	return housekeeping_setup(str, flags);
 }
-- 
2.51.0


