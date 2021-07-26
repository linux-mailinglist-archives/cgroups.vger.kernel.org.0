Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D933D5C8B
	for <lists+cgroups@lfdr.de>; Mon, 26 Jul 2021 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhGZOTy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jul 2021 10:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbhGZOTx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jul 2021 10:19:53 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F2C061760
        for <cgroups@vger.kernel.org>; Mon, 26 Jul 2021 08:00:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id m11so7190573qtx.7
        for <cgroups@vger.kernel.org>; Mon, 26 Jul 2021 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTTsptuLITxPc+Owajv0QCvUN6VmzjQA4sTb/kLyZME=;
        b=ZXLe+pV1dgrpJxW8gR0RgPwPUehS8IrE/2Vbou8UHcmjEUrqODo0mbUUtREDLuboHI
         uRYwy1cK4J2lucpZS2lkrz+Yw3WhqxYpAkUM404nyr8nhUs+xbXAzDBhgicYHjJ02tcT
         P7TwXco+KKFQYqfCwlG7Pa+rFK8sjhe3zkhUEIpLvEhU1x/8TfOIdLv3UNg30/xApIS9
         n+idNUq/UTyY5HU1LEGAlJPZWfKdyKAYAIaaFhvqhVJnPZULfAhZMEDr+qzP1/Amj40Q
         BVflhSLUWnZN5aqLPa75Q9QA+mvqr+1FOMZjDpEEW8gOwUNQA5DRllSRQyw3V6m1xd8f
         cVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTTsptuLITxPc+Owajv0QCvUN6VmzjQA4sTb/kLyZME=;
        b=bNjiwdxB2N2HwNnygp6ys9HwbEo5nnu2SeEBtHqfOR1GYKy0q6sNSUY5dC+1LxuxRK
         A7FxAY2Zi4wB9J9iWpIX6VJ1SjALaTvBq+ineZWraHxlV42JXnCf1q8Xm8Q5Z0heJxOR
         b2jMoA1NAw+wN1pQkzSKKX60vNw5We2ZMKiA6BjiAcvF+gqw1jOeK0beFPwFN+5aXsmG
         wqu6DrpyXFIzJY3cdAS5lOKYMKulj500FYmDocsWM3JPmu9Wjf0sFv530i7tDj13nGKg
         NH4XBurP8Y8bDAYq0FZekPNdl79iU+338QNa4nJfZaWmwmlrTACkbmFZhRLV6fSRvvQA
         0UIQ==
X-Gm-Message-State: AOAM533K+0pK9+2LHBcJpFdDfHRowmuHGmoncVWxcd/wW/w0j5Zx1c7y
        crEMCX47pQT+RrIgkQne+q6ADw==
X-Google-Smtp-Source: ABdhPJxUmmX4dY9GgbrCAU62sFsuKrKt/V1WzL+nrW4HxYYqVOvANMZBVBRtyJKBVfb1X3SNBJmi+w==
X-Received: by 2002:ac8:66ca:: with SMTP id m10mr14787845qtp.171.1627311621182;
        Mon, 26 Jul 2021 08:00:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e732])
        by smtp.gmail.com with ESMTPSA id h10sm99931qka.83.2021.07.26.08.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 08:00:20 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: memcontrol: fix blocking rstat function called from atomic cgroup1 thresholding code
Date:   Mon, 26 Jul 2021 11:00:19 -0400
Message-Id: <20210726150019.251820-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dan Carpenter reports:

    The patch 2d146aa3aa84: "mm: memcontrol: switch to rstat" from Apr
    29, 2021, leads to the following static checker warning:

	    kernel/cgroup/rstat.c:200 cgroup_rstat_flush()
	    warn: sleeping in atomic context

    mm/memcontrol.c
      3572  static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
      3573  {
      3574          unsigned long val;
      3575
      3576          if (mem_cgroup_is_root(memcg)) {
      3577                  cgroup_rstat_flush(memcg->css.cgroup);
			    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    This is from static analysis and potentially a false positive.  The
    problem is that mem_cgroup_usage() is called from __mem_cgroup_threshold()
    which holds an rcu_read_lock().  And the cgroup_rstat_flush() function
    can sleep.

      3578                  val = memcg_page_state(memcg, NR_FILE_PAGES) +
      3579                          memcg_page_state(memcg, NR_ANON_MAPPED);
      3580                  if (swap)
      3581                          val += memcg_page_state(memcg, MEMCG_SWAP);
      3582          } else {
      3583                  if (!swap)
      3584                          val = page_counter_read(&memcg->memory);
      3585                  else
      3586                          val = page_counter_read(&memcg->memsw);
      3587          }
      3588          return val;
      3589  }

__mem_cgroup_threshold() indeed holds the rcu lock. In addition, the
thresholding code is invoked during stat changes, and those contexts
have irqs disabled as well. If the lock breaking occurs inside the
flush function, it will result in a sleep from an atomic context.

Use the irsafe flushing variant in mem_cgroup_usage() to fix this.

Fixes: 2d146aa3aa84 ("mm: memcontrol: switch to rstat")
Cc: <stable@vger.kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae1f5d0cb581..eb8e87c4833f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3574,7 +3574,8 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 	unsigned long val;
 
 	if (mem_cgroup_is_root(memcg)) {
-		cgroup_rstat_flush(memcg->css.cgroup);
+		/* mem_cgroup_threshold() calls here from irqsafe context */
+		cgroup_rstat_flush_irqsafe(memcg->css.cgroup);
 		val = memcg_page_state(memcg, NR_FILE_PAGES) +
 			memcg_page_state(memcg, NR_ANON_MAPPED);
 		if (swap)
-- 
2.32.0

