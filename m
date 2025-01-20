Return-Path: <cgroups+bounces-6240-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7833A16EDD
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2025 15:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B81162119
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2025 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982F71E412A;
	Mon, 20 Jan 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aaabB0Df"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ABD1E3784
	for <cgroups@vger.kernel.org>; Mon, 20 Jan 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385084; cv=none; b=tT+VuxkShBaGLT0uonzc6jEDlcW5VlZjy353H9BkOreGwCBbRZ1gefWRIt/ncnvxHLQxS957K7PHeJKsZa6aoSAtkOoTHiAP3w+C5nDpWbPzoy2mpldOcQ5/e4qVgArIRTVKHJ8ii0m+uBz4G9FSiigahW5qtgVNkQgKbN0eAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385084; c=relaxed/simple;
	bh=56WlhH6jPzqZByuiYdl4jsWwIAL/Ut6r6VEEsRXxnpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ta7x/dbv/VAXhAm93Y1WWYiC7Mx2XncQ8nK7ccRTZeGegko6IJ6GRrXSInn+nreUiHUGOKld2t9ycife320Xo60GOFqWufHTxd6O9k2jSODuJst0d/2MzMuvXtpgHo2xAm4y+05VqGAUs4JPdQQhS8k1DWnlzhYtsFHDRhndYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aaabB0Df; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso29087505e9.1
        for <cgroups@vger.kernel.org>; Mon, 20 Jan 2025 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737385080; x=1737989880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DigW40pwT4nOr0qZtSkWArRwF+H88GufczXyIQiDM4M=;
        b=aaabB0DfD/FM1quX1LDzMra+vtge5CEOdF/PBC9EPr6WaxOMzgopi+DhM2/GLRpfwX
         JG0K72l7kPIxvWr27fQOVF2OWgqpF6WS7CN6yEP+GNkEAYX+pCMkxZd9Ksp3O9a401BG
         NNpqaz/HGfOVliBLDTmFWqQzp+Fbi365V0wguwf3H8zS/tyBefsqB7FKhfUyhEEdDfyE
         0XdMXX4vpLTVyG5i6gLYVaPGNRuGgNXl/iinNpjwb1reovWrp9+Pa5S9koYVbfTl1zTg
         5CO/IAoK6w0omAy/gSvAEw4Fl3YFt4Rjt3ECuDc66II28cvHlyAptnhYuuFKyDQAGjUP
         tJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737385080; x=1737989880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DigW40pwT4nOr0qZtSkWArRwF+H88GufczXyIQiDM4M=;
        b=O8/w6kmtn/PBxCPzpBgpFgtC7F5d/DxKTANK1xj5KYN2xaD0PwwAZ0q7uYjDzrmQUj
         aqI5wkbD5GAMUUr3plBV6BFIgjcakcn7FWWsvOL8ZWNps4LwYPa2aom65POpa2pyQLqZ
         2jOMvgkoCL+ZyiC08Ob+v1LM5R3ulixiaiNpljqbdssY0aZKtxzFLlEJUZUajypAAnml
         65YjEkdh/0HPFIWXKLnSxOe+7pw6MYUwm0+rwJUrDHLwd0XmvNxthpP36lrloLJIBLcc
         BSwURnqPdGn6rpRKd7KmqJMb1j4MN2MQ7SFjE+RajRrrMi2QfVLPVBYjuLCArwL9ekh1
         tXuA==
X-Forwarded-Encrypted: i=1; AJvYcCVgeBRVzbM5bvXks+JemFWpVcFIT+HjFdbL1ys+7rIR7ChRq0w+/HSRAYMtaytyctMmK5BkgvCC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dmRb/GNUPopIB+awkHkWCO0W27v12JLTXKH+H2fUIo+DxGDB
	cWP0VDJJJ+H529x+r0qWSzJ6LbzGO2bWunageRpTf3icoc1vse9RgDZRXceTHs4WPffqohARYGM
	Z
X-Gm-Gg: ASbGncsniFNZxd2E+VRPDN1AQbTe3u0EuI5gdwNSy0aG3cBYywCKpXdBNvP2DD5etv0
	y4977vDVN7WUDqK5co0R4RrD+1ZaGSHzXoODNNBniUFCYt09xhabQVvY6kl0dkmGdfPosbAmrdW
	0SXLABTyNvl3JL5HDNCa+lT07Uf0YpI5jreRuJvBnsLEav6wRkUKFPWRxW+/kYMZG/ra81CPCr9
	5RV7f1v53IEwq0XlfmPB+7yAw5nw5vEC5vjQLAzCkVLy7voHxgBQOWyOYYtn5cclPcyA0HR
X-Google-Smtp-Source: AGHT+IHBaC/4UsqbYBLrADk+m53X/Kk6KfBMm3DCefyXtGlRjIO7eMUNfspDKGEeUfKGRNdqKRmDSQ==
X-Received: by 2002:a05:600c:218e:b0:434:e65e:457b with SMTP id 5b1f17b1804b1-437c6ae9bdcmr194004685e9.3.1737385080284;
        Mon, 20 Jan 2025 06:58:00 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904087cbsm146156245e9.3.2025.01.20.06.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:58:00 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH v3] cgroup/cpuset: Move procfs cpuset attribute under cgroup-v1.c
