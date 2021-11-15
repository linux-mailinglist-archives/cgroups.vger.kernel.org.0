Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A77A44FCA8
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 02:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhKOBHW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 14 Nov 2021 20:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhKOBHU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 14 Nov 2021 20:07:20 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA77C061746;
        Sun, 14 Nov 2021 17:04:25 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so64344147edv.1;
        Sun, 14 Nov 2021 17:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=uejnxkT5XpebYh7AJgnAoZS2xCFi6l9f8v0QEmMOCyM=;
        b=TNGczOiR+iwHno2SJBMCOT4TunVBBZElYiMRh8BVt9VPMWc5LI+5LhIufZSsv3H88Z
         ikwlGPZnl4ZIiiXYkXUgQqYdI253+48ZCaxfV2m2bx3cBg9aU8XAy1+vghKH6Y7IP9Of
         oiJgeovnV2OyfCOYubEtrU0hmanZAFcHfKFR5FroIxAVgLQKVkj8TuNC7oTX9FxQP+0Z
         jacZe0CDY4fWA/o7Pe9MJfzApF8FgSrLp+1//UrQceZiOpaBzf9wLpzsvw71mTZXgSwe
         37NdW4Pgsql6E0fKnlDDKoszgyK7RhFB+EZqm8d4B7IHk73yo3FttJQMwuTWFXMopayH
         JhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uejnxkT5XpebYh7AJgnAoZS2xCFi6l9f8v0QEmMOCyM=;
        b=u9ZSdUtVWJKi9odR6P9ywBefrRxBy7q9gYAfxAg90W2XcFwghYP3SKXnQA/7bgRjI9
         1ZeRYjF5D1V8nj5LmabI/l7nKpWeSoOz5vdDdQ/CXtIyRtBW61P6zRNSmKSyMx7wvJbT
         EmSzrvH9a0wicamXRWeIvr1DGh+zzbFXxwqTF+Wy0RNYkYKKFZDcdNo9t+sihEJWhgvp
         9iQY/P2BRoncCMFYnYMi9BLsd6oTbHozIjEZWQl0DGwP2jZ5MvUkpbYfcMcM/L3PIJ/t
         hblq0/JTpI9jZMb1QsPsJOdSKRLLF9kfIe+f/BiSS1CSFC3YL9G/572b4N5ltnxG1IjY
         AhJA==
X-Gm-Message-State: AOAM532o493k2vBgi5F8TlfS8eCYLIZ9s65GAynvlTUC7zhlXgyVCcr5
        Ifl5Z2XBtEy37HM1rEZcwJQ=
X-Google-Smtp-Source: ABdhPJxXwgk53qPinlKejr41eeU6oobiIeCBmRIF9dXRK5ggumctXAquABpob98tZD/RUpZierCmpQ==
X-Received: by 2002:a05:6402:27c6:: with SMTP id c6mr49035118ede.152.1636938264006;
        Sun, 14 Nov 2021 17:04:24 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id sa3sm5569180ejc.113.2021.11.14.17.04.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Nov 2021 17:04:23 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] cgroup: pretty format /proc/cgroups
Date:   Mon, 15 Nov 2021 01:04:07 +0000
Message-Id: <20211115010407.20380-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Current /proc/cgroups looks like this:

cpuset  3       1       1
cpu     2       1       1
cpuacct 2       1       1
memory  4       71      1
freezer 5       1       1

Let's align the title and value. After this patch, it looks like this.

      cpuset            5                 1           1
         cpu            3                 1           1
     cpuacct            3                 1           1
      memory            2                71           1
     freezer            4                 1           1

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
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

