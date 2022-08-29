Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893A05A41A2
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 06:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiH2EAL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Aug 2022 00:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH2EAK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Aug 2022 00:00:10 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70605D98;
        Sun, 28 Aug 2022 21:00:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x80so3024860pgx.0;
        Sun, 28 Aug 2022 21:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=xORpSpkCLQjB00fE/w41wxtlc3w+yIV5elX70E62Eso=;
        b=KiwyJmOUs55sjpXqlc+BHYz3sI41VDESyMnkSIVReWpVFP3s1pwXaTLA9LURs/q6dW
         DPQY4CRZaZHELQpA8MxUf+Qlih8jhsew0X1tjoml3+BIuKFafa1i6qwla7W3MufJ88sz
         r3Ua+lsaR8A3cxvlhYrR5i3I82MkZ16wxsb822x7upPhexjbgJPVIWSHo72yb57xKVrX
         CoKvxGjSY1howJWGreAlSixBHMgp7zDySDCaXp4CrXql62yaHHdUn09oIHUIdfZYCTBV
         +9ZAyGJDSvpS3oyE/dELfVlsDlMRZubVg4OK43r92PdsgLYMCndYL9wfYueizcAjGo1j
         RBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=xORpSpkCLQjB00fE/w41wxtlc3w+yIV5elX70E62Eso=;
        b=SeSjRNOR9DLbiOdKcnMyRHdOiv3qc+LBFmRGAZaw2uKrp7qYU2AH/c1R9OrR+q3vi4
         U9cUzs39mF/9glCdKLLiWGWytoWmShX/Xc9WGyZ9VjbsZkYU6OrHAUWKoxnWoE0dB+jl
         3LAYxLmCC4hqY3O4l+sSdJq0D80CNbkVUrDgzf+6bclQs9vdr79c9mVkvk6IkMTldPdN
         nQbYllucfTg8TM/Jqx674JQAUhaLT81WHCfz54zdTbuywP1ZEyJFHpNNGAhzAASbm3oL
         UEjj1xy9R6HNbSFGIxwldc5LL4M1/5R9nhmCjsFYFKTNT6Myd6hiKro+GrQ37zLViI47
         AzMw==
X-Gm-Message-State: ACgBeo2nfaETG65rBI3qUgC6H+jaazSX5H6QAeocgS9ED/jYoIi5oACW
        prn07yGDZwXXQHFGpC6M492W4HW6OII=
X-Google-Smtp-Source: AA6agR6T4gw1ISYuhbsh+KEBBKJmZqe27oNtaCUsYEohqHIcwLPcTS8iK5Lm3i+xa7QtOc5JuGBUog==
X-Received: by 2002:a65:6cca:0:b0:427:17e6:b32b with SMTP id g10-20020a656cca000000b0042717e6b32bmr12041050pgw.349.1661745607343;
        Sun, 28 Aug 2022 21:00:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b10-20020a62a10a000000b00538116bab6fsm2356394pff.213.2022.08.28.21.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 21:00:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 28 Aug 2022 18:00:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        cgroups@vger.kernel.org
Subject: [PATCH] cgroup: Fix build failure when CONFIG_SHRINKER_DEBUG
Message-ID: <Yww5xZtKLgBFCuY2@slm.duckdns.org>
References: <20220829132951.1f175865@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220829132951.1f175865@canb.auug.org.au>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From c0f2df49cf2471289d5aabf16f50ac26eb268f7d Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sun, 28 Aug 2022 17:54:15 -1000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fa7e439cf90b ("cgroup: Homogenize cgroup_get_from_id() return value") broken
build when CONFIG_SHRINKER_DEBUG by trying to return an errno from
mem_cgroup_get_from_ino() which returns struct mem_cgroup *. Fix by using
ERR_CAST() instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michal Koutný <mkoutny@suse.com>f
Fixes: fa7e439cf90b ("cgroup: Homogenize cgroup_get_from_id() return value")
---
Sorry about that. Applied this fix to cgroup/for-6.1.

Thanks.

 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 86f5ca8c6fa6..e9fc364d5e96 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5111,7 +5111,7 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
 
 	cgrp = cgroup_get_from_id(ino);
 	if (IS_ERR(cgrp))
-		return PTR_ERR(cgrp);
+		return ERR_CAST(cgrp);
 
 	css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
 	if (css)
-- 
2.37.2

