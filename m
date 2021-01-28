Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6474D306F07
	for <lists+cgroups@lfdr.de>; Thu, 28 Jan 2021 08:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhA1HWb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jan 2021 02:22:31 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35145 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231754AbhA1HTo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jan 2021 02:19:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UN7J966_1611818338;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UN7J966_1611818338)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Jan 2021 15:18:58 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-cgroup: Remove obsolete macro
Date:   Thu, 28 Jan 2021 15:18:50 +0800
Message-Id: <2d053708b596fe148c1d9e63a97117c150a0004a.1611818240.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Remove the obsolete 'MAX_KEY_LEN' macro.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4b4fcb5..a317c03 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -32,8 +32,6 @@
 #include <linux/psi.h>
 #include "blk.h"
 
-#define MAX_KEY_LEN 100
-
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
  * blkcg_pol_register_mutex nests outside of it and synchronizes entire
-- 
1.8.3.1

