Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A8D65ECB7
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 14:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjAENRs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 08:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjAENRZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 08:17:25 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706705B14B;
        Thu,  5 Jan 2023 05:17:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ge16so36167856pjb.5;
        Thu, 05 Jan 2023 05:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEyDN1DoPB92rHtz9Bu6YtukEjhpZoR1SaNfSfYIFW4=;
        b=KZ7VuUCIf/RIhfW0Ha0Xh1OvaTK8RR2Ace8AZf12WVCOnGaDE++Tuix77O0TG+tqiI
         UWbd7O/vXR0K9zscx6A2zOnv4chr/TVaiURpCNyhxVrNgpvVq+IGIwz7lfE/M1oPlINT
         NOImTaNK7y8SYUX9EPUpfeB+pyGG+UOwZJWLFHpvj9UKA2txvhk4n80kTWxu4ASs586K
         ZZEhS3Z5gKACg1SwAWYMQXZ6lTapo9WARtjcGi9fJorXpCMpiMmKe1majuwpBybQ57ct
         aDlKlivxjCkkztxSPZMmfGBDQO3qVzGV7zDAJZOreudO+D52wAYUJ/ZO0UBifALXXsuJ
         P4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEyDN1DoPB92rHtz9Bu6YtukEjhpZoR1SaNfSfYIFW4=;
        b=WmPjIh7eScAtC/HYbTXFef6wn9on4prUXmkGrW/QMaCVKinEx2zDhL4bFHENdc0nA+
         V6s+BvnKRj/AkPEk323CDmFtj4AYN8phJ61jj+h6BNETlwGgQ8JA2RTXXZTWASo0bxIC
         7mvWVNdrTxnJbw+MODf7bRSvYpl6pRluP8RvJdpmg+QVj7JP0vvs6iJAO2rtvGENrkZq
         Y9/MDbJTYSouOxZlRhQSzFRIT8O3FNGtlr72CD1yBTRujlS7Sf1pS3BrL+HA//Hlr6ut
         Jo88H+rLW0gx8wRVR4not2jU1ZFespbBYFtVnxVAkSYQBnUpNk55aU1NY89asHs4YrCA
         92HA==
X-Gm-Message-State: AFqh2kpYWx6bWJ+O89VOO0RG/+ytorA7wUg5/qzszP9QqZM6+lB+1TUw
        wP1HxqbSflCW/ycueQydTfQ=
X-Google-Smtp-Source: AMrXdXua9EXcDqeZze7Fj7qX9Z1Mtd3h5heZGEbc9ZeNK053ZyPPuHU+uBZFwPujwGzBi1MnYiCLlQ==
X-Received: by 2002:a17:90a:e545:b0:226:2332:a3fd with SMTP id ei5-20020a17090ae54500b002262332a3fdmr29442612pjb.5.1672924626731;
        Thu, 05 Jan 2023 05:17:06 -0800 (PST)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id nn2-20020a17090b38c200b001df264610c4sm4161995pjb.0.2023.01.05.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:17:05 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 7BD531042DE; Thu,  5 Jan 2023 20:16:59 +0700 (WIB)
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
Subject: [PATCH v2 1/9] docs: cgroup-v1: replace custom note constructs with appropriate admonition blocks
Date:   Thu,  5 Jan 2023 20:16:26 +0700
Message-Id: <20230105131633.553574-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105131633.553574-1-bagasdotme@gmail.com>
References: <20230105131633.553574-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5301; i=bagasdotme@gmail.com; h=from:subject; bh=DlZUnry3AswBM9GzCcO9SGcvMxRqxgXh0Yg3NkkBNXs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnbzq6zkfwiJlWTZq4w3UpyzsfuB5u2XBOcKPWCf9efiZ8l TRiEO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRxUsZfrPHF16fd5hv0fNbsQuerm Hv9+Q/dKNXRJdnxrNENY8Iw9UM/9359n8NbLm8K+J17eds1aCraype/s+5+KVnt4jYtvkLeVgB
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
index 60370f2c67b99c..d0d8c780cb6bd9 100644
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
@@ -274,12 +274,12 @@ The reclaim algorithm has not been modified for cgroups, except that
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
@@ -367,10 +367,10 @@ U != 0, K < U:
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
@@ -405,16 +405,16 @@ Since now we're in the 0 cgroup, we can alter the memory limit::
 
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
 
@@ -574,12 +574,12 @@ recent_scanned_anon	  VM internal parameter. (see mm/vmscan.c)
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
@@ -710,10 +710,11 @@ If we want to change this to 1G, we can at any time use::
 
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
 
@@ -735,17 +736,20 @@ If you want to enable it::
 
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

