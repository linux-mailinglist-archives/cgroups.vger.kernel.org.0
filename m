Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93190416C10
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 08:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbhIXGsB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 02:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244211AbhIXGsA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Sep 2021 02:48:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C315C061574;
        Thu, 23 Sep 2021 23:46:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m26so8085609pff.3;
        Thu, 23 Sep 2021 23:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f0GxVaNbVW0DvbjS40nByrp5JbLVkqcqCJ/2Z3nsHrQ=;
        b=KumeSPyep1PPko2skk0eqpAVVSFetiWqeAAclpxM6br9aBNY8UZ8HoRNhWJt6dq4l7
         DRGK4F0m1dv7vyCNkpWdtUDJyDW+hkyAAlj3zMFof7bL81tqd8GDGjD90+ALVa+4UYUf
         6FMs2h5X4jYNZ3iPHrGfooduiRDtrbu/taZ/wFQWushFmSxXf0ZsHKUup+5eZnOsl0KB
         1VSbhX833c7Iy64o+my5fT3ImlXC9hJ88ZWfrLkL0CEcTzp2SMYINwUi4srGg4hk6KZ9
         kfjY4T8MD/aNuc51L+/6neQbOOfxq9CcLzOxvs1HIpwVUOJ2DKNRd40CaSm1ws8GpnJw
         Euew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f0GxVaNbVW0DvbjS40nByrp5JbLVkqcqCJ/2Z3nsHrQ=;
        b=g+W2jB6nznB/at/pmx/iC6S1PhwhVBjy7nKWjiPYRE/k6NOcNYa8/3P2r1OoofnK9L
         gcpOZNuKOb8y3ntb1nJkVonfEbky0NC6BTh2ux8gkQ05R6q5TwjcUHflcgWDxwl+hd2e
         Ohj2CTHW1h5KPnvJLGrDjEsxfjFj5wZrWhZpI1ERjOm3KP1eE6accRua6NQ4dteMs8yd
         g8e7je70bfchIzvChZ3ffBE66+bfuy6SCdEqYzNUQJ7dSSpAHaOBf0zAxZSMdbsq6Up1
         8Q2Dhy0TjVYNsNLE1jUQFR07r9PLgKnL4G38VGr1jFLiMaRJy/J87eG05I2zTrJPUvsX
         f0YA==
X-Gm-Message-State: AOAM532ngHTOYzK4hz8n143TDqYGudd6LzhSDUx0242lj6jDR1e2CgsA
        +CBdMYGt1Cp1ldWk7chugXbAAoaZHWhGow==
X-Google-Smtp-Source: ABdhPJy4MKlz14srcviUr/+8Aipp+9PwQ1diUE7a6FKNXV3qce1UNzEw7NlbEofTk75dvMF6gWo9ww==
X-Received: by 2002:a65:6251:: with SMTP id q17mr2499581pgv.416.1632465987869;
        Thu, 23 Sep 2021 23:46:27 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id q20sm7978818pfc.57.2021.09.23.23.46.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Sep 2021 23:46:27 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 2/2] mem_cgroup: introduce foreign_writeback_in_process() function
Date:   Fri, 24 Sep 2021 14:46:23 +0800
Message-Id: <1632465983-30525-2-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1632465983-30525-1-git-send-email-brookxu.cn@gmail.com>
References: <1632465983-30525-1-git-send-email-brookxu.cn@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Directly use atomic_read(&frn->done.cnt) == 1 to check whether frn
is issued, which makes the code a bit obscure. Maybe we should
replace it with a more understandable function.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 mm/memcontrol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e1384a6..464745b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4542,6 +4542,12 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
  * As being wrong occasionally doesn't matter, updates and accesses to the
  * records are lockless and racy.
  */
+
+static inline bool foreign_writeback_in_process(struct memcg_cgwb_frn *frn)
+{
+	return atomic_read(&frn->done.cnt) != 1;
+}
+
 void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 					     struct bdi_writeback *wb)
 {
@@ -4565,7 +4571,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 		    frn->memcg_id == wb->memcg_css->id)
 			break;
 		if (time_before64(frn->at, oldest_at) &&
-		    atomic_read(&frn->done.cnt) == 1) {
+		    !foreign_writeback_in_process(frn)) {
 			oldest = i;
 			oldest_at = frn->at;
 		}
@@ -4612,7 +4618,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		 * already one in flight.
 		 */
 		if (time_after64(frn->at, now - intv) &&
-		    atomic_read(&frn->done.cnt) == 1) {
+		    !foreign_writeback_in_process(frn)) {
 			frn->at = 0;
 			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
 			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
-- 
1.8.3.1

