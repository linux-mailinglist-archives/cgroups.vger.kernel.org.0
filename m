Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC444FCAC
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 02:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhKOBQV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 14 Nov 2021 20:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhKOBQV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 14 Nov 2021 20:16:21 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C49C061746;
        Sun, 14 Nov 2021 17:13:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z5so4464418edd.3;
        Sun, 14 Nov 2021 17:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8dSDliGOTbrCRTDPXM+yPCUeDQ1veUO4KLyhLzS8ruY=;
        b=apxFVYMKfx0nm/y0nIvv+SpIAJNFXAG1Oq4gGtfxk6xwJbv6V9aWCrObLHXv9MuOgY
         oY2QbT34qrEJbKJSQsk1BnakQSjFI5o4kqPfJaWC7+WPLPNcH5khOR2dB3soh8iH9/jd
         mdauPJeQx8gXmbkv8eu0h9UaZh8/OBb9F5b96CC7nmqfpWuVQUHxsDOT0bacEngndFxa
         3bcoflvH4ETZq0pJUmmhd2igUsG40UE37H6MoujEHW8/Cq0ecMTB4vukz+eLYtWE29jn
         VO1r8nVs/HXgpVzG9zVH/7p4+ciCmdJcftCEy4sxFt7T8tAfSfTwKcosNMaeNAhWa9nz
         cjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8dSDliGOTbrCRTDPXM+yPCUeDQ1veUO4KLyhLzS8ruY=;
        b=CwnxPqFUmjM5thjdPv1jNFmpRIGcTvLK8W4Hpn/PyL5ewH4brchc18KIv40t4SWFU4
         DXTXvJoWsKZUXRXQrnILtJzskVbUwefci3Jta8GmkyxJK+j6TnIVi289LTPDkjIfCACb
         MMAjQ1J/t+SBGkVT5PdgWM0ZmROiHt0cpKMbrelRE4Q+MtQNd8EPqkmZvhRAstSY/+bY
         7UjVfn7RHWtL8b5qaxEGpIb/Au9hhgV9vZSu7kry3TEtab48D+iL9azzqVgljG6DT3LP
         m/blra8PPAzIhz/24E7UMarQ6VjSx6p9hI+eH9QnjqqXs2W1Knm7OWuu51zq/iS/fek/
         6Oyw==
X-Gm-Message-State: AOAM5311Ey6ivEkDVH8p5xzgpIDdZyCPJiTe5KsHPLBxvjna0OmQWtjD
        JRNBWqOEGwd27C3HYDZ9VVA=
X-Google-Smtp-Source: ABdhPJxWMXZYk+4CWkeBAui8+UgRYJkBKdOyo3ACVLsd9k3y9B8YkLdabMptVqwET8vR8TK4sT4Trg==
X-Received: by 2002:a50:d88b:: with SMTP id p11mr49922006edj.287.1636938805399;
        Sun, 14 Nov 2021 17:13:25 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d14sm5757352edu.57.2021.11.14.17.13.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Nov 2021 17:13:25 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2] cgroup: pretty format /proc/cgroups
Date:   Mon, 15 Nov 2021 01:12:53 +0000
Message-Id: <20211115011253.20778-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Current /proc/cgroups looks like this:

 subsys_name    hierarchy       num_cgroups     enabled
cpuset  3       1       1
cpu     2       1       1
cpuacct 2       1       1
memory  4       71      1
freezer 5       1       1

Let's align the title and value. After this patch, it looks like this.

 subsys_name    hierarchy       num_cgroups     enabled
      cpuset            5                 1           1
         cpu            3                 1           1
     cpuacct            3                 1           1
      memory            2                71           1
     freezer            4                 1           1

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: the title line is omitted for the start "#"

---
 kernel/cgroup/cgroup-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 81c9e0685948..5b177e0eca2c 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -664,7 +664,7 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	 */
 
 	for_each_subsys(ss, i)
-		seq_printf(m, "%s\t%d\t%d\t%d\n",
+		seq_printf(m, "%12s\t%9d\t%11d\t%7d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
-- 
2.33.1

