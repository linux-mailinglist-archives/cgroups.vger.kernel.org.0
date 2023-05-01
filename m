Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E236F34C4
	for <lists+cgroups@lfdr.de>; Mon,  1 May 2023 19:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjEARDb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 May 2023 13:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjEARCP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 May 2023 13:02:15 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C89840DF
        for <cgroups@vger.kernel.org>; Mon,  1 May 2023 09:57:05 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64115ef7234so23372365b3a.1
        for <cgroups@vger.kernel.org>; Mon, 01 May 2023 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960195; x=1685552195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHz3gIMQ14LMAlJH3BHlupoStZ8/+BrUL09pT+1nDVs=;
        b=cL9ulyr1TZmloHcY9ZAQt2916/Hy8kFnLfCTiFsQOyXG21mKZDk2kVsVGS3swW/o9A
         lmsPI4V+ni8bJ2cDmSOvMhTe7jiZncm+a+dX+h32N0c6xUNbGxEO59xGx2raskwk+yE+
         EY40N2q/B5lxnqf+wqKkKUxKcIxmFMWDeQ/MPMZ5UoklVL3SBusyJB6cuGrGjrAev2jt
         I6daIpOCKx+oNZEO+zjvrtYAnmo4PPKmPdsrXndRo+l1Ieu4A+pt+fjUYtVugs+1Ncqh
         keNiqCygIJKFaCxV1denDbSpt/uk9T3I2i0PdEP0vYROV8UgAo/d+Ogm15HjT6dg+WeL
         DFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960195; x=1685552195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHz3gIMQ14LMAlJH3BHlupoStZ8/+BrUL09pT+1nDVs=;
        b=Mvt8DsDHdOKrYCIr6shMtb0YQavv5aaMIMPSdnwikXGMBseNJkHbJVS8ONk98MHOcF
         pmS58VVDEBK3pAbsyL82gqZtFq8+q5quC8uI4LHJkleF5FCSiToyGltzVHPQORr7/eTx
         /eS+1wXZSKH8PjkQiXn5oN9zbgB4GU3TCWZ1/+whKXDFiUzPuMyCFuZJPRwCngfYatvR
         om5a0QuMtJzUpbx1Fg262JqTPCtF0854Vw5M9nxsh2J2XnQ0q1G0fbEv/A8lpzxcJ5zn
         /7Rf2FEL+BH2rd2l8FQrCbq5djGZVEV1YccrL3ihycDF2jLLPif8rKWS15mY/eJxCrdm
         CD1Q==
X-Gm-Message-State: AC+VfDyG3mtc3wNE7zfcr/2hGKMKEf7mgcqfPJsTFvEcoNJraxAwlDIQ
        iNoBKQ3pWc9sDz7CDacnDRLqqZFW76c=
X-Google-Smtp-Source: ACHHUZ7qtjt6xJv0/W6KanE/G1kJWq4JffXkn4YmB84VAxkpL2X6o57PZ5XdLwRiQeUXxZyrcuCDjEjhXCs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a17:90a:5105:b0:244:9620:c114 with SMTP id
 t5-20020a17090a510500b002449620c114mr3673305pjh.1.1682960194723; Mon, 01 May
 2023 09:56:34 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:48 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-39-surenb@google.com>
Subject: [PATCH 38/40] codetag: debug: mark codetags for reserved pages as empty
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

To avoid debug warnings while freeing reserved pages which were not
allocated with usual allocators, mark their codetags as empty before
freeing.
Maybe we can annotate reserved pages correctly and avoid this?

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..f5969cb85879 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
+#include <linux/pgalloc_tag.h>
 #include <linux/bug.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
@@ -2920,6 +2921,13 @@ extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void free_reserved_page(struct page *page)
 {
+	union codetag_ref *ref;
+
+	ref = get_page_tag_ref(page);
+	if (ref) {
+		set_codetag_empty(ref);
+		put_page_tag_ref(ref);
+	}
 	ClearPageReserved(page);
 	init_page_count(page);
 	__free_page(page);
-- 
2.40.1.495.gc816e09b53d-goog

