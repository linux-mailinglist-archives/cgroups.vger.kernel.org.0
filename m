Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D7F50BC51
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 17:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388221AbiDVQAq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444635AbiDVQAo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 12:00:44 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41C5DA6E;
        Fri, 22 Apr 2022 08:57:51 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id d19so6104392qko.3;
        Fri, 22 Apr 2022 08:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQtAE3ZcQpFqrp+bASWhDiZvk53BS0iYnbojqFdBn7s=;
        b=pUjL1i8FFKphbX3iLrEFzRe2/oR2hgqiTKaefu4wZn8iGy41GnogA69Drqw75RHLA9
         oVuJ3MvA7U4NCea6LQzpVHoKL6oQVvv9OAEXDg9+Fx1h/BBrKhp9m3AllcGgPgX9hrLu
         bp8098AD2I8S2SjUne27p3UizmsYi1wDUkYUPt/jju86dwbpf1FU6KdLCM2MwPpjQpLz
         IQ46RP9PW5MhP473tLGqLYmCuxfOkE6E4uOO3GzYE68I+/C89v/W3300ssKgtelg92tv
         Rv3FqlGMVHE9LmftXi8LkVrEXcaZUwaFimvN41VlqM7Y7Zqj0mFpk/Xkc89E8//OO/I4
         dVQw==
X-Gm-Message-State: AOAM530X5HrPKHw+aCjiSIJZkK/THfeTEuYfbwEuGCHIZcyuzp2cAQSQ
        DIN5NJEFtYs1KlLyRTHJ+SP6uqnkcrOXNg==
X-Google-Smtp-Source: ABdhPJyEzJRX9vnV3+Z6TRD9kwrLPpVaz5L36ZFL4C9MSpyDrjP37pubNs3ib3cwHPc3pShEIIcIkA==
X-Received: by 2002:a37:987:0:b0:69e:927e:756f with SMTP id 129-20020a370987000000b0069e927e756fmr3142409qkj.699.1650643070358;
        Fri, 22 Apr 2022 08:57:50 -0700 (PDT)
Received: from localhost (fwdproxy-ash-018.fbsv.net. [2a03:2880:20ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id e23-20020a05620a12d700b0069ec181a0b2sm1033549qkl.69.2022.04.22.08.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:57:50 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH 4/5] cgroup: Removing racy check in test_memcg_sock()
Date:   Fri, 22 Apr 2022 08:57:28 -0700
Message-Id: <20220422155728.3055914-5-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422155728.3055914-1-void@manifault.com>
References: <20220422155728.3055914-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index d88e0ca3f3d1..c4735fa36a3d 100644
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

