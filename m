Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23115FA8C6
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 01:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJJX6y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 19:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJJX6x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 19:58:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE44A7FE7E
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 16:58:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q17-20020a25f911000000b006bcc33faa7bso11981779ybe.4
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=32G3k93Ulqw+bBT8wloqCvMkNp9uoyXmylHiGN2Ypxc=;
        b=oBamiBMlwevwaWtK9/MK/DT9KKivXxO2BxJN593yqX6pYjoGISML+X3eegUtf6A2M5
         4iA2KIkdw4Sa2t3eOKZT3OrwBQCo8yzMbPa7sEEiMxRHAUJzqmE8fikOru5PvKc3xLKp
         7pBhjHTEQuE239jf1M8tJM2axFb+arNmTjtVlvz9nWLtrXVa2bgjE1lgBqheC+oaMxPV
         buJwf/w9KTYkdmjq4x2mUZ67/K32gzGzfrn+c8T3b3ekZOISsbXD9cufr41n2pvvZnd4
         2U5PTZALuINUVBwjM1H5EV2MwG9mT5ARQpFgxKTCSTKgM98LAeeMrpsjT5iMKRDZqt+F
         TL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32G3k93Ulqw+bBT8wloqCvMkNp9uoyXmylHiGN2Ypxc=;
        b=QDePlAK6ZkFEA4cDbzkel2lb+DsL5pLiPJoa8AVrhbl4Vk9UA3/T2hlkVwP0giDDw8
         in3lt8xa52vosa1EnkxsO8h01Bh9QIBOHlmg4wXTYv00AmMBDYAHrpGnjPUGR2lORbuL
         /a2jtX3EYd9a69XS6oF+LkKeVPUd59PP86czn3ljbDrxdTLamRXy6r1NOhO/P2tLiNSF
         hQaooegs0Yp3ffLlJw2k7eMSkF3/diqOU0SirQ7penlFi6POVuNIVFupqGhI2mGCeyuG
         gznh95/PiwzjNlp8afyGxyjdGLKfXQ8q3UDTSZ+vfsg2xw4RQPVQlpZDdVicTU8boEbW
         KKIA==
X-Gm-Message-State: ACrzQf2RMvq+8fE3QmTgHeJDAOl6MHootUYKWH73/wFCzGdnlBsR8dMU
        uoLyhaDiyLA2IwJfIBtUmsxq6FRgEmDT9CEy
X-Google-Smtp-Source: AMsMyM5DVXg5sRb4xhrP+EF/t+N8fSesDoGkVZhdZwcIM0i//2doFKVpIAnhQz1pvBQYkekxL/PBBffZP3lfkxTd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a0d:ce05:0:b0:345:5ea7:22fa with SMTP
 id q5-20020a0dce05000000b003455ea722famr19246450ywd.279.1665446332163; Mon,
 10 Oct 2022 16:58:52 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:58:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010235845.3379019-1-yosryahmed@google.com>
Subject: [PATCH v1 0/3] Fix cgroup1 support in get from fd/file interfaces
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

commit f3a2aebdd6fb ("cgroup: enable cgroup_get_from_file() on cgroup1")
enabled using cgroup_get_from_file() and cgroup_get_from_fd() on
cgroup1, to enable bpf cgroup_iter to attach to cgroup1.

Apparently, other callers depended on these functions only supporting
cgroup2. Revert f3a2aebdd6 and add new separate interfaces that support
both cgroup1 and cgroup2.

Yosry Ahmed (3):
  Revert "cgroup: enable cgroup_get_from_file() on cgroup1"
  cgroup: add cgroup_all_get_from_[fd/file]()
  bpf: cgroup_iter: support cgroup1 using cgroup fd

 include/linux/cgroup.h   |  1 +
 kernel/bpf/cgroup_iter.c |  2 +-
 kernel/cgroup/cgroup.c   | 55 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 51 insertions(+), 7 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

