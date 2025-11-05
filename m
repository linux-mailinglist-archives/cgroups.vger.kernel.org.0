Return-Path: <cgroups+bounces-11634-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3339C37E91
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 228B04F4131
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7334FF7B;
	Wed,  5 Nov 2025 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szIDSeRI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D6337BB2;
	Wed,  5 Nov 2025 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376832; cv=none; b=XO70Vamx8nV1lb00FFg2k9X066UMk/fUlc0tCpeJDeGu8oZ+E0xrFCM1WW6n+xaktARqn2jQUQDU2At2wWPAV26EBnwNYfNC3RbFXymUClzMeZBpHC5+4znwRIfuHdBH+YBVniwdNHeBrUfnbG0BVtTZOKEIBteatS41Ay+G9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376832; c=relaxed/simple;
	bh=J6j4zsULKpjy2xGkRdPN0GqxRFQVWDdmCEJclS8fknA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tp40LY3qV4op9IGVhMvOUZIoRuQFmGsmp4QnvwcTCLgZ9MpKUXG7POWuxWRGxRMDGTh0XNxNpeuN9GtDQDJ4S0HsZQRyjk1Se72J8iEKbcwbOxbi+3hmWRBqCHpDlg9n2r41pOlSdlcuWJ5wkCuYZaqcUfGdXBM1hq4wEftibnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szIDSeRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81075C4CEF5;
	Wed,  5 Nov 2025 21:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376832;
	bh=J6j4zsULKpjy2xGkRdPN0GqxRFQVWDdmCEJclS8fknA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=szIDSeRICvuPVa22uckyIj7tLtbwryeVGfvVRmV5zDtNt+6NVBCBqBwYblGbDqHv6
	 WQdkxwLPuV6izEzNadmWY/Cp9t5y4JB4wOFuPfAabLsKAgXFvGeFbrrhzqeNduk8ES
	 yUOiqND2LZGDY74RENtGR/Bq7PP6DayV2rI64BjaalSyI4LE4lkSiJrfizlKFn1Emx
	 uvFPUHCmqtSHSOY5v+/BkFDW/Z0kokfN1Y/al6wn7QE3P1GrD20T3kbhNhdCZ3GLRg
	 rZ7BiZ/qbZ2XKuvtAYnPwl0IiJ1OfTlvfENurtuaeb+8HQO0rRM7YpPG6V6BEzxd/v
	 N3mdEa+6d4mDw==
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
Subject: [PATCH 24/31] kthread: Rely on HK_TYPE_DOMAIN for preferred affinity management
Date: Wed,  5 Nov 2025 22:03:40 +0100
Message-ID: <20251105210348.35256-25-frederic@kernel.org>
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

Unbound kthreads want to run neither on nohz_full CPUs nor on domain
isolated CPUs. And since nohz_full implies domain isolation, checking
the latter is enough to verify both.

Therefore exclude kthreads from domain isolation.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 86abfbc21bb0..69d70baceba2 100644
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
2.51.0


