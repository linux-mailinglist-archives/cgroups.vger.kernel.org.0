Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FAB3CB52C
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhGPJW2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 05:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhGPJW1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 05:22:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392F3C06175F;
        Fri, 16 Jul 2021 02:19:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id o4so4747887pgs.6;
        Fri, 16 Jul 2021 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=uDUNa0EcB9Oof2rQJyV0DbNI25r/rWDu0m3opyTl7Y4=;
        b=Zm8GGZrZI8+jWXAZOl2WF2v2GIioF9ifPmmt3UEAnyivukqQoFOFcqlnuxWEo0j6Tb
         CXu/wINeRiG8mkV9Gs7bVQDfOVfBQkoemU+MQ72ZaF2A5K87tbrCBg/dxStrLWUBH4Dj
         IJVvD/jDVnsQGGiO4WSZLZzCkL7TDd5mEH0SMayoQrNhhiBnbrWNgGzutwk0zGLZKjAI
         SswtoZHcOBdYNnKVEIHwpUiWTQ/Yi+tFOQfWhOsCmX24VorMn/Bvv/pgrKYFckB0V3oJ
         z88F367aH3xcz8N3nlBgzaeskTjmzSGkOcb2ayFotDieePcVLHXnUdo/s5h/sxJlYXpD
         cvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=uDUNa0EcB9Oof2rQJyV0DbNI25r/rWDu0m3opyTl7Y4=;
        b=RRlk2RA9/WqnQ8NaHZxOE7x8vO2eDh+Nj2zI5BzZIzDDRQW6puruP14glf4hXrkA3D
         msck9Ht2ZHjTQMxsMGhPItWzIytnIYuk4WakqN9VUhplxjU0Rqe/jplsZv4dwlWCVYW/
         b5DsiZMBjXjdBuKYIOIIIBFEk6mwdNgOWiKsT2Mt3E4pGZQWQR+aj2WcTH42crasuzq3
         OGviCWdSQmfHnLn3ya9JCTK5AL4tVEjj0oYKsz8fKJ2ddsc9WtX0qzXEI8vDgEzcyjA7
         7osOzXuQJWrZHHKroQKVNDccHe76ORTNLB8RPnfkOUqZzMCTUMRCKlGGrDxRcxcacUB/
         VsEQ==
X-Gm-Message-State: AOAM533csImZccPOTJgbbHJfaNwzLRSrmmkP5cHOIloO9lSrQPvwgq2o
        ig4udgMwR9YY7BrBZFNHO5k=
X-Google-Smtp-Source: ABdhPJz03Vm1fOPx/HEDrKDSD/IFw1Vf/YRbNkbx3EMVikgEPc4Kam7hcqO6WcSah2dYY3hPMsmpOA==
X-Received: by 2002:a65:6412:: with SMTP id a18mr8781742pgv.445.1626427171879;
        Fri, 16 Jul 2021 02:19:31 -0700 (PDT)
Received: from ZB-9C0LZZ2.360buyAD.local (5e.8a.38a9.ip4.static.sl-reverse.com. [169.56.138.94])
        by smtp.gmail.com with ESMTPSA id d15sm9371394pfl.82.2021.07.16.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 02:19:31 -0700 (PDT)
From:   zhaoxiaoqiang007@gmail.com
X-Google-Original-From: zhaoxiaoqiang11@jd.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     viro@zeniv.linux.org.uk, cgroups@vger.kernel.org,
        trivial@kernel.org, linux-kernel@vger.kernel.org,
        zhaoxiaoqiang11 <zhaoxiaoqiang11@jd.com>
Subject: [PATCH] cgroup: remove cgroup_mount from comments
Date:   Fri, 16 Jul 2021 17:18:53 +0800
Message-Id: <20210716091853.1049-1-zhaoxiaoqiang11@jd.com>
X-Mailer: git-send-email 2.27.0
Reply-To: zhaoxiaoqiang007@gmail.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: zhaoxiaoqiang11 <zhaoxiaoqiang11@jd.com>

Git rid of the inappropriate comment

Since cgroup is fully switched to fs_context, function cgroup_mount
is removed and it's confused to mention in comments of cgroup_kill_sb.
Just wipe it out.

Signed-off-by: zhaoxiaoqiang11 <zhaoxiaoqiang11@jd.com>
---
 kernel/cgroup/cgroup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3a0161c21b6b..d0725c1a8db5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2169,7 +2169,6 @@ static void cgroup_kill_sb(struct super_block *sb)
 	/*
 	 * If @root doesn't have any children, start killing it.
 	 * This prevents new mounts by disabling percpu_ref_tryget_live().
-	 * cgroup_mount() may wait for @root's release.
 	 *
 	 * And don't kill the default root.
 	 */
-- 
2.27.0

