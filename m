Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991FF65ECBF
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 14:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjAENRv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 08:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbjAENRY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 08:17:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA5A5DE54;
        Thu,  5 Jan 2023 05:17:08 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z4-20020a17090a170400b00226d331390cso880502pjd.5;
        Thu, 05 Jan 2023 05:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwHqK93GBSz13u5EOGerS6VNG9qcHKdmktoqbjmWNKQ=;
        b=I+haejsbxcT8QansUCm5NiZgqf2JOyk2XoX+L9ANWJ+oZ3TVmy88uTaaDIAnH60Se4
         QC+8pZ1DVABAn9fbxX+01giMJL8QxVbK5JPMK71xZAR5l7hIoZ2HXOLK7XsTFATW8Ixz
         q5RKiApAiRwuaEXAif1bny8NJyICU1d5b6cBVkt8ozpHIt9kHXCkiP5RwaeGheITxLGD
         pv66I/8vKCfVNCU4pCKkHXOn0aYd0sZ7fEE9fRKjDaTaPdM6tDTlOWpzJaqe86/t7zq+
         J5IuSSFoT4VVRLtFO79+qqLr4ipbuvJqdL0XtgxljHoOaC9wrD8egICm691ltJy92+D9
         o4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwHqK93GBSz13u5EOGerS6VNG9qcHKdmktoqbjmWNKQ=;
        b=SZRBhVmMiC4AjJNitA9UaZdgmV30LZMKQezwkz5tDXHWz/udwr3M8Aa8QpvL2x3GDB
         OKjfOBJHDi/8cycQzScM7NZqHn09tg1F5iz66FS5eO49DC+vVZUuO5EsP8ub3rNBiW6j
         fmlfUGc5UmbiuN2bB+KlJ/odLi3f8xD4PaUS28ODP7bIj7wzYG5yFcJveL6W8XTPLpQt
         jRC0mRMNpmmPj9iIe5VnlrElJyQBqol+OmjNw5TIx8S8cS5fb+Cx8MBqL4DgFM6fRgiu
         MOWXnYaFP/DhHhfoczflMfQ63cCS1kzPtGFXOM8ViPRWJxrI+TgMPMJ2OdkTukwLKZef
         FU9Q==
X-Gm-Message-State: AFqh2kqHDB8d86kMEpNJ957J0joXeNftD/JhnaWuNnOMVaWCn0Dnrs0P
        THHqOh0b6NLtZlcG6C13ulc=
X-Google-Smtp-Source: AMrXdXvVQHFIAhZFjXWcvmWsd4zYjHp8TCtZNuDhrgXiXGz/KDF8sgcU0cuj/xK31xQp+cbn98HKDw==
X-Received: by 2002:a17:90b:4a8c:b0:225:a8f2:fa38 with SMTP id lp12-20020a17090b4a8c00b00225a8f2fa38mr51004080pjb.21.1672924627951;
        Thu, 05 Jan 2023 05:17:07 -0800 (PST)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id h6-20020a63c006000000b00478b930f970sm21709710pgg.66.2023.01.05.05.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:17:07 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2BC92104C58; Thu,  5 Jan 2023 20:17:00 +0700 (WIB)
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
Subject: [PATCH v2 6/9] docs: cgroup-v1: use bullet lists for list of stat file tables
Date:   Thu,  5 Jan 2023 20:16:31 +0700
Message-Id: <20230105131633.553574-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105131633.553574-1-bagasdotme@gmail.com>
References: <20230105131633.553574-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6795; i=bagasdotme@gmail.com; h=from:subject; bh=SoIEcDdcT5n5ldqzkBmfedkjJd/EdMw6QuqYA3S+KDs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnbzm6ofK+yRrC/JWDHq/r1ulxRxxxnKLB3/v5w8IjPvxk1 Z7pEOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjAR325GhpZFRVP+NhbwxQf07X/ULH dQqH2NpZHRx3nVQsUaj+IvuTD8z7n7YJ5tTpdh076r6d6G/05xbVAXtfb+sau3RtPG+o4bBwA=
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

The stat file section contains three tables, where the leading texts for
them are subsection heading. Organize them in the bullet list, while
demoting headings into normal text.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../admin-guide/cgroup-v1/memory.rst          | 93 +++++++++----------
 1 file changed, 46 insertions(+), 47 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 4d96a5bbbfcfdc..162cc26dcddb25 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -519,60 +519,59 @@ will be charged as a new owner of it.
 5.2 stat file
 -------------
 
-memory.stat file includes following statistics
+memory.stat file includes following statistics:
 
-per-memory cgroup local status
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+  * per-memory cgroup local status
 
