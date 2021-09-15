Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BECE40BDB0
	for <lists+cgroups@lfdr.de>; Wed, 15 Sep 2021 04:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhIOCUQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 22:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhIOCUP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 22:20:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A8C061574;
        Tue, 14 Sep 2021 19:18:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d17so647545plr.12;
        Tue, 14 Sep 2021 19:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=juTuMGYLDFSf15GDeZ/llKXGqDNMFhVIYFa8WUCbryw=;
        b=g1kBf6mxbwuBgKY0zeaBNmkhNUjyetF7qAcShuR/M1bj9IUcJPGG4ff9kVL7mtu4sZ
         /Y1D7tyCxPQlxFiiGRw7QxHtTCHvs2/jSJTL859u9OpZBnkRR7V+bJpVx71eYsuDKq3m
         NbUgbiD6ZVJFmEXZDUcfY8jMgMxjkgeWzpw8OQkr12gEP/uDoim14zIhrERhtfoCUO8H
         zpPJSy5wsw+u/k7G2yTS9Vb44IxYG8E/BC1yZASDariDtjGsc/1ZR388oNaN9DHNP3lw
         CO3iDZr3mQ1nM2F9/PGHKTV4xC6Rqg3FZjKY+oIjv0flrGfqn5RhOgLPlfgKkffP8qXT
         D0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=juTuMGYLDFSf15GDeZ/llKXGqDNMFhVIYFa8WUCbryw=;
        b=uKbkrgeO5bmkCimhFi1w/KfkRTWYEEBZfFkQ7NPqTKxn+90JCF+dEMqlFk8jl6aJ+Z
         vicFM9Q+P+Vs4q3HXCNwgUVii6vCL44e6Ba3QB9Tlbp++AzShIRyn4QMdvVZjj0teFUo
         C1i051+aLdjhIo9fL2Kr88m1rN8xXo28gcdDep/xPMD4fSQE9YJTFMB3QRC860SGa1Ru
         6CK27KuNxgE4OxHcz2E1m4UaZuQlH215IWdC/l2PQk361tgc5MbmFj25Q4lFbQghAunM
         iV1Rh+DF7VVkdyopU/jpIgSpYvvIQaNVftw84pIQiNIpWixMc1STnQzZi0dtPWYauszR
         Fqlw==
X-Gm-Message-State: AOAM532CmO0l+CpEZJ2SNyZOGwnhgtwQGpKDNevPfqXygv9TwUywX/k0
        DFPyyVmtR9wIXkazs/5sCk26AghfeZqmDg==
X-Google-Smtp-Source: ABdhPJwJV13f0XvFDg8JurGF+FmrmHY6fiV4OTH91BaLheyglgJxg2sHEd6rSQMfcSENbSYmOXe2Yw==
X-Received: by 2002:a17:90a:4a8e:: with SMTP id f14mr5591709pjh.169.1631672337443;
        Tue, 14 Sep 2021 19:18:57 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id h4sm3297645pjc.28.2021.09.14.19.18.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 19:18:57 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 2/3] misc_cgroup: remove error log to avoid log flood
Date:   Wed, 15 Sep 2021 10:18:50 +0800
Message-Id: <a960cd793f649bd944127fe5e5e3f4d8bb9040a4.1631671936.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
In-Reply-To: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In scenarios where containers are frequently created and deleted,
a large number of error logs maybe generated. This log provides
less information, we can get more detailed info from misc.events.
From this, perhaps we can remove it.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/misc_cgroup.h | 1 -
 kernel/cgroup/misc.c        | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 091f2d2..c238207 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -37,7 +37,6 @@ struct misc_res {
 	unsigned long max;
 	atomic_long_t usage;
 	atomic_long_t events;
-	bool failed;
 };
 
 /**
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 4b2b492..fe3e8a0 100644
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
1.8.3.1

