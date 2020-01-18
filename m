Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DF71415A7
	for <lists+cgroups@lfdr.de>; Sat, 18 Jan 2020 04:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgARDLL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jan 2020 22:11:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33585 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgARDLL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jan 2020 22:11:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so10642966plb.0;
        Fri, 17 Jan 2020 19:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kCkFnYkawO75Slclr1NGNbFjc/K/Z8ax1mgdyxXyluc=;
        b=kFFMSn6GQbVrsB7xcz6GHNYsvWVsZtZLtyarkvcW4Qjn8R2Vlklx5fkrNTwwRZulTD
         Jjnj/FKMP1+IzHx8ruolwTiB6z+Z3Y8NZWo1QTXIis3LaKm2v0/NYOdnner2pO9hrV3U
         Ock9seKbMjAL63Xn7eeqrCFS6F4e3bYHJIFHESFv0x7zzpG5oh2xf5aR0alR+kcSYnxC
         LG9Aeugqhvwf/kv2MkGt9FH7Y2RXdgoKAowTagWQUeVtagogRbE2cDQ/xhduU5oOB2Hz
         CMgcvKpqoCE6iquWtUM+Fqj57BHjyIdrVoGA6eEf5Rud/K6I9FFqrL1asp7kDWRlW57+
         0S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kCkFnYkawO75Slclr1NGNbFjc/K/Z8ax1mgdyxXyluc=;
        b=tNriiQ+07mMGuSyUF0fx0w37zTSkJkcm1GrJHzD+Y6zxRRSPiioxQuyqBinszD9Zas
         OLwL8ZN1aVVWpYHkYx0xhVaJ3Yl9NdOiHTNj0EVhemEfQgdoc013qhyj8q2a6nAkilzg
         XXf2NUWktlYFbGhPnqpDMSKQv8keTLvg7R7DKmxS1HPFELRGA4jj7g0kdt1QKCFbm62O
         Fi2XPA8SYXAwYvTgMSPgoagl6BWLNIiwHQq3nUWWETvYpn7PLx2aFPoYkn33UGmkmm8W
         1HfgndZDieQQrRdC1nzHazsj97lDZzMKmMdQqKhLUqSMGsfh4yeQiZK2LUShwN5zOMkW
         12iQ==
X-Gm-Message-State: APjAAAWKhmhYkbBH2DSXObZCZoGFZPsHvXXkNN8eAj9qf68SHO2ieJc6
        rGRGMk4ks7oDxlwroW0HMg==
X-Google-Smtp-Source: APXvYqzrX/dzjceNK2YxPQDFBmGY7ox/l+PSYdFJ8XUj9ddhcLLJUTQk19QT+CBkmgvu/QeymGKONg==
X-Received: by 2002:a17:902:848f:: with SMTP id c15mr2751205plo.182.1579317070565;
        Fri, 17 Jan 2020 19:11:10 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee0:feca:40cf:944c:98dd:69a3])
        by smtp.gmail.com with ESMTPSA id g8sm30478701pfh.43.2020.01.17.19.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 19:11:10 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     tj@kernel.org, lizefan@huawei.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, rcu@vger.kernel.org, frextrite@gmail.com,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] cgroup.c: Use built-in RCU list checking
Date:   Sat, 18 Jan 2020 08:40:51 +0530
Message-Id: <20200118031051.28776-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

list_for_each_entry_rcu has built-in RCU and lock checking.
Pass cond argument to list_for_each_entry_rcu() to silence
false lockdep warning when  CONFIG_PROVE_RCU_LIST is enabled
by default.

Even though the function css_next_child() already checks if
cgroup_mutex or rcu_read_lock() is held using
cgroup_assert_mutex_or_rcu_locked(), there is a need to pass
cond to list_for_each_entry_rcu() to avoid false positive
lockdep warning.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 kernel/cgroup/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f15f95..c2959764ad95 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4152,7 +4152,8 @@ struct cgroup_subsys_state *css_next_child(struct cgroup_subsys_state *pos,
 	} else if (likely(!(pos->flags & CSS_RELEASED))) {
 		next = list_entry_rcu(pos->sibling.next, struct cgroup_subsys_state, sibling);
 	} else {
-		list_for_each_entry_rcu(next, &parent->children, sibling)
+		list_for_each_entry_rcu(next, &parent->children, sibling,
+					lockdep_is_held(&cgroup_mutex))
 			if (next->serial_nr > pos->serial_nr)
 				break;
 	}
-- 
2.17.1

