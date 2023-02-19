Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8987369C35E
	for <lists+cgroups@lfdr.de>; Mon, 20 Feb 2023 00:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBSXZ4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Feb 2023 18:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBSXZz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Feb 2023 18:25:55 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45A61A96E;
        Sun, 19 Feb 2023 15:25:53 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o10-20020a17090a744a00b00233ba727724so1271840pjk.1;
        Sun, 19 Feb 2023 15:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TVsbXUpnD9I9/F1PvXMGIEd9MiHz9LD4rwNzvGPEVYo=;
        b=RfltPZ9lK1PJDPSiB2nr1+OyTnFqPHeFURn46UrC4hgv+pd4AFDf1epKZEXn3Yk97y
         L8XFxJkekyn6fwf+aBihZHmAHNQ4gSit4MxvGU4tyE5KVOsvdF/9rRu8n5Y9ZVyzlMZ7
         jgvlHr/bLgAfbRRQqFoPYgzLvZCe8hlItXbpg7qVrLA69l0Jth0NeyinmWgil6aMuSQG
         q0k6yYfk+Ul7SqUOoX1vJj9B2lX8p9VPOS/mMzSoxKCBgZQAjVW1QD/FbQ5Fv5PsrKm4
         3dS8PNplovpOiBnj/HyPEWtBG5nQDC1puEjxKz2AXQpcM5r/53Gsj4BStYXOf3OWztjk
         3sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVsbXUpnD9I9/F1PvXMGIEd9MiHz9LD4rwNzvGPEVYo=;
        b=26Jf2nu8g10mPJDstIy1qFcPA8ZjNm7e4e3NS44qQiGBrW41jLg20oI45lfEKRgrbt
         zFpcGYY2JpRTt2iyFc2Y3QMulNI8p5wDBjOxmRF46O+rbuQoGcUm8/ogUFxwPJ44R1Lx
         7Kwp40/+4O9Bw5R5brWWcS9R5Vgl4nUTgXYV7fRHQnm4pGDbagDgbvyMjWUbUFf8oz6d
         J+UmewIk482tQgdbASWST2cyYMLMuEM8OAcKAhz4bKhsYQvs1sYL5xZTM9Ziw0UXT/lX
         gnKeHnbhC4Rd6QN8pQ3JNVRZJKOrlOnBkLCOtiViujHgsewjFsHlBEAj3Ooef/ctkka9
         dkUg==
X-Gm-Message-State: AO0yUKU8kkh7sNy7s/6XBKbDMgwk4gcJTHry7LPZTMbCOT1RgHum7Nwh
        cCLA0Ruv1Sn5EU/BxQMn6xM=
X-Google-Smtp-Source: AK7set/q3JgqHfJI0JNmKuaOZQCLc1pcYvFOF4FjvmsGQn/LqSCH7ggi9iwaZJtjDO1ZvksVGZw3ZQ==
X-Received: by 2002:a17:90a:1917:b0:234:5e7d:6d27 with SMTP id 23-20020a17090a191700b002345e7d6d27mr1885739pjg.42.1676849152891;
        Sun, 19 Feb 2023 15:25:52 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id nn7-20020a17090b38c700b00230befd3b2csm492375pjb.6.2023.02.19.15.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 15:25:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 19 Feb 2023 13:25:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v6.3-rc1
Message-ID: <Y/Kv/v/zdeHfwgcc@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following changes since commit 512dee0c00ad9e9c7ae9f11fc6743702ea40caff:

  Merge tag 'x86-urgent-2023-01-04' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2023-01-04 12:11:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.3

for you to fetch changes up to 32a47817d07557ffca9992964c514fd79bda6fba:

  cgroup/cpuset: fix a few kernel-doc warnings & coding style (2023-01-10 12:28:17 -1000)

----------------------------------------------------------------
cgroup changes for v6.3-rc1

All the commits are trivial. Doc updates and a trivial code cleanup.

----------------------------------------------------------------
Bagas Sanjaya (9):
      docs: cgroup-v1: replace custom note constructs with appropriate admonition blocks
      docs: cgroup-v1: wrap remaining admonitions in admonition blocks
      docs: cgroup-v1: use code block for locking order schema
      docs: cgroup-v1: fix footnotes
      docs: cgroup-v1: move hierarchy of accounting caption
      docs: cgroup-v1: use bullet lists for list of stat file tables
      docs: cgroup-v1: make swap extension subsections subsections
      docs: cgroup-v1: add internal cross-references
      docs: cgroup-v1: use numbered lists for user interface setup

Daniel Vacek (1):
      cgroup/cpuset: no need to explicitly init a global static variable

Randy Dunlap (1):
      cgroup/cpuset: fix a few kernel-doc warnings & coding style

 Documentation/admin-guide/cgroup-v1/cgroups.rst |   2 +
 Documentation/admin-guide/cgroup-v1/memory.rst  | 284 +++++++++++++-----------
 kernel/cgroup/cpuset.c                          |  15 +-
 3 files changed, 162 insertions(+), 139 deletions(-)

-- 
tejun
