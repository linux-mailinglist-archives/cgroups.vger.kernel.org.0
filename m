Return-Path: <cgroups+bounces-5722-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA499DF589
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 13:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFFDB21241
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 12:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29571B4F2D;
	Sun,  1 Dec 2024 12:43:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31851B4F10;
	Sun,  1 Dec 2024 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733057012; cv=none; b=DmDjITEa+dDPrJq5Cg595GT3Mep0C/YJRmBSisCEgGe6EGXyaGHhAATYblFJ+bI8YV5086r2JwDftnXTrtnfqHhmkA4sJ9DMApvksLANal4KYRV7uOYMVL5qJc1tg1/vjteFuVzQM2zLZYZPM+N5wdgnslwuFrW44PWMqIzAbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733057012; c=relaxed/simple;
	bh=jFSka1yGhbHJNKx7+u+18P6j13WVA48HuQ6F6r0Jcow=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baiTnNxO+y1jhKe5Z2SS6lfF8e7Fs1v05gsDOJWNwaa7FmChUborHsE7Xrn7IIePPzLm3lJAW9Mu64aPFmrcYgjqkjZPJ0DH4ytuO0bo4gd9Z9oGCZggZp9k7YI17WaAtNLoficGvh9Y45DyjXSnmRNn+YlNdxqwcGaaDMrjpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so30788925e9.3;
        Sun, 01 Dec 2024 04:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733057009; x=1733661809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm5KHITgvJAlZwMn/vft2HYn9JiVpV45gh+d1dBBjCk=;
        b=H0HDA+T8KlMeO8YZNNBXCXbvBGgrCTEfJmsDsO38HJy4BWN+oOkcmsDk4XGPebirFj
         0e4qi6eY/ZpcBr8jakhSpYI7n8EWMrcOUs73OLIR3GxLS5cGmWyDIOqre1QTeRcEDrWU
         R56t9WjGPachiSr+/qfnuRZQFzGysRDI+eiVQAh2+Lu6tq46vllwAcnY3owYbQLMpusR
         wee/hWRtBGdOT0HLpYFcXSf+GCOhPGzAkSBJz28JI6gNVKy/wCz/LqYZsbG8KQudtGGQ
         H/srk5ZVCMLOmnUHPiWUh90q8soOpi1Sk3TSdFuh61hqmE21kzDPkY7bVgy4As/L6FX/
         Q2+g==
X-Forwarded-Encrypted: i=1; AJvYcCUdZ3cejs2mNn0HtUYZLAahE08Yag93FSAfmvouGoU+GD9KJYxDed/X4SZjgv+wDIszemeWX8vHYne9Pa4M@vger.kernel.org, AJvYcCXuPtXNF8LxPrfLJq4yZLLbQGdGbck0wRoHvrBIrBh3+I7ujb5f34G4rpKc8Rb8xXo9iBSWXqMO@vger.kernel.org
X-Gm-Message-State: AOJu0YzwE1hC7Z44tGpz7Xsaxu2I8yfh2e4UBb0f5xwg22Q+B05ME+Ir
	3HE/DjjHpSaqE7rtOX1pkW5U3PVBAh+jKGPiEmzrhMHZ8nkxoiyp
X-Gm-Gg: ASbGnctOjxqauhxwAqheTEN2rAqgkWaIhd/ZqYK/QBzIAo0+Oeg9Uq3YDuOwZpV03Zr
	9Lz7W+FSWiTwMxQWAc6yxcl8K4qABM/V761bt9lekq6Fwdb2zIIiphIZxikxIbnsphXkx28lsIu
	Q05csb7CKGlqLGQbiyqqPuYd4gV57r+Fd4WkjUMLp2MTYJhmhgRo3v8WHTZQcHkFDI3hBBT9GZG
	DM6Y8Wrsu9I+rA9zkRIiB/a5yrCzSzLBl7mAasie4TzQLoQspnsjbHvVOpMDU12pBU=
