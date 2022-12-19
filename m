Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2EB65070D
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 05:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiLSEWc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 23:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLSEWX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 23:22:23 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A765AE;
        Sun, 18 Dec 2022 20:22:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so7721897pjm.2;
        Sun, 18 Dec 2022 20:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bkaFHH9828XqB+keHudWE3HrJtGvwGZpCKERfRezL4=;
        b=UIKz0INgkJM01u8DImabW8vV0MXUcqTEWZ6ucIGfJpJGp3Ik7KfefxrEs5exBi19qf
         XOlxIyF1jrI3Sq8Uxn+VtjhXJOy7+fB74CPXeuahB4jkAnrIaxlbygXxHDuIt7YxoZRY
         SEKriY2DNUbP0Dz1n2r3FsmrLK38p9D0i4yJyz1BoG8JXNOnHiXiBS+fb6ScQ8dmQxU2
         /b1NwJV6ZymcsU+LSeAsDigeFh1FLNZTKynWuqlRIdJHw9djnkAV9Cncv1Kb1fH9oh8Y
         Ajg8/GvAGXhcsO/P7JDzYZlwUAH3vmMR7bOyjo8yFrMnt++B2ZI2h4gWSuOJlPi8fT9b
         Ppjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bkaFHH9828XqB+keHudWE3HrJtGvwGZpCKERfRezL4=;
        b=N5lIkeQtgZjtYSsy/hWaEoAqwaIPW22mcDU3bBK+7Wd9rB2sxoOE5rVhVaDwAjFCd8
         4kI+Yq5Z1LCdXc4CH1UGd21NehBand36jXoJZwQ2wck4WRzGn2BmdnjlqcU5dA7K8ngY
         +LCf1Cd9bHaMKqRiNyst5qZ/HOd5BJU4jiDRxgPIBMTe6xy/kI2XuvpU7cIXWmiQJAa6
         SgzpeA551DmNhEK8o1seCzwRyU0L9HJDL7xHwRVoC/5DW8+HqDWelerdqIO+tdBTpRx+
         QJkDbknaU6XYsm4unoAPmVutYhlPfsPcF5UkzVKy2hHTGSiWWVqFS023lwTlpspwR/Jv
         usJQ==
X-Gm-Message-State: ANoB5pkdOfxWYlqhf547wJQuHla9jp1IYxyrwLxjaF0RBbgWsDdKp2+K
        RQso0vhFK0gPACyAtm4BF+s=
X-Google-Smtp-Source: AA0mqf6I7/d0mc3irtLSumffry2zYvwZBOzD461YgTGyJYmyWAUOgar/8T2H2806AsXi+Hck7ffldw==
X-Received: by 2002:a17:90a:fe0a:b0:219:8cba:cbbd with SMTP id ck10-20020a17090afe0a00b002198cbacbbdmr42968593pjb.32.1671423741351;
        Sun, 18 Dec 2022 20:22:21 -0800 (PST)
Received: from debian.me (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090a6b0c00b00216df8f03fdsm8134652pjj.50.2022.12.18.20.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 20:22:19 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2471B10016D; Mon, 19 Dec 2022 11:22:13 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 06/10] docs: cgroup-v1: move hierarchy of accounting caption
Date:   Mon, 19 Dec 2022 11:22:05 +0700
Message-Id: <20221219042209.22898-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=bagasdotme@gmail.com; h=from:subject; bh=WY+LE4Uwh5JcjEow4gYNYbipiHLpv95jOJMY0+5U34E=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnzn71fJaiww7539/HXxqIn3C+/eS/vd6Yu/Gpqw6WMPKkb bl4ZHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIXheG/wnKDwPkTj3+u7Lw195Dd6 /bbN29cslWj9BNfq5itgw1HA6MDCeeahssk5yXulP18q5tq2oS7uZ/8lmlmDfpCae0vWLIOhYA
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

The caption for hierarchy of accounting figure is in the code block,
which is quite odd. Move the caption into :caption: option of
code-block:: directive instead.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 642ef0bb20380a..3b365a72996be5 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -149,7 +149,8 @@ specific data structure (mem_cgroup) associated with it.
 2.2. Accounting
 ---------------
 
-::
+.. code-block::
+   :caption: Figure 1: Hierarchy of Accounting
 
 		+--------------------+
 		|  mem_cgroup        |
@@ -169,7 +170,6 @@ specific data structure (mem_cgroup) associated with it.
            |               |           |               |
            +---------------+           +---------------+
 
-             (Figure 1: Hierarchy of Accounting)
 
 
 Figure 1 shows the important aspects of the controller
-- 
An old man doll... just what I always wanted! - Clara

