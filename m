Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAE265ECBC
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 14:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjAENRw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 08:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjAENRZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 08:17:25 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9A95DE5C;
        Thu,  5 Jan 2023 05:17:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n12so26924989pjp.1;
        Thu, 05 Jan 2023 05:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcgLa2dNrRbbB5gOhzfJxjnV71pkRRr18/tvuPVFK50=;
        b=keDd3AgPUHBkhQi+rsF5VDBfEFxkbSMl3Vqw0PYwH/URI1zS8RogSrFV/8SHOT2rcb
         I133BM/nD4wJ1EadTEgtSEDHDPrcig04g3dNQ4nfkqx1gvITJcygp7HgRmME0VppT5i5
         8g7EWVT/saKRIoUp1ZIB7M2O49HAmxkadDEdEUWyUhIldVpmt2TD6k1XYn5vN+l4y0t+
         w5uhh7NvkckKzoRXRBq2lpxu28RhgpVqRYPd9uRQhoPdfLt59iM9m5mpmZVpxojBFHUU
         kKNdT2f3FiEZjnlOWzwCzGTfAEwvYMLKN2ON1apQj+lEfgkbpdE1RfunoE+Bbj/ZZ3aU
         1R0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcgLa2dNrRbbB5gOhzfJxjnV71pkRRr18/tvuPVFK50=;
        b=nimXTESkTyg87YRB03Cqtu6aQxviw7gE338s9xal+N5+yMZkHMWYsix/zcq3gCKhdf
         MPaxZgSP9ZLLPFlN5uXQ7mRSLKVbvAGtqPteAkxur7CvkWFgw+UA6ZATKfm4v39fYzJI
         03wXcOUbAcjGvVXY/+bxCqL53IAsTGKhRzM1Mby79E3hLirccOCCrEkeKwr86LnkpBp9
         IrovuilJUMmF+zZ9a15BfCdaqcj+xbsDzndyqHag1i5grrNICG5w4NBzOrIyAirfRtwE
         Qzm/KbfqLNfAY5aU3G3Qok5bJEFs6fm6JkDy41EsQMOx8aKi+a8BTAg3haEzlyt5ujQS
         Nlww==
X-Gm-Message-State: AFqh2krtwy0NmnMWfEso9LbEbD8CJTJ3LoTs3JnURf2gmwG6qwbNBGQR
        CFpkn++R0jCDVNyrMapalMc=
X-Google-Smtp-Source: AMrXdXtglOj8A4JpjzospA6ZVS8xDhDFh3sS/+n6zUQ0COioBhiZcJZTWPZZ7RtTN+bsVQJ0rOvuEA==
X-Received: by 2002:a17:902:d491:b0:192:b40b:e41 with SMTP id c17-20020a170902d49100b00192b40b0e41mr33019419plg.61.1672924628393;
        Thu, 05 Jan 2023 05:17:08 -0800 (PST)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id u14-20020a170903124e00b001911e0af95dsm25982139plh.240.2023.01.05.05.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:17:07 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 1616D104F84; Thu,  5 Jan 2023 20:16:59 +0700 (WIB)
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
Subject: [PATCH v2 4/9] docs: cgroup-v1: fix footnotes
Date:   Thu,  5 Jan 2023 20:16:29 +0700
Message-Id: <20230105131633.553574-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105131633.553574-1-bagasdotme@gmail.com>
References: <20230105131633.553574-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4564; i=bagasdotme@gmail.com; h=from:subject; bh=Li+17qbQJgnbNb0Pbpw9z8Zmcq62SZTQcF9sfN0MfPE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnbzq6P9OrLP7vybP+GlXoHvU8ZyVxYFBl27qn5hBWm9b4h Kzo1O0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRl/4M/4wTt0d1cuy3W33uwGLZ0q yehNM3tp7XkOpxUg0Ofe9xdicjQ2d5hGC1K1+WwIaTC+q3+EedWJbbzfbB321yw8oapQW9bAA=
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
index 2b807fc128c662..8d1cedcf44f6ea 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -23,7 +23,7 @@ Benefits and Purpose of the memory controller
 =============================================
 
 The memory controller isolates the memory behaviour of a group of tasks
-from the rest of the system. The article on LWN [12] mentions some probable
+from the rest of the system. The article on LWN [12]_ mentions some probable
 uses of the memory controller. The memory controller can be used to
 
 a. Isolate an application or a group of applications
@@ -107,16 +107,16 @@ Brief summary of control files.
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
@@ -960,15 +960,16 @@ commented and discussed quite extensively in the community.
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
@@ -978,7 +979,8 @@ References
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

