Return-Path: <cgroups+bounces-13740-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Dv3Blv9hWnUIwQAu9opvQ
	(envelope-from <cgroups+bounces-13740-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 15:40:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 937E9FF16A
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 15:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19F9930065DE
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF55421888;
	Fri,  6 Feb 2026 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxlPvTUb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DC341C2E0
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388817; cv=none; b=TvvEUL+XCje13g+zwTEU81NKLzZESxa70Gkt6sSHkBgz4hiCN5fyKwB7Ty0pLsEsBlHdOqEx62xAw5py74Vn2V4ce/aQmtXteVZHE5HtqQv6vofPaqGIF6w0PFFa9o4ieHHWBUodnLaTWU6JIaJzazTg4LVCzmLDeWyVzUUW++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388817; c=relaxed/simple;
	bh=674iJzfGbFsX2qbg3ceilngtOic4gGutdvqYvY0LB34=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TUx6mvAXvCGNG78MYukugHQuqo6VZDIY1PLVAul5fRGeWjq6MwpurBD0Gn/3hUTDu2+nwliysgpd1fz+kVnGXo1NfljHt4OFUEVQStABWP+0YQlPaXbRpQUDO7amkuURYZDrjaiBQWAxOB34p8JW5gAnZyPziN6vSgJi/P4CtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxlPvTUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770388816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fEOvqcoh1Fhr9YWKofxCBfvK5qH5BMzdkv72N1ftR1w=;
	b=QxlPvTUbfiLgDH9WB/xoUOgYDlwXe0MXskg87fr8gSI2PxpvZUTnBlEid+loVMYV1ziwl7
	0h3WSPd/N+49NyaB82iDCBQFELO3vogk/5Chj2fD9joU0dQ3n81QaScY9P1mjKthiOvhHk
	vXrLZiWW5u5EsQ3glYn2zajbALrfdW4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-xgRGpuo7OGSRD_FKQvVXFw-1; Fri,
 06 Feb 2026 09:40:12 -0500
X-MC-Unique: xgRGpuo7OGSRD_FKQvVXFw-1
X-Mimecast-MFC-AGG-ID: xgRGpuo7OGSRD_FKQvVXFw_1770388810
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF7461955DC2;
	Fri,  6 Feb 2026 14:40:09 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.22.74.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A09A918004AD;
	Fri,  6 Feb 2026 14:40:07 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id A63C641D2D126; Fri,  6 Feb 2026 11:39:20 -0300 (-03)
Message-ID: <20260206143741.525190180@redhat.com>
User-Agent: quilt/0.66
Date: Fri, 06 Feb 2026 11:34:31 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 1/4] Introducing qpw_lock() and per-cpu queue & flush work
References: <20260206143430.021026873@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13740-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linux.com,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 937E9FF16A
X-Rspamd-Action: no action

Some places in the kernel implement a parallel programming strategy
consisting on local_locks() for most of the work, and some rare remote
operations are scheduled on target cpu. This keeps cache bouncing low since
cacheline tends to be mostly local, and avoids the cost of locks in non-RT
kernels, even though the very few remote operations will be expensive due
to scheduling overhead.

On the other hand, for RT workloads this can represent a problem:
scheduling work on remote cpu that are executing low latency tasks
is undesired and can introduce unexpected deadline misses.

It's interesting, though, that local_lock()s in RT kernels become
spinlock(). We can make use of those to avoid scheduling work on a remote
cpu by directly updating another cpu's per_cpu structure, while holding
it's spinlock().

In order to do that, it's necessary to introduce a new set of functions to
make it possible to get another cpu's per-cpu "local" lock (qpw_{un,}lock*)
and also the corresponding queue_percpu_work_on() and flush_percpu_work()
helpers to run the remote work.

Users of non-RT kernels but with low latency requirements can select
similar functionality by using the CONFIG_QPW compile time option.

