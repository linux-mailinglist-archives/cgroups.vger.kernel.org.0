Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110D5667C9D
	for <lists+cgroups@lfdr.de>; Thu, 12 Jan 2023 18:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjALRf6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 12:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjALRfT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 12:35:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A76C9707;
        Thu, 12 Jan 2023 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673542664; x=1705078664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aC20zrLtbmafnfXUOIpvUqX1idswNb59e1zqrjldwBE=;
  b=Fv8J3bfSQaMOklkkJ+9vB7zuAKImSWTmKlfCQQtwzJuSX+2cDp9508sR
   Jd3zGBIqOIJMLo69Aw5qS3G0YFP7v7F9f+g9Cun/2lIKSktjyaq+vfu1C
   yFhtJqrhhWb/bdDR45QwAENIqtJCJHU42sNj/OE65lRCnztAc2btroLsJ
   Cl+ueY4Jm6OmfWG2MlsV23A45uffvRYZyhS7JUIlkHuFwvPYx7cvI+C96
   wGoYE5aDrwFkT/0l6qD/Knhr1ZrWRF3biVCOPslilnqqRvisyitC2WjEi
   Jg7DOi9Fe9zYsrXSKRxe8+zTM8DSDbAw7Yk8DsCY+OjUumx5RaE7Bmxpl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325016206"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325016206"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:56:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="651232540"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="651232540"
Received: from jacton-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.195.171])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:56:25 -0800
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Zack Rusin <zackr@vmware.com>,
        linux-graphics-maintainer@vmware.com,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [RFC 01/12] drm: Track clients by tgid and not tid
Date:   Thu, 12 Jan 2023 16:55:58 +0000
Message-Id: <20230112165609.1083270-2-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Thread group id (aka pid from userspace point of view) is a more
interesting thing to show as an owner of a DRM fd, so track and show that
instead of the thread id.

In the next patch we will make the owner updated post file descriptor
handover, which will also be tgid based to avoid ping-pong when multiple
threads access the fd.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: linux-graphics-maintainer@vmware.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Reviewed-by: Zack Rusin <zackr@vmware.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
 drivers/gpu/drm/drm_debugfs.c           | 4 ++--
 drivers/gpu/drm/drm_file.c              | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 00edc7002ee8..ca0181332578 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -969,7 +969,7 @@ static int amdgpu_debugfs_gem_info_show(struct seq_file *m, void *unused)
 		 * Therefore, we need to protect this ->comm access using RCU.
 		 */
 		rcu_read_lock();
-		task = pid_task(file->pid, PIDTYPE_PID);
+		task = pid_task(file->pid, PIDTYPE_TGID);
 		seq_printf(m, "pid %8d command %s:\n", pid_nr(file->pid),
 			   task ? task->comm : "<unknown>");
 		rcu_read_unlock();
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 4f643a490dc3..4855230ba2c6 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -80,7 +80,7 @@ static int drm_clients_info(struct seq_file *m, void *data)
 	seq_printf(m,
 		   "%20s %5s %3s master a %5s %10s\n",
 		   "command",
-		   "pid",
+		   "tgid",
 		   "dev",
 		   "uid",
 		   "magic");
@@ -94,7 +94,7 @@ static int drm_clients_info(struct seq_file *m, void *data)
 		bool is_current_master = drm_is_current_master(priv);
 
 		rcu_read_lock(); /* locks pid_task()->comm */
-		task = pid_task(priv->pid, PIDTYPE_PID);
+		task = pid_task(priv->pid, PIDTYPE_TGID);
 		uid = task ? __task_cred(task)->euid : GLOBAL_ROOT_UID;
 		seq_printf(m, "%20s %5d %3d   %c    %c %5d %10u\n",
 			   task ? task->comm : "<unknown>",
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index a51ff8cee049..c1018c470047 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -156,7 +156,7 @@ struct drm_file *drm_file_alloc(struct drm_minor *minor)
 	if (!file)
 		return ERR_PTR(-ENOMEM);
 
-	file->pid = get_pid(task_pid(current));
+	file->pid = get_pid(task_tgid(current));
 	file->minor = minor;
 
 	/* for compatibility root is always authenticated */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
index ce609e7d758f..f2985337aa53 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -260,7 +260,7 @@ static int vmw_debugfs_gem_info_show(struct seq_file *m, void *unused)
 		 * Therefore, we need to protect this ->comm access using RCU.
 		 */
 		rcu_read_lock();
-		task = pid_task(file->pid, PIDTYPE_PID);
+		task = pid_task(file->pid, PIDTYPE_TGID);
 		seq_printf(m, "pid %8d command %s:\n", pid_nr(file->pid),
 			   task ? task->comm : "<unknown>");
 		rcu_read_unlock();
-- 
2.34.1

