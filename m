Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0FA4C23CE
	for <lists+cgroups@lfdr.de>; Thu, 24 Feb 2022 07:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiBXGCm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Feb 2022 01:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiBXGCl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Feb 2022 01:02:41 -0500
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0668EEDF18
        for <cgroups@vger.kernel.org>; Wed, 23 Feb 2022 22:02:11 -0800 (PST)
Received: by mail-ot1-x34a.google.com with SMTP id g24-20020a9d6a18000000b005af04eaa543so703964otn.11
        for <cgroups@vger.kernel.org>; Wed, 23 Feb 2022 22:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OO7dB9NTGAXAhA+gBMGfXBf6knvYeWfSe3D67/xkaoQ=;
        b=BldGrl8aFcOSbdVR4P9FzFom2hvFMTJ2CdwBc7COsLaKo1cqiF/+Gv99lsd8c1msIk
         3PD3Be4u1NT5Uq9QMkdoXYWRZOLLsqG5XPtMpaeNhTEQG8GTp9GnTdUEAPEl5akR1sNj
         WnqgtfZa3bJx8sd7/c5cCwNm9VXJZY46+8anaKY/zgT/j0wXuns5FpJFZHo2AmBLU4nu
         gf97IPxANjPSyVqDP4u7V9J64qkz7Sb+ZiAHC7iFbec6WNOV9mbmtfUGmS3TLmEr54jN
         LkVheQoAnmVvPsWELK0en87WmNFB7+QZFMwJBc10XRolneDIfLb6xZ22Hqek9MO2leHx
         14dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OO7dB9NTGAXAhA+gBMGfXBf6knvYeWfSe3D67/xkaoQ=;
        b=Wc8VzO2Q1XLwGX8n8ZxLPYz5Xi4OKfH2EEgpXp/jEjaDTXb7+p6cSp5SLtMU5Z6N2q
         Q9DzSbAKkEH1RumOsi3lZO8M8zenU/uDEAnSmGJ8ryzuzY99cYWj2S6uc2C1dF8gEXp4
         LZ+UnpLEUMVZM0BBqK3YnnoEQUm/COvLcf/4R5czR2anN4EOlQ4TYj3y8S+xHsr/b6/A
         KEfizsclyc+KBSC7JRtRuhecaeD9emxxUd7zk0y7kvVpr/gkJMPqBv6v1SPCyKrniVbk
         eJJHajdQN8rkjWf8FCEv/Ch2MBcrGtJL89lae850jCi9uxHjc6cIJJMUBcpXPBJJjnvM
         uKew==
X-Gm-Message-State: AOAM530MXQxl5TWo0QvM4I/Q8a+G9cv3+oU8IuMisjtOzOJ8RqNbja/w
        MfPGa/i29TfxpOrjq2G5+s8Qg1SQHj5rWw==
X-Google-Smtp-Source: ABdhPJxGY+1TrcGtsNlDkKUCbu8WC3gLD389SbOn70+65fBzfSoK0DWaKfiA2Qns+WaBk+it7Umf54Sz69w5hw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:8c61:13e8:87c2:e5f0])
 (user=shakeelb job=sendgmr) by 2002:a05:6808:ec7:b0:2cf:acb7:1b50 with SMTP
 id q7-20020a0568080ec700b002cfacb71b50mr6405998oiv.134.1645682530301; Wed, 23
 Feb 2022 22:02:10 -0800 (PST)
Date:   Wed, 23 Feb 2022 22:01:48 -0800
Message-Id: <20220224060148.4092228-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer as well
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I have been contributing and reviewing to the memcg codebase for last
couple of years. So, making it official.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ab8f1621d027..cb97140e7dda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5014,6 +5014,7 @@ CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Michal Hocko <mhocko@kernel.org>
 M:	Roman Gushchin <roman.gushchin@linux.dev>
+M:	Shakeel Butt <shakeelb@google.com>
 L:	cgroups@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Maintained
-- 
2.35.1.574.g5d30c73bfb-goog

