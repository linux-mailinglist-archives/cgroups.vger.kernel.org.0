Return-Path: <cgroups+bounces-905-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A82C809F70
	for <lists+cgroups@lfdr.de>; Fri,  8 Dec 2023 10:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93571F20FB8
	for <lists+cgroups@lfdr.de>; Fri,  8 Dec 2023 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10E4125CE;
	Fri,  8 Dec 2023 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JtuRaQ5/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD58E
	for <cgroups@vger.kernel.org>; Fri,  8 Dec 2023 01:33:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54bfd4546fbso2658805a12.1
        for <cgroups@vger.kernel.org>; Fri, 08 Dec 2023 01:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1702027993; x=1702632793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4rZ/GzRY7+TnTS+jdlOOGqRdC+4LjtAOi+pvi/VqV0=;
        b=JtuRaQ5/qOG7u7fsHo5vA6j7INkvoMJWlC1UGGAfMSrIB7FIC1QukHG4FajC596zsl
         E1zj8nAleHRCoRTpXiDjrILm+XBC173B2tVZ/hXyw4X0pKJaAHNOTJPaEpTy59Xy4i0B
         407bVZdzIkVKxG6nY8A/IktYMm9NrRWgwKyZpWkys9KDaJfM3ghOCgrvg+rsgp9THm2b
         BXA4lQGqmnt0CAaa063gwnxdn6t7vwb4GiASNoMfarZTk6f/hgKum1oJggoXgy5WTHtE
         wdbN0a3eyOep+cfChbuTdIhzES1l9V+AegXlBk8vKh+E8/6VkJ+bTZ0JH2BTDSxqMuW6
         /7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702027993; x=1702632793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4rZ/GzRY7+TnTS+jdlOOGqRdC+4LjtAOi+pvi/VqV0=;
        b=jluCMBgZYk0LwSeqk67lJ+w8w8PqqE1o4MvCmuFv3RbqQFo78KfDqAEg4cGzS84sei
         y+PoJjptBRIN3JnJV3XR0Ooe7JsX9SfSEAijRsfJ1aLTI4Duq6HbAfMBpsSbw5BZpsRq
         WyYlH2pN5Kkrjs+gXej7NvT9WKyz7xTOsT1P19iNMOxqHefetSSiuTCiaKAQxY1iT12N
         29EzkjtLCXKhyuCjR3yaeVsZFecCEvBdsereGRWtUyrwK2ElmU/5UrEvv4BXXFiNpR+i
         EP+waqYtZvkyWJ9vmCGWD1EAeKPYOxWPonvVUEH2dRByv8X7gFF1jZqESlkRsKY4wsIv
         ks6Q==
X-Gm-Message-State: AOJu0YzYkMUzJb2hsGz33+joqQIpc6TpWgr9CfqvXSbdYRXy/kjp9AsY
	/ljoLJMfPEIHKersD1FENGbxUQ==
X-Google-Smtp-Source: AGHT+IEDKaDtDXTodMm2fz1ox0C+VP5DwilqtYu0RuTtufQyat/65bCaa/g2n8dCE/SBCfkr5NUY+w==
X-Received: by 2002:a17:906:10ce:b0:a1e:1da1:73c0 with SMTP id v14-20020a17090610ce00b00a1e1da173c0mr1885941ejv.10.1702027992742;
        Fri, 08 Dec 2023 01:33:12 -0800 (PST)
Received: from heron.intern.cm-ag (p200300dc6f0b6500529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f0b:6500:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id vk5-20020a170907cbc500b00a1ce56f7b16sm774812ejc.71.2023.12.08.01.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:33:12 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 1/2] kernel/cgroup: use kernfs_create_dir_ns()
Date: Fri,  8 Dec 2023 10:33:09 +0100
Message-Id: <20231208093310.297233-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By passing the fsugid to kernfs_create_dir_ns(), we don't need
cgroup_kn_set_ugid() any longer.  That function was added for exactly
this purpose by commit 49957f8e2a43 ("cgroup: newly created dirs and
files should be owned by the creator").

Eliminating this piece of duplicate code means we benefit from future
improvements to kernfs_create_dir_ns(); for example, both are lacking
S_ISGID support currently, which my next patch will add to
kernfs_create_dir_ns().  It cannot (easily) be added to
cgroup_kn_set_ugid() because we can't dereference struct kernfs_iattrs
from there.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Acked-by: Tejun Heo <tj@kernel.org>
--
v1 -> v2: 12-digit commit id
---
 kernel/cgroup/cgroup.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4b9ff41ca603..a844b421fd83 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4169,20 +4169,6 @@ static struct kernfs_ops cgroup_kf_ops = {
 	.seq_show		= cgroup_seqfile_show,
 };
 
-/* set uid and gid of cgroup dirs and files to that of the creator */
-static int cgroup_kn_set_ugid(struct kernfs_node *kn)
-{
-	struct iattr iattr = { .ia_valid = ATTR_UID | ATTR_GID,
-			       .ia_uid = current_fsuid(),
-			       .ia_gid = current_fsgid(), };
-
-	if (uid_eq(iattr.ia_uid, GLOBAL_ROOT_UID) &&
-	    gid_eq(iattr.ia_gid, GLOBAL_ROOT_GID))
-		return 0;
-
-	return kernfs_setattr(kn, &iattr);
-}
-
 static void cgroup_file_notify_timer(struct timer_list *timer)
 {
 	cgroup_file_notify(container_of(timer, struct cgroup_file,
@@ -4195,25 +4181,18 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 	char name[CGROUP_FILE_NAME_MAX];
 	struct kernfs_node *kn;
 	struct lock_class_key *key = NULL;
-	int ret;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	key = &cft->lockdep_key;
 #endif
 	kn = __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
 				  cgroup_file_mode(cft),
-				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				  current_fsuid(), current_fsgid(),
 				  0, cft->kf_ops, cft,
 				  NULL, key);
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
 
-	ret = cgroup_kn_set_ugid(kn);
-	if (ret) {
-		kernfs_remove(kn);
-		return ret;
-	}
-
 	if (cft->file_offset) {
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
@@ -5616,7 +5595,9 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 		goto out_cancel_ref;
 
 	/* create the directory */
-	kn = kernfs_create_dir(parent->kn, name, mode, cgrp);
+	kn = kernfs_create_dir_ns(parent->kn, name, mode,
+				  current_fsuid(), current_fsgid(),
+				  cgrp, NULL);
 	if (IS_ERR(kn)) {
 		ret = PTR_ERR(kn);
 		goto out_stat_exit;
@@ -5761,10 +5742,6 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	 */
 	kernfs_get(cgrp->kn);
 
-	ret = cgroup_kn_set_ugid(cgrp->kn);
-	if (ret)
-		goto out_destroy;
-
 	ret = css_populate_dir(&cgrp->self);
 	if (ret)
 		goto out_destroy;
-- 
2.39.2


