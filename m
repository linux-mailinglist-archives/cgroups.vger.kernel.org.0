Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9BE6AC5B1
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 16:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCFPmj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 10:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCFPmi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 10:42:38 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6FB26CCF;
        Mon,  6 Mar 2023 07:42:06 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id w23so10946929qtn.6;
        Mon, 06 Mar 2023 07:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678117325;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ddh13VuSlVvMq9R5DcJQcv52Z9rBjlC8yPuM/C/Td5E=;
        b=MCGpVA5Twmc5z/yNIE43gFVuQVEit+BiKYabkQjNNN/2ScnKdGlcrnT4Tw1PZtKGIP
         eKTu5pqNmBHJWz4krNPS8BZr6HnJCBbluol3nqwekyFMkqhSRGTvYAVRFkw8JFhieuAZ
         bRL6J+sGg0n1sZ4TkeJ0cu2xTWeCFd5990AVYxGQkIkB8tMkDlrASjCJ0T0wWLDMFTma
         J++aX7oaaYAt4jgoedO2rVUmB6DXoFLCiV+TSdjEFVmPCtLOoNmrY0VpNvmlEvcom334
         Anw06N5MDbJMTBljfWk0MLg3frE/aQWfi7kwrCGSOpuypCk7yyYx7bYso2pCNb6DjaG/
         FAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678117325;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ddh13VuSlVvMq9R5DcJQcv52Z9rBjlC8yPuM/C/Td5E=;
        b=x4GNgBM7AjC+L5IAzMHV6wilzIOS26G/1P2VqWEgZQVXU4PxA8zdPHx3M9ycSBPer3
         ccPTIY7c29nEY/DpIF/yEx6VlJ+AqJsZsZSVP6xSWGZHVg0UoQpblq/aCI3Hbnotc41R
         y3sn6K4PAlhJVe7dtycdkCAu80ZTGyNc1N/Lwh/1PDiSaAv77ysmF+kxGF2L2gQjdcRB
         oUC5bN8PgiDefN/UupjpIEwpnqfhlW2bYG8zwszRWZ13DQQS/Bt6unu+C2O0cHzNqSvH
         rNYse0xPnDobIRYpYymJgJSfQ8SPnEgeu8KN0WC+nv0qjL+hLzAdqX3fNoV8Y93H/87f
         RXEA==
X-Gm-Message-State: AO0yUKVoffrhSmZvCtB/fAFz5yJIH93y2m7CpEhB+HKjbbebsOLGyC7b
        l4EDobKVUuiEU8LiDc675hY=
X-Google-Smtp-Source: AK7set8OFXfIc7MtP0TG1b8BKUO2Py6Tlb4jZHj/owhpNxc+rTvc681ywvrtExUnVun/ZgTT6OrlQw==
X-Received: by 2002:a05:622a:1a2a:b0:3bf:b8ae:6ece with SMTP id f42-20020a05622a1a2a00b003bfb8ae6ecemr19680815qtb.10.1678117325131;
        Mon, 06 Mar 2023 07:42:05 -0800 (PST)
Received: from MSI-FindNS.localdomain ([107.191.40.138])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a121300b007424376ca4bsm7618400qkj.18.2023.03.06.07.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:42:04 -0800 (PST)
From:   Yue Zhao <findns94@gmail.com>
To:     akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev, willy@infradead.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH v2, 0/4] mm, memcg: cgroup v1 and v2 tunable load/store tearing fixes
Date:   Mon,  6 Mar 2023 23:41:34 +0800
Message-Id: <20230306154138.3775-1-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch series helps to prevent load/store tearing in
several cgroup knobs.

As kindly pointed out by Michal Hocko and Roman Gushchin
, the changelog has been rephrased.

Besides, more knobs were checked, according to kind suggestions
from Shakeel Butt and Muchun Song.

v1:
- Add [WRITE|READ]_ONCE for memcg->oom_group
v2:
- Rephrase changelog
- Add [WRITE|READ]_ONCE for memcg->oom_kill_disable,
 memcg->swappiness, vm_swappiness and memcg->soft_limit

Yue Zhao (4):
  mm, memcg: Prevent memory.oom.group load/store tearing
  mm, memcg: Prevent memory.swappiness load/store tearing
  mm, memcg: Prevent memory.oom_control load/store tearing
  mm, memcg: Prevent memory.soft_limit_in_bytes load/store tearing

 include/linux/swap.h |  8 ++++----
 mm/memcontrol.c      | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.17.1