On CONFIG_QPW disabled kernels, no changes are expected, as every
one of the introduced helpers work the exactly same as the current
implementation:
qpw_{un,}lock*()        ->  local_{un,}lock*() (ignores cpu parameter)
queue_percpu_work_on()  ->  queue_work_on()
flush_percpu_work()     ->  flush_work()

For QPW enabled kernels, though, qpw_{un,}lock*() will use the extra
cpu parameter to select the correct per-cpu structure to work on,
and acquire the spinlock for that cpu.

queue_percpu_work_on() will just call the requested function in the current
cpu, which will operate in another cpu's per-cpu object. Since the
local_locks() become spinlock()s in QPW enabled kernels, we are
safe doing that.

flush_percpu_work() then becomes a no-op since no work is actually
scheduled on a remote cpu.

Some minimal code rework is needed in order to make this mechanism work:
The calls for local_{un,}lock*() on the functions that are currently
scheduled on remote cpus need to be replaced by qpw_{un,}lock_n*(), so in
QPW enabled kernels they can reference a different cpu. It's also
necessary to use a qpw_struct instead of a work_struct, but it just
contains a work struct and, in CONFIG_QPW, the target cpu.

This should have almost no impact on non-CONFIG_QPW kernels: few
this_cpu_ptr() will become per_cpu_ptr(,smp_processor_id()).

On CONFIG_QPW kernels, this should avoid deadlines misses by
removing scheduling noise.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   10 +
 Documentation/locking/qpwlocks.rst              |   63 +++++++
 MAINTAINERS                                     |    6 
 include/linux/qpw.h                             |  190 ++++++++++++++++++++++++
 init/Kconfig                                    |   35 ++++
 kernel/Makefile                                 |    2 
 kernel/qpw.c                                    |   26 +++
 7 files changed, 332 insertions(+)
 create mode 100644 include/linux/qpw.h
 create mode 100644 kernel/qpw.c

Index: slab/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- slab.orig/Documentation/admin-guide/kernel-parameters.txt
+++ slab/Documentation/admin-guide/kernel-parameters.txt
@@ -2819,6 +2819,16 @@ Kernel parameters
 
 			The format of <cpu-list> is described above.
 
+	qpw=		[KNL,SMP] Select a behavior on per-CPU resource sharing
+			and remote interference mechanism on a kernel built with
+			CONFIG_QPW.
+			Format: { "0" | "1" }
+			0 - local_lock() + queue_work_on(remote_cpu)
+			1 - spin_lock() for both local and remote operations
+
+			Selecting 1 may be interesting for systems that want
+			to avoid interruption & context switches from IPIs.
+
 	iucv=		[HW,NET]
 
 	ivrs_ioapic	[HW,X86-64]
Index: slab/MAINTAINERS
===================================================================
--- slab.orig/MAINTAINERS
+++ slab/MAINTAINERS
@@ -21291,6 +21291,12 @@ F:	Documentation/networking/device_drive
 F:	drivers/bus/fsl-mc/
 F:	include/uapi/linux/fsl_mc.h
 
+QPW
+M:	Leonardo Bras <leobras@redhat.com>
+S:	Supported
+F:	include/linux/qpw.h
+F:	kernel/qpw.c
+
 QT1010 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
