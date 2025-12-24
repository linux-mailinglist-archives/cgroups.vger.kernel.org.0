Return-Path: <cgroups+bounces-12685-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0012CDC92F
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 15:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1389F306D67C
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D9C35A93A;
	Wed, 24 Dec 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED8aVW74"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB435A92B;
	Wed, 24 Dec 2025 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584205; cv=none; b=g/olDdBmg30U7WmIhR7erS8l8gK9Bga3Em3YKtfhg/+py9FyUCX22CjbUV8StQ8+PABnJvtTRcOJ8jgbYfwAfvnLjMIEPDSZ39Q3x5fqHCqSpJu7WRrbdipmNs+xF19h+WlWUDx3S1Sth5u3cjKx3havSw0zW/FlKKbnyTRqQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584205; c=relaxed/simple;
	bh=kluxsGzh3yUyBuEdMQW2ChyzrN9Wa4B73tu4Iho0QMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=So2zAAHQSZICoYUKr7bmB2av6l/5GpaIk+fRexi7lkj3HdtwpkZCL6E0yuUfaGjiaJdZj4hBtxAjiomx3o6CvDG2uz6eQvOldpZIBq8KNPEOi0mebaFa2wySzIzyAN6galN+4kfCiPGg32M+rpLh89vCx9/K7TB9AuxWin8M5jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED8aVW74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98524C4CEF7;
	Wed, 24 Dec 2025 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766584205;
	bh=kluxsGzh3yUyBuEdMQW2ChyzrN9Wa4B73tu4Iho0QMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ED8aVW74APnBRvzGpOYVOFXbISRUsSm2ff53aXv0cWlkuHzOa2Q7QLiJId6sHUyzN
	 rkK7hTT6utUbQFbv9Df3yhyCa4a8EYD50BV5521k0CI2l3AehI+q/A+085+RK2ThGK
	 wvYl9sJQUScLxm3mKhBNH3YhFcIwGu1GH7wQB4YyxS/SkG4Nvoc4QK5tSR5YexlEny
	 6f20Uaepl338lDSloLKe39VsAqy2OxcQFbfkUg/+huV1Y3z61CgCJMswZDPm2OK7Ft
	 bgTx4CvDQ/1YAp+ph0GVI2FQhlYM9WTBhc2gtIOsrRGOMZsvUVeGeCAwy4V9Rh2Ybl
	 UzfA5FSzot4Kg==
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
Subject: [PATCH 32/33] kthread: Document kthread_affine_preferred()
Date: Wed, 24 Dec 2025 14:45:19 +0100
Message-ID: <20251224134520.33231-33-frederic@kernel.org>
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

The documentation of this new API has been overlooked during its
introduction. Fill the gap.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 51f419139dea..c50f4c0eabfe 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -856,6 +856,18 @@ int kthreadd(void *unused)
 	return 0;
 }
 
+/**
+ * kthread_affine_preferred - Define a kthread's preferred affinity
+ * @p: thread created by kthread_create().
+ * @mask: preferred mask of CPUs (might not be online, must be possible) for @p
+ *        to run on.
+ *
+ * Similar to kthread_bind_mask() except that the affinity is not a requirement
+ * but rather a preference that can be constrained by CPU isolation or CPU hotplug.
+ * Must be called before the first wakeup of the kthread.
+ *
+ * Returns 0 if the affinity has been applied.
+ */
 int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
 {
 	struct kthread *kthread = to_kthread(p);
-- 
2.51.1


