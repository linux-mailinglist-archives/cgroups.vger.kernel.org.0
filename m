Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031FD4516C
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 03:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfFNB4a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 21:56:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35782 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNB4a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 21:56:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so582014pgl.2;
        Thu, 13 Jun 2019 18:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=SR8M6Ti5j/3I6nXx+EB2QCVkt/EsvMWc6B0LovjzHEY=;
        b=tuogteSkKpt2iRcOnqRANHGIzyYK7P/qZ6GixOJk7Rblemec1OhU7Bi33T7HdV9x05
         rU6FkYi7SXRaeVmrvKCFzyFo2Fm7nZ1QJHSYmzITHW9MdUgsiY8EQfzCFwGggCQvcKcm
         FVKyovUbiRGlK8rnYUp91QbMxObu/yBHnnp26iu36uxYoEOX+CRf+umhStz3ehVX52WX
         TNxSKfTzaNTi+s53F0d7NQd0uybzHufs4378zvE4hgwosVhsW143fBpBpG0JZyqTNxcv
         72KsqJ2Y1UCdDau0pgi2DEhRPF8Eq9uoVlUY1XYJwtaysxyKFEetnq+0KlZ/zHzg8Duk
         v8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=SR8M6Ti5j/3I6nXx+EB2QCVkt/EsvMWc6B0LovjzHEY=;
        b=C8sNYGr86Fd5/fO3Fx9YPFTopV+6zwgkaBL8C5US8Ojd7bdcYpEH18EN1J84pVoGlf
         o7+pXHHtG5mAdDTZd4VQVFzw7I35/LHulTSOno+xF3KqVq9DMB2AheXUsJjxR7c0KGod
         +VPqFi+xpXoHLe6PpCvr0sJX6YuJsksBQxvgdFciu0RyGtmI/kO1wf9J3jboRIoZb/qG
         x1i7zAXRen3ArWc+/nkuxRs9S7O/EaM7M/7wJIiYjRhD1rc6x8TzVPt1vJ7P9JR4BDAY
         6BNaELWDv+Yxj7LcTHQKT86thA5TNLyzoBDGqbKiJZC9cGpCaeEY/Z6ISmPzbUkvcW5M
         /RIQ==
X-Gm-Message-State: APjAAAXELzA/nO/8b/Yed0VXGNyab3HWTu/xj2WkkLRD5ZCqSjd5RSDu
        WAWx0g8Trb3NbhcM3tjjbPs=
X-Google-Smtp-Source: APXvYqx66cHST5ToX+HhTP5yXqS10svpi3XfuBzFGcgLyrXYcclXY5mqSC2Gie/VJ6ax8NpzOa8XlQ==
X-Received: by 2002:a63:e358:: with SMTP id o24mr32652524pgj.78.1560477389128;
        Thu, 13 Jun 2019 18:56:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id g5sm958549pjt.14.2019.06.13.18.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 18:56:27 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org
Subject: [PATCHSET block/for-next] IO cost model based work-conserving porportional controller
Date:   Thu, 13 Jun 2019 18:56:10 -0700
Message-Id: <20190614015620.1587672-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

One challenge of controlling IO resources is the lack of trivially
observable cost metric.  This is distinguished from CPU and memory
where wallclock time and the number of bytes can serve as accurate
enough approximations.

Bandwidth and iops are the most commonly used metrics for IO devices
but depending on the type and specifics of the device, different IO
patterns easily lead to multiple orders of magnitude variations
rendering them useless for the purpose of IO capacity distribution.
While on-device time, with a lot of clutches, could serve as a useful
approximation for non-queued rotational devices, this is no longer
viable with modern devices, even the rotational ones.

While there is no cost metric we can trivially observe, it isn't a
complete mystery.  For example, on a rotational device, seek cost
dominates while a contiguous transfer contributes a smaller amount
proportional to the size.  If we can characterize at least the
relative costs of these different types of IOs, it should be possible
to implement a reasonable work-conserving proportional IO resource
distribution.

