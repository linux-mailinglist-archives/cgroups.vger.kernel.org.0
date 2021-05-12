Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3268437EE77
	for <lists+cgroups@lfdr.de>; Thu, 13 May 2021 00:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbhELVnu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 May 2021 17:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386848AbhELUWY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 May 2021 16:22:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAF3C061352
        for <cgroups@vger.kernel.org>; Wed, 12 May 2021 13:19:59 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d201-20020ae9efd20000b02902e9e9d8d9dcso18087156qkg.10
        for <cgroups@vger.kernel.org>; Wed, 12 May 2021 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=YXR7018ir3yC5tcsqwArvEvMEw9OfhcwUNlN5MdOICU=;
        b=qOWX+kRIMBQ4mZ/HLAhtp9wtaMHP5alBj0yPlO6T3CwoNy5+yXHc5+lK3jUvjUIMh4
         scx7qYpwH7fn/Co419Rrw+6ku5QpMn8wo3UNlyU8TEuYLawfwF18y1DiiuImUsYbxsLv
         LPA6EbjkZjr8zxRwy4oYlC+xugm0nGJrCHl73zgZwy8DgPcoBkh7M4oINhOnNXmLUYrW
         wZH4ZX80NB0kU/47Pq/MkaoXxSGioC5CD8RKCA+CBb71BHR8hQXMfVcj9JTEz9cL6sX7
         RIfHXat1yI2+q4QA/ysP/u64GkwyUP8I5QE/j0PdS2w8+MmdJ1lJC2/HhIa71OzHvOVR
         oOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=YXR7018ir3yC5tcsqwArvEvMEw9OfhcwUNlN5MdOICU=;
        b=cgGvzDWx2PCJXYeEVExVWulTuVMx7Wlzj3D07m+LcVq2lSNwM+qFOSzQoelEk/7WSm
         E4a/M0hkCpgvcKhysn7faEd+DINdCbzozHoxl12JgKTN1FQ36ZHOpXS3T2bzqI3YfHnJ
         bkC393Y2QJ04Iwv1pBv4YL3XRCR9Te/wUnaBmU0CBwBxc5hXClgeqAxoqhN+P9mYp36/
         JUa8xtYHMHhexYGXI6SaSiKZtVGQUi4mayr4lh1HXfGvTbxQnGkXCN42V0KyrxrO2mMH
         iYv9NFXbieC01pZ43F+xGHMnA6NNGj+gkO811ozm4N6TMS4Xl65TCecVOui3cm2AKxAN
         xv2g==
X-Gm-Message-State: AOAM533MAQCUgYm6SpLogRF1P0SlzSCrtnEYRWzO4BphDnE62Q9DeZdG
        ArQmswRwgaEdhqSlrFKXtottDq7ML56pNw==
X-Google-Smtp-Source: ABdhPJy9B5ZOBGDC2X2Ln5na2zOpL8YrUS7FzOGtaEKRGfgX6pCT328QYm5PbLKrd9uhkotB5yKaub1wDZxxnA==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:937a:8b67:cf77:36ff])
 (user=shakeelb job=sendgmr) by 2002:a37:c0e:: with SMTP id
 14mr2543550qkm.255.1620850798158; Wed, 12 May 2021 13:19:58 -0700 (PDT)
Date:   Wed, 12 May 2021 13:19:46 -0700
Message-Id: <20210512201946.2949351-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] cgroup: disable controllers at parse time
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, shy828301@gmail.com,
        junichi.nomura@nec.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch effectively reverts the commit a3e72739b7a7 ("cgroup: fix
too early usage of static_branch_disable()"). The commit 6041186a3258
("init: initialize jump labels before command line option parsing") has
moved the jump_label_init() before parse_args() which has made the
commit a3e72739b7a7 unnecessary. On the other hand there are
consequences of disabling the controllers later as there are subsystems
doing the controller checks for different decisions. One such incident
is reported [1] regarding the memory controller and its impact on memory
reclaim code.

[1] https://lore.kernel.org/linux-mm/921e53f3-4b13-aab8-4a9e-e83ff15371e4@n=
ec.com

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reported-by: NOMURA JUNICHI(=E9=87=8E=E6=9D=91=E3=80=80=E6=B7=B3=E4=B8=80) =
<junichi.nomura@nec.com>
---
 kernel/cgroup/cgroup.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e049edd66776..e7a9a2998245 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5634,8 +5634,6 @@ int __init cgroup_init_early(void)
 	return 0;
 }
=20
-static u16 cgroup_disable_mask __initdata;
-
 /**
  * cgroup_init - cgroup initialization
  *
@@ -5694,12 +5692,8 @@ int __init cgroup_init(void)
 		 * disabled flag and cftype registration needs kmalloc,
 		 * both of which aren't available during early_init.
 		 */
-		if (cgroup_disable_mask & (1 << ssid)) {
-			static_branch_disable(cgroup_subsys_enabled_key[ssid]);
-			printk(KERN_INFO "Disabling %s control group subsystem\n",
-			       ss->name);
+		if (!cgroup_ssid_enabled(ssid))
 			continue;
-		}
=20
 		if (cgroup1_ssid_disabled(ssid))
 			printk(KERN_INFO "Disabling %s control group subsystem in v1 mounts\n",
@@ -6214,7 +6208,10 @@ static int __init cgroup_disable(char *str)
 			if (strcmp(token, ss->name) &&
 			    strcmp(token, ss->legacy_name))
 				continue;
-			cgroup_disable_mask |=3D 1 << i;
+
+			static_branch_disable(cgroup_subsys_enabled_key[i]);
+			pr_info("Disabling %s control group subsystem\n",
+				ss->name);
 		}
 	}
 	return 1;
--=20
2.31.1.607.g51e8a6a459-goog

