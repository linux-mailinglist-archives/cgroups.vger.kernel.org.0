Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476444F8AD0
	for <lists+cgroups@lfdr.de>; Fri,  8 Apr 2022 02:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiDGWow (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Apr 2022 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiDGWov (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Apr 2022 18:44:51 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38BE152833
        for <cgroups@vger.kernel.org>; Thu,  7 Apr 2022 15:42:48 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id u32-20020a634560000000b0039940fd2020so3736708pgk.20
        for <cgroups@vger.kernel.org>; Thu, 07 Apr 2022 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6TC/fcsrdvkufWtZCTMpd2QTNgth1gYBFeUR7KMTO3o=;
        b=LTNa5mWxit+bHznZj3tr4HARnvMRLGMcNuJSn+VXMiSstVWYzjo8RrN+E1ms6VTeiU
         nFOM753PV0ux/FjpS7u2I8H53Ls+iBrNQ2VqMkJ4/013wYWzOkTOMvmPlfAViGmsT7JI
         wz5hfFfmebTV4K8w6FLtQJbWTKHCf1RVY3yK5HCK8UW5AxATe0Hhq4JXxY2zummMacbw
         7WdJ0FJA8Bcsx0SQlqs5lD1wWFqEVYOi93AQ+e8nhUdpDGM/3Zb7Qs408eH4czs6r98a
         v6ypkffmKqRINf6d0u5JEFrGrfWgcL+egNOTvvTXneQR/WkDoHb0cWVv6VuyGlMHSD9n
         t4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6TC/fcsrdvkufWtZCTMpd2QTNgth1gYBFeUR7KMTO3o=;
        b=4ihH7DEGQZDiU0rgidwxtnObw1AbfZD4Ml4g61tBhD130FvbymfQR49Q1WMlKtmUP5
         cQyoUI0SvXOh7fam7Ggf91f4wixQHo56AyngczoVRZZzQorka5txLJ8MabFz/1NfulvV
         d9TEWUfBV7OFJ5fzSVH1SyMD2v2uXl/NVUqYNFXuMeiDK2CSTPLFR3atZKTel0X+nmQf
         bxY+e7TTw2B9kekHP1fUFAEFNlCa915WJ9Ep6n35UmMvoYoxR/d9o2VWsvO/BYfiV9t1
         wcz8kAftwmRD1UyxIN11tpGJFZGk/hfHxEQ/QHVHDeqv0qlgF8YXb73f+twEYTj94Lgs
         wTLQ==
X-Gm-Message-State: AOAM5309PTtRHsjf4VwVBhd93aVaAqEJ9ft7XU1YOtfVr1L/1ULBlW6k
        +bipArAVR1IjOUU6hEGueq35elvGp+7PVnkv
X-Google-Smtp-Source: ABdhPJwlNJ+NsHyswmzk8S8aUJPENy0C4JQyTzYFWx7UJ9STkknW1VVVp9zPNMHpVNXpn76wXS46DNMY8mlzVMZv
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a65:4b8f:0:b0:39c:c85d:7e7a with SMTP
 id t15-20020a654b8f000000b0039cc85d7e7amr4074145pgq.324.1649371368364; Thu,
 07 Apr 2022 15:42:48 -0700 (PDT)
Date:   Thu,  7 Apr 2022 22:42:40 +0000
Message-Id: <20220407224244.1374102-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v2 0/4] memcg: introduce per-memcg proactive reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, Huang@google.com,
        Ying <ying.huang@intel.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch series adds a memory.reclaim proactive reclaim interface.
The rationale behind the interface and how it works are in the first
patch.

---

Changes in V2:
- Add the interface to root as well.
- Added a selftest.
- Documented the interface as a nested-keyed interface, which makes
  adding optional arguments in the future easier (see doc updates in the
  first patch).
- Modified the commit message to reflect changes and add a timeout
  argument as a suggested possible extension
- Return -EAGAIN if the kernel fails to reclaim the full requested
  amount.

---

Shakeel Butt (1):
  memcg: introduce per-memcg reclaim interface

Yosry Ahmed (3):
  selftests: cgroup: return the errno of write() in cg_write() on
    failure
  selftests: cgroup: fix alloc_anon_noexit() instantly freeing memory
  selftests: cgroup: add a selftest for memory.reclaim

 Documentation/admin-guide/cgroup-v2.rst       | 21 +++++
 mm/memcontrol.c                               | 37 ++++++++
 tools/testing/selftests/cgroup/cgroup_util.c  | 11 ++-
 .../selftests/cgroup/test_memcontrol.c        | 94 ++++++++++++++++++-
 4 files changed, 156 insertions(+), 7 deletions(-)

-- 
2.35.1.1178.g4f1659d476-goog

