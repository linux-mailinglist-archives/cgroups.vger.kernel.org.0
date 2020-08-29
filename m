Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EBF2566C3
	for <lists+cgroups@lfdr.de>; Sat, 29 Aug 2020 12:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgH2KDU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 29 Aug 2020 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgH2KDT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 29 Aug 2020 06:03:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD73C061236;
        Sat, 29 Aug 2020 03:03:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 67so1644013pgd.12;
        Sat, 29 Aug 2020 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ve5Y7UpqDFbuWlDWcOR+wgYs8OkOidRTnnjW9IZXZ6U=;
        b=bs9p3/w0ksSNIWFN2OvCev28CeZY6aVLLibarFLpX9igmm3UCZ0WpSDC0RjHJVE75F
         H6W7uKT9MCe1b8AIjN2AvBuJ6gh37kMBK2eVt+hisLVudA4m5Af39dZmwu3E09DGHCKV
         cNpW5Cwsaa2UfbToWG2axFJcuWHifEaCZY3XWYMpCK7YRgK/u20e1drvosjW9UxV5DYU
         7DOmTGZmqGPYe18nCsshEyruy4jEVu4ZWmQyViWOxpBNwccL1/UnxisZ01sjNv1bPZ7K
         yrOuGOvYzmGSonLRH3hz0LQUVq28P3ZeYf8QIdh/tH5OkTIO2/6LXeg18S+ceeUI/u2T
         XRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ve5Y7UpqDFbuWlDWcOR+wgYs8OkOidRTnnjW9IZXZ6U=;
        b=XbiMcepRa5Ub51Pm+3xSp+KByb9UZ0uGcv3I9NDv8pYYTqY0y/5XQbBcg2Ci9ygFb1
         mTBSWLVd8tselE1V5VVpjWe5p8bB4vPFOsNO6Oqoa6Z3EAxIr1U6yXl6xu0BsebFD1j/
         hUQR7E85KHwXOmQ6G2E30f39rROXNUWGJmV80ixLuUJ7szIKCu2p3mIU+bgN0aqp7tJ/
         iizhlAM3LREk/sgQE3AfhiEMafsGgQyXhjF+mobo/OT0NY2KwxVXpRjmtcW8xgvd2mTG
         q+BuQ62oMGgb+IK2+cyObWeGT1VmfEmJe96KJ+1wB6hqBD9K/LEhClvN2YxODfYhZn+d
         65Uw==
X-Gm-Message-State: AOAM532In9jZWwV1SYXapGxYL2Su6dUgotyPW7r7TJHRtDb2CTojlPsj
        G7HZafBelSIzfzOm4AQTJik=
X-Google-Smtp-Source: ABdhPJzoTwhsMjm/U955Ohjqv+ei2DZZG8H6U8UGf9Gye8cesUtHSfljq1YVtlpDFw91JYyt531fDg==
X-Received: by 2002:a63:fe06:: with SMTP id p6mr2003724pgh.337.1598695398716;
        Sat, 29 Aug 2020 03:03:18 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id v12sm2040355pgk.81.2020.08.29.03.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 03:03:18 -0700 (PDT)
Date:   Sat, 29 Aug 2020 10:03:16 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     tj@kernel.org
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, haolee.swjtu@gmail.com
Subject: [PATCH] cgroup: Delete unnecessary if statement in css_visible()
Message-ID: <20200829100202.GA855@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

css_visible() is called in either cgroup_apply_control_enable()
or cgroup_apply_control_disable().
In cgroup_apply_control_enable(), we have checked ss_mask before calling
css_visible(), so there is no need to do the same thing again.
In cgroup_apply_control_disable():
 - If css->parent is not NULL, we have checked ss_mask in the
   second condition, so there is no need to do the same thing again.
 - If css->parent is NULL, dsct is root cgroup so the deleted if
   statement is always false and there is no need to keep it.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 kernel/cgroup/cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd247747ec14..b6714166106d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3023,8 +3023,6 @@ static bool css_visible(struct cgroup_subsys_state *css)
 
 	if (cgroup_control(cgrp) & (1 << ss->id))
 		return true;
-	if (!(cgroup_ss_mask(cgrp) & (1 << ss->id)))
-		return false;
 	return cgroup_on_dfl(cgrp) && ss->implicit_on_dfl;
 }
 
-- 
2.24.1

