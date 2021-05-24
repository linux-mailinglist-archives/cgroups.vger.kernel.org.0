Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746BC38F271
	for <lists+cgroups@lfdr.de>; Mon, 24 May 2021 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhEXRpH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 May 2021 13:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbhEXRpG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 May 2021 13:45:06 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D914C061574;
        Mon, 24 May 2021 10:43:37 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v8so27830727qkv.1;
        Mon, 24 May 2021 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zhwu1FpE2bEhuHjrue2EKzTEGamwY+6jfsv2dbB3NtU=;
        b=Qq8H9LT+STnb034ptJPGiLU1qZiDizsNroHu0Q4/azITwgPsDeywMkF3Fs4d258r9m
         sPdmfsrXp4/lo5So6kExMrd+2oTlTbAbok5ESbCabR6bueqbDfO67dVqABNBX4/egmSg
         IGzjMqM0S+sdarQH8iPlFOcWnPCw4sEV6ON+mn0ncvueRz31Ib2xQetWauH1/ks3oaQn
         R4mBmm41kibxqyMqQ6OUeesGUzYckoA/5R5vaZPSVk2mp95uiSC/SsgYG3sqkG/0ftNn
         Z6d67EsRB2Et2dwQ3sxlwlZ6VgcROVB+AnQ4hi6JlxtBBbK/983MSE8lMcY5pfL42amB
         zqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=zhwu1FpE2bEhuHjrue2EKzTEGamwY+6jfsv2dbB3NtU=;
        b=I064tvu055cLTR0RgTu+Q2/xryvksU3O6y8Kv01st3/ovQF47p2J0FwiS9KQ8cpYZZ
         nQcNhe7dwRpG6FJYIgcw+OuY8Tdm8JAsy5qQ57qu1FBmYdNoWg5z2XBg/dydhk4jbnBl
         VvU27AqoiOJcHjJlr87ymigjzxy1vyFtEWFG4cO8N8tpgqvviJEkFvSdLEPkXz9NMtp7
         1oEsnEbBbVSxsv1JnK1ApYw83wNpyeO6vEWhRNHMtRlDw+mfVTty8545CkcpLiOLtATi
         OgWHv1d4kq88NSOdKE32nnlIEJHx+7p6PbSYfM5vXA1tEQNnO5JagQEKV+1LpfnHVbP2
         6XaA==
X-Gm-Message-State: AOAM533XsC4iYAiCR2cAZTkCUegNaz5Vf1ZeyE8oXzow4nxHvwjXQXbN
        80xlcdVcEnpDXfOg/zhsKoI=
X-Google-Smtp-Source: ABdhPJwve3MNWYzDr9X9ixbSfD8MfMeT+qv4t3HaQv9JSyCzNQrtOq49juZpXxr9pWODbNxBlICIWg==
X-Received: by 2002:a37:ef08:: with SMTP id j8mr28500818qkk.24.1621878216188;
        Mon, 24 May 2021 10:43:36 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id j15sm9208538qtv.11.2021.05.24.10.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 10:43:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 24 May 2021 13:43:35 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.13-rc3
Message-ID: <YKvlx7PZs6EplU1D@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

* "cgroup_disable=" boot param was being applied too late confusing some
  subsystems. Fix it by moving application to __setup() time.

* Comment spelling fixes. Included here to lower the chance of trivial
  future merge conflicts.

Thanks.

The following changes since commit c3d0e3fd41b7f0f5d5d5b6022ab7e813f04ea727:

  Merge tag 'fs.idmapped.mount_setattr.v5.13-rc3' of gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux (2021-05-19 06:12:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13-fixes

for you to fetch changes up to 08b2b6fdf6b26032f025084ce2893924a0cdb4a2:

  cgroup: fix spelling mistakes (2021-05-24 12:45:26 -0400)

----------------------------------------------------------------
Shakeel Butt (1):
      cgroup: disable controllers at parse time

Zhen Lei (1):
      cgroup: fix spelling mistakes

 include/linux/cgroup-defs.h |  6 +++---
 include/linux/cgroup.h      |  2 +-
 kernel/cgroup/cgroup-v1.c   |  2 +-
 kernel/cgroup/cgroup.c      | 21 +++++++++------------
 kernel/cgroup/cpuset.c      |  2 +-
 kernel/cgroup/rdma.c        |  2 +-
 kernel/cgroup/rstat.c       |  2 +-
 7 files changed, 17 insertions(+), 20 deletions(-)

-- 
tejun
