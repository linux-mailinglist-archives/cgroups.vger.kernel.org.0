Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655F5650716
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 05:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiLSEWm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 23:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiLSEW0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 23:22:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A465BC;
        Sun, 18 Dec 2022 20:22:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u5so7819873pjy.5;
        Sun, 18 Dec 2022 20:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRDhbAuFFMtCfx+H7ZJIpQoYnynck5HVInZvHowpBNk=;
        b=aJ8LYUErJn/ZPG6EC26fQcgCJgiRXAOf+Wbw+PidOOWMUaiVUsUcSgo8htcy1YlFQ7
         5bm1d9ZM3R2uYEKryoIQ4t6aV5PBbAJSRU1yzOikLW9IDPs009uccbn2P3EEMCtnWvJR
         +CyqWbBcyowHmuqUUkGyOLvHs1ktvjGk7UMvLkomuT7rgqpvddtVJC/vMnYvTDSX4Uz9
         unhqp0K6PAkA6+9AIErzHE/RGpYjG/w/jfoTnxq83m5DMytP1sh8csjErB9nFyUidNm+
         woDrW5wk2XJcVeUrU1oFu23rb7xClFXHHQdRWDYcarrITAEVGSjXIOwCNx5JycJ7tL5+
         /HOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRDhbAuFFMtCfx+H7ZJIpQoYnynck5HVInZvHowpBNk=;
        b=bcywHCPh7axeisrc5YGteKjrtZDDc2NLkxdQhJ/cObMs2wM+7UBtSDJnYAvItExPhK
         rK24tm+V40xE2afERfITvPPl8PMyvfEhUBENcGIElxGYJdQ8HfIekVP7L/oYjIxStsps
         /By5+61R+BWGP87bqggWFDzBxoaZNPRmFU5ziTEVOr6DR4aP3zAeSEE8sz2WwEmni/Al
         /4Toa1JAsouSz2BsLKJ2emEwSupT8xVfiVCBSatRH9s79XbrmjZOiZ/6vlOXJpv4MVMW
         5r2ip8++DUutYrmgMqaAF3kFf1pYymx5e7BGst9W9ClKLjKq/oloV2rbWPb8wgimntn4
         9GjA==
X-Gm-Message-State: ANoB5pknj+buOToeQ6E8bZFIT53p3muC56dS9v0gYtbm/Oi7eouLEFhF
        7sCUD1kQkJ1yfx7ip6ul2VA=
X-Google-Smtp-Source: AA0mqf50Q60/cHOKADaVTGJceXn1H4SLjSKCSi1WgOTYDrJ97ZGoPbiT1Y4BH9GfoxR8lLFlpaar3Q==
X-Received: by 2002:a17:90a:1b0b:b0:219:396c:9e32 with SMTP id q11-20020a17090a1b0b00b00219396c9e32mr43342946pjq.16.1671423745034;
        Sun, 18 Dec 2022 20:22:25 -0800 (PST)
Received: from debian.me (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id nn11-20020a17090b38cb00b00212cf2fe8c3sm16638727pjb.1.2022.12.18.20.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 20:22:23 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 1437210164A; Mon, 19 Dec 2022 11:22:14 +0700 (WIB)
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
Subject: [PATCH 07/10] docs: cgroup-v1: use bullet lists for list of stat file tables
Date:   Mon, 19 Dec 2022 11:22:06 +0700
Message-Id: <20221219042209.22898-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6795; i=bagasdotme@gmail.com; h=from:subject; bh=Qv/IUrGqp6BPq2cwpkOiVBXASeOlAsriWizhHWQnHq4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnzn703LdK1T/66R/jyZrvEyVzW0yr0r//Oum3vofGLRydv z+/ijlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExk+lVGhjki233c9qqJ3Zpyt+jn+o gkR7uyW9yffms/71tXPOvhEVZGhmurJaxWvK0rVNIV2j5n64a4vZzP7l50Cfn0u+h7TswiJh4A
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
index 3b365a72996be5..01104b459b4cbd 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -521,60 +521,59 @@ will be charged as a new owner of it.
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

