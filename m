Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70530164E44
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 20:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSTCD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 14:02:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41505 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgBSTCD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 14:02:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id 70so551250pgf.8
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2020 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gaq6NM5o+UM+pFOLAVDFZv0/RMH6toB+rITqZIOsMYE=;
        b=lLfi6cyMIxFEgNuwaGXNFp+Ts5Y/KtKR4ejCootJgO0ckrc0gRvgZ7nZudfZhjQoBI
         Q+Knj9pxcd3wq4LHf974POD/1Hnc1WLhh+kb4jKuK0df5rwk2iv1uTnor3Qx5iHTuPG0
         6K4HnlgfXU5h6k7AIRjJaZLVQOz6UOuRrMgB8+OAD6HMboRGS5lIdf7dZ6Ucih5+R7Yl
         Rog2cqFxxqxQHrPhjPpD2KCEN9OsLng7bSpIYqsSPDMDkmsISBpLWbLW2+0qZvzT1V07
         z5vq1ehXDwR3+F8rgzV7zl1I6T57sNXV+zO+rlE6KPJkoXVN3bBVWhpnq9CEo2lp5Kyv
         f3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gaq6NM5o+UM+pFOLAVDFZv0/RMH6toB+rITqZIOsMYE=;
        b=V2jOR5JtJ+NH0jyYOo2slfnripMxDgGQxpM/JgEGmzuB8SVcKkd7uCFgmgehu3KSb3
         N+QeJi3PqchUDBk1wW0lWgaD8eiOui9DNoXauAHJD0DHB14k5k9HPYkT+jznhdJAFOHQ
         HUKLeMKNHrwttLxij1Ar+J+C1U+2N0/EO5NrkTpmaHm7AvVdDlP9bXVCBC9SUii0+s9X
         jn+Rh2ZPAq6jVOFjvsIkb1y920nJpgusLidnikeg65SJFPE7Tm3dLVdWGDvxp9IfVBGh
         wdUIKUvqtyW2zSKeBses9Oz/hnlIq95BTdKvwTZ3RZadgpdUa4kEq9+K1PVKS1tsVGYB
         F4Bw==
X-Gm-Message-State: APjAAAW1fiJxEGlpHNE2YY4Kgf/7/41QsENzgsHZU3CQXmjzXHMHkcRa
        ESDifXlZl1EXDnO1DS2a1JUryvS7+XQ=
X-Google-Smtp-Source: APXvYqzL9QHxtjM0arkcSibiR2+WuYV6t3I4blhYPV4i/x7bknHVO47R8L1k55I3DTecqOfiHbMLSg==
X-Received: by 2002:a63:ba19:: with SMTP id k25mr30971648pgf.333.1582138921637;
        Wed, 19 Feb 2020 11:02:01 -0800 (PST)
Received: from cisco.hsd1.co.comcast.net ([2001:420:c0c8:1007::7a1])
        by smtp.gmail.com with ESMTPSA id q12sm345195pfh.158.2020.02.19.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:02:00 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     cgroups@vger.kernel.org
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Serge Hallyn <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] cgroup1: don't call release_agent when it is ""
Date:   Wed, 19 Feb 2020 12:01:29 -0700
Message-Id: <20200219190129.6899-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Older (and maybe current) versions of systemd set release_agent to "" when
shutting down, but do not set notify_on_release to 0.

Since 64e90a8acb85 ("Introduce STATIC_USERMODEHELPER to mediate
call_usermodehelper()"), we filter out such calls when the user mode helper
path is "". However, when used in conjunction with an actual (i.e. non "")
STATIC_USERMODEHELPER, the path is never "", so the real usermode helper
will be called with argv[0] == "".

Let's avoid this by not invoking the release_agent when it is "".

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 kernel/cgroup/cgroup-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index be1a1c83cdd1..b3626c3c6f92 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -782,7 +782,7 @@ void cgroup1_release_agent(struct work_struct *work)
 
 	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
 	agentbuf = kstrdup(cgrp->root->release_agent_path, GFP_KERNEL);
-	if (!pathbuf || !agentbuf)
+	if (!pathbuf || !agentbuf || !strlen(agentbuf))
 		goto out;
 
 	spin_lock_irq(&css_set_lock);
-- 
2.20.1

