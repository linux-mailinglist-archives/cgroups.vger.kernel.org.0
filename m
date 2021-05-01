Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7B637078B
	for <lists+cgroups@lfdr.de>; Sat,  1 May 2021 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhEAOWw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 May 2021 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEAOWv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 May 2021 10:22:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7FBC06174A
        for <cgroups@vger.kernel.org>; Sat,  1 May 2021 07:22:00 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w15so190772ljo.10
        for <cgroups@vger.kernel.org>; Sat, 01 May 2021 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vbeA+iBCLiNiP2wrTp6xojcacyeQy/jqI+Mj96mgGk=;
        b=y/K0hf4sv3h8fLlnlRiBx0ByouhIDRAk3BT7hYrPSHWEbme/eIDvtqAN5+bnJLY2Tc
         elUqcci7p79wKEAb8ftWqOLSmEPNULmlkT/S5OM5Tkg8m3CAB6pleUPnwZ7qE/bAH4BT
         jPftK9pmabJiPvwjrxe/U5bJ7NB3+AX9kNivNmAPxINTp7BeXq4U20rz004YXs6uDJEP
         tXAdoJq5+psCY2x4rT9HcKBuxXe7MLJeYeCQI3CpB/ATmf1ydRa620iJ2i2bD7LvWwn8
         xDQ1h6xXDDvswJnbU5K+rDqLULHNpMUfwkjwLnao4jlxEMr1Q+MLP45HUCeoKrJG4LEV
         i3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vbeA+iBCLiNiP2wrTp6xojcacyeQy/jqI+Mj96mgGk=;
        b=BHK4A4iJ0pE/ATjbArFxFW5IR+1YMiEbVmq09pnKlLFVIxohBd5sqUeBdWrY4euhqT
         vBMPfIasu6b204C6h9Nz8mJpeAJVnKp1aqPxmO0AogztoDvWV+Y7ydzt/a2kPIq9hgEx
         T24zcge4uh8RYybAyHo+PD/PP6TDDJ2VINbQ4lXg/NculqMel1L0S+NyvwSTdMEchjUF
         VCgoC+T8O4bjULXk77v3RXxN1ClYHKyn/DvCA3gsh9UvIe+CItMQA9XZ9SJJuYGI4QKw
         g2MTANizE7A48rRtWuRfdtKF9FBjB6nq41FybjchzM4mWM3IFRJAI34AQu3akU3NvcPz
         brMA==
X-Gm-Message-State: AOAM530XtBOJrqnxOwv4WsaANgJ9iVsn1X3/7cDa4K7zMnu/3M0yE2Lb
        YMSCjFOLy14ruuzL36bLhf+fKw==
X-Google-Smtp-Source: ABdhPJxzRCzyczLK931MzAajPInkKKyOObWXeLAnxn5pMli8gzsMsdcO4eLFnSfzPjzIIW1UeYPSvw==
X-Received: by 2002:a05:651c:211e:: with SMTP id a30mr7459238ljq.18.1619878918455;
        Sat, 01 May 2021 07:21:58 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2280.bb.online.no. [80.212.253.245])
        by smtp.gmail.com with ESMTPSA id h22sm581400lfu.91.2021.05.01.07.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 07:21:57 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH v2 0/1] sched/fair: Fix unfairness caused by missing load decay
Date:   Sat,  1 May 2021 16:19:49 +0200
Message-Id: <20210501141950.23622-1-odin@uged.al>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

TL;DR: Read the patch msg first; hopefully it makes sense. Feel free
to cc more relevant people, and (as I am pretty new to this), feedback
is highly appreciated!

I thought it was smart to split the discussion of the patch and the issuse, so
here is some (wall of text, sorry) discussion around it:

This patch fixes an extremely strange edge case, discovered more or less by
accident (while testing container runtimes for my thesis),
where the fairness of the cfs scheduler get skewed quite
extensively. This often leads to two cgroups who are supposed to get
share cpu time 50/50, instead getting something like 90/10 or
even 99/1 (!!) in some rare cases (see below for example). I find this
edge case quite interesting, especially since I am able to so easily
reproduce it on all machines and all (4.8+) kernels.

The issue can be easily reproduced on all kernels 4.8+, and afaik. most
"container runtimes" are affected. I do believe that I have wondered about
this issue earlier, but not actually understood what was causing it. There
is really (afaik.) no way to find the issue from userspace without using
a tracing tool like bpftrace. I am _sure_ this affects real production
environments _everywhere_, at least those running the normal container/using
cgroup tools together with cpu pinning; but verifying that the
fairness is skewed is quite hard, or more or less impossible in such cases,
especially when running multiple workloads simultaneously. I did inspect some
of my production servers, and found a set of this on multiple cgroups.

