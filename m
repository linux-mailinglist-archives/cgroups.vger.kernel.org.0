Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3C1BE38
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2019 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfEMT4x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 May 2019 15:56:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49856 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbfEMT4x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 May 2019 15:56:53 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DJlbVN001152
        for <cgroups@vger.kernel.org>; Mon, 13 May 2019 12:56:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Q/m7r9oDhbabE7C5gARZpfLLlDj2HaUtKuQrbtPLsyQ=;
 b=iESxXiQh8mb73jrpFI7BpQ+227YydRv6Qyx7giJk6NgY/AibbJqMfp5B9+i5/DFDZmaJ
 xGCKpXW5AcggB98y/MQ6C2KMCqG4Nbiehiql13wiZ92CLvkMRjJqsDEnLv0GZvoYnso+
 zQwnhi7bI0MeWMwGDquYHiMIwQeIOulmK44= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sf94d1fcb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <cgroups@vger.kernel.org>; Mon, 13 May 2019 12:56:52 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 May 2019 12:56:50 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 4F25311FD7D42; Mon, 13 May 2019 12:56:48 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Tejun Heo <tj@kernel.org>
CC:     Oleg Nesterov <oleg@redhat.com>, Alex Xu <alex_y_xu@yahoo.ca>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] signal: don't always leave task frozen after ptrace_stop()
Date:   Mon, 13 May 2019 12:55:17 -0700
Message-ID: <20190513195517.2289671-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=352 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130133
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The ptrace_stop() function contains the cgroup_enter_frozen() call,
but no cgroup_leave_frozen(). When ptrace_stop() is called from the
do_jobctl_trap() path, it's correct, because corresponding
cgroup_leave_frozen() calls in get_signal() will guarantee that
the task won't leave the signal handler loop frozen.

However, if ptrace_stop() is called from ptrace_signal() or
ptrace_notify(), there is no such guarantee, and the task may leave
with the frozen bit set.

It leads to the regression, reported by Alex Xu. Write system call
gets mistakenly interrupted by fake TIF_SIGPENDING, which is set
by recalc_sigpending_tsk() because of the set frozen bit.

The regression can be reproduced by stracing the following simple
program:

  #include <unistd.h>

  int main() {
      write(1, "a", 1);
      return 0;
  }

An attempt to run strace ./a.out leads to the infinite loop:
  [ pre-main omitted ]
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  [ repeats forever ]

With this patch applied, it works as expected:
  [ pre-main omitted ]
  write(1, "a", 1)                        = 1
  exit_group(0)                           = ?
  +++ exited with 0 +++

Reported-by: Alex Xu <alex_y_xu@yahoo.ca>
Fixes: 76f969e8948d ("cgroup: cgroup v2 freezer")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
---
 kernel/signal.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8607b11ff936..f12abbda4c4b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2016,7 +2016,8 @@ static bool sigkill_pending(struct task_struct *tsk)
  * If we actually decide not to stop at all because the tracer
  * is gone, we keep current->exit_code unless clear_code.
  */
-static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t *info)
+static void ptrace_stop(int exit_code, int why, int clear_code,
+			kernel_siginfo_t *info, bool may_remain_frozen)
 	__releases(&current->sighand->siglock)
 	__acquires(&current->sighand->siglock)
 {
@@ -2112,6 +2113,8 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		preempt_enable_no_resched();
 		cgroup_enter_frozen();
 		freezable_schedule();
+		if (!may_remain_frozen)
+			cgroup_leave_frozen(true);
 	} else {
 		/*
 		 * By the time we got the lock, our tracer went away.
@@ -2152,7 +2155,8 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 	recalc_sigpending_tsk(current);
 }
 
-static void ptrace_do_notify(int signr, int exit_code, int why)
+static void ptrace_do_notify(int signr, int exit_code, int why,
+			     bool may_remain_frozen)
 {
 	kernel_siginfo_t info;
 
@@ -2163,7 +2167,7 @@ static void ptrace_do_notify(int signr, int exit_code, int why)
 	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
 
 	/* Let the debugger run.  */
-	ptrace_stop(exit_code, why, 1, &info);
+	ptrace_stop(exit_code, why, 1, &info, may_remain_frozen);
 }
 
 void ptrace_notify(int exit_code)
@@ -2173,7 +2177,7 @@ void ptrace_notify(int exit_code)
 		task_work_run();
 
 	spin_lock_irq(&current->sighand->siglock);
-	ptrace_do_notify(SIGTRAP, exit_code, CLD_TRAPPED);
+	ptrace_do_notify(SIGTRAP, exit_code, CLD_TRAPPED, false);
 	spin_unlock_irq(&current->sighand->siglock);
 }
 
@@ -2328,10 +2332,10 @@ static void do_jobctl_trap(void)
 			signr = SIGTRAP;
 		WARN_ON_ONCE(!signr);
 		ptrace_do_notify(signr, signr | (PTRACE_EVENT_STOP << 8),
-				 CLD_STOPPED);
+				 CLD_STOPPED, true);
 	} else {
 		WARN_ON_ONCE(!signr);
-		ptrace_stop(signr, CLD_STOPPED, 0, NULL);
+		ptrace_stop(signr, CLD_STOPPED, 0, NULL, true);
 		current->exit_code = 0;
 	}
 }
@@ -2385,7 +2389,7 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
 	 * comment in dequeue_signal().
 	 */
 	current->jobctl |= JOBCTL_STOP_DEQUEUED;
-	ptrace_stop(signr, CLD_TRAPPED, 0, info);
+	ptrace_stop(signr, CLD_TRAPPED, 0, info, false);
 
 	/* We're back.  Did the debugger cancel the sig?  */
 	signr = current->exit_code;
-- 
2.20.1

