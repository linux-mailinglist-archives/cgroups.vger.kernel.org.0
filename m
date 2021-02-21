Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB89A320DD0
	for <lists+cgroups@lfdr.de>; Sun, 21 Feb 2021 22:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhBUVNG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 21 Feb 2021 16:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhBUVNF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 21 Feb 2021 16:13:05 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82160C061574;
        Sun, 21 Feb 2021 13:12:25 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id s10so4586233qvl.9;
        Sun, 21 Feb 2021 13:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=LCUI5qaT8pUqYdarYBDd4M2SdOdGcx4WAwh3rcV5wfE=;
        b=K2xYpI7uhz0ocTvxg1i4Gss/Fjo22LSFsmuhD+/1uZccNj0kMo9XZkOgCFXxi2tT4D
         VMOksXOVCCbE6jmKoavxIN7iR0kN5SQkskoEUqmZbP3q3PkiBwMNTgzZw49p7+J9GqNN
         V92osIH3Ok/wPvBSW7gQHFfp0jAdckcgjmECOC2LrjtmSttm0K8LF1+gkcRVduV7Cugj
         2j4i9E77cSUzKiP3jdbJvEVclicSHNgdmzBqp7PpZHyU4fI7HYfOtHW/FZcjZpvAYOBv
         aWe3S9rkHwuGEenkL8pKw1k4sgAjX5X9ZF7RSsuD17YAvM3BVReJ7VnEGabdiiiexE38
         3vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=LCUI5qaT8pUqYdarYBDd4M2SdOdGcx4WAwh3rcV5wfE=;
        b=oU2y/DvTVj9mVzjlQjbDLdfXpmMqxF6HWIOha6AI3nqWDaWL+YYhWBf1pfReVnJ83x
         UtlhaAB1vkQzaBIBq3EW/noOXjPyYv7k360vI4gZaxODCam0a80LqnUNx8i1W+NuYLcl
         k5JK3KwIJHukLwqlvbkx6iEWch/UuOmNQIKcV/sfDIqwYBzDb7YmTHpRx3EPQXacszEv
         s0I+ojUz6W0E51+UUCWlo1kO6PbqnBSAGyzet8oWXU2f77nMGXM0iX39MTkiFTAM58bF
         ywZjHnHkPokDmCbHAYXFQMMGIDaPenpceIzu/UaHiJTlo/M2JjEBsGKcXxDzRT6RRZWH
         ShYg==
X-Gm-Message-State: AOAM533+US0/mAoKpSk+SI2EUO4MhzDlMsfq+nvLMro/CBPp+uMDMbtv
        utYXjn9r5UA4mp+eUwzQ5Fg=
X-Google-Smtp-Source: ABdhPJzePxikO1oAL/7ATEo4HaTD2bd5/KxsTfeT8uJYvpyJ3CR4Z9QzvVA6NPWw08Hsrs3Rm8TeQA==
X-Received: by 2002:a0c:c488:: with SMTP id u8mr10570635qvi.9.1613941944438;
        Sun, 21 Feb 2021 13:12:24 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id q6sm10860187qkd.41.2021.02.21.13.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 13:12:23 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 21 Feb 2021 16:12:22 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.12-rc1
Message-ID: <YDLMthAFbC6OTeh9@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

Nothing interesting. Just two minor patches.

Thanks.

The following changes since commit b5e56576e16236de3c035ca86cd3ef16591722fb:

  MAINTAINERS: Update my email address (2021-01-15 15:33:06 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.12

for you to fetch changes up to 415de5fdeb5ac28c2960df85b749700560dcd63c:

  cpuset: fix typos in comments (2021-01-15 15:36:41 -0500)

----------------------------------------------------------------
Aubrey Li (1):
      cpuset: fix typos in comments

Michal Koutný (1):
      cgroup: cgroup.{procs,threads} factor out common parts

 kernel/cgroup/cgroup.c | 55 +++++++++++++-------------------------------------
 kernel/cgroup/cpuset.c |  6 +++---
 2 files changed, 17 insertions(+), 44 deletions(-)

-- 
tejun
