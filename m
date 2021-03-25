Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE9A348993
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCYG6Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhCYG6C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD647C06174A;
        Wed, 24 Mar 2021 23:58:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l123so1046358pfl.8;
        Wed, 24 Mar 2021 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0HAQH9S7BYME7xDrrfAGZHnKbsUU3U5GDi3mcyHwUY=;
        b=ghPXClxqYWb2AdpDYWC1Z/AJsylFh3gBBPzyIZFVKCVWHDNg+l3ozpCD3UwuX7CC+n
         TnhnNfVtwOvvBUGr6Deg+KI2oCjO+kBuL5oJFvPVNHDhncTGln/i6mtVGdWDsDc8jr2w
         nzyfacn4VJM+NOOt+ZHiWK5WENii+qwmkCvIBYtQkqM3yacAFMYC5tHMurqF147ys2bQ
         ANIegMB5gk1zE/3b0DdgYbISokZB0BhlKKhTUyFZbi2bFNBoIIHXLUTJ75Sux4NiL9zT
         bO5ixe7zO8VOiHwbMR/fkY7xs5ra2A4IPIuxJlXHq6khuak2NyAsNsV6GU6tH5RtIib4
         4S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0HAQH9S7BYME7xDrrfAGZHnKbsUU3U5GDi3mcyHwUY=;
        b=gQF2+QTWthBwGRuekqED9h7bd5Sf1Dne2apBqHa91VeNyb0VR5SOX/zF3DDbwwDbuO
         Z0z0GCscok+Ls/VN8QJlfjT/Yr6oPPfABhHKc1ZQUko/komJrQDxQy4UkdiWKP0fuNpF
         Ogx5I8OyQgWS7cc20NvqJIco4HkBy1SyWyR1AjS1h44IH+/HKISlPiOyxQCt0DNpMf0b
         gJM3rgxNHOiFs00LDjgxPX5/8c1pe3SPa6YqsGflUXd2yX4w5bcb+1TscPPAo95TR8m8
         JuuR1uuih4ZEraZX+Ho/u91p1dLYzh/WZbDMnXa67cos1wLH5uHNAm7Yqv7Zfs175pFn
         lGWA==
X-Gm-Message-State: AOAM533IEHRsmMdc0TS8Jbl07/KZlX56/HNbRvbOh0KqZd6sTy6G8fH6
        PuTMWIio22S+qhJVSLwRqvLF8gstT8QFWw==
X-Google-Smtp-Source: ABdhPJw96zxjSYdVKFYe0+o7SJQSpRJ56/BCjNvRk6WHEqB+Fv2lFBBpzzMJPmTZ3DOWo6HL6cYoFg==
X-Received: by 2002:a62:6451:0:b029:20e:f351:f1e with SMTP id y78-20020a6264510000b029020ef3510f1emr6709995pfb.54.1616655481015;
        Wed, 24 Mar 2021 23:58:01 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.57.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:00 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/14] bfq: introduce bfq.ioprio for cgroup
Date:   Thu, 25 Mar 2021 14:57:44 +0800
Message-Id: <cover.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Any suggestions or discussions are welcome, thank you every much.

BACKGROUND:
In the container scenario, in addition to throughput, we also pay
attention to Qos of each group. Based on hierarchical scheduling,
EMQ, IO Injection, bfq.weight and other mechanisms, we can achieve
better IO isolation, better throughput, better avoiding priority
inversion. However, we still have something to be optimized.

OPTIMIZATION:

We try to do something to make bfq work better in the container scene.

1. Introduce bfq.ioprio
Tasks in the production environment can be roughly divided into
three categories: emergency, ordinary and offline. Emergency tasks
need to be scheduled in real time, such as system agents. Offline
tasks do not need to guarantee QoS, but can improve system resource
utilization during system idle periods, such as background tasks.

At present, we can use weights to simulate IO preemption, but since
weights are more of a share concept, they cannot be simulated well.
Using ioprio class for group, we can solve the above problems more
easier. In this way, in hierarchical scheduling, we can ensure that
RT and IDLE group can be scheduled correctly. In addition, we also
introduce ioprio for group, so we realize a weight value through
ioprio class and ioprio. In scenarios where only simple weights are
needed, we can achieve IO preemption and weight isolation only
through bfq.ioprio. 

After the introduction of bfq.ioprio, in order to better adapt to
the actual container environment. When scheduling within a group,
we use task ioprio class. But outside of group, we use group ioprio
class. For example, when counting bfqd->busy_queues[], tasks from the
CLASS_IDLE group are always regarded as CLASS_IDLE, and the ioprio
class of the task is ignored.

