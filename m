Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C847AF566
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 22:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjIZUlS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 16:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjIZUlR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 16:41:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381429F;
        Tue, 26 Sep 2023 13:41:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c5cd27b1acso86300785ad.2;
        Tue, 26 Sep 2023 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695760870; x=1696365670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDGh2bfYFEdmujy/uEQ8v6m9bD4HO3qMXiBWaHUJXwQ=;
        b=iizb+0mMo9pfx/eNixNWYm1ja6dmk5maQzuDvr8w4wwRA7/AHwWdCZJmGMmFgaeu0G
         DZJLLbJyWGTaJHcLe9eubfySTHYcJcPP8tboOeVYaKlcV4t6PkX8cgw3jTtWLvmRv3sb
         t/eoVr1g+VZaNZTTA+EbspUF3B2tKTaN0gaT0aBmZ1cpfeJ67GQsn7UVmS92t9K/Ff4i
         XjcrchteOxBSPvqg/MCBMZ5z34rtUl8JQ0ZnlPY+mJCy3qQKy+/sxEjKuPr05+8y5nNC
         jrY0EDTPT+2yx61028z8GYKnv9lgLjl2J/jFawQMHM2CumoBsDpbegqFqVeNmjW8kFTa
         1g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695760870; x=1696365670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDGh2bfYFEdmujy/uEQ8v6m9bD4HO3qMXiBWaHUJXwQ=;
        b=Z9pHfCxh71Ym+1cLhRR1sjQptycP99HIxG8lKv5lL0YtAPkCztunc0CircmCciVnmh
         CVBP/fc7s9xLuQi97s0OEwdBvlo0/eVNOtqS8PcPG8JIlF6qSgtO3zikKRIYzvPscZ9x
         3eWizc7RBLI1Ohsce2GKqZq6ZvV3jgZ55s9aOfkMu3KeBEvzMQHZXxWh7uXIJuSdyGoO
         3fg4d3CcLq6ah/Ll6YSGrCKmOVrG/3HCGcbuD1TWRcHN/m9dB6X3qE4VzQB4pKaPiaj7
         L3bmBLDspauOXnLDZEl75Xu7pxWYiWvU9lvO92f1p9x0VBwwhhnQltLmdr6D6wCDq+yN
         rtsQ==
X-Gm-Message-State: AOJu0YyaVybxA792uMKZjUvtx7PjKsGEdvLIRMq6OT9mqMvoRlWzQx9o
        u5QVTP2n8JCe0uysvFf1crk=
X-Google-Smtp-Source: AGHT+IEagb5BPqw9DlNSXZX9HSucCdM4hLntye4ZbKexj1B5SxNJIHCvr/UMM1KQke88rXaG4Xu/lg==
X-Received: by 2002:a17:903:110d:b0:1b8:4f93:b210 with SMTP id n13-20020a170903110d00b001b84f93b210mr12673893plh.45.1695760869764;
        Tue, 26 Sep 2023 13:41:09 -0700 (PDT)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b001bd99fd1114sm4198499plg.288.2023.09.26.13.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 13:41:09 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: add a selftest to verify hugetlb usage in memcg
Date:   Tue, 26 Sep 2023 13:41:08 -0700
Message-Id: <20230926204108.2931076-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926194949.2637078-3-nphamcs@gmail.com>
References: <20230926194949.2637078-3-nphamcs@gmail.com>
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

Ooops I forgot to commit this change.
Basically just moving the nr_hugepages check inside the test program
run within the cgroup. This should apply cleanly:

diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
index 9651f6af6914..436522257cd2 100644
--- a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
+++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
@@ -100,6 +100,14 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
 	int ret = EXIT_FAILURE;
 
 	old_current = cg_read_long(test_group, "memory.current");
+	set_nr_hugepages(20);
+	current = cg_read_long(test_group, "memory.current");
+	expected_current = old_current;
+	if (!values_close(expected_current, current, 10)) {
+		ksft_print_msg(
+			"memory usage should not increase after setting nr_hugepages.\n");
+		return EXIT_FAILURE;
+	}
 
 	addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, 0, 0);
 	if (addr == MAP_FAILED) {
@@ -152,10 +160,8 @@ static int test_hugetlb_memcg(char *root)
 {
 	int ret = KSFT_FAIL;
 	char *test_group;
-	long old_current, expected_current, current;
 
 	test_group = cg_name(root, "hugetlb_memcg_test");
-
 	if (!test_group || cg_create(test_group)) {
 		ksft_print_msg("fail to create cgroup.\n");
 		goto out;
@@ -171,16 +177,6 @@ static int test_hugetlb_memcg(char *root)
 		ksft_print_msg("fail to disable swap.\n");
 		goto out;
 	}
-	old_current = cg_read_long(test_group, "memory.current");
-
-	set_nr_hugepages(20);
-	current = cg_read_long(test_group, "memory.current");
-	expected_current = old_current;
-	if (!values_close(expected_current, current, 10)) {
-		ksft_print_msg(
-			"memory usage should not increase after setting nr_hugepages.\n");
-		goto out;
-	}
 
 	if (!cg_run(test_group, hugetlb_test_program, (void *)test_group))
 		ret = KSFT_PASS;
