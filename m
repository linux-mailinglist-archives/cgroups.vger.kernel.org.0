Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A687AA9B0
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjIVHFt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 03:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjIVHFs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 03:05:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300F192
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 00:05:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690f9c787baso1562290b3a.1
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695366342; x=1695971142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RyLfLRpZqTOqTStamV6qTVG95Q+PZuaFWt0g8stCLvk=;
        b=GyXK78Wfo/zOHzJBmK/cio1ZSi/CmeXiZWYClGzE/eEeoT02ZvR8iJ4AW28Ru31GoE
         p4/mYmvP1uWtq8DYw9eZjgjYRQmYtV2XBg8ZYGpV57snvTbg1y9BruWrZMKh/HkBfNke
         /GiOE9qudMMr6kH5H3HUr8WB4IKRAeC7OgKtJduXe49Wx1B6sSWiQqZNzUdK5ecLgszr
         fmemvMe3tH8sXXlmIGJRqjvcbVuneRJJdk87VWlLOZ4OB2nf9mkZRhfqX3G2z/NdSO0J
         rki3PeDUjQg0S79Q56Y+FRwqsrf9mABwrbCjZGL+lAJ2cMx0809BQa4ahgKU2fa3L1a2
         EDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695366342; x=1695971142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyLfLRpZqTOqTStamV6qTVG95Q+PZuaFWt0g8stCLvk=;
        b=IkHg7w5aL89SzS7y/tEISqSMGoR6nkNqO96UwVuF8IT3YTE1MpJU90Vg6Xsn3PSyRW
         RfC04m71okOKTjeGLcZ5orerskG6TFe4TuZycxVneYWiUkQ6SZD8wl3USMHIlOR/6DEi
         6uXawTWGDpJb3bI8rgwfhpOQc167G8qMMMiVmr0UqlyCENxKFi49GwXM2EHvFKCu8AIk
         UHieImkhLDYGYLY/CucC0SVY8nMQgc7y2G1myk4tIaUcpQmoz2vkutTpd0Wwy4+RJN+I
         opI1oqvZJYO0RR5+4vs2EVZg0PnoPD8d7AJc+nGQwetkuYmU1ihgmb6SK6pkgSABMCyt
         imvw==
X-Gm-Message-State: AOJu0YzJiKzkQe3yQLDkFY4R/NQ/v/cAohJ/VoEdUT2z/q/3QUWlgKDf
        q1aggVddONIwUgqZPu5G2ocu8A==
X-Google-Smtp-Source: AGHT+IG8fOoqmqtRiEzbJpYEMdHEDnsgJQcYWPJsiAo3HehX7Aeak9SJaxcD1Z/MoA1ktJ/ARyX8/A==
X-Received: by 2002:a05:6a00:3187:b0:690:f877:aa22 with SMTP id bj7-20020a056a00318700b00690f877aa22mr4369198pfb.3.1695366342091;
        Fri, 22 Sep 2023 00:05:42 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id k17-20020a637b51000000b0056b27af8715sm2443723pgn.43.2023.09.22.00.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 00:05:41 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@kernel.org
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 1/2] memcg, oom: unmark under_oom after the oom killer is done
Date:   Fri, 22 Sep 2023 07:05:28 +0000
Message-Id: <20230922070529.362202-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When application in userland receives oom notification from kernel
and reads the oom_control file, it's confusing that under_oom is 0
though the omm killer hasn't finished. The reason is that under_oom
is cleared before invoking mem_cgroup_out_of_memory(), so move the
action that unmark under_oom after completing oom handling. Therefore,
the value of under_oom won't mislead users.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..0b6ed63504ca 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1970,8 +1970,8 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 	if (locked)
 		mem_cgroup_oom_notify(memcg);
 
-	mem_cgroup_unmark_under_oom(memcg);
 	ret = mem_cgroup_out_of_memory(memcg, mask, order);
+	mem_cgroup_unmark_under_oom(memcg);
 
 	if (locked)
 		mem_cgroup_oom_unlock(memcg);
-- 
2.25.1

