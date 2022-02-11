Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9484B30C1
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 23:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbiBKWgB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 17:36:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347236AbiBKWfy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 17:35:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD38DD5
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 14:35:46 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644618945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2jFa60m1adjhL+4fflkSQgNee+J2OI1P+D0ydxQNeSM=;
        b=PY+tx1P/mAMJnjwiGOq8e0x1SapvGN6YbEqZaTEbMW2zWB0RjTDrvIb6ROp0H8V02fkC18
        VMSHJ69jRzMfXnFB6K80K5V1OabCPyXzqitZdwCtgC06n/VTeVk/i+I1j1JXdsULrnXeQe
        JzeDCNY2nbc8So97FKQmAn6Q+JtOnEZeTuZU1XkPvPUPbBBN+dYopC+zcptCSOc56qYfhT
        U8+mQd2WJEgQnzJRNdIsPONysf5VTR9KPCIF/s4H8X8GdAUlCY+cFL7emEO3NNEElbhYE7
        0ZATNH/bUreS/33JZmnH83dZrO8RuDMKDmNQF4lNUgWQereiUO1p21BRe1aYrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644618945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2jFa60m1adjhL+4fflkSQgNee+J2OI1P+D0ydxQNeSM=;
        b=MOCraIlS0/LMJ+LLb0Si15mJMZtVSnjhrMJYsm25gGy9c0+ObvcxsdrF7SxqppFmMTgVLu
        PjGlxx5xmHuA49Aw==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/4] mm/memcg: Address PREEMPT_RT problems instead of disabling it.
Date:   Fri, 11 Feb 2022 23:35:33 +0100
Message-Id: <20220211223537.2175879-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

this series aims to address the memcg related problem on PREEMPT_RT.

I tested them on CONFIG_PREEMPT and CONFIG_PREEMPT_RT with the
tools/testing/selftests/cgroup/* tests and I haven't observed any
regressions (other than the lockdep report that is already there).

Changes since v1:
- Made a full patch from Michal Hocko's diff to disable the from-IRQ vs
  from-task optimisation

- Disabling threshold event handlers is using now IS_ENABLED(PREEMPT_RT)
  instead of #ifdef. The outcome is the same but there is no need to
  shuffle the code around.

v1: https://lore.kernel.org/all/20220125164337.2071854-1-bigeasy@linutronix=
.de/

Changes since the RFC:
- cgroup.event_control / memory.soft_limit_in_bytes is disabled on
  PREEMPT_RT. It is a deprecated v1 feature. Fixing the signal path is
  not worth it.

- The updates to per-CPU counters are usually synchronised by disabling
  interrupts. There are a few spots where assumption about disabled
  interrupts are not true on PREEMPT_RT and therefore preemption is
  disabled. This is okay since the counter are never written from
  in_irq() context.

RFC: https://lore.kernel.org/all/20211222114111.2206248-1-bigeasy@linutroni=
x.de/

Sebastian


