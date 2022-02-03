Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D77E4A886C
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 17:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiBCQNf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 11:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiBCQNe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 11:13:34 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D88DC061714;
        Thu,  3 Feb 2022 08:13:34 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a8so2619507pfa.6;
        Thu, 03 Feb 2022 08:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=uOJP/dHIjrt3Mk14YimQ7oK5vd7nsEQbU3Iru0dLJMs=;
        b=DctRaEel5LO3as8bp8Q61ufK6PmYwfRynGpoS9S0XFEZDYYnIvtW5bLY+wBWVVI1pX
         xt/CFxBrzuvUFyGTTkuJCSbVDUvkUANCQuSpKo5YiAoNeiL9X2IcJB3jxTlQ3aTD/EBy
         suVMO53T83SDzqZF9CXZRS1wDrXInC6sU01MR99dATKQSO1puIbKbwJk7c0d2l8Tl9mK
         keVyFE3lpmOedsoGf25+HK7KhvAlouycn9FFw9CAvWwqnA5V9DN4DC2Uk4DALP0xw0q6
         6IfDFk5Hnz4ZW1LmvdYJI5VUWskhDW/g6cE0zkZahFVCXGLEmm6LRZMIGdxdDwbD0Sjk
         MO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=uOJP/dHIjrt3Mk14YimQ7oK5vd7nsEQbU3Iru0dLJMs=;
        b=CTMvbNY+VsLlpPt7MWQu2i4iPNbmAFxnFCaqxNAsD3b6MuP2JQsEvIRMh+5MhPgpAs
         eFoq3g2RK9QX833mGn0t/57sMBDi2kBic5ekjIkXvbjtlv438blMb/lHUIl9NGLmU3jT
         A6w/UnnGK2c0MWItb8SD7qFUsnMNhuQBgkeFGVYbl/TYEcGTEZyDJ6BPEs+7fkqMeHWi
         gbeqmpgDKx7tatPmv22/uHLwBGWEoYPYU6900RLeECkj23703N0SA6z/NAd9xsbLxSm4
         Tqjfc6/REyjc+1tZOgZAHaLd3GZY5Q4k98gwmQ6SIXOfNVAKrgXmR6Bzr1lDQvFnxzur
         N/Gg==
X-Gm-Message-State: AOAM5334t6GEhff4m68r0AZFkx8hb6WHC9xQwEcYYpmKPHNiIxfluPrk
        eTs29QvkCnlm51/sIMgYhNNTE43fKiA=
X-Google-Smtp-Source: ABdhPJzY6Iv7v1e0alBuGwqkZCEeCsz5lA4sryOjz8JZ28oyXPewdL6g3T5H3YgRcXngVBco+P3BdQ==
X-Received: by 2002:a05:6a00:1a53:: with SMTP id h19mr34733463pfv.65.1643904813831;
        Thu, 03 Feb 2022 08:13:33 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s30sm18551263pfw.63.2022.02.03.08.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:13:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 3 Feb 2022 06:13:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup fixes for v5.17-rc2
Message-ID: <Yfv/LMxqHSa3s5YS@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

cgroup fixes for v5.17-rc2 including:

* Eric's fix for a long standing cgroup1 permission issue where it only
  checks for uid 0 instead of CAP which inadvertently allows unprivileged
  userns roots to modify release_agent userhelper.

* Fixes for the fallouts from Waiman's recent cpuset work.

Thanks.

The following changes since commit daadb3bd0e8d3e317e36bc2c1542e86c528665e5:

  Merge tag 'locking_core_for_v5.17_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2022-01-11 17:24:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.17-fixes

for you to fetch changes up to 2bdfd2825c9662463371e6691b1a794e97fa36b4:

  cgroup/cpuset: Fix "suspicious RCU usage" lockdep warning (2022-02-03 05:59:01 -1000)

----------------------------------------------------------------
Eric W. Biederman (1):
      cgroup-v1: Require capabilities to set release_agent

Michal Koutný (1):
      cgroup/cpuset: Make child cpusets restrict parents on v1 hierarchy

Tianchen Ding (1):
      cpuset: Fix the bug that subpart_cpus updated wrongly in update_cpumask()

Waiman Long (1):
      cgroup/cpuset: Fix "suspicious RCU usage" lockdep warning

 kernel/cgroup/cgroup-v1.c | 14 ++++++++++
 kernel/cgroup/cpuset.c    | 65 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 65 insertions(+), 14 deletions(-)

-- 
tejun
