Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37C4259ECC
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgIASxJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIASxC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:53:02 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4753C061244;
        Tue,  1 Sep 2020 11:53:01 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z2so1730298qtv.12;
        Tue, 01 Sep 2020 11:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aT4PofSSAV/4Uz0nRqbPA+6cW6GzyIGarpofm1HYm5U=;
        b=KHevFLIoVNyzIYnY/WEmliVjng0ASRrMatTBReOEcDHUqvZHsJHzD5Ck3aWSucz8lx
         RM7rcSa32POkT5nQ0He0gcJ1/N/Q3F6FSwIFq6QXe1s8nSjpSQKF0QfNKqI5v7DVE3jw
         dSO3EnndfgS26GQpGbmZOcW5dBRNFNT+/Ye6H+so8vfcxMkRcM2JdAdF2sNZ+oS7L05a
         utqwa8PmFFQBEFFktZO8vIqnLTXZyhRCYQPZM+5hm5ZohhM6qh+IAzwNa5qnTuW9JEh0
         tW6ajDIUwUn+spaRZKWHi/za/WAVrousISxNYdlTeZ/etnQz4fbuHGeWSpw5F8h/hJyI
         TtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aT4PofSSAV/4Uz0nRqbPA+6cW6GzyIGarpofm1HYm5U=;
        b=D/ONMeK2RL/jDu9hM47keg0dHlFNgRjA5RrPJZ6/EA2mSFjAaJvNcTtTEwe2GgU9JZ
         13j+FBEjL8v3lEabfpzHdifSzhuPXlaN/nKoB90fdms0Bfk7tZ9KLeug0l93bmfQwPyl
         a7/NjWLFX3wZ5Zfqz99KiV7/thCiyzNBy3WRIV8zrjKZc8VcAmfavBdTai0fg502Wn+w
         ijzp3smqz0V6cRaQ0Ta7hh/FgjSzi5KCWSd8gHaAN5+oDA+Zzv/+ddtx4dpUc6xYROrS
         s73OYOkzKkH2gCrSxROMPA72vDGBYSMw+zeKJE8xikLLVcGkOuSrD62mEUWBkX+gUjCt
         8aUw==
X-Gm-Message-State: AOAM530GUEZWpOIXw5Iwun0RYqRJjm77iKFPignyGNSVXL9rydp7undk
        EdslgN6PQQfZ8BrD3L6g+PQ=
X-Google-Smtp-Source: ABdhPJwftTO1H5MJ2Q/tp7NpaXQdBF30yPgiAJF7a86MFb02yazpgx5CsBrq7xNNC0ejcB56zCiWIg==
X-Received: by 2002:ac8:4747:: with SMTP id k7mr3173654qtp.76.1598986380824;
        Tue, 01 Sep 2020 11:53:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id d12sm2394189qka.34.2020.09.01.11.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:00 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com
Subject: [PATCHSET for-5.10/block] blk-iocost: iocost: improve donation, debt and excess handling
Date:   Tue,  1 Sep 2020 14:52:30 -0400
Message-Id: <20200901185257.645114-1-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

This patchset improves iocost in three areas to make iocost internal
operations more accurate and immediate with the goal of improving work
conservation and distribution fairness, and removing dependence on vrate
adjustments for masking work conservation issues. This improves overall
control quality and allows regulating vrate more tightly for more consistent
behavior as vrate now only needs to respond to device behavior changes.

1. Donation

iocost implements work-conservation by making under-utliized cgroups to
donate unused budgets to saturated cgroups. This approach has the
significant advantage that calculation or synchronization inaccuracies never
lead to over utilization of the device while allowing all hot path
operations to be local to each cgroup - it's inherently safe w/o needing
system-wide synchronization in hot paths.

However, this approach requires dynamically adjusting weights according to
the current usage of each cgroup. Given that a cgroup with weight X is using
only a portion of its hierarchical absoulte share, it needs to scale down X
so that the share matches the observed usage. With nesting and multiple
nodes needing adjustments at once, the math is non-trivial. The current
implementation works around the issue by trying to converge by repeatedly
under-adjusting the weight of each cgroup.

The innate inaccuracies can lead to significant errors impacting work
conservation and fairness, and the workarounds around them weigh down the
rest of the control logic.

Andy Newell devised a method to calculate the exact weight updates given the
target hierarchical shares which is described in the following pdfs.

  https://drive.google.com/file/d/1PsJwxPFtjUnwOY1QJ5AeICCcsL7BM3bo
  https://drive.google.com/file/d/1vONz1-fzVO7oY5DXXsLjSxEtYYQbOvsE
  https://drive.google.com/file/d/1WcrltBOSPN0qXVdBgnKm4mdp9FhuEFQN

This patchset implements Andy's method for precise donation weight
adjustments on each period timer.

