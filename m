Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E65296642
	for <lists+cgroups@lfdr.de>; Thu, 22 Oct 2020 22:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372067AbgJVU6O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Oct 2020 16:58:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48188 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897292AbgJVU6O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Oct 2020 16:58:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DE6D31F45E92
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, khazhy@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 1/2] blk-cgroup: Fix memleak on error path
Date:   Thu, 22 Oct 2020 16:57:57 -0400
Message-Id: <20201022205758.1739430-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If new_blkg allocation raced with blk_policy change and
blkg_lookup_check fails, new_blkg is leaked.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index f9b55614d67d..f9389b7cf823 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -663,6 +663,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		blkg = blkg_lookup_check(pos, pol, q);
 		if (IS_ERR(blkg)) {
 			ret = PTR_ERR(blkg);
+			blkg_free(new_blkg);
 			goto fail_unlock;
 		}
 
-- 
2.28.0

