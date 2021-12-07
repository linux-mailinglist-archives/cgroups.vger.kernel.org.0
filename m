Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E72E46BFEE
	for <lists+cgroups@lfdr.de>; Tue,  7 Dec 2021 16:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhLGPzm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Dec 2021 10:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbhLGPzm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Dec 2021 10:55:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A50C061748
        for <cgroups@vger.kernel.org>; Tue,  7 Dec 2021 07:52:11 -0800 (PST)
Date:   Tue, 7 Dec 2021 16:52:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638892329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VS6roNBiwUEM5X9fxDy5HZGLySBmQhwrowKmxwnMeKo=;
        b=BcczSFN8CKvWRlXBGO8eJz8aSgoUZFPDl3yXZwMqcRiniKvyEO5H1I4FD8smWeB72tPE7W
        4FhHfvENUhH9Oo6smxiNulqEiCddctZcH8HzErDwFV5cQVwltMyZTjvCpZA16+BMABd+nu
        URprFReGV/dMjZsMN9iyCoeY+dLhb/Sv22rM9pdB88rvFY2yO2deqrjbrcgru9sePRnXs+
        Zu5n9d5/Jpy2MuFGa1z+CABNUK9eZbcyQVF+WyhjJaF2c8dQU9/Z8fRwNc7F6XZRQAzXpr
        LgdIAHZGeTPJuYa+DoJdCJ6Vn8/T5VSKZagkg/tQUH0Rcb5lLWAMFha7knUaPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638892329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VS6roNBiwUEM5X9fxDy5HZGLySBmQhwrowKmxwnMeKo=;
        b=w1JyOzTzNREXfaHDN1SVgPUu3ulwLcDKPcxYzaU9oZ+cen1LSNAG8b7kwCvPe4RsoqnOQS
        pEpFizCPgDi0ANAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/memcontrol: Disable on PREEMPT_RT
Message-ID: <20211207155208.eyre5svucpg7krxe@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

MEMCG has a few constructs which are not compatible with PREEMPT_RT's
requirements. This includes:
- relying on disabled interrupts from spin_lock_irqsave() locking for
  something not related to lock itself (like the per-CPU counter).

- explicitly disabling interrupts and acquiring a spinlock_t based lock
  like in memcg_check_events() -> eventfd_signal().

- explicitly disabling interrupts and freeing memory like in
  drain_obj_stock() -> obj_cgroup_put() -> obj_cgroup_release() ->
  percpu_ref_exit().

Commit 559271146efc ("mm/memcg: optimize user context object stock
access") continued to optimize for the CPU local access which
complicates the PREEMPT_RT locking requirements further.

Disable MEMCG on PREEMPT_RT until the whole situation can be evaluated
again.

[ bigeasy: commit description. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 init/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -943,6 +943,7 @@ config PAGE_COUNTER
 
 config MEMCG
 	bool "Memory controller"
+	depends on !PREEMPT_RT
 	select PAGE_COUNTER
 	select EVENTFD
 	help