X-Google-Smtp-Source: AGHT+IG8nH9SSVD+lxWjB0L+a2E2bi9fBHSp8wh/OQyotTaqJTBfFi76+Ura6+CZGZS1obvkex1oZw==
X-Received: by 2002:a05:600c:458b:b0:431:5a0e:fa2e with SMTP id 5b1f17b1804b1-434a9de3d04mr142985055e9.21.1733057009007;
        Sun, 01 Dec 2024 04:43:29 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d91sm114434985e9.39.2024.12.01.04.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 04:43:28 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v4 3/4] cgroup/cpuset: Restart CPUs whose isolated_cpus bits have changed
Date: Sun,  1 Dec 2024 14:42:43 +0200
Message-ID: <20241201124244.997754-4-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241201124244.997754-1-costa.shul@redhat.com>
References: <20241201124244.997754-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal is to dynamically isolate CPUs to prevent interference
from housekeeping subsystems.

The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
boot command line options, are used at boot time to exclude selected
CPUs from running some kernel housekeeping subsystems to minimize
interference with latency sensitive userspace applications such as DPDK.
This options can only be changed with a reboot. This is a problem for
containerized workloads running on OpenShift/Kubernetes where a mix of
low latency and "normal" workloads can be created/destroyed dynamically
and the number of CPUs allocated to each workload is often not known at
boot time.

CPU hotplug can be used to isolate CPUs by restarting related CPUs only,
without complete reboot.

Experimental solution.

Automatically restart changed CPUs when the `isolated_cpus` is modified
through the cgroup/cpuset interface.

No additional manipulation of the CPU online status from userspace is
required, and it remains compatible with existing software.

cpu_device_down()/cpu_device_up() can't be called within subroutines of
cpuset_write_resmask() because it locks `cpu_hotplug_lock` with
cpus_read_lock() but _cpu_down()/_cpu_up() lock `cpu_hotplug_lock` with
cpus_write_lock().

Intuitively the change of `isolated_cpus` should be performed between
cpu_device_down() and cpu_device_up(). Since cpu_device_down(), at
least for managed interrupts, doesn't depends on `isolated_cpus` and
`housekeeping` it is more simple to call cpu_device_down() after change
of `isolated_cpus` and `housekeeping` and cpus_read_unlock().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/cgroup/cpuset.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 570941d782ef..d5d2b4036314 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3131,6 +3131,27 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	mutex_unlock(&cpuset_mutex);
 }
 
+/*
+ * Restart CPUs whose isolated_cpus bits have changed.
+ * Enforce subsystems to adopt the new isolated_cpus and housekeeping masks
+ * using CPU hotplug.
+ */
+static void propogate_isolated_cpus_change(struct cpumask *isolated_cpus_prev)
+{
+	unsigned int cpu;
+
+	if (!isolated_cpus_prev)
+		return;
+
+	for_each_online_cpu(cpu) {
+		if (cpumask_test_cpu(cpu, isolated_cpus_prev) !=
+		    cpumask_test_cpu(cpu, isolated_cpus)) {
+			remove_cpu(cpu);
+			add_cpu(cpu);
+		}
+	}
+}
+
 /*
  * Common handling for a write to a "cpus" or "mems" file.
  */
@@ -3138,6 +3159,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
 	struct cpuset *cs = css_cs(of_css(of));
+	cpumask_var_t isolated_cpus_prev;
 	struct cpuset *trialcs;
 	int retval = -ENODEV;
 
@@ -3167,6 +3189,12 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
+	if (!alloc_cpumask_var(&isolated_cpus_prev, GFP_KERNEL)) {
+		retval = -ENOMEM;
+		goto out_unlock;
+	}
+
+	cpumask_copy(isolated_cpus_prev, isolated_cpus);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -3200,6 +3228,13 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
 	flush_workqueue(cpuset_migrate_mm_wq);
+
+	/* If isolated_cpus modified, the change must be propagated
+	 * to all subsystems.
+	 */
+	propogate_isolated_cpus_change(isolated_cpus_prev);
+	free_cpumask_var(isolated_cpus_prev);
+
 	return retval ?: nbytes;
 }
 
-- 
2.47.0


