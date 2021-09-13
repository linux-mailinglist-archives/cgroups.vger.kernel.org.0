Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78A4083A6
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 07:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhIMFCZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 01:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhIMFCX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 01:02:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8973FC061574;
        Sun, 12 Sep 2021 22:01:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m21-20020a17090a859500b00197688449c4so5619696pjn.0;
        Sun, 12 Sep 2021 22:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sq2sVElL6LfrWUTgPoXcRO8q9sfpNwqgOJwmbj5VuD0=;
        b=W7gTxo1dbLBUb/zQ15G4oMV9hmfVEKB31vCWW8cUhxKnCCWD1E3k0PI/13ceSkzIkW
         hVytVb/b6W/kjpmc7X2LBh3vbmbQYuYsaZ54nNjLo8tfZ3eWSuTjyCqPhqmcN4v21Iva
         WsNTufzNiHNLY/l83N+Ply8xxG0ef7FnT58Y6wYTo3mxeGD6Aenz+vZVm89UHfKleEO2
         qmCv1FgUtIqXXPZJ8wajaeGVUyFFKdUygmHZsTLoWBQgCfDc/+iUzQwtcdK64EjdowsB
         Z5WxIgnvuSVqL9kJ31SNg4dRA8VlnA8ApGczoIoFNxoakayNSUEgpgcigv5DayoGxY/Y
         Ab9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sq2sVElL6LfrWUTgPoXcRO8q9sfpNwqgOJwmbj5VuD0=;
        b=43XHJXYBZ+NZtEo8+rIs+7rRLItRWFkgGOIIAJjhx7H4xyvWBr5Dvf3tZnCmLg3T21
         eoyAb7Usz3II7tqTM+QGYFNEoEZlP9tIOQ+0fk7PxVdVpnlR/0xFdK57piuhpCNuW8Ty
         48vy64ghgrbH4aK4FcnI7al+TF89YDdo+BlEXqYlrX8lsgcUgRw24LOPglgPreGDPPFM
         vqWsxN48vzWHtNf3Clc7lg/HXZMX7ZBE43Ftlvg89nlOAYNxRy1jiS1j0RNMx5n3MxIB
         64szr/uAWCLo/nzYYlvcCaRzVFNO2v7z5fMwjjumDtARqM/mHzcPc4Cxzf/rDpOl8CVq
         3wzQ==
X-Gm-Message-State: AOAM531oBkLz128PoMe+N31W/8hV+OeK5JpxG4dqxP3/UZEvwLms4xaz
        cuY019l3aHqs75DrlZJxCgE=
X-Google-Smtp-Source: ABdhPJxNk6nCjhMF/yWWIIW4koMWlV8hocj9LtGKfHZSfcxOI1aZFM+S2BERYCc6xgYrkWrs09AgEw==
X-Received: by 2002:a17:902:c402:b0:138:e681:fba3 with SMTP id k2-20020a170902c40200b00138e681fba3mr8948328plk.63.1631509267681;
        Sun, 12 Sep 2021 22:01:07 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id n38sm291879pfv.198.2021.09.12.22.01.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Sep 2021 22:01:06 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 2/3] misc_cgroup: remove error log to avoid log flood
Date:   Mon, 13 Sep 2021 13:01:00 +0800
Message-Id: <b335a5d8241f837313cd20647647bf436385dd8d.1631504710.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
References: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
In-Reply-To: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
References: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In scenarios where containers are frequently created and deleted,
a large number of error logs maybe generated. This log provides
less information, we can get more detailed info from misc.events,
misc.events.local. From this, perhaps we can remove it.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/misc_cgroup.h | 1 -
 kernel/cgroup/misc.c        | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 602fc11..89dcb62 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -43,7 +43,6 @@ struct misc_res {
 	atomic_long_t usage;
 	atomic_long_t events[MISC_CG_EVENT_TYPES];
 	atomic_long_t events_local[MISC_CG_EVENT_TYPES];
-	bool failed;
 };
 
 /**
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 5f06b2a..980ebaa 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -161,13 +161,6 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 		new_usage = atomic_long_add_return(amount, &res->usage);
 		if (new_usage > READ_ONCE(res->max) ||
 		    new_usage > READ_ONCE(misc_res_capacity[type])) {
-			if (!res->failed) {
-				pr_info("cgroup: charge rejected by the misc controller for %s resource in ",
-					misc_res_name[type]);
-				pr_cont_cgroup_path(i->css.cgroup);
-				pr_cont("\n");
-				res->failed = true;
-			}
 			ret = -EBUSY;
 			goto err_charge;
 		}
-- 
1.8.3.1

