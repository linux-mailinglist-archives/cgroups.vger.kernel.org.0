Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0720E50CC10
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 17:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiDWQAP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiDWQAM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 12:00:12 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40704260F;
        Sat, 23 Apr 2022 08:57:13 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id f22so7573996qtp.13;
        Sat, 23 Apr 2022 08:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=feBO+KbcIht+BPtu2AkAQpokc7FT3Bt17XhQc38rY6I=;
        b=Joa6bmM+0gvNBp9oBUlhTxR8ZPxs/9eAbHbOEsWovmEaQHfNDnOVwPcKDPfCcCuxdy
         76oFJIQ+bW95H9niQwNAoIIFCCWUNb3bCeTjXcgAPog8cBZ6EdlpLNlklbX8Fgm/BqTQ
         gU9Uauzrf3O3q+ns4PTxeQRLidvplH0lf6jjny8dUmVCsePCpcl3pBUd87HtLnzLMmgd
         cCwZIoE2+X1k23EeBJe8QLxH4w1vZatcyGArDZp94Zj7NaZXzBcrj9fbU8WJrOu2odLC
         Ko82xmphao59BHrycD4/45q+/4A4/eNnzOGP5ONwlSguoFvLOEl0x3Cx7OYNcdj0LHzP
         zt5A==
X-Gm-Message-State: AOAM532JEMmGhtk67ka1LX3072PcPr07zvR6wN7lwnsBfsuQQACmdWm3
        RnTHmHyERML1KqKEc14saVk=
X-Google-Smtp-Source: ABdhPJxIXud5TfSFIhMm/UhJy9PJtx0SRoz2tqQh0wV2kl2SWYF7ZeJPEXsR6zpNHVRdizGPzQIUjw==
X-Received: by 2002:ac8:5956:0:b0:2f2:521:7195 with SMTP id 22-20020ac85956000000b002f205217195mr6834676qtz.409.1650729432349;
        Sat, 23 Apr 2022 08:57:12 -0700 (PDT)
Received: from localhost (fwdproxy-ash-014.fbsv.net. [2a03:2880:20ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id i68-20020a375447000000b006809e0adfffsm2529753qkb.25.2022.04.23.08.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:57:12 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH v2 4/5] cgroup: Removing racy check in test_memcg_sock()
Date:   Sat, 23 Apr 2022 08:56:21 -0700
Message-Id: <20220423155619.3669555-5-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423155619.3669555-1-void@manifault.com>
References: <20220423155619.3669555-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

test_memcg_sock() in the cgroup memcg tests, verifies expected memory
accounting for sockets. The test forks a process which functions as a TCP
server, and sends large buffers back and forth between itself (as the TCP
client) and the forked TCP server. While doing so, it verifies that
memory.current and memory.stat.sock look correct.

There is currently a check in tcp_client() which asserts memory.current >=
memory.stat.sock. This check is racy, as between memory.current and
memory.stat.sock being queried, a packet could come in which causes
mem_cgroup_charge_skmem() to be invoked. This could cause memory.stat.sock
to exceed memory.current. Reversing the order of querying doesn't address
the problem either, as memory may be reclaimed between the two calls.
Instead, this patch just removes that assertion altogether, and instead
relies on the values_close() check that follows to validate the expected
accounting.

Signed-off-by: David Vernet <void@manifault.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index e899b3f28c22..38d2054eefe6 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -993,9 +993,6 @@ static int tcp_client(const char *cgroup, unsigned short port)
 		if (current < 0 || sock < 0)
 			goto close_sk;
 
-		if (current < sock)
-			goto close_sk;
-
 		if (values_close(current, sock, 10)) {
 			ret = KSFT_PASS;
 			break;
-- 
2.30.2

