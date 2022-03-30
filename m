Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD44ED05A
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 01:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346536AbiC3Xtd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 19:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242691AbiC3Xtc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 19:49:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C74965D08
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 16:47:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h1so26298278edj.1
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 16:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=9LsSC7UA/+paobOapmA1UTtO12gXoTTx/WztGKAK+nc=;
        b=fe8eEAxqUkCZXNGaq3RHJrZtPAa7wyQzIypVPUh9xnoN6xe8QrIvlcinUSoQ6IUwhD
         MsAIu87gT2JCNO2a5tAm6RP/syCmhSmtdFYMrW5HEfNhzGlRxUChrw8BMQWKR289xWnS
         WjapK7MM2ND4tNqj5/C9UmPFZ+uMsaguZKFcYNppJSJZCtDU+3EnT96GQnXANK0oY0hd
         8Z2Wo2LpiGv/0Y4JEKbKMSQdv5CyDm2YYqX6xqZfwtesHHXVylMZBzm6t32Z+B9mp4D8
         OA3Qu4yzBCYSpwB24NguEODDVRhh6T5/BFUncycCXkxxqhcmTKHb7PeJ+gZ2nDyTUfxH
         gAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9LsSC7UA/+paobOapmA1UTtO12gXoTTx/WztGKAK+nc=;
        b=nxDqj6HYUr+Q0HPX8j6YMLcY8EYQHNiR4CVu6b47IHYlH36ymLL8VFWI5YaX5jRwKC
         AzxcX9JUKG9hzUuOfwa4sNtRnx5lE/gTlDAufcHHa5s0xJoKQBsRkTjJHNmDi8B+LywU
         EV5xItakKzMSlIK0eXefD8DVgvj5C8CBK1WEU/ato4upquMr2yMWgosB5FP+VjqifkQh
         2lW17+pIzbVWfCvyJaAufF0HgWquoaQK/ezLttnZNKQeBp7b0usxIxcIXMccvcLn4zHk
         GmZHGO5bmX786zW8iDWLFKNLZzFwML2eznI2bao9iEZEVH6EGxYWwXLR5hvy5+u8EB+F
         /eCA==
X-Gm-Message-State: AOAM531XuWzmXN5ZO2bLunTWGGMkPj68b8FtPIiCNcHuXH19oY6WISHt
        zGorjWlxAZySPnb5wgrn3julY9MUcKU=
X-Google-Smtp-Source: ABdhPJzYepoaEpY+Ia1Q3I1JFH/RZTdrqcEo0FxbNDNSw2eXDEbi/BjnIfcPQxEQhVmeV2yIqKUobw==
X-Received: by 2002:a05:6402:1e8b:b0:3da:58e6:9a09 with SMTP id f11-20020a0564021e8b00b003da58e69a09mr13737843edf.155.1648684061888;
        Wed, 30 Mar 2022 16:47:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c11-20020a056402120b00b004196059efd1sm10400924edw.75.2022.03.30.16.47.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 16:47:41 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 0/3] mm/memcg: some cleanup for mem_cgroup_iter()
Date:   Wed, 30 Mar 2022 23:47:16 +0000
Message-Id: <20220330234719.18340-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No functional change, try to make it more readable.

v2: some adjustment as suggested by Johannes 

Wei Yang (3):
  mm/memcg: set memcg after css verified and got reference
  mm/memcg: set pos explicitly for reclaim and !reclaim
  mm/memcg: move generation assignment and comparison together

 mm/memcontrol.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

-- 
2.33.1

