Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FFE487EF9
	for <lists+cgroups@lfdr.de>; Fri,  7 Jan 2022 23:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiAGWen (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 17:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiAGWem (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jan 2022 17:34:42 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5687EC061574;
        Fri,  7 Jan 2022 14:34:42 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f5so6695593pgk.12;
        Fri, 07 Jan 2022 14:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Hajn5l7U97JtfpTs2/PxkmXJPD+Ebo3WEH1DTWrY9fs=;
        b=IsQj6jO9nIti6ZtG5tnTQXikV7zTjNLfa2WWQSxgWIoYWrKvEATCYX4BjSrB13lF11
         /71JjyKKz89vsseqUkFWfGUB9x75XEk5yasllnCh9yBcaP8WrtA8g6jlpcH5zqq/5KY3
         QxV64YzC1oEuc+Sfc/wRK5mkdKv5XbL/RPffB5Nh+QTOFuBVJX8ZsaN8IeWR1pIWCuVQ
         qQ5TBsa48KxO/TPTUmStiaNyDw42Q/xqcaRWFsxTu/kQLqs2fkMklND9WKJdS4k03lTg
         vMzStdl6fpSiyUOk3XGgLErIYhelFo0re3iX2cv/nWdgqn0AJ3FUFDafW1fx3rbLyOdk
         uRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Hajn5l7U97JtfpTs2/PxkmXJPD+Ebo3WEH1DTWrY9fs=;
        b=Ul2bX9+m9k0ravkn06pVaWjeUqPD75izNi8SojM4HkJMDqxPzPWRdemPFOSV8x8krN
         zCXeCOu49wE1nIfJJaR73QUXhrEI+dflyEu1G9U+T43bxkVWRtPG1TTh4+U1ax7vsj7r
         RArSz2jNA6zZV7l+JbanlWlY8F4hq6z/Ncs4c9aMUMo8jXMX77E9ckg2cyrVlSHC9uQT
         7J08983tHpbQpLVavZxQa/fsmq9g8uK+KugyvPaZiEGfSgkvUi128yT4kcwA5s+0qhDs
         mYDDLbx1aAWMrxnjwQFomT4VFere89gxILqzdw7zlWWNPTxm4Vwv5gAmPxwfKtxu3ggt
         8gxw==
X-Gm-Message-State: AOAM530HIyJd0LhgXLRr/MFsL6kA0RXYKm6gSkx6oEcbn78pZH5SyJFU
        q7olmrDv+KghGoLx1ldWWKlaNsIAVCyniw==
X-Google-Smtp-Source: ABdhPJwNFP28998exn86X98TlnrRjOP11pUelKWH34INVylajcgEsItEeu/0fsqTJgWVUoHjWNxmKQ==
X-Received: by 2002:aa7:88ce:0:b0:4ba:efec:39e0 with SMTP id k14-20020aa788ce000000b004baefec39e0mr66630743pff.80.1641594881676;
        Fri, 07 Jan 2022 14:34:41 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id e20sm6397994pfd.104.2022.01.07.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 14:34:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 7 Jan 2022 12:34:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.16-rc8
Message-ID: <YdjAAK4AtsUDv5vw@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

Sorry about the late pull request. I ended up staying offline longer than
planned. This pull request contains the cgroup.procs permission check fixes
so that they use the credentials at the time of open rather than write,
which also fixes the cgroup namespace lifetime bug.

While the changes seem safe to me and they tested fine, this is on the
invasive side for a pull request this late, so please feel free to ignore.
I'll include them when the merge window opens.

Thanks and happy new year.

The following changes since commit 75acfdb6fd922598a408a0d864486aeb167c1a97:

  Merge tag 'net-5.16-final' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-01-05 14:08:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.16-fixes

for you to fetch changes up to bf35a7879f1dfb0d050fe779168bcf25c7de66f5:

  selftests: cgroup: Test open-time cgroup namespace usage for migration checks (2022-01-06 11:02:29 -1000)

----------------------------------------------------------------
Tejun Heo (6):
      cgroup: Use open-time credentials for process migraton perm checks
      cgroup: Allocate cgroup_file_ctx for kernfs_open_file->priv
      cgroup: Use open-time cgroup namespace for process migration perm checks
      selftests: cgroup: Make cg_create() use 0755 for permission instead of 0644
      selftests: cgroup: Test open-time credential usage for migration checks
      selftests: cgroup: Test open-time cgroup namespace usage for migration checks

 kernel/cgroup/cgroup-internal.h              |  19 +++
 kernel/cgroup/cgroup-v1.c                    |  33 +++---
 kernel/cgroup/cgroup.c                       |  88 +++++++++-----
 tools/testing/selftests/cgroup/cgroup_util.c |   2 +-
 tools/testing/selftests/cgroup/test_core.c   | 165 +++++++++++++++++++++++++++
 5 files changed, 263 insertions(+), 44 deletions(-)

-- 
tejun
