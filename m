Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D540F834
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 14:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhIQMpq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbhIQMpp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 08:45:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39534C061766;
        Fri, 17 Sep 2021 05:44:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o8so6141924pll.1;
        Fri, 17 Sep 2021 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JmDsZYoKM3nd+syw9DbJHHGWUZG2yxMKHrpfUjr/K8o=;
        b=V7u00EZvkgEFdaMOD7yTZgP1Ant/Zm1hlYhWol9JNo30Y1+D/BpaTJAkpTuKHVOvZ5
         9zzsDqD/0REVAbD0tqqN+qtrLHGmJovO2GPNXlXT4hYH54lQuue+XFAvB+HS4MadRcF5
         t8WKCK33pXxKk+ZtML7SZoD1PIceqI2c2BqMVMgwY312sBjkoKZ3Vk+J1yMzfUrljTjI
         M1OFQ7Ot5EG1HeXZiq4ciMM3J4xWL/xc2cn8bixKlCxdohQauR9x+tlgCgAUM86Qy9RR
         IGjfHqt63NM+17cfAOa2Xg5ab9ZH4m8voTjhUgFFI9batZf2YtJSgEFgCAj2KZ4h2FXn
         30Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JmDsZYoKM3nd+syw9DbJHHGWUZG2yxMKHrpfUjr/K8o=;
        b=lB9TVnMmF1x8B6IKpWnMBCA80Eqv1hvF2j9bCMcMOz6vtsJSx+dQsmMxb7D9oIFoMw
         YrXcFf99wr4nInHfiUnNTDvvSr6UBOBG1tgpfS5xGcKCfOClq8Dt6sILYul9cIqORkF+
         rPI6gtBVQF0t/wQSwp6PePfauO/0QDIeR/CCP9YulEtA4++OrJ/QP/G1ZFtD9u5eJVCS
         i5pwo7A34sD2FVYdUKKazZm9gfvx5t7ZOWe44ovnfkJ83thgtWzdjIS6HN2u57bZLxH0
         Sg8jlzggvLxrJvdfW7kYxqUPa8JxGdtptLVOSnPAkiZk/bB8KJW+RT3vK3y+dxYHI/Og
         j5Sw==
X-Gm-Message-State: AOAM5306ikZ5zuU79ducouzQUucTcu4iRpVh8ZDwt97zhVX6H2FI4CcE
        A4oqRWS/CKWNhoM9qmWVAjs=
X-Google-Smtp-Source: ABdhPJzhsczgQwskla1PdmFxziualchwO8nWDEAZ+ne1ZR1xyaYVWbalgguQpPjQTr8L++XDBTbQrQ==
X-Received: by 2002:a17:902:ab55:b0:13c:9740:3e00 with SMTP id ij21-20020a170902ab5500b0013c97403e00mr9492060plb.55.1631882662832;
        Fri, 17 Sep 2021 05:44:22 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id n185sm6570299pfn.171.2021.09.17.05.44.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 05:44:22 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 2/3] misc_cgroup: remove error log to avoid log flood
Date:   Fri, 17 Sep 2021 20:44:15 +0800
Message-Id: <469945b22298bacef5d117b53c4762a32c42fb35.1631881726.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631881726.git.brookxu@tencent.com>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631881726.git.brookxu@tencent.com>
In-Reply-To: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631881726.git.brookxu@tencent.com>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631881726.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In scenarios where containers are frequently created and deleted,
a large number of error logs maybe generated. The logs only show
which node is about to go over the max limit, not the node which
resource request failed. As misc.events has provided relevant
information, maybe we can remove this log.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
---
v4: update commit message.

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

