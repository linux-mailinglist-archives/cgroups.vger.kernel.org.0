Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7072C3AAF54
	for <lists+cgroups@lfdr.de>; Thu, 17 Jun 2021 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhFQJMJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Jun 2021 05:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhFQJMJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Jun 2021 05:12:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825CEC061574
        for <cgroups@vger.kernel.org>; Thu, 17 Jun 2021 02:10:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a11so5858627wrt.13
        for <cgroups@vger.kernel.org>; Thu, 17 Jun 2021 02:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LddN6VdqgEQMBDMe5FR55fpFlxE7qF0s8cEeKWSAjEI=;
        b=KZpHq/WPIKCp1FfdmUAv30N4kxlka+BYdq8VCOr44rPGmtN7nA81Ky30TdKCsWiaLH
         WfeW6XrSTyoae7fp2LbfK5so5gWjrQJba25FfRA/ZDltyzU1h6uaCPi6VVeFBTtuaOVN
         YvwjKpmnRcBZ+vr5GfuKOuzlgz9AxJX3Dk8M/icA84TW4K9SaB3v19hBxBQipD5i7XLy
         t1Z6Zjmx+vys6N2FZm2y1cR8tUA1E8fWzqtTxw10nx9ufCPJ8HpaCypgTpde0BjzyrIY
         IHccjezjR6A5ECS4ddSOZeuMVW9YMeNDOFUkbqS+8SkqDxFhsOUKyAURr3mr6WARAhfR
         ypWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LddN6VdqgEQMBDMe5FR55fpFlxE7qF0s8cEeKWSAjEI=;
        b=m3b/inOvMKQmyRmjVcqMRKArFj9hNUdpw99u67am/BG6ZrCYJe8Ou5JNyqFP1nkqEf
         PnGJG9xEnTt4fyuBDOAxKpFUNZcVni6LbEPITrRSUPRWujGXMNOG/9u+T2mmpXJ7SLdl
         cO9ZKHLoP2jk75CaDXFCNYf/631Llwzd/hbgm+YYh/7Psl1y/a7KIEwUrlYGv8OoLbUl
         k4QcQ3CVaKGk9O16RojeR7k+jfw2TQCLVCDDtF0Ts513+Yt4GrYUDd5ocP+gUxGghO5q
         X1JW3GaTGWaopSTmAfghJTQeFU8KtekceZ4W6pqZLUgkvTckyfx3VhA8OzzHwFaFAx9E
         pwpw==
X-Gm-Message-State: AOAM532y1QDXg6GVjQyLhHq6UCn/C+XihdnHcBdSCpDiPxSIpNNgJYhj
        FuT+anHbjy9ilwwuX5DdBO/xog==
X-Google-Smtp-Source: ABdhPJzmiMDIHpo1Gi9jB6ZSpBA3YLu1mMpg3dE7vWL9Cqi1rMgj4OtezJDP0Pl3q0d2h4hM+mKjjg==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr4444000wru.192.1623921000089;
        Thu, 17 Jun 2021 02:10:00 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id m7sm5179719wrv.35.2021.06.17.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:09:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH 1/1] cgroup-v1: Grant CAP_SYS_NICE holders permission to move tasks between cgroups
Date:   Thu, 17 Jun 2021 10:09:41 +0100
Message-Id: <20210617090941.340135-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It should be possible for processes with CAP_SYS_NICE capabilities
(privileges) to move lower priority tasks within the same namespace to
different cgroups.

One extremely common example of this is Android's 'system_server',
which moves processes around to different cgroups/cpusets, but should
not require any other root privileges.

Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 kernel/cgroup/cgroup-v1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 1f274d7fc934e..56d0d91951f02 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -510,7 +510,8 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 	tcred = get_task_cred(task);
 	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
 	    !uid_eq(cred->euid, tcred->uid) &&
-	    !uid_eq(cred->euid, tcred->suid))
+	    !uid_eq(cred->euid, tcred->suid) &&
+	    !ns_capable(tcred->user_ns, CAP_SYS_NICE))
 		ret = -EACCES;
 	put_cred(tcred);
 	if (ret)
-- 
2.32.0

