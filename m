Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085B5650711
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 05:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiLSEWg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 23:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiLSEWY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 23:22:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C122B7DD;
        Sun, 18 Dec 2022 20:22:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so7721943pjm.2;
        Sun, 18 Dec 2022 20:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szBp/K72BE8/BicOSwRE0ZIF4ays06I72BistI/53Pk=;
        b=U8mV2UMqqjrK76pglD8zq0C3ETUIxiTKnqdujwOR1qcvaxNfhqdcHidmBUWAcceOzr
         y+Suw92hyd+cGnMxdplh2Zbh/USuOlHnACokA+9qPliCRmT3CwZK1r7vEHS4fS/8lpwW
         rrUnQpmiPj2h/meLZp8vgu8PHs0S3QalFVHJh1AJRCji5YGu1wpEjCICHGPLZvnmIJnM
         jDBTxQVTtcluZTysxPluqLoFbhmLlIxw5zWp9dHVlhkRyLhCW5xG9LptVj7zoxUOqE5d
         dzytGhmBIrO+zIgiFqlSKYE3HSILCOMh7bDi1pEmu/rC1qR83Lu5voDaYXHisXoGJ15K
         JMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szBp/K72BE8/BicOSwRE0ZIF4ays06I72BistI/53Pk=;
        b=Romy1HmaH2P81gJLXKbApAnBp0Ftf663qhHBQGjl+CryBzN1wLoc+ugr1ITdNtLRFl
         eJAdTv67nX/5SwKPaZovd49C11XVWeHXAaswf8sMYZswdm37Rc7BahRApWcHfZTFknb1
         v4aPQXTw3+EKaO2ApKoxGO/bZyrjLoqHkVGQkxNRS2qlfcHv40Bt8ER/VOCmxpYHxPIL
         CNAjyrKREO5LsC5fKA4qvZjBEnRn97XIx5OByYJyQUicwZQa/ledn7nLdIFEvJii0MVU
         FK+tJ1+GwCRegIvE2r8IaIOPb+rkswUn+EQSfQYA2cmxgPJQt6MKF8kUybYR6LLG4dmN
         yOfw==
X-Gm-Message-State: AFqh2krE5kXBsfSnhO7+Fd4WICPrmjQVuKGQVgCGFdpFXoE6oWeLzheq
        hiswr+3gN1FYO4mahRq7ajw=
X-Google-Smtp-Source: AMrXdXsaWnf+YsPfG0kbNpKSn0wN8/z9T5tw2wVXv1UitQlm7avF6zIUjxIy0Ns5NvJMeue6JNod5Q==
X-Received: by 2002:a05:6a20:8f01:b0:af:e891:f4cb with SMTP id b1-20020a056a208f0100b000afe891f4cbmr15555056pzk.27.1671423743336;
        Sun, 18 Dec 2022 20:22:23 -0800 (PST)
