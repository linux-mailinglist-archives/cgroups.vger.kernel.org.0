Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D295D429947
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 00:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhJKWFA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Oct 2021 18:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhJKWFA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Oct 2021 18:05:00 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26BEC061570;
        Mon, 11 Oct 2021 15:02:59 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r2so11998751pgl.10;
        Mon, 11 Oct 2021 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HAdOW08pUGdUyMrTZxurTqi+ppgklE5YNPt3pyK3J9Y=;
        b=msXhSiuDh0TAfFpXf7otQ4GKX/jL9A3xSgn0ohRua33XqhiKTEwLRhyXaaueECwKeh
         4FOUyz1OrCpiS5KlUDb60Fu6L6I6GWsAa5Jy7GHfcEwv7mX56CD9H7gb67LydZKqqWEx
         za2+mtS2MGrNocBbyNpxOVnStZpVkJgnrrmsDBkSs48INoZuBgggWkJ9eyDXpK9IYlro
         nzJAiTLGR0Fl1kFLb9qK0JRfQPZBIYKbz0A2CZ4+vLHrmGdyro1qFIIBkArE/oMY/1Vt
         mTdsTFmBnul1MsYiC3UAp7E6aP39tFgn1trqg1mvD/xViQu2F++i95WG7e8AnGJgrrKL
         kz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=HAdOW08pUGdUyMrTZxurTqi+ppgklE5YNPt3pyK3J9Y=;
        b=PYU/5HkmPYu4lEMIP9BlJxTPCkvYd7VXBUCTyZJrC0oE2fiitA2piNdQiCFb1V2nBw
         zz11J5uNfXYv2+qOe9QSx/rpQXY2dxlaHNVQpEH0omonn9W2SFLsugq7SczL5IVOXcRb
         g31F7pYwUNaroEWu+Q6RR9fR5THhFNoibUwZ/87u44U/cZliT1dxg955OB9FUNaVE2ug
         5JrXGlYC9/d2RSjlnHDcuLmvnQ4RAUee+NsNbIcI+T+7/V8xAWdoGRoN+fD6baSZTGIH
         dnCiJ0SYa9kta071ZUMI5YRPt3/sagjJJ0caxYrcKJCsPT6oUsRIpmJbUdygc9ok/9/P
         zoQA==
X-Gm-Message-State: AOAM531Rox6wbEIGgWCo3C5+Xm1POrjjvRkcF0I+hHzSIOJd7V0ItfLL
        PozA6jbbSjZ7CmU90LcoOiHBGv6/U9/DnA==
X-Google-Smtp-Source: ABdhPJxoDWg9cFb9RgY3a20u4GeVDtZnuvVfU/kd/9eocrlurCJJTcBSjp+wYZswBh5gEsV7aC7l4g==
X-Received: by 2002:a63:5608:: with SMTP id k8mr20176424pgb.287.1633989779234;
        Mon, 11 Oct 2021 15:02:59 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id a7sm8533717pfn.150.2021.10.11.15.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 15:02:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 11 Oct 2021 12:02:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.15-rc6
Message-ID: <YWS0kcEY3MmKrZJk@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

All documentation / comment updates.

Thanks.

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.15-fixes

for you to fetch changes up to c0002d11d79900f8aa5c8375336434940d6afedf:

  cgroupv2, docs: fix misinformation in "device controller" section (2021-09-13 08:08:46 -1000)

----------------------------------------------------------------
ArthurChiao (1):
      cgroupv2, docs: fix misinformation in "device controller" section

Chunguang Xu (1):
      docs/cgroup: remove some duplicate words

Waiman Long (1):
      cgroup/cpuset: Change references of cpuset_mutex to cpuset_rwsem

 Documentation/admin-guide/cgroup-v2.rst | 28 ++++++++---------
 kernel/cgroup/cpuset.c                  | 56 +++++++++++++++++----------------
 2 files changed, 43 insertions(+), 41 deletions(-)

-- 
tejun
