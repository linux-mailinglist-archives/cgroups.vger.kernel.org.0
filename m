Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACC0601B7B
	for <lists+cgroups@lfdr.de>; Mon, 17 Oct 2022 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJQVqd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Oct 2022 17:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJQVqR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Oct 2022 17:46:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4983E2CC8A;
        Mon, 17 Oct 2022 14:45:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b2so11995173plc.7;
        Mon, 17 Oct 2022 14:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpjDhdEYCevjuzshNCxGyveRGg8J9v5lzGJkYpIm3yo=;
        b=PwfF1qfG7/L22xs/9xUr1w4RjP34Qo/Gja2efbLUE1Vep091V/fXEDwe6ctvoMbo8c
         g3e7Rnysdbf8WgQ8hC86n1iUDvtyKudrI/nvAYZlxINPRhc1gO22EMnvO51aLs+Jvb9i
         x7EzQ1XmFrnH9Zdq/M1Lr4TL3l7mkCOYhioxmL/0d6THKgaJycgj9WpXYzczrKFolWC2
         kb9ew/OwaTvpH/cNwEq6v8mVTupS7OwfX4aEg1YXZcWkkRWytVTgxX+h2e9GiDvQ5qKW
         sm20bt3QYdqPnGAtxVOqIO1Wbp4qI8cQ5yVqqi2VC81MJgj81FhX+ZPbttw/buRsMw4K
         7vRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FpjDhdEYCevjuzshNCxGyveRGg8J9v5lzGJkYpIm3yo=;
        b=dyf9ruhnhhHwJvr7IJzDXU84jKXMqahGZ3lIZBCn3p7BzIDtqXs3K74P8r/3gbx6Cc
         hOM9h0Kh/jSvrY8KFRf1CRMFWzeFrcEUn4Uk5u3SabVHqcmg8TsvaPPesihRJ+wLZH0+
         ehGWHABWKKb7vdd4+wEBBG5xgH/MGNSppeX9H0+HDWDlEWNXJ3+a3o77cHpPgk6HZI2H
         /EJYioTcZX4VGFk5OYX4uJMjLipmILYZk5kVt/Vt32Ghq0FxOh6Pi1CMZfj0SpxuZIVs
         I+1ee6FKr/oMYwCufJwOeDtBGbZHTvKfTSa0SpPxA189bYUbNivU/zHf62Yb/gVu0INw
         4WWw==
X-Gm-Message-State: ACrzQf1Se1b/3BbO9cerpQkbFYqNnYA8pfXNVglUmyNMqdM8bxelnLk6
        /EC6cSwBPizJ0ms9ozymidVkW0opYlye5Q==
X-Google-Smtp-Source: AMsMyM6D6DkXfWvCY9q2OUFJynt+IlcgGHDQMaq4jZoFuRCmOccV5SomLkrAxoGx1d2HyJ4WGNvO/w==
X-Received: by 2002:a17:90a:c984:b0:20a:ac88:d39d with SMTP id w4-20020a17090ac98400b0020aac88d39dmr34918720pjt.13.1666043149141;
        Mon, 17 Oct 2022 14:45:49 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k24-20020a170902761800b001782aab6318sm7077181pll.68.2022.10.17.14.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 14:45:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 11:45:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v6.1-rc1
Message-ID: <Y03NC6GVxT6iPDsr@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following changes since commit 4de65c5830233e7a4adf2e679510089ec4e210c7:

  Merge tag 'livepatching-for-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching (2022-10-10 11:36:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.1-rc1-fixes

for you to fetch changes up to 79a818b5087393d5a4cb356d4545d02f55bf1a2f:

  blkcg: Update MAINTAINERS entry (2022-10-17 09:27:18 -1000)

----------------------------------------------------------------
cgroup fixes for v6.1-rc1

* Fix a recent regression where a sleeping kernfs function is called with
  css_set_lock (spinlock) held.

* Revert the commit to enable cgroup1 support for cgroup_get_from_fd/file().
  Multiple users assume that the lookup only works for cgroup2 and breaks
  when fed a cgroup1 file. Instead, introduce a separate set of functions to
  lookup both v1 and v2 and use them where the user explicitly wants to
  support both versions.

* Compat update for tools/perf/util/bpf_skel/bperf_cgroup.bpf.c.

* Add Josef Bacik as a blkcg maintainer.

----------------------------------------------------------------
Michal Koutný (1):
      cgroup: Reorganize css_set_lock and kernfs path processing

Namhyung Kim (1):
      perf stat: Support old kernels for bperf cgroup counting

Tejun Heo (2):
      Revert "cgroup: enable cgroup_get_from_file() on cgroup1"
      blkcg: Update MAINTAINERS entry

Yosry Ahmed (3):
      cgroup: add cgroup_v1v2_get_from_[fd/file]()
      bpf: cgroup_iter: support cgroup1 using cgroup fd
      mm: cgroup: fix comments for get from fd/file helpers

 MAINTAINERS                                 |  2 +
 include/linux/cgroup.h                      |  1 +
 kernel/bpf/cgroup_iter.c                    |  2 +-
 kernel/cgroup/cgroup.c                      | 99 +++++++++++++++++++++++------
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 29 ++++++++-
 5 files changed, 111 insertions(+), 22 deletions(-)