This patchset implements IO cost model based work-conserving
proportional controller.  It currently has a simple linear cost model
builtin where each IO is classified as sequential or random and given
a base cost accordingly and additional size-proportional cost is added
on top.  Each IO is given a cost based on the model and the controller
issues IOs for each cgroup according to their hierarchical weight.

By default, the controller adapts its overall IO rate so that it
doesn't build up buffer bloat in the request_queue layer, which
guarantees that the controller doesn't lose significant amount of
total work.  However, this may not provide sufficient differentiation
as the underlying device may have a deep queue and not be fair in how
the queued IOs are serviced.  The controller provides extra QoS
control knobs which allow tightening control feedback loop as
necessary.

For more details on the control mechanism, implementation and
interface, please refer to the comment at the top of
block/blk-ioweight.c and Documentation/admin-guide/cgroup-v2.rst
changes in the "blkcg: implement blk-ioweight" patch.

Here are some test results.  Each test run goes through the following
combinations with each combination running for a minute.  All tests
are performed against regular files on btrfs w/ deadline as the IO
scheduler.  Random IOs are direct w/ queue depth of 64.  Sequential
are normal buffered IOs.

	high priority (weight=500)	low priority (weight=100)

	Rand read			None
	ditto				Rand read
	ditto				Seq  read
	ditto				Rand write
	ditto				Seq  write
	Seq  read			None
	ditto				Rand read
	ditto				Seq  read
	ditto				Rand write
	ditto				Seq  write
	Rand write			None
	ditto				Rand read
	ditto				Seq  read
	ditto				Rand write
	ditto				Seq  write
	Seq  write			None
	ditto				Rand read
	ditto				Seq  read
	ditto				Rand write
	ditto				Seq  write

* 7200RPM SATA hard disk
  * No IO control
    https://photos.app.goo.gl/1KBHn7ykpC1LXRkB8
  * ioweight, QoS: None
    https://photos.app.goo.gl/MLNQGxCtBQ8wAmjm7
  * ioweight, QoS: rpct=95.00 rlat=40000 wpct=95.00 wlat=40000 min=25.00 max=200.00
    https://photos.app.goo.gl/XqXHm3Mkbm9w6Db46
* NCQ-blacklisted SATA SSD (QD==1)
  * No IO control
    https://photos.app.goo.gl/wCTXeu2uJ6LYL4pk8
  * ioweight, QoS: None
    https://photos.app.goo.gl/T2HedKD2sywQgj7R9
  * ioweight, QoS: rpct=95.00 rlat=20000 wpct=95.00 wlat=20000 min=50.00 max=200.00
    https://photos.app.goo.gl/urBTV8XQc1UqPJJw7
* SATA SSD (QD==32)
  * No IO control
    https://photos.app.goo.gl/TjEVykuVudSQcryh6
  * ioweight, QoS: None
    https://photos.app.goo.gl/iyQBsky7bmM54Xiq7
  * ioweight, QoS: rpct=95.00 rlat=10000 wpct=95.00 wlat=20000 min=50.00 max=400.00
    https://photos.app.goo.gl/q1a6URLDxPLMrnHy5

Even without explicit QoS configuration, read-heavy scenarios can
obtain acceptable differentiation.  However, when write-heavy, the
deep buffering on the device side makes it difficult to maintain
control.  With QoS parameters set, the differentiation is acceptable
across all combinations.

The implementation comes with default cost model parameters which are
selected automatically which should provide acceptable behavior across
most common devices.  The parameters for hdd and consumer-grade SSDs
seem pretty robust.  The default parameter set and selection criteria
for highend SSDs might need further adjustments.

