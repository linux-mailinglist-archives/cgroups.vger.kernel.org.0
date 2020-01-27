Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B619A14ABC1
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2020 22:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgA0Vrx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jan 2020 16:47:53 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46535 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgA0Vrx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jan 2020 16:47:53 -0500
Received: by mail-qv1-f65.google.com with SMTP id y2so1415461qvu.13;
        Mon, 27 Jan 2020 13:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=vBfb6b7TVkkhFizHEZ1B5meaSInahJG+9I7ajoLipOE=;
        b=LsCWSTOZ34ymj9MtQDPlDQ7Rx/wZx0JHqXIESlklpvDlbafAnvNcpqkNpgvsz2yWa1
         TIQVSJw7s7fllV15gSsadCaOQJWXISlNQyxP5SIJpXJwC3Gug9vfsuVbDYqMMawaM++w
         ojFtihhP9giu3uc0FuaFx7kA/3pHKbzCmkJVn+zDjqlJdGTn08F6OooO2RwQ/EA0PkvF
         gIaavzW3YXAUmH2iU3W2g8GuOb00m56aFL6rwlcGwSDH50DpsBkyF52iauvuXzG0v0bK
         ttZrZ29mhwFKl2QXqN8H+rj312o3E+i6AUYzk5oxH0ZjiuyK+T3fU4A8g3p81wOBdGN1
         h9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=vBfb6b7TVkkhFizHEZ1B5meaSInahJG+9I7ajoLipOE=;
        b=gdYGNZGJDhXl6G8BrK1lQvpmlE7Goyrf5D1o51wkimSPADp+HewpRZezRk6eq+o27a
         l2Ce0PyvJWT0Y/TweehyjxgPnHMI1qGQ3Knq+YsodS2JI1tstvTgQyASD7GybCgSgv3v
         uKbcQ1bzBboY9HygVoP1nCZlnRiaV5L2lqVc2fZ5qYtSRnHt+9l0oUzfDm12v0TzWM9X
         jNDUWVCL5+vIStxWvC2sbKgQco8rptW6pBXWu8GyfPj3QQsFo2IfoISPA22GYcX1fy+p
         Cnm3R6y/VR/ckcDgiu+KxPDnHl3z4/z33WrBm63nQnFgZKexh/Lm76KdyZMn9jvwVzro
         GdGg==
X-Gm-Message-State: APjAAAVPQmneVdvXHDwOeSia2526ZpuC0rSm4eOURlhrZ86OFllTqEFn
        RROIAcsBQTC/2XeYZoHq5dA=
X-Google-Smtp-Source: APXvYqyCpi/Y7G1sPuVgc3HDbzujsB0JEfikRYxPimFmOlwDR7fH9H4ph4c9m+UyUxvW3EoOqtSMig==
X-Received: by 2002:ad4:42aa:: with SMTP id e10mr13363491qvr.92.1580161671794;
        Mon, 27 Jan 2020 13:47:51 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::19d])
        by smtp.gmail.com with ESMTPSA id d22sm4661752qtp.37.2020.01.27.13.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 13:47:49 -0800 (PST)
Date:   Mon, 27 Jan 2020 16:47:49 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.6-rc1
Message-ID: <20200127214749.GC180576@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

* cgroup2 interface for hugetlb controller. I think this was the last
  remaining bit which was missing from cgroup2.

* Fixes for race and a spurious warning in threaded cgroup handling.

* Other minor changes.

Thanks.

The following changes since commit 6afa873170a612b2b9e392c19c523ed8aae6fbc9:

  Merge tag 'linux-kselftest-5.5-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2019-12-16 10:06:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.6

for you to fetch changes up to 9ea37e24d4a95dd934a0600d65caa25e409705bb:

  iocost: Fix iocost_monitor.py due to helper type mismatch (2020-01-17 11:54:35 -0800)

----------------------------------------------------------------
Chen Zhou (1):
      cgroup: fix function name in comment

Giuseppe Scrivano (1):
      mm: hugetlb controller for cgroups v2

Michal Koutný (1):
      cgroup: Prevent double killing of css when enabling threaded cgroup

Tejun Heo (1):
      iocost: Fix iocost_monitor.py due to helper type mismatch

 Documentation/admin-guide/cgroup-v2.rst |  29 +++++
 include/linux/hugetlb.h                 |   3 +-
 kernel/cgroup/cgroup.c                  |  11 +-
 kernel/cgroup/rstat.c                   |   2 +-
 mm/hugetlb_cgroup.c                     | 198 ++++++++++++++++++++++++++++++--
 tools/cgroup/iocost_monitor.py          |   4 +-
 6 files changed, 227 insertions(+), 20 deletions(-)

-- 
tejun
