Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D093FCBB4
	for <lists+cgroups@lfdr.de>; Tue, 31 Aug 2021 18:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbhHaQnl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Aug 2021 12:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbhHaQnc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Aug 2021 12:43:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271F5C0617AE;
        Tue, 31 Aug 2021 09:42:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x4so17363825pgh.1;
        Tue, 31 Aug 2021 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rwAwM/f7xCIyGLgjKw6m0UR3ux/e/UzH0gwF7myxEvs=;
        b=RtiK3a37eisNqkkGWXt1I8MV2kdXnD1XVPVaVV6mupWtT3nOV6gHiuOQEAyEv/GOQN
         p42bXin7ZQM16TLp8lqEsd5zj4Di4GIeqRW7kL+/Q1G4tUFtxEw1knySBj+AmjeW9TaD
         GUSoTNudWD645aJPMJlSXRp2wFaLJckFB3c/S2N/05himiolQyj3NbrXRzi7Np+pA9rY
         S6KqzkWz1qu0m0FyBpQj61Hp+wMJAzJFDC4ziRPiNj4nh4TBW3j/d7vD/zPyp8wUcyLj
         Uw3sSHQCmxdq4nEqzoJDQpVVI2DBu1zXV39PZk/MrVwM2+djG/qk0/d2i00+81jeKiRq
         avew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=rwAwM/f7xCIyGLgjKw6m0UR3ux/e/UzH0gwF7myxEvs=;
        b=aKgVq7bITU95qLPdykFUwvPWYD1tRPb72SVUjudMvkTzfRy+VRyiO51etv3V55tykb
         7xFAejm3UJYyYgYL3nT8pt0E+4qVlGEESmP9srdQJdvXmFy/gF0HH7HX09Q1iB58hK45
         BvKwH3JT66BjUKP7XLJwt/CernfYSCXUF+AAPyjBKpHgTBo3+mug3pusRMDEqzYL0DTp
         9Ba7FeiXeGeOmD/4aCHHhQ8YR2zbR9BS6hw/3/lzof5PrpivcfNDh7H+3h5528N4g1EY
         MHKvTWiIojRJYowLibDoxhJCfvlu3onWw1233jVK3RtU9QZogw9B3UkgkMQCAPlN7jaX
         DuEw==
X-Gm-Message-State: AOAM532Q5ezXHr+sMTAW0Lv88A6EWDeoMObf7OZ/TCl2tl3L5eu89qS8
        lYISxZtoZBZ0zBFIaY3VDNc=
X-Google-Smtp-Source: ABdhPJxT4IhVE8gfC62icpupw56xGChLLkUvAO3dL+2patStPBCnTPSDeN7DG1tbGv/ZX3Sgqi+1Ag==
X-Received: by 2002:a62:ab04:0:b0:405:c1c0:543c with SMTP id p4-20020a62ab04000000b00405c1c0543cmr3274542pff.36.1630428153330;
        Tue, 31 Aug 2021 09:42:33 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id o16sm22648349pgv.29.2021.08.31.09.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:42:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 31 Aug 2021 06:42:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.15-rc1
Message-ID: <YS5b98kN6updRd3u@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

Two cpuset behavior changes:

* cpuset on cgroup2 is changed to enable memory migration based on nodemask
  by default.

* A notification is generated when cpuset partition state changes.

All other patches are minor fixes and clenaups.

Thanks.

The following changes since commit d936eb23874433caa3e3d841cfa16f5434b85dcf:

  Revert "Makefile: Enable -Wimplicit-fallthrough for Clang" (2021-07-15 18:05:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.15

for you to fetch changes up to d20d30ebb199354729c64c86945ed25c66ff4991:

  cgroup: Avoid compiler warnings with no subsystems (2021-08-30 07:36:43 -1000)

----------------------------------------------------------------
Kees Cook (1):
      cgroup: Avoid compiler warnings with no subsystems

Nicolas Saenz Julienne (1):
      cgroup/cpuset: Avoid memory migration when nodemasks match

Randy Dunlap (1):
      cgroup: cgroup-v1: clean up kernel-doc notation

Sebastian Andrzej Siewior (1):
      cgroup: Replace deprecated CPU-hotplug functions.

Waiman Long (5):
      cgroup/cpuset: Miscellaneous code cleanup
      cgroup/cpuset: Fix a partition bug with hotplug
      cgroup/cpuset: Fix violation of cpuset locking rule
      cgroup/cpuset: Enable event notification when partition state changes
      cgroup/cpuset: Enable memory migration for cpuset v2

zhaoxiaoqiang11 (1):
      cgroup: remove cgroup_mount from comments

 Documentation/admin-guide/cgroup-v2.rst |  11 +++
 kernel/cgroup/cgroup-v1.c               |   8 +-
 kernel/cgroup/cgroup.c                  |  27 ++++--
 kernel/cgroup/cpuset.c                  | 162 +++++++++++++++++++++-----------
 4 files changed, 144 insertions(+), 64 deletions(-)

-- 
tejun
