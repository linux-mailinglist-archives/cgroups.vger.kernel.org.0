Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28F489E9D
	for <lists+cgroups@lfdr.de>; Mon, 10 Jan 2022 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiAJRqf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 12:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbiAJRqf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 12:46:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6CDC06173F;
        Mon, 10 Jan 2022 09:46:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id pj2so13119756pjb.2;
        Mon, 10 Jan 2022 09:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=u0Lz9mY57BVHXdIMBERfZvaxhsfkpGuYaUsYOCfAqn4=;
        b=HBqm+po5ZDE4m9WK5MHhyaEMItwNlLIeyMV1c7FLlZsx7PUl5fGzHZp8kVP5Uk1AFB
         O1BdWT+L1Fim/dmH2UqJ4EmUfjpQAk/vZaNt4QndUakC9B0uJYDzoqoH1FTyGanOg6u9
         UbfWpo8GaxVrJ2fIWJqSSinar/9MCGj15+VsZ6TCT0X2rZXToBXeSwhD/r3eFsjpPlId
         CS9XXvUGvbojTmrr1+vbOyd1/OVPRmnsn5enhZ+MWWfkxo421RsVTYdXgsVFzUgblGcQ
         qr9fd4d2G2C8oOituQ2JRaTHG6F3icDyqiuey9ISO7OnW562CNuq5u8PVezwn0QTrsKX
         tw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=u0Lz9mY57BVHXdIMBERfZvaxhsfkpGuYaUsYOCfAqn4=;
        b=5+Ff9PkAHa+mOXgq+28HAlKiB1CxqChpaHitFAwqsBuHrzLTKw2JKZ7PQbCv37Gbn3
         L1wzhVEVJHhlPJUJBCtYAX+DYNjXjSjWfyg91T9gNFn2BeaTywOspeXWMQXR0j6lMtQ9
         aq8hvtq+r02SSSAN+haIPlRAqJSBF2wcZgUSfojTq+vc93MSBucnR+4PFx+SNmp7D3f/
         tV/9TsquFRl+/wWl1ds+6mGWuUl2GX05V4LlDXRWcIDSrymF7n6fAF5E+f/asNFiWgeb
         rbtnrHxz2LrIFydcdC3EPCVp0SL94vW2ZCyMSNhMw//EnPxNecczwA4iK/8Q5bEmgQA2
         09DA==
X-Gm-Message-State: AOAM5325iFEVWu5PGlnr9lzryAYYas87yE7Pb5xIRyutNQ20vjS/fXio
        cD53YZ6N+6+EMrxLHwVLNeM7zg3LqkGQLA==
X-Google-Smtp-Source: ABdhPJzkgDLPlSxtzXdf8n+xfuIH4EpoaFP+eDpFUdf67iiuV6UCCpGhiYmRCzhMac5/bnD69ySU4w==
X-Received: by 2002:a65:5808:: with SMTP id g8mr688104pgr.91.1641836794455;
        Mon, 10 Jan 2022 09:46:34 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j3sm7926800pfc.196.2022.01.10.09.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 09:46:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jan 2022 07:46:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.17-rc1
Message-ID: <Ydxw+LLhEmi5B/Re@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

Nothing too interesting. The only two noticeable changes are a subtle cpuset
behavior fix and trace event id field being expanded to u64 from int. Most
others are code cleanups.

Thanks.

The following changes since commit 8ab774587903771821b59471cc723bba6d893942:

  Merge tag 'trace-v5.16-5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2021-11-14 19:07:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.17

for you to fetch changes up to d4296faebd337e5f76c0fddb815de33d2b0ad118:

  cpuset: convert 'allowed' in __cpuset_node_allowed() to be boolean (2022-01-07 12:05:52 -1000)

----------------------------------------------------------------
Michal Koutný (1):
      cgroup: rstat: Mark benign data race to silence KCSAN

Qi Zheng (1):
      cpuset: convert 'allowed' in __cpuset_node_allowed() to be boolean

Waiman Long (1):
      cgroup/cpuset: Don't let child cpusets restrict parent in default hierarchy

Wei Yang (5):
      cgroup: get the wrong css for css_alloc() during cgroup_init_subsys()
      cgroup: fix a typo in comment
      cgroup: return early if it is already on preloaded list
      cgroup: rstat: explicitly put loop variant in while
      cgroup/rstat: check updated_next only for root

William Kucharski (1):
      cgroup: Trace event cgroup id fields should be u64

 include/linux/cgroup-defs.h   |  2 +-
 include/trace/events/cgroup.h | 12 +++++-----
 kernel/cgroup/cgroup.c        |  6 ++---
 kernel/cgroup/cpuset.c        | 16 ++++----------
 kernel/cgroup/rstat.c         | 51 ++++++++++++++++++++-----------------------
 5 files changed, 38 insertions(+), 49 deletions(-)

-- 
tejun