2. Introduce better_faireness mode
Better Qos control needs to sacrifice throughput, and this is not
suitable for all scenarios. For this, we added a switch called
better_fairness. After better_fairness is enabled, we will make
the following restrictions:

Guarantee group Qos:
1. Cooperator queue can only come from the same group and the same class.
2. Waker queue can only come from the same group and the same class.
3. Inject queue can only come from the same group of the same class.

Guarantee RT tasks Qos:
1. Async_queue cannot inject RT queue.
2. Traverse the upper schedule domain to determine whether
   in_service_queue needs to be preempted.
3. If in_service_queue marked prio_expire, disable idle.

Better Buffer IO control:
1. Except for the CLASS_IDLE queue, other queues allow idle by default.

INTERFACE:

The bfq.ioprio interface now is available for cgroup v1 and cgroup
v2. Users can configure the ioprio for cgroup through this
interface, as shown below:

echo "1 2"> blkio.bfq.ioprio

The above two values respectively represent the values of ioprio
class and ioprio for cgroup.

EXPERIMENT:

The test process is as follows:
# prepare data disk
mount /dev/sdb /data1

# prepare IO scheduler
echo bfq > /sys/block/sdb/queue/scheduler
echo 0 > /sys/block/sdb/queue/iosched/low_latency
echo 1 > /sys/block/sdb/queue/iosched/better_fairness

It is worth noting here that nr_requests limits the number of
requests, and it does not perceive priority. If nr_requests is
too small, it may cause a serious priority inversion problem.
Therefore, we can increase the size of nr_requests based on
the actual situation.

# create cgroup v1 hierarchy
cd /sys/fs/cgroup/blkio
mkdir rt be0 be1 be2 idle

# prepare cgroup
echo "1 0" > rt/blkio.bfq.ioprio
echo "2 0" > be0/blkio.bfq.ioprio
echo "2 4" > be1/blkio.bfq.ioprio
echo "2 7" > be2/blkio.bfq.ioprio
echo "3 0" > idle/blkio.bfq.ioprio

# run fio test
fio fio.ini

# generate svg graph
fio_generate_plots res

The contents of fio.ini are as follows:
[global]
ioengine=libaio
group_reporting=1
log_avg_msec=3000
direct=1
time_based=1
iodepth=16
size=100M
rw=write
bs=1M
[rt]
name=rt
write_bw_log=rt
write_lat_log=rt
write_iops_log=rt
filename=/data1/rt.bin
cgroup=rt
runtime=30s
nice=-10
[be0]
name=be0
write_bw_log=be0
write_lat_log=be0
write_iops_log=be0
filename=/data1/be0.bin
cgroup=be0
runtime=60s
[be1]
name=be1
write_bw_log=be1
write_lat_log=be1
write_iops_log=be1
filename=/data1/be1.bin
cgroup=be1
runtime=60s
[be2]
name=be2
write_bw_log=be2
write_lat_log=be2
write_iops_log=be2
filename=/data1/be2.bin
cgroup=be2
runtime=60s
[idle]
name=idle
write_bw_log=idle
write_lat_log=idle
write_iops_log=idle
filename=/data1/idle.bin
cgroup=idle
runtime=90s

V3:
1. introdule prio_expire for bfqq.
2. introduce better_fairness mode.
3. optimize the processing of task ioprio and group ioprio. 
4. optimize some small points

V2:
1. Optmise bfq_select_next_class().
2. Introduce bfq_group [] to track the number of groups for each CLASS.
3. Optimse IO injection, EMQ and Idle mechanism for CLASS_RT.

Chunguang Xu (14):
  bfq: introduce bfq_entity_to_bfqg helper method
  bfq: convert the type of bfq_group.bfqd to bfq_data*
  bfq: introduce bfq.ioprio for cgroup
  bfq: introduce bfq_ioprio_class to get ioprio class
  bfq: limit the IO depth of CLASS_IDLE to 1
  bfq: keep the minimun bandwidth for CLASS_BE
  bfq: introduce better_fairness for container scene
  bfq: introduce prio_expire flag for bfq_queue
  bfq: expire in_serv_queue for prio_expire under better_fairness
  bfq: optimize IO injection under better_fairness
  bfq: disable idle for prio_expire under better_fairness
  bfq: disable merging between different groups under better_fairness
  bfq: remove unnecessary initialization logic
  bfq: optimize the calculation of bfq_weight_to_ioprio()

 block/bfq-cgroup.c  |  99 ++++++++++++++++++++++++++---
 block/bfq-iosched.c | 119 +++++++++++++++++++++++++++++++---
 block/bfq-iosched.h |  36 +++++++++--
 block/bfq-wf2q.c    | 180 ++++++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 376 insertions(+), 58 deletions(-)

-- 
1.8.3.1

