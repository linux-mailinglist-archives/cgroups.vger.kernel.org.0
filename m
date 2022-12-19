Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7682365070B
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 05:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiLSEWb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 23:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiLSEWW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 23:22:22 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA60F64D1;
        Sun, 18 Dec 2022 20:22:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so7702812pjo.3;
        Sun, 18 Dec 2022 20:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEwa20X9A+wyrh3eoohiFgEbSAwTbPLRyuDyRq0+iJI=;
        b=II0wTtuXbBN9IR3zSvAIoImZqLWv0Oeuf04Gufnq1MigHIf67TLDV0jn7TB8epZsFl
         3sobPQazNVCSNREFsj+waKJmepN4RKRGv5jKhGOO8xQ3FeFMzjxswnj+wJX6zJuVVKtD
         vRlBDOOCXf+uqa8v4WjUjVsV5efjC6QCtCju7xnXLNyCWjRxDOx84+zksXWKn2HTT2Hc
         VEhTup0H5OoAJZe17tUKAxcqCseN4njXFE8lC38/Jk2FkFYYKlooS+tYXbKC8MZgXjKQ
         bg0846Fhh86noJjama1Be+g7Al4PFbe0WtzrpNcNqNgtBIbwrZHUf37b32x+NPmZMMOX
         0zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEwa20X9A+wyrh3eoohiFgEbSAwTbPLRyuDyRq0+iJI=;
        b=oZ9M0cpmBrzXiZr+cjRfWGf0gHOWYHt/yOGVHMN305abHSGOAVB2QGZs4oCVwuUSBy
         2LpFRh7gOWcfXSF1o/hn4bNt8mqbweBGZrlv43c/6cj7tDbfRZ5Fo9HjQSqo+ypSVH9c
         RGyjqbhzaqYMGxtYhb0wjV6RMXTEdMq+1WP6zggLE2hNYd8WkdBJ41B13LH1iXnHnFNW
         wI/9Rezu7WmQAAawFuWVGRzrWnhDww/ru0Z1TNvjL+/Hr+N/iaxnqy6REMNupEJewYoB
         ciLp6ac3dXfppOkm8srSAFSKQsYJVh6Pvq3778mKw/2UiT18skM63fNSGRdhDZAHAABD
         4b2Q==
X-Gm-Message-State: AFqh2kqdMVbPiTJwONReXsuTVTo7ZsJaHV6rEUc7ighyClO+b+E98iyT
        6L++o1cNlbhv6YFDcTbKLU4=
X-Google-Smtp-Source: AMrXdXsGNlWGG3n6vP6It4uosK23dRFLrGgn17glXzSNE6kRoir89VzcMFMpQ7rLtZjdeTa4FFao4g==
X-Received: by 2002:a17:902:c187:b0:186:fb90:573d with SMTP id d7-20020a170902c18700b00186fb90573dmr8523902pld.3.1671423739989;
        Sun, 18 Dec 2022 20:22:19 -0800 (PST)
