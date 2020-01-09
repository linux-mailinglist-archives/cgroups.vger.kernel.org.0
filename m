Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80124135C31
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2020 16:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgAIPGI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jan 2020 10:06:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:53916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgAIPGI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 9 Jan 2020 10:06:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E64DAE34;
        Thu,  9 Jan 2020 15:06:06 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] cgroup: Prevent double killing of css when enabling threaded cgroup
Date:   Thu,  9 Jan 2020 16:05:59 +0100
Message-Id: <20200109150559.14457-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219022716.o7vxxia6o67tyfmf@wittgenstein>
References: <20191219022716.o7vxxia6o67tyfmf@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The test_cgcore_no_internal_process_constraint_on_threads selftest when
running with subsystem controlling noise triggers two warnings:

> [  597.443115] WARNING: CPU: 1 PID: 28167 at kernel/cgroup/cgroup.c:3131 cgroup_apply_control_enable+0xe0/0x3f0
> [  597.443413] WARNING: CPU: 1 PID: 28167 at kernel/cgroup/cgroup.c:3177 cgroup_apply_control_disable+0xa6/0x160

Both stem from a call to cgroup_type_write. The first warning was also
triggered by syzkaller.

When we're switching cgroup to threaded mode shortly after a subsystem
was disabled on it, we can see the respective subsystem css dying there.

The warning in cgroup_apply_control_enable is harmless in this case
since we're not adding new subsys anyway.
The warning in cgroup_apply_control_disable indicates an attempt to kill
css of recently disabled subsystem repeatedly.

The commit prevents these situations by making cgroup_type_write wait
for all dying csses to go away before re-applying subtree controls.
When at it, the locations of WARN_ON_ONCE calls are moved so that
warning is triggered only when we are about to misuse the dying css.

Reported-by: syzbot+5493b2a54d31d6aea629@syzkaller.appspotmail.com
Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 53098c1d45e2..97cc713079df 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3054,8 +3054,6 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
 		for_each_subsys(ss, ssid) {
 			struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
 
-			WARN_ON_ONCE(css && percpu_ref_is_dying(&css->refcnt));
-
 			if (!(cgroup_ss_mask(dsct) & (1 << ss->id)))
 				continue;
 
@@ -3065,6 +3063,8 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
 					return PTR_ERR(css);
 			}
 
+			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
+
 			if (css_visible(css)) {
 				ret = css_populate_dir(css);
 				if (ret)
@@ -3100,11 +3100,11 @@ static void cgroup_apply_control_disable(struct cgroup *cgrp)
 		for_each_subsys(ss, ssid) {
 			struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
 
-			WARN_ON_ONCE(css && percpu_ref_is_dying(&css->refcnt));
-
 			if (!css)
 				continue;
 
+			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
+
 			if (css->parent &&
 			    !(cgroup_ss_mask(dsct) & (1 << ss->id))) {
 				kill_css(css);
@@ -3391,7 +3391,8 @@ static ssize_t cgroup_type_write(struct kernfs_open_file *of, char *buf,
 	if (strcmp(strstrip(buf), "threaded"))
 		return -EINVAL;
 
-	cgrp = cgroup_kn_lock_live(of->kn, false);
+	/* drain dying csses before we re-apply (threaded) subtree control */
+	cgrp = cgroup_kn_lock_live(of->kn, true);
 	if (!cgrp)
 		return -ENOENT;
 
-- 
2.24.1

