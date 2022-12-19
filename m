Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EB465071B
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 05:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiLSEWu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 23:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiLSEW1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 23:22:27 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3758B7DC;
        Sun, 18 Dec 2022 20:22:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d7so7839293pll.9;
        Sun, 18 Dec 2022 20:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1lEXUxDv+RQRfIU+EhWl1xsmh7T8TN0B09r+Rt+f6E=;
        b=mRDBpTfsKGJFj9sStOs+u6rafPXo1yrNY3co/JxzhxWdSf+Ee9lJP+AcKfTLxqHGJ7
         /ruFXJ54tEJ4/+rcvJpAXQGBvu8w2UNqb0qeXxzf0gv8Jkp/oTNCrG9/na5e2adVEq5C
         WuJOTPR+DvmUilQKp2CDo8N0Cc5zHA/oHv8XtyTh95Op/bEJ3NuqFA7gFCBB7/YTl1bk
         h8H9Tdq13+dru7pjLYX0hoC91Z+4PFfcpUS8bKiUP/j1BA+kOvIF7kF1ElNq7ehaveTa
         5BiBrlFzSwLanGEXndk8Nv7qoHt5phcg46YAkWLGp+UfoZmPVmgbEzGUnf4RnmEo06ab
         3+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1lEXUxDv+RQRfIU+EhWl1xsmh7T8TN0B09r+Rt+f6E=;
        b=PO/K8LULBP3GcnYr8nZgxpOmmkmF14R1oTVFcZ4gUdXqnGWF3svggDYkXwCFUJAJo6
         1IqmM3cHUW+1oiZiRplIxoJDpDLKV45LDBy13GTsjV6tLmpDlrSva2R0OSGGW6+XQ8eH
         2jaTSfW46s/65tDlTOJA6XIxkEbcZiG7P0/rVFrhAS5diaaTzL1J8eyseMwAnPXe/wyV
         2lPPrKSBiW8DDNtOD2KdauN50yd5/TxV+HpEw0wlBmyTQ3PRjRDDxSBe7a5lCx7bl7rr
         XpiL2E0Nch4hbV4A6WXoJSRIw9aZ4rxUc4ELn+kFKRYABSGhBRWPEKXelBPznFCU2B/0
         a5Dw==
X-Gm-Message-State: AFqh2krFR3LsXaMN+iFPTFHiiwdDeDKPaaZ2zO6loMyZevP9cIxsWzNq
        cT/so75CpSt4GYC/vqr0u4w=
X-Google-Smtp-Source: AMrXdXuHTIuf1k1NZ+BSaH+fLP88vjx6aUE1R2UTN8o/LCwMK8JQI/oHDBZOqtPYKI0Wdfg3I4Phqw==
X-Received: by 2002:a17:90a:b384:b0:213:b6c8:2295 with SMTP id e4-20020a17090ab38400b00213b6c82295mr7583508pjr.22.1671423745509;
        Sun, 18 Dec 2022 20:22:25 -0800 (PST)
