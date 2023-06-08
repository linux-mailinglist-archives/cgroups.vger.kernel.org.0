Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C32727A88
	for <lists+cgroups@lfdr.de>; Thu,  8 Jun 2023 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjFHIzG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Jun 2023 04:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbjFHIzA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Jun 2023 04:55:00 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D60EE50;
        Thu,  8 Jun 2023 01:54:59 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33c1fb9f2ecso903805ab.1;
        Thu, 08 Jun 2023 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686214498; x=1688806498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jz1qf2zlWvjIpJVPr8zbP9jXOvJw9H1KwfzL0mmuSd4=;
        b=EuMNUFCfE0m86T6owuPiuM3nPqKSsrppr0wIRvWzkBFqPSyYAwjgWJ61t4zN5rSJu0
         Ayeta9huLcJBWt0FElPaKqc5fDe+DbWXiyF99GiNyAdXME7CQe2Kmkl+BVekSF0Vxu7G
         oBHNbJoqx+5q+tpwJOfaYMWZyXMm3dQRCX2xX4D9OIzKM/Rs/T0klFg7Gk8IR0+QKyJT
         8qh8yNo4uL4Ej350MaH8gIp7cbyU12rhdfkT2rwiE5veSRw00Ta7pPwlINcE1PMp+Rjp
         m4SOAfrSesBUy5Y240gqXo9HO2Z5HP76qwj/RFXri19iewh5vTbHAfqLfzYXAQ7M5waU
         5jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214498; x=1688806498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jz1qf2zlWvjIpJVPr8zbP9jXOvJw9H1KwfzL0mmuSd4=;
        b=WslNNk+EYS0FdLZ4OAic1QqyAMNEcx+BFPLsRtRtMBsMMmgbnBVsFsW9jWRltRrwPO
         +lRfzYuZZSDGPX2uKqF9Ld/fRDS4BDU7qTU6d8LdNxWoNbHhkLcm2YT4savsVti9OnaC
         Zh63P4d7ksdvZo51psLRDl3fupZtNzSt4MvvBY4nA+iAZJkad9pyivqXAQ/Flym4by8r
         0AzaKor1x74uYit2IkDgIjjQVIPoGP3TzqynV/uJ9F0ZshWSPONxd9rtzdW5ZAUDPCBZ
         8XLZLi3j9GNi21NuPlpygpKKjMMarqg5NtjXGSmKR7XqgVwpTDVvh2IPQmxy1mf1g8nA
         qdyg==
X-Gm-Message-State: AC+VfDxqIVnk9RdexCeJuxuRR2l+Xe2kGjX4WhdUui4o9KWw3tshnwLj
        4KVN9jsUF5EhPjE63ebASQg=
X-Google-Smtp-Source: ACHHUZ706Zpr9+29hq8R5/qIx9mGu8tGfi9Ud1gQ3CptlORnk1gUA7yNS6HZvSGEgfztkNaTyK3F2Q==
X-Received: by 2002:a05:6e02:602:b0:33d:6626:7e35 with SMTP id t2-20020a056e02060200b0033d66267e35mr7301987ils.13.1686214498109;
        Thu, 08 Jun 2023 01:54:58 -0700 (PDT)
Received: from suhua-virtual-machine.localdomain ([36.112.24.11])
        by smtp.gmail.com with ESMTPSA id x17-20020aa793b1000000b00640dbf177b8sm664965pff.37.2023.06.08.01.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:54:57 -0700 (PDT)
From:   suhua <suhua.tanke@gmail.com>
To:     longman@redhat.com, lizefan.x@bytedance.com, tj@kernel.org,
        hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        suhua.tanke@gmail.com
Subject: [PATCH] cgroup/cpuset: Fix comment in cpuset_hotplug_workfn
Date:   Thu,  8 Jun 2023 16:54:39 +0800
Message-Id: <20230608085439.27501-1-suhua.tanke@gmail.com>
X-Mailer: git-send-email 2.34.1
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

"synchronize cpus_allowed to cpu_active_mask"
-> "synchronize cpu_active_mask to cpus_allowed"

Signed-off-by: suhua <suhua.tanke@gmail.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b0aee733b92b..4810d29e2d63 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3739,7 +3739,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	if (!cpus_updated && top_cpuset.nr_subparts_cpus)
 		cpus_updated = true;
 
-	/* synchronize cpus_allowed to cpu_active_mask */
+	/* synchronize cpu_active_mask to cpus_allowed */
 	if (cpus_updated) {
 		spin_lock_irq(&callback_lock);
 		if (!on_dfl)
-- 
2.34.1

