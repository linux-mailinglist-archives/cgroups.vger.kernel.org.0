Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB244AE347
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 23:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386575AbiBHWVk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 17:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386194AbiBHTnh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 14:43:37 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6273C0613CB;
        Tue,  8 Feb 2022 11:43:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w20so221012plq.12;
        Tue, 08 Feb 2022 11:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3ImYAmlfRKBZkC/pLF9BVzBCr+7P+OE/oDyEYAOAPQ=;
        b=RSk9d3qmUd4qYszbyz1ANvzT1zanWxXRFOsL6+7w9bKoGrI/+i5ySpouQXJyrqUIfL
         oC7RstqRX7MpfHBVJ3qKOPvM2BtsmoKGJi1utEYXQE9ntJNNhnQiBWtnnACiY3fhwHMP
         lmeaj3JpoNOOzymhWEDUxQTplKUmuNsoEf8dFHpUUT0ewQwsItB2l3YzSjmBq+poSuKX
         0l1QzuC7w1xxfSNSGUzUiEkj9zHkCopGQNPAwj1cyjRwiyR2/0BK+UNChrCuKVwKY+nj
         oY7b69LyjPwbT7tZYcMfDUtEFR3mEVHEuF9uFfS64DN0Glg9zHz/G1ZVKXS0tlAhFdub
         5/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=k3ImYAmlfRKBZkC/pLF9BVzBCr+7P+OE/oDyEYAOAPQ=;
        b=J08zdvTMUfLBgKv4zy7C7t/+QmKRf/GPesOFPgDAM8mZIhlZAKDVhbDM93NLOnhT3X
         22fhbqQOwPww8mxC4LizzLE7ctjBc+cPi1B7q69huoKQBgWBnXYh+dAgqM4nDS2voxWh
         qL62WF8lVHimrDWZbL9+pYAltQQjGoub2QgCWWokOiVHuQN6yOMVD6KhuwYCsSXc3Jts
         rqUfYpoPrTtIjoN20z79MR4b7VaB3w4SuAn0Oc2Q6II5MFc+7KuKFCEi5EOJl7nsWI8O
         1Z9AdN1fBA5LDk3XuNqsSvrib97yNRXhUXL0ESpZeFIene7vEUanuVoJKOjiJNP5ebwQ
         9jeg==
X-Gm-Message-State: AOAM532HAaToKMOn+GXmBZ4voBh9kThDeYvTWAMiAz8tlpGUMqg5veGP
        1F7uc7D0tD2fS2W3bZLxDKI=
X-Google-Smtp-Source: ABdhPJxdROXUt/+NpwRLoiVRuI5Fkp69z4w5V7oVsLdzS6wbeh4k2qfYnhWIH93Nq9q1XFfnjyp7cQ==
X-Received: by 2002:a17:902:7489:: with SMTP id h9mr2349321pll.8.1644349415950;
        Tue, 08 Feb 2022 11:43:35 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:35 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, cgroups@vger.kernel.org,
        linux-btrfs@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [RFC RESEND 00/12] locking: Separate lock tracepoints from lockdep/lock_stat (v1.1)
Date:   Tue,  8 Feb 2022 11:43:12 -0800
Message-Id: <20220208194324.85333-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

