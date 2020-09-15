Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B758726A923
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgIOPzJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgIOPx7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 11:53:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D42C06178A
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 08:53:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so2165136pfa.10
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU2nEMhjCVWVrMXPlsQXavcJV9QfPkKaCh123WirJUY=;
        b=fZ2zBCziQ3BDs46gAsEfUI7yxJtBST2rD1IAijko7XSzcOwptW4Ut8cyp/pKulyFN5
         Ya4+QRLBdUkedXev1V3EdJCBcWw7K2d1vm39dZMITMuBww53C+M6rM4NEoxRfDq+96Yq
         2hILdPF14cQEnz3v9ybLMFkS5pimkLRnuRTMrfCq5Hqy0KBcOcUjxpRFWbPMDZMUJqMZ
         JPJbtE/cVWhEHuZd7qbloKU9e+hR+nATFMV8pU+Rx6w1VBa40PqCN6W+dSAz4PQVeQeJ
         kt8jlvKwp4uuM6KWcCHU8nbzruP+ox0zWXUzIfgBxlatJaEpX6d7VdrCYvQraoKKotZH
         aM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU2nEMhjCVWVrMXPlsQXavcJV9QfPkKaCh123WirJUY=;
        b=Xad4zI1kbQb45R86YL3tc9Z7uiPh3v8v392Afy2amMZcFv3yRy3HMEeJnIe601DHqc
         eiKrXJFIZAkWtwbOE+j6sIUSfpl6rA/y70oup83sxmRT+IzZdIOlZ8jYcEl9QGqjwBTY
         FDIxtP94Rhd59/ihM8gQsfrPnk4Y51TB0xHh4+ro0aYxvywn9h96XBeRlmOZa4xCoSHS
         wiBI72+youJSXMP7Wo6ph95x70BbuEo3b0l2WaZo26YYV1zKXt68f0seW20pYaiWbGDo
         WioSJRTtyJoNOXCE8MpVSlvYcrF9tMo+FHQd63f5W14e3PAWtsiY5fmLHxgiGbfqCg9r
         9d5g==
X-Gm-Message-State: AOAM532H1ioh1T2vkw2KSHcvYREVe6l/CtOD5AkAX1hfJ0j+/ADzPCYe
        OJZipGrbxKH44Gqv5i+bFGg/CA==
X-Google-Smtp-Source: ABdhPJwi4fkNDvtVlto8KWYR1aJj5ID6DauHtUvOTVllokb0/rs8ghVhOYd/5I+QLqtz7r8sPEBupg==
X-Received: by 2002:a62:1bc7:0:b029:13e:d13d:a0f6 with SMTP id b190-20020a621bc70000b029013ed13da0f6mr18184752pfb.18.1600185237926;
        Tue, 15 Sep 2020 08:53:57 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id b20sm14808636pfb.198.2020.09.15.08.53.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 08:53:57 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhouchengming@bytedance.com, luodaowen.backend@bytedance.com,
        songmuchun@bytedance.com
Subject: [PATCH] cgroup: Add cgroupstats numbers to cgroup.stat file
Date:   Tue, 15 Sep 2020 23:53:49 +0800
Message-Id: <20200915155349.15181-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In the cgroup v1, we can use netlink interface to get cgroupstats for
a cgroup. But it has been excluded from cgroup v2 interface intentionally
due to the duplication and inconsistencies with other statistics.
To make container monitor tool like "cadvisor" continue to work, we add
these cgroupstats numbers to the cgroup.stat file, and change the
admin-guide doc accordingly.

Reported-by: Daowen Luo <luodaowen.backend@bytedance.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 15 ++++++++++++++
 kernel/cgroup/cgroup.c                  | 36 +++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6be43781ec7f..9f781edca95a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -925,6 +925,21 @@ All cgroup core files are prefixed with "cgroup."
 		A dying cgroup can consume system resources not exceeding
 		limits, which were active at the moment of cgroup deletion.
 
+          nr_running
+                Number of tasks running.
+
+          nr_sleeping
+                Number of tasks sleeping.
+
+          nr_uninterruptible
+                Number of tasks in uninterruptible state.
+
+          nr_stopped
+                Number of tasks in stopped state.
+
+          nr_io_wait
+                Number of tasks waiting on IO.
+
   cgroup.freeze
 	A read-write single value file which exists on non-root cgroups.
 	Allowed values are "0" and "1". The default is "0".
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 0e23ae3b1e56..c6ccacaf812d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -42,6 +42,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
+#include <linux/delayacct.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/percpu-rwsem.h>
@@ -3499,11 +3500,46 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
 static int cgroup_stat_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgroup = seq_css(seq)->cgroup;
+	struct css_task_iter it;
+	struct task_struct *tsk;
+	u64 nr_running = 0;
+	u64 nr_sleeping = 0;
+	u64 nr_uninterruptible = 0;
+	u64 nr_stopped = 0;
+	u64 nr_io_wait = 0;
+
+	css_task_iter_start(&cgroup->self, 0, &it);
+	while ((tsk = css_task_iter_next(&it))) {
+		switch (tsk->state) {
+		case TASK_RUNNING:
+			nr_running++;
+			break;
+		case TASK_INTERRUPTIBLE:
+			nr_sleeping++;
+			break;
+		case TASK_UNINTERRUPTIBLE:
+			nr_uninterruptible++;
+			break;
+		case TASK_STOPPED:
+			nr_stopped++;
+			break;
+		default:
+			if (delayacct_is_task_waiting_on_io(tsk))
+				nr_io_wait++;
+			break;
+		}
+	}
+	css_task_iter_end(&it);
 
 	seq_printf(seq, "nr_descendants %d\n",
 		   cgroup->nr_descendants);
 	seq_printf(seq, "nr_dying_descendants %d\n",
 		   cgroup->nr_dying_descendants);
+	seq_printf(seq, "nr_running %llu\n", nr_running);
+	seq_printf(seq, "nr_sleeping %llu\n", nr_sleeping);
+	seq_printf(seq, "nr_uninterruptible %llu\n", nr_uninterruptible);
+	seq_printf(seq, "nr_stopped %llu\n", nr_stopped);
+	seq_printf(seq, "nr_io_wait %llu\n", nr_io_wait);
 
 	return 0;
 }
-- 
2.11.0

