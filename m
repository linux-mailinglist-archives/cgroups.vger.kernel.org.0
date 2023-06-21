Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC9A738E58
	for <lists+cgroups@lfdr.de>; Wed, 21 Jun 2023 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjFUSQ6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jun 2023 14:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFUSQ5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Jun 2023 14:16:57 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D33FE
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:16:56 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6686e4499b1so2068918b3a.1
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687371415; x=1689963415;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SErWj7qxRQBNUC6Smh628AB0v7WlXXsygGd167Tdi3o=;
        b=gH6qZbnmbvzhnYXoZHM0cADGdDaQIJB+Zb3K2J/nt0RJuILN8TTUQfNKhL1NoOpRoz
         4eVB/B6O+ns16KrHXkmaeikTQ1b4ePaYZisr/NBGvmSQq0hmkMR56XmPQ9zVAPgyYpmv
         NWCVADLarekZTb/YF8tUjVsARrtG4eYeUd7AA+vBvQZiMqWNtFY3+HGIkyHzwljwaele
         W05jZa+gTCAsFM8uZ+8pwELeyZ6jb1Kp2qCG2b0T90gXpNA9TB2I4C8u3P2k6nyj8VqU
         jSnRcjmfT6h2C4RkMJHux+0cYzROGVEdGqr7gLxMMg1pIBqe2KL8660Qf2/lKBB+AAlN
         vztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371415; x=1689963415;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SErWj7qxRQBNUC6Smh628AB0v7WlXXsygGd167Tdi3o=;
        b=k294j5ihI03vkdbCVO6VbYjK/axhfenOrqOW+0Ty2I4GZEb0XMhtstVQbVJboPDkBr
         tBZpxppDO4HZdM1K9cixQ55VPvwdKtgUuZLenLLeMw2aCHv81bXfwm2ix3W4Z/rcFJh2
         T69pb2A1b+4F9pN/6YaONMrY3pYEviZH6DViFXO4a90wN2tiu9gWYqcG3q+BzJPze37k
         3cxCa6PbtQJQSh0l/5rxSYX2O2NxUkDbRlh2wthQcuUyOjKR2ra5AtSP37Mmb+IcJvHW
         xU22Lb6psktihpWiPzDPgC+U4qGt8CgiHrdF1490Xjan2EC0XUxHAJC/X9WBCc4H+5en
         zP0Q==
X-Gm-Message-State: AC+VfDw01TAiOnpBcUP2l7xdTx7DfYv1RLI0jJs2WywAGY7Ysx3QAIQw
        mly65GIblYbNY98uXGrvjCEWTDPQ5TS3
X-Google-Smtp-Source: ACHHUZ7nxJJH9K2lG/iQd5bdjKxZhjoz3HwnSi034CqmZTOfysPDXpRBX0XDcr7KKuoAxK436AtEeNkdKwqq
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4024])
 (user=yuanchu job=sendgmr) by 2002:a05:6a00:22c7:b0:666:e954:8ab6 with SMTP
 id f7-20020a056a0022c700b00666e9548ab6mr3973259pfj.3.1687371415509; Wed, 21
 Jun 2023 11:16:55 -0700 (PDT)
Date:   Wed, 21 Jun 2023 18:04:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621180454.973862-1-yuanchu@google.com>
Subject: [RFC PATCH v2 0/6] mm: working set reporting
From:   Yuanchu Xie <yuanchu@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kairui Song <kasong@tencent.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yuanchu Xie <yuanchu@google.com>,
        "T . J . Alumbaugh" <talumbau@google.com>
Cc:     Wei Xu <weixugc@google.com>, SeongJae Park <sj@kernel.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        kai.huang@intel.com, hch@lst.de, jon@nutanix.com,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

RFC v1: https://lore.kernel.org/linux-mm/20230509185419.1088297-1-yuanchu@google.com/
For background and interfaces, see the RFC v1 posting.

Changes from v1 -> v2:
- Refactored the patchs into smaller pieces
- Renamed interfaces and functions from wss to wsr (Working Set Reporting)
- Fixed build errors when CONFIG_WSR is not set
- Changed working_set_num_bins to u8 for virtio-balloon
- Added support for per-NUMA node reporting for virtio-balloon

The RFC adds CONFIG_WSR and requires MGLRU to function. T.J. and I aim to support
the active/inactive LRU and working set estimation from the userspace as well.
This series should be build with the following configs:
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_WSR=y

TODO list:
- There's a hack in mm/vmscan.c that calls into the virtio-balloon driver,
  which doesn't work if CONFIG_VIRTIO_BALLOON=m. T.J. Alumbaugh (talumbau@google.com)
  and I plan on solving this problem with a working set notification mechanism
  that would allow multiple consumers to subscribe for working set changes.
- memory.reaccess.histogram does not consider swapped out pages to be reaccessed.
  I plan to implement this with the shadow entry computed from mm/workingset.c.

QEMU device implementation:
https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06617.html

virtio-dev spec proposal v1 (v2 to be posted by T.J.):
https://lore.kernel.org/virtio-dev/CABmGT5Hv6Jd_F9EoQqVMDo4w5=7wJYmS4wwYDqXK3wov44Tf=w@mail.gmail.com/

LSF/MM discussion slides:
https://lore.kernel.org/linux-mm/CABmGT5HK9xHz=E4q4sECCD8XodP9DUcH0dMeQ8kznUQB5HTQhQ@mail.gmail.com/

T.J. Alumbaugh (1):
  virtio-balloon: Add Working Set reporting

Yuanchu Xie (5):
  mm: aggregate working set information into histograms
  mm: add working set refresh threshold to rate-limit aggregation
  mm: report working set when under memory pressure
  mm: extend working set reporting to memcgs
  mm: add per-memcg reaccess histogram

 drivers/base/node.c                 |   3 +
 drivers/virtio/virtio_balloon.c     | 288 +++++++++++++++++
 include/linux/balloon_compaction.h  |   3 +
 include/linux/memcontrol.h          |   6 +
 include/linux/mmzone.h              |   5 +
 include/linux/wsr.h                 | 114 +++++++
 include/uapi/linux/virtio_balloon.h |  33 ++
 mm/Kconfig                          |   7 +
 mm/Makefile                         |   1 +
 mm/internal.h                       |  12 +
 mm/memcontrol.c                     | 351 ++++++++++++++++++++-
 mm/mmzone.c                         |   3 +
 mm/vmscan.c                         | 194 +++++++++++-
 mm/wsr.c                            | 464 ++++++++++++++++++++++++++++
 14 files changed, 1480 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/wsr.h
 create mode 100644 mm/wsr.c

-- 
2.41.0.162.gfafddb0af9-goog

