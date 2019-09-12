Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07430B15BC
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2019 23:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfILVLy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Sep 2019 17:11:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:47075 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfILVLx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Sep 2019 17:11:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id v11so31293851qto.13;
        Thu, 12 Sep 2019 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ft1lXaFWyeFaR5dQq95+R6LQSsO9+rjJoCxsIQDK09Q=;
        b=ieuj2Q4AeufUufy5S/GjvLZqVEpSa2IqXOab6R7dw+TPfduNg/yvHq0tl5qtqN0aKu
         S0Fx69ForISDBKoqDSgnU+Ex84zoIn6OicdJHOOhJfaN9DpJhK8OQ8WlNWst6zNANSkE
         uz06s7IH1hnkNgtVos8xsUrtLpW1alGkANMSxzQwJikaxvOm328tMWkt5q/ckCJSeW2R
         tE8OFY85hlXCYtYKqnIT9SUAM0Pcjd+igwUe9qIHEbjEGkiPA6Q/+niXtkBsb8oQYYKh
         c97G6DGolDXJlzzSulLh/aVSPaV7e5fCXSMlHdZBsu+PHA6+WRDQMnP8v5BH1IUP6rEI
         QvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Ft1lXaFWyeFaR5dQq95+R6LQSsO9+rjJoCxsIQDK09Q=;
        b=MbqZU7o+AdKNES9AGtMiUMqHmmEObxGoCbp4MqlRqWCWeZF0cMHgKLt6r/3i9/MFWy
         jXPegICu8wbi0B10p+louHNTW8bxXIA7Xoeu44a4z2uFBh+EoTFAVhx77qrecwmfxu3x
         taQIm+0kDyC9gJkm08rDQoCE/ZsAMNfrjRbhdALR6K/ep4HzljYvGDTlTg4D3bdebKgb
         tGkyP1CrXeXZxaSmfHsbMdUQfgBPo5zJ6KobStQhZaRPYwwR7khly0pZCdcIcIABx6n2
         Btj88368+8fhOiD5KusG8gOsndJgY+C3VdSraA84gH0AXmdU1LK3zaU7slgNK/nIG1Xl
         kfCg==
X-Gm-Message-State: APjAAAUDo9K2/gtGT799Er6OuPv1+ENp7DO19ztgjrECuoXlhBJO61DY
        8BKjd4otqyigT72tixgOaV4=
X-Google-Smtp-Source: APXvYqyFV6GzAFsdhGFZvs4PQNzbuUrE2sTzZ2hjhIXeRQdicNaWlF0F1IcyXsbSfuPbVGxUKSKXtA==
X-Received: by 2002:ac8:2b29:: with SMTP id 38mr44390498qtu.188.1568322712544;
        Thu, 12 Sep 2019 14:11:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::12af])
        by smtp.gmail.com with ESMTPSA id 8sm10128044qto.6.2019.09.12.14.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 14:11:52 -0700 (PDT)
Date:   Thu, 12 Sep 2019 14:11:50 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: [GIT PULL] cgroup fixes for v5.3-rc8
Message-ID: <20190912211150.GB3084169@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

Roman found and fixed a bug in the cgroup2 freezer which allows new
child cgroup to escape frozen state.

Thanks.

The following changes since commit 505a8ec7e11ae5236c4a154a1e24ef49a8349600:

  Revert "drm/i915/userptr: Acquire the page lock around set_page_dirty()" (2019-09-12 14:55:03 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.3-fixes

for you to fetch changes up to 97a61369830ab085df5aed0ff9256f35b07d425a:

  cgroup: freezer: fix frozen state inheritance (2019-09-12 14:04:45 -0700)

----------------------------------------------------------------
Roman Gushchin (2):
      kselftests: cgroup: add freezer mkdir test
      cgroup: freezer: fix frozen state inheritance

 kernel/cgroup/cgroup.c                        | 10 ++++-
 tools/testing/selftests/cgroup/test_freezer.c | 54 +++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

-- 
tejun
