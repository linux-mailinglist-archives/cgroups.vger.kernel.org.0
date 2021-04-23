Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70F9369816
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 19:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243329AbhDWROi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 13:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243282AbhDWROh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 23 Apr 2021 13:14:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30184613CD;
        Fri, 23 Apr 2021 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619198040;
        bh=ESTVrCw7TotbBwAMIwQqPUQhO6lqCc7NXv3caGsjfiI=;
        h=From:To:Cc:Subject:Date:From;
        b=kQMJwsKSAt/b4uHWRFc39CifpV22TDGhTbP5wrp1ERadJUkr7SyrbDB7Ex4ddnFT2
         sILUo/6Qnk9zG9p222tibIyJvaoQWSS++mdFTIvT6iMa09WTu3SeA+Zfi7Y3IhS8Wn
         ShSK9fDLofX6PGEQCm5MsvqHh7Wd1/hD9Wl2i6q9WxP/MaG3EQMY1RliRHKyM4cis1
         B5SW0CrOUfpdxsg0Q6WD8GBVF1eYNUTdxfezHdrfDu/SfFfySW7h7Pll1IPrryEPWh
         dRrkK/kWMkQaYMMKCNNEySfRK/xtrKeZCd4PaOWi3j4otlOk0pjKHVAlApbg9QS8Mg
         +H/4lrtlW9c4Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [RFC PATCH] cgroup: add cgroup.signal
Date:   Fri, 23 Apr 2021 19:13:51 +0200
Message-Id: <20210423171351.3614430-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=I4u9XblrLcECnka6FpVaFIsFqgVvn6HiGYChpF0c1Q8=; m=alVyCiG2ucAu2ebPjQ7rdbjv1TXuuYolfWGSHSIbb/g=; p=tUcHmFzcLtmGzU9EJMa17PX6wA5yrOse4LQk4co6cZY=; g=16d5043ef0d8ae344dfcd2b5741a5d1d5ce39d15
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYIMAPwAKCRCRxhvAZXjcopYUAP4txHg t46CGEDlIx5Pm6w1l+n+IPO0fB+eb3NcQxfLoUAEAzTs2XAbQWgDiLaMSeAdglsI3IL7frtGMR3kc JSmi6wY=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Introduce a new cgroup.signal file which is available in non-root
cgroups and allows to send signals to cgroups. As with all new cgroup
features this is recursive by default. This first implementation is
restricted to sending SIGKILL with the possibility to be extended to
other signals in the future which I think is very likely.

There are various use-cases of this interface. In container-land
assuming a conservative layout where a container is treated as a
separate machine each container usually has a delegated cgroup.

This means there is a 1:1 mapping between container and cgroup. If the
container in addition uses a separate pid namespace then killing a
container becomes a simple kill -9 <container-init-pid> from an ancestor
pid namespace.

However, there are quite a few scenarios where that isn't true. For
example, there are containers that share the cgroup with other processes
on purpose that are supposed to be bound to the lifetime of the
container but are not in the same pidns of the container. Containers
that are in a delegated cgroup but share the pid namespace with the host
or other containers.

Other use-cases arise for service management in systemd and potentially
userspace oom implementations.

I'm honestly a bit worried because this patch feels way to
straightforward right now and I've been holding it back because I fear I
keep missing obvious problems. In any case, here are the semantics and
the corner-cases that came to my mind and how I reasoned about them:
- Signals are specified by writing the signal number into cgroup.signal.
  An alternative would be to allow writing the signal name but I don't
  think that's worth it. Callers like systemd can easily do a snprintf()
  with the signal's define/enum.
- Since signaling is a one-time event and we're holding cgroup_mutex()
  as we do for freezer we don't need to worry about tasks joining the
  cgroup while we're signaling the cgroup. Freezer needed to care about
  this because a task could join or leave frozen/non-frozen cgroups.
  Since we only support SIGKILL currently and SIGKILL works for frozen
  tasks there's also not significant interaction with frozen cgroups.
- Since signaling leads to an event and not a state change the
  cgroup.signal file is write-only.
- Since we currently only support SIGKILL we don't need to generate a
  separate notification and can rely on the unpopulated notification
  meachnism. If we support more signals we can introduce a separate
  notification in cgroup.events.
- We skip signaling kthreads this also means a cgroup that has a kthread
  but receives a SIGKILL signal will not become empty and consequently
  no populated event will be generated. This could potentially be
  handled if we were to generate an event whenever we are finished
  sending a signal. I'm not sure that's worth it.
