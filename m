Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B818D4D3705
	for <lists+cgroups@lfdr.de>; Wed,  9 Mar 2022 18:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiCIRFX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Mar 2022 12:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbiCIRER (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Mar 2022 12:04:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C643619E73C
        for <cgroups@vger.kernel.org>; Wed,  9 Mar 2022 08:53:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l19-20020a252513000000b00629235aacb2so2127576ybl.13
        for <cgroups@vger.kernel.org>; Wed, 09 Mar 2022 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=ArtryYFgH5mlYpraW6Z9pzBKDmlE5B7N8QDWxuF8nCw=;
        b=ET2G8YAxigglCgwH9ORXjYEpMOwkLAxVMGluElrrT20Iij1J38dmr6UP8EdlHvk4DN
         azfkhu/4N5mTJEJm6TVVmQy58D9W8S5IKUZrU96emS4lJxesAiyxiaL+UhI4peXvb1ET
         2NfRSubT3bKB7llEizgDSk5WlvkFPBL2wIZ+UrsonprCR0wGscERyJLQ5lFI6A7C+Mqr
         bBt/5MUBkAllxZeIaBAydEb4kU5tR1u3dOU4OHuIMqo5beiURrjjfEoxT78k7cZx6CKK
         JslptEply/Lv5cfDpBB3GPPAcjhXmY9D9nxBJ4PiqVjPoV/QbfVEvtvJmrpZObB+eaR2
         BMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ArtryYFgH5mlYpraW6Z9pzBKDmlE5B7N8QDWxuF8nCw=;
        b=bj+o/EOR/wcR8w3uV2TajD63VBJjDeuREh3/oZZiKG6s38NBmNebNLcIyhUaWwD7Yt
         GeOIVnP1eZdR3jUimcVHIh7wnCSvKVKUvT4XWlnjlE7TazyCtx8S4ruAYyS9Pieidwd4
         4GOGyj9vXg9h/kcYaLi5QkBajKirphZwYK+QEtN7iTRf4YIaf95R842AbAvX/P0qBP1+
         D0jyUSb7YYFg9fRcrCINJ9eguCjp1mIVS3yh2n1vpznrs/EfTBm4QZ/P7ge9OQZjDV7n
         C2nMWMpgKd06XGa1p6pdB880vMOPLcJzV/t8gFu+CIe2scnSdsUWbdrwPUstxahZj/5g
         aM4A==
X-Gm-Message-State: AOAM533CUgWTZKGoQCZzbbeSRKZ9haqJtNOvRoT3VA4xiC+cbsfxIdEY
        acJ8fW44hOZvjnzjmZavcPPC78j2WX8LFt0=
X-Google-Smtp-Source: ABdhPJwhCCM8fnCv/YYjH2ItlE07Kq6zIIhQQNOdvRKBR0On1xzyi6be0Wrkn7kWsIBobS2Z6B4GB8mh7xehQH8=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:a25:3403:0:b0:628:a2e4:ae8a with SMTP id
 b3-20020a253403000000b00628a2e4ae8amr504446yba.219.1646844771702; Wed, 09 Mar
 2022 08:52:51 -0800 (PST)
Date:   Wed,  9 Mar 2022 16:52:16 +0000
In-Reply-To: <20220309165222.2843651-1-tjmercier@google.com>
Message-Id: <20220309165222.2843651-7-tjmercier@google.com>
Mime-Version: 1.0
References: <20220309165222.2843651-1-tjmercier@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [RFC v3 6/8] binder: Add a buffer flag to relinquish ownership of fds
From:   "T.J. Mercier" <tjmercier@google.com>
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
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kaleshsingh@google.com, Kenny.Ho@amd.com,
        "T.J. Mercier" <tjmercier@google.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Hridya Valsaraju <hridya@google.com>

This patch introduces a buffer flag BINDER_BUFFER_FLAG_SENDER_NO_NEED
that a process sending an fd array to another process over binder IPC
can set to relinquish ownership of the fds being sent for memory
accounting purposes. If the flag is found to be set during the fd array
translation and the fd is for a DMA-BUF, the buffer is uncharged from
the sender's cgroup and charged to the receiving process's cgroup
instead.

It is up to the sending process to ensure that it closes the fds
regardless of whether the transfer failed or succeeded.

Most graphics shared memory allocations in Android are done by the
graphics allocator HAL process. On requests from clients, the HAL process
allocates memory and sends the fds to the clients over binder IPC.
The graphics allocator HAL will not retain any references to the
buffers. When the HAL sets the BINDER_BUFFER_FLAG_SENDER_NO_NEED for fd
arrays holding DMA-BUF fds, the gpu cgroup controller will be able to
correctly charge the buffers to the client processes instead of the
graphics allocator HAL.

Since this is a new feature exposed to userspace, the kernel and userspace
must be compatible for the accounting to work for transfers. In all cases
the allocation and transport of DMA buffers via binder will succeed, but
only when both the kernel supports, and userspace depends on this feature
will the transfer accounting work. The possible scenarios are detailed
below:

1. new kernel + old userspace
The kernel supports the feature but userspace does not use it. The old
userspace won't mount the new cgroup controller, accounting is not
performed, charge is not transferred.

2. old kernel + new userspace
The new cgroup controller is not supported by the kernel, accounting is
not performed, charge is not transferred.

3. old kernel + old userspace
Same as #2

4. new kernel + new userspace
Cgroup is mounted, feature is supported and used.

Signed-off-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
v3 changes
Remove android from title per Todd Kjos.

Use more common dual author commit message format per John Stultz.

Include details on behavior for all combinations of kernel/userspace
versions in changelog (thanks Suren Baghdasaryan) per Greg Kroah-Hartman.

v2 changes
Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
heap to a single dma-buf function for all heaps per Daniel Vetter and
Christian K=C3=B6nig.
---
 drivers/android/binder.c            | 26 ++++++++++++++++++++++++++
 include/uapi/linux/android/binder.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c5638880..f50d88ded188 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -42,6 +42,7 @@
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
+#include <linux/dma-buf.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
@@ -2482,8 +2483,10 @@ static int binder_translate_fd_array(struct list_hea=
d *pf_head,
 {
 	binder_size_t fdi, fd_buf_size;
 	binder_size_t fda_offset;
+	bool transfer_gpu_charge =3D false;
 	const void __user *sender_ufda_base;
 	struct binder_proc *proc =3D thread->proc;
+	struct binder_proc *target_proc =3D t->to_proc;
 	int ret;
=20
 	fd_buf_size =3D sizeof(u32) * fda->num_fds;
@@ -2521,8 +2524,15 @@ static int binder_translate_fd_array(struct list_hea=
d *pf_head,
 	if (ret)
 		return ret;
=20
+	if (IS_ENABLED(CONFIG_CGROUP_GPU) &&
+		parent->flags & BINDER_BUFFER_FLAG_SENDER_NO_NEED)
+		transfer_gpu_charge =3D true;
+
 	for (fdi =3D 0; fdi < fda->num_fds; fdi++) {
 		u32 fd;
+		struct dma_buf *dmabuf;
+		struct gpucg *gpucg;
+
 		binder_size_t offset =3D fda_offset + fdi * sizeof(fd);
 		binder_size_t sender_uoffset =3D fdi * sizeof(fd);
=20
@@ -2532,6 +2542,22 @@ static int binder_translate_fd_array(struct list_hea=
d *pf_head,
 						  in_reply_to);
 		if (ret)
 			return ret > 0 ? -EINVAL : ret;
+
+		if (!transfer_gpu_charge)
+			continue;
+
+		dmabuf =3D dma_buf_get(fd);
+		if (IS_ERR(dmabuf))
+			continue;
+
+		gpucg =3D gpucg_get(target_proc->tsk);
+		ret =3D dma_buf_charge_transfer(dmabuf, gpucg);
+		if (ret) {
+			pr_warn("%d:%d Unable to transfer DMA-BUF fd charge to %d",
+				proc->pid, thread->pid, target_proc->pid);
+			gpucg_put(gpucg);
+		}
+		dma_buf_put(dmabuf);
 	}
 	return 0;
 }
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/andro=
id/binder.h
index 3246f2c74696..169fd5069a1a 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -137,6 +137,7 @@ struct binder_buffer_object {
=20
 enum {
 	BINDER_BUFFER_FLAG_HAS_PARENT =3D 0x01,
+	BINDER_BUFFER_FLAG_SENDER_NO_NEED =3D 0x02,
 };
=20
 /* struct binder_fd_array_object - object describing an array of fds in a =
buffer
--=20
2.35.1.616.g0bdcbb4464-goog

