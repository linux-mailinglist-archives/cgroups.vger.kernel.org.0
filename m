Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2170F025C
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2019 17:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390057AbfKEQJ5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Nov 2019 11:09:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39448 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389907AbfKEQJ5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Nov 2019 11:09:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id 15so21612942qkh.6;
        Tue, 05 Nov 2019 08:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=me3lESL1ggtumWsSVDttQmUrbEo7485lmzzekY64N38=;
        b=tPrZdHjJcV0IzlK9UurrMNrUsqfSlMSqpZQhPr+KB57uDynjOd2cTm7wzPG77+mtk+
         hLy4rIuS5QDPxR2XJOLho/ugr6NpnXyf0z2qcsyEs1KXsWE9iEwSbsL5HK0pA0vxrdRX
         RBmf7MvgZoeS34lShwgpJj4mMhwED4aY97WiHDCa09wdQQw3dEbBYj1qurBcXocQ253p
         NOj/Fk6JB7X5eax98zJ3qHft9JtWqDZD4pM4D8np4axWPcwEM7cjLQ/Z8FzI96R6rpFz
         2xv70RhmHogmpE1IRKYvm5C6SePm7MjU72MVcm51XYWQSpWchtuiI+mDMKCXRc9E8u76
         4/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=me3lESL1ggtumWsSVDttQmUrbEo7485lmzzekY64N38=;
        b=KpHRn3rZ/zMv16JjZdT0yR6w8hqcq/VlHKUtlX06P9UWC2zwfUIdSofBle0SGwRwOf
         8VW0JozIrgMk4/XugmHraM6DXcS0a7V4ybpBN7zORuLWdfOrfv110fI4bS7Zw92fk5/F
         sORYFI9INa0wxRQwTRUdQXbbXno/QLgUTMzSzYQYYPYPRI8gR+FtsQV/lPfVYsZWoy4Y
         6d3dQKH2L6p1bxVToiWxzDTuiZmQtuilg23rZOE40+K52rzCppoojGMQGbxI2fJJ0UiZ
         rAJHxCuwKqFXOZ3bd2z65WalJRkX3LUxUgY8b51zNcydj0mH+f3cbvnQJFmluc5Rg0MT
         HQrA==
X-Gm-Message-State: APjAAAVkQ9okXWt1LYTEZ51SgAYDxMF3tUByfrLans5KFH9yqAxF6Naa
        fiNc2v6ieSjusS0rZ3eOdIkm7xmA
X-Google-Smtp-Source: APXvYqzLB/L7Dj+A7FHR7I7t9gslk7a7ssseyWvo6BBPcRa35boS1fXIjPGUdSu+UaCEGKaUJHUgAg==
X-Received: by 2002:a05:620a:a85:: with SMTP id v5mr11569535qkg.471.1572970195651;
        Tue, 05 Nov 2019 08:09:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:bc42])
        by smtp.gmail.com with ESMTPSA id o2sm10936208qkf.68.2019.11.05.08.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 08:09:55 -0800 (PST)
Date:   Tue, 5 Nov 2019 08:09:51 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Roman Gushchin <guro@fb.com>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <jbacik@fb.com>
Subject: [PATCH block/for-5.4-fixes] blkcg: make blkcg_print_stat() print
 stats only for online blkgs
Message-ID: <20191105160951.GS3622521@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

blkcg_print_stat() iterates blkgs under RCU and doesn't test whether
the blkg is online.  This can call into pd_stat_fn() on a pd which is
still being initialized leading to an oops.

The heaviest operation - recursively summing up rwstat counters - is
already done while holding the queue_lock.  Expand queue_lock to cover
the other operations and skip the blkg if it isn't online yet.  The
online state is protected by both blkcg and queue locks, so this
guarantees that only online blkgs are processed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Roman Gushchin <guro@fb.com>
Cc: Josef Bacik <jbacik@fb.com>
Fixes: 903d23f0a354 ("blk-cgroup: allow controllers to output their own stats")
Cc: stable@vger.kernel.org # v4.19+
---
 block/blk-cgroup.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -934,9 +934,14 @@ static int blkcg_print_stat(struct seq_f
 		int i;
 		bool has_stats = false;
 
+		spin_lock_irq(&blkg->q->queue_lock);
+
+		if (!blkg->online)
+			goto skip;
+
 		dname = blkg_dev_name(blkg);
 		if (!dname)
-			continue;
+			goto skip;
 
 		/*
 		 * Hooray string manipulation, count is the size written NOT
@@ -946,8 +951,6 @@ static int blkcg_print_stat(struct seq_f
 		 */
 		off += scnprintf(buf+off, size-off, "%s ", dname);
 
-		spin_lock_irq(&blkg->q->queue_lock);
-
 		blkg_rwstat_recursive_sum(blkg, NULL,
 				offsetof(struct blkcg_gq, stat_bytes), &rwstat);
 		rbytes = rwstat.cnt[BLKG_RWSTAT_READ];
@@ -960,8 +963,6 @@ static int blkcg_print_stat(struct seq_f
 		wios = rwstat.cnt[BLKG_RWSTAT_WRITE];
 		dios = rwstat.cnt[BLKG_RWSTAT_DISCARD];
 
-		spin_unlock_irq(&blkg->q->queue_lock);
-
 		if (rbytes || wbytes || rios || wios) {
 			has_stats = true;
 			off += scnprintf(buf+off, size-off,
@@ -999,6 +1000,8 @@ static int blkcg_print_stat(struct seq_f
 				seq_commit(sf, -1);
 			}
 		}
+	skip:
+		spin_unlock_irq(&blkg->q->queue_lock);
 	}
 
 	rcu_read_unlock();
