Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7A63D69D3
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 00:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhGZWMA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jul 2021 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhGZWL7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jul 2021 18:11:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D25C061757
        for <cgroups@vger.kernel.org>; Mon, 26 Jul 2021 15:52:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i1so13484044plr.9
        for <cgroups@vger.kernel.org>; Mon, 26 Jul 2021 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WqhFWoemQOi+naKM/w3DU5/DczHPjUx7VB4ssERw9O0=;
        b=CmcfVHMcIfbv90YU4RtOSEiZoB4RSr8IIZYy+fVwQ2tjCJLyEB5KvFVLo1foAV+m2y
         X5FIplATb2u6CIK8LQj7HgS299Hd+JLtia3Ub3BEe3CfGP6JfRQPlA76tvA1qLU5iKvH
         7xxmwLEmQNyQhOhYCR2bWGBQzmyv7dLL0nNWeUONKIu0ajEyXjFU6sDz1S2Qf+Pdd7LF
         FWDfeGBs+d94RwNRVbqMne5OyOZVA3cN2XlAklAunqL1MGBbl7aY3GsWw74dahJf+wZF
         M6rTFgp8ODmDaG3K3WscHIo1psscyymiIG5Rmd0AnXLF9Wa6Wgm3PNPATsTqTmqYMDDN
         9mUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=WqhFWoemQOi+naKM/w3DU5/DczHPjUx7VB4ssERw9O0=;
        b=Ytpx5HCDSa6F7zA61kSxpdQap2cgTZmGfKebSeGJxF3OnJVmjDU44oEA48f+lly6iF
         NSYU2wDMxgLJ8pDKAH2cBY/skJBxKc0EUUkmHxK9un9VehmNdoSq5CIkUfimTC0c9CeR
         EbNBwS1WRwNuKKd7yYZioAhYfv6yb98kL6MlTrfl0DFQAvapfoCUj/E74StOCynTSmvS
         B8YKpvVbgNFxfYTG8Ak9GhjLqa5uGBicKLYVWrebpNXi4agshd2zcynEjLhxMlMdOWvq
         baNBNakaaJTZiuMAUupfgyw0QtoLVRQfgRqMFcRmiQpE5s4+HUY+vwBgvoXJ5nhRoDp/
         8LrA==
X-Gm-Message-State: AOAM533VDTjuUaC/qLH3y0JvcI2cA/bcFCBJpa8ry3wQ7h5LTFDjkoBM
        7SS3rJ1ymYvwgxiniQDrbCrEYvOh7DU=
X-Google-Smtp-Source: ABdhPJxBQ0fc+vSLqe+vWtr/HFbkJSFRkiUf9P07KJ6kWZeej764Fox/OUwalgRf+2bg26agVJ4ntg==
X-Received: by 2002:a17:90b:514:: with SMTP id r20mr6969110pjz.80.1627339946510;
        Mon, 26 Jul 2021 15:52:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:428])
        by smtp.gmail.com with ESMTPSA id m19sm1121064pfa.135.2021.07.26.15.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:52:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jul 2021 12:52:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.14-rc4
Message-ID: <YP88pSEKctnQe2v2@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

One commit to fix leaked filesystem context root bug which is triggered by
LTP. Not too likely to be a problem in non-testing environments.

Thanks.

The following changes since commit 8cae8cd89f05f6de223d63e6d15e31c8ba9cf53b:

  seq_file: disallow extremely large seq buffer allocations (2021-07-19 17:18:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14-fixes

for you to fetch changes up to 1e7107c5ef44431bc1ebbd4c353f1d7c22e5f2ec:

  cgroup1: fix leaked context root causing sporadic NULL deref in LTP (2021-07-21 06:39:20 -1000)

----------------------------------------------------------------
Paul Gortmaker (1):
      cgroup1: fix leaked context root causing sporadic NULL deref in LTP

 fs/internal.h              | 1 -
 include/linux/fs_context.h | 1 +
 kernel/cgroup/cgroup-v1.c  | 4 +---
 3 files changed, 2 insertions(+), 4 deletions(-)

-- 
tejun
