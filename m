Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ED748F3ED
	for <lists+cgroups@lfdr.de>; Sat, 15 Jan 2022 02:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiAOBJJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 20:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiAOBJJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 20:09:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2123C06173E
        for <cgroups@vger.kernel.org>; Fri, 14 Jan 2022 17:09:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h2-20020a5b0a82000000b0061192499188so21630092ybq.9
        for <cgroups@vger.kernel.org>; Fri, 14 Jan 2022 17:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kkjQvBHUpUsPJOcuRnb4FbpqpDLYZFNC/PGNH3Zg5WU=;
        b=B7HrMalKbOrQ0jLo+t2k5LKQyXsYTrKPSnoCQbJTFt3xXAdNgf+Y3bG0OwuuV3conm
         9YDTffSi81yddsv2BoH3Yepu0Qf4t9Yufib51okExGf5c00BzhktLBE/1fgctRjU17A0
         FE5Q2yG/2zZsbcQO5KIgRMuIdtuJb3ntKNdMvUrJDIlln1wNgH3uN1Xs3Tq4HUuo2nQw
         vX/4a2fLq5zN8JuJ/ROXboM4iqrNUfkxyQzzeG4K6rLmd0dL8lZlsn2U8cU340A6r7rt
         CrzHH2yHQihIsNpJ9nYxK0RZUUVox7TiNHvKS/20HXPEnTeOhUMt/SoHjy/YrqoHfDGB
         975A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kkjQvBHUpUsPJOcuRnb4FbpqpDLYZFNC/PGNH3Zg5WU=;
        b=KgUxT/+nL2ZkWnMbQVvffXUoRJRkSXmazkqwmwz3UkthdqzAtP5XNy3jvizoMQrXtF
         4x/9GUWbmyWbkA2XZYTrS18cMntOB2E48LiiAbAQgJ67z5PGm3+D2+3LCAQ+PfSTTFJA
         uQyM0pBC6DtZYJ88vTnyaJ98RrraHeaXgRBNUdqiF7fGFCrHa5gktYg/IEwq+LKZf5j3
         EYhbHLm40jgcyY8ST+vH0QRcvTEkdXEJyvpyN7q87CC6HcAHhKKlZEBT/XtYya3ZWYTq
         OU2i6riQMJQA0t9xGlvtGJJ7cxq7o8JKdDAYEnT8qU4CbjA+DkVLkacz6P+AXDQovHGg
         Kq2A==
X-Gm-Message-State: AOAM531T38V9prEZWUlGgUNo2KBOcrHvc+5x9VLHKPBE2p2dwd8XfGhJ
        lS3zcmHTbBaPmtfNfIatB6GV7ThQFUA=
X-Google-Smtp-Source: ABdhPJz9CR2IoAwevLCGCWJ5VPMm/mBeIOkcx7f8CHh3K/XQY53M+B3vhZstfGoP5vWHDyFMJE3GX6t7YyU=
X-Received: from hridya.mtv.corp.google.com ([2620:15c:211:200:5860:362a:3112:9d85])
 (user=hridya job=sendgmr) by 2002:a25:7b44:: with SMTP id w65mr15284933ybc.59.1642208948043;
 Fri, 14 Jan 2022 17:09:08 -0800 (PST)
Date:   Fri, 14 Jan 2022 17:06:04 -0800
In-Reply-To: <20220115010622.3185921-1-hridya@google.com>
Message-Id: <20220115010622.3185921-7-hridya@google.com>
Mime-Version: 1.0
References: <20220115010622.3185921-1-hridya@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [RFC 6/6] android: binder: Add a buffer flag to relinquish ownership
 of fds
From:   Hridya Valsaraju <hridya@google.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
        Kenneth Graunke <kenneth@whitecape.org>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Li Li <dualli@google.com>, Marco Ballesio <balejs@google.com>,
        Hang Lu <hangl@codeaurora.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
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

