Return-Path: <cgroups+bounces-13520-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG83BcCwe2mSHwIAu9opvQ
	(envelope-from <cgroups+bounces-13520-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 20:10:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CFEB3D15
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 20:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A56030160C1
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 19:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCE0311979;
	Thu, 29 Jan 2026 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtK8oPU3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94022F6179
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713851; cv=none; b=MbvR6Rk+CtoCBqDFGPbpnwx2neTjz5PvSJk+8AGBHVWDIINz2FdDVTC8nDboCqdza7IQaAOTM5pqYoZy2Qa76gBd1moJ9pKXP0Zx9JhSwjKsfZnteU3Cc6hLdOvw1EtS/Mnqzma4b8pBduI1KaxKup8XmYCx/3+JzhUOT+6YWhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713851; c=relaxed/simple;
	bh=KZeyt5voKMoub5vWPZp4qL3RJfBnpEaM6zFAgfgFd6s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pkq6Rg2NPxShuk+xBfiygQXcrQtGx1+2i6vMM/sP/VlP8i4JaeueRnJEUVp4R9Y2nKsbgmx/yNRsFvuSrA0ZE+gXv0v+sBVFrRy9UgdrgCKIj/haZJVyH0iYo1t/178rzo+PbNVXxMT2cDxNmHv7NKVTjXyqtFIYh8oa5bnu2nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KtK8oPU3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c54e81eeab9so838073a12.3
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 11:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769713849; x=1770318649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AUVt+oDQfJ/oInSqEUinongYdkRA6IauvZRFu+cIGm4=;
        b=KtK8oPU3Xz4lGQr+u2jv5yOpZnWeGlGuiHGMHEWXTWnqtdZodO3DHHlchuun6XudjW
         MFBgp/FM15Fn+s840eR85bzEyqjQZGc0HOrgjqn8vITe7DH6D41U2mMDcSKdKDK+C6vQ
         FPtCDvLmCg0/PP3Hw7KyHSQeM4TCjyCIf0tStqVHK3xj4tbgHMRt0AXO2f1n736DhVgc
         Znu4a4PtnCHSfAKghNN5tvwkKmg9KC1bmw732XE5aOLVgo2NSY+5Rhq7pHbjCICvDfvu
         edursCPs2HjraGUDdACm1fsvKAygxs8FtfkNgYEaGnCcHR8QGdsprbZLu/4vHGWMEFH+
         EvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769713849; x=1770318649;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUVt+oDQfJ/oInSqEUinongYdkRA6IauvZRFu+cIGm4=;
        b=U6l/fy9+pp3P0d1nOjGeHWM2I0T3G7FVK/Q7PWp7if4XvoWR/+gpp9t8BHfIdED561
         ROuIAsgI45X1ilz/eLfL0hFs5i4fzGBn5W9cJEjY01LlXPoQqatYZafe0dw0V1YMx6af
         9DU4Od74C2NOuUHQT9RZLYCep42bF4j9Mb5eJ8RoGBYMDl9ENi3GxRIFITjr8sm367yY
         0jnBHRTUR2YMokftmn8pjvgcMEevaudRHkXif/Ng4kWUuK0yt+m33CSSfS0YIciRY++B
         U7NbBlKhN1r1HOVuy+CxjvKT7vGm84EZ/zK+jlz3dFhfOJWuJVs7d3gMzpVej+KWcpV8
         2XfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQqsCGmMfgRZicGCbLOvjo+P9g2IgAxMnDGeSzosine4JQyFeZJEwLsJMkRgogee7lRc2u23XH@vger.kernel.org
X-Gm-Message-State: AOJu0YyV5HyxVT+pAUyI8yQ4mMTKJssmKgRsJSxPAy9NdO5rRlAh3gU+
	xl8NoJqgk4D+/b+NXTse4hX0NIAmRQeymWIXkoo54R8/Z4N9XQKm3WeDuUNLjESf+KlMXj9rEMh
	87TV7U/5NFV1NKwAdzA==
X-Received: from pghl8.prod.google.com ([2002:a63:f308:0:b0:c5e:84e5:d15c])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d50c:b0:341:9db0:61f1 with SMTP id adf61e73a8af0-392e00007e4mr82697637.16.1769713849038;
 Thu, 29 Jan 2026 11:10:49 -0800 (PST)
Date: Thu, 29 Jan 2026 11:10:34 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129191034.3181412-1-tjmercier@google.com>
Subject: [PATCH 6.12.y] cgroup: Fix kernfs_node UAF in css_free_rwork_fn
From: "T.J. Mercier" <tjmercier@google.com>
To: stable@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, cgroups@vger.kernel.org, hawk@kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13520-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96CFEB3D15
X-Rspamd-Action: no action

This fix patch is not upstream, and is applicable only to kernels 6.10
(where the cgroup_rstat_lock tracepoint was added) through 6.15 after
which commit 5da3bfa029d6 ("cgroup: use separate rstat trees for each
subsystem") reordered cgroup_rstat_flush as part of a new feature
addition and inadvertently fixed this UAF.

css_free_rwork_fn first releases the last reference on the cgroup's
kernfs_node, and then calls cgroup_rstat_exit which attempts to use it
in the cgroup_rstat_lock tracepoint:

kernfs_put(cgrp->kn);
cgroup_rstat_exit
  cgroup_rstat_flush
    __cgroup_rstat_lock
      trace_cgroup_rstat_locked:
        TP_fast_assign(
          __entry->root = cgrp->root->hierarchy_id;
          __entry->id = cgroup_id(cgrp);

Where cgroup_id is:
static inline u64 cgroup_id(const struct cgroup *cgrp)
{
	return cgrp->kn->id;
}

Fix this by reordering the kernfs_put after cgroup_rstat_exit.

[78782.605161][ T9861] BUG: KASAN: slab-use-after-free in trace_event_raw_event_cgroup_rstat+0x110/0x1dc
[78782.605182][ T9861] Read of size 8 at addr ffffff890270e610 by task kworker/6:1/9861
[78782.605199][ T9861] CPU: 6 UID: 0 PID: 9861 Comm: kworker/6:1 Tainted: G        W  OE      6.12.23-android16-5-gabaf21382e8f-4k #1 0308449da8ad70d2d3649ae989c1d02f0fbf562c
[78782.605220][ T9861] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[78782.605226][ T9861] Hardware name: Qualcomm Technologies, Inc. Alor QRD + WCN7750 WLAN + Kundu PD2536F_EX (DT)
[78782.605235][ T9861] Workqueue: cgroup_destroy css_free_rwork_fn
[78782.605251][ T9861] Call trace:
[78782.605254][ T9861]  dump_backtrace+0x120/0x170
[78782.605267][ T9861]  show_stack+0x2c/0x40
[78782.605276][ T9861]  dump_stack_lvl+0x84/0xb4
[78782.605286][ T9861]  print_report+0x144/0x7a4
[78782.605301][ T9861]  kasan_report+0xe0/0x140
[78782.605315][ T9861]  __asan_load8+0x98/0xa0
[78782.605329][ T9861]  trace_event_raw_event_cgroup_rstat+0x110/0x1dc
[78782.605339][ T9861]  __traceiter_cgroup_rstat_locked+0x78/0xc4
[78782.605355][ T9861]  __cgroup_rstat_lock+0xe8/0x1dc
[78782.605368][ T9861]  cgroup_rstat_flush_locked+0x7dc/0xaec
[78782.605383][ T9861]  cgroup_rstat_flush+0x34/0x108
[78782.605396][ T9861]  cgroup_rstat_exit+0x2c/0x120
[78782.605409][ T9861]  css_free_rwork_fn+0x504/0xa18
[78782.605421][ T9861]  process_scheduled_works+0x378/0x8e0
[78782.605435][ T9861]  worker_thread+0x5a8/0x77c
[78782.605446][ T9861]  kthread+0x1c4/0x270
[78782.605455][ T9861]  ret_from_fork+0x10/0x20
[78782.605470][ T9861] Allocated by task 2864 on cpu 7 at 78781.564561s:
[78782.605467][    C5] ENHANCE: rpm_suspend+0x93c/0xafc: 0:0:0:0 ret=0
[78782.605481][ T9861]  kasan_save_track+0x44/0x9c
[78782.605497][ T9861]  kasan_save_alloc_info+0x40/0x54
[78782.605507][ T9861]  __kasan_slab_alloc+0x70/0x8c
[78782.605521][ T9861]  kmem_cache_alloc_noprof+0x1a0/0x428
[78782.605534][ T9861]  __kernfs_new_node+0xd4/0x3e4
[78782.605545][ T9861]  kernfs_new_node+0xbc/0x168
[78782.605554][ T9861]  kernfs_create_dir_ns+0x58/0xe8
[78782.605565][ T9861]  cgroup_mkdir+0x25c/0xc9c
[78782.605576][ T9861]  kernfs_iop_mkdir+0x130/0x214
[78782.605586][ T9861]  vfs_mkdir+0x290/0x388
[78782.605599][ T9861]  do_mkdirat+0xfc/0x27c
[78782.605612][ T9861]  __arm64_sys_mkdirat+0x5c/0x78
[78782.605625][ T9861]  invoke_syscall+0x90/0x1e8
[78782.605634][ T9861]  el0_svc_common+0x134/0x168
[78782.605643][ T9861]  do_el0_svc+0x34/0x44
[78782.605652][ T9861]  el0_svc+0x38/0x84
[78782.605667][ T9861]  el0t_64_sync_handler+0x70/0xbc
[78782.605681][ T9861]  el0t_64_sync+0x19c/0x1a0
[78782.605695][ T9861] Freed by task 69 on cpu 1 at 78782.573275s:
[78782.605705][ T9861]  kasan_save_track+0x44/0x9c
[78782.605719][ T9861]  kasan_save_free_info+0x54/0x70
[78782.605729][ T9861]  __kasan_slab_free+0x68/0x8c
[78782.605743][ T9861]  kmem_cache_free+0x118/0x488
[78782.605755][ T9861]  kernfs_free_rcu+0xa0/0xb8
[78782.605765][ T9861]  rcu_do_batch+0x324/0xaa0
[78782.605775][ T9861]  rcu_nocb_cb_kthread+0x388/0x690
[78782.605785][ T9861]  kthread+0x1c4/0x270
[78782.605794][ T9861]  ret_from_fork+0x10/0x20
[78782.605809][ T9861] Last potentially related work creation:
[78782.605814][ T9861]  kasan_save_stack+0x40/0x70
[78782.605829][ T9861]  __kasan_record_aux_stack+0xb0/0xcc
[78782.605839][ T9861]  kasan_record_aux_stack_noalloc+0x14/0x24
[78782.605849][ T9861]  __call_rcu_common+0x54/0x390
[78782.605863][ T9861]  call_rcu+0x18/0x28
[78782.605875][ T9861]  kernfs_put+0x17c/0x28c
[78782.605884][ T9861]  css_free_rwork_fn+0x4f4/0xa18
[78782.605897][ T9861]  process_scheduled_works+0x378/0x8e0
[78782.605910][ T9861]  worker_thread+0x5a8/0x77c
[78782.605923][ T9861]  kthread+0x1c4/0x270
[78782.605932][ T9861]  ret_from_fork+0x10/0x20
[78782.605947][ T9861] The buggy address belongs to the object at ffffff890270e5b0
[78782.605947][ T9861]  which belongs to the cache kernfs_node_cache of size 144
[78782.605957][ T9861] The buggy address is located 96 bytes inside of
[78782.605957][ T9861]  freed 144-byte region [ffffff890270e5b0, ffffff890270e640)

Fixes: fc29e04ae1ad ("cgroup/rstat: add cgroup_rstat_lock helpers and tracepoints")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b8cde3d1cb7b..cb756ee15b6f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5481,9 +5481,9 @@ static void css_free_rwork_fn(struct work_struct *work)
 			 * children.
 			 */
 			cgroup_put(cgroup_parent(cgrp));
-			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
 			cgroup_rstat_exit(cgrp);
+			kernfs_put(cgrp->kn);
 			kfree(cgrp);
 		} else {
 			/*

base-commit: abf529abd660d8ccad46dd8c8f20e93db6134f5f
-- 
2.53.0.rc1.225.gd81095ad13-goog