Index: slab/include/linux/qpw.h
===================================================================
--- /dev/null
+++ slab/include/linux/qpw.h
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_QPW_H
+#define _LINUX_QPW_H
+
+#include "linux/spinlock.h"
+#include "linux/local_lock.h"
+#include "linux/workqueue.h"
+
+#ifndef CONFIG_QPW
+
+typedef local_lock_t qpw_lock_t;
+typedef local_trylock_t qpw_trylock_t;
+
+struct qpw_struct {
+	struct work_struct work;
+};
+
+#define qpw_lock_init(lock)			\
+	local_lock_init(lock)
+
+#define qpw_trylock_init(lock)			\
+	local_trylock_init(lock)
+
+#define qpw_lock(lock, cpu)			\
+	local_lock(lock)
+
+#define qpw_lock_irqsave(lock, flags, cpu)	\
+	local_lock_irqsave(lock, flags)
+
+#define qpw_trylock(lock, cpu)			\
+	local_trylock(lock)
+
+#define qpw_trylock_irqsave(lock, flags, cpu)	\
+	local_trylock_irqsave(lock, flags)
+
+#define qpw_unlock(lock, cpu)			\
+	local_unlock(lock)
+
+#define qpw_unlock_irqrestore(lock, flags, cpu)	\
+	local_unlock_irqrestore(lock, flags)
+
+#define qpw_lockdep_assert_held(lock)		\
+	lockdep_assert_held(lock)
+
+#define queue_percpu_work_on(c, wq, qpw)	\
+	queue_work_on(c, wq, &(qpw)->work)
+
+#define flush_percpu_work(qpw)			\
+	flush_work(&(qpw)->work)
+
+#define qpw_get_cpu(qpw)	smp_processor_id()
+
+#define qpw_is_cpu_remote(cpu)		(false)
+
+#define INIT_QPW(qpw, func, c)			\
+	INIT_WORK(&(qpw)->work, (func))
+
+#else /* CONFIG_QPW */
+
+DECLARE_STATIC_KEY_MAYBE(CONFIG_QPW_DEFAULT, qpw_sl);
+
+typedef union {
+	spinlock_t sl;
+	local_lock_t ll;
+} qpw_lock_t;
+
+typedef union {
+	spinlock_t sl;
+	local_trylock_t ll;
+} qpw_trylock_t;
+
+struct qpw_struct {
+	struct work_struct work;
+	int cpu;
+};
+
+#define qpw_lock_init(lock)								\
+	do {										\
+		if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl))			\
+			spin_lock_init(lock.sl);					\
+		else									\
+			local_lock_init(lock.ll);					\
+	} while (0)
+
+#define qpw_trylock_init(lock)								\
+	do {										\
+		if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl))			\
+			spin_lock_init(lock.sl);					\
+		else									\
+			local_trylock_init(lock.ll);					\
+	} while (0)
+
+#define qpw_lock(lock, cpu)								\
+	do {										\
+		if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl))			\
+			spin_lock(per_cpu_ptr(lock.sl, cpu));				\
+		else									\
+			local_lock(lock.ll);						\
+	} while (0)
+
+#define qpw_lock_irqsave(lock, flags, cpu)						\
+	do {										\
+		if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl))			\
+			spin_lock_irqsave(per_cpu_ptr(lock.sl, cpu), flags);		\
+		else									\
+			local_lock_irqsave(lock.ll, flags);				\
+	} while (0)
+
+#define qpw_trylock(lock, cpu)								\
+	({										\
+		int t;									\
+		if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl))			\
+			t = spin_trylock(per_cpu_ptr(lock.sl, cpu));			\
+		else									\
+			t = local_trylock(lock.ll);					\
+		t;									\
+	})
+
+#define qpw_trylock_irqsave(lock, flags, cpu)						\
+	({										\
+		int t;									\
+		if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl))			\
+			t = spin_trylock_irqsave(per_cpu_ptr(lock.sl, cpu), flags);	\
+		else									\
+			t = local_trylock_irqsave(lock.ll, flags);			\
+		t;									\
+	})
+
+#define qpw_unlock(lock, cpu)								\
+	do {										\
+		if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl)) {			\
+			spin_unlock(per_cpu_ptr(lock.sl, cpu));				\
+		} else {								\
+			local_unlock(lock.ll);						\
+		}									\
+	} while (0)
+
+#define qpw_unlock_irqrestore(lock, flags, cpu)						\
+	do {										\
+		if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl))			\
+			spin_unlock_irqrestore(per_cpu_ptr(lock.sl, cpu), flags);	\
+		else									\
+			local_unlock_irqrestore(lock.ll, flags);			\
+	} while (0)
+
+#define qpw_lockdep_assert_held(lock)							\
+	do {										\
+		if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl))			\
+			lockdep_assert_held(this_cpu_ptr(lock.sl));			\
+		else									\
+			lockdep_assert_held(this_cpu_ptr(lock.ll));			\
+	} while (0)
+
+#define queue_percpu_work_on(c, wq, qpw)						\
+	do {										\
+		int __c = c;								\
+		struct qpw_struct *__qpw = (qpw);					\
+		if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl)) {			\
+			WARN_ON((__c) != __qpw->cpu);					\
+			__qpw->work.func(&__qpw->work);					\
+		} else {								\
+			queue_work_on(__c, wq, &(__qpw)->work);				\
+		}									\
+	} while (0)
+
+/*
+ * Does nothing if QPW is set to use spinlock, as the task is already done at the
+ * time queue_percpu_work_on() returns.
+ */
+#define flush_percpu_work(qpw)								\
+	do {										\
+		struct qpw_struct *__qpw = (qpw);					\
+		if (!static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl)) {		\
+			flush_work(&__qpw->work);					\
+		}									\
+	} while (0)
+
+#define qpw_get_cpu(w)			container_of((w), struct qpw_struct, work)->cpu
+
+#define qpw_is_cpu_remote(cpu)		((cpu) != smp_processor_id())
+
+#define INIT_QPW(qpw, func, c)								\
+	do {										\
+		struct qpw_struct *__qpw = (qpw);					\
+		INIT_WORK(&__qpw->work, (func));					\
+		__qpw->cpu = (c);							\
+	} while (0)
+
+#endif /* CONFIG_QPW */
+#endif /* LINUX_QPW_H */
Index: slab/init/Kconfig
===================================================================
--- slab.orig/init/Kconfig
+++ slab/init/Kconfig
@@ -747,6 +747,41 @@ config CPU_ISOLATION
 
 	  Say Y if unsure.
 