Donation amount is also adjusted during a period if the donor is running out
of budget. This mechanism used to be very coarse as donation calculations
weren't accurate to begin with. Now that donation calculations are exact,
this patchset improves in-period adjustments too.

2. Debt

Some IOs which are attributed to a low priority cgroup can cause severe
priority inversions when blocked - e.g. swap outs and filesystem metadata
IOs. These IOs are issued right away even when the cgroup doesn't have
enough budget. When this happens, the cgroup incurs debt, which the cgroup
has to pay off before issuing more IOs.

There were several issues around debt handling around how weight is adjusted
while under debt, how payment is calculated, and how anonymous memory delay
duration is determined. This patchset fixes and improves debt handling and
adds debt forgiveness mechanism which avoids extended pathological stalling
on very slow devices.

3. Excess handling

During a period, each cgroup mostly runs on its own without constantly
synchronizing with other cgroups. This often leads to excess budget which
needs to be thrown away at the end of the period, which can have negative
impact on work conservation. This is somewhat offset by vrate adjustments
but vrate compensation is delayed and can sometimes be erratic and it
prevents us from confining vrate for more consistent behavior.

This patchset implements excess vrate compensation where the effective vrate
is transparently boosted to compensate for excesses without affecting the
regular latency based vrate adjustment mechanism. This compensates for
excesses immediately and accurately and allows the regular vrate adjustment
mechanism to worry only about device behavior changes.


This patchset is on top of for-5.10/block (2b64038972e4) and availalbe in
the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git iocost-andys

It contains the following 27 patches.

 0001-blk-iocost-ioc_pd_free-shouldn-t-assume-irq-disabled.patch
 0002-blk-stat-make-q-stats-lock-irqsafe.patch
 0003-blk-iocost-use-local-64-_t-for-percpu-stat.patch
 0004-blk-iocost-rename-propagate_active_weights-to-propag.patch
 0005-blk-iocost-clamp-inuse-and-skip-noops-in-__propagate.patch
 0006-blk-iocost-move-iocg_kick_delay-above-iocg_kick_wait.patch
 0007-blk-iocost-make-iocg_kick_waitq-call-iocg_kick_delay.patch
 0008-blk-iocost-s-HWEIGHT_WHOLE-WEIGHT_ONE-g.patch
 0009-blk-iocost-use-WEIGHT_ONE-based-fixed-point-number-f.patch
 0010-blk-iocost-make-ioc_now-now-and-ioc-period_at-64bit.patch
 0011-blk-iocost-streamline-vtime-margin-and-timer-slack-h.patch
 0012-blk-iocost-grab-ioc-lock-for-debt-handling.patch
 0013-blk-iocost-add-absolute-usage-stat.patch
 0014-blk-iocost-calculate-iocg-usages-from-iocg-local_sta.patch
 0015-blk-iocost-replace-iocg-has_surplus-with-surplus_lis.patch
 0016-blk-iocost-decouple-vrate-adjustment-from-surplus-tr.patch
 0017-blk-iocost-restructure-surplus-donation-logic.patch
 0018-blk-iocost-implement-Andy-s-method-for-donation-weig.patch
 0019-blk-iocost-revamp-donation-amount-determination.patch
 0020-blk-iocost-revamp-in-period-donation-snapbacks.patch
 0021-blk-iocost-revamp-debt-handling.patch
 0022-blk-iocost-implement-delay-adjustment-hysteresis.patch
 0023-blk-iocost-halve-debts-if-device-stays-idle.patch
 0024-blk-iocost-implement-vtime-loss-compensation.patch
 0025-blk-iocost-restore-inuse-update-tracepoints.patch
 0026-blk-iocost-add-three-debug-stat-cost.wait-indebt-and.patch
 0027-blk-iocost-update-iocost_monitor.py.patch

0001-0002 are fixes w/ stable cc'd.

0003-0012 are prep patches - increasing calculation precision for weights,
switching some fields to 64bit, code reorganization, locking changes and so
on.

0013-0014 implement per-cgroup absolute usage tracking so that control
decisions aren't affected by weight distribution changes.

0015-0017 restructure donation logic to prepare for Andy's weight adjustment
method.

0018-0020 implement Andy's weight adjustment method, improve donation logic
both on period and in period.

0021-0023 improve debt and delay handling.

0024 implements budget excess compensation.

0025-0027 update tracepoints, monitoring script, debug stat.

diffstat follows. Thanks.

 block/blk-cgroup.c             |   23 
 block/blk-iocost.c             | 1540 +++++++++++++++++++++++++++++++----------
 block/blk-stat.c               |   17 
 include/trace/events/iocost.h  |   26 
 tools/cgroup/iocost_monitor.py |   54 -
 5 files changed, 1227 insertions(+), 433 deletions(-)

--
tejun

