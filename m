Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363E1169C79
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2020 04:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgBXDAb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 23 Feb 2020 22:00:31 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46570 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgBXDAb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 23 Feb 2020 22:00:31 -0500
Received: by mail-qv1-f67.google.com with SMTP id y2so3539527qvu.13
        for <cgroups@vger.kernel.org>; Sun, 23 Feb 2020 19:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axj+zYhKgui/GRpLokmGt4hkOovhk9D4qksINrRJ1Ak=;
        b=f419reAEsjTeJdGXZaoZyZpTiWQNTrZvDjlFHYNYo6hws9F1baASusMDFHpIAblfCn
         MDrLtDYdBa37g4PRqNh/MPFrxz5Z85DqSVa6Dzdzins0kWeNGM++kzZ0/peBTuhv9UYm
         aqGxFrqA+fqrkOxvGd/d+j1ZSxUtdy6ueQ5HDJ85/8FME2IJ4a9dzvWa2g8Srhpt9dSf
         561JzE6H7EI7d1vJtVqCtT6ZWFOhOjkAtZhzDP0P1Qvn7+S9o3evgs8TcB+UVGHp4XcP
         ATkJnrGXsGL3fYd3Qd07QCnJZ7a7tiJwhOXEUedVP4rxKZTn6s6ROrRoHLSPBHZS/RnR
         e2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axj+zYhKgui/GRpLokmGt4hkOovhk9D4qksINrRJ1Ak=;
        b=OpKHspzs4J8PWTEANKAPQyIyGPRuQ5FAk0s/FxotmUBVVTgWv1B1Yu1Zu0H6/DWqui
         K5q3nuBt5qI5zdXGREitm6RUz6BBw1pyWE+PPZS4tJ5QTHEJ4yySqG81Kw1ysH8mNBBH
         RuUfjHgA3ssudYTQYIEUXdDNNG0tTpPtL9HmlK4wPa6q3QMMxEqZ7v4LsolllQUrsfTG
         5MPnLBsjd6mnlXkGqq3pIgo/E+zDwONVf5HvSVHk8xtyZvXS4AR2p5Djjz2kdAhvpSsB
         W1/zS5p6CaXfi/rZ2T5Z/eAEabQwfzmjx2HADdHO1jzhTkZldrlkJsUX1kIFLnUj4GdU
         IiEA==
X-Gm-Message-State: APjAAAVxFsNH8hE7uVxVqG8Z9jpePb+h0wuS0oWA/z902uBtm4fKRxZj
        GabjL33huOKASVRvMdDVwhfn7g==
X-Google-Smtp-Source: APXvYqwNK5+khXEgg8ag3M7aq6QkrRCoOOzbAMD7wOmLl4yiFPdzv+V2JCKxPRHFxjSSKNReQogbeQ==
X-Received: by 2002:a05:6214:176e:: with SMTP id et14mr40790796qvb.133.1582513230182;
        Sun, 23 Feb 2020 19:00:30 -0800 (PST)
Received: from ovpn-120-117.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t2sm5219859qkc.62.2020.02.23.19.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2020 19:00:29 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tj@kernel.org
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] cgroup: fix psi_show() crash on 32bit ino archs
Date:   Sun, 23 Feb 2020 22:00:07 -0500
Message-Id: <20200224030007.3990-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Similar to the commit d7495343228f ("cgroup: fix incorrect
WARN_ON_ONCE() in cgroup_setup_root()"), cgroup_id(root_cgrp) does not
equal to 1 on 32bit ino archs which triggers all sorts of issues with
psi_show() on s390x. For example,

 BUG: KASAN: slab-out-of-bounds in collect_percpu_times+0x2d0/
 Read of size 4 at addr 000000001e0ce000 by task read_all/3667
 collect_percpu_times+0x2d0/0x798
 psi_show+0x7c/0x2a8
 seq_read+0x2ac/0x830
 vfs_read+0x92/0x150
 ksys_read+0xe2/0x188
 system_call+0xd8/0x2b4

Fix it by using cgroup_ino().

Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/cgroup/cgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 75f687301bbf..cd5f41289f7d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3542,21 +3542,21 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_id(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
 
 	return psi_show(seq, psi, PSI_IO);
 }
 static int cgroup_memory_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_id(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
 
 	return psi_show(seq, psi, PSI_MEM);
 }
 static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_id(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
 
 	return psi_show(seq, psi, PSI_CPU);
 }
-- 
2.21.0 (Apple Git-122.2)

