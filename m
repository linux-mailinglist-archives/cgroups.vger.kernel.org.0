Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE2D4BEADC
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 20:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiBUS1l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 13:27:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiBUS0d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 13:26:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98165215
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 10:26:09 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645467966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jxyd7UXPX5m/2j0TbW7YsD0CbLlXnk2SQHCfRxdbRq8=;
        b=rDqhHBZwWPmrML+3zs+6Mry2+GNEjjA2OB1vXBk6cIwkdYf79tuoYcBtWuGqMUx7pbqKav
        A/11ZQzjIQf7TZ0fZ5Qt12GUJbJ4CEf0+OKdcxPBoWpMPvM9G1p2FbpsPgZXRDx3VXeRRU
        Uq/iEdP/UHrQ4l7y4x65LjBJPhypR3DE+anLYbBxZcQ5HxHzmkG0w0CnJyPiXPQd9VZWk5
        qc7JN+OWjdgOUJr695dH+ENcatXmRCfewsDIjstt8Wt34dqGa81x8iLqUMRq9V8MC01d83
        u/Aj13T3DL3oGVIK9y6vegva0eyCsY+bK5ZhkIpTAXSC2wNc6xXWBiEdhpDDIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645467966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jxyd7UXPX5m/2j0TbW7YsD0CbLlXnk2SQHCfRxdbRq8=;
        b=z0wkmCZRL38ez2aF9RpPLjXxM5m6UAa833zd33BcQNifDcHjsIBWZcqD8bdsNL9+6VRwmU
        LpFHPO8HL8JCCEBw==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/6] mm/memcg: Address PREEMPT_RT problems instead of disabling it.
Date:   Mon, 21 Feb 2022 19:25:34 +0100
Message-Id: <20220221182540.380526-1-bigeasy@linutronix.de>
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

Changes since v3:
- Added __memcg_stats_lock() to __mod_memcg_lruvec_state(). This one
  does not check for disabled interrupts on !RT. The only user
  (__mod_memcg_lruvec_state()) checks if the context is task (neither
  soft nor hard irq) if the two idx are used which are used by rmap.c
  and otherwise it checks for disabled interrupts. Reported by Shakeel
  Butt.

- In drain_all_stock() migration is disabled and drain_local_stock() is
  invoked directly if the request CPU is the local CPU.=20

v3: https://lore.kernel.org/all/20220217094802.3644569-1-bigeasy@linutronix=
.de/

Changes since v2:
- rebased on top of v5.17-rc4-mmots-2022-02-15-20-39.

- Added memcg_stats_lock() in 3/5 so it a little more obvious and
  hopefully easiert to maintain.

- Opencoded obj_cgroup_uncharge_pages() in drain_obj_stock(). The
  __locked suffix was confusing.

v2: https://lore.kernel.org/all/20220211223537.2175879-1-bigeasy@linutronix=
.de/

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


