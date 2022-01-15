Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C969348F3D1
	for <lists+cgroups@lfdr.de>; Sat, 15 Jan 2022 02:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiAOBHp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 20:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiAOBHp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 20:07:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A657C06173E
        for <cgroups@vger.kernel.org>; Fri, 14 Jan 2022 17:07:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w189-20020a2549c6000000b00611c8be224cso11808637yba.14
        for <cgroups@vger.kernel.org>; Fri, 14 Jan 2022 17:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CR8oumQ41fWbohZqu7VQHjOAD/Bx/ZcAVT1B4LsANwg=;
        b=lGXcxF63iPTNTbS5H4rTR2A4N0gg/FIHhngKYtgJLHSd7RYuPLb//LBZvaUW8W04t3
         TgKUvihd0nLul6DoxQ9aIBMIJ6YDRpPc0EDT3xRWVtVXZvnigi3RY2mS/ceCPIyZM8VE
         XkLZ0Kbj+pnM3SwWQ/tvolKEYQzwYBty7Rkz+9UftAFbpEGH6G4OTDdvHo17DbUQsuML
         cUL4oopIaW2nHdXmLetzejLubLnTh5hHD71RLk2ZdLviUXuxdm4xTiPRdrsTi8ZudvWu
         pVDkZU630F/BYVEWjnaorjpfZ7ntOMRnBtWIJqaspziUUFylYdDY4BvTX4namM2axY+Q
         uFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CR8oumQ41fWbohZqu7VQHjOAD/Bx/ZcAVT1B4LsANwg=;
        b=OStAhaS+eQWXuFyL3oCtgr/qjVZnxwfXgsHC6GG3/zTO8Mn3ByWMqvKgOV0s9+k6fD
         1SyCKxTMnY3D6vbjbxijM5OHShCZ6SttCdA6K+0iYM00mk3gB1hEQGdm8RZtWMRGUxKA
         Y48YgqgDaY9lpIcbrd9MamGm4qCfqvYpB29i1ws6VxfBQFds5wlLhcz02MlyD9xPyMJS
         hv/cXixRATTNCa+9jY+kU6+RFphHfWej9BDDJqJTBC92SNRqpqn4LLACv0geOUJXWBpg
         WfnIRr5tJekQa+MKHT3CTw4PVSCw78s9Cb1vR/8Jm2Ke5DlxBTwEch5sq5KtIqddGs49
         vsOw==
X-Gm-Message-State: AOAM5335RDeLAxSLNuixQMxbDMXOhfoWnj2QyQVamnRehknoLuUG4uJR
        2IYrPtSZEr11wjg7STibapn75YhmHes=
X-Google-Smtp-Source: ABdhPJwe6PRoNGGuD7vbd/1DhHrfcN5EnqrVEOomaJBSf0k5t4M4mWUACg5ubnkcLAOP3GFjq3bBRFVDrDI=
X-Received: from hridya.mtv.corp.google.com ([2620:15c:211:200:5860:362a:3112:9d85])
 (user=hridya job=sendgmr) by 2002:a25:b392:: with SMTP id m18mr15342081ybj.37.1642208863584;
 Fri, 14 Jan 2022 17:07:43 -0800 (PST)
Date:   Fri, 14 Jan 2022 17:06:00 -0800
In-Reply-To: <20220115010622.3185921-1-hridya@google.com>
Message-Id: <20220115010622.3185921-3-hridya@google.com>
Mime-Version: 1.0
References: <20220115010622.3185921-1-hridya@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [RFC 2/6] cgroup: gpu: Add a cgroup controller for allocator
 attribution of GPU memory
From:   Hridya Valsaraju <hridya@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Airlie <airlied@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Li Li <dualli@google.com>, Marco Ballesio <balejs@google.com>,
        Hang Lu <hangl@codeaurora.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Vipin Sharma <vipinsh@google.com>,
        Chris Down <chris@chrisdown.name>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org
Cc:     Kenny.Ho@amd.com, daniels@collabora.com, kaleshsingh@google.com,
        tjmercier@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The cgroup controller provides accounting for GPU and GPU-related
memory allocations. The memory being accounted can be device memory or
memory allocated from pools dedicated to serve GPU-related tasks.

