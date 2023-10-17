Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EBD7CC385
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjJQMqN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjJQMqL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 08:46:11 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AB2FB;
        Tue, 17 Oct 2023 05:46:09 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57bca5b9b0aso2950763eaf.3;
        Tue, 17 Oct 2023 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546769; x=1698151569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH+izS6IgAWJi6hgilQUZOMAoXXgYkaiGHHHch4343w=;
        b=Shb7bDIKpkX13ahbT3Wu08UXssFoOBiGzVsCW1UdYv+L7dDcpVylFhiVkzzDJoXLae
         zHRFsykCKknPNzrzIP+37LVeim4RhDSt8EyuQO7UOvCbP0uYeLbCzRGihpoLcRZzWsKI
         OpKdIQTzklapeFVsEwjsk1LFr750FLCjcIY4EyIpIQX9Nz3d+HPqfd+sb5M9ZCQCQCbp
         7NEMwAqeOTS13rgnOGfWmdZdEmWdmE4IzXv8ndZ7xzK+QraRAed2koSumFVwES0CcuuN
         226OP/qxjGxVHdaQCZ9PsVtwpXCAjE7hqxUW5A8XRruMcaGi5lQAfYwzRAzu5guoiDYi
         pMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546769; x=1698151569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH+izS6IgAWJi6hgilQUZOMAoXXgYkaiGHHHch4343w=;
        b=mAHqAltRGLMUKnapH/29GYvUOjPvUKeK83GgVB4EZejQxz5apo9cJ6J5oH3ZBtIrX9
         OI8vjPUVgRdntxKJOzn0LUIkTe2OWomuxhV09gt7GEnAmhTu1wy/mK0U4EXCYB4TaQjM
         xn/my5W25gkVl1pqpKzM7roWAG1gyz/62n00BYTTZl9wwpR6gz9tHwsDGXZ20HbMO7iP
         zh0e8mMQrArrFs+2YhIsSWd184XNISQ6PwjBqQ6eG+ZQqz2nFYGWxzfnOpV+wPHZb69j
         MwRODkJN2/2vdckgtQNsyIcFrSzwE2nS9T+TUNaeU+0Xd5/9y0rr3SWBeheyqNZ4EaRz
         3WHg==
X-Gm-Message-State: AOJu0YwYzrY4UqHYRe5s6TIlVKjrHb4tgLZmXfHhaSTCISxbTtQU5ewk
        kNLMQ1JbOmcMbt30KfIRcnM=
X-Google-Smtp-Source: AGHT+IHom0u3EVjkJF7bWSDQ7AT/KDYUsJY1p0g4trXbL5i3GhbvxiGdUHqpMjLfBe5Dqp2kbJ4BYw==
X-Received: by 2002:a05:6359:d0f:b0:133:595:1c with SMTP id gp15-20020a0563590d0f00b001330595001cmr1849779rwb.31.1697546768245;
        Tue, 17 Oct 2023 05:46:08 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:3b2:5400:4ff:fe9b:d21b])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006bdf4dfbe0dsm1375595pfb.12.2023.10.17.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:46:07 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 2/9] cgroup: Eliminate the need for cgroup_mutex in proc_cgroup_show()
Date:   Tue, 17 Oct 2023 12:45:39 +0000
Message-Id: <20231017124546.24608-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017124546.24608-1-laoar.shao@gmail.com>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The cgroup root_list is already RCU-safe. Therefore, we can replace the
cgroup_mutex with the RCU read lock in some particular paths. This change
will be particularly beneficial for frequent operations, such as
`cat /proc/self/cgroup`, in a cgroup1-based container environment.

I did stress tests with this change, as outlined below
(with CONFIG_PROVE_RCU_LIST enabled):

- Continuously mounting and unmounting named cgroups in some tasks,
  for example:

  cgrp_name=$1
  while true
  do
      mount -t cgroup -o none,name=$cgrp_name none /$cgrp_name
      umount /$cgrp_name
  done

- Continuously triggering proc_cgroup_show() in some tasks concurrently,
  for example:
  while true; do cat /proc/self/cgroup > /dev/null; done

They can ran successfully after implementing this change, with no RCU
warnings in dmesg. It's worth noting that this change can also catch
deleted cgroups, as demonstrated by running the following task at the
same time:

  while true; do grep deleted /proc/self/cgroup; done

Results in output like:

  7995:name=cgrp2: (deleted)
  8594:name=cgrp1: (deleted)

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/cgroup/cgroup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index bae8f9f27792..30bdb3bf1dcd 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6256,7 +6256,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 	if (!buf)
 		goto out;
 
-	cgroup_lock();
+	rcu_read_lock();
 	spin_lock_irq(&css_set_lock);
 
 	for_each_root(root) {
@@ -6279,6 +6279,10 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		seq_putc(m, ':');
 
 		cgrp = task_cgroup_from_root(tsk, root);
+		if (!cgrp) {
+			seq_puts(m, " (deleted)\n");
+			continue;
+		}
 
 		/*
 		 * On traditional hierarchies, all zombie tasks show up as
@@ -6311,7 +6315,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 	retval = 0;
 out_unlock:
 	spin_unlock_irq(&css_set_lock);
-	cgroup_unlock();
+	rcu_read_unlock();
 	kfree(buf);
 out:
 	return retval;
-- 
2.30.1 (Apple Git-130)

