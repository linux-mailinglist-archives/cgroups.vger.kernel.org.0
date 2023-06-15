Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C247310CB
	for <lists+cgroups@lfdr.de>; Thu, 15 Jun 2023 09:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244932AbjFOHdb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Jun 2023 03:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244940AbjFOHc7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Jun 2023 03:32:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7792D77
        for <cgroups@vger.kernel.org>; Thu, 15 Jun 2023 00:32:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b51f729f22so636925ad.0
        for <cgroups@vger.kernel.org>; Thu, 15 Jun 2023 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1686814362; x=1689406362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNxDzGJxt2Rtrqq4SUvAlNEkp/z3fWK6RSnN1kjt4g4=;
        b=KEuKbPWosv9iUFbOmk/dVUFWj71DFPDvQ7CbfsaMugZZDa8k//E8CAEE0n7vr+1f9j
         LuaB0+g520Fb2VC8JF2Ke6qTtXHB+JzbKxSjCpCxOC9+m6pzYQjTgltBzMdNNNeet8Ea
         TA9tu43p8KzKc8oCUgqgD54eZUaQvLI/G36bAbrWX2vpG6RWPW0E2Yk20bIdnngUwFnx
         D1g4aYowz3lb2PduXbvRW/O2vQlVUUk6t5e9VKATy19FtWYWUTaAZlJk+ItZuMhRmNEr
         ZqgledtelE5KdFama0C4457YvSAPiqJd6KA8hxamKJH0N860sPoNcs9G9Wa6jhBqj3x8
         THYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686814362; x=1689406362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNxDzGJxt2Rtrqq4SUvAlNEkp/z3fWK6RSnN1kjt4g4=;
        b=W5Sy+fYXsSNAG5UD3ZWERHUwezou4uO86DPCfuW5sZxrXilyndKulmsH6S7aHOkHqT
         3ZVKEwwrRRIvJvV7yloVznWfPXaMUDoa8Tnu7x1kuAbrrYFukkJwNVb5oOSBCdHGCGN8
         UmHZoBXVuYlVkSfFdWrwZlcX7iBf8xZS/l4TJO1QKcZ1NT6F9Omb0JljdYoXaFbc0fAh
         7b9fq/HXoW9OG+7eS3sKLYbhj2zGzLPgc04CQ3Dn74Z6qefrDrxTq0OZMdsT2gaqQ3ry
         PcvGeARHBXaBQeqXJFtc6GcdXjxbyT46rC2QQjUyY2PDJiAWKMYFMrwR8S4v8PbYzusG
         uvcQ==
X-Gm-Message-State: AC+VfDyDlDpT/YhJxNVzRIvhSzP8RJGm2yXZXWZQvL9H6BFGRxFRkBY0
        R1jkGWB/uwqiwUOv+ZZHgqVuoQ==
X-Google-Smtp-Source: ACHHUZ4RNNqwi8HU+cLMcAd/WjHpoTHaaDty+uv58jkXb+0O1XjbgRfWVrmXZ5x8K/OLSw71zvr47w==
X-Received: by 2002:a17:903:2350:b0:1a1:b3bb:cd5b with SMTP id c16-20020a170903235000b001a1b3bbcd5bmr17543833plh.62.1686814362490;
        Thu, 15 Jun 2023 00:32:42 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001acad86ebc5sm13352570plg.33.2023.06.15.00.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 00:32:42 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@suse.com
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 2/2] mm/memcontrol: add check for allocation failure in mem_cgroup_init()
Date:   Thu, 15 Jun 2023 07:32:26 +0000
Message-Id: <20230615073226.1343-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If mem_cgroup_init() fails to allocate mem_cgroup_tree_per_node, we
should not try to initilaize it. Add check for this case to avoid
potential NULL pointer dereference.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c73c5fb33f65..7ebf64e48b25 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7422,6 +7422,8 @@ static int __init mem_cgroup_init(void)
 		struct mem_cgroup_tree_per_node *rtpn;
 
 		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
+		if (!rtpn)
+			continue;
 
 		rtpn->rb_root = RB_ROOT;
 		rtpn->rb_rightmost = NULL;
-- 
2.25.1

