Return-Path: <cgroups+bounces-6185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170CA1372A
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 10:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A34161A09
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8201DD88D;
	Thu, 16 Jan 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dtLNTTH2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B751DDC19
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021423; cv=none; b=Sv3xcU3Inj/QIpBISMI92OZSNXZa2jbgQOX5G3rPAwSYkwu8v3yq+jQDjodniMMs1ZXfItbMFNbgNVY2EcJ0I4rpJPDBHpPQ5A/rVEGmDgTby6x3TU1+8appmtEj2FLTarUJ8Dmm939iMSd7leRw0QIms9cRl56Lc06Z51oFv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021423; c=relaxed/simple;
	bh=EAjIHYsQHu5Qztu+FJQE8Aask+V9lOoZp97lcTQQ054=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pnGONoSXxuaaSlSoGgR4hkDYZ1yaQ8fIvzLxUz8QbesiavutduFeAx7Q0zTVdBZPkmdR6SQTzK9bWF61LqUcI7a2ArGMA+NC2pq/C3idaFt/x5ZTx6XlwGQb2uVIorJ5sK0JAGircToiYJ5UUDhwocp488cWml+yBr3So/XkvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dtLNTTH2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38a88ba968aso674552f8f.3
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 01:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737021418; x=1737626218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KjN+BTd6HGuSA9k3Pw827ZjXdUPZek7uz38VNrIqxDY=;
        b=dtLNTTH2eDhHecFqG59cMtKsAHKaclNPeFUZIQvjjQn8A4heTvtF+g3NwJnRYVhRnx
         Hdb7wR7T4GuNIUGoFGjHseztMFIRpSFGN5+nfh21CYUWT8LtY58rRcZ9S1IqI7E6Xxmd
         Gdi1ETePdgNhkmcmxyTzbIFLX0NY99n7RhJywha4icRVsbAyuVrPDuIhGQOd9soSFDy6
         YNqBVMbuOsEAMLmQpr/SfmtJxD9LseAa0PgMDW27SXnRUUxv4FjankeGXNJfmN/qJuXO
         G3YNlB87nZhI3uqhAi7IfGjwomZFtlkDpUNjtvLzJ9coXPwRtQfMYsONQ8cyPmWsIFgM
         cv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737021418; x=1737626218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjN+BTd6HGuSA9k3Pw827ZjXdUPZek7uz38VNrIqxDY=;
        b=UvbvTpspQh2jcy/PbwqskZbJerATIe9Elop6TDe6IZziPg5EL7lrkgFYi4wKhVan3r
         DUxUsIEy/huIBKsAcRZyxCrPIOBLFNXozd1vF6GeVGc8LdYv7+8sH0s/LAHuOWpBnRvg
         PsPZeO8GIDmmfqR70EcLebGhmibto0hNTAN22ZuGo8q4WiV0AFbtjb/Ws10cTXJyHW33
         bOvjCO/yknioENBay47gvN6JylfsiSK+7tjhyvBPQUGd5C+1p9nZaS1j57gDHd/ITjvD
         vIPZkvNyCUpRWF3y9kv7B4cBkrD8KdILxX/7iv0+APZMD2PC2xzuZIRqj5SxOC0ZeAn1
         kYhw==
X-Forwarded-Encrypted: i=1; AJvYcCXt9OxyNLXqWSU2Np5yN23xKL7QirCoLONlSSgt2pa3+WhFvs6ixIKNJJRssU9+Rd+r6snCgJXi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz80MXUqvLTQVlF9ajacoirUeA+3Ypt9XRLCVRNIHjeGb0f651s
	Pgo9rpvajx1lzw1XmU/oZpwat7zt+v3p2bZJBabQSPB34KmPRD1IY4V4P4+oAlo=
X-Gm-Gg: ASbGncua9F8QL5yHgdSNozcTh10ZT0zF0jp4Obxte7+dpzLrVJKUwy7JLoxX+iuH/Rm
	ZpMjbwFa0ss8zBInYsb5L6xYGG5LFlgxG7po0s4VnaaTm591VsUTonoNV8CDq6wDU0gy8ywEy2S
	OyK60rxh/dLvy31nsyJIWvw4E1lxXAj7jx+aYpn5rlwyFA1UOk/PxQ4mnqAXAYj4KElrXKfAVjG
	4nAVUeNoAtcqR1PbSJF+ybHUALeDlGAm38uppZ15lHUwzGkJIay9EK0JnE=
X-Google-Smtp-Source: AGHT+IEFdutyIapFlcsCKhcuaRLoXIhXE5DrGgWXzRdw4dxk16q8542OAAWupm+R9ohYioH5sjkIiQ==
X-Received: by 2002:a05:6000:1f85:b0:385:f909:eb2c with SMTP id ffacd0b85a97d-38a87338c26mr34200153f8f.38.1737021418598;
        Thu, 16 Jan 2025 01:56:58 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74e6511sm54069945e9.38.2025.01.16.01.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 01:56:58 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH] cgroup/cpuset: Move procfs cpuset attribute under cgroup-v1.c
Date: Thu, 16 Jan 2025 10:56:56 +0100
Message-ID: <20250116095656.643976-1-mkoutny@suse.com>
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
v1 (and it'd be equal to effective /proc/$pid/cgroup path on the unified
hierarchy).

Followup to commit b0ced9d378d49 ("cgroup/cpuset: move v1 interfaces to
cpuset-v1.c") and hide CONFIG_PROC_PID_CPUSET under CONFIG_CPUSETS_V1.
Drop an obsolete comment too.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 init/Kconfig              |  2 +-
 kernel/cgroup/cpuset-v1.c | 40 +++++++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c    | 44 ---------------------------------------
 3 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a20e6efd3f0fb..2a1d5ef3fa48e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1190,7 +1190,7 @@ config CPUSETS_V1
 
 config PROC_PID_CPUSET
 	bool "Include legacy /proc/<pid>/cpuset file"
-	depends on CPUSETS
+	depends on CPUSETS_V1
 	default y
 
 config CGROUP_DEVICE
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 25c1d7b77e2f2..fff1a38f2725f 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -373,6 +373,46 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
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
index 0f910c828973a..7d6e8db234290 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4244,50 +4244,6 @@ void cpuset_print_current_mems_allowed(void)
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


