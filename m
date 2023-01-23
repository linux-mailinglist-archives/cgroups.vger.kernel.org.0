Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0593A678612
	for <lists+cgroups@lfdr.de>; Mon, 23 Jan 2023 20:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjAWTTC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Jan 2023 14:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjAWTS3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 Jan 2023 14:18:29 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A132E70
        for <cgroups@vger.kernel.org>; Mon, 23 Jan 2023 11:18:17 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id dc11-20020a056a0035cb00b00589a6a97519so5669946pfb.8
        for <cgroups@vger.kernel.org>; Mon, 23 Jan 2023 11:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2WhRnZzQgS7vry+Z+wffN8GNT/+GwBkd2a3cKemc3A=;
        b=qIoHkzSJgScPAOmXRPybmkkxLYzr2DadvdaoU+21L1WVU3YW/Hmjf98YSxQck6Cojl
         hSJIB90Oc/J5PhcPthu37nMpMkmKvUecOx+8XcN0o61N3c9FSHsypWEcnKqeCpO8oZn5
         5t2GLdXEZE6+Kn1L/RgqPV6+knFah8Sty5ttQeslTrfM6XTfbVGpIJuSS4JTguGrEf+K
         02GyI8CR+Za0guqiCqlg7dAfcw68H5UFF1O5CbDXUC7fdVcQj+I00pYkk/UsWsyDil4n
         wMUZxRBLOsVMt7lEWJwwaO1NERbypePie8xI/PldXEjxtDPpICffELsttwq1JrA5YUun
         L0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2WhRnZzQgS7vry+Z+wffN8GNT/+GwBkd2a3cKemc3A=;
        b=6uW+gJpv/3xB8ug38/BEvzkF4e4wP9J3lt1OvD31EwXtft5RE8ZMQKPoxmK/5GAeYd
         IiGD+Zz5upEIWQkQm9lyzRFgUcc6HFFRM6V+fni6Bea8N+LmVwKQnWggAfm8qpTxZ0Sa
         Ti/1GP6bEXa09EUY3+HXD/byG7PpoNXm1mcTWOD5BffN0SVCDhGe5yjfwpn/xt6OVw6a
         O8Hc8/tx946V3Z/vteFWhTSWjohj2lEWiIp+Cs5mVMhszwUfSVfkyoxCmmld/PLQtnnW
         DBvosBS0HDNH5v9JlmQjBsKJL5fO7PXkV8YUaed914cXaxMQgYXtAYonHc/84laQqDII
         kobA==
X-Gm-Message-State: AFqh2krT4ZcuyyKR4dY/VErtxcK10ZJDFBzhs4LvxK/oo0WPYx9lX1C8
        vA+UBquQFYTbkEhcVshSjeJAoVYFrWjw95s=
X-Google-Smtp-Source: AMrXdXsNa09AO4Arg6ZBRXKwo+WF/qUZjQHNXFX5rA6KWe8BFUhOpIiYlW4PW5subPRyzOFWH3Ah7qsET8UrWsU=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:aa7:8a0b:0:b0:58d:bffa:db35 with SMTP id
 m11-20020aa78a0b000000b0058dbffadb35mr2968935pfa.34.1674501496540; Mon, 23
 Jan 2023 11:18:16 -0800 (PST)
Date:   Mon, 23 Jan 2023 19:17:26 +0000
In-Reply-To: <20230123191728.2928839-1-tjmercier@google.com>
Mime-Version: 1.0
References: <20230123191728.2928839-1-tjmercier@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230123191728.2928839-5-tjmercier@google.com>
Subject: [PATCH v2 4/4] security: binder: Add binder object flags to selinux_binder_transfer_file
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     hannes@cmpxchg.org, daniel.vetter@ffwll.ch, android-mm@google.com,
        jstultz@google.com, jeffv@google.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Any process can cause a memory charge transfer to occur to any other
process when transmitting a file descriptor through binder. This should
only be possible for central allocator processes, so the binder object
flags are added to the security_binder_transfer_file hook so that LSMs
can enforce restrictions on charge transfers.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/android/binder.c            |  2 +-
 include/linux/lsm_hook_defs.h       |  2 +-
 include/linux/lsm_hooks.h           |  5 ++++-
 include/linux/security.h            |  6 ++++--
 security/security.c                 |  4 ++--
 security/selinux/hooks.c            | 13 ++++++++++++-
 security/selinux/include/classmap.h |  2 +-
 7 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 5e707974793f..7b1bb23b6b79 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2270,7 +2270,7 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset, __u32 flags,
 		ret = -EBADF;
 		goto err_fget;
 	}
