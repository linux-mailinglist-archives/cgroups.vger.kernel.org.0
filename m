Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80C54433AB
	for <lists+cgroups@lfdr.de>; Tue,  2 Nov 2021 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhKBQus (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Nov 2021 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhKBQur (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Nov 2021 12:50:47 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7112C0613F5;
        Tue,  2 Nov 2021 09:48:11 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t7so20624887pgl.9;
        Tue, 02 Nov 2021 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Xhz9r7JZBOQDI5whNrjmgfij89zWmhOWkSDOjjnmQtU=;
        b=LFq5SycnhAKDHq9ZyasKQkc8+vi8lqOCAUuILQ33aZtyJ1e00W9RjrwYzW3sja+mYk
         5+lmaHTcJcMOCerhu4EIwjborGskve15iWDXO0KicLqjRXgrPY6cEH91q64qZMgZGFxy
         83NRV1K6dz659Bzf43hOPPJvGnT3bMb44CiIyxCj0nVp00kXn7e4dV0Uy0d86tWWL7Uc
         wD2AcpQMHRVzaeXEF7oCop5ZzXcbeAphTjQTb44rp0ixPRsWW4S9QobJPWfq3Q3SNO+m
         XOiWQgWJ77XtntkkURIlAkL6y9Li3Yj953/27IS4g8QKBHMaW5fU2BqHXeeXL9ryyFV2
         aEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Xhz9r7JZBOQDI5whNrjmgfij89zWmhOWkSDOjjnmQtU=;
        b=Hh0DBvspUoOQonxEzfgpI5WEJzLFWrZFTDdifvAdcKuwOs/Kd6XtNi0CtxBjD2woZt
         +Kv6UZhQfNzTdp1V/gUgk+PRJeGNqaUPcm+xWQmYInkUCGEHa75VrACmQyC5AksPjtkk
         E5/EGFTgUDvJ9BQJ237ZdTrdIXLybEEq7fPs2+JUqnx3a/bKZbiu7D1c3gvGAQpm9RL4
         R2EHQK+ElIie/zQQLvWMMAgSAE8IPV1AQ20MENedJg0EpbU27+P1qlMuSkUtMvhQq3H/
         XT1hkgoL/+l7BL5h8hZ3PWdagXErk9g5n3FZQtK8G1w3tCpPqP2qJlwQ5ak1rwwhuS3p
         5jRA==
X-Gm-Message-State: AOAM5316aTNR36m5tJwwtxSBsJXC2aPItpm24c0AEBdLoLFx+zuHdp5l
        hsoKfGSl/6RfuXTfR3b+lK0=
X-Google-Smtp-Source: ABdhPJz2XdH0RwG9i9PgDghtTp4v9ZF5yp0LKtfKT+kYBORV67Iu3RkXkje/UdWUmel8K32Oew/2rQ==
X-Received: by 2002:a63:154:: with SMTP id 81mr28375443pgb.38.1635871691043;
        Tue, 02 Nov 2021 09:48:11 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id m184sm15625698pga.40.2021.11.02.09.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:48:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 2 Nov 2021 06:48:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.16-rc1
Message-ID: <YYFryTJQxFok0jo/@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

* The misc controller now reports allocation rejections through misc.events
  instead of printking.

* cgroup_mutex usage is reduced to improve scalability of some operations.

* vhost helper threads are now assigned to the right cgroup on cgroup2.

* Bug fixes.

Thanks.

The following changes since commit c0002d11d79900f8aa5c8375336434940d6afedf:

  cgroupv2, docs: fix misinformation in "device controller" section (2021-09-13 08:08:46 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.16

for you to fetch changes up to 588e5d8766486e52ee332a4bb097b016a355b465:

  cgroup: bpf: Move wrapper for __cgroup_bpf_*() to kernel/bpf/cgroup.c (2021-11-01 06:49:00 -1000)

----------------------------------------------------------------
Chunguang Xu (3):
      misc_cgroup: introduce misc.events to count failures
      misc_cgroup: remove error log to avoid log flood
      docs/cgroup: add entry for misc.events

Dan Schatzberg (1):
      cgroup: Fix rootcg cpu.stat guest double counting

He Fengqing (1):
      cgroup: bpf: Move wrapper for __cgroup_bpf_*() to kernel/bpf/cgroup.c

Shakeel Butt (3):
      cgroup: reduce dependency on cgroup_mutex
      cgroup: remove cgroup_mutex from cgroupstats_build
      cgroup: no need for cgroup_mutex for /proc/cgroups

Vishal Verma (1):
      cgroup: cgroup-v1: do not exclude cgrp_dfl_root

Waiman Long (1):
      cgroup: Make rebind_subsystems() disable v2 controllers all at once

 Documentation/admin-guide/cgroup-v2.rst |  10 +++
 include/linux/bpf-cgroup.h              |  20 ------
 include/linux/misc_cgroup.h             |   6 +-
 kernel/bpf/cgroup.c                     |  54 +++++++++++---
 kernel/cgroup/cgroup-v1.c               |  17 ++---
 kernel/cgroup/cgroup.c                  | 120 +++++++++++++++-----------------
 kernel/cgroup/misc.c                    |  31 +++++++--
 kernel/cgroup/rstat.c                   |   2 -
 8 files changed, 144 insertions(+), 116 deletions(-)

-- 
tejun