This patch introduces a buffer flag BINDER_BUFFER_FLAG_SENDER_NO_NEED
that a process sending an fd array to another process over binder IPC
can set to relinquish ownership of the fds being sent for memory
accounting purposes. If the flag is found to be set during the fd array
translation and the fd is for a DMA-BUF, the buffer is uncharged from
the sender's cgroup and charged to the receiving process's cgroup
instead.

It is upto the sending process to ensure that it closes the fds
regardless of whether the transfer failed or succeeded.

Most graphics shared memory allocations in Android are done by the
graphics allocator HAL process. On requests from clients, the HAL process
allocates memory and sends the fds to the clients over binder IPC.
The graphics allocator HAL will not retain any references to the
buffers. When the HAL sets the BINDER_BUFFER_FLAG_SENDER_NO_NEED for fd
arrays holding DMA-BUF fds, the gpu cgroup controller will be able to
correctly charge the buffers to the client processes instead of the
graphics allocator HAL.

Signed-off-by: Hridya Valsaraju <hridya@google.com>
---
 drivers/android/binder.c            | 32 +++++++++++++++++++++++++++++
 include/uapi/linux/android/binder.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 5497797ab258..83082fd1ab6a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -42,6 +42,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/dma-buf.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
@@ -2482,8 +2483,11 @@ static int binder_translate_fd_array(struct list_head *pf_head,
 {
 	binder_size_t fdi, fd_buf_size;
 	binder_size_t fda_offset;
+	bool transfer_gpu_charge = false;
 	const void __user *sender_ufda_base;
 	struct binder_proc *proc = thread->proc;
+	struct binder_proc *target_proc = t->to_proc;
+
 	int ret;
 
 	fd_buf_size = sizeof(u32) * fda->num_fds;
@@ -2520,8 +2524,15 @@ static int binder_translate_fd_array(struct list_head *pf_head,
 	if (ret)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_CGROUP_GPU) &&
+	    parent->flags & BINDER_BUFFER_FLAG_SENDER_NO_NEED)
+		transfer_gpu_charge = true;
+
 	for (fdi = 0; fdi < fda->num_fds; fdi++) {
 		u32 fd;
+		struct dma_buf *dmabuf;
+		struct gpucg *gpucg;
+
 		binder_size_t offset = fda_offset + fdi * sizeof(fd);
 		binder_size_t sender_uoffset = fdi * sizeof(fd);
 
@@ -2531,6 +2542,27 @@ static int binder_translate_fd_array(struct list_head *pf_head,
 						  in_reply_to);
 		if (ret)
 			return ret > 0 ? -EINVAL : ret;
+
+		if (!transfer_gpu_charge)
+			continue;
+
+		dmabuf = dma_buf_get(fd);
+		if (IS_ERR(dmabuf))
+			continue;
+
+		if (dmabuf->ops->charge_to_cgroup) {
+			gpucg = gpucg_get(target_proc->tsk);
+			ret = dmabuf->ops->charge_to_cgroup(dmabuf, gpucg);
+			if (ret) {
+				pr_warn("%d:%d Unable to transfer DMA-BUF fd charge to %d",
+					proc->pid, thread->pid, target_proc->pid);
+				gpucg_put(gpucg);
+			}
+		} else {
+			pr_warn("%d:%d DMA-BUF exporter %s is not configured correctly for GPU cgroup memory accounting",
+				proc->pid, thread->pid, dmabuf->exp_name);
+		}
+		dma_buf_put(dmabuf);
 	}
 	return 0;
 }
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index ad619623571e..c85f0014c341 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -137,6 +137,7 @@ struct binder_buffer_object {
 
 enum {
 	BINDER_BUFFER_FLAG_HAS_PARENT = 0x01,
+	BINDER_BUFFER_FLAG_SENDER_NO_NEED = 0x02,
 };
 
 /* struct binder_fd_array_object - object describing an array of fds in a buffer
-- 
2.34.1.703.g22d0c6ccf7-goog

