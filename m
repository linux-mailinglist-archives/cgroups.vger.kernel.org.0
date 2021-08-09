Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238BB3E4FB2
	for <lists+cgroups@lfdr.de>; Tue, 10 Aug 2021 01:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhHIXCW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Aug 2021 19:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhHIXCV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Aug 2021 19:02:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC24C0613D3;
        Mon,  9 Aug 2021 16:02:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so2379616pjl.4;
        Mon, 09 Aug 2021 16:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FIJq4ZNboXbfq5kIKSzg2GS0ml9Miy3RL/9vBFSXcYI=;
        b=BqY7udQeB6Iv9m++WzDq2lkKT1nZFRQJDUQxx+PSSO7nDEv8wlnFFTtm0sxwHaYsFO
         znYWcD776guDJPii/afFvx/fvo81dqYw21icscwKZKnrEN5e76HdqjHTWMaipCXjvTgw
         jYzPAnZij1Mp3ufJAwBoTU2jaJr3kcL9mqWltHWIiF0Ix7NJ6su97oINNZC+Clm1shHc
         miSm9Rlzj0g8oUB1EA0wufvM4Tm5qIUHQK1YzLigveqBJcfSJmWNswkFn595xgCOfyXy
         FGPxEUL15GUvozGfYLQtPhEmxgNAGyeZFkaOvmnSBVKMaf/niSWJGDeq1r0bctmS6JgS
         Gl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=FIJq4ZNboXbfq5kIKSzg2GS0ml9Miy3RL/9vBFSXcYI=;
        b=S3VWiqwrsd3yIQSKT4pXysi/2c5m9M+Efo8GsuDUEvUuHnFb512MBvh3kOVXyDY2lt
         d+UngFbWfza9FMd4GngErASKx0AcQfMJzg34wv4dX1ifmVpfrTz1TYg7w4AHwZvegJX5
         ntiuA7oSjwWsANAAd6UvsEyG+UdhDWOZfZZ5LHdlUzKbLSyXyi3r0LZYPEyujpJtnLbm
         KqdAtVTfJOrsXVzzIXC4vjxEOGZOQp7bJfys4mSXQn+DH4EqW/au/lLiLpgAOjt77rXV
         NW6yfgXm/33GT6ob79dh9+y00XWZhLGqgcM7Ro40zcGkmBifk6wvnqY+Wqe/V3KR6lt+
         5A2w==
X-Gm-Message-State: AOAM531MviTkAQE4KMYQxxmZDX16Tan3+wxJ+dqaJPZ0MSvnVUcM3/u+
        UsVP7dVxk1QGUvshJ2I5mF5vfn/sFlW3tw==
X-Google-Smtp-Source: ABdhPJzOd0gJy9Fo/ZAHPENEsMue6HHO1OKM69bk2lCnAxRo0ItuJqWGKhsahrRQTdQFfk6XlWd46g==
X-Received: by 2002:a05:6a00:a0e:b029:3c3:538:b4b8 with SMTP id p14-20020a056a000a0eb02903c30538b4b8mr20166465pfh.25.1628550120256;
        Mon, 09 Aug 2021 16:02:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df1c])
        by smtp.gmail.com with ESMTPSA id pj11sm568869pjb.4.2021.08.09.16.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 16:01:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Aug 2021 13:01:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.14-rc6
Message-ID: <YRGz4nmDZNhsKSr1@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

One commit to fix a possible A-A deadlock around u64_stats_sync on
32bit machines caused by updating it without disabling IRQ when it may
be read from IRQ context.

Thanks.

The following changes since commit 1e7107c5ef44431bc1ebbd4c353f1d7c22e5f2ec:

  cgroup1: fix leaked context root causing sporadic NULL deref in LTP (2021-07-21 06:39:20 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14-fixes

for you to fetch changes up to c3df5fb57fe8756d67fd56ed29da65cdfde839f9:

  cgroup: rstat: fix A-A deadlock on 32bit around u64_stats_sync (2021-07-27 13:12:20 -1000)

----------------------------------------------------------------
Tejun Heo (1):
      cgroup: rstat: fix A-A deadlock on 32bit around u64_stats_sync

 block/blk-cgroup.c    | 14 ++++++++------
 kernel/cgroup/rstat.c | 19 +++++++++++--------
 2 files changed, 19 insertions(+), 14 deletions(-)

-- 
tejun
