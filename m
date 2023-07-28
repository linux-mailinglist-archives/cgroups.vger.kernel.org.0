Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E07766B2B
	for <lists+cgroups@lfdr.de>; Fri, 28 Jul 2023 12:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjG1K7J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jul 2023 06:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbjG1K7H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jul 2023 06:59:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C909A2701;
        Fri, 28 Jul 2023 03:59:06 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so3468115e87.2;
        Fri, 28 Jul 2023 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690541945; x=1691146745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFsY8/ZjjU7LwHHb+uRNiN1oriLKCvMdQRblo9hKtwI=;
        b=mSoO2RBLZ3V69g4yjzRKp6C+BjpK019a/acfMnMuGovyLL1pQbGVJeXQMhQ8MK5b89
         EBnWdmtyjiVgXpCFGzCbLJBX0nY5tinBn6y3jmpLj+yxOMwyvZ6GdGektEy3TePpvRqi
         AwxwXp0F7JBLTV+MGi0EvXeaNmMoJxRT2DhsHcs8fJAjpwUprUw5Z2ZywuTJ2rA7KxbR
         AOGIgsmD5iG5UpKJ1N7e8LhBpHEsZ7WorTdnJu0rXy5NWO7TEadJjXSz3vCGtwGSn2lu
         n47SgkW3FM3cWrQfZ+c8YlHLS7DRSlBTC3CczS0xm7RM9C6HRNA5/Cpk52kA97cxSIAf
         LflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690541945; x=1691146745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFsY8/ZjjU7LwHHb+uRNiN1oriLKCvMdQRblo9hKtwI=;
        b=LpGMcEotOXpx0bAs0iuTKb3sMSky2sUDFqLSgwVXVCAK1PHyf3+D25JIAtnOE//eGB
         5a/6CHVemf+b/wYfTcwDKJ6WBUWWLJ9P4lf0YBYpxMAQDKK2B+32hx1iYicGeXnjKghN
         xsTnnIUsLXRjxyQ9dJ23kPpjHdgXDapo7epSaHYbIHlQP2jl1ulOtsbTTsoaB/DEwmQY
         XqYegG6/7+5qJHqj+GIjcBLHIwmNpIoCgWALjgWqeVa/QlqXcAwLrnESqGvRV5wnvvpJ
         Xm4pP2U5+xrocvJUYnTr89B8GbWMmbeYHXLbDlvlHZ8K9TpJ26PA5FsWlCtZafB+y2qv
         ol1Q==
X-Gm-Message-State: ABy/qLbNF8rstnGGmqaK4hbKbZUfXwkbEkGEE7kimPEJZbDUyGISSijA
        J8HrI0ifj/MGEOpBEqWiQOo=
X-Google-Smtp-Source: APBJJlGblw/0Qc18d73UPymiWqhuNkPJzTof8WfS6SiIvzeqqxcJbuCmijtMQN3rPEGKUdV11/CqpA==
X-Received: by 2002:a05:6512:ba0:b0:4fb:8bad:1cdf with SMTP id b32-20020a0565120ba000b004fb8bad1cdfmr1856183lfv.42.1690541944666;
        Fri, 28 Jul 2023 03:59:04 -0700 (PDT)
Received: from WRO1-LDL-P90114.synapse.com ([2a02:a319:a140:2280:be02:6cc6:d8eb:a2a6])
        by smtp.gmail.com with ESMTPSA id e17-20020a056512091100b004fce9e8c390sm767872lft.63.2023.07.28.03.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:59:03 -0700 (PDT)
From:   Krzysztof Pawlaczyk <krzpaw@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Cc:     Krzysztof Pawlaczyk <krzpaw@gmail.com>
Subject: [PATCH] docs: cgroup-v1: replace dead CONFIG_MEM_RES_CTRL_SWAP symbol
Date:   Fri, 28 Jul 2023 12:57:23 +0200
Message-Id: <20230728105723.251892-1-krzpaw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit e55b9f96860f ("mm: memcontrol: drop dead CONFIG_MEMCG_SWAP
config symbol") removed MEMCG_SWAP as it was just a shorthand for
CONFIG_MEMCG && CONFIG_SWAP.

The commit also adjusted the documentation but missed reference to
CONFIG_MEM_RES_CTRL_SWAP, which was the previous name of
CONFIG_MEMCG_SWAP before renaming in commit c255a458055e ("memcg: rename
config variables").

Update the reference to the current state.

Signed-off-by: Krzysztof Pawlaczyk <krzpaw@gmail.com>
---
 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
index a402359abb99..1f128458ddea 100644
--- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
+++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
@@ -62,7 +62,7 @@ Please note that implementation details can be changed.
 
 	At cancel(), simply usage -= PAGE_SIZE.
 
-Under below explanation, we assume CONFIG_MEM_RES_CTRL_SWAP=y.
+Under below explanation, we assume CONFIG_SWAP=y.
 
 4. Anonymous
 ============
-- 
2.25.1

