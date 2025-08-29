Return-Path: <cgroups+bounces-9481-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 957A3B3BFE4
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 17:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764711887743
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999ED3375BF;
	Fri, 29 Aug 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENEga7Da"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6A32A3C7;
	Fri, 29 Aug 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482534; cv=none; b=PgHKlYfcXNt1c63nFkO5qp6hEs2oDiqyw09MYQiwmoMsrwDIir3sKQXczwtKZfjOwh7ojzelBWKiQ0S9Akm9hkTJ30wD6MxUpNG3W2qXQOh8jypEhWtnTWAxZ/V64D7brwfay0tahGuIGTnYpXtyLWInhLnY62DUtUywvok7ZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482534; c=relaxed/simple;
	bh=LPfGRQUCouLlYMYagUni4E5aLlawCBT0lOrgRGdT9YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwDBbhi8FJbe1Lz0+BCORwQRIMh4wgW5V2mKqdP65Kr6x/CkdwqjSGawF7bMDAv64FeKrw8Mhk0ul1lgS/+06QkeNvFRZdWrKbKiR08XBFPrsEIY8s1enc/pld7K5hsEr5XTPRQEGW9c0NPP7Hv0OEbwEYF9QmgJtevpyewy50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENEga7Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3396C4CEF6;
	Fri, 29 Aug 2025 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482534;
	bh=LPfGRQUCouLlYMYagUni4E5aLlawCBT0lOrgRGdT9YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENEga7Dam+kNI8dPxGhGkV8vI6v/8iw/viFTgf36zq726dg9TrY/N8US8GvzpfpFE
	 l5KBzDsoznlioAIEtdNOcA7JpgrNvgYM7FBLPBLpmViRE2xLTtzcbBAOce4GIycC1c
	 UvWwmQZnnbpfONbkQ32MGghq9QWK+bWWITEf1TOUNxLuuYZFD7+WD4DRCYm2RJt2H2
	 rMf5iaKEkP/Abfc7UmAZaHt+HASHdqxbrfFM0sZzRB+XoU1VIIKilMkAVDg7ZJ9xzA
	 81l2ACdYvTlJbyTw3+qrJpOLClcffmd4UoJvAfPTQMp4VupfosmAVh9JWEwSHE6r9z
	 GVbTFOkLpLpyA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 12/33] cpuset: Provide lockdep check for cpuset lock held
Date: Fri, 29 Aug 2025 17:47:53 +0200
Message-ID: <20250829154814.47015-13-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cpuset modifies partitions, including isolated, while holding the cpuset
mutex.

This means that holding the cpuset mutex is safe to synchronize against
housekeeping cpumask changes.

Provide a lockdep check to validate that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpuset.h | 2 ++
 kernel/cgroup/cpuset.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 2ddb256187b5..051d36fec578 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -18,6 +18,8 @@
 #include <linux/mmu_context.h>
 #include <linux/jump_label.h>
 
+extern bool lockdep_is_cpuset_held(void);
+
 #ifdef CONFIG_CPUSETS
 
 /*
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b00d8e3c30ba..2d2fc74bc00c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -254,6 +254,13 @@ void cpuset_unlock(void)
 	mutex_unlock(&cpuset_mutex);
 }
 
+#ifdef CONFIG_LOCKDEP
+bool lockdep_is_cpuset_held(void)
+{
+	return lockdep_is_held(&cpuset_mutex);
+}
+#endif
+
 static DEFINE_SPINLOCK(callback_lock);
 
 void cpuset_callback_lock_irq(void)
-- 
2.51.0


