Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35A8646743
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 03:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiLHCxU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Dec 2022 21:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLHCxT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Dec 2022 21:53:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA6C5BD55;
        Wed,  7 Dec 2022 18:53:17 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d3so228231plr.10;
        Wed, 07 Dec 2022 18:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Tg8aD+lDH6Tv1G5iqzFowxNp9DpUbCk5WdkpP14KUyw=;
        b=bwaVRySVfZUnRb2bEPwJ5xCOaAbW2JOL2VzvtwPsxsOLsgpqhXcMxtBMO4VtjWsH7V
         MDQdVhBlbBUjWAU33uNkOOvxe6VkCUIQpal1m6VcrraOtDor8fGL9ie8cC1x1k9jxDpj
         czQSokKN+AFxHVJpY8Th5uLXRaS/kzWqoEfgdtR/nJOjRFicdSnYdhZ4WHoINWQqfB/R
         k05tFcdSkGfjgd0dvF+scgm7a1+iUyuh/FVGqvRGA392bZFPehNVJTITg5BaWJBBlLvm
         tIEKV5suDt1M2Sc9G4ukFt5sH7wc7eq/2lUB3Z18JNCWI+My330fDciGZKoERtGwNA5C
         HQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tg8aD+lDH6Tv1G5iqzFowxNp9DpUbCk5WdkpP14KUyw=;
        b=6LKQ6WRHjit+VvlRmohFvuan4UmIN3DNtmQPDPWG/N9GzebLs8sYYKZYcCVCkbtZjC
         TkiayfHHdwEhYvHjoneo9S0LHak4vHy7zeFdh9Cyy5c6xqvwhPW7LjBk7paset4b3xgk
         V9bMlcmA0wxC6KzEBTrFCYn+X3xKtPxaX3xQbbiLZ7lIla+mYjGnCOtGQoiTqHJ3ZRUF
         0hl43YWqzOz5EWkSIgR11M3EHj2tNMLMGueBdMQMNx9pXmmbTiDGFe6HxypAKscJZiwO
         vjZSYgmIe7o42GeEicXX/hFg6aBDSSPlegECOP6osicqVPV/yU685FU+5rFroBmgaPR5
         mZqQ==
X-Gm-Message-State: ANoB5plIAgCtF7pVUUx27G5A0kAUTfVdlHRaYEnJnacj/9Jyp+2GIBtS
        l3P48d9sLXsVV3xnBCB+EHA=
X-Google-Smtp-Source: AA0mqf6MHLTy6w/tpnXtPpaIlwt8HeZbJL0xdkJqzAciMkw8dRBGOvKbVId36jXJqjg26Wh9+SLmYQ==
X-Received: by 2002:a17:90a:1f8c:b0:219:fcad:75be with SMTP id x12-20020a17090a1f8c00b00219fcad75bemr10669236pja.165.1670467996865;
        Wed, 07 Dec 2022 18:53:16 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id o25-20020aa79799000000b005769b244c2fsm8692079pfp.40.2022.12.07.18.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 18:53:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 7 Dec 2022 16:53:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
Subject: [PATCH for-6.1-fixes] memcg: Fix possible use-after-free in
 memcg_write_event_control()
Message-ID: <Y5FRm/cfcKPGzWwl@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

memcg_write_event_control() accesses the dentry->d_name of the specified
control fd to route the write call. As a cgroup interface file can't be
renamed, it's safe to access d_name as long as the specified file is a
regular cgroup file. Also, as these cgroup interface files can't be removed
before the directory, it's safe to access the parent too.

Prior to 347c4a874710 ("memcg: remove cgroup_event->cft"), there was a call
to __file_cft() which verified that the specified file is a regular cgroupfs
file before further accesses. The cftype pointer returned from __file_cft()
was no longer necessary and the commit inadvertently dropped the file type
check with it allowing any file to slip through. With the invarients broken,
the d_name and parent accesses can now race against renames and removals of
arbitrary files and cause use-after-free's.

Fix the bug by resurrecting the file type check in __file_cft(). Now that
cgroupfs is implemented through kernfs, checking the file operations needs
to go through a layer of indirection. Instead, let's check the superblock
and dentry type.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 347c4a874710 ("memcg: remove cgroup_event->cft")
Cc: stable@vger.kernel.org # v3.14+
Reported-by: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/cgroup.h          |    1 +
 kernel/cgroup/cgroup-internal.h |    1 -
 mm/memcontrol.c                 |   15 +++++++++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 528bd44b59e2..2b7d077de7ef 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -68,6 +68,7 @@ struct css_task_iter {
 	struct list_head		iters_node;	/* css_set->task_iters */
 };
 
+extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
 
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index fd4020835ec6..367b0a42ada9 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -167,7 +167,6 @@ struct cgroup_mgctx {
 extern spinlock_t css_set_lock;
 extern struct cgroup_subsys *cgroup_subsys[];
 extern struct list_head cgroup_roots;
-extern struct file_system_type cgroup_fs_type;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a1a35c12635e..266a1ab05434 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4832,6 +4832,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	unsigned int efd, cfd;
 	struct fd efile;
 	struct fd cfile;
+	struct dentry *cdentry;
 	const char *name;
 	char *endp;
 	int ret;
@@ -4885,6 +4886,16 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	if (ret < 0)
 		goto out_put_cfile;
 
+	/*
+	 * The control file must be a regular cgroup1 file. As a regular cgroup
+	 * file can't be renamed, it's safe to access its name afterwards.
+	 */
+	cdentry = cfile.file->f_path.dentry;
+	if (cdentry->d_sb->s_type != &cgroup_fs_type || !d_is_reg(cdentry)) {
+		ret = -EINVAL;
+		goto out_put_cfile;
+	}
+
 	/*
 	 * Determine the event callbacks and set them in @event.  This used
 	 * to be done via struct cftype but cgroup core no longer knows
@@ -4893,7 +4904,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	 *
 	 * DO NOT ADD NEW FILES.
 	 */
-	name = cfile.file->f_path.dentry->d_name.name;
+	name = cdentry->d_name.name;
 
 	if (!strcmp(name, "memory.usage_in_bytes")) {
 		event->register_event = mem_cgroup_usage_register_event;
@@ -4917,7 +4928,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	 * automatically removed on cgroup destruction but the removal is
 	 * asynchronous, so take an extra ref on @css.
 	 */
-	cfile_css = css_tryget_online_from_dir(cfile.file->f_path.dentry->d_parent,
+	cfile_css = css_tryget_online_from_dir(cdentry->d_parent,
 					       &memory_cgrp_subsys);
 	ret = -EINVAL;
 	if (IS_ERR(cfile_css))
