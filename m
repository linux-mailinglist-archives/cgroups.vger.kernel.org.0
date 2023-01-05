Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7EB65ECD0
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 14:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjAENSV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 08:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjAENRZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 08:17:25 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7315F921;
        Thu,  5 Jan 2023 05:17:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 17so39358235pll.0;
        Thu, 05 Jan 2023 05:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUkOkbYzuv5WTxnO2sv3n0IBM4omUdA6IheQF/z4HEk=;
        b=NGtacwLgGIfh31U+j37UAkxT1pREhpEa5I7Zke513uzhR7ayCdgCJbrs6KJiPvm06G
         fFnCmYRv+PHI1g5DcOZktq7IN/66rGcEzHoW3YjMbKRqEvewBDT8rUuYaoaaHqHZ78QP
         PtEv4zWfcdWbJYB7ILQwRDe/bGViy3ZC63cJeYMXvm8MbStVEc3cjzLQnVHYp+FNYSb5
         PQNcD40i+b5wMdGICjjhXSmU5X7aytJ1yHYPs94FSKOKHIuzzpjLwfEopRxYZyhe2GU3
         nrs86tF5hzi0AXjOlJujcpTA+Bmag6mafIsPZcuIeq6mpMF3FF8GB3vZHPbXUaTjKHqL
         Jn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUkOkbYzuv5WTxnO2sv3n0IBM4omUdA6IheQF/z4HEk=;
        b=vS7ymXYw2F1mZ6u3l2JqFEzx6kMCIIzRkSLJgMRX2jsej7kp4AOfsrTkjfur/MTB/9
         fbTFtbX5rvzw3+DallsYk1Q1GJ75tkhf/Er5n0xn5Jrax23F1fWtBhdW53PzeMt2NR8U
         +WMovphqlCybv82HwTnK5fNNVwCqbTwOmuhJkj/pggLaFEOBHZM6ZfXaC5NgbHQCQe/Q
         CBzx4u8bzg/GrQDOKyOYpCVKIx3dd5rYsOnOSuD/XRTN/ZdXv839r94wJ3wbw3uhyDR2
         8vQpV/h1PP7zZnM0pnV2akJ8PuUBHSMafHFP604vQkYIcXKyG61XWpDf7aP3aD4hEWXe
         /A/g==
X-Gm-Message-State: AFqh2kp3/bHsovkmMo6d9iAcnR9q5A2amsbty+DWjdCi6M8GExmsweNm
        u1YdDjnreYMreb85FYHJRmU=
X-Google-Smtp-Source: AMrXdXu6rCc1zuGeZNCk5kWS9i/EY+REle4fGbOLkNgWpwIL6oVfmjfm6n/aQtbOiutCYncfzkjHxw==
X-Received: by 2002:a05:6a20:4655:b0:aa:23f9:7314 with SMTP id eb21-20020a056a20465500b000aa23f97314mr52845051pzb.46.1672924626119;
        Thu, 05 Jan 2023 05:17:06 -0800 (PST)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id p28-20020aa79e9c000000b00575caf8478dsm12597033pfq.41.2023.01.05.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:17:05 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 3792010447A; Thu,  5 Jan 2023 20:16:59 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux CGroups <cgroups@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 0/9] docs: cgroup-v1: formatting improv for "Memory Resource Controller" doc
Date:   Thu,  5 Jan 2023 20:16:25 +0700
Message-Id: <20230105131633.553574-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353; i=bagasdotme@gmail.com; h=from:subject; bh=/kf4xrQxZdifPynYl0ZAE3ZdLLa3+RCO1xkFVH/rr78=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnbzq74Oaf24mtmL1epe2kFR1t/Gskr2N2/xXXUT5Cp7Mit N8vOdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiAWcZGU5FLnntdv6I4smC0myPyx r1nxvn7So4dqmS6VnI/EmdLxYx/FOWCK2cymic2LvpZ6Cq+MkLArusbB7tVZ543rpZb8f/2WwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

"Memory Resource Controller" CGroup v1 documentation has been in reST since
99c8b231ae6c6c ("docs: cgroup-v1: convert docs to ReST and rename to *.rst").
The current doc look is kinda ugly, so improve the formatting (only htmldocs is
tested).

Changes since v1 [1]:
  * Drop the underline fix, since the blamed commit had been dropped
  * Rebase on top of current cgroup tree (for-next branch)

Range-diff against v1:

 1:  e0f2b878ad6435 <  -:  -------------- docs: cgroup-v1: extend underline of section 8
 2:  4e26b743ce9b42 =  1:  cb31249cacdad6 docs: cgroup-v1: replace custom note constructs with appropriate admonition blocks
 3:  c89f9aa1e6dac9 <  -:  -------------- docs: cgroup-v1: wrap remaining admonitions in admonition blocks
 -:  -------------- >  2:  8e03baf289c4f2 docs: cgroup-v1: wrap remaining admonitions in admonition blocks
 4:  b901b2b0407e23 =  3:  790ac70bcf31e1 docs: cgroup-v1: use code block for locking order schema
 5:  f4112d2f9990ce =  4:  2af22c24977a38 docs: cgroup-v1: fix footnotes
 6:  d5d16831555e6b =  5:  9788d0e8c87cc5 docs: cgroup-v1: move hierarchy of accounting caption
 7:  92db959851e2c8 =  6:  b191e2bd87871b docs: cgroup-v1: use bullet lists for list of stat file tables
 8:  767988658f58b8 !  7:  56e4ba363e4e65 docs: cgroup-v1: use make swap extension subsections subsections
    @@ Metadata
     Author: Bagas Sanjaya <bagasdotme@gmail.com>
     
      ## Commit message ##
    -    docs: cgroup-v1: use make swap extension subsections subsections
    +    docs: cgroup-v1: make swap extension subsections subsections
     
         Subsections text of swap extension section is marked up as bold text,
         whereas making them proper subsection is more appropriate.
 9:  a502f09f9a3c33 !  8:  6895ee7c84e840 docs: cgroup-v1: add internal cross-references
    @@ Documentation/admin-guide/cgroup-v1/memory.rst: If we want to change this to 1G,
      
     +.. _cgroup-v1-memory-move-charges:
     +
    - 8. Move charges at task migration (DEPRECATED!)
    - ===============================================
    + 8. Move charges at task migration
    + =================================
      
     @@ Documentation/admin-guide/cgroup-v1/memory.rst: If you want to enable it::
      
10:  895b1f1aa37d33 =  9:  b179c2788f2a36 docs: cgroup-v1: use numbered lists for user interface setup

[1]: https://lore.kernel.org/linux-doc/20221219042209.22898-1-bagasdotme@gmail.com/

Bagas Sanjaya (9):
  docs: cgroup-v1: replace custom note constructs with appropriate
    admonition blocks
  docs: cgroup-v1: wrap remaining admonitions in admonition blocks
  docs: cgroup-v1: use code block for locking order schema
  docs: cgroup-v1: fix footnotes
  docs: cgroup-v1: move hierarchy of accounting caption
  docs: cgroup-v1: use bullet lists for list of stat file tables
  docs: cgroup-v1: make swap extension subsections subsections
  docs: cgroup-v1: add internal cross-references
  docs: cgroup-v1: use numbered lists for user interface setup

 .../admin-guide/cgroup-v1/cgroups.rst         |   2 +
 .../admin-guide/cgroup-v1/memory.rst          | 268 ++++++++++--------
 2 files changed, 146 insertions(+), 124 deletions(-)


base-commit: 21786e5cb375a1e58a9175fee423e1d7f892d965
-- 
An old man doll... just what I always wanted! - Clara

