Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891742E8A0C
	for <lists+cgroups@lfdr.de>; Sun,  3 Jan 2021 03:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbhACCup (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Jan 2021 21:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbhACCuo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Jan 2021 21:50:44 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C22C061573;
        Sat,  2 Jan 2021 18:50:04 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c12so14238047pfo.10;
        Sat, 02 Jan 2021 18:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=p6iRhZ/uYPqRIQIFRU+QWQNN/PsTmWN2Q1BgTb5rkC4=;
        b=kmjT0+e+DXnGVq/NU58+KkWaJnAxIdBusxYqE/mjp9QJVLIDZ8pbW6u3Jpw1yh3wLI
         WGhq9ab+bgq5iWnCOvOZaX0/Mu7XPz4CBQ5tcx2m4aLgssWPsebKfcSQKJ4A0JZIjznz
         vs7vT+Wb+6ZjaJfKoDZbWnedxzEfQ8h/ywWRq3dsqwUTfT/rvEXQgCMzb/8p5s7djCS1
         dPW8+KAMCSc4ujNuYaqMU8ykLEkl46MuYXZ8CHmZN3VQZlDJfx43aKgW4JxnXY9+ib7R
         f3oX0/MlSGCXJEocqvyriKJtYskKkjq7twPLMotJtfcD3Z2ZLPrdfe1MQ5LsIoEqGQSq
         VGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p6iRhZ/uYPqRIQIFRU+QWQNN/PsTmWN2Q1BgTb5rkC4=;
        b=svo3NWnHz2/UpnAM6kYAXdBEjaJhwu3qo35IjyDGsMvuiDKUrwFXTnZ2Q+Gc4n0Pj4
         KrZBxB8H5oYx2WmV2uudFUS9kVwNG9hoNc0ePqQ+pESKjvpIeyqY8pU3eTmOH8ZlNLc0
         uOx3fAN7q3BLWlwD8+qX5cpvdNHEqSEq6zY6CPSkyO91NRFOshJpY7tCmHclQ+qoodyn
         QdOXWkzPMFgwHG0CevAU6rFLjmqbltvdwkMux+uxWjb4GsssmpZXhtqUFNheytSXD4TP
         4bco9z4DS6gHy6hozQ9qiyYJqUN6AmaQsA2LFKTEsOXCv94I19MBXWku09FhPeSGdqPO
         KhZA==
X-Gm-Message-State: AOAM531mxcO4vbQIdx7f18Y+2zix2snKzqKsQgcigfvA56BsAtWFGMez
        bX1ZF6nUD61gJOtJlA5xLR4=
X-Google-Smtp-Source: ABdhPJyejemM8Q9mdxTKugp4+eoWRPt5lN/UsVlyn+1Nll1s5Dp3arwyuTDx2u8pXxAmhgCcPIi8Ow==
X-Received: by 2002:a63:c80e:: with SMTP id z14mr65630856pgg.435.1609642203964;
        Sat, 02 Jan 2021 18:50:03 -0800 (PST)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id er23sm16522048pjb.12.2021.01.02.18.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 18:50:03 -0800 (PST)
Date:   Sun, 3 Jan 2021 02:50:01 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     tj@kernel.org
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, haolee.swjtu@gmail.com
Subject: [PATCH] cgroup: Remove unnecessary call to strstrip()
Message-ID: <20210103024846.GA15337@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The string buf will be stripped in cgroup_procs_write_start() before it
is converted to int, so remove this unnecessary call to strstrip().

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 kernel/cgroup/cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5e9cb81c088a..8b3554c1113a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4774,8 +4774,6 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 	ssize_t ret;
 	bool locked;
 
-	buf = strstrip(buf);
-
 	dst_cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!dst_cgrp)
 		return -ENODEV;
-- 
2.24.1