+config QPW
+	bool "Queue per-CPU Work"
+	depends on SMP || COMPILE_TEST
+	default n
+	help
+	  Allow changing the behavior on per-CPU resource sharing with cache,
+	  from the regular local_locks() + queue_work_on(remote_cpu) to using
+	  per-CPU spinlocks on both local and remote operations.
+
+	  This is useful to give user the option on reducing IPIs to CPUs, and
+	  thus reduce interruptions and context switches. On the other hand, it
+	  increases generated code and will use atomic operations if spinlocks
+	  are selected.
+
+	  If set, will use the default behavior set in QPW_DEFAULT unless boot
+	  parameter qpw is passed with a different behavior.
+
+	  If unset, will use the local_lock() + queue_work_on() strategy,
+	  regardless of the boot parameter or QPW_DEFAULT.
+
+	  Say N if unsure.
+
+config QPW_DEFAULT
+	bool "Use per-CPU spinlocks by default"
+	depends on QPW
+	default n
+	help
+	  If set, will use per-CPU spinlocks as default behavior for per-CPU
+	  remote operations.
+
+	  If unset, will use local_lock() + queue_work_on(cpu) as default
+	  behavior for remote operations.
+
+	  Say N if unsure
+
 source "kernel/rcu/Kconfig"
 
 config IKCONFIG
Index: slab/kernel/Makefile
===================================================================
--- slab.orig/kernel/Makefile
+++ slab/kernel/Makefile
@@ -140,6 +140,8 @@ obj-$(CONFIG_WATCH_QUEUE) += watch_queue
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
+obj-$(CONFIG_QPW) += qpw.o
+
 CFLAGS_kstack_erase.o += $(DISABLE_KSTACK_ERASE)
 CFLAGS_kstack_erase.o += $(call cc-option,-mgeneral-regs-only)
 obj-$(CONFIG_KSTACK_ERASE) += kstack_erase.o