It is fairly easy to configure the QoS parameters and, if needed, cost
model coefficients.  We'll follow up with tooling and further
documentation.  Also, the last RFC patch in the series implements
support for bpf-based custom cost function.  Originally we thought
that we'd need per-device-type cost functions but the simple linear
model now seem good enough to cover all common device classes.  In
case custom cost functions become necessary, we can fully develop the
bpf based extension and also easily add different builtin cost models.

Andy Newell did the heavy lifting of analyzing IO workloads and device
characteristics, exploring various cost models, determining the
default model and parameters to use.

Josef Bacik implemented a prototype which explored the use of
different types of cost metrics including on-device time and Andy's
linear model.

This patchset is on top of
  cgroup/for-5.3
    git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.3
+ [PATCHSET block/for-linus] Assorted blkcg fixes
    http://lkml.kernel.org/r/20190613223041.606735-1-tj@kernel.org
+ [PATCHSET btrfs/for-next] btrfs: fix cgroup writeback support
    http://20190614003350.1178444-1-tj@kernel.org

This patchset contains the following 10 patches.

 0001-blkcg-pass-q-and-blkcg-into-blkcg_pol_alloc_pd_fn.patch
 0002-blkcg-make-cpd_init_fn-optional.patch
 0003-blkcg-separate-blkcg_conf_get_disk-out-of-blkg_conf_.patch
 0004-block-rq_qos-add-rq_qos_merge.patch
 0005-block-rq_qos-implement-rq_qos_ops-queue_depth_change.patch
 0006-blkcg-s-RQ_QOS_CGROUP-RQ_QOS_LATENCY.patch
 0007-blk-mq-add-optional-request-pre_start_time_ns.patch
 0008-blkcg-implement-blk-ioweight.patch
 0009-blkcg-add-tools-cgroup-monitor_ioweight.py.patch
 0010-RFC-blkcg-implement-BPF_PROG_TYPE_IO_COST.patch

0001-0007 are prep patches.
0008 implements blk-ioweight.
0009 adds monitoring script.
0010 is the RFC patch for BPF cost function.

The patchset is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-iow

diffstat follows, Thanks.

 Documentation/admin-guide/cgroup-v2.rst                |   93 
 block/Kconfig                                          |   12 
 block/Makefile                                         |    1 
 block/bfq-cgroup.c                                     |    5 
 block/blk-cgroup.c                                     |   71 
 block/blk-core.c                                       |    4 
 block/blk-iolatency.c                                  |    8 
 block/blk-ioweight.c                                   | 2509 +++++++++++++++++
 block/blk-mq.c                                         |   11 
 block/blk-rq-qos.c                                     |   18 
 block/blk-rq-qos.h                                     |   28 
 block/blk-settings.c                                   |    2 
 block/blk-throttle.c                                   |    6 
 block/blk-wbt.c                                        |   18 
 block/blk-wbt.h                                        |    4 
 block/blk.h                                            |    8 
 block/ioctl.c                                          |    4 
 include/linux/blk-cgroup.h                             |    4 
 include/linux/blk_types.h                              |    3 
 include/linux/blkdev.h                                 |    7 
 include/linux/bpf_types.h                              |    3 
 include/trace/events/ioweight.h                        |  174 +
 include/uapi/linux/bpf.h                               |   11 
 include/uapi/linux/fs.h                                |    2 
 tools/bpf/bpftool/feature.c                            |    3 
 tools/bpf/bpftool/main.h                               |    1 
 tools/cgroup/monitor_ioweight.py                       |  264 +
 tools/include/uapi/linux/bpf.h                         |   11 
 tools/include/uapi/linux/fs.h                          |    2 
 tools/lib/bpf/libbpf.c                                 |    2 
 tools/lib/bpf/libbpf_probes.c                          |    1 
 tools/testing/selftests/bpf/Makefile                   |    2 
 tools/testing/selftests/bpf/iocost_ctrl.c              |   43 
 tools/testing/selftests/bpf/progs/iocost_linear_prog.c |   52 
 34 files changed, 3333 insertions(+), 54 deletions(-)

--
tejun

