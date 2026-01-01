Return-Path: <cgroups+bounces-12876-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDEACED7CB
	for <lists+cgroups@lfdr.de>; Thu, 01 Jan 2026 23:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0651C3007DA3
	for <lists+cgroups@lfdr.de>; Thu,  1 Jan 2026 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5A930DD29;
	Thu,  1 Jan 2026 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3tzAh1q"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C508A30DD14;
	Thu,  1 Jan 2026 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767305874; cv=none; b=soj7oguk7xddQzcBd1ZhJsWV/RDQj4ziOzDSfOWAQsSwzHfXLWcNAsCMr8Xc6afridogRvTaYGp+kGk+AbhXoOiKe3o3nr6/fHWsb6d1/8KiTsPHAu6k/dp97HWbwivBV9AFeqT1uczrzfE5Bf9iYV1T+INiQl8oNTuaChFB7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767305874; c=relaxed/simple;
	bh=OKxr66AuTYpmtINGeWatnOeeLWTfC6xUU/wfI1fZOeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrILqCXd9AEXg9kOO92KC9l9unsS0IemVVrnuSHNkP8bZStUIUBIFABCrWefERaS55hrAqS5G1CZKQc+wQ9V0ZtI8Ild7lZ1SyA2GhcHAqLk6yN3jas36h95gP84VmdDwE4VKcWxtAaRJuzkZ0I8SaqoG0MA3q9qeMbbosmnWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3tzAh1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696F1C4CEF7;
	Thu,  1 Jan 2026 22:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767305874;
	bh=OKxr66AuTYpmtINGeWatnOeeLWTfC6xUU/wfI1fZOeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3tzAh1qqBzEdJr7W13PBSjlKJJ2OZj+v1bk3WgK5Y/gMgiJhnOqkbzrE4d5fNn6r
	 3ihlWEqcfPQ/esrNTdCUpshwQlHu06VG7Fg8ddHxFPeJyiGDYP6VsaEe7AtkYGFNID
	 7bW3zS0Mk2L74PT+vdla6Mz6/0qfIdMkfBICDBxermqoh+GzMfbu/cvTlTD1Um7KNG
	 qADGnv9N68YVfnTeHvZRAP+S2Gd2w3P6I51mCUa2XTbkMdiLCDF9BPwbcddsZ2ehdj
	 ZdhkVDdGYr4dZ1sqs2Pe0ofLfYQE9v4eJ/Tk1J3wPU7EWgXsmp45dISB+MYVn2h/GZ
	 vonDrbTOK4C9w==
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
Subject: [PATCH 27/33] kthread: Rely on HK_TYPE_DOMAIN for preferred affinity management
Date: Thu,  1 Jan 2026 23:13:52 +0100
Message-ID: <20260101221359.22298-28-frederic@kernel.org>
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

Unbound kthreads want to run neither on nohz_full CPUs nor on domain
isolated CPUs. And since nohz_full implies domain isolation, checking
the latter is enough to verify both.

Therefore exclude kthreads from domain isolation.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/kthread.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 85ccf5bb17c9..968fa5868d21 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -362,18 +362,20 @@ static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpum
 {
 	const struct cpumask *pref;
 
+	guard(rcu)();
+
 	if (kthread->preferred_affinity) {
 		pref = kthread->preferred_affinity;
 	} else {
 		if (kthread->node == NUMA_NO_NODE)
-			pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
+			pref = housekeeping_cpumask(HK_TYPE_DOMAIN);
 		else
 			pref = cpumask_of_node(kthread->node);
 	}
 
-	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
+	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_DOMAIN));
 	if (cpumask_empty(cpumask))
-		cpumask_copy(cpumask, housekeeping_cpumask(HK_TYPE_KTHREAD));
+		cpumask_copy(cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 }
 
 static void kthread_affine_node(void)
-- 
2.51.1


