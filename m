Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5574C5803
	for <lists+cgroups@lfdr.de>; Sat, 26 Feb 2022 21:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiBZUm2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 26 Feb 2022 15:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiBZUm1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 26 Feb 2022 15:42:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32EB24F1B6
        for <cgroups@vger.kernel.org>; Sat, 26 Feb 2022 12:41:52 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645908109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SqdsGvA5XeY6PhfXzb3Fr1EyB14Ft2+PMkzy4AmRIn4=;
        b=2NaqpCidvSVf+88nSX8VSQNVk3Si8mImBA5EHfCoM4lIs7LfsmD+KBlq/MGKt86xC4oXoq
        8EWgEu493FqRB5MDmeVAUT1G32mSvM1WQF/HJKg2e4Ct2JSaMqbSHBITiakO3lAyY+HbJa
        SRVU9w0Y5wF/xB3TuUeNfFA81jTuhsdqgHcTl33NQgPeQuQOYa+XmAvCwuuYUrjFzcGKun
        h/4lEFR3BpJtUCUQaBaS0O5A2qiyAIMtEwbx7puHV8ep0Xn8zWhTnJgoW9PQjZKhoTYzXJ
        A7u6tZKzJt2/yOgkUv+3r60NSVktizaq147UgJ3o+w/7+uJx/ocHFA0KPQsSNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645908109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SqdsGvA5XeY6PhfXzb3Fr1EyB14Ft2+PMkzy4AmRIn4=;
        b=jvZQ8XhTfJ0uhYjhex/5SW2SjipGrWDJ2wYe5UCJWXgE0OV7mSPE/5THKDACixj1nzJn6H
        KrUHr9k6SqNnDmDQ==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 0/6]  mm/memcg: Address PREEMPT_RT problems instead of disabling it.
Date:   Sat, 26 Feb 2022 21:41:38 +0100
Message-Id: <20220226204144.1008339-1-bigeasy@linutronix.de>
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

Changes since v4:
- Added additional counter index to __mod_memcg_lruvec_state() which are
  updated with enabled interrupts but with disabled interrupts. Also
  disable these checks on PREEMPT_RT. Reported by Shakeel Butt.

- Add additional comment regarding `obj' in drain_obj_stock().

- Disable migration in drain_all_stock() and drain the local stock
  instead of scheduling a worker.

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

