Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2194033BC
	for <lists+cgroups@lfdr.de>; Wed,  8 Sep 2021 07:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhIHFZy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Sep 2021 01:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbhIHFZv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Sep 2021 01:25:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2114CC061575;
        Tue,  7 Sep 2021 22:24:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w7so1321924pgk.13;
        Tue, 07 Sep 2021 22:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FQ5T0HqJNT9t39aOsQECaxpdxcnOU7H2Z1up+JT0ahA=;
        b=KSjeu4V7QQUimg8NL+XI827Mhtjv4Do5UNgas+FfP5NOXy4uByNlBeEkc6Q9IKqYwu
         ib9n6iQEA17insu7R6QsJ1F9gho8Q7vQf1jqBt1rnLS/kGv5HYDPpttcHLE7ZsEd3r3+
         QO789ukWZ/vxtrPy6/+w3ajKVx/LeDxahaKJHoH8qyVIBbJo8XMGTMZk/uWGTLyRTK/a
         uKk4dy64QSEkHtB55nMjI1gJH2dmAHHKjoC9GVneHicx5rnZVrJcW88kFs6aSUWAkqeR
         kRTnheqwrE+HpTMp2Py3QJWDqkXcz7X7pN8mAfPJzslHTckh/VRIkq/K//aQpOa+g14o
         RxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FQ5T0HqJNT9t39aOsQECaxpdxcnOU7H2Z1up+JT0ahA=;
        b=PxbN7XXVECT16u97gcOPlYY0tRHpYHF+w4ffyYE4PcBkAZ3z2dRGWLE4UR+8t5PLWf
         VceKya9XQIuWNFWm4HZu4iMl52sqFWIbBXD5fwqigWg4R5YWn2wUFzc3z0hFvDe9AREk
         /HsvRz6B7SOHRqfMoGHkaHHQtbEb73Xh96aJwOyZuxbVDxBOrOdHLNQhc2QwhoI5MHP3
         f9oLssQrJbAohoPtDDYen263rP4kddl/vCJRD/VkgR5YFBVZ8mVS8qknPP2QwZhaj4De
         VtkPKNNilu3ZpNistgKef2CnIcL7A+wo3AGdYjH4sr3i8X95DFyS6/Nj8C0TXP7tqpzr
         5e1w==
X-Gm-Message-State: AOAM5303/CCRcO2zJagUZHWUVF8x3nKhyLhAuD+TW0fzloE7Bqk8hMLy
        fWO52E1Gu0jIPvth1eu9iuU=
X-Google-Smtp-Source: ABdhPJyPhYq6dBuj4ksRnOBmdBHYCrJ2wUbH6FtEad1zS+LMXbJalsxjs4gmd9lRPvgICUBhIXJpMw==
X-Received: by 2002:a63:4344:: with SMTP id q65mr1973416pga.364.1631078683798;
        Tue, 07 Sep 2021 22:24:43 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id k190sm769674pfd.211.2021.09.07.22.24.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:24:43 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
Date:   Wed,  8 Sep 2021 13:24:36 +0800
Message-Id: <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
In-Reply-To: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In scenarios where containers are frequently created and deleted,
a large number of error logs maybe generated. This log provides
less information, we can get more detailed failure records through
misc.events, misc.events.local and misc.failcnt. From this, perhaps
we can remove it.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/misc_cgroup.h | 1 -
 kernel/cgroup/misc.c        | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 4d630cd3e4bd..838e26149263 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -36,7 +36,6 @@ struct misc_cg;
 struct misc_res {
 	unsigned long max;
 	atomic_long_t usage;
-	bool failed;
 };
 
 /**
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index d8f99fd58981..b9c7e488413f 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -157,13 +157,6 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
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
2.30.0

