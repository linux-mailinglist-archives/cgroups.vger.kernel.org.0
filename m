Return-Path: <cgroups+bounces-8612-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A497EAE1E88
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E6C7A523C
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798AB2EACFF;
	Fri, 20 Jun 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apKUxTLn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E42BFC79;
	Fri, 20 Jun 2025 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433030; cv=none; b=UgQJYP24ix0Q+0YRStKnk7PhcxP6nCozUsDItwy+zeo2+VBf4yx9InmgNNFZ/JTcGKa1YT52vAv9lUA91De+4e0CjnDCzw2wKBg5IhRqo/KaV5Jkx0aw9cPHSraQEAGbDIBwU3T48tGMzBfoSQU8g5eRYY+8JtDp/9+PV7YJ5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433030; c=relaxed/simple;
	bh=6vWppYdTk5e9qrlSezsH+M7RzeU8JEFva4V6UhNLxfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p32OhRSPSikHwTJhUPri2ZyIAd1W3GukEia5GCW9g53rfcxflyRuK2ttwntPK5bpMOLZCRPBzsTQ/cvQ0fqe96KJT9xNHG0Z1F47wQgsvLGdV8DIrhHkO2Lix/lYkQPGHRUC3AdYraCnGKTlkhYc3rkgTSD4xLLdHYqHSAYzbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apKUxTLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B58BC4CEE3;
	Fri, 20 Jun 2025 15:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750433029;
	bh=6vWppYdTk5e9qrlSezsH+M7RzeU8JEFva4V6UhNLxfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apKUxTLn3MyBYPHBJGTXh1Ss8p95bBRxsLRZ807pnflMsPa/4oRyNH8Qnh1S35p+F
	 RPnRAFMswu0L+hX0sccHS+OHyFN0pLZUI/Su+KX7jSXO277Yy5d0kiq8YEa3oLhtpu
	 v4VrnaKe0mxUgLYvYv9nMvM4Yop0b4zCIGrJg27grAxrG7C5IC1SL+mSlaQtTGMyAG
	 h0edjuOtpmjIdp07v5w5+iNAJqfZO5Wk8XmgGr4nTH56z9viUjQ2OIRzJw706Zyprw
	 yP3Ou1awhk/GgBcDGkgU/CSoyb4s9mw6f/mnIbfcQo9Xk8jjKiKJWjoB2fFfh7p9VT
	 RkJ6cHOueAdrg==
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
Subject: [PATCH 13/27] cpuset: Provide lockdep check for cpuset lock held
Date: Fri, 20 Jun 2025 17:22:54 +0200
Message-ID: <20250620152308.27492-14-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250620152308.27492-1-frederic@kernel.org>
References: <20250620152308.27492-1-frederic@kernel.org>
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
index aae8a739d48d..8221b6a7da46 100644
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
2.48.1


