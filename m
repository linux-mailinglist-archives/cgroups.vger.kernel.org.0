Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B851123D
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 09:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358564AbiD0HVH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 03:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357783AbiD0HVF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 03:21:05 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F054CD5A
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 00:17:54 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e24so730958pjt.2
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=N+lrgi/0M85P7HYpF70zDPeGfYctINM3Nu7Hv1hhv8w=;
        b=Dmaz/5beHXaZ3SilA9s4PheTqGgczMacCq8WYyNnDyP4coR1sNWgxE5ghs8qnXO4Fe
         zqMrMzv7qEkR/m43GTpWOlqm+QIBEKZ1mFICjeZU8pSBiLqOEJWe3oSB3mNX0uctIjvq
         nQshYi+wBF14j+34XaWhAmX6SGaesnjFg5gcW5Ry4YrGs/1m/6xPOUf1JbLX2aZAVK0z
         McamG8f/t+iyOc6Zq6a65u6bnhkF/QDY06A8p0iFWvo1s3SmoXBdoecYZJ9fSgEv7fxr
         mFFW+XIjBd8up7NiluKBWpcHetcSxbNwqVghqY1NGNi/y36lsqZLaCqK64e66KpSW+HQ
         eHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N+lrgi/0M85P7HYpF70zDPeGfYctINM3Nu7Hv1hhv8w=;
        b=U4y8y8qmyIufVDJXIlwIlRd1ntvsTsw4ZmVMh45c1xWSPJE5Xb+tM4tZAlh0LtCuvM
         fweksARfJb0qwUY7C+b2Dvr/qeAcLryrLFTsA1YSMMoAsRzHw7N88NaPXCfhXl48AG7t
         BtPTJWllvnfBcS8xftid3uoAfgZ196yxDM+oiLVqvDb6rqc+OLKNaXr8qoxTG5I7F8Oe
         5zySfYI6sMveBfQcaeXFAN4O1mghnfwY36G7dZiYL677aLJOrTUZMYiKhFFOaF35M7CU
         BqHuN6+KepbbnVfP8XKI9/DHvoZbTFSeEx+PqKsrKMbujKleYH7/UeQBEPCayvp7Q1iG
         sudA==
X-Gm-Message-State: AOAM532ZeKYRtK3WYgECRX53xuVDzoqmna49+T27HUfsfoOVl62Okvrs
        IOFQi9EOGveIleSqTmF9xhY=
X-Google-Smtp-Source: ABdhPJybSksItwljCztMKY3JOO1mYmHdayaTaYC5oTdwLWVOfwj63OF8muhWM6Z14ImJ6ulLhRAefw==
X-Received: by 2002:a17:903:1208:b0:151:93fd:d868 with SMTP id l8-20020a170903120800b0015193fdd868mr27595227plh.121.1651043873881;
        Wed, 27 Apr 2022 00:17:53 -0700 (PDT)
Received: from her0gyu-virtual-machine.localdomain ([1.221.137.163])
        by smtp.gmail.com with ESMTPSA id x4-20020a628604000000b0050d2ff56603sm12012229pfd.60.2022.04.27.00.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:17:53 -0700 (PDT)
From:   YoungJun Park <her0gyugyu@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        YoungJun Park <her0gyugyu@gmail.com>
Subject: [PATCH] mm: memcontrol: annotation typo error
Date:   Wed, 27 Apr 2022 16:17:49 +0900
Message-Id: <20220427071749.81345-1-her0gyugyu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

fix annotation typo error

Signed-off-by: YoungJun Park <her0gyugyu@gmail.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 598fece89e2b..7a2dba1ae042 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1140,7 +1140,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	} while ((memcg = parent_mem_cgroup(memcg)));
 
 	/*
-	 * When cgruop1 non-hierarchy mode is used,
+	 * When cgroup1 non-hierarchy mode is used,
 	 * parent_mem_cgroup() does not walk all the way up to the
 	 * cgroup root (root_mem_cgroup). So we have to handle
 	 * dead_memcg from cgroup root separately.
-- 
2.17.1

