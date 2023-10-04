Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F80F7B8D94
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 21:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjJDTpN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjJDTpM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 15:45:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54AA9;
        Wed,  4 Oct 2023 12:45:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c724577e1fso1236005ad.0;
        Wed, 04 Oct 2023 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696448708; x=1697053508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyUM37CKgXrMLT04cPOBLc8ziCR9vdEGhysDHWiFSLc=;
        b=KPkcvk5ty0ou/a3iijoX8Yz9LJPzwDwW1cbgksy4WO4xfSqq+z/XYtrtc3S2zdzJwU
         D+fgc1nObfGOKuEVmC9DdPPDIIVfMT0B4lX8EuD48gvMjkwswNr0dxpX0dyLd/Vmaz7c
         sOOLcjFrv+GRZ7HBhSRMo+VtJUVCQ4atikX0as/fCiht0JcFSs9pgEQoFNNLjNaD+yR3
         Xbi81c0xTYpqXvnjrHgU4FcIh5G3sWifoI4Ogz0dmxUVC5FN0c8VsKPXkroFhSlTdpEl
         OjhNU/v0JSl9SEKqIoxukld1Lbg4jM+4j+XtHCbn4Ck8Q4PgVdkSqAHelm8SPofGe5gF
         d+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696448708; x=1697053508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyUM37CKgXrMLT04cPOBLc8ziCR9vdEGhysDHWiFSLc=;
        b=RgrPNOCwlHYXQesrS/isSqLHthXxrnKcYCZzXmrvwsqRl8TMHeT3eQeiw1dCxU1wuL
         r+qhTRTC/wOdpfKq38/TrVjp0d9p5l2nKpPtye636V4cKaoMc6/gLSZUvQ/BrJePFQqv
         OqV7gQ4oYTnTx0HtJ/FOZgGVnyCkpfZwEzrhgrXhzFTIgx81XydLUnF9XcTQAH/T9JxL
         Ng6mknZMkLzVaph5oLLEDZFrMSl2ufwKCGXJ90yr/VTVUXNX+qp/Wva0d/vvvJ62fjOp
         Uh5FHlSvlwTzKXo4Fuj4KOt67O3OjeCF3jkRI3CQKGbMnH/tU6Kc7h3e5Gk5Ft84ydJw
         Lr8A==
X-Gm-Message-State: AOJu0YzTpTuz1QfYj5CBvixxMG5jrCemvX6WHgLIRZ+G7iCrtYsyBIUS
        +cV/U4vZ0njlXfdt62twSiw=
X-Google-Smtp-Source: AGHT+IEDXow3A1fp9kd0BwC4Z4+/Sc9FxJhrMtWKD/ySWkG+I+nY8g90SQBAt1MveEvPzTZEsXyCiQ==
X-Received: by 2002:a17:902:db0d:b0:1bf:8779:e045 with SMTP id m13-20020a170902db0d00b001bf8779e045mr3805106plx.50.1696448707904;
        Wed, 04 Oct 2023 12:45:07 -0700 (PDT)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b001c73eace0fesm4188137plb.157.2023.10.04.12.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:45:07 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in memory controller (fix)
Date:   Wed,  4 Oct 2023 12:45:06 -0700
Message-Id: <20231004194506.946908-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003001828.2554080-3-nphamcs@gmail.com>
References: <20231003001828.2554080-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Ensure hugetlb folio migration also transfers the memcg metadata.

This fixlet should be squashed to the following patch:
https://lore.kernel.org/lkml/20231003001828.2554080-3-nphamcs@gmail.com/
hugetlb: memcg: account hugetlb-backed memory in memory controller

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/migrate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 7d1804c4a5d9..6034c7ed1d65 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -633,8 +633,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 
 	folio_copy_owner(newfolio, folio);
 
-	if (!folio_test_hugetlb(folio))
-		mem_cgroup_migrate(folio, newfolio);
+	mem_cgroup_migrate(folio, newfolio);
 }
 EXPORT_SYMBOL(folio_migrate_flags);
 
-- 
2.34.1
