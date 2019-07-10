Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D40264DBA
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2019 22:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfGJUvf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Jul 2019 16:51:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37018 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfGJUvf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Jul 2019 16:51:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id g15so1798250pgi.4;
        Wed, 10 Jul 2019 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CvZE8fnJezhAyMxqeAIRKgAjF8cMHDm7PT8K7Ek+hOE=;
        b=DQawfYEbXUtxURVUOcgUx0iJqhamXmbVlpefnJycQXXDtty5rO/aqwpmaThddJ4mHV
         iM1kbRldtpLnv+uPXGVI/JcWHuub22y1ojge5FDshApcloGK1dIvzvPj3ip+widkIA/Y
         160/xlqb7LGTf+Iisvxz+oFF1l9taXBkaEyuEf9Y6xM1mft68LZl6yqNjqV4h6c3nCRY
         0oJNAmo3ddhBueZ5xBkEiPbLZxPONG2BbSsX3rPM6I4O+RpBKfvcZ9RwuwD7d18AJYjF
         c9cfKwiaMboQpDBqY2EPOW0zjadlwnNVml7I587CkE6kBCCxiDtiXKqfdX9Rk8KBAz3B
         +yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=CvZE8fnJezhAyMxqeAIRKgAjF8cMHDm7PT8K7Ek+hOE=;
        b=NVHdvQ0ccqO+JI6FUIKNmw4jWoOIOGKEwtN3kl4K//spc6joktYcV9i58znYrVwbiH
         H28nSXCXMNATkNBPsWgp1zVu7POZk01Ok6zWKYavaF1jD0/iU+Oqpcy5SsUlXG81wxlv
         nf6dMNBEBaiz4Mb9VY8CnLaZWMHxiutVouOp0ALOxIOp9s6wGEx/qYIGTGUSJELEZ8ox
         S+hNj6IicLsPA1s/Nh4plPxaY/ibTJIwg5a6k/M0Xjw91tWqBSYbuuIc/stk2EtAoqr2
         5j2xn2hIOAkjaaAtrL6tidT6/3x3qyPFQcf2BX51m24SFxaiOIqRTMh6DWLK0k0eqbQw
         4bjg==
X-Gm-Message-State: APjAAAWrDpocjdXiknq7+gIX7Dm7VspvMurZnn6jxrVhxoRUBJ2gFvhs
        Zv+q5RVeXOEDazB+RsPCO30=
X-Google-Smtp-Source: APXvYqy+i9l1eritxzC3MX4GTWx5k40hH8zeIKzOLt74WPzldLLMksGAs5+GPjLlIggI1jQZOHkoPg==
X-Received: by 2002:a63:1208:: with SMTP id h8mr172872pgl.377.1562791893860;
        Wed, 10 Jul 2019 13:51:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id v12sm2832000pjk.13.2019.07.10.13.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:51:32 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCHSET v2 block/for-linus] IO cost model based work-conserving porportional controller
Date:   Wed, 10 Jul 2019 13:51:18 -0700
Message-Id: <20190710205128.1316483-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Changes from v1[1]:

* Prerequisite patchsets had cosmetic changes and merged.  Refreshed
  on top.

* Renamed from ioweight to iocost.  All source code and tools are
  updated accordingly.  Control knobs io.weight.qos and
  io.weight.cost_model are renamed to io.cost.qos and io.cost.model
  respectively.  This is a more fitting name which won't become a
  misnomer when, for example, cost based io.max is added.

* Various bug fixes and improvements.  A few bugs were discovered
  while testing against high-iops nvme device.  Auto parameter
  selection improved and verified across different classes of SSDs.

* Dropped bpf iocost support for now.

* Added coef generation script.

* Verified on high-iops nvme device.  Result is included below.

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
block/blk-iocost.c and Documentation/admin-guide/cgroup-v2.rst changes
in the "blkcg: implement blk-iocost" patch.

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
  * iocost, QoS: None
    https://photos.app.goo.gl/MLNQGxCtBQ8wAmjm7
  * iocost, QoS: rpct=95.00 rlat=40000 wpct=95.00 wlat=40000 min=25.00 max=200.00
    https://photos.app.goo.gl/XqXHm3Mkbm9w6Db46
