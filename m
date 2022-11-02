Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0EA616149
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 11:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKBKzl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 06:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKBKzk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 06:55:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D5411443
        for <cgroups@vger.kernel.org>; Wed,  2 Nov 2022 03:55:40 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667386538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxLD+kWPx3lLvr+vk97jAcOCFNUbHoatvsStYxnpabQ=;
        b=gRdn8Kk+9daT6ZaXRsCbyPCBOrp67oJ0J5Jh49uic6NI2WT2n6UknoWUNGe50PfF3kX9WI
        /6nz6hJwbTPpFf70xBPndo/WoENfMzKSP8CORDHZKTfDaJONpy8AzWYODHwW7nGpTrx4p3
        l9F4/05EGozKhsx82GjCelNq4m2uDtbCIh1zWJ6iOD+Le8bm3pxYh3/BrTfTMo4vmfd4S4
        kwutEUL96HIk1mKBTN3+eWdJ/hfXV9ZFT9eWNIavny6epvI8L+TtK9JhOk7jfJbrSwdusf
        EEXZDU588VCy/qTKAdzoMWt+kUypeiuVecyGX/xknfJ57zG1iwwZl9pyUYxs1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667386538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxLD+kWPx3lLvr+vk97jAcOCFNUbHoatvsStYxnpabQ=;
        b=RHC/NzcwWbpQAmMu3pqEgJN9jPXPlgNOCoxNvDiAXuNNo6AL9pBUMLY9amL2ixmcIEHj8d
        FIoqtrYxUpu10FDw==
To:     cgroups@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 1/2] cpuset: Don't change the cpumask on attach if it is a subset.
Date:   Wed,  2 Nov 2022 11:55:29 +0100
Message-Id: <20221102105530.1795429-2-bigeasy@linutronix.de>
In-Reply-To: <20221102105530.1795429-1-bigeasy@linutronix.de>
References: <20221102105530.1795429-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If a task it attached to a cgroup then its CPU-mask will be set to the
mask of the cgroup. Upon enabling the cpuset controller it will be set
to all online CPUs. All running user tasks, that changed their CPU-mask,
will have their mask altered without knowing it. Tasks with unchanged
CPU-mask are set to all online CPUs and this change is a nop.

If the task is already using a subset of the allowed (new) CPUs, skip
changing the mask. This will preserve the CPU-mask as long as it
contains only allowed CPUs from the new CPU-mask.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cgroup/cpuset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b474289c15b82..8d5126684f9e6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2527,7 +2527,8 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		 * can_attach beforehand should guarantee that this doesn't
 		 * fail.  TODO: have a better way to handle failure here
 		 */
-		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+		if (!cpumask_subset(&task->cpus_mask, cpus_attach))
+			WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
=20
 		cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
 		cpuset_update_task_spread_flag(cs, task);
--=20
2.37.2

