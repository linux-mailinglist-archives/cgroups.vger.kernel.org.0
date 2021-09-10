Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC764065C9
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 04:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhIJCok (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Sep 2021 22:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229720AbhIJCoj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Sep 2021 22:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631241809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=gUD1vKzYV0VFOfbg/xx9d5TFA8WbIvMJMHxJQQTpNRM=;
        b=dCfVtDYpHL5n73cgvwl3G39ZkR9HzX+CqqWWsHP5E9Nr4tHhqT9c+frOeSR39P1yClQUhW
        duI4dCmmcbTigQ3XJurffutLEOIJYbu7FPRubcIjmXQi8Zy6mg3i9c3pkR5T7NLDn3vo+q
        A58e7ZaEuRTORwAyrz39h/P33kcqgGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-s9GBw-Y8MqGUwMuS8WsOYA-1; Thu, 09 Sep 2021 22:43:28 -0400
X-MC-Unique: s9GBw-Y8MqGUwMuS8WsOYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6660D1084682;
        Fri, 10 Sep 2021 02:43:26 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 904F660C7F;
        Fri, 10 Sep 2021 02:43:17 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] cgroup: Fix incorrect warning from cgroup_apply_control_disable()
Date:   Thu,  9 Sep 2021 22:42:55 -0400
Message-Id: <20210910024256.7615-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It was found that the following warning was displayed when remounting
controllers from cgroup v2 to v1:

[ 8042.997778] WARNING: CPU: 88 PID: 80682 at kernel/cgroup/cgroup.c:3130 cgroup_apply_control_disable+0x158/0x190
   :
[ 8043.091109] RIP: 0010:cgroup_apply_control_disable+0x158/0x190
[ 8043.096946] Code: ff f6 45 54 01 74 39 48 8d 7d 10 48 c7 c6 e0 46 5a a4 e8 7b 67 33 00 e9 41 ff ff ff 49 8b 84 24 e8 01 00 00 0f b7 40 08 eb 95 <0f> 0b e9 5f ff ff ff 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3
[ 8043.115692] RSP: 0018:ffffba8a47c23d28 EFLAGS: 00010202
[ 8043.120916] RAX: 0000000000000036 RBX: ffffffffa624ce40 RCX: 000000000000181a
[ 8043.128047] RDX: ffffffffa63c43e0 RSI: ffffffffa63c43e0 RDI: ffff9d7284ee1000
[ 8043.135180] RBP: ffff9d72874c5800 R08: ffffffffa624b090 R09: 0000000000000004
[ 8043.142314] R10: ffffffffa624b080 R11: 0000000000002000 R12: ffff9d7284ee1000
[ 8043.149447] R13: ffff9d7284ee1000 R14: ffffffffa624ce70 R15: ffffffffa6269e20
[ 8043.156576] FS:  00007f7747cff740(0000) GS:ffff9d7a5fc00000(0000) knlGS:0000000000000000
[ 8043.164663] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8043.170409] CR2: 00007f7747e96680 CR3: 0000000887d60001 CR4: 00000000007706e0
[ 8043.177539] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 8043.184673] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 8043.191804] PKRU: 55555554
[ 8043.194517] Call Trace:
[ 8043.196970]  rebind_subsystems+0x18c/0x470
[ 8043.201070]  cgroup_setup_root+0x16c/0x2f0
[ 8043.205177]  cgroup1_root_to_use+0x204/0x2a0
[ 8043.209456]  cgroup1_get_tree+0x3e/0x120
[ 8043.213384]  vfs_get_tree+0x22/0xb0
[ 8043.216883]  do_new_mount+0x176/0x2d0
[ 8043.220550]  __x64_sys_mount+0x103/0x140
[ 8043.224474]  do_syscall_64+0x38/0x90
[ 8043.228063]  entry_SYSCALL_64_after_hwframe+0x44/0xae

It was caused by the "WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt))"
check. It was because the css had not been completely removed from
a previous call to css_kill() by cgroup_apply_control_disable() and
so the warning was triggered when cgroup_apply_control_disable() was
called again soon afterward.

Eliminating this incorrect warning by using percpu_ref_is_dying() as
escape for further action instead.

Fixes: 945ba19968888 ("cgroup: combine cgroup_mutex locking and offline css draining")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cgroup.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 881ce1470beb..e31bca9fcd46 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3140,7 +3140,16 @@ static void cgroup_apply_control_disable(struct cgroup *cgrp)
 			if (!css)
 				continue;
 
-			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
+			/*
+			 * A kill_css() might have been called previously, but
+			 * the css may still linger for a while before being
+			 * removed. Skip it in this case.
+			 */
+			if (percpu_ref_is_dying(&css->refcnt)) {
+				WARN_ON_ONCE(css->parent &&
+					cgroup_ss_mask(dsct) & (1 << ss->id));
+				continue;
+			}
 
 			if (css->parent &&
 			    !(cgroup_ss_mask(dsct) & (1 << ss->id))) {
-- 
2.18.1

