Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B25D6F33F3
	for <lists+cgroups@lfdr.de>; Mon,  1 May 2023 18:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjEAQ4Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 May 2023 12:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjEAQzh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 May 2023 12:55:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C1A1BE6
        for <cgroups@vger.kernel.org>; Mon,  1 May 2023 09:55:19 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24df9b0ed7aso1439567a91.3
        for <cgroups@vger.kernel.org>; Mon, 01 May 2023 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960119; x=1685552119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Am8x4T/C3ER6nwTMzq8wqC7nUn5OpA8nmjjdL2Y+IyA=;
        b=WPj8roryRwAmmVOt/f6DiF72YfWfvTwfrhdft0wjazxPvIpRZjMIBwQEDTYgaFjL40
         EYH/Obl5jlfmohNQjk6ksHyCvogtUr2FLXSqo8imf9pH+Av5pbwlM01Z0VPnzvuHFHvS
         sJJApW1h4nytu2oRGIJAzX1ILNXit4lP55uwJk+oNrWKlXyEZFC9xWXVli4TIY3SK85U
         B99AfIcgd6WX1rUTcNtVjahhym0hUSbpRJ8MlMIviR2dEnrK9LO4e6TK4pMF6ElbNOxK
         BqCNggeEEuUJjuE4WJ/nJF98lgK/t0MR2oB5re4JYDKTxZxL1IcsVMbdtZa5WL37TB8E
         NhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960119; x=1685552119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Am8x4T/C3ER6nwTMzq8wqC7nUn5OpA8nmjjdL2Y+IyA=;
        b=KAyXOUaGAnzb0tcVLUoe/CGE2pvsn2SUwefezt7WqiDe0/SHOILsZlx4o1uJV69TMi
         QAI//NsOLS7+7FQ/w8ViM43Y7Zc5BVTfS/39IRjPbY2Irs32dG7U/xY31nHv1i75pPx9
         y6v/9gbETSpUFCWYJDXBTMQg13i4uhZrRW+Tu603vUDiJek2CLhFO8DczECn/cPrY3fq
         slYpCf5Lqflu2usGPKPDvWJ+c3nLmmrX/ZlHdBFdC35fgXLMn3yB+iPMbEucAUEr9Sc7
         0EWRmm/mzueaP05lEzrQQ7yT0zA667T5CmvTxw7rjumHtMnQMoGB1TNs7N9Au39uqhhO
         xdNw==
X-Gm-Message-State: AC+VfDy4Yli69WYGnm9thsv28eoNoBMiXuV34r4K4l8Pf+q1ygZBEgf/
        SQ5vgxbBpR0/nPFmswqm+WNUcefTPik=
X-Google-Smtp-Source: ACHHUZ4HYpYlqwon9ul71ywYVvGlfL5GDzgkEgI+UaCs1iOfSF39OpEKQuit70zO4oA3hBY7TJW8YvGVQSU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a17:90a:24a:b0:24d:e504:69ed with SMTP id
 t10-20020a17090a024a00b0024de50469edmr1685228pje.3.1682960119293; Mon, 01 May
 2023 09:55:19 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:15 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-6-surenb@google.com>
Subject: [PATCH 05/40] prandom: Remove unused include
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
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

From: Kent Overstreet <kent.overstreet@linux.dev>

prandom.h doesn't use percpu.h - this fixes some circular header issues.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/prandom.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f2ed5b72b3d6..f7f1e5251c67 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,7 +10,6 @@
 
 #include <linux/types.h>
 #include <linux/once.h>
-#include <linux/percpu.h>
 #include <linux/random.h>
 
 struct rnd_state {
-- 
2.40.1.495.gc816e09b53d-goog

