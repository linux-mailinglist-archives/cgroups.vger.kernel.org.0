Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F51A0D23
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 00:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfH1WGI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Aug 2019 18:06:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42683 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfH1WGI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Aug 2019 18:06:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id f13so1122554qkm.9;
        Wed, 28 Aug 2019 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=vDon8M1NTFQbFibMp4kfu+E3libW4ghIHFjpCN3/Sb8=;
        b=GF2v1bOluHD/OkqipjqvA+sPl0H3BQepwJraUApzHqySvYizPwWE4ZIijVU6Dhuygt
         TnFoi+ULA5Ff4BKLF8IgJnocF4gLSEC6vdLRqovXmyVY9N7K8WU6TzuH/CmHLuzS6AX1
         VqZaaLFaiDh1eT66s03MgVMgFmdGEuiiiABwUjAoYD5pCFa1vCU6h/uzmGccmloMmlng
         Mx9pmZPx4irfcZcMl+rryvh0kse+KpVIpDp+YS366aepwiRnq50qtcw3QH41f0EKEZCK
         yCufagiiozzbowr0gyi1H5mZEUsqDXK6HsjO5ObhSA/YU+gItqy/yHfjI1fO5MbR8MBj
         mE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=vDon8M1NTFQbFibMp4kfu+E3libW4ghIHFjpCN3/Sb8=;
        b=K1NEXPnfJmXQfqmi8l+Ds3+raTfafCaI32xmMigea2mo/XvS8DPhk0TVhKI09pknpv
         VtmLAloTQWQm11BciZ6cs6q3j6uynUdeIaCKjHFS363C49/BsNLHBjtH91riQCfHCr1q
         9h+9nwFaoWoSMuA1SIt4Jl50wOV5CaKLsZ6KvY9oFJptwKL6XiiDncT0WuF+JCsw+nKN
         Pmc7rSDln8ZMvnIR9uOT8NADj19ocWYy3Fy+gK4blQe6FeIYx0CurDRFC9qThsB9ihzf
         DjsxmUPhWEiAnwZoWA2g+/5A8xAlZMOtOpZS1EU37G0RoDOK5luoa6JxHG8LyPc1bR6T
         Ks1A==
X-Gm-Message-State: APjAAAWo6qibYY/SQW0qvcvj0zUBarHFsiCyegPGQJXfHkGOlhFz4PWV
        PT/DmZeJQKKNOhLM8Yc5kR4=
X-Google-Smtp-Source: APXvYqwAFv81LsDVvF5UXN5dahyez4CEqHbvAWDOZAhu+oN1W9nIcwhE78ywRXVp03oEENgVd8vKeQ==
X-Received: by 2002:ae9:e714:: with SMTP id m20mr6198003qka.72.1567029966033;
        Wed, 28 Aug 2019 15:06:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c231])
        by smtp.gmail.com with ESMTPSA id w5sm223367qki.13.2019.08.28.15.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 15:06:05 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
Subject: [PATCHSET v3 block/for-linus] IO cost model based work-conserving porportional controller
Date:   Wed, 28 Aug 2019 15:05:50 -0700
Message-Id: <20190828220600.2527417-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Changes from v2[2]:

* Fixed a divide-by-zero bug in current_hweight().

* pre_start_time and friends renamed to alloc_time and now has its own
  CONFIG option which is selected by IOCOST.

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

        high priority (weight=500)      low priority (weight=100)

        Rand read                       None
        ditto                           Rand read
        ditto                           Seq  read
        ditto                           Rand write
        ditto                           Seq  write
        Seq  read                       None
        ditto                           Rand read
        ditto                           Seq  read
        ditto                           Rand write
        ditto                           Seq  write
        Rand write                      None
        ditto                           Rand read
        ditto                           Seq  read
        ditto                           Rand write
        ditto                           Seq  write
        Seq  write                      None
        ditto                           Rand read
        ditto                           Seq  read
        ditto                           Rand write
        ditto                           Seq  write

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

This patchset is on top of the current block/for-next 53fc55c817c3
("Merge branch 'for-5.4/block' into for-next") and contains the
following 10 patches.

 0001-blkcg-pass-q-and-blkcg-into-blkcg_pol_alloc_pd_fn.patch
 0002-blkcg-make-cpd_init_fn-optional.patch
 0003-blkcg-separate-blkcg_conf_get_disk-out-of-blkg_conf_.patch
 0004-block-rq_qos-add-rq_qos_merge.patch
 0005-block-rq_qos-implement-rq_qos_ops-queue_depth_change.patch
 0006-blkcg-s-RQ_QOS_CGROUP-RQ_QOS_LATENCY.patch
 0007-blk-mq-add-optional-request-alloc_time_ns.patch
 0008-blkcg-implement-blk-iocost.patch
 0009-blkcg-add-tools-cgroup-iocost_monitor.py.patch
 0010-blkcg-add-tools-cgroup-iocost_coef_gen.py.patch

0001-0007 are prep patches.
0008 implements blk-iocost.
0009 adds monitoring script.
0010 adds linear cost model coefficient generation script.

The patchset is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-iow-v2

diffstat follows, Thanks.

 Documentation/admin-guide/cgroup-v2.rst |   97 +
 block/Kconfig                           |   13 
 block/Makefile                          |    1 
 block/bfq-cgroup.c                      |    5 
 block/blk-cgroup.c                      |   71 
 block/blk-core.c                        |    4 
 block/blk-iocost.c                      | 2395 ++++++++++++++++++++++++++++++++
 block/blk-iolatency.c                   |    8 
 block/blk-mq.c                          |   13 
 block/blk-rq-qos.c                      |   18 
 block/blk-rq-qos.h                      |   28 
 block/blk-settings.c                    |    2 
 block/blk-throttle.c                    |    6 
 block/blk-wbt.c                         |   18 
 block/blk-wbt.h                         |    4 
 include/linux/blk-cgroup.h              |    4 
 include/linux/blk_types.h               |    3 
 include/linux/blkdev.h                  |   13 
 include/trace/events/iocost.h           |  174 ++
 tools/cgroup/iocost_coef_gen.py         |  178 ++
 tools/cgroup/iocost_monitor.py          |  270 +++
 21 files changed, 3272 insertions(+), 53 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20190614015620.1587672-1-tj@kernel.org
[2] http://lkml.kernel.org/r/20190710205128.1316483-1-tj@kernel.org