- Freezer doesn't care about tasks in different pid namespaces, i.e. if
  you have two tasks in different pid namespaces the cgroup would still
  be frozen.
  The cgroup.signal mechanism should consequently behave the same way,
  i.e.  signal all processes and ignore in which pid namespace they
  exist. This would obviously mean that if you e.g. had a task from an
  ancestor pid namespace join a delegated cgroup of a container in a
  child pid namespace the container can kill that task. But I think this
  is fine and actually the semantics we want since the cgroup has been
  delegated.
- It is currently not possible to signal tasks in ancestor or sibling
  pid namespaces with regular singal APIs. This is not even possible
  with pidfds right now as I've added a check access_pidfd_pidns() which
  verifies that the task to be signaled is in the same or a descendant
  pid namespace as the caller. However, with cgroup.signal this would be
  possible whenever a task lives in a cgroup that is delegated to a
  caller in an ancestor or sibling pid namespace.
- SIGKILLing a task that is PID 1 in a pid namespace which is
  located in a delegated cgroup but which has children in non-delegated
  cgroups (further up the hierarchy for example) would necessarily cause
  those children to die too.
- We skip signaling tasks that already have pending fatal signals.
- If we are located in a cgroup that is going to get SIGKILLed we'll be
  SIGKILLed as well which is fine and doesn't require us to do anything
  special.
- We're holding the read-side of tasklist lock while we're signaling
  tasks. That seems fine since kill(-1, SIGKILL) holds the read-side
  of tasklist lock walking all processes and is a way for unprivileged
  users to trigger tasklist lock being held for a long time. In contrast
  it would require a delegated cgroup with lots of processes and a deep
  hierarchy to allow for something similar with this interface.

Fwiw, in addition to the system manager and container use-cases I think
this has the potential to be picked up by the "kill" tool. In the future
I'd hope we can do: kill -9 --cgroup /sys/fs/cgroup/delegated

Once we see this is a feasible direction and I haven't missed a bunch of
obvious problems I'll add proper tests and send out a non-RFC version of
this patch. Manual testing indicates it works as expected.

Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: cgroups@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/cgroup/cgroup.c | 75 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9153b20e5cc6..fff90e0bf5ae 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3654,6 +3654,76 @@ static ssize_t cgroup_freeze_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static void __cgroup_signal(struct cgroup *cgrp, int signr)
+{
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	css_task_iter_start(&cgrp->self, 0, &it);
+	while ((task = css_task_iter_next(&it))) {
+		/* Ignore kernel threads here. */
+		if (task->flags & PF_KTHREAD)
+			continue;
+
+		/* Skip dying tasks. */
+		if (__fatal_signal_pending(task))
+			continue;
+
+		send_sig(signr, task, 0);
+	}
+	css_task_iter_end(&it);
+}
+
+static void cgroup_signal(struct cgroup *cgrp, int signr)
+{
+	struct cgroup_subsys_state *css;
+	struct cgroup *dsct;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	/*
+	 * Propagate changes downwards the cgroup tree.
+	 */
+	read_lock(&tasklist_lock);
+	css_for_each_descendant_pre(css, &cgrp->self) {
+		dsct = css->cgroup;
+
+		if (cgroup_is_dead(dsct))
+			continue;
+
+		__cgroup_signal(dsct, signr);
+	}
+	read_unlock(&tasklist_lock);
+}
+
+static ssize_t cgroup_signal_write(struct kernfs_open_file *of, char *buf,
+				   size_t nbytes, loff_t off)
+{
+	struct cgroup *cgrp;
+	ssize_t ret;
+	int signr;
+
+	ret = kstrtoint(strstrip(buf), 0, &signr);
+	if (ret)
+		return ret;
+
+	/* Only allow SIGKILL for now. */
+	if (signr != SIGKILL)
+		return -EINVAL;
+
+	cgrp = cgroup_kn_lock_live(of->kn, false);
+	if (!cgrp)
+		return -ENOENT;
+
+	cgroup_signal(cgrp, signr);
+
+	cgroup_kn_unlock(of->kn);
+
+	return nbytes;
+}
+
 static int cgroup_file_open(struct kernfs_open_file *of)
 {
 	struct cftype *cft = of_cft(of);
@@ -4846,6 +4916,11 @@ static struct cftype cgroup_base_files[] = {
 		.seq_show = cgroup_freeze_show,
 		.write = cgroup_freeze_write,
 	},
+	{
+		.name = "cgroup.signal",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.write = cgroup_signal_write,
+	},
 	{
 		.name = "cpu.stat",
 		.seq_show = cpu_stat_show,

base-commit: d434405aaab7d0ebc516b68a8fc4100922d7f5ef
-- 
2.27.0