-=============== ===============================================================
-cache		# of bytes of page cache memory.
-rss		# of bytes of anonymous and swap cache memory (includes
-		transparent hugepages).
-rss_huge	# of bytes of anonymous transparent hugepages.
-mapped_file	# of bytes of mapped file (includes tmpfs/shmem)
-pgpgin		# of charging events to the memory cgroup. The charging
-		event happens each time a page is accounted as either mapped
-		anon page(RSS) or cache page(Page Cache) to the cgroup.
-pgpgout		# of uncharging events to the memory cgroup. The uncharging
-		event happens each time a page is unaccounted from the cgroup.
-swap		# of bytes of swap usage
-dirty		# of bytes that are waiting to get written back to the disk.
-writeback	# of bytes of file/anon cache that are queued for syncing to
-		disk.
-inactive_anon	# of bytes of anonymous and swap cache memory on inactive
-		LRU list.
-active_anon	# of bytes of anonymous and swap cache memory on active
-		LRU list.
-inactive_file	# of bytes of file-backed memory and MADV_FREE anonymous memory(
-                LazyFree pages) on inactive LRU list.
-active_file	# of bytes of file-backed memory on active LRU list.
-unevictable	# of bytes of memory that cannot be reclaimed (mlocked etc).
-=============== ===============================================================
+    =============== ===============================================================
+    cache           # of bytes of page cache memory.
+    rss             # of bytes of anonymous and swap cache memory (includes
+                    transparent hugepages).
+    rss_huge        # of bytes of anonymous transparent hugepages.
+    mapped_file     # of bytes of mapped file (includes tmpfs/shmem)
+    pgpgin          # of charging events to the memory cgroup. The charging
+                    event happens each time a page is accounted as either mapped
+                    anon page(RSS) or cache page(Page Cache) to the cgroup.
+    pgpgout         # of uncharging events to the memory cgroup. The uncharging
+                    event happens each time a page is unaccounted from the
+                    cgroup.
+    swap            # of bytes of swap usage
+    dirty           # of bytes that are waiting to get written back to the disk.
+    writeback       # of bytes of file/anon cache that are queued for syncing to
+                    disk.
+    inactive_anon   # of bytes of anonymous and swap cache memory on inactive
+                    LRU list.
+    active_anon     # of bytes of anonymous and swap cache memory on active
+                    LRU list.
+    inactive_file   # of bytes of file-backed memory and MADV_FREE anonymous
+                    memory (LazyFree pages) on inactive LRU list.
+    active_file     # of bytes of file-backed memory on active LRU list.
+    unevictable     # of bytes of memory that cannot be reclaimed (mlocked etc).
+    =============== ===============================================================
 
-status considering hierarchy (see memory.use_hierarchy settings)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+  * status considering hierarchy (see memory.use_hierarchy settings):
 
-========================= ===================================================
-hierarchical_memory_limit # of bytes of memory limit with regard to hierarchy
-			  under which the memory cgroup is
-hierarchical_memsw_limit  # of bytes of memory+swap limit with regard to
-			  hierarchy under which memory cgroup is.
+    ========================= ===================================================
+    hierarchical_memory_limit # of bytes of memory limit with regard to
+                              hierarchy
+                              under which the memory cgroup is
+    hierarchical_memsw_limit  # of bytes of memory+swap limit with regard to
+                              hierarchy under which memory cgroup is.
 
-total_<counter>		  # hierarchical version of <counter>, which in
-			  addition to the cgroup's own value includes the
-			  sum of all hierarchical children's values of
-			  <counter>, i.e. total_cache
-========================= ===================================================
+    total_<counter>           # hierarchical version of <counter>, which in
+                              addition to the cgroup's own value includes the
+                              sum of all hierarchical children's values of
+                              <counter>, i.e. total_cache
+    ========================= ===================================================
 
-The following additional stats are dependent on CONFIG_DEBUG_VM
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+  * additional vm parameters (depends on CONFIG_DEBUG_VM):
 
-========================= ========================================
-recent_rotated_anon	  VM internal parameter. (see mm/vmscan.c)
-recent_rotated_file	  VM internal parameter. (see mm/vmscan.c)
-recent_scanned_anon	  VM internal parameter. (see mm/vmscan.c)
-recent_scanned_file	  VM internal parameter. (see mm/vmscan.c)
-========================= ========================================
+    ========================= ========================================
+    recent_rotated_anon       VM internal parameter. (see mm/vmscan.c)
+    recent_rotated_file       VM internal parameter. (see mm/vmscan.c)
+    recent_scanned_anon       VM internal parameter. (see mm/vmscan.c)
+    recent_scanned_file       VM internal parameter. (see mm/vmscan.c)
+    ========================= ========================================
 
 .. hint::
 	recent_rotated means recent frequency of LRU rotation.
-- 
An old man doll... just what I always wanted! - Clara