-	ret = security_binder_transfer_file(proc->cred, target_proc->cred, file);
+	ret = security_binder_transfer_file(proc->cred, target_proc->cred, file, flags);
 	if (ret < 0) {
 		ret = -EPERM;
 		goto err_security;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ed6cb2ac55fa..84ee61089f7b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -32,7 +32,7 @@ LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
 LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
 	 const struct cred *to)
 LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
-	 const struct cred *to, struct file *file)
+	 const struct cred *to, struct file *file, u32 binder_object_flags)
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0a5ba81f7367..d57977336ae8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1381,9 +1381,12 @@
  *	Return 0 if permission is granted.
  * @binder_transfer_file:
  *	Check whether @from is allowed to transfer @file to @to.
+ *	If @binder_object_flags indicates a memory charge transfer for @file, then
+ *	permission for the charge transfer can be checked as well.
  *	@from contains the struct cred for the sending process.
- *	@file contains the struct file being transferred.
  *	@to contains the struct cred for the receiving process.
+ *	@file contains the struct file being transferred.
+ *	@binder_object_flags contains the flags associated with the binder object.
  *	Return 0 if permission is granted.
  *
  * @ptrace_access_check:
diff --git a/include/linux/security.h b/include/linux/security.h
index 5b67f208f7de..c4b80fc8d104 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -269,7 +269,8 @@ int security_binder_transaction(const struct cred *from,
 int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to);
 int security_binder_transfer_file(const struct cred *from,
-				  const struct cred *to, struct file *file);
+				  const struct cred *to, struct file *file,
+				  u32 binder_object_flags);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(struct task_struct *target,
@@ -542,7 +543,8 @@ static inline int security_binder_transfer_binder(const struct cred *from,
 
 static inline int security_binder_transfer_file(const struct cred *from,
 						const struct cred *to,
-						struct file *file)
+						struct file *file,
+						u32 binder_object_flags)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index d1571900a8c7..12ccaca744c0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -796,9 +796,9 @@ int security_binder_transfer_binder(const struct cred *from,
 }
 
 int security_binder_transfer_file(const struct cred *from,
-				  const struct cred *to, struct file *file)
+				  const struct cred *to, struct file *file, u32 binder_object_flags)
 {
-	return call_int_hook(binder_transfer_file, 0, from, to, file);
+	return call_int_hook(binder_transfer_file, 0, from, to, file, binder_object_flags);
 }
 
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3c5be76a9199..d4cfca3c9a3b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -88,6 +88,7 @@
 #include <linux/bpf.h>
 #include <linux/kernfs.h>
 #include <linux/stringhash.h>	/* for hashlen_string() */
+#include <uapi/linux/android/binder.h>
 #include <uapi/linux/mount.h>
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
@@ -2029,7 +2030,8 @@ static int selinux_binder_transfer_binder(const struct cred *from,
 
 static int selinux_binder_transfer_file(const struct cred *from,
 					const struct cred *to,
-					struct file *file)
+					struct file *file,
+					u32 binder_object_flags)
 {
 	u32 sid = cred_sid(to);
 	struct file_security_struct *fsec = selinux_file(file);
@@ -2038,6 +2040,15 @@ static int selinux_binder_transfer_file(const struct cred *from,
 	struct common_audit_data ad;
 	int rc;
 
+	if (binder_object_flags & BINDER_FD_FLAG_XFER_CHARGE) {
+		rc = avc_has_perm(&selinux_state,
+			    cred_sid(from), sid,
+			    SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
+			    NULL);
+		if (rc)
+			return rc;
+	}
+
 	ad.type = LSM_AUDIT_DATA_PATH;
 	ad.u.path = file->f_path;
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index a3c380775d41..2eef180d10d7 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -172,7 +172,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "tun_socket",
 	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
 	{ "binder", { "impersonate", "call", "set_context_mgr", "transfer",
-		      NULL } },
+		      "transfer_charge", NULL } },
 	{ "cap_userns",
 	  { COMMON_CAP_PERMS, NULL } },
 	{ "cap2_userns",
-- 
2.39.0.246.g2a6d74b583-goog