Received: from debian.me (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902f35100b00187197c499asm5882262ple.164.2022.12.18.20.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 20:22:19 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 93250101314; Mon, 19 Dec 2022 11:22:13 +0700 (WIB)
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
Subject: [PATCH 05/10] docs: cgroup-v1: fix footnotes
Date:   Mon, 19 Dec 2022 11:22:04 +0700
Message-Id: <20221219042209.22898-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4564; i=bagasdotme@gmail.com; h=from:subject; bh=JPQvjZYEry5PAqc04yDM29al0BTsUtfNTgHs2tjYRDY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnzn713s2ALYv7Qur7Z8OQ8xUPaUbXSj7TzHyttWtb8Zc7r WimDjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEyk8gHDP8uTjBf7tATssl9F6ut+mL 3WS/eK9VIWiadnj+7WDqq+JsHIcEb+29LkV/o8IVzfVV5WSz7+2/dD1uj8A4E/ce+mWqx1ZAIA
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

The documentation contains external references, which some of them are
marked as footnotes. Fix the syntax for them to be properly rendered as
such.

Non-footnote references aren't affected since the text for these is
aligned the same to the footnotes.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../admin-guide/cgroup-v1/memory.rst          | 36 ++++++++++---------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index c21ce0b906059f..642ef0bb20380a 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -23,7 +23,7 @@ Benefits and Purpose of the memory controller
 =============================================
 
 The memory controller isolates the memory behaviour of a group of tasks
-from the rest of the system. The article on LWN [12] mentions some probable
+from the rest of the system. The article on LWN [12]_ mentions some probable
 uses of the memory controller. The memory controller can be used to
 
 a. Isolate an application or a group of applications
@@ -109,16 +109,16 @@ Brief summary of control files.
 ==========
 
 The memory controller has a long history. A request for comments for the memory
-controller was posted by Balbir Singh [1]. At the time the RFC was posted
+controller was posted by Balbir Singh [1]_. At the time the RFC was posted
 there were several implementations for memory control. The goal of the
 RFC was to build consensus and agreement for the minimal features required
-for memory control. The first RSS controller was posted by Balbir Singh[2]
-in Feb 2007. Pavel Emelianov [3][4][5] has since posted three versions of the
-RSS controller. At OLS, at the resource management BoF, everyone suggested
-that we handle both page cache and RSS together. Another request was raised
-to allow user space handling of OOM. The current memory controller is
+for memory control. The first RSS controller was posted by Balbir Singh [2]_
+in Feb 2007. Pavel Emelianov [3]_ [4]_ [5]_ has since posted three versions
+of the RSS controller. At OLS, at the resource management BoF, everyone
+suggested that we handle both page cache and RSS together. Another request was
+raised to allow user space handling of OOM. The current memory controller is
 at version 6; it combines both mapped (RSS) and unmapped Page
-Cache Control [11].
+Cache Control [11]_.
 
 2. Memory Control
 =================
@@ -971,15 +971,16 @@ commented and discussed quite extensively in the community.
 References
 ==========
 
-1. Singh, Balbir. RFC: Memory Controller, http://lwn.net/Articles/206697/
-2. Singh, Balbir. Memory Controller (RSS Control),
+.. [1] Singh, Balbir. RFC: Memory Controller, http://lwn.net/Articles/206697/
+.. [2] Singh, Balbir. Memory Controller (RSS Control),
    http://lwn.net/Articles/222762/
-3. Emelianov, Pavel. Resource controllers based on process cgroups
+.. [3] Emelianov, Pavel. Resource controllers based on process cgroups
    https://lore.kernel.org/r/45ED7DEC.7010403@sw.ru
-4. Emelianov, Pavel. RSS controller based on process cgroups (v2)
+.. [4] Emelianov, Pavel. RSS controller based on process cgroups (v2)
    https://lore.kernel.org/r/461A3010.90403@sw.ru
-5. Emelianov, Pavel. RSS controller based on process cgroups (v3)
+.. [5] Emelianov, Pavel. RSS controller based on process cgroups (v3)
    https://lore.kernel.org/r/465D9739.8070209@openvz.org
+
 6. Menage, Paul. Control Groups v10, http://lwn.net/Articles/236032/
 7. Vaidyanathan, Srinivasan, Control Groups: Pagecache accounting and control
    subsystem (v3), http://lwn.net/Articles/235534/
@@ -989,7 +990,8 @@ References
    https://lore.kernel.org/r/464D267A.50107@linux.vnet.ibm.com
 10. Singh, Balbir. Memory controller v6 test results,
     https://lore.kernel.org/r/20070819094658.654.84837.sendpatchset@balbir-laptop
-11. Singh, Balbir. Memory controller introduction (v6),
-    https://lore.kernel.org/r/20070817084228.26003.12568.sendpatchset@balbir-laptop
-12. Corbet, Jonathan, Controlling memory use in cgroups,
-    http://lwn.net/Articles/243795/
+
+.. [11] Singh, Balbir. Memory controller introduction (v6),
+   https://lore.kernel.org/r/20070817084228.26003.12568.sendpatchset@balbir-laptop
+.. [12] Corbet, Jonathan, Controlling memory use in cgroups,
+   http://lwn.net/Articles/243795/
-- 
An old man doll... just what I always wanted! - Clara