Received: from debian.me (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id a3-20020aa794a3000000b005750d6b4761sm5349770pfl.168.2022.12.18.20.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 20:22:22 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 0136F103F5F; Mon, 19 Dec 2022 11:22:13 +0700 (WIB)
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
Subject: [PATCH 02/10] docs: cgroup-v1: replace custom note constructs with appropriate admonition blocks
Date:   Mon, 19 Dec 2022 11:22:01 +0700
Message-Id: <20221219042209.22898-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5301; i=bagasdotme@gmail.com; h=from:subject; bh=9M2vbQHkCDEOiNLeCwV/da0jjZmiwfDhmvzgespqc+I=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnzn727o/DpacD63LWPLCMXrVpgbzrTSVndwerLZ8EPS6Lv /NTO7ChlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEHlxg+O/IYedZt37L7my1VOdDb8 21Go2P8c1/+5VdziZaPcWJ+yojw60tUjpXliw1T/4m5S1/XfZ4gcXjkL/NL7cphRcGcJ1mYgAA
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

Admonition constructs on the documentation use definition lists, which
isn't fit for the purpose. Replace them with appropriate blocks:

  * Use caution:: for outdated document notice
  * hint:: for memo
  * note:: for other constructs
  * warning:: for memory reclaim

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../admin-guide/cgroup-v1/memory.rst          | 58 ++++++++++---------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 258e45cc3b2db1..ec99bcbd55c2e7 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -2,13 +2,13 @@
 Memory Resource Controller
 ==========================
 
-NOTE:
+.. caution::
       This document is hopelessly outdated and it asks for a complete
       rewrite. It still contains a useful information so we are keeping it
       here but make sure to check the current code if you need a deeper
       understanding.
 
-NOTE:
+.. note::
       The Memory Resource Controller has generically been referred to as the
       memory controller in this document. Do not confuse memory controller
       used here with the memory controller that is used in hardware.
@@ -276,12 +276,12 @@ The reclaim algorithm has not been modified for cgroups, except that
 pages that are selected for reclaiming come from the per-cgroup LRU
 list.
 
-NOTE:
-  Reclaim does not work for the root cgroup, since we cannot set any
-  limits on the root cgroup.
+.. note::
+   Reclaim does not work for the root cgroup, since we cannot set any
+   limits on the root cgroup.
 
-Note2:
-  When panic_on_oom is set to "2", the whole system will panic.
+.. note::
+   When panic_on_oom is set to "2", the whole system will panic.
 
 When oom event notifier is registered, event will be delivered.
 (See oom_control section)
@@ -369,10 +369,10 @@ U != 0, K < U:
     never greater than the total memory, and freely set U at the cost of his
     QoS.
 
-WARNING:
-    In the current implementation, memory reclaim will NOT be
-    triggered for a cgroup when it hits K while staying below U, which makes
-    this setup impractical.
+    .. warning::
+       In the current implementation, memory reclaim will NOT be triggered for
+       a cgroup when it hits K while staying below U, which makes this setup
+       impractical.
 
 U != 0, K >= U:
     Since kmem charges will also be fed to the user counter and reclaim will be
@@ -407,16 +407,16 @@ Since now we're in the 0 cgroup, we can alter the memory limit::
 
 	# echo 4M > /sys/fs/cgroup/memory/0/memory.limit_in_bytes
 
-NOTE:
-  We can use a suffix (k, K, m, M, g or G) to indicate values in kilo,
-  mega or gigabytes. (Here, Kilo, Mega, Giga are Kibibytes, Mebibytes,
-  Gibibytes.)
+.. note::
+   We can use a suffix (k, K, m, M, g or G) to indicate values in kilo,
+   mega or gigabytes. (Here, Kilo, Mega, Giga are Kibibytes, Mebibytes,
+   Gibibytes.)
 
-NOTE:
-  We can write "-1" to reset the ``*.limit_in_bytes(unlimited)``.
+.. note::
+   We can write "-1" to reset the ``*.limit_in_bytes(unlimited)``.
 
-NOTE:
-  We cannot set limits on the root cgroup any more.
+.. note::
+   We cannot set limits on the root cgroup any more.
 
 ::
 
@@ -576,12 +576,12 @@ recent_scanned_anon	  VM internal parameter. (see mm/vmscan.c)
 recent_scanned_file	  VM internal parameter. (see mm/vmscan.c)
 ========================= ========================================
 
-Memo:
+.. hint::
 	recent_rotated means recent frequency of LRU rotation.
 	recent_scanned means recent # of scans to LRU.
 	showing for better debug please see the code for meanings.
 
-Note:
+.. note::
 	Only anonymous and swap cache memory is listed as part of 'rss' stat.
 	This should not be confused with the true 'resident set size' or the
 	amount of physical memory used by the cgroup.
@@ -712,10 +712,11 @@ If we want to change this to 1G, we can at any time use::
 
 	# echo 1G > memory.soft_limit_in_bytes
 
-NOTE1:
+.. note::
        Soft limits take effect over a long period of time, since they involve
        reclaiming memory for balancing between memory cgroups
-NOTE2:
+
+.. note::
        It is recommended to set the soft limit always below the hard limit,
        otherwise the hard limit will take precedence.
 
@@ -744,17 +745,20 @@ If you want to enable it::
 
 	# echo (some positive value) > memory.move_charge_at_immigrate
 
-Note:
+.. note::
       Each bits of move_charge_at_immigrate has its own meaning about what type
       of charges should be moved. See 8.2 for details.
-Note:
+
+.. note::
       Charges are moved only when you move mm->owner, in other words,
       a leader of a thread group.
-Note:
+
+.. note::
       If we cannot find enough space for the task in the destination cgroup, we
       try to make space by reclaiming memory. Task migration may fail if we
       cannot make enough space.
-Note:
+
+.. note::
       It can take several seconds if you move charges much.
 
 And if you want disable it again::
-- 
An old man doll... just what I always wanted! - Clara

