Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17EC6DE812
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 01:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDKXgu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 19:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDKXgt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 19:36:49 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF33410F1
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 16:36:48 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id a13so10047739ybl.11
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 16:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681256208; x=1683848208;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e+cWg+b19Pk6f8lXfyk0VWgnSnQrmltuo/INztAOGCM=;
        b=vk1Y0/oQzBUKttG+1CE6Ykc1Os1ojCytzOnyh/uKmZw1VqlduwkcIOGwSrjaxmqQZy
         9rbnHcjMsuGy47RJQ0tDwzDsfqZ3odrq+rP2bYEL8fY0bFzv09M8Ns8y9subW8q2Hxmi
         Wy45zN3ZdT6Nn60tro6WBgbtscAv4FWObD957ShoM4DJR3ARE9eSLY78cFkVS9AD3JWQ
         jETav30clTRWo3y8krtaJPOD39cGb6zkkFpSG8Op77Gr0Js3nG0R1MlZ41AF13QSZqFS
         AeSFa3TCWZlR54JH/xtyu8RGrzmUPafEJhPZkfwPIgSMYesdaBp7Uqn6tI5mRFpcNQkF
         nppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681256208; x=1683848208;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+cWg+b19Pk6f8lXfyk0VWgnSnQrmltuo/INztAOGCM=;
        b=G3clwekiY9BcPsS7P/Y4ZhpNTDCMsuJ0e2JggHAaQA1o4nzgzBZVa9xqOTcVSDOkWu
         kJCOvnullxJzLEDyWOahZ3dTbUnAEAAOSB07ZqwKONhAbf/IzItZ879IHQnqidnHvO/I
         XoQBnk2WvQgWWCu7swQgJUqblelypWLcvhVp+jjwxku/1gfMFn/sBTO1lzjzAqu5uTeY
         SVDjvLKjhD703RjlYov/NhYhDxLgiPyvujmhZTCSBz2o4qZqossdg3YsRx2OJl/XA/uS
         zMdyYYxS5z3JrbOiCG8BTAZq2HjjKxQ/E7ljnlOWM4qWoySYncf9tw6+9jVmKrmJiTAd
         v5cw==
X-Gm-Message-State: AAQBX9duQ5WUXDTSCClrUxUeBolnwfCHGop77YTCEhR2KkEZChaNBJ+O
        DBIhyAj3kSvdx+36PDvM78zHZn8+u46yJZwGg7EpPQ==
X-Google-Smtp-Source: AKy350a/D1o92hNC65AUYewK6NKnO5GBHgtProbpBqJDoVgY74hK4YNYrX19Hq1NIrvTbVlXoBjnfT2wr92sdl5THZI=
X-Received: by 2002:a25:e009:0:b0:b8e:db4a:a366 with SMTP id
 x9-20020a25e009000000b00b8edb4aa366mr383770ybg.11.1681256208004; Tue, 11 Apr
 2023 16:36:48 -0700 (PDT)
MIME-Version: 1.0
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 11 Apr 2023 16:36:37 -0700
Message-ID: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a memcg is removed by userspace it gets offlined by the kernel.
Offline memcgs are hidden from user space, but they still live in the
kernel until their reference count drops to 0. New allocations cannot
be charged to offline memcgs, but existing allocations charged to
offline memcgs remain charged, and hold a reference to the memcg.

As such, an offline memcg can remain in the kernel indefinitely,
becoming a zombie memcg. The accumulation of a large number of zombie
memcgs lead to increased system overhead (mainly percpu data in struct
mem_cgroup). It also causes some kernel operations that scale with the
number of memcgs to become less efficient (e.g. reclaim).

There are currently out-of-tree solutions which attempt to
periodically clean up zombie memcgs by reclaiming from them. However
that is not effective for non-reclaimable memory, which it would be
better to reparent or recharge to an online cgroup. There are also
proposed changes that would benefit from recharging for shared
resources like pinned pages, or DMA buffer pages.

Suggested attendees:
Yosry Ahmed <yosryahmed@google.com>
Yu Zhao <yuzhao@google.com>
T.J. Mercier <tjmercier@google.com>
Tejun Heo <tj@kernel.org>
Shakeel Butt <shakeelb@google.com>
Muchun Song <muchun.song@linux.dev>
Johannes Weiner <hannes@cmpxchg.org>
Roman Gushchin <roman.gushchin@linux.dev>
Alistair Popple <apopple@nvidia.com>
Jason Gunthorpe <jgg@nvidia.com>
Kalesh Singh <kaleshsingh@google.com>
