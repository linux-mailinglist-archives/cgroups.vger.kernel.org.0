Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4EC715D71
	for <lists+cgroups@lfdr.de>; Tue, 30 May 2023 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjE3Lke (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 May 2023 07:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjE3Lka (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 May 2023 07:40:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3543FB0
        for <cgroups@vger.kernel.org>; Tue, 30 May 2023 04:40:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d3578c25bso5032623b3a.3
        for <cgroups@vger.kernel.org>; Tue, 30 May 2023 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685446827; x=1688038827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JO+xdar3MejOJZdKmBkA9ihZEhu1lJTvdVxsMRKinbc=;
        b=WsDOY9jQoN7Z60/CfCewtBbx5WDKyT8UAnjmpj9OQeIMppc40tAvX12MUibOoFeC7F
         1yvBEnazT7feLsOMV4EmMc7BN0meQQncwW7I8uk5n4K35FpQV1ssrM64kI8qNjo86HCU
         q2b3VVlCgdXlWT5ljhv4SobkdECX9a/4ycYrCXq4U/GEy8xocCxQ5uD1oj2uZquQ3me1
         XgBo5tCmkqXMjg0hRKZfkVek1kAWtxJIuKw9xheE9KTLYc2oxLxe/7utv8B1FrJyg2CW
         1Sn6hEVW5ZWW1PfUOx9Kpa62nIcl20BGmKkT1L1FZjER2FvJLR2KYjVryJv1rdsTTDE9
         movg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446827; x=1688038827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JO+xdar3MejOJZdKmBkA9ihZEhu1lJTvdVxsMRKinbc=;
        b=Biq2gzLju2dRopqyGdOjKuvhglVaW/kaGAVYAZR2wmCkeoq6UIlkniEphckvPxUFyo
         z6iuQAcsQElSx26qM2TSxa+b2hOAIN/J7YxyDlTb4ND4mw3NheBW1AEDm1yPNBEPqH/n
         /5NkFMUDzTid6yo3nI2htOt66xWN0jAID9MJLPti0euAo7E/Y7ZpU0Sa98Isy/RBtwoU
         21Phxgig0/qaTZaTWVzO5dqCkpvhdcNZWcZUHrrdo6QlYh+VrhoWM+XqfrWTjkYe31KB
         wxzPQIea9SdqlQcOGlRxkuItoYoeoVDC0Wl09VW13I7RXVQLU4sEb7ND3uRhiqGjkHuC
         Tjcw==
X-Gm-Message-State: AC+VfDzKORa4qnhFCqOdTS9/U6rM/NgDerJCM4fXuy+0Yx6mDwAidHWu
        +RsoIGaurwXDYgZ4pfQ5q7VmOV1+9lWOMp4lzM4=
X-Google-Smtp-Source: ACHHUZ7vxE2I8AcBFyrCBnPtSDWf+89hv2cMdNzv+jUYl+x0Xx48DRjOu9QgyvfV/5n8S9vBOlxxDg==
X-Received: by 2002:a05:6a20:3d85:b0:100:60f3:2975 with SMTP id s5-20020a056a203d8500b0010060f32975mr2490885pzi.4.1685446827713;
        Tue, 30 May 2023 04:40:27 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j20-20020aa78dd4000000b00642ea56f06fsm1515103pfr.0.2023.05.30.04.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 04:40:27 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 0/4] sock: Improve condition on sockmem pressure 
Date:   Tue, 30 May 2023 19:40:07 +0800
Message-Id: <20230530114011.13368-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently the memcg's status is also accounted into the socket's
memory pressure to alleviate the memcg's memstall. But there are
still cases that can be improved. Please check the patches for
detailed info.

v4:
  - Per Shakeel's suggestion, removed the patch that suppresses
    allocation under net-memcg pressure to avoid further keeping
    the senders waiting if SACKed segments get dropped from the
    OFO queue.

v3:
  - Fixed some coding style issues pointed out by Simon
  - Fold dependency into memcg pressure func to improve readability

v2:
  - Splited into several patches and modified commit log for
    better readability.
  - Make memcg's pressure consideration function-wide in
    __sk_mem_raise_allocated().

v1: https://lore.kernel.org/lkml/20230506085903.96133-1-wuyun.abel@bytedance.com/
v2: https://lore.kernel.org/lkml/20230522070122.6727-1-wuyun.abel@bytedance.com/
v3: https://lore.kernel.org/lkml/20230523094652.49411-1-wuyun.abel@bytedance.com/

Abel Wu (4):
  net-memcg: Fold dependency into memcg pressure cond
  sock: Always take memcg pressure into consideration
  sock: Fix misuse of sk_under_memory_pressure()
  sock: Remove redundant cond of memcg pressure

 include/linux/memcontrol.h |  2 ++
 include/net/sock.h         | 14 ++++++++------
 include/net/tcp.h          |  3 +--
 net/core/sock.c            | 10 ++++++++--
 4 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.37.3

