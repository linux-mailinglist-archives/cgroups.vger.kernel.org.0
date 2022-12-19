Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD63B65070E
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 05:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiLSEWe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 23:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiLSEWY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 23:22:24 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ECF65AD;
        Sun, 18 Dec 2022 20:22:23 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d7so7839247pll.9;
        Sun, 18 Dec 2022 20:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eJ0PgV9osw1yzCFjYcppkmXI1mNsCk3sVd7FF32JKk=;
        b=DWj2vrOsmcNcemOcEX+STJ0rY9zglo4HAd+kl6qkuHXYj1Wn+icY7bqhzZvQZPEXZq
         q2GE6FnBygHaxi5XvVdiki3g+eQJkl7gjZr1Q4aOMaIIXj2g3RiKjVlAvHdORhkzVuS4
         LKCmZkz7m3E1QfHnWerxeT51zEUy73Fa3T0MnAL2nY3N6bvLyTDW6zbbK3pew4Out7Z8
         jjk1A2g/g70jdwVtmUF1V58q7Edd24yVBJgNwr+kfc2MrzW3xE/q5mUuXT3zwr81YB8D
         3Nk2RzYCxxS+IpdEdLaruJm43t6qLYaz2ZiHbbSop+4Xt9I921ssalMCYn48uELg73fN
         NQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eJ0PgV9osw1yzCFjYcppkmXI1mNsCk3sVd7FF32JKk=;
        b=H8fJJDwoFf8MoP4bs39YEVUJmh+q6PsUEzZJuhWhF3kr9ppk3ixxU4fj5Dz37ea3Sw
         QC6ENsX9XqFbyzHER/SwXBQi9hf53OyTbHmQsfBs/hyfC3rf+mK4A2rR2XmwEmJwr2Mh
         o3lk8D48sOKoTxpIwZFd3wddD65g+fqi/uTjozYZcKfUxiOjfRFnvaeW5CfVQC3XOTi2
         1r3W+x8OUS/DQR164YTMKu5I+EOYAruT9zIjesUNUn5VdnhfY4Umv9BqmokK90hKogYu
         9T1fIi48tqcPWW4wNb4XAqUaf1qzCUL9qbfGuMnSLZNfeREwGb9LOMtfy3H1bmCCxXJU
         f0Rg==
X-Gm-Message-State: ANoB5pk0MadVFRLY2HLROns3yUDRnFBDdiCaUtZvB2yGauLv0ceKnJFd
        Fvk44EjibODXbR3bMdmvvpc=
X-Google-Smtp-Source: AA0mqf5MV88rivDFHbXAo0wF1vc9fTd9ZJ8yZVxW/J5PoxzMPwtuA4ml+Kh2ZZH4Hkxwpc1lxQbtzg==
X-Received: by 2002:a17:90a:d24f:b0:219:251f:d92d with SMTP id o15-20020a17090ad24f00b00219251fd92dmr42619785pjw.9.1671423743042;
        Sun, 18 Dec 2022 20:22:23 -0800 (PST)
Received: from debian.me (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id h22-20020a17090a055600b0021e1c8ef788sm6768182pjf.51.2022.12.18.20.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 20:22:22 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 50B64103F77; Mon, 19 Dec 2022 11:22:14 +0700 (WIB)
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
Subject: [PATCH 10/10] docs: cgroup-v1: use numbered lists for user interface setup
Date:   Mon, 19 Dec 2022 11:22:09 +0700
Message-Id: <20221219042209.22898-11-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017; i=bagasdotme@gmail.com; h=from:subject; bh=haqtoEyuEFE5UnwPbflPC/PeHSHq/t5MqztTHGRMvxU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnzn31Yu6nM4+SR7DS266m3vv0SYTkjskqKnT1/2vb+2c+E 01fc6ihlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEtCIYGSby1km+5D6Wv99W4+3DqV 9jop/ITFCZJ+BRZbfuSIH2LT6Gf7q/dRxd+6+pLdU36Xr6wNKyY9lSKyVHrU1bSjdLNW26yQIA
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
index ae3a1d3873d73b..8cd46525b19c2e 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -389,30 +389,30 @@ U != 0, K >= U:
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
@@ -424,10 +424,6 @@ Since now we're in the 0 cgroup, we can alter the memory limit::
 .. note::
    We cannot set limits on the root cgroup any more.
 
-::
-
-  # cat /sys/fs/cgroup/memory/0/memory.limit_in_bytes
-  4194304
 
 We can check the usage::
 
-- 
An old man doll... just what I always wanted! - Clara

