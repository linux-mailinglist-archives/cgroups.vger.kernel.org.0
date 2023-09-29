Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729BF7B39E4
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 20:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjI2SR1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Sep 2023 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjI2SR0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Sep 2023 14:17:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9331A5;
        Fri, 29 Sep 2023 11:17:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-69101022969so12987633b3a.3;
        Fri, 29 Sep 2023 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696011434; x=1696616234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4L3CyM2KD+Bhc4bJOeMsRzzCpxEuAkcHebE0BFIhjE=;
        b=jnNjkUJX9fh3CAyx9b9KmbLqYFBKyPxAkIp0FGPkfk1lzXdROpbxnonWzKIpQzJM5i
         0e2GZWxBfyfYetWxBG3Oiwcg1V+7xYVoYTeLLPWfY+r4I3OSKWIPpoXjy3n8VZT87U3T
         PxIX9fn2jHKUePJGki7Qx2aUvW4r+X8eDX5b08IsNnfTWgf7pVVzl+aKhH8ZDZfBJzoj
         DjoWIRQXX4jWKfiIl3e2wj4n2rWYBxxSWeEjVEgEmQFkwC8MN5P6L2Q1lRradRXQ6kNA
         jeY1AJzJusqBhVHuorSLjrgl3V4Yns2NlzaW0uG1KjwJ3xGTygByteasf3M53tre4UNv
         51Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011434; x=1696616234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4L3CyM2KD+Bhc4bJOeMsRzzCpxEuAkcHebE0BFIhjE=;
        b=vmyJ68qED6d6yozaxQfhRFDzagWFAFX7X8z5YQDsLSCO9g6PGRbvSuX34W3i9wTTkO
         w/tJra8SPVLqMEgf0voU1jFfXDOw6LBnpy7lN2ew5CajW5XcQsMH6FIvj2+cpcCBvhoY
         u4Ca+OeEDD7sU9ffeQjcJeXtsD3cVe1KEMWEhJ7nZ2oLChrOOehtV5DPKZqqvt5tHjbN
         EJ/rTHKl9POqPLCvMfHTKyKx3vpFtjAl1wm6LP4Qv+lWczQzOkFJ8QzdhTW3GUzLtafq
         vrq//N0PNXDC1Jf/m5kGr1Y5yUMZAPUKBNpohmBKYE8vs+/vUhOiPE40zPl7wVBezPCh
         BNNw==
X-Gm-Message-State: AOJu0Ywkgm+5PaJqsP8bcVC2//hWzCc/gwCR79t510z/EOJ8RTsaajwa
        swYcphrqQEvs64lzpiPJ9JQ=
X-Google-Smtp-Source: AGHT+IHRn9NtuT89nl3ZXIHaQZ4qLfOhCqEnsf7Txzjq31uEbwhnFHCeEyskUB/5E4VwIq1/0vHdrg==
X-Received: by 2002:a05:6a00:852:b0:691:da6:47a with SMTP id q18-20020a056a00085200b006910da6047amr5678328pfk.31.1696011433596;
        Fri, 29 Sep 2023 11:17:13 -0700 (PDT)
Received: from localhost (fwdproxy-prn-006.fbsv.net. [2a03:2880:ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id i14-20020aa787ce000000b006900cb919b8sm15326753pfo.53.2023.09.29.11.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:17:13 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in memory controller (fix)
Date:   Fri, 29 Sep 2023 11:17:12 -0700
Message-Id: <20230929181712.3723495-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928005723.1709119-2-nphamcs@gmail.com>
References: <20230928005723.1709119-2-nphamcs@gmail.com>
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

This fixlet disables the hugetlb memcg accounting behavior in cgroup v1.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d5dfc9b36acb..de6bd8ca87f5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7081,6 +7081,7 @@ int mem_cgroup_hugetlb_charge_folio(struct folio *folio, gfp_t gfp)
 	int ret;
 
 	if (mem_cgroup_disabled() ||
+		!cgroup_subsys_on_dfl(memory_cgrp_subsys) ||
 		!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
 		return 0;
 
-- 
2.34.1
