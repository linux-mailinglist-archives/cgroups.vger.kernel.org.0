Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719AA73EEA6
	for <lists+cgroups@lfdr.de>; Tue, 27 Jun 2023 00:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFZWaV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jun 2023 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZWaV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jun 2023 18:30:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A88A12D;
        Mon, 26 Jun 2023 15:30:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b7f68f1c9eso18226465ad.2;
        Mon, 26 Jun 2023 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687818620; x=1690410620;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=srYH61jPdlaM0MowCsJN0isuziRw2t+pfv2C6FBW2u4=;
        b=oc1Y9ulu/tTCNJdypcysex6m70Pojpf1VuD3SGuFtEhBKrItjq5TNwCpmusDlTXp/r
         1DsH1GcEp1Q4gNQ7VN8sl6aSwaZk0sPZtwMXgcMg0m49KCn1Gl7x1T64mczVXKBChTrR
         hhrVPwOgH6uNBaIfuk4+lDNAe6bc/SjBU6+TcMryHwEYCuE1YLjaugyWZ7Kan/92bvML
         26L/22Hz4aGiCAizqmv/Ha7m5SqFLhPPbj5m7KX10Q6hZB7XUkjKrE2n2Dl98aq4YYiG
         5hDu7/PUnx1Ym0YFPnx37gSBpUpHSPyxF6CgC0c6ucG6Zj9VHEtSb5nZPkrfHLp8Bc66
         So5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687818620; x=1690410620;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srYH61jPdlaM0MowCsJN0isuziRw2t+pfv2C6FBW2u4=;
        b=OMr9Jhsd8g35BG7PQXXUGC+qiLzJyILi6TT9OozHx3rWsJaPQIRS1i0WiJpSmYaaPl
         tcOaLAQy3MwYm2qUGs7la1qmSe9AsE4Fh+46OQLQVWCXUJKMR7Z8Jr1WusMcSMh76dA6
         898mF0z+waYwc/I4OGNdf5tU4HmMoEOoP/qcQCT57Rksv8V8jNMHHxLPXTyPKgeKyWNS
         dxLZQ8BLdInx4EVj+PUESP1zUb2RTDH/OWnETR7YVtr2ZNifSFsKyOj/fW9emotjWvW8
         YsEVuPnUiF9SoypbjUQ3/NKsFCfNwdrbZ8Ztf0r+BJbziscWvYnXAWQ5hTK823ujTu9H
         E0fg==
X-Gm-Message-State: AC+VfDyzb2NDCDqhkFMZZB5WKj4+VfSqMtY4+Wla2oSW00Fz1SzpOrPy
        RbB2siGVtQw1LblLlB8exIZar4cv+HbfHA==
X-Google-Smtp-Source: ACHHUZ6ugmoAeDZP27nsDDGh6h8y7s0qM10k8L//MvlNEKQi/nog8spCfMsO1Ww/Jmwwgb86citMvQ==
X-Received: by 2002:a17:902:e84a:b0:1b8:15e3:d9b1 with SMTP id t10-20020a170902e84a00b001b815e3d9b1mr1450797plg.22.1687818619543;
        Mon, 26 Jun 2023 15:30:19 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001aaed524541sm4645443plj.227.2023.06.26.15.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 15:30:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jun 2023 12:30:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Changes for v6.5
Message-ID: <ZJoRezbOXRTLIL3T@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following changes since commit ba0ad6ed89fd5dada3b7b65ef2b08e95d449d4ab:

  media: nxp: imx8-isi: fix buiding on 32-bit (2023-05-08 09:10:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.5

for you to fetch changes up to 81621430c81bb7965c3d5807039bc2b5b3ec87ca:

  Revert "cgroup: Avoid -Wstringop-overflow warnings" (2023-06-22 08:51:14 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.5

* Whenever cpuset needs to rebuild sched_domain, it walked all tasks looking
  for DEADLINE tasks as they need to be accounted on the new domain. Walking
  all tasks can be expensive and there may not be any DEADLINE tasks at all.
  Task iteration is now omitted if there are no DEADLINE tasks.

* Fixes DEADLINE bandwidth misaccounting after task migration failures.

* When no controller is enabled, -Wstringop-overflow warning is triggered.
  The fix patch added an early exit which is too eager and got reverted for
  now. Will fix later.

* Everything else are minor cleanups.

----------------------------------------------------------------
Azeem Shaikh (1):
      cgroup: Replace all non-returning strlcpy with strscpy

Dietmar Eggemann (2):
      sched/deadline: Create DL BW alloc, free & check overflow interface
      cgroup/cpuset: Free DL BW in case can_attach() fails

Gaosheng Cui (2):
      cgroup: Replace the css_set call with cgroup_get
      rdmacg: fix kernel-doc warnings in rdmacg

Gustavo A. R. Silva (1):
      cgroup: Avoid -Wstringop-overflow warnings

Juri Lelli (4):
      cgroup/cpuset: Rename functions dealing with DEADLINE accounting
      sched/cpuset: Bring back cpuset_mutex
      sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
      cgroup/cpuset: Iterate only if DEADLINE tasks are present

LeiZhou-97 (1):
      cgroup/misc: Expose misc.current on cgroup v2 root

Miaohe Lin (6):
      cgroup/cpuset: remove unneeded header files
      cgroup: remove unused macro for_each_e_css()
      cgroup: make cgroup_is_threaded() and cgroup_is_thread_root() static
      cgroup/cpuset: remove unneeded header files
      cgroup: remove unused task_cgroup_path()
      cgroup: remove obsolete comment on cgroup_on_dfl()

Tejun Heo (1):
      Revert "cgroup: Avoid -Wstringop-overflow warnings"

Xiu Jianfeng (1):
      cgroup: Update out-of-date comment in cgroup_migrate()

 Documentation/admin-guide/cgroup-v2.rst |   2 +-
 include/linux/cgroup.h                  |   1 -
 include/linux/cpuset.h                  |  12 +-
 include/linux/sched.h                   |   4 +-
 kernel/cgroup/cgroup-internal.h         |   2 -
 kernel/cgroup/cgroup-v1.c               |   4 +-
 kernel/cgroup/cgroup.c                  |  72 ++-------
 kernel/cgroup/cpuset.c                  | 267 +++++++++++++++++++-------------
 kernel/cgroup/misc.c                    |   1 -
 kernel/cgroup/rdma.c                    |   2 +
 kernel/sched/core.c                     |  41 +++--
 kernel/sched/deadline.c                 |  67 ++++++--
 kernel/sched/sched.h                    |   2 +-
 13 files changed, 257 insertions(+), 220 deletions(-)