Received: from debian.me (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090a5a0d00b0021806f631ccsm4817086pjd.30.2022.12.18.20.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 20:22:23 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 87729104054; Mon, 19 Dec 2022 11:22:14 +0700 (WIB)
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
Subject: [PATCH 09/10] docs: cgroup-v1: add internal cross-references
Date:   Mon, 19 Dec 2022 11:22:08 +0700
Message-Id: <20221219042209.22898-10-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5927; i=bagasdotme@gmail.com; h=from:subject; bh=9S/rkKjh7S+VIO4A14dIVvNcepKziJ1wiMcg1+yyND0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnzn33w62KZ2zBTurxBrqKy41HuS1ff56zOJzwbQ/9xeLTv dD3XUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIlYGTEyvOj691Dsls78a7/0WFe6uD IcOLpg2rH2CUdm9buXrS6X6WFk6Jj/+OPi+BmnM//9uHV+710Pl3/vj6/KOTgzaOJd5+dMz1gA
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

The documentation contains references to other sections in the doc
(internal). Add cross-references for them so that these can be accessed
without having to manually search for them.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../admin-guide/cgroup-v1/memory.rst          | 43 +++++++++++++------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 863e0f17ca0067..ae3a1d3873d73b 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -55,7 +55,8 @@ Features:
  - Root cgroup has no limit controls.
 
  Kernel memory support is a work in progress, and the current version provides
- basically functionality. (See Section 2.7)
+ basically functionality. (See :ref:`section 2.7
+ <cgroup-v1-memory-kernel-extension>`)
 
 Brief summary of control files.
 
@@ -223,8 +224,9 @@ behind this approach is that a cgroup that aggressively uses a shared
 page will eventually get charged for it (once it is uncharged from
 the cgroup that brought it in -- this will happen on memory pressure).
 
-But see section 8.2: when moving a task to another cgroup, its pages may
-be recharged to the new cgroup, if move_charge_at_immigrate has been chosen.
+But see :ref:`section 8.2 <cgroup-v1-memory-movable-charges>` when moving a
+task to another cgroup, its pages may be recharged to the new cgroup, if
+move_charge_at_immigrate has been chosen.
 
 2.4 Swap Extension
 --------------------------------------
@@ -272,7 +274,7 @@ global VM. When a cgroup goes over its limit, we first try
 to reclaim memory from the cgroup so as to make space for the new
 pages that the cgroup has touched. If the reclaim is unsuccessful,
 an OOM routine is invoked to select and kill the bulkiest task in the
-cgroup. (See 10. OOM Control below.)
+cgroup. (See :ref:`10. OOM Control <cgroup-v1-memory-oom-control>` below.)
 
 The reclaim algorithm has not been modified for cgroups, except that
 pages that are selected for reclaiming come from the per-cgroup LRU
@@ -286,7 +288,7 @@ list.
    When panic_on_oom is set to "2", the whole system will panic.
 
 When oom event notifier is registered, event will be delivered.
-(See oom_control section)
+(See :ref:`oom_control <cgroup-v1-memory-oom-control>` section)
 
 2.6 Locking
 -----------
@@ -303,6 +305,8 @@ Per-node-per-memcgroup LRU (cgroup's private LRU) is guarded by
 lruvec->lru_lock; PG_lru bit of page->flags is cleared before
 isolating a page from its LRU under lruvec->lru_lock.
 
+.. _cgroup-v1-memory-kernel-extension:
+
 2.7 Kernel Memory Extension
 -----------------------------------------------
 
@@ -462,6 +466,8 @@ test because it has noise of shared objects/status.
 But the above two are testing extreme situations.
 Trying usual test under memory controller is always helpful.
 
+.. _cgroup-v1-memory-test-troubleshoot:
+
 4.1 Troubleshooting
 -------------------
 
@@ -474,8 +480,11 @@ terminated by the OOM killer. There are several causes for this:
 A sync followed by echo 1 > /proc/sys/vm/drop_caches will help get rid of
 some of the pages cached in the cgroup (page cache pages).
 
-To know what happens, disabling OOM_Kill as per "10. OOM Control" (below) and
-seeing what happens will be helpful.
+To know what happens, disabling OOM_Kill as per :ref:`"10. OOM Control"
+<cgroup-v1-memory-oom-control>` (below) and seeing what happens will be
+helpful.
+
+.. _cgroup-v1-memory-test-task-migration:
 
 4.2 Task migration
 ------------------
@@ -486,15 +495,16 @@ remain charged to it, the charge is dropped when the page is freed or
 reclaimed.
 
 You can move charges of a task along with task migration.
-See 8. "Move charges at task migration"
+See :ref:`8. "Move charges at task migration" <cgroup-v1-memory-move-charges>`
 
 4.3 Removing a cgroup
 ---------------------
 
-A cgroup can be removed by rmdir, but as discussed in sections 4.1 and 4.2, a
-cgroup might have some charge associated with it, even though all
-tasks have migrated away from it. (because we charge against pages, not
-against tasks.)
+A cgroup can be removed by rmdir, but as discussed in :ref:`sections 4.1
+<cgroup-v1-memory-test-troubleshoot>` and :ref:`4.2
+<cgroup-v1-memory-test-task-migration>`, a cgroup might have some charge
+associated with it, even though all tasks have migrated away from it. (because
+we charge against pages, not against tasks.)
 
 We move the stats to parent, and no change on the charge except uncharging
 from the child.
@@ -721,6 +731,8 @@ If we want to change this to 1G, we can at any time use::
        It is recommended to set the soft limit always below the hard limit,
        otherwise the hard limit will take precedence.
 
+.. _cgroup-v1-memory-move-charges:
+
 8. Move charges at task migration (DEPRECATED!)
 ===============================================
 
@@ -750,7 +762,8 @@ If you want to enable it::
 
 .. note::
       Each bits of move_charge_at_immigrate has its own meaning about what type
-      of charges should be moved. See 8.2 for details.
+      of charges should be moved. See :ref:`section 8.2
+      <cgroup-v1-memory-movable-charges>` for details.
 
 .. note::
       Charges are moved only when you move mm->owner, in other words,
@@ -768,6 +781,8 @@ And if you want disable it again::
 
 	# echo 0 > memory.move_charge_at_immigrate
 
+.. _cgroup-v1-memory-movable-charges:
+
 8.2 Type of charges which can be moved
 --------------------------------------
 
@@ -817,6 +832,8 @@ threshold in any direction.
 
 It's applicable for root and non-root cgroup.
 
+.. _cgroup-v1-memory-oom-control:
+
 10. OOM Control
 ===============
 
-- 
An old man doll... just what I always wanted! - Clara

