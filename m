Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2F365ECC1
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 14:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjAENRx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 08:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjAENR0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 08:17:26 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EBE5C1C6;
        Thu,  5 Jan 2023 05:17:10 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jn22so39264114plb.13;
        Thu, 05 Jan 2023 05:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8J8qW+Vq8pd6T9oMP3SU6TUuvWLiPg70zvs+kZ90og=;
        b=iCXg4LXUCBckmKqWrrrxIf26SHrZFmi22auf4ZaicKRigcxRH4J1pPKSfOGqGrx+70
         2Dz9hHlbyfiE4Ej5uw8WLiINWCrDAzbB2ANP3+/gbqzdOwBY6PAVA7BUZTzjTjN9cnpk
         w7tPekaV9ZL3vtm3yJhU/niRomQUa/kb4CWyJH8y8iuAh/qLPl6JCDrc6ste8rMI94Vb
         txsfBlJ+2NXRQscx4WGe5FgfV4qryQy/us+G8v74ohmJ9dZ1/1Yydjnm5pMDR4CGIFWd
         rFyAaog+Q+WI+4vFL84NNY7n+NkZ1tRC3x6sboqGdsT7/ikXBHb5637YYaiNJOQxgOy1
         wIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8J8qW+Vq8pd6T9oMP3SU6TUuvWLiPg70zvs+kZ90og=;
        b=1EsZW3jg+Lf7iiDSD0QtAfimZyq0pJG0IFjY74GLcjXT61X/zVcK7cBnGCnyY/o2hk
         g4S3O/gKxwlFuVYri4roj/bOFmayCuuxL0IjuBmjihfwo2/X/5rtvic7ZXBctHG98DXs
         fHwcnbXBfkbVEn32VS7taymR9klF8Ab+46CzXRld21Pi2OST5SsoJRo9WEIK4PIWzLVl
         Lvw+Reu1hESXcaLEQv2XFxXuL08iQz18lSzpdRBiHSMZqQGms9XybTTL661/zBwcctGp
         naXpMZjeQ9cjx8Q9PSG2j/z9Qy7IOyguSWbWkHmwLU60Us6MJbtdSlJWVwvzuIy03H4S
         IRgg==
X-Gm-Message-State: AFqh2kqy1Ygx2AwCzP0gaM2iJju4J3hQr4y6AqSvlGq4oifLN9HtBsVl
        5lzZUK6keEHo2mx2+BfJqvc=
X-Google-Smtp-Source: AMrXdXslOn7z2k07aal+6cIKgoQ5LswkwnJ95kNaoSJyQRPK/amOfoIBRXrc2Nm+i57mpW0/cAM3qw==
X-Received: by 2002:a05:6a20:4295:b0:a8:8714:233b with SMTP id o21-20020a056a20429500b000a88714233bmr80647372pzj.57.1672924630106;
        Thu, 05 Jan 2023 05:17:10 -0800 (PST)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902a3c700b0018997f6fc88sm10893264plb.34.2023.01.05.05.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:17:09 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 8148B105232; Thu,  5 Jan 2023 20:17:00 +0700 (WIB)
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
Subject: [PATCH v2 9/9] docs: cgroup-v1: use numbered lists for user interface setup
Date:   Thu,  5 Jan 2023 20:16:34 +0700
Message-Id: <20230105131633.553574-10-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105131633.553574-1-bagasdotme@gmail.com>
References: <20230105131633.553574-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017; i=bagasdotme@gmail.com; h=from:subject; bh=nysWUkfThi/UCTzfZAv3ZXQWTYDkn/SrXnv8ebwTGco=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnbzm5cWtCq0ng04TEHZ7mB8SLVvBOR8ztZH9yf/zX6aJlM um9YRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbibcPwT83d3Ur0YVzhzYLHnCdO+i /VN2/wf6tmmSycLGTr8LlwKsN/L4kJ/ZbNi2Kc+F4s8DBN49CYLV1rXfH+fJz40j4rB2VOAA==
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

Setup instructions for memory resource controller UI uses a mix of
section headings and normal paragraphs, whereas numbered lists are
better fit for this purpose.

While at it, also slightly reword the instructions and add reference to
"Why are cgroups needed?" in the main cgroups documentation.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../admin-guide/cgroup-v1/cgroups.rst         |  2 ++
 .../admin-guide/cgroup-v1/memory.rst          | 26 ++++++++-----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cgroups.rst b/Documentation/admin-guide/cgroup-v1/cgroups.rst
index b0688011ed06de..9343148ee99366 100644
--- a/Documentation/admin-guide/cgroup-v1/cgroups.rst
+++ b/Documentation/admin-guide/cgroup-v1/cgroups.rst
@@ -80,6 +80,8 @@ access. For example, cpusets (see Documentation/admin-guide/cgroup-v1/cpusets.rs
 you to associate a set of CPUs and a set of memory nodes with the
 tasks in each cgroup.
 
+.. _cgroups-why-needed:
+
 1.2 Why are cgroups needed ?
 ----------------------------
 
diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 16d938abe69f81..27d89495ac880a 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -387,30 +387,30 @@ U != 0, K >= U:
 3. User Interface
 =================
 
-3.0. Configuration
-------------------
+To use the user interface:
 
-a. Enable CONFIG_CGROUPS
-b. Enable CONFIG_MEMCG
-
-3.1. Prepare the cgroups (see cgroups.txt, Why are cgroups needed?)
--------------------------------------------------------------------
-
-::
+1. Enable CONFIG_CGROUPS and CONFIG_MEMCG options
+2. Prepare the cgroups (see :ref:`Why are cgroups needed?
+   <cgroups-why-needed>` for the background information)::
 
 	# mount -t tmpfs none /sys/fs/cgroup
 	# mkdir /sys/fs/cgroup/memory
 	# mount -t cgroup none /sys/fs/cgroup/memory -o memory
 
-3.2. Make the new group and move bash into it::
+3. Make the new group and move bash into it::
 
 	# mkdir /sys/fs/cgroup/memory/0
 	# echo $$ > /sys/fs/cgroup/memory/0/tasks
 
-Since now we're in the 0 cgroup, we can alter the memory limit::
+4. Since now we're in the 0 cgroup, we can alter the memory limit::
 
 	# echo 4M > /sys/fs/cgroup/memory/0/memory.limit_in_bytes
 
+   The limit can now be queried::
+
+	# cat /sys/fs/cgroup/memory/0/memory.limit_in_bytes
+	4194304
+
 .. note::
    We can use a suffix (k, K, m, M, g or G) to indicate values in kilo,
    mega or gigabytes. (Here, Kilo, Mega, Giga are Kibibytes, Mebibytes,
@@ -422,10 +422,6 @@ Since now we're in the 0 cgroup, we can alter the memory limit::
 .. note::
    We cannot set limits on the root cgroup any more.
 
-::
-
-  # cat /sys/fs/cgroup/memory/0/memory.limit_in_bytes
-  4194304
 
 We can check the usage::
 
-- 
An old man doll... just what I always wanted! - Clara