Index: slab/kernel/qpw.c
===================================================================
--- /dev/null
+++ slab/kernel/qpw.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "linux/export.h"
+#include <linux/sched.h>
+#include <linux/qpw.h>
+#include <linux/string.h>
+
+DEFINE_STATIC_KEY_MAYBE(CONFIG_QPW_DEFAULT, qpw_sl);
+EXPORT_SYMBOL(qpw_sl);
+
+static int __init qpw_setup(char *str)
+{
+	int opt;
+
+	if (!get_option(&str, &opt)) {
+		pr_warn("QPW: invalid qpw parameter: %s, ignoring.\n", str);
+		return 0;
+	}
+
+	if (opt)
+		static_branch_enable(&qpw_sl);
+	else
+		static_branch_disable(&qpw_sl);
+
+	return 0;
+}
+__setup("qpw=", qpw_setup);
Index: slab/Documentation/locking/qpwlocks.rst
===================================================================
--- /dev/null
+++ slab/Documentation/locking/qpwlocks.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========
+QPW locks
+=========
+
+Some places in the kernel implement a parallel programming strategy
+consisting on local_locks() for most of the work, and some rare remote
+operations are scheduled on target cpu. This keeps cache bouncing low since
+cacheline tends to be mostly local, and avoids the cost of locks in non-RT
+kernels, even though the very few remote operations will be expensive due
+to scheduling overhead.
+
+On the other hand, for RT workloads this can represent a problem:
+scheduling work on remote cpu that are executing low latency tasks
+is undesired and can introduce unexpected deadline misses.
+
+QPW locks help to convert sites that use local_locks (for cpu local operations)
+and queue_work_on (for queueing work remotely, to be executed
+locally on the owner cpu of the lock) to QPW locks.
+
+The lock is declared qpw_lock_t type.
+The lock is initialized with qpw_lock_init.
+The lock is locked with qpw_lock (takes a lock and cpu as a parameter).
+The lock is unlocked with qpw_unlock (takes a lock and cpu as a parameter).
+
+The qpw_lock_irqsave function disables interrupts and saves current interrupt state,
+cpu as a parameter.
+
+For trylock variant, there is the qpw_trylock_t type, initialized with
+qpw_trylock_init. Then the corresponding qpw_trylock and
+qpw_trylock_irqsave.
+
+work_struct should be replaced by qpw_struct, which contains a cpu parameter
+(owner cpu of the lock), initialized by INIT_QPW.
+
+The queue work related functions (analogous to queue_work_on and flush_work) are:
+queue_percpu_work_on and flush_percpu_work.
+
+The behaviour of the QPW functions is as follows:
+
+* !CONFIG_PREEMPT_RT and !CONFIG_QPW (or CONFIG_QPW and qpw=off kernel
+boot parameter):
+        - qpw_lock:                     local_lock
+        - qpw_lock_irqsave:             local_lock_irqsave
+        - qpw_trylock:                  local_trylock
+        - qpw_trylock_irqsave:          local_trylock_irqsave
+        - qpw_unlock:                   local_unlock
+        - queue_percpu_work_on:         queue_work_on
+        - flush_percpu_work:            flush_work
+
+* CONFIG_PREEMPT_RT or CONFIG_QPW (and CONFIG_QPW_DEFAULT or qpw=on kernel
+boot parameter),
+        - qpw_lock:                     spin_lock
+        - qpw_lock_irqsave:             spin_lock_irqsave
+        - qpw_trylock:                  spin_trylock
+        - qpw_trylock_irqsave:          spin_trylock_irqsave
+        - qpw_unlock:                   spin_unlock
+        - queue_percpu_work_on:         executes work function on caller cpu
+        - flush_percpu_work:            empty
+
+qpw_get_cpu(work_struct), to be called from within qpw work function,
+returns the target cpu.



