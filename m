Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E673DFD0F4
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2019 23:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNWbd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Nov 2019 17:31:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36056 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWbc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Nov 2019 17:31:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id d13so6524405qko.3;
        Thu, 14 Nov 2019 14:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qyKgxDIoS90Bkq4dmLrHtgbONXS0B4JMDXYzM2TILvI=;
        b=GjsvHBt7MeaEC6ypDHcPMK+s4FU+jBrqyBph1dVSDP6GI5ClRgEmnDD2Hk2fNzRKfP
         z1IBWzaXJeLT1ubyYe0TtRTwRHibve7KSwuFU33vAAOEpobMcSrWuQ3RkD3VWfOXdiw+
         /F6IS2oY+rtMYJbeX32d60XzvRfhF6RTC+Yo7K8KSxkwrnBg+/QuORoDoyMOkTLoTiCS
         cYMhyizV/A9PpsvWwZCI7AtDdcMg+ynVXanL2cPjXHkTxdbe2sU7/EbnEdoX9XBFAdkT
         Ek/6EdXl/XqBOKYkXJzKA/M2VGzSA5+TFpXf43Fkow8BNPoSwm0aO5y6L6wtVTBapJo/
         0gSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qyKgxDIoS90Bkq4dmLrHtgbONXS0B4JMDXYzM2TILvI=;
        b=m/GkTU1fFS/OKHazpmz3e6CS8rbYVrz4mt+zLgmvC0RDMrFiFO0+lSbkNjU8XHuspD
         zzaSLRYp5Q/F9DFcoAGXtc0Mf9om1BFn7oLDWgav81P9HQxeoysOICqZ7l2yhGmZBBAV
         fwHNJczx22qjPSzP7jy9ksY+m0muAGrAcJQ1ORGfRFNTvfZX3zKsO/nknmuFoPPR+9mN
         cH3SAcvajm3c/+SZQGjZaplkdrdPEhNBLSm0/TOqdnl3vOCN1L1ivzZJ3+dkqFHS5U9T
         uE6WGR2VdZzVbR0fp5c1IVjxRBf5hvr1luv3fneJ4lcdv5edh8DswBKvdeGVKJQSgE2B
         QyAA==
X-Gm-Message-State: APjAAAUYXrsN0Tabx4LZej/OxlCfpQ3D4iW/F6ZKlBbI7Ty8XTOAZ5AV
        i/hcDAcLQUsZah+D7JpssHk=
X-Google-Smtp-Source: APXvYqytpqrP2AH8JJZOMk4LKbZkA401xnv/6PKzXgmJCV3xg7WdX/M+YdK/OO21loAmQxwc/gwY8A==
X-Received: by 2002:a37:d02:: with SMTP id 2mr10040528qkn.307.1573770691207;
        Thu, 14 Nov 2019 14:31:31 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:69f2])
        by smtp.gmail.com with ESMTPSA id 80sm530624qkh.108.2019.11.14.14.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 14:31:30 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:31:28 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Faiz Abbas <faiz_abbas@ti.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, kernel-team@fb.com,
        Dan Schatzberg <dschatzberg@fb.com>, Daniel Xu <dlxu@fb.com>
Subject: [PATCH block/for-next] blk-cgroup: cgroup_rstat_updated() shouldn't
 be called on cgroup1
Message-ID: <20191114223128.GM4163745@devbig004.ftw2.facebook.com>
References: <20191107191804.3735303-1-tj@kernel.org>
 <20191107191804.3735303-6-tj@kernel.org>
 <cd3ebcee-6819-a09b-aeba-de6817f32cde@ti.com>
 <20191113163501.GI4163745@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113163501.GI4163745@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, cgroup rstat is supported only on cgroup2 hierarchy and
rstat functions shouldn't be called on cgroup1 cgroups.  While
converting blk-cgroup core statistics to rstat, f73316482977
("blk-cgroup: reimplement basic IO stats using cgroup rstat")
accidentally ended up calling cgroup_rstat_updated() on cgroup1
cgroups causing crashes.

Longer term, we probably should add cgroup1 support to rstat but for
now let's mask the call directly.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
---
 include/linux/blk-cgroup.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 48a66738143d..19394c77ed99 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -626,7 +626,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		bis->cur.ios[rwd]++;
 
 		u64_stats_update_end(&bis->sync);
-		cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);
+		if (cgroup_subsys_on_dfl(io_cgrp_subsys))
+			cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);
 		put_cpu();
 	}
 