This patch adds APIs to:
-allow a device to register for memory accounting using the GPU cgroup
controller.
-charge and uncharge allocated memory to a cgroup.

When the cgroup controller is enabled, it would expose information about
the memory allocated by each device(registered for GPU cgroup memory
accounting) for each cgroup.

The API/UAPI can be extended to set per-device/total allocation limits
in the future.

The cgroup controller has been named following the discussion in [1].

[1]: https://lore.kernel.org/amd-gfx/YCJp%2F%2FkMC7YjVMXv@phenom.ffwll.local/

Signed-off-by: Hridya Valsaraju <hridya@google.com>
---
 include/linux/cgroup_gpu.h    | 120 +++++++++++++
 include/linux/cgroup_subsys.h |   4 +
 init/Kconfig                  |   7 +
 kernel/cgroup/Makefile        |   1 +
 kernel/cgroup/gpu.c           | 305 ++++++++++++++++++++++++++++++++++
 5 files changed, 437 insertions(+)
 create mode 100644 include/linux/cgroup_gpu.h
 create mode 100644 kernel/cgroup/gpu.c

diff --git a/include/linux/cgroup_gpu.h b/include/linux/cgroup_gpu.h
new file mode 100644
index 000000000000..0ac303ce6179
--- /dev/null
+++ b/include/linux/cgroup_gpu.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: MIT
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright (C) 2022 Google LLC.
+ */
+#ifndef _CGROUP_GPU_H
+#define _CGROUP_GPU_H
+
+#include <linux/cgroup.h>
+#include <linux/page_counter.h>
+
+#ifdef CONFIG_CGROUP_GPU
+ /* The GPU cgroup controller data structure */
+struct gpucg {
+	struct cgroup_subsys_state css;
+	/* list of all resource pools that belong to this cgroup */
+	struct list_head rpools;
+};
+
+struct gpucg_device {
+	/*
+	 * list  of various resource pool in various cgroups that the device is
+	 * part of.
+	 */
+	struct list_head rpools;
+	/* list of all devices registered for GPU cgroup accounting */
+	struct list_head dev_node;
+	/*
+	 * pointer to string literal to be used as identifier for accounting and
+	 * limit setting
+	 */
+	const char *name;
+};
+
+/**
+ * css_to_gpucg - get the corresponding gpucg ref from a cgroup_subsys_state
+ * @css: the target cgroup_subsys_state
+ *
+ * Returns: gpu cgroup that contains the @css
+ */
+static inline struct gpucg *css_to_gpucg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct gpucg, css) : NULL;
+}
+
+/**
+ * gpucg_get - get the gpucg reference that a task belongs to
+ * @task: the target task
+ *
+ * This increases the reference count of the css that the @task belongs to.
+ *
+ * Returns: reference to the gpu cgroup the task belongs to.
+ */
+static inline struct gpucg *gpucg_get(struct task_struct *task)
+{
+	if (!cgroup_subsys_enabled(gpu_cgrp_subsys))
+		return NULL;
+	return css_to_gpucg(task_get_css(task, gpu_cgrp_id));
+}
+
+/**
+ * gpucg_put - put a gpucg reference
+ * @gpucg: the target gpucg
+ *
+ * Put a reference obtained via gpucg_get
+ */
+static inline void gpucg_put(struct gpucg *gpucg)
+{
+	if (gpucg)
+		css_put(&gpucg->css);
+}
+
+/**
+ * gpucg_parent - find the parent of a gpu cgroup
+ * @cg: the target gpucg
+ *
+ * This does not increase the reference count of the parent cgroup
+ *
+ * Returns: parent gpu cgroup of @cg
+ */
+static inline struct gpucg *gpucg_parent(struct gpucg *cg)
+{
+	return css_to_gpucg(cg->css.parent);
+}
+
+int gpucg_try_charge(struct gpucg *gpucg, struct gpucg_device *device, u64 usage);
+void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_device *device, u64 usage);
+void gpucg_register_device(struct gpucg_device *gpucg_dev, const char *name);
+#else /* CONFIG_CGROUP_GPU */
+
+struct gpucg;
+struct gpucg_device;
+
+static inline struct gpucg *css_to_gpucg(struct cgroup_subsys_state *css)
+{
+	return NULL;
+}
+
+static inline struct gpucg *gpucg_get(struct task_struct *task)
+{
+	return NULL;
+}
+
+static inline void gpucg_put(struct gpucg *gpucg) {}
+
+static inline struct gpucg *gpucg_parent(struct gpucg *cg)
+{
+	return NULL;
+}
+static inline int gpucg_try_charge(struct gpucg *gpucg, struct gpucg_device *device,
+				   u64 usage)
+{
+	return 0;
+}
+
+static inline void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_device *device,
+				  u64 usage) {}
+static inline void gpucg_register_device(struct gpucg_device *gpucg_dev,
+					 const char *name) {}
+#endif	/* CONFIG_CGROUP_GPU */
+#endif	/* _CGROUP_GPU_H */
diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
index 445235487230..46a2a7b93c41 100644
--- a/include/linux/cgroup_subsys.h
+++ b/include/linux/cgroup_subsys.h
@@ -65,6 +65,10 @@ SUBSYS(rdma)
 SUBSYS(misc)
 #endif
 
