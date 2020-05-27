Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44321E45A7
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2020 16:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbgE0OVX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 May 2020 10:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389072AbgE0OVX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 May 2020 10:21:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0ABC08C5C1;
        Wed, 27 May 2020 07:21:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c12so5560544qkk.13;
        Wed, 27 May 2020 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PmfbmDEwWXL4BvaLDwT2z4rZRjeL8v9u316orBCGPsE=;
        b=DLCV/9qp/eo/ydm2hUV10ZlWLk6rheVtyjcRfQ+8f/LMjMkhpz22lWZg3MvQwxHhs3
         CHOnqxsMW1BIGdZ94iLc0LS3sc5JXalpHzd4cF3cp9CRoHIpeC+gW/uyUxTJxfO8Ul4V
         JVfrzYFZzKvBL8i6ZDDZH6H3rOlSXRc56iFSAvbsbXi59riI5jYGK3akTKSrsmErr/3L
         rxAWXOu46hcqmboR1f1aK4GeJckXcTonukZOWfZs8jNdv1cGw91nHofl+lXy8bFjEqmN
         j3tA9he2fixBEaLwxstJpyNbX0evnrPvVY1KrLt+BS4kr34o8Olnti7/MCLhB4E9PczS
         PhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=PmfbmDEwWXL4BvaLDwT2z4rZRjeL8v9u316orBCGPsE=;
        b=rIxM1pL7M2b6df9z33C6Fz8VT06oW91lWiRH59OpH1c4/0AvN/WU9tzqmO5/awGqGa
         85Ddm96Y7Z25ZLoczm98U7Q6ovZW97UmpQ6AJIRxTv50ukABP+ugDz3ktaTp6dBF46rb
         Og3Z19eEROgQ3cMiwW/9QOzToyyspl2d1xFRWGo2+pzT2aL3OJoOqP00oVHu1NJcpqi6
         gB3RRbNGIKb4aL7o3ZPSU/xKPWSZW4Gd2x8eTRbwrdwVRVOSov68mVM90ZpsgYVTixiG
         WLSNfiR1jHpZcu0jl4i5H6GGbj/VC5D9dnL4ItpqrOseraA0YPv1XsKJSrACuwFVm7FS
         kGUA==
X-Gm-Message-State: AOAM5332MahYu7pL10+r15jhXAV4DX6qn0RWfEzDP05ToTFKaaHgKlzM
        RzCDXGFaYB9Ob8GugmpcvG/96tOX
X-Google-Smtp-Source: ABdhPJwJ5w0FMyPpjzMetGcGvVQO5ReWFBlW0ncrsM00xH/mx+qxCMHrGJdo8aivZzXQmO2COCyivQ==
X-Received: by 2002:a37:64c6:: with SMTP id y189mr4300125qkb.353.1590589281745;
        Wed, 27 May 2020 07:21:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:74a])
        by smtp.gmail.com with ESMTPSA id w13sm2750212qtk.66.2020.05.27.07.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 07:21:21 -0700 (PDT)
Date:   Wed, 27 May 2020 10:21:19 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.7-rc7
Message-ID: <20200527142119.GJ83516@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

* Reverted stricter synchronization for cgroup recursive stats which was
  prepping it for event counter usage which never got merged. The change was
  causing performation regressions in some cases.

* Restore bpf-based device-cgroup operation even when cgroup1 device cgroup
  is disabled.

* An out-param init fix.

Thanks.

The following changes since commit 87ebc45d2d32936fb1c8242032eb0b9bcd058858:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2020-04-09 11:04:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.7-fixes

for you to fetch changes up to eec8fd0277e37cf447b88c6be181e81df867bcf1:

  device_cgroup: Cleanup cgroup eBPF device filter code (2020-04-13 14:41:54 -0400)

----------------------------------------------------------------
Daniel Xu (1):
      xattr: fix uninitialized out-param

Odin Ugedal (1):
      device_cgroup: Cleanup cgroup eBPF device filter code

Tejun Heo (1):
      Revert "cgroup: Add memory barriers to plug cgroup_rstat_updated() race window"

 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 +-
 fs/xattr.c                            |  6 +++---
 include/linux/device_cgroup.h         | 14 +++++---------
 kernel/cgroup/rstat.c                 | 16 +++-------------
 security/Makefile                     |  2 +-
 security/device_cgroup.c              | 19 ++++++++++++++++---
 6 files changed, 29 insertions(+), 30 deletions(-)

-- 
tejun