Date: Mon, 20 Jan 2025 15:57:49 +0100
Message-ID: <20250120145749.925170-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The cpuset file is a legacy attribute that is bound primarily to cpuset
v1 hierarchy (equivalent information is available in /proc/$pid/cgroup path
on the unified hierarchy in conjunction with respective
cgroup.controllers showing where cpuset controller is enabled).

Followup to commit b0ced9d378d49 ("cgroup/cpuset: move v1 interfaces to
cpuset-v1.c") and hide CONFIG_PROC_PID_CPUSET under CONFIG_CPUSETS_V1.
Drop an obsolete comment too.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 init/Kconfig              |  5 +++--
 kernel/cgroup/cpuset-v1.c | 41 +++++++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c    | 45 ---------------------------------------
 3 files changed, 44 insertions(+), 47 deletions(-)

v3 changes:
- move dependency on internal cgroup-internal.h to v1-only too
  Reported-by: kernel test robot <lkp@intel.com>
  Link: https://lore.kernel.org/oe-kbuild-all/202501180315.KcDn5BG5-lkp@intel.com/

v2 changes:
- explicitly say what's part of CPUSETS_V1
- commit message wrt effective paths

diff --git a/init/Kconfig b/init/Kconfig
index a20e6efd3f0fb..2f3121c49ed23 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1182,7 +1182,8 @@ config CPUSETS_V1
 	help
 	  Legacy cgroup v1 cpusets controller which has been deprecated by
 	  cgroup v2 implementation. The v1 is there for legacy applications
-	  which haven't migrated to the new cgroup v2 interface yet. If you
+	  which haven't migrated to the new cgroup v2 interface yet. Legacy
+	  interface includes cpuset filesystem and /proc/<pid>/cpuset. If you
 	  do not have any such application then you are completely fine leaving
 	  this option disabled.
 
@@ -1190,7 +1191,7 @@ config CPUSETS_V1
 
 config PROC_PID_CPUSET
 	bool "Include legacy /proc/<pid>/cpuset file"
-	depends on CPUSETS
+	depends on CPUSETS_V1
 	default y
 
 config CGROUP_DEVICE
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 25c1d7b77e2f2..81b5e2a50d587 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include "cgroup-internal.h"
 #include "cpuset-internal.h"
 
 /*
@@ -373,6 +374,46 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
 	return ret;
 }
 
+#ifdef CONFIG_PROC_PID_CPUSET
+/*
+ * proc_cpuset_show()
+ *  - Print tasks cpuset path into seq_file.
+ *  - Used for /proc/<pid>/cpuset.
+ */
+int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
+		     struct pid *pid, struct task_struct *tsk)
+{
+	char *buf;
+	struct cgroup_subsys_state *css;
+	int retval;
+
+	retval = -ENOMEM;
+	buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	rcu_read_lock();
+	spin_lock_irq(&css_set_lock);
+	css = task_css(tsk, cpuset_cgrp_id);
+	retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
+				       current->nsproxy->cgroup_ns);
+	spin_unlock_irq(&css_set_lock);
+	rcu_read_unlock();
+
+	if (retval == -E2BIG)
+		retval = -ENAMETOOLONG;
+	if (retval < 0)
+		goto out_free;
+	seq_puts(m, buf);
+	seq_putc(m, '\n');
+	retval = 0;
+out_free:
+	kfree(buf);
+out:
+	return retval;
+}
+#endif /* CONFIG_PROC_PID_CPUSET */
+
 static u64 cpuset_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
 {
 	struct cpuset *cs = css_cs(css);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0f910c828973a..5a637292faa20 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -21,7 +21,6 @@
  *  License.  See the file COPYING in the main directory of the Linux
  *  distribution for more details.
  */
-#include "cgroup-internal.h"
 #include "cpuset-internal.h"
 
 #include <linux/init.h>
@@ -4244,50 +4243,6 @@ void cpuset_print_current_mems_allowed(void)
 	rcu_read_unlock();
 }
 
-#ifdef CONFIG_PROC_PID_CPUSET
-/*
- * proc_cpuset_show()
- *  - Print tasks cpuset path into seq_file.
- *  - Used for /proc/<pid>/cpuset.
- *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
- *    doesn't really matter if tsk->cpuset changes after we read it,
- *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
- *    anyway.
- */
-int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
-		     struct pid *pid, struct task_struct *tsk)
-{
-	char *buf;
-	struct cgroup_subsys_state *css;
-	int retval;
-
-	retval = -ENOMEM;
-	buf = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!buf)
-		goto out;
-
-	rcu_read_lock();
-	spin_lock_irq(&css_set_lock);
-	css = task_css(tsk, cpuset_cgrp_id);
-	retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
-				       current->nsproxy->cgroup_ns);
-	spin_unlock_irq(&css_set_lock);
-	rcu_read_unlock();
-
-	if (retval == -E2BIG)
-		retval = -ENAMETOOLONG;
-	if (retval < 0)
-		goto out_free;
-	seq_puts(m, buf);
-	seq_putc(m, '\n');
-	retval = 0;
-out_free:
-	kfree(buf);
-out:
-	return retval;
-}
-#endif /* CONFIG_PROC_PID_CPUSET */
-
 /* Display task mems_allowed in /proc/<pid>/status file. */
 void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
 {
-- 
2.47.1