(Resending with Paul's correct email address, sorry!)

There have been some requests for low-overhead kernel lock contention
monitoring.  The kernel has CONFIG_LOCK_STAT to provide such an infra
either via /proc/lock_stat or tracepoints directly.

However it's not light-weight and hard to be used in production.  So
I'm trying to separate out the tracepoints and using them as a base to
build a new monitoring system.

* Changes in v1.1
 - add some Acked-by's
 - add comments on cgroup rstat cpu lock
 
As the lockdep and lock_stat provide good hooks in the lock functions,
it'd be natural to reuse them.  Actually I tried to use lockdep as is
but disables the functionality at runtime (initialize debug_locks = 0,
lock_stat = 0).  But it still has unacceptable overhead and the
lockdep data structures also increase memory footprint unnecessarily.

So I'm proposing a separate tracepoint-only configuration and keeping
lockdep_map only with minimal information needed for tracepoints (for
now, it's just name).  And then the existing lockdep hooks can be used
for the tracepoints.

The patch 01-06 are preparation for the work.  In a few places in the
kernel, they calls lockdep annotation explicitly to deal with
limitations in the lockdep implementation.  In my understanding, they
are not needed to analyze lock contention.

To make matters worse, they rely on the compiler optimization (or
macro magic) so that it can get rid of the annotations and their
arguments when lockdep is not configured.

But it's not true any more when lock tracepoints are added and it'd
cause build errors.  So I added #ifdef guards for LOCKDEP in the code
to prevent such errors.

In the patch 07 I mechanically changed most of code that depend on
CONFIG_LOCKDEP or CONFIG_DEBUG_LOCK_ALLOC to CONFIG_LOCK_INFO.  It
paves the way for the codes to be shared for lockdep and tracepoints.
Mostly, it makes sure that locks are initialized with a proper name,
like in the patch 08 and 09.

I didn't change some places intentionally - for example, timer and
workqueue depend on LOCKDEP explicitly since they use some lockdep
annotations to work around the "held lock freed" warnings.  The ocfs2
directly accesses lockdep_map.key so I didn't touch the code for now.
And RCU was because it generates too much overhead thanks to the
rcu_read_lock().  Maybe I need to revisit some of them later.

I added CONFIG_LOCK_TRACEPOINTS in the patch 10 to make it optional.
I found that it adds 2~3% of overhead when I ran `perf bench sched
messaging` even when the tracepoints are disabled.  The benchmark
creates a lot of processes and make them communicate by socket pairs
(or pipes).  I measured that around 15% of lock acquisition creates
contentions and it's mostly for spin locks (alc->lock and u->lock).

I ran perf record + report with the workload and it showed 50% of the
cpu cycles are in the spin lock slow path.  So it's highly affected by
the spin lock slow path.  Actually LOCK_CONTENDED() macro transforms
the spin lock code (and others) to use trylock first and then fall
back to real lock function if failed.  Thus it'd add more (atomic)
operations and cache line bouncing for the contended cases:

  #define LOCK_CONTENDED(_lock, try, lock)		\
  do {							\
      if (!try(_lock)) {				\
          lock_contended(&(_lock)->dep_map, _RET_IP_);	\
          lock(_lock);					\
      }							\
      lock_acquired(&(_lock)->dep_map, _RET_IP_);	\
  } while (0)

If I modify the macro not to use trylock and to call the real lock
function directly (so the lock_contended tracepoint would be called
always, if enabled), the overhead goes down to 0.x% when the
tracepoints are disabled.

I don't have a good solution as long as we use LOCK_CONTENDED() macro
to separate the contended locking path.  Maybe we can make it call
some (generic) slow path lock function directly after failing trylock.
Or move the lockdep annotations into the each lock function bodies and
get rid of the LOCK_CONTENDED() macro entirely.  Ideas?

Actually the patch 11 handles the same issue on the mutex code.  The
fast version of mutex trylock was attempted only if LOCKDEP is not
enabled and it affects the mutex lock performance in the uncontended
cases too.  So I partially reverted the change in the patch 07 to use
the fast functions with lock tracepoints too.  Maybe we can use it
with LOCKDEP as well?

The last patch 12 might be controversial and I'd like to move the
lock_acquired annotation into the if(!try) block in the LOCK_CONTEDED
macro so that it can only be called when there's a contention.

Eventually I'm mostly interested in the contended locks only and I
want to reduce the overhead in the fast path.  By moving that, it'd be
easy to track contended locks with timing by using two tracepoints.

It'd change lock hold time calculation in lock_stat for the fast path,
but I assume time difference between lock_acquire and lock_acquired
would be small when the lock is not contended.  So I think we can use
the timestamp in lock_acquire.  If it's not acceptable, we might
consider adding a new tracepoint to track the timing of contended
locks.

This series base on the current tip/locking/core and you get it from
'locking/tracepoint-v1' branch in my tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: rcu@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org


Namhyung Kim (12):
  locking: Pass correct outer wait type info
  cgroup: rstat: Make cgroup_rstat_cpu_lock name readable
  timer: Protect lockdep functions with #ifdef
  workqueue: Protect lockdep functions with #ifdef
  drm/i915: Protect lockdep functions with #ifdef
  btrfs: change lockdep class size check using ks->names
  locking: Introduce CONFIG_LOCK_INFO
  locking/mutex: Init name properly w/ CONFIG_LOCK_INFO
  locking: Add more static lockdep init macros
  locking: Add CONFIG_LOCK_TRACEPOINTS option
  locking/mutex: Revive fast functions for LOCK_TRACEPOINTS
  locking: Move lock_acquired() from the fast path

 drivers/gpu/drm/drm_connector.c               |   7 +-
 drivers/gpu/drm/i915/i915_sw_fence.h          |   2 +-
 drivers/gpu/drm/i915/intel_wakeref.c          |   3 +
 drivers/gpu/drm/i915/selftests/lib_sw_fence.h |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +-
 drivers/tty/tty_ldsem.c                       |   2 +-
 fs/btrfs/disk-io.c                            |   4 +-
 fs/btrfs/disk-io.h                            |   2 +-
 fs/cifs/connect.c                             |   2 +-
 fs/kernfs/file.c                              |   2 +-
 include/linux/completion.h                    |   2 +-
 include/linux/jbd2.h                          |   2 +-
 include/linux/kernfs.h                        |   2 +-
 include/linux/kthread.h                       |   2 +-
 include/linux/local_lock_internal.h           |  18 +-
 include/linux/lockdep.h                       | 170 ++++++++++++++++--
 include/linux/lockdep_types.h                 |   8 +-
 include/linux/mmu_notifier.h                  |   2 +-
 include/linux/mutex.h                         |  12 +-
 include/linux/percpu-rwsem.h                  |   4 +-
 include/linux/regmap.h                        |   4 +-
 include/linux/rtmutex.h                       |  14 +-
 include/linux/rwlock_api_smp.h                |   4 +-
 include/linux/rwlock_rt.h                     |   4 +-
 include/linux/rwlock_types.h                  |  11 +-
 include/linux/rwsem.h                         |  14 +-
 include/linux/seqlock.h                       |   4 +-
 include/linux/spinlock_api_smp.h              |   4 +-
 include/linux/spinlock_rt.h                   |   4 +-
 include/linux/spinlock_types.h                |   4 +-
 include/linux/spinlock_types_raw.h            |  28 ++-
 include/linux/swait.h                         |   2 +-
 include/linux/tty_ldisc.h                     |   2 +-
 include/linux/wait.h                          |   2 +-
 include/linux/ww_mutex.h                      |   6 +-
 include/media/v4l2-ctrls.h                    |   2 +-
 include/net/sock.h                            |   2 +-
 include/trace/events/lock.h                   |   4 +-
 kernel/cgroup/rstat.c                         |   7 +-
 kernel/locking/Makefile                       |   1 +
 kernel/locking/lockdep.c                      |  40 ++++-
 kernel/locking/mutex-debug.c                  |   2 +-
 kernel/locking/mutex.c                        |  22 ++-
 kernel/locking/mutex.h                        |   7 +
 kernel/locking/percpu-rwsem.c                 |   2 +-
 kernel/locking/rtmutex_api.c                  |  10 +-
 kernel/locking/rwsem.c                        |   4 +-
 kernel/locking/spinlock.c                     |   2 +-
 kernel/locking/spinlock_debug.c               |   4 +-
 kernel/locking/spinlock_rt.c                  |   8 +-
 kernel/locking/ww_rt_mutex.c                  |   2 +-
 kernel/printk/printk.c                        |  14 +-
 kernel/rcu/update.c                           |  27 +--
 kernel/time/timer.c                           |   8 +-
 kernel/workqueue.c                            |  13 ++
 lib/Kconfig.debug                             |  14 ++
 mm/memcontrol.c                               |   7 +-
 mm/mmu_notifier.c                             |   2 +-
 net/core/dev.c                                |   2 +-
 net/sunrpc/svcsock.c                          |   2 +-
 net/sunrpc/xprtsock.c                         |   2 +-
 62 files changed, 391 insertions(+), 180 deletions(-)


base-commit: 1dc01abad6544cb9d884071b626b706e37aa9601
-- 
2.35.0.263.gb82422642f-goog