* NCQ-blacklisted SATA SSD (QD==1)
  * No IO control
    https://photos.app.goo.gl/wCTXeu2uJ6LYL4pk8
  * iocost, QoS: None
    https://photos.app.goo.gl/T2HedKD2sywQgj7R9
  * iocost, QoS: rpct=95.00 rlat=20000 wpct=95.00 wlat=20000 min=50.00 max=200.00
    https://photos.app.goo.gl/urBTV8XQc1UqPJJw7
* SATA SSD (QD==32)
  * No IO control
    https://photos.app.goo.gl/TjEVykuVudSQcryh6
  * iocost, QoS: None
    https://photos.app.goo.gl/iyQBsky7bmM54Xiq7
  * iocost, QoS: rpct=95.00 rlat=10000 wpct=95.00 wlat=20000 min=50.00 max=400.00
    https://photos.app.goo.gl/q1a6URLDxPLMrnHy5
* NVME SSD (ran with 8 concurrent fio jobs to achieve saturation)
  * No IO control
    https://photos.app.goo.gl/S6xjEVTJzcfb3w1j7
  * iocost, QoS: None
    https://photos.app.goo.gl/SjQUUotJBAGr7vqz7
  * iocost, QoS: rpct=95.00 rlat=5000 wpct=95.00 wlat=5000 min=1.00 max=10000.00
    https://photos.app.goo.gl/RsaYBd2muX7CegoN7

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

This patchset is on top of block/for-linus 3a10f999ffd4
("blk-throttle: fix zero wait time for iops throttled group")
and contains the following ten patches.

 0001-blkcg-pass-q-and-blkcg-into-blkcg_pol_alloc_pd_fn.patch
 0002-blkcg-make-cpd_init_fn-optional.patch
 0003-blkcg-separate-blkcg_conf_get_disk-out-of-blkg_conf_.patch
 0004-block-rq_qos-add-rq_qos_merge.patch
 0005-block-rq_qos-implement-rq_qos_ops-queue_depth_change.patch
 0006-blkcg-s-RQ_QOS_CGROUP-RQ_QOS_LATENCY.patch
 0007-blk-mq-add-optional-request-pre_start_time_ns.patch
 0008-blkcg-implement-blk-iocost.patch
 0009-blkcg-add-tools-cgroup-iocost_monitor.py.patch
 0010-blkcg-add-tools-cgroup-iocost_coef_gen.py.patch

0001-0007 are prep patches.  0008 implements blk-iocost.  0009 adds
monitoring script.  0010 adds linear model coef generation script.

The patchset is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-iocost

diffstat follows, Thanks.

 Documentation/admin-guide/cgroup-v2.rst |   97 +
 block/Kconfig                           |    9 
 block/Makefile                          |    1 
 block/bfq-cgroup.c                      |    5 
 block/blk-cgroup.c                      |   71 
 block/blk-core.c                        |    4 
 block/blk-iocost.c                      | 2394 ++++++++++++++++++++++++++++++++
 block/blk-iolatency.c                   |    8 
 block/blk-mq.c                          |   11 
 block/blk-rq-qos.c                      |   18 
 block/blk-rq-qos.h                      |   28 
 block/blk-settings.c                    |    2 
 block/blk-throttle.c                    |    6 
 block/blk-wbt.c                         |   18 
 block/blk-wbt.h                         |    4 
 include/linux/blk-cgroup.h              |    4 
 include/linux/blk_types.h               |    3 
 include/linux/blkdev.h                  |    7 
 include/trace/events/iocost.h           |  174 ++
 tools/cgroup/iocost_coef_gen.py         |  178 ++
 tools/cgroup/iocost_monitor.py          |  270 +++
 21 files changed, 3259 insertions(+), 53 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20190614015620.1587672-1-tj@kernel.org

