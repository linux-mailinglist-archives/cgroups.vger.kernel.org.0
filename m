Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2877765ECB0
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 14:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjAENRq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 08:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjAENRW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 08:17:22 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD25DE44;
        Thu,  5 Jan 2023 05:17:05 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso1965117pjp.4;
        Thu, 05 Jan 2023 05:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkiZx8G6kdpCzam2vHq1Krq/P436bxFUUtcX4wR/YOk=;
        b=BAV6F8Yry5m7pE15IbeDN664RrsiJsNm9vbYob0JFJ2Ju/wOA0FWzzb/8xhmm9hA7C
         v/izEcjV1ZWW0M0eYpLFDCeiib6kON4L2EJObpomid/HgCPtHZuwpF/MZbVzgOOMVBxA
         2eQ/j3CEQDk9/feT47ZDi8n0VmyCnOLONMBO9N6B87pyCEjB3dZEEQGjkaaTnHQVfsB1
         9iSMexDvgOSQsSASKop+FTY3ugsqALhgHQCstrTJtedG0BviKysorT5ivSoL2VR9qTuN
         r2nMIplNNT4c3bC9AXof2DUjXncmHxPhxjzVUz8sHd3mIA/hwGrQAcq953i+u4hITGhc
         hlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkiZx8G6kdpCzam2vHq1Krq/P436bxFUUtcX4wR/YOk=;
        b=xedkdVEW26AnNVmWBFEklgkY1u30aLWJgM+FUV8DRJSyw2kTfaxYpHHECebQ1YAEQE
         ABoqkZUhHr50kczrHXEhFE71Dnby+0Ns7v0DuGAc3I8NLrxELnZAjHPZzuYrrCV3vfEQ
         6bmRy6OsADzoDGs2Ail8xbDwu+/4ApCk7LzKbuAy4kk6kko+G5M52P0Y6M3oMkf9pPLN
         fjnLDkilpNX6uoEBbnw8EDAH60HmUopHbVmLHCqKfouhYA0s2COXh892c6Yw8r3iOzJu
         QlVq6qoAxFM34uuop45sV7YGeVyZcttJ6dzRC2yr1PP6FOLLHCUGhwZJQGo5ltQgDQM+
         Hs0w==
X-Gm-Message-State: AFqh2kpGRfdoraGX7m1uv0dzf6M7qBDP9GqElhX6IzpZx+ktgIp6d/gl
        Ha38Q+FAhIA7XhYeiwIFiQg=
X-Google-Smtp-Source: AMrXdXvU6JEa6Mo8Z3q8vgd6itpg+H+sn8AbZc7dz53eHdr8Dq6kKktbkfhRPk9Vf4cl6fO4pJiFQg==
X-Received: by 2002:a05:6a21:9218:b0:9d:efbf:787d with SMTP id tl24-20020a056a21921800b0009defbf787dmr61323421pzb.50.1672924624917;
        Thu, 05 Jan 2023 05:17:04 -0800 (PST)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709029a8100b001925c3ec34esm25318972plp.196.2023.01.05.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:17:04 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id E8F10104732; Thu,  5 Jan 2023 20:16:59 +0700 (WIB)
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
Subject: [PATCH v2 5/9] docs: cgroup-v1: move hierarchy of accounting caption
Date:   Thu,  5 Jan 2023 20:16:30 +0700
Message-Id: <20230105131633.553574-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105131633.553574-1-bagasdotme@gmail.com>
References: <20230105131633.553574-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=bagasdotme@gmail.com; h=from:subject; bh=TtcaCybTo5E7/N6tLTMu/WowHmwrmC15HAxU0Etkee0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnbzm6QcbE4K32OSZZjtpvtW73vYXYp6j8ub5d/5Jc/icVt 0/PJHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIoiCG/67NdXrclae/rl4qPj1HKP 1KjaXzB8dJLA0uxtGtGaKxdxgZHjisMcn4dnP232h9H7YC7h1W0yar8uexCGecca19c8yFCwA=
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
index 8d1cedcf44f6ea..4d96a5bbbfcfdc 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -147,7 +147,8 @@ specific data structure (mem_cgroup) associated with it.
 2.2. Accounting
 ---------------
 
-::
+.. code-block::
+   :caption: Figure 1: Hierarchy of Accounting
 
 		+--------------------+
 		|  mem_cgroup        |
@@ -167,7 +168,6 @@ specific data structure (mem_cgroup) associated with it.
            |               |           |               |
            +---------------+           +---------------+
 
-             (Figure 1: Hierarchy of Accounting)
 
 
 Figure 1 shows the important aspects of the controller
-- 
An old man doll... just what I always wanted! - Clara

