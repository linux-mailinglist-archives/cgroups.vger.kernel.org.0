Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB6335D4E7
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 03:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbhDMBj2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 21:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbhDMBj1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 21:39:27 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4308BC061574
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 18:39:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id p12so10796639pgj.10
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 18:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=D8cI9p8duSAuwc0HuZGq6ac3QTWtYsZEHTOhpxbujwY=;
        b=VEAgWfFzhjH6Aq/MB7OIrsgZ27v6iLoERBo84DYM2EtxfQjTQw6u5Hc439W+fhK8rh
         sCNSLEsFZd5nIOJzec8uQ4dLoceN/7urm7KmQQ+AS4wocWlG/wg2C0O3kUi7+xdZBWpj
         eIYy45pXDN8DEJnTyk619D0G+PeSyupZeJ9eyuU6gcdr8W37soX3Z5haOHeGvKMxxUyz
         yNGiSxmvHBDTi3wDc3jl+2/pwwWNQWDF2TYYY1Z7SQahiblPItifkLI+mcP+GsDWmcAh
         C32HbbEwchQQbJTYKCuIyO+6hcMqkfeXFd0a8FN4gllacZlTCWabfH0+NU6Ehsb61kTf
         0Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=D8cI9p8duSAuwc0HuZGq6ac3QTWtYsZEHTOhpxbujwY=;
        b=haQTcIrWTLIKBXhKUBg+ZGl99YvdkaB4ZZU86mB5m+hWboQVnfyqq8IpRzw9Jjy3IV
         fTKsCOcd2pCtcvm9LRSlJ8z/ruaQe5JvQIUzIRKi+BpW8O0cRBj3LGr+M+GgFBaW9Wkj
         8aZUEaf+HfRWuKZhM2KbAjSMLjZJcFkMFGbQ12uAXjIvwIo3gSVS5LKTPIm/i8drw8sj
         6FlEnW66EEBEn7cCZ58NA57ZlIsRCEjb2Mjbuj+mWicrTGUA8H0dq+ZKWlRVBVQ8e2Ba
         vL7lm0N4urFZRsy4f1kzCt90CZLLlAAChfQOLFi3d34FTpcEEFUDwuRH07QBr2q1GbX2
         zFYw==
X-Gm-Message-State: AOAM533YgxVCe+Xa/pH2ISQn8zVHtVKEIzg939PK9e2hh+NrikV7tmZj
        uqOTIqbXZ9zZ2ZS52HVkvqs=
X-Google-Smtp-Source: ABdhPJxE0FARvR/0NWp6oGsUjzBW9JRldTGUmCEU4wg7MK3g3h307rSvKpb/f6VbOLKHbvJFTnZaqw==
X-Received: by 2002:a63:1717:: with SMTP id x23mr29428600pgl.89.1618277948913;
        Mon, 12 Apr 2021 18:39:08 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id 33sm12231396pgq.21.2021.04.12.18.39.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 18:39:08 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Subject: [RESEND PATCH] cgroup: use tsk->in_iowait instead of delayacct_is_task_waiting_on_io()
Date:   Tue, 13 Apr 2021 09:39:05 +0800
Message-Id: <7fee39d482a783254379f2419a00b9a9f32d7f2e.1618275776.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

If delayacct is disabled, then delayacct_is_task_waiting_on_io()
always returns false, which causes the statistical value to be
wrong. Perhaps tsk->in_iowait is better.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 kernel/cgroup/cgroup-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 32596fd..91991e2 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -727,7 +727,7 @@ int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 			stats->nr_stopped++;
 			break;
 		default:
-			if (delayacct_is_task_waiting_on_io(tsk))
+			if (tsk->in_iowait)
 				stats->nr_io_wait++;
 			break;
 		}
-- 
1.8.3.1

