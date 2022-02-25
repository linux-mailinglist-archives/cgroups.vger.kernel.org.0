Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0581D4C3A64
	for <lists+cgroups@lfdr.de>; Fri, 25 Feb 2022 01:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiBYAfO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Feb 2022 19:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiBYAfM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Feb 2022 19:35:12 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B3727578E
        for <cgroups@vger.kernel.org>; Thu, 24 Feb 2022 16:34:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lw4so7656963ejb.12
        for <cgroups@vger.kernel.org>; Thu, 24 Feb 2022 16:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=l406JsmQ/9uHOd645BEgXJ9iwo5dFGG+M3DDOGQskWM=;
        b=AxgCPgFo9m4iTfxiNc3Kp/VTeCR+mrjpl/1u4/YA7zC01jyqIlaAvaz1O7r5gh9sr4
         xRsjVa8DlT5P1IYmHb/vPOYa1eqfogoBw8FdWBKPlE5NfrBoabHtn34nmJZBju5Q1PhT
         Nbz6TaFicOpbm8B0Z/j4/nRJaj0fVirZD/Nx0kVsktldUuqZoI3nXV1KJP6C5djg0VWJ
         NUIY1CGZfGaLJzzzJV3PZSiGMF6IBpUwK4r+/SzzTLdR9H5zd0CXrcWaNALW2CSTYN2j
         VxqNB2p/RRFpUeDOBqCVlPrw317qXse8GZ3XZ+H8sLe0OLcIzXPVTDHPc6P4/AxwGuAt
         nMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l406JsmQ/9uHOd645BEgXJ9iwo5dFGG+M3DDOGQskWM=;
        b=X1b3zwwni1oe9kJZ0KK3BePMcQ8J+k/HCwLnn64R0QcTD9fThMuYLbLsPxjJBQYmQM
         fM4bumJKYyy+W9BGeWzeldhbpP5mRnudlivIyDzRpOYmjH+4SRUIRl2at0oXKVI8iQAn
         ySy2Fw20g6DaMTTR8kZNmIOrCOuJxkZjIGYE2RE1AEPu/t2SBF0BuRRlxjlrftqirbC3
         IHmiEfKFCgV74+ZDPcxkG23KGNTRK2mnQuwP98ug6v4owB+ApE5OSDdACK8xsdiBUQku
         zB4cJdIsG/6uCwbLEjcRGCVx0KKaoP2VNc65DF2/MgWuwXMIgBbJY8ZSy/aabBXr1Kmc
         gyPg==
X-Gm-Message-State: AOAM531yMcOw671Opdwh0LSpsBlpcpt0ZxoLgGB7VkaFK1g5euEype7N
        7YS0T1sROI9LANfy/pAVJi0=
X-Google-Smtp-Source: ABdhPJxHtbNu/Y/V+qoak6Uqf+cZ2KKFO6eNlkhWo9yLSY60Enq4GACpFOhnNOv4so0GqxC8xlV21w==
X-Received: by 2002:a17:907:70c1:b0:6ce:78ff:bad4 with SMTP id yk1-20020a17090770c100b006ce78ffbad4mr4254252ejb.68.1645749280272;
        Thu, 24 Feb 2022 16:34:40 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id cc21-20020a0564021b9500b00403bc1dfd5csm515084edb.85.2022.02.24.16.34.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Feb 2022 16:34:39 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 0/3] mm/memcg: some cleanup for mem_cgroup_iter()
Date:   Fri, 25 Feb 2022 00:34:34 +0000
Message-Id: <20220225003437.12620-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No functional change, try to make it more readable.

Wei Yang (3):
  mm/memcg: set memcg after css verified and got reference
  mm/memcg: set pos to prev unconditionally
  mm/memcg: move generation assignment and comparison together

 mm/memcontrol.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

-- 
2.33.1