+#if IS_ENABLED(CONFIG_CGROUP_GPU)
+SUBSYS(gpu)
+#endif
+
 /*
  * The following subsystems are not supported on the default hierarchy.
  */
diff --git a/init/Kconfig b/init/Kconfig
index cd23faa163d1..408910b21387 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -990,6 +990,13 @@ config BLK_CGROUP
 
 	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
 
+config CGROUP_GPU
+       bool "gpu cgroup controller (EXPERIMENTAL)"
+       select PAGE_COUNTER
+       help
+	Provides accounting and limit setting for memory allocations by the GPU
+	and GPU-related subsystems.
+
 config CGROUP_WRITEBACK
 	bool
 	depends on MEMCG && BLK_CGROUP
diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index 12f8457ad1f9..be95a5a532fc 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_CGROUP_RDMA) += rdma.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_CGROUP_MISC) += misc.o
 obj-$(CONFIG_CGROUP_DEBUG) += debug.o
+obj-$(CONFIG_CGROUP_GPU) += gpu.o
diff --git a/kernel/cgroup/gpu.c b/kernel/cgroup/gpu.c
new file mode 100644
index 000000000000..b171fae06b0d
--- /dev/null
+++ b/kernel/cgroup/gpu.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: MIT
+// Copyright 2019 Advanced Micro Devices, Inc.
+// Copyright (C) 2022 Google LLC.
+
+#include <linux/cgroup.h>
+#include <linux/cgroup_gpu.h>
+#include <linux/page_counter.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+
+static struct gpucg *root_gpucg __read_mostly;
+
+/*
+ * Protects list of resource pools maintained on per cgroup basis
+ * and list of devices registered for memory accounting using the GPU cgroup
+ * controller.
+ */
+static DEFINE_MUTEX(gpucg_mutex);
+static LIST_HEAD(gpucg_devices);
+
+struct gpucg_resource_pool {
+	 /* The device whose resource usage is tracked by this resource pool */
+	struct gpucg_device *device;
+
+	/* list of all resource pools for the cgroup */
+	struct list_head cg_node;
+
+	/*
+	 * list maintained by the gpucg_device to keep track of its
+	 * resource pools
+	 */
+	struct list_head dev_node;
+
+	/* tracks memory usage of the resource pool */
+	struct page_counter total;
+};
+
+static void free_cg_rpool_locked(struct gpucg_resource_pool *rpool)
+{
+	lockdep_assert_held(&gpucg_mutex);
+
+	list_del(&rpool->cg_node);
+	list_del(&rpool->dev_node);
+	kfree(rpool);
+}
+
+static void gpucg_css_free(struct cgroup_subsys_state *css)
+{
+	struct gpucg_resource_pool *rpool, *tmp;
+	struct gpucg *gpucg = css_to_gpucg(css);
+
+	// delete all resource pools
+	mutex_lock(&gpucg_mutex);
+	list_for_each_entry_safe(rpool, tmp, &gpucg->rpools, cg_node)
+		free_cg_rpool_locked(rpool);
+	mutex_unlock(&gpucg_mutex);
+
+	kfree(gpucg);
+}
+
+static struct cgroup_subsys_state *
+gpucg_css_alloc(struct cgroup_subsys_state *parent_css)
+{
+	struct gpucg *gpucg, *parent;
+
+	gpucg = kzalloc(sizeof(struct gpucg), GFP_KERNEL);
+	if (!gpucg)
+		return ERR_PTR(-ENOMEM);
+
+	parent = css_to_gpucg(parent_css);
+	if (!parent)
+		root_gpucg = gpucg;
+
+	INIT_LIST_HEAD(&gpucg->rpools);
+
+	return &gpucg->css;
+}
+
+static struct gpucg_resource_pool *find_cg_rpool_locked(struct gpucg *cg,
+							struct gpucg_device *device)
+
+{
+	struct gpucg_resource_pool *pool;
+
+	lockdep_assert_held(&gpucg_mutex);
+
+	list_for_each_entry(pool, &cg->rpools, cg_node)
+		if (pool->device == device)
+			return pool;
+
+	return NULL;
+}
+
+static struct gpucg_resource_pool *init_cg_rpool(struct gpucg *cg,
+						 struct gpucg_device *device)
+{
+	struct gpucg_resource_pool *rpool = kzalloc(sizeof(*rpool),
+						    GFP_KERNEL);
+	if (!rpool)
+		return ERR_PTR(-ENOMEM);
+
+	rpool->device = device;
+
+	page_counter_init(&rpool->total, NULL);
+	INIT_LIST_HEAD(&rpool->cg_node);
+	INIT_LIST_HEAD(&rpool->dev_node);
+	list_add_tail(&rpool->cg_node, &cg->rpools);
+	list_add_tail(&rpool->dev_node, &device->rpools);
+
+	return rpool;
+}
+
+/**
+ * get_cg_rpool_locked - find the resource pool for the specified device and
+ * specified cgroup. If the resource pool does not exist for the cg, it is created
+ * in a hierarchical manner in the cgroup and its ancestor cgroups who do not
+ * already have a resource pool entry for the device.
+ *
+ * @cg: The cgroup to find the resource pool for.
+ * @device: The device associated with the returned resource pool.
+ *
+ * Return: return resource pool entry corresponding to the specified device in
+ * the specified cgroup (hierarchically creating them if not existing already).
+ *
+ */
+static struct gpucg_resource_pool *
+get_cg_rpool_locked(struct gpucg *cg, struct gpucg_device *device)
+{
+	struct gpucg *parent_cg, *p, *stop_cg;
+	struct gpucg_resource_pool *rpool, *tmp_rpool;
+	struct gpucg_resource_pool *parent_rpool = NULL, *leaf_rpool = NULL;
+
+	rpool = find_cg_rpool_locked(cg, device);
+	if (rpool)
+		return rpool;
+
+	stop_cg = cg;
+	do {
+		rpool = init_cg_rpool(stop_cg, device);
+		if (IS_ERR(rpool))
+			goto err;
+
+		if (!leaf_rpool)
+			leaf_rpool = rpool;
+
+		stop_cg = gpucg_parent(stop_cg);
+		if (!stop_cg)
+			break;
+
+		rpool = find_cg_rpool_locked(stop_cg, device);
+	} while (!rpool);
+
+	/*
+	 * Re-initialize page counters of all rpools created in this invocation to
+	 * enable hierarchical charging.
+	 * stop_cg is the first ancestor cg who already had a resource pool for
+	 * the device. It can also be NULL if no ancestors had a pre-existing
+	 * resource pool for the device before this invocation.
+	 */
+	rpool = leaf_rpool;
+	for (p = cg; p != stop_cg; p = parent_cg) {
+		parent_cg = gpucg_parent(p);
+		if (!parent_cg)
+			break;
+		parent_rpool = find_cg_rpool_locked(parent_cg, device);
+		page_counter_init(&rpool->total, &parent_rpool->total);
+
+		rpool = parent_rpool;
+	}
+
+	return leaf_rpool;
+err:
+	for (p = cg; p != stop_cg; p = gpucg_parent(p)) {
+		tmp_rpool = find_cg_rpool_locked(p, device);
+		free_cg_rpool_locked(tmp_rpool);
+	}
+	return rpool;
+}
+
+/**
+ * gpucg_try_charge - charge memory to the specified gpucg and gpucg_device.
+ * Caller must hold a reference to @gpucg obtained through gpucg_get(). The size
+ * of the memory is rounded up to be a multiple of the page size.
+ *
+ * @gpucg: The gpu cgroup to charge the memory to.
+ * @device: The device to charge the memory to.
+ * @usage: size of memory to charge in bytes.
+ *
+ * Return: returns 0 if the charging is successful and otherwise returns an
+ * error code.
+ */
+int gpucg_try_charge(struct gpucg *gpucg, struct gpucg_device *device, u64 usage)
+{
+	struct page_counter *counter;
+	u64 nr_pages;
+	struct gpucg_resource_pool *rp;
+	int ret = 0;
+
+	mutex_lock(&gpucg_mutex);
+	rp = get_cg_rpool_locked(gpucg, device);
+	/*
+	 * gpucg_mutex can be unlocked here, rp will stay valid until gpucg is
+	 * freed and the caller is holding a reference to the gpucg.
+	 */
+	mutex_unlock(&gpucg_mutex);
+
+	if (IS_ERR(rp))
+		return PTR_ERR(rp);
+
+	nr_pages = PAGE_ALIGN(usage) >> PAGE_SHIFT;
+	if (page_counter_try_charge(&rp->total, nr_pages,
+				    &counter))
+		css_get_many(&gpucg->css, nr_pages);
+	else
+		ret = -ENOMEM;
+
+	return ret;
+}
+
+/**
+ * gpucg_uncharge - uncharge memory from the specified gpucg and gpucg_device.
+ * The caller must hold a reference to @gpucg obtained through gpucg_get().
+ *
+ * @gpucg: The gpu cgroup to uncharge the memory from.
+ * @device: The device to uncharge the memory from.
+ * @usage: size of memory to uncharge in bytes.
+ */
+void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_device *device,
+		   u64 usage)
+{
+	u64 nr_pages;
+	struct gpucg_resource_pool *rp;
+
+	mutex_lock(&gpucg_mutex);
+	rp = find_cg_rpool_locked(gpucg, device);
+	/*
+	 * gpucg_mutex can be unlocked here, rp will stay valid until gpucg is
+	 * freed and there are active refs on gpucg.
+	 */
+	mutex_unlock(&gpucg_mutex);
+
+	if (unlikely(!rp)) {
+		pr_err("Resource pool not found, incorrect charge/uncharge ordering?\n");
+		return;
+	}
+
+	nr_pages = PAGE_ALIGN(usage) >> PAGE_SHIFT;
+	page_counter_uncharge(&rp->total, nr_pages);
+	css_put_many(&gpucg->css, nr_pages);
+}
+
+/**
+ * gpucg_register_device - Registers a device for memory accounting using the
+ * GPU cgroup controller.
+ *
+ * @device: The device to register for memory accounting.
+ * @name: Pointer to a string literal to denote the name of the device.
+ *
+ * Both @device andd @name must remain valid.
+ */
+void gpucg_register_device(struct gpucg_device *device, const char *name)
+{
+	if (!device)
+		return;
+
+	INIT_LIST_HEAD(&device->dev_node);
+	INIT_LIST_HEAD(&device->rpools);
+
+	mutex_lock(&gpucg_mutex);
+	list_add_tail(&device->dev_node, &gpucg_devices);
+	mutex_unlock(&gpucg_mutex);
+
+	device->name = name;
+}
+
+static int gpucg_resource_show(struct seq_file *sf, void *v)
+{
+	struct gpucg_resource_pool *rpool;
+	struct gpucg *cg = css_to_gpucg(seq_css(sf));
+
+	mutex_lock(&gpucg_mutex);
+	list_for_each_entry(rpool, &cg->rpools, cg_node) {
+		seq_printf(sf, "%s %lu\n", rpool->device->name,
+			   page_counter_read(&rpool->total) * PAGE_SIZE);
+	}
+	mutex_unlock(&gpucg_mutex);
+
+	return 0;
+}
+
+struct cftype files[] = {
+	{
+		.name = "memory.current",
+		.seq_show = gpucg_resource_show,
+	},
+	{ }	/* terminate */
+};
+
+struct cgroup_subsys gpu_cgrp_subsys = {
+	.css_alloc	= gpucg_css_alloc,
+	.css_free	= gpucg_css_free,
+	.early_init	= false,
+	.legacy_cftypes	= files,
+	.dfl_cftypes	= files,
+};
-- 
2.34.1.703.g22d0c6ccf7-goog