It _is_ possible to read '/proc/sched_debug', but since that list only prints
the cfs_rq's from "leaf_cfs_rq_list", the cfs_rq's we are _really_ looking for,
are missing; making it look like the problem isn't becuase of cfs. One can however
use the information in infer that there is an issue (look at the bottom).

Also, another solution may be to don't add the load before the task is actually
enqueued, avoiding this issue all together. But is that better (I assume that will
be more in the "hot path", and require quite a bit more code?

There may definetly be a better solution to this that I still haven't found, and that
other more experienced kernel devs see right away. :)


Also feel free to suggest additions/wording of the patch
message and title, and/or the comment in the code to make it more clear.

This issue was introduced in 4.8, so all stable (4.9+) releases should probably
get this (the final solution at least), or?

Below is various ways/scripts to reproduce - sorry this is so long (and
sorry for bash in general), but thought people might be interested in them:

note: due to the nature of the issue, the "lost" load is different each time, so
the values change each time, and sometimes/often end up at ~50/50; but my testing
shows that it keep happening almost every time:


Example on cgruoup v1. Often results in 60/40 load:
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       18026 63.0  0.0   3676   100 pts/7    R+   13:09   0:06 stress --cpu 1
root       18036 36.6  0.0   3676   100 pts/7    R+   13:09   0:04 stress --cpu 1
--- bash start
CGROUP_CPU=/sys/fs/cgroup/cpu/slice
CGROUP_CPUSET=/sys/fs/cgroup/cpuset/slice
CPU=0

function run_sandbox {
  local CG_CPUSET="$1"
  local CG_CPU="$2"
  local CMD="$3"

  local PIPE="$(mktemp -u)"
  mkfifo "$PIPE"
  sh -c "read < $PIPE ; exec $CMD" &
  local TASK="$!"
  sleep .1
  mkdir -p "$CG_CPUSET"
  mkdir -p "$CG_CPU"
  tee "$CG_CPU"/cgroup.procs <<< "$TASK"

  tee "$CG_CPUSET"/cgroup.procs <<< "$TASK"

  tee "$PIPE" <<< sandox_done
  rm "$PIPE"
}

mkdir -p "$CGROUP_CPU"
mkdir -p "$CGROUP_CPUSET"
tee "$CGROUP_CPUSET"/cpuset.cpus <<< "0" 
tee "$CGROUP_CPUSET"/cpuset.mems <<< "0" 

run_sandbox "$CGROUP_CPUSET" "$CGROUP_CPU/cg-1" "stress --cpu 1"
run_sandbox "$CGROUP_CPUSET" "$CGROUP_CPU/cg-2" "stress --cpu 1"

read # click enter to cleanup
killall stress
sleep .2
rmdir /sys/fs/cgroup/cpuset/slice/
rmdir /sys/fs/cgroup/cpu/slice/{cg-1,cg-2,}
--- bash end

Example on cgroup v2 with sub cgroup (same as described in commit message),
where both should get 50/50, but instead getting 99% and 1% (!!).

USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       18568  1.1  0.0   3684   100 pts/12   R+   13:36   0:00 stress --cpu 1
root       18580 99.3  0.0   3684   100 pts/12   R+   13:36   0:09 stress --cpu 1
--- bash start (in case of systemd - make sure some slice/scope is delegated(?)/use cpusets)
CGROUP_CPU=/sys/fs/cgroup/cpu/slice
CGROUP_CPUSET=/sys/fs/cgroup/cpuset/slice
CPU=0

function run_sandbox {
  local CG_CPUSET="$1"
  local CG_CPU="$2"
  local CMD="$3"

  local PIPE="$(mktemp -u)"
  mkfifo "$PIPE"
  sh -c "read < $PIPE ; exec $CMD" &
  local TASK="$!"
  sleep .01
  mkdir -p "$CG_CPUSET"
  mkdir -p "$CG_CPU"
  tee "$CG_CPU"/cgroup.procs <<< "$TASK"

  tee "$CG_CPUSET"/cgroup.procs <<< "$TASK"

  tee "$PIPE" <<< sandox_done
  rm "$PIPE"
}

mkdir -p "$CGROUP_CPU"
mkdir -p "$CGROUP_CPUSET"
tee "$CGROUP_CPUSET"/cpuset.cpus <<< "0" 
tee "$CGROUP_CPUSET"/cpuset.mems <<< "0" 

run_sandbox "$CGROUP_CPUSET" "$CGROUP_CPU/cg-1" "stress --cpu 1"
run_sandbox "$CGROUP_CPUSET" "$CGROUP_CPU/cg-2" "stress --cpu 1"

