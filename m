Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9318D74DD61
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGJSdp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 14:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJSdo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 14:33:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E6319A
        for <cgroups@vger.kernel.org>; Mon, 10 Jul 2023 11:33:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6689430d803so2468855b3a.0
        for <cgroups@vger.kernel.org>; Mon, 10 Jul 2023 11:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689014021; x=1691606021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KfOFwa2MqGzUVHMgMbaymeSQf/jXq0PE9ZHxapBD3Wg=;
        b=L6sqxAkYvprfFLOpuEhxBMp3KNnplB0ZZcAipTraoZiFvvCxf5cGIkbNgr1XsLKwwt
         dYDuePFBEKrJay9FP/gc2BkJQgoUC0I4JXHljZAkscoST0FgIb9tIOctKtBoElAIOCeJ
         RLip2ZlDiqlYFlPsq3R684aqltWpmCQoDLRgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014021; x=1691606021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfOFwa2MqGzUVHMgMbaymeSQf/jXq0PE9ZHxapBD3Wg=;
        b=laZRbqrjBQlxJvVo86yHkUNXTm8UCoc5qN7aBi6HyH+uVWw98w40OJKAG9l9AmUc7L
         CtgPjK4vwxZE6p/CpH4Xkjvr8hjx+L8hgLDVqMliRH/2I5/d9e5MUUHCbu3OtBTghec+
         QKojr4eODkJkxJvs0/evXEBk/5zWNlSVC3tKFYQIqtyftOdrVrbrFfS1AKp2n73Lby8E
         5S4lr+vV5TXy+PfofTz+zq/qrNbwPqQR9dfXuhesnoGEEqFiUXGNN60mvzbWDIl4Fj1N
         DnSRmTxqksedByMGLoKDDKnJkvRwRbx3z/C6ppMCJZ2P8gDoauNTotUw1kD4tfAq9jQw
         dp5Q==
X-Gm-Message-State: ABy/qLYcmBvhImTybGu5yVTHaQxJJBykbEhaDZ0W81x88VzQlLyTp5rx
        yat392iLFcmqQ1AqWNBGErvwYw==
X-Google-Smtp-Source: APBJJlEqVexQ6jN2gO3KWfYqkBJoMzaqpFqQyvVnVP9eqYxWtYJk6TKV2fjLJpZdKtiKiwtFwVEYsg==
X-Received: by 2002:a05:6a00:1915:b0:64a:2dd6:4f18 with SMTP id y21-20020a056a00191500b0064a2dd64f18mr12947103pfi.13.1689014021308;
        Mon, 10 Jul 2023 11:33:41 -0700 (PDT)
Received: from localhost ([2601:644:200:aea:60e1:d34a:f5f6:64b5])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79391000000b00679d3fb2f92sm96713pfe.154.2023.07.10.11.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:33:41 -0700 (PDT)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ivan Babrou <ivan@cloudflare.com>
Subject: [PATCH] kernfs: attach uuid for every kernfs and report it in fsid
Date:   Mon, 10 Jul 2023 11:33:38 -0700
Message-ID: <20230710183338.58531-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following two commits added the same thing for tmpfs:

* commit 2b4db79618ad ("tmpfs: generate random sb->s_uuid")
* commit 59cda49ecf6c ("shmem: allow reporting fanotify events with file handles on tmpfs")

Having fsid allows using fanotify, which is especially handy for cgroups,
where one might be interested in knowing when they are created or removed.

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
---
 fs/kernfs/mount.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d49606accb07..930026842359 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -16,6 +16,8 @@
 #include <linux/namei.h>
 #include <linux/seq_file.h>
 #include <linux/exportfs.h>
+#include <linux/uuid.h>
+#include <linux/statfs.h>
 
 #include "kernfs-internal.h"
 
@@ -45,8 +47,15 @@ static int kernfs_sop_show_path(struct seq_file *sf, struct dentry *dentry)
 	return 0;
 }
 
+int kernfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	simple_statfs(dentry, buf);
+	buf->f_fsid = uuid_to_fsid(dentry->d_sb->s_uuid.b);
+	return 0;
+}
+
 const struct super_operations kernfs_sops = {
-	.statfs		= simple_statfs,
+	.statfs		= kernfs_statfs,
 	.drop_inode	= generic_delete_inode,
 	.evict_inode	= kernfs_evict_inode,
 
@@ -351,6 +360,8 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
+		uuid_gen(&sb->s_uuid);
+
 		down_write(&root->kernfs_supers_rwsem);
 		list_add(&info->node, &info->root->supers);
 		up_write(&root->kernfs_supers_rwsem);
-- 
2.41.0

