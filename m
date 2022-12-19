Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ED1650718
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 05:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiLSEWo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 23:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiLSEW0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 23:22:26 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB5265B4;
        Sun, 18 Dec 2022 20:22:24 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a9so7846723pld.7;
        Sun, 18 Dec 2022 20:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nm7j4zp8S75Gf6ZgO/l+49FQ5Ia2zwvn+/ND79+AHM=;
        b=RehRdEZifLMG395ppV/7LVvRdnCDdwl9Hfk5Mmn0sswBZr2pNnW1dWd6YtLlfrIL0K
         oqFZJeTpgIBe4v9P3jAHQ9dobxEbwfP4nRMw0pL4/19ifX9Wwh5VebaXq3G0TckKJT5Q
         3kqZoZbODRk6hDbPJJd4GFJwl9htH2bxOx75GIbhK2rZIKB2c/2H7a6LVwPUGFKq6dG/
         voKaNBAD4+uMB8PRT0gAzEa0OtrUnuL4iaXuxFPQ2hzvgPrPfj6mx/ywyY5yaaXZ/NLt
         mBvHQKq1T/lpaZO+0hDhimJVesG6NF/drKn9yloFBkV8jzeDVvtTEOdeCDnZ9BCUi30G
         zz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nm7j4zp8S75Gf6ZgO/l+49FQ5Ia2zwvn+/ND79+AHM=;
        b=4ZIhAokgVmUqh4GPgTW/jSQXMRYb6A6w68QJiK5eCX4uOiyV56Rw1P15UCC4eoyRD6
         gwdvzBTVJmb/uiFFwx/aYlvtBWARO829Mxlqvrk79Oo/chsTGrZbzEMujZ2R8v+Imp4f
         X9E0gYK3wqpY4pprPZ4VRy6QTPPQTA7exUviqVgEWF+IWzkc8i0POZc67CwnV58YFZ11
         BNUwrHxlfCnDL2EHoR0d2ZV95K/nBqg+ifH8PtELoHCD8hbdNQrsh6KJ1L86regRJhwL
         1niSXc2aFXSkCb+CB5HtiW4OiZ4muR/ana9WKmGvewgaw4CMPDTqqcjEu3csk9O9B3zX
         QhSg==
X-Gm-Message-State: ANoB5pkmiVM4+zDhofz5sPA7Pt+WC7ncOB3KgSR4Phh1lVkFG97DRMNl
        o1SXEmVK7sTz+IKXtoLVY6s=
X-Google-Smtp-Source: AA0mqf5qxCuExoyYlyieMwjF0eKAXLuFPRct34IG3Wobwg2OKrtfxxsUeZlvXStIvh1gBbS1/p2qiQ==
X-Received: by 2002:a17:90b:2685:b0:21b:c5d9:3478 with SMTP id pl5-20020a17090b268500b0021bc5d93478mr41654253pjb.0.1671423744293;
        Sun, 18 Dec 2022 20:22:24 -0800 (PST)
Received: from debian.me (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id u31-20020a63235f000000b00488b8ad57bfsm2735607pgm.54.2022.12.18.20.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 20:22:23 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 3A60E104053; Mon, 19 Dec 2022 11:22:13 +0700 (WIB)
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
Subject: [PATCH 04/10] docs: cgroup-v1: use code block for locking order schema
Date:   Mon, 19 Dec 2022 11:22:03 +0700
Message-Id: <20221219042209.22898-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=bagasdotme@gmail.com; h=from:subject; bh=myLqQWWL5ny5cfaM/c1+RVILw8UoUUmH9P1+d/iRWF8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnzn70zn9QX8TP45KkeoY/d0cnefcv2Fi8TMpOtTxa/U5hk vTWwo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOZvInhn/En+655Kw+EtDmba0gcLq 3akbQju8Am0mHuv99/CyRu6DIyTCuP1Cr+cCL9uti17M/FphdjK1O0XvOHHklgXN1wLpWNAwA=
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

The locking order schema is a figure (like diagram), which should have
been formatted with literal code block for consistency with other
figures.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index f828db2a671be4..c21ce0b906059f 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -289,7 +289,7 @@ When oom event notifier is registered, event will be delivered.
 2.6 Locking
 -----------
 
-Lock order is as follows:
+Lock order is as follows::
 
   Page lock (PG_locked bit of page->flags)
     mm->page_table_lock or split pte_lock
-- 
An old man doll... just what I always wanted! - Clara