read # click enter to cleanup
killall stress
sleep .2
rmdir /sys/fs/cgroup/cpuset/slice/
rmdir /sys/fs/cgroup/cpu/slice/{cg-1,cg-2,}
--- bash end



For those who only want to run docker stuff:
(on cgroup v1, you must use systemd driver)
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root        9291 60.1  0.0   7320    96 pts/0    R+   13:18   0:07 /usr/bin/stress --verbose --cpu 1
root        9388 45.5  0.0   7320    96 pts/0    R+   13:18   0:04 /usr/bin/stress --verbose --cpu 1
--- bash start
docker run --cpuset-cpus=0 --rm -it an-image-with-stress
docker run --cpuset-cpus=0 --rm -it an-image-with-stress
--- bash end


Example for cgroup v1 where CPU is pinned to 1, and then changed to 0. Often results
in 99/1 load balance.
--- bash start
CGROUP_CPU=/sys/fs/cgroup/cpu/slice
CGROUP_CPUSET=/sys/fs/cgroup/cpuset/slice
CGROUP_CPUSET_ME=/sys/fs/cgroup/cpuset/me
CPU=0
CPU_ME=1

function run_sandbox {
  local CG_CPUSET="$1"
  local CG_CPU="$2"
  local INNER_SHARES="$3"
  local CMD="$4"

  local PIPE="$(mktemp -u)"
  mkfifo "$PIPE"
  sh -c "read < $PIPE ; exec $CMD" &
  local TASK="$!"
  sleep .1
  mkdir -p "$CG_CPUSET"
  mkdir -p "$CG_CPU"/sub
  tee "$CG_CPU"/sub/cgroup.procs <<< "$TASK"
  tee "$CG_CPU"/sub/cpu.shares <<< "$INNER_SHARES"

  tee "$CG_CPUSET"/cgroup.procs <<< "$TASK"

  tee "$PIPE" <<< sandox_done
  rm "$PIPE"
}

mkdir -p "$CGROUP_CPU"
mkdir -p "$CGROUP_CPUSET"
mkdir -p "$CGROUP_CPUSET_ME"

tee "$CGROUP_CPUSET"/cpuset.cpus <<< "$CPU"
tee "$CGROUP_CPUSET"/cpuset.mems <<< "$CPU"

tee "$CGROUP_CPUSET_ME"/cpuset.cpus <<< "$CPU_ME"
echo $$ | tee "$CGROUP_CPUSET_ME"/cgroup.procs

run_sandbox "$CGROUP_CPUSET" "$CGROUP_CPU/cg-1" 50000 "stress --cpu 1"
run_sandbox "$CGROUP_CPUSET" "$CGROUP_CPU/cg-2" 2     "stress --cpu 1"

read # click enter to cleanup and stop all stress procs
killall stress
sleep .2
rmdir /sys/fs/cgroup/cpuset/slice/
rmdir /sys/fs/cgroup/cpu/slice/{cg-{1,2}{/sub,},}
--- bash end

To verify what is happening, one can take a close look at sched_debug:

$ cat /proc/sched_debug | grep ":/slice" -A 28 | egrep "(tg_load_avg|slice)"
cfs_rq[0]:/slice/cg-2/sub
  .tg_load_avg_contrib           : 1026
  .tg_load_avg                   : 1757
cfs_rq[0]:/slice/cg-1/sub
  .tg_load_avg_contrib           : 1027
  .tg_load_avg                   : 1473
cfs_rq[0]:/slice/cg-1
  .tg_load_avg_contrib           : 5
  .tg_load_avg                   : 398
cfs_rq[0]:/slice/cg-2
  .tg_load_avg_contrib           : 60603
  .tg_load_avg                   : 61264
cfs_rq[0]:/slice
  .tg_load_avg_contrib           : 1024
  .tg_load_avg                   : 1864


We can clearly see that for all cfs_rqs, .tg_load_avg_contrib!=.tg_load_avg.
Since removed.on_list==0 on the other cfs_rq's, the load on those will never
be "cleaned" up unless a new task starts on that cpu, but due to the cpuset, that would not
be the case. slice/cg-1 and slice/cg-2 also have load attached to cpu 3 that isn't removed (but
the patch will properly decay the load on them as well). 

With this patch, all of these examples just end up sharing cpu time in a fair 50/50 way, as expected.

Thanks to Vincent and Dietmar for feedback!

Changes since v1:
- Moved code to avoid looping se hierarchy twice.
- Replaced the bpftrace code with a simpler example using sched_debug in cover letter
- Updated cover letter

Odin Ugedal (1):
  sched/fair: Fix unfairness caused by missing load decay

 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.31.1

