Return-Path: <cgroups+bounces-3186-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C4908243
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 05:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616F2284D23
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 03:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0E145323;
	Fri, 14 Jun 2024 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gFAj1zhz"
X-Original-To: cgroups@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF64118307A;
	Fri, 14 Jun 2024 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334118; cv=none; b=rORWeOd6VrwbgXZ1kEWCbtun9zZCtmw+kJQ1fE1Y5RTTiYg6nu/JH+/C/wNLAiNlTrfHwRLISFUFounHX3ID4p+xrbA3xCza8rwKdDBpWoH/Z1aA6TUsWT0E75VZPGFPLTUR6NFI9tT/gwBOV8Fccwwxti65go75QkbmNupEsEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334118; c=relaxed/simple;
	bh=fZkL8/N0Qrpf6UZl+375BkCSZcaQ8OEmN0T9VaL5fJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bSFlUWZ0kOS4iI0ZOA0lPTPC3OBG32gootJjyoTWlnScn04qWXPZJtGnPecS97QwFOEy5v0ZhMrKi9+SrdFVYVRYjBKvHZylojMbsb0IXstsydMZdcu7G9TvbTDXn2JiHmWG862xls8roKW+i/xaTeWrzBxANgRgLgAw8py7iKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gFAj1zhz; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=rDpTaBvyHd6bNpZrRPSRtHW8SN7lFV/WuSCT3A7Nn+Q=;
	b=gFAj1zhzSF8SgiQyHgQ7kUR5rFa1Ti3e9IFGizES8RuDPfJnqNlKvXd6s0HBlu
	bI1/8wAgz83xdSDG43iD1EfjthlMu11F/TUb1lCKiyVP5EPAUvlx6v6Aq6m7ZqMD
	xxTEX2RUNuJ1ke0j0+X7QI3UPi9NRZmrOMlqLfE7AID/M=
Received: from localhost.localdomain (unknown [222.20.94.23])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3v314smtmMheHAA--.27463S2;
	Fri, 14 Jun 2024 11:01:13 +0800 (CST)
From: xz <15086729272@163.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangzhi.lwj@antgroup.com,
	lizhi16@hust.edu.cn,
	zhenxu <15086729272@163.com>
Subject: [PATCH] cgroup: bridge namespaces and cgroups
Date: Fri, 14 Jun 2024 11:01:11 +0800
Message-Id: <20240614030111.26945-1-15086729272@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v314smtmMheHAA--.27463S2
X-Coremail-Antispam: 1Uf129KBjvAXoWDCF4DJw1rJr4UCryUGr4UJwb_yoWxXFW3Wo
	WIvFs0vr1kXr18JrW8CF93Ja98uaykG398Ar45ZFZI93WFv3yYgry7Cay5XF13XF4Svr43
	Ar4Sq3WrJF48Jas5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRrb1UUUUUU
X-CM-SenderInfo: bprvimiwxsmjixs6il2tof0z/1tbiMRr9VmVODoyXDAAAsy

From: zhenxu <15086729272@163.com>

For an individual container, the creation and destruction of its namespaces and cgroups are synchronous. Upon the container’s termination, the resources allocated in this container will be released following the destruction of the related namespace, while the accounting of those resources is canceled as the container’s cgroup destroys.

Nonetheless, namespace sharing disrupts this synchrony. When a container shares its namespace with other entities (containers or the host), the termination of this container does not destroy the shared namespace, which continues to be sustained by those entities. Moreover, the resources created by the terminated container are also maintained within this namespace and can be used by other entities sharing the same namespace. Nevertheless, the container’s cgroup, which records and limits these resources, is destroyed when the container exits. As a result, repeatedly restarting the container and requesting resources within that namespace can bypass the cgroup limitations, allowing the theft or exhaustion of certain resources.

Here, we list all the resources that can be exploited: shared memory (IPC namespace), semaphores (IPC namespace), message queues (IPC namespace), network devices (NET namespace), pid (PID namespace). To defend the attacks, we propose this patch. This patch bridges the namespace and the cgroups by placing a cgroup tag on all the resources mentioned above except the pid. These tags identify which cgroup is responsible for charging and restricting these resources. Furthermore, this tag can be used to identify the residual resources which should be prevented from getting rid of the restrictions after the cgroup’s exit.

To re-manage these residual resources., this patch creates a balloon cgroup specifically for limiting these residual resources. First, resources requested by each container are tagged with the cgroup of that container. When a cgroup is about to be destroyed, the patch will reclaim the resources and transfer all the resources and their records to the balloon cgroup. Later, when a container reuses these resources, the residual resources become owned by the container in need, are tagged and governed by the container’s cgroup, and removed from the balloon cgroup. Specially, this patch finishes the following things:

1). Connecting namespaces and cgroup. extend the cgroup structure by integrating 3 linked lists, each designed to store pointers to a particular namespace. Each pointer in the list points to the namespace corresponding to the processes contained in the current cgroup. These linked-lists serve the function of tracking the instances tied to specific types of namespaces such as IPC, network, and PID namespaces.

2). Associating virtual resources to the cgroup. To accurately identify the resources connected to this cgroup instance. This patch adds a member to the structures of all isolated virtual resources mentioned above with a cgroup tag that corresponds to the cgroup instance.

3) Balloon cgroup initialization and configuration. This patch sets a universal balloon cgroup for all namespace instances and adds a global variable pointing to it. A Max_Limit can be set by the system administrator to ensure that the sum of residual resources across all containers within the system does not exceed this threshold. Then, a Dynamic_Limit is set on the balloon cgroup, whose value is the highest configured cgroup’s limit among the ones of cgroups that are destroyed. The balloon cgroup dynamically adjusts its resource limits to the lower one between Max_Limit and Dynamic_Limit.

4) Reassigning usable resources. The resources that are shared between the containers through a sharing namespace are transformed to the balloon cgroup and tagged as residual resources when the container exits. When these residual resources are reused, they will be transformed to the cgroup of the user.

5) Freeing expired resources. When the addition of new residual resources causes the balloon cgroup to reach its limit, some of these resources must be forcefully released This release process is guided by a ’first-in-first-out’ methodology.

Signed-off-by: xz <15086729272@163.com>
---
 arch/x86/entry/vdso/stUIdlrG    |  11 ++
 drivers/base/core.c             |   3 +
 drivers/net/veth.c              |   1 +
 include/linux/cgroup-defs.h     |  34 +++++
 include/linux/cgroup.h          |   2 +
 include/linux/inetdevice.h      |   4 +-
 include/linux/ipc.h             |   3 +
 include/linux/ipc_namespace.h   |  14 +++
 include/linux/memcontrol.h      |  20 ++-
 include/linux/netdevice.h       |   4 +
 include/linux/pid_namespace.h   |   2 +
 include/linux/sem.h             |   3 +-
 include/net/neighbour.h         |   2 +
 include/net/net_namespace.h     |   1 +
 ipc/msg.c                       | 140 ++++++++++++++++++++-
 ipc/msgutil.c                   |  21 ++++
 ipc/namespace.c                 | 102 ++++++++++++++-
 ipc/sem.c                       | 138 +++++++++++++++++++-
 ipc/shm.c                       | 144 ++++++++++++++++++++-
 ipc/util.c                      |   2 +-
 ipc/util.h                      |   2 +-
 kernel/cgroup/cgroup-internal.h |   2 +
 kernel/cgroup/cgroup-v1.c       |   2 +-
 kernel/cgroup/cgroup.c          | 217 +++++++++++++++++++++++++++++++-
 kernel/cgroup/pids.c            |   3 +-
 kernel/exit.c                   |  15 +++
 kernel/pid_namespace.c          |  95 ++++++++++++++
 kernel/sysctl.c                 |   7 ++
 mm/memcontrol.c                 | 172 +++++++++++++++++++++++++
 mm/shmem.c                      |  35 ++++++
 net/core/dev.c                  | 190 +++++++++++++++++++++++++++-
 net/core/neighbour.c            |  17 +++
 net/core/net_namespace.c        |  71 +++++++++++
 net/ipv4/devinet.c              |  17 +++
 net/ipv6/addrconf.c             |  30 ++++-
 stuN8OnK                        |   0
 36 files changed, 1505 insertions(+), 21 deletions(-)
 create mode 100644 arch/x86/entry/vdso/stUIdlrG
 create mode 100644 stuN8OnK

diff --git a/arch/x86/entry/vdso/stUIdlrG b/arch/x86/entry/vdso/stUIdlrG
new file mode 100644
index 000000000..a331df7ad
--- /dev/null
+++ b/arch/x86/entry/vdso/stUIdlrG
@@ -0,0 +1,11 @@
+!<thin>
+vma.o/
+extable.o/
+vdso32-setup.o/
+vdso-image-64.o/
+vdso-image-32.o/
+/0              0           0     0     644     359752    `
+/7              0           0     0     644     275744    `
+/18             0           0     0     644     67472     `
+/34            /0           0     0     644     70168     `
+/51            /0           0     0     644     70168     `
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6ed21587b..1d0b619f4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -31,6 +31,9 @@
 #include <linux/swiotlb.h>
 #include <linux/sysfs.h>
 #include <linux/dma-map-ops.h> /* for dma_default_coherent */
+#include <linux/kobject.h>
+#include <linux/memcontrol.h>
+#include <linux/sysfs.h>
 
 #include "base.h"
 #include "physical_location.h"
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index dfc7d87fa..f391596ca 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -26,6 +26,7 @@
 #include <linux/ptr_ring.h>
 #include <linux/bpf_trace.h>
 #include <linux/net_tstamp.h>
+#include <linux/memcontrol.h>
 
 #define DRV_NAME	"veth"
 #define DRV_VERSION	"1.0"
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8a0d5466c..9b9f7436c 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -374,11 +374,45 @@ struct cgroup_freezer_state {
 	 */
 	int nr_frozen_tasks;
 };
+struct ipc_ns_list {
+	struct list_head list;
+	struct ipc_namespace *ipc_ns;
+};
+
+struct net_ns_list {
+	struct list_head list;
+	struct net *net_ns;
+};
+
+struct pid_ns_list {
+	struct list_head list;
+	struct pid_namespace *pid_ns;
+};
 
+extern struct ipc_ns_list *ipc_ns_list_init(void);
+extern int ipc_ns_list_add_tail(struct ipc_ns_list *head, struct ipc_namespace *ipc_ns);
+extern int ipc_ns_list_free(struct ipc_ns_list *head);
+extern int ipc_ns_list_delete_elem(struct ipc_ns_list *head, struct ipc_namespace *ipc_ns);
+extern int ipc_ns_list_insert(struct ipc_ns_list *head, struct ipc_namespace *ipc_ns);
+
+extern struct net_ns_list *net_ns_list_init(void);
+extern int net_ns_list_add_tail(struct net_ns_list *head, struct net *net_ns);
+extern int net_ns_list_free(struct net_ns_list *head);
+extern int net_ns_list_delete_elem(struct net_ns_list *head, struct net *net_ns);
+extern int net_ns_list_insert(struct net_ns_list *head, struct net *net_ns);
+
+extern struct pid_ns_list *pid_ns_list_init(void);
+extern int pid_ns_list_add_tail(struct pid_ns_list *head, struct pid_namespace *pid_ns);
+extern int pid_ns_list_free(struct pid_ns_list *head);
+extern int pid_ns_list_delete_elem(struct pid_ns_list *head, struct pid_namespace *pid_ns);
+extern int pid_ns_list_insert(struct pid_ns_list *head, struct pid_namespace *pid_ns);
 struct cgroup {
 	/* self css with NULL ->ss, points back to this cgroup */
 	struct cgroup_subsys_state self;
 
+	struct ipc_ns_list *ipc_list;   /*all ipc_ns the processes in this cgroup belong to */
+	struct net_ns_list *net_list;
+	struct pid_ns_list *pid_list;
 	unsigned long flags;		/* "unsigned long" so bitops work */
 
 	/*
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 3410aecff..bb00714fc 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -71,6 +71,7 @@ struct css_task_iter {
 extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
+extern struct cgroup *recycle_cgroup;
 
 #define SUBSYS(_x) extern struct cgroup_subsys _x ## _cgrp_subsys;
 #include <linux/cgroup_subsys.h>
@@ -858,3 +859,4 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 #endif /* CONFIG_CGROUP_BPF */
 
 #endif /* _LINUX_CGROUP_H */
+extern void recycle_cgroup_clear(int times);
diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index ddb27fc0e..88d1c067c 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -298,6 +298,6 @@ static __inline__ int inet_mask_len(__be32 mask)
 		return 0;
 	return 32 - ffz(~hmask);
 }
-
-
+extern int devinet_move(struct ipv4_devconf *ipv4_p, struct mem_cgroup *from, struct mem_cgroup *to);
+extern int ipv6_dev_move(struct inet6_dev *in_dev, struct mem_cgroup  *from, struct mem_cgroup  *to);
 #endif /* _LINUX_INETDEVICE_H */
diff --git a/include/linux/ipc.h b/include/linux/ipc.h
index e1c9eea60..dc7466e6e 100644
--- a/include/linux/ipc.h
+++ b/include/linux/ipc.h
@@ -10,6 +10,8 @@
 
 /* used by in-kernel data structures */
 struct kern_ipc_perm {
+	struct cgroup *cgroup;
+	unsigned int residual_time;
 	spinlock_t	lock;
 	bool		deleted;
 	int		id;
@@ -25,6 +27,7 @@ struct kern_ipc_perm {
 	struct rhash_head khtnode;
 
 	struct rcu_head rcu;
+
 	refcount_t refcount;
 } ____cacheline_aligned_in_smp __randomize_layout;
 
diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index e8240cf26..6d26a7472 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -11,7 +11,9 @@
 #include <linux/refcount.h>
 #include <linux/rhashtable-types.h>
 #include <linux/sysctl.h>
+#include <linux/msg.h>
 #include <linux/percpu_counter.h>
+#include <linux/cgroup-defs.h>
 
 struct user_namespace;
 
@@ -211,3 +213,15 @@ static inline bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
 #endif /* CONFIG_SYSVIPC_SYSCTL */
 #endif
+void free_recycle_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids, int times,
+	       void (*free)(struct ipc_namespace *, struct kern_ipc_perm *));
+extern int ipc_sem_move_check(struct ipc_namespace *ns, struct cgroup *cgrp);
+extern void ipc_sem_free(struct ipc_namespace *ns, int times);
+
+extern int ipc_shm_move_check(struct ipc_namespace *ns, struct cgroup *cgrp);
+extern int ipc_shm_folio_move(struct inode *inode, struct mem_cgroup *from, struct mem_cgroup *to);
+extern void ipc_shm_free(struct ipc_namespace *ns, int times);
+
+extern int ipc_msq_move_check(struct ipc_namespace *ns, struct cgroup *cgrp);
+extern int ipc_msg_move(struct msg_msg *msg, struct mem_cgroup *from, struct mem_cgroup *to);
+extern void ipc_msq_free(struct ipc_namespace *ns, int times);
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 85dc9b88e..3af9c7ecc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -18,9 +18,11 @@
 #include <linux/vmpressure.h>
 #include <linux/eventfd.h>
 #include <linux/mm.h>
+#include <linux/device.h>
 #include <linux/vmstat.h>
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
+#include <linux/cgroup-defs.h>
 
 struct mem_cgroup;
 struct obj_cgroup;
@@ -768,8 +770,8 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
 }
 #endif
 
-static inline
-struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
+static struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
+{
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
 }
 
@@ -1878,4 +1880,18 @@ static inline void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg,
 }
 #endif
 
+extern int _obj_cgroup_move(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects, struct obj_cgroup *to);
+extern int kmem_cache_move(struct kmem_cache *s, void *addr,
+					 int objects, struct mem_cgroup *to);
+extern int obj_cgroup_move(void *addr, struct mem_cgroup *from, struct mem_cgroup *to);
+extern int kmem_folio_move(struct folio *folio,  struct mem_cgroup *from, struct mem_cgroup *to);
+
+extern struct mem_cgroup *get_cg_from_cgrp(struct cgroup *cgrp, const char *subsys_name);
+
+extern int memory_max_set(struct mem_cgroup *memcg, unsigned long max_pages);
+#define RECYCLE_MEM_MAX (1 << 18)
+extern long recycle_max_limit;
+extern int page_set_shadow_max(struct mem_cgroup *from, struct mem_cgroup *to);
+extern int kmem_cgroup_move(void *addr, struct mem_cgroup *from, struct mem_cgroup *to);
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e6e02184c..24fd870ce 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2018,6 +2018,9 @@ struct net_device {
 	char			name[IFNAMSIZ];
 	struct netdev_name_node	*name_node;
 	struct dev_ifalias	__rcu *ifalias;
+
+	struct cgroup *cgroup;
+	unsigned int residual_time;
 	/*
 	 *	I/O specific fields
 	 *	FIXME: Merge these and struct ifmap into one
@@ -5188,3 +5191,4 @@ extern struct net_device *blackhole_netdev;
 		atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
 
 #endif	/* _LINUX_NETDEVICE_H */
+extern int net_device_move_check(struct net *ns, struct cgroup *cgrp);
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 07481bb87..f630f304d 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -92,3 +92,5 @@ static inline bool task_is_in_init_pid_ns(struct task_struct *tsk)
 }
 
 #endif /* _LINUX_PID_NS_H */
+extern void check_pid_zombie(struct pid_namespace *pid_ns, struct cgroup *cgrp);
+extern int zombie_cgrp_insert_ns(struct task_struct *task, struct cgroup *cgrp);
\ No newline at end of file
diff --git a/include/linux/sem.h b/include/linux/sem.h
index 5608a500c..9646b89e4 100644
--- a/include/linux/sem.h
+++ b/include/linux/sem.h
@@ -6,7 +6,7 @@
 
 struct task_struct;
 struct sem_undo_list;
-
+struct sem_array;
 #ifdef CONFIG_SYSVIPC
 
 struct sysv_sem {
@@ -16,6 +16,7 @@ struct sysv_sem {
 extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
 extern void exit_sem(struct task_struct *tsk);
 
+extern struct sem_array *find_sem_from_perm(struct kern_ipc_perm *perm);
 #else
 
 struct sysv_sem {
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 2f2a6023f..0f584afc6 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -605,3 +605,5 @@ static inline void neigh_update_is_router(struct neighbour *neigh, u32 flags,
 	}
 }
 #endif
+extern int neigh_move(struct neigh_parms *neigh_p, struct mem_cgroup *from, struct mem_cgroup *to);
+
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 78beaa765..03b656273 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -542,3 +542,4 @@ static inline void net_ns_init(void) {}
 #endif
 
 #endif /* __NET_NET_NAMESPACE_H */
+extern void net_device_free(struct net *ns, int times);
diff --git a/ipc/msg.c b/ipc/msg.c
index fd08b3cb3..5731fca48 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -40,6 +40,7 @@
 #include <linux/ipc_namespace.h>
 #include <linux/rhashtable.h>
 #include <linux/percpu_counter.h>
+#include <linux/memcontrol.h>
 
 #include <asm/current.h>
 #include <linux/uaccess.h>
@@ -133,7 +134,8 @@ static void msg_rcu_free(struct rcu_head *head)
 	security_msg_queue_free(&msq->q_perm);
 	kfree(msq);
 }
-
+struct msg_queue *find_msq_from_perm(struct kern_ipc_perm *perm);
+int ipc_msq_move(struct msg_queue *msq, struct mem_cgroup *from, struct mem_cgroup *to);
 /**
  * newque - Create a new msg queue
  * @ns: namespace
@@ -294,10 +296,42 @@ static void freeque(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 	ipc_update_pid(&msq->q_lrpid, NULL);
 	ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
 }
+void msg_tag(struct kern_ipc_perm *ipcp, struct ipc_namespace *ns)
+{
+	struct msg_queue *msq;
+	struct mem_cgroup *memcg_owner, *memcg_recycle;
+	struct cgroup *cgrp_owner;
+
+	memcg_owner = mem_cgroup_from_task(current);
+	if (!memcg_owner)
+		return;
+
+	cgrp_owner = memcg_owner->css.cgroup;
+	if (!cgrp_owner)
+		return;
+
+
+	if (ipcp->cgroup == recycle_cgroup) { //move the resources
+		msq = find_msq_from_perm(ipcp);
+		if (!msq)
+			return;
+		memcg_recycle = get_cg_from_cgrp(recycle_cgroup, "memory");
+		ipc_msq_move(msq, memcg_recycle, memcg_owner);
+	}
+	ipcp->cgroup = cgrp_owner;
+	ipc_ns_list_insert(cgrp_owner->ipc_list, ns);
 
+}
+extern void ipc_msq_free(struct ipc_namespace *ns, int times)
+{
+	free_recycle_ipcs(ns, &msg_ids(ns), times, freeque);
+}
 long ksys_msgget(key_t key, int msgflg)
 {
 	struct ipc_namespace *ns;
+	int err;
+	struct kern_ipc_perm *ipcp;
+
 	static const struct ipc_ops msg_ops = {
 		.getnew = newque,
 		.associate = security_msg_queue_associate,
@@ -309,7 +343,20 @@ long ksys_msgget(key_t key, int msgflg)
 	msg_params.key = key;
 	msg_params.flg = msgflg;
 
-	return ipcget(ns, &msg_ids(ns), &msg_ops, &msg_params);
+	err = ipcget(ns, &msg_ids(ns), &msg_ops, &msg_params);
+	if (err >= 0) {
+		down_write(&msg_ids(ns).rwsem);
+		ipcp = ipc_findkey(&msg_ids(ns), key);
+		if (!ipcp)
+			goto no_lock;
+
+		msg_tag(ipcp, ns);
+		ipc_unlock(ipcp);
+
+no_lock:
+		up_write(&msg_ids(ns).rwsem);
+	}
+	return err;
 }
 
 SYSCALL_DEFINE2(msgget, key_t, key, int, msgflg)
@@ -1374,3 +1421,92 @@ void __init msg_init(void)
 				"       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n",
 				IPC_MSG_IDS, sysvipc_msg_proc_show);
 }
+
+struct msg_queue *find_msq_from_perm(struct kern_ipc_perm *perm)
+{
+	struct msg_queue *msq = container_of(perm, struct msg_queue, q_perm);
+	return msq;
+}
+int ipc_msq_move(struct msg_queue *msq, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	struct msg_msg *msg, *t;
+	int err = 0;
+
+	list_for_each_entry_safe(msg, t, &msq->q_messages, m_list) {
+		err = ipc_msg_move(msg, from, to);
+		if (err < 0)
+			return err;
+	}
+	err = kmem_cgroup_move(msq, from, to);
+	return err;
+}
+
+int ipc_msq_move_check(struct ipc_namespace *ns, struct cgroup *cgrp)
+{
+	struct ipc_ids *ids;
+	struct kern_ipc_perm *perm;
+	int next_id;
+	int total, in_use;
+	struct msg_queue *msq;
+	bool MAX_SET = true;
+	int clear_times = 5;
+
+	struct mem_cgroup *memcg_to, *memcg_from = get_cg_from_cgrp(cgrp, "memory");
+	ids = &msg_ids(ns);
+	if (ids == NULL)
+		return 0;
+
+	if (memcg_from == NULL)
+		return 0;
+
+	in_use = ids->in_use;
+	for (total = 0, next_id = 0; total < in_use; next_id++) {
+		perm = idr_find(&ids->ipcs_idr, next_id);
+		if (perm == NULL) {
+			total++;
+			continue;
+		}
+
+		msq = find_msq_from_perm(perm);
+		if (msq == NULL) {
+			total++;
+			continue;
+		}
+
+		if (perm->cgroup == NULL) {
+			down_write(&msg_ids(ns).rwsem);
+			rcu_read_lock();
+			ipc_lock_object(perm);
+			freeque(ns, perm);
+			up_write(&msg_ids(ns).rwsem);
+			total++;
+			continue;
+		}
+
+		if (perm->cgroup == recycle_cgroup)
+			perm->residual_time++;
+
+		if (perm->cgroup == cgrp) {
+			memcg_to = get_cg_from_cgrp(recycle_cgroup, "memory");
+			if (!memcg_to)
+				return 0;
+
+			if (MAX_SET) {
+				page_set_shadow_max(memcg_from, memcg_to);
+				MAX_SET = false;
+			}
+
+			perm->residual_time = 0;
+			perm->cgroup = recycle_cgroup;
+			ipc_ns_list_insert(recycle_cgroup->ipc_list, ns);
+
+			if (ipc_msq_move(msq, memcg_from, memcg_to) < 0) {
+				recycle_cgroup_clear(clear_times);
+				if (clear_times > 0)
+					clear_times--;
+			}
+		}
+		total++;
+	}
+	return 0;
+}
\ No newline at end of file
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index d0a0e877c..b9f5e34f8 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -15,6 +15,7 @@
 #include <linux/proc_ns.h>
 #include <linux/uaccess.h>
 #include <linux/sched.h>
+#include <linux/memcontrol.h>
 
 #include "util.h"
 
@@ -182,3 +183,23 @@ void free_msg(struct msg_msg *msg)
 		seg = tmp;
 	}
 }
+extern int ipc_msg_move(struct msg_msg *msg, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	struct msg_msgseg *seg;
+	int err;
+
+	seg = msg->next;
+	err = kmem_cgroup_move(msg, from, to);
+	if (err < 0)
+		return err;
+	while (seg != NULL) {
+		struct msg_msgseg *tmp = seg->next;
+
+		cond_resched();
+		err = kmem_cgroup_move(seg, from, to);
+		if (err < 0)
+			return err;
+		seg = tmp;
+	}
+	return err;
+}
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 8316ea585..252a53581 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -16,6 +16,8 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
+#include <linux/cgroup-defs.h>
+#include <linux/cgroup.h>
 
 #include "util.h"
 
@@ -72,7 +74,6 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 
 	sem_init_ns(ns);
 	shm_init_ns(ns);
-
 	return ns;
 
 fail_mq:
@@ -128,6 +129,81 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 	up_write(&ids->rwsem);
 }
 
+struct ipc_ns_list *ipc_ns_list_init(void)
+{
+	struct ipc_ns_list *head;
+
+	head = kmalloc(sizeof(struct ipc_ns_list), GFP_KERNEL);
+	if (head == NULL)
+		return NULL;
+
+	INIT_LIST_HEAD(&(head->list));
+	return head;
+}
+
+/*
+-1: insert failed
+0: insert success
+*/
+int ipc_ns_list_add_tail(struct ipc_ns_list *head, struct ipc_namespace *ipc_ns)
+{
+	struct ipc_ns_list *new_node;
+
+	new_node = kmalloc(sizeof(struct ipc_ns_list), GFP_KERNEL);
+	if (new_node == NULL)
+		return -1;
+
+	memset(new_node, 0, sizeof(struct ipc_ns_list));
+	new_node->ipc_ns = ipc_ns;
+
+	list_add_tail(&(new_node->list), &(head->list));
+	return 0;
+}
+int ipc_ns_list_free(struct ipc_ns_list *head)
+{
+	struct ipc_ns_list *p, *q;
+
+    list_for_each_entry_safe(p, q, &(head->list), list) {
+		list_del(&(p->list));
+		kfree(p);
+    }
+	list_del(&(head->list));
+	kfree(head);
+	return 0;
+}
+/*
+-1: list empty
+-2: not found
+*/
+int ipc_ns_list_delete_elem(struct ipc_ns_list *head, struct ipc_namespace *ipc_ns)
+{
+	struct ipc_ns_list *pos;
+
+	if (list_empty(&(head->list)))
+		return -1;
+	list_for_each_entry(pos,  &(head->list), list) {
+		if (pos->ipc_ns == ipc_ns) {
+			list_del(&(pos->list));
+			kfree(pos);
+			return 0;
+		}
+	}
+	return -2;
+}
+int ipc_ns_list_insert(struct ipc_ns_list *head, struct ipc_namespace *ipc_ns)
+{
+	int err;
+	struct ipc_ns_list *pos;
+
+	list_for_each_entry(pos, &(head->list), list) {
+		if (pos->ipc_ns == ipc_ns)
+			return 0;
+	}
+	err = ipc_ns_list_add_tail(head, ipc_ns);
+	return err;
+}
+
+
 static void free_ipc_ns(struct ipc_namespace *ns)
 {
 	/* mq_put_mnt() waits for a grace period as kern_unmount()
@@ -239,3 +315,27 @@ const struct proc_ns_operations ipcns_operations = {
 	.install	= ipcns_install,
 	.owner		= ipcns_owner,
 };
+void free_recycle_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids, int times,
+	       void (*free)(struct ipc_namespace *, struct kern_ipc_perm *))
+{
+	struct kern_ipc_perm *perm;
+	int next_id;
+	int total, in_use;
+
+	down_write(&ids->rwsem);
+
+	in_use = ids->in_use;
+
+	for (total = 0, next_id = 0; total < in_use; next_id++) {
+		perm = idr_find(&ids->ipcs_idr, next_id);
+		if (perm == NULL)
+			continue;
+		if (perm->residual_time >= times && perm->cgroup == recycle_cgroup) {
+			rcu_read_lock();
+			ipc_lock_object(perm);
+			free(ns, perm);
+		}
+		total++;
+	}
+	up_write(&ids->rwsem);
+}
diff --git a/ipc/sem.c b/ipc/sem.c
index 00f88aa01..a550d88fe 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -87,7 +87,9 @@
 #include <linux/sched/wake_q.h>
 #include <linux/nospec.h>
 #include <linux/rhashtable.h>
-
+#include <linux/cgroup-defs.h>
+#include <linux/memcontrol.h>
+#include <linux/delay.h>
 #include <linux/uaccess.h>
 #include "util.h"
 
@@ -583,6 +585,90 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 
 	return sma->sem_perm.id;
 }
+struct sem_array *find_sem_from_perm(struct kern_ipc_perm *perm)
+{
+	struct sem_array *sma = container_of(perm, struct sem_array, sem_perm);
+	return sma;
+}
+int ipc_sem_move(struct sem_array *sma, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	return obj_cgroup_move(sma, from, to);
+}
+void ipc_sem_free(struct ipc_namespace *ns, int times)
+{
+	free_recycle_ipcs(ns, &sem_ids(ns), times, freeary);
+}
+
+
+int ipc_sem_move_check(struct ipc_namespace *ns, struct cgroup *cgrp)
+{
+	struct ipc_ids *ids;
+	struct kern_ipc_perm *perm;
+	int next_id;
+	int total, in_use;
+	struct sem_array *sma;
+	bool MAX_SET = true;
+	int clear_times = 5;
+	struct mem_cgroup *memcg_to, *memcg_from = get_cg_from_cgrp(cgrp, "memory");
+
+	ids =  &sem_ids(ns);
+	if (ids == NULL)
+		return 0;
+
+	if (memcg_from == NULL)
+		return 0;
+
+	in_use = ids->in_use;
+	for (total = 0, next_id = 0; total < in_use; next_id++) {
+		perm = idr_find(&ids->ipcs_idr, next_id);
+		if (perm == NULL) {
+			total++;
+			continue;
+		}
+		sma = find_sem_from_perm(perm);
+
+		if (sma == NULL) {
+			total++;
+			continue;
+		}
+
+		if (perm->cgroup == NULL) {
+			down_write(&sem_ids(ns).rwsem);
+			rcu_read_lock();
+			ipc_lock_object(perm);
+			freeary(ns, perm);
+			up_write(&sem_ids(ns).rwsem);
+			total++;
+			continue;
+		}
+
+		if (perm->cgroup == recycle_cgroup)
+			perm->residual_time++;
+
+		if (perm->cgroup == cgrp) { //belongs to the exiting cgorup.
+			memcg_to = get_cg_from_cgrp(recycle_cgroup, "memory");
+			if (!memcg_to)
+				return 0;
+
+			if (MAX_SET) {
+				page_set_shadow_max(memcg_from, memcg_to);
+				MAX_SET = false;
+			}
+
+			perm->residual_time = 0;
+			perm->cgroup = recycle_cgroup;
+			ipc_ns_list_insert(recycle_cgroup->ipc_list, ns);
+
+			if (ipc_sem_move(sma, memcg_from, memcg_to) < 0) {
+				recycle_cgroup_clear(clear_times);
+				if (clear_times > 0)
+					clear_times--;
+			}
+		}
+		total++;
+	}
+	return 0;
+}
 
 
 /*
@@ -598,10 +684,45 @@ static int sem_more_checks(struct kern_ipc_perm *ipcp, struct ipc_params *params
 
 	return 0;
 }
+void sem_tag(struct kern_ipc_perm *ipcp, struct ipc_namespace *ns)
+{
+	struct sem_array *sma;
+	struct mem_cgroup *memcg_owner, *memcg_recycle;
+	struct cgroup *cgrp_owner;
+
+	memcg_owner = mem_cgroup_from_task(current);
+	if (!memcg_owner)
+		return;
+
+	cgrp_owner = memcg_owner->css.cgroup;
+	if (!cgrp_owner)
+		return;
+
+	ipc_ns_list_insert(cgrp_owner->ipc_list, ns);
+
+	if (!ipcp)
+		return;
+
+	if (ipcp->cgroup == recycle_cgroup) {
+		sma = find_sem_from_perm(ipcp);
+		if (!sma)
+			return;
+
+		memcg_recycle = get_cg_from_cgrp(recycle_cgroup, "memory");
+		if (!memcg_recycle)
+			return;
+
+		obj_cgroup_move(sma, memcg_recycle, memcg_owner);
+	}
+	ipcp->cgroup = cgrp_owner;
+}
 
 long ksys_semget(key_t key, int nsems, int semflg)
 {
 	struct ipc_namespace *ns;
+	int err;
+	struct kern_ipc_perm *ipcp;
+
 	static const struct ipc_ops sem_ops = {
 		.getnew = newary,
 		.associate = security_sem_associate,
@@ -618,7 +739,20 @@ long ksys_semget(key_t key, int nsems, int semflg)
 	sem_params.flg = semflg;
 	sem_params.u.nsems = nsems;
 
-	return ipcget(ns, &sem_ids(ns), &sem_ops, &sem_params);
+	err = ipcget(ns, &sem_ids(ns), &sem_ops, &sem_params);
+	if (err >= 0) {
+		down_write(&sem_ids(ns).rwsem);
+		ipcp = ipc_findkey(&sem_ids(ns), key);
+		sem_tag(ipcp, ns);
+
+		if (!ipcp)
+			goto no_lock;
+
+		ipc_unlock(ipcp);
+no_lock:
+		up_write(&sem_ids(ns).rwsem);
+	}
+	return err;
 }
 
 SYSCALL_DEFINE3(semget, key_t, key, int, nsems, int, semflg)
diff --git a/ipc/shm.c b/ipc/shm.c
index bd2fcc4d4..6ae8b693b 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -44,6 +44,7 @@
 #include <linux/mount.h>
 #include <linux/ipc_namespace.h>
 #include <linux/rhashtable.h>
+#include <linux/memcontrol.h>
 
 #include <linux/uaccess.h>
 
@@ -98,6 +99,7 @@ static const struct vm_operations_struct shm_vm_ops;
 	ipc_unlock(&(shp)->shm_perm)
 
 static int newseg(struct ipc_namespace *, struct ipc_params *);
+extern int ipc_shm_move(struct shmid_kernel *shp, struct mem_cgroup *from, struct mem_cgroup *to);
 static void shm_open(struct vm_area_struct *vma);
 static void shm_close(struct vm_area_struct *vma);
 static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp);
@@ -827,10 +829,49 @@ static int shm_more_checks(struct kern_ipc_perm *ipcp, struct ipc_params *params
 
 	return 0;
 }
+struct shmid_kernel *find_shp_from_perm(struct kern_ipc_perm *perm)
+{
+	struct shmid_kernel *shp = container_of(perm, struct shmid_kernel, shm_perm);
+	return shp;
+}
+
+void shm_tag(struct kern_ipc_perm *ipcp, struct ipc_namespace *ns)
+{
+	struct shmid_kernel *shp;
+	struct mem_cgroup *memcg_owner, *memcg_recycle;
+	struct cgroup *cgrp_owner;
+
+	memcg_owner = mem_cgroup_from_task(current);
+	if (!memcg_owner)
+		return;
+
+	cgrp_owner = memcg_owner->css.cgroup;
+	if (!cgrp_owner)
+		return;
+
+	if (ipcp->cgroup == recycle_cgroup) {
+		shp = find_shp_from_perm(ipcp);
+		if (!shp)
+			return;
+		memcg_recycle = get_cg_from_cgrp(recycle_cgroup, "memory");
+		ipc_shm_move(shp, memcg_recycle, memcg_owner);
+	}
+
+	ipcp->cgroup = cgrp_owner;
+	ipc_ns_list_insert(cgrp_owner->ipc_list, ns);
+}
+
+extern void ipc_shm_free(struct ipc_namespace *ns, int times)
+{
+	free_recycle_ipcs(ns, &shm_ids(ns), times, do_shm_rmid);
+}
 
 long ksys_shmget(key_t key, size_t size, int shmflg)
 {
 	struct ipc_namespace *ns;
+	int err;
+	struct kern_ipc_perm *ipcp;
+
 	static const struct ipc_ops shm_ops = {
 		.getnew = newseg,
 		.associate = security_shm_associate,
@@ -844,7 +885,20 @@ long ksys_shmget(key_t key, size_t size, int shmflg)
 	shm_params.flg = shmflg;
 	shm_params.u.size = size;
 
-	return ipcget(ns, &shm_ids(ns), &shm_ops, &shm_params);
+	err = ipcget(ns, &shm_ids(ns), &shm_ops, &shm_params);
+	if (err >= 0) {
+		down_write(&shm_ids(ns).rwsem);
+		ipcp = ipc_findkey(&shm_ids(ns), key);
+		if (!ipcp)
+			goto no_lock;
+
+		shm_tag(ipcp, ns);
+
+		ipc_unlock(ipcp);
+no_lock:
+		up_write(&shm_ids(ns).rwsem);
+	}
+	return err;
 }
 
 SYSCALL_DEFINE3(shmget, key_t, key, size_t, size, int, shmflg)
@@ -1881,3 +1935,91 @@ static int sysvipc_shm_proc_show(struct seq_file *s, void *it)
 	return 0;
 }
 #endif
+
+extern int ipc_shm_move(struct shmid_kernel *shp, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	int err;
+	struct file *file;
+	struct inode *inode;
+
+	file = shp->shm_file;
+	if (!file)
+		return 0;
+
+	inode = file->f_inode;
+	if (!inode)
+		return 0;
+
+	err = obj_cgroup_move(shp, from, to);
+	err = ipc_shm_folio_move(inode, from, to);
+	return err;
+}
+
+
+int ipc_shm_move_check(struct ipc_namespace *ns, struct cgroup *cgrp)
+{
+	struct ipc_ids *ids;
+	struct kern_ipc_perm *perm;
+	int next_id;
+	int total, in_use;
+	struct shmid_kernel *shp;
+	bool MAX_SET = true;
+	int clear_times = 5;
+	struct mem_cgroup *memcg_to, *memcg_from = get_cg_from_cgrp(cgrp, "memory");
+
+	ids =  &shm_ids(ns);
+
+	if (ids == NULL)
+		return 0;
+
+	if (memcg_from == NULL)
+		return 0;
+
+	in_use = ids->in_use;
+	for (total = 0, next_id = 0; total < in_use; next_id++) {
+		perm = idr_find(&ids->ipcs_idr, next_id);
+		if (perm == NULL) {
+			total++;
+			continue;
+		}
+
+		shp = find_shp_from_perm(perm);
+		if (shp == NULL) {
+			total++;
+			continue;
+		}
+		if (perm->cgroup == NULL) {
+			down_write(&shm_ids(ns).rwsem);
+			rcu_read_lock();
+			ipc_lock_object(perm);
+			do_shm_rmid(ns, perm);
+			up_write(&shm_ids(ns).rwsem);
+			total++;
+			continue;
+		}
+		if (perm->cgroup == recycle_cgroup)
+			perm->residual_time++;
+
+		if (perm->cgroup == cgrp) {
+			memcg_to = get_cg_from_cgrp(recycle_cgroup, "memory");
+			if (!memcg_to)
+				return 0;
+
+			if (MAX_SET) {
+				page_set_shadow_max(memcg_from, memcg_to);
+				MAX_SET = false;
+			}
+			perm->residual_time = 0;
+			perm->cgroup = recycle_cgroup;
+			ipc_ns_list_insert(recycle_cgroup->ipc_list, ns);
+
+			if (ipc_shm_move(shp, memcg_from, memcg_to) < 0) {
+				recycle_cgroup_clear(clear_times);
+				if (clear_times > 0)
+					clear_times--;
+			}
+		}
+		total++;
+	}
+	return 0;
+}
diff --git a/ipc/util.c b/ipc/util.c
index 05cb9de66..6522916a6 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -169,7 +169,7 @@ void __init ipc_init_proc_interface(const char *path, const char *header,
  *
  * Called with writer ipc_ids.rwsem held.
  */
-static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
+extern struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 {
 	struct kern_ipc_perm *ipcp;
 
diff --git a/ipc/util.h b/ipc/util.h
index b2906e366..740366a36 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -254,7 +254,7 @@ static inline int sem_check_semmni(struct ipc_namespace *ns) {
 	return ((ns->sem_ctls[3] < 0) || (ns->sem_ctls[3] > ipc_mni))
 		? -ERANGE : 0;
 }
-
+extern struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key);
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 struct compat_ipc_perm {
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 367b0a42a..ac22b690f 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -262,6 +262,8 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode);
 int cgroup_rmdir(struct kernfs_node *kn);
 int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 		     struct kernfs_root *kf_root);
+int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent,
+			  const char *new_name_str);
 
 int __cgroup_task_count(const struct cgroup *cgrp);
 int cgroup_task_count(const struct cgroup *cgrp);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 52bb5a74a..0ffda2b19 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -824,7 +824,7 @@ void cgroup1_release_agent(struct work_struct *work)
 /*
  * cgroup_rename - Only allow simple rename of directories in place.
  */
-static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent,
+int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent,
 			  const char *new_name_str)
 {
 	struct cgroup *cgrp = kn->priv;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c099cf3fa..b29dc32e2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -58,8 +58,24 @@
 #include <linux/fs_parser.h>
 #include <linux/sched/cputime.h>
 #include <linux/psi.h>
+#include <linux/cgroup-defs.h>
+#include <linux/memcontrol.h>
+#include <linux/ipc_namespace.h>
+#include <linux/slab.h>
+#include <linux/sem.h>
+#include <linux/shm.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/syscalls.h>
+#include <linux/security.h>
+#include <linux/namei.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
 #include <net/sock.h>
 
+#include <linux/percpu_counter.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/cgroup.h>
 
@@ -5707,6 +5723,15 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 	return ret;
 }
 
+void cgroup_recycle_init(struct cgroup *cgrp)
+{
+	if (!cgrp)
+		return;
+	cgrp->ipc_list = ipc_ns_list_init();
+	cgrp->net_list = net_ns_list_init();
+	cgrp->pid_list = pid_ns_list_init();
+}
+
 int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 {
 	struct cgroup *parent, *cgrp;
@@ -5730,7 +5755,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 		ret = PTR_ERR(cgrp);
 		goto out_unlock;
 	}
-
+	cgroup_recycle_init(cgrp);
 	/*
 	 * This extra ref will be put in cgroup_free_fn() and guarantees
 	 * that @cgrp->kn is always accessible.
@@ -5841,6 +5866,146 @@ static void kill_css(struct cgroup_subsys_state *css)
 	percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn);
 }
 
+struct mem_cgroup *get_cg_from_cgrp(struct cgroup *cgrp, const char *subsys_name)
+{
+	struct cgroup_subsys_state *css;
+	struct mem_cgroup *memcg;
+
+	if (!cgrp)
+		return NULL;
+
+	for (int i = 0; i < CGROUP_SUBSYS_COUNT; i++) {
+		if (strcmp(subsys_name, cgroup_subsys_name[i]) == 0) {
+			css = cgrp->subsys[i];
+			break;
+		}
+	}
+	memcg = mem_cgroup_from_css(css);
+	return memcg;
+}
+
+static int memcg_ipc_check(struct cgroup *cgrp)
+{
+	struct ipc_ns_list *head;
+	struct ipc_namespace *ipc_ns;
+	struct ipc_ns_list *pos;
+
+	head = cgrp->ipc_list;
+
+	if (head == NULL)
+		return 0;
+
+	list_for_each_entry(pos, &head->list, list) {
+		ipc_ns = pos->ipc_ns;
+		if (ipc_ns == NULL)
+			continue;
+		if (ipc_ns->used_sems != 0)
+			ipc_sem_move_check(ipc_ns, cgrp);
+
+		if (ipc_ns->shm_tot != 0)
+			ipc_shm_move_check(ipc_ns, cgrp);
+
+		ipc_msq_move_check(ipc_ns, cgrp);
+	}
+
+	ipc_ns_list_free(cgrp->ipc_list);
+	cgrp->ipc_list = NULL;
+	return 0;
+}
+
+static int memcg_net_check(struct cgroup *cgrp)
+{
+	struct net_ns_list *head;
+	struct net *net_ns;
+	struct net_ns_list *pos;
+	head = cgrp->net_list;
+
+	if (head == NULL)
+		return 0;
+
+	list_for_each_entry(pos, &head->list, list) {
+		net_ns = pos->net_ns;
+		if (net_ns == NULL)
+			return 0;
+
+		if (!list_empty(&net_ns->dev_base_head))
+			net_device_move_check(net_ns, cgrp);
+
+	}
+	net_ns_list_free(cgrp->net_list);
+	cgrp->net_list = NULL;
+	return 0;
+}
+
+static int pid_check(struct cgroup *cgrp)
+{
+	struct pid_ns_list *head;
+	struct pid_namespace *pid_ns;
+	struct pid_ns_list *pos;
+
+	head = cgrp->pid_list;
+
+	if (head == NULL)
+		return 0;
+
+	list_for_each_entry(pos, &head->list, list) {
+		pid_ns = pos->pid_ns;
+		if (pid_ns == NULL)
+			continue;
+		check_pid_zombie(pid_ns, cgrp);
+	}
+
+	pid_ns_list_free(cgrp->pid_list);
+	cgrp->pid_list = NULL;
+	return 0;
+}
+
+static void ipc_residual_clear(int times)
+{
+	struct ipc_ns_list *head;
+	struct ipc_namespace *ipc_ns;
+	struct ipc_ns_list *pos;
+
+	head = recycle_cgroup->ipc_list;
+
+	if (head == NULL)
+		return;
+
+	list_for_each_entry(pos, &head->list, list) {
+		ipc_ns = pos->ipc_ns;
+		if (ipc_ns == NULL)
+			continue;
+		ipc_sem_free(ipc_ns, times);
+		ipc_shm_free(ipc_ns, times);
+		ipc_msq_free(ipc_ns, times);
+	}
+}
+
+static void net_residual_clear(int times)
+{
+	struct net_ns_list *head;
+	struct net *net_ns;
+	struct net_ns_list *pos;
+
+	head = recycle_cgroup->net_list;
+
+	if (head == NULL)
+		return;
+
+	list_for_each_entry(pos, &head->list, list) {
+		net_ns = pos->net_ns;
+		if (net_ns == NULL)
+			return;
+
+		net_device_free(net_ns, times);
+	}
+}
+
+extern void recycle_cgroup_clear(int times)
+{
+	ipc_residual_clear(times);
+	net_residual_clear(times);
+}
 /**
  * cgroup_destroy_locked - the first stage of cgroup destruction
  * @cgrp: cgroup to be destroyed
@@ -5945,6 +6110,9 @@ int cgroup_rmdir(struct kernfs_node *kn)
 	cgrp = cgroup_kn_lock_live(kn, false);
 	if (!cgrp)
 		return 0;
+	memcg_ipc_check(cgrp);
+	memcg_net_check(cgrp);
+	pid_check(cgrp);
 
 	ret = cgroup_destroy_locked(cgrp);
 	if (!ret)
@@ -5959,6 +6127,7 @@ static struct kernfs_syscall_ops cgroup_kf_syscall_ops = {
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
 	.show_path		= cgroup_show_path,
+	.rename 		= cgroup1_rename,
 };
 
 static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
@@ -6050,6 +6219,50 @@ int __init cgroup_init_early(void)
 	}
 	return 0;
 }
+struct cgroup *recycle_cgroup;
+void recycle_cgroup_create(void)
+{
+	struct kernfs_node *root_kn;
+	struct mem_cgroup *memcg;
+	struct cgroup *cgrp = ERR_PTR(-ENOENT);
+	struct cgroup *root_cgrp;
+	int ret;
+
+	root_cgrp = current_cgns_cgroup_dfl();
+	root_kn = root_cgrp->kn;
+	cgrp = cgroup_create(root_cgrp, "recycle.slice", S_IRWXU | S_IRGRP | S_IROTH);
+	/*
+	 * This extra ref will be put in cgroup_free_fn() and guarantees
+	 * that @cgrp->kn is always accessible.
+	 */
+	kernfs_get(cgrp->kn);
+	ret = cgroup_kn_set_ugid(cgrp->kn);
+	if (ret)
+		goto out_destroy;
+
+	ret = css_populate_dir(&cgrp->self);
+	if (ret)
+		goto out_destroy;
+
+	ret = cgroup_apply_control_enable(cgrp);
+
+	if (ret)
+		goto out_destroy;
+	/* let's create and online css's */
+	kernfs_activate(cgrp->kn);
+	ret = 0;
+	memcg = get_cg_from_cgrp(cgrp, "memory");
+
+	cgroup_recycle_init(cgrp);
+	goto out_unlock;
+
+out_destroy:
+	cgroup_destroy_locked(cgrp);
+
+out_unlock:
+	recycle_cgroup = cgrp;
+}
+EXPORT_SYMBOL(recycle_cgroup);
 
 /**
  * cgroup_init - cgroup initialization
@@ -6151,7 +6364,7 @@ int __init cgroup_init(void)
 #ifdef CONFIG_CPUSETS
 	WARN_ON(register_filesystem(&cpuset_fs_type));
 #endif
-
+	recycle_cgroup_create();
 	return 0;
 }
 
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 7695e60bc..0328aefb5 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -34,7 +34,7 @@
 #include <linux/cgroup.h>
 #include <linux/slab.h>
 #include <linux/sched/task.h>
-
+#include <linux/pid_namespace.h>
 #define PIDS_MAX (PID_MAX_LIMIT + 1ULL)
 #define PIDS_MAX_STR "max"
 
@@ -247,6 +247,7 @@ static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 		css = task_css_check(current, pids_cgrp_id, true);
 	pids = css_pids(css);
 	err = pids_try_charge(pids, 1);
+	zombie_cgrp_insert_ns(task, css->cgroup);
 	if (err) {
 		/* Only log the first time events_limit is incremented. */
 		if (atomic64_inc_return(&pids->events_limit) == 1) {
diff --git a/kernel/exit.c b/kernel/exit.c
index f2afdb0ad..e7abaacfc 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1920,3 +1920,18 @@ __weak __function_aligned void abort(void)
 	panic("Oops failed to kill thread");
 }
 EXPORT_SYMBOL(abort);
+void check_pid_zombie(struct pid_namespace *pid_ns, struct cgroup *cgrp)
+{
+	struct task_struct *tmp, *reaper, *pos;
+	struct cgroup *to;
+
+	reaper = pid_ns->child_reaper;
+	if (list_empty(&reaper->children))
+		return;
+
+	list_for_each_entry_safe(pos, tmp, &reaper->children, sibling) {
+		to = task_cgroup(pos, pids_cgrp_id);
+		if (pos->exit_state == EXIT_ZOMBIE && to == cgrp)
+			release_task(pos);
+	}
+}
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index fc21c5d5f..97ef1261a 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -476,3 +476,98 @@ static __init int pid_namespaces_init(void)
 }
 
 __initcall(pid_namespaces_init);
+struct pid_ns_list *pid_ns_list_init(void)
+{
+	struct pid_ns_list *head;
+
+	head = kmalloc(sizeof(struct pid_ns_list), GFP_KERNEL);
+	if (head == NULL)
+		return NULL;
+
+	INIT_LIST_HEAD(&(head->list));
+	return head;
+}
+
+int pid_ns_list_add_tail(struct pid_ns_list *head, struct pid_namespace *pid_ns)
+{
+	struct pid_ns_list *new_node;
+
+	new_node = kmalloc(sizeof(struct pid_ns_list), GFP_KERNEL);
+	if (new_node == NULL)
+		return -1;
+
+	memset(new_node, 0, sizeof(struct pid_ns_list));
+	new_node->pid_ns = pid_ns;
+
+	list_add_tail(&(new_node->list), &(head->list));
+	return 0;
+}
+
+int pid_ns_list_free(struct pid_ns_list *head)
+{
+	struct pid_ns_list *p, *q;
+
+    list_for_each_entry_safe(p, q, &(head->list), list) {
+		list_del(&(p->list));
+		kfree(p);
+    }
+	list_del(&(head->list));
+	kfree(head);
+	return 0;
+}
+
+int pid_ns_list_delete_elem(struct pid_ns_list *head, struct pid_namespace *pid_ns)
+{
+	struct pid_ns_list *pos;
+
+	if (list_empty(&(head->list)))
+		return -1;
+
+	list_for_each_entry(pos,  &(head->list), list) {
+		if (pos->pid_ns == pid_ns) {
+			list_del(&(pos->list));
+			kfree(pos);
+			return 0;
+		}
+	}
+	return 0;
+}
+
+int pid_ns_list_insert(struct pid_ns_list *head, struct pid_namespace *pid_ns)
+{
+	int err;
+	struct pid_ns_list *pos;
+
+	if (!head)
+		return 0;
+	list_for_each_entry(pos, &(head->list), list) {
+		if (pos->pid_ns == pid_ns)
+			return 0;
+	}
+	err = pid_ns_list_add_tail(head, pid_ns);
+	return err;
+}
+
+extern int zombie_cgrp_insert_ns(struct task_struct *tsk, struct cgroup *cgrp)
+{
+	struct pid *pid;
+	struct pid_namespace *ns;
+	int ret;
+
+	pid = tsk->thread_pid;
+	if (!pid)
+		return 0;
+
+	ns = pid->numbers[pid->level].ns;
+	if (!ns)
+		return 0;
+
+	if (!cgrp)
+		return 0;
+
+	if (!cgrp->pid_list)
+		return 0;
+
+	ret = pid_ns_list_insert(cgrp->pid_list, ns);
+	return ret;
+}
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1c240d2c9..c77f9fc15 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1645,6 +1645,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "recycle_max_limit",
+		.data		= &recycle_max_limit,
+		.maxlen		= sizeof(long),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 #ifdef CONFIG_PROC_SYSCTL
 	{
 		.procname	= "tainted",
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2eee092f8..a601fe6ae 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/kernfs.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -72,6 +73,8 @@
 #include <linux/uaccess.h>
 
 #include <trace/events/vmscan.h>
+long recycle_max_limit = RECYCLE_MEM_MAX;
+EXPORT_SYMBOL(recycle_max_limit);
 
 struct cgroup_subsys memory_cgrp_subsys __read_mostly;
 EXPORT_SYMBOL(memory_cgrp_subsys);
@@ -7814,3 +7817,172 @@ static int __init mem_cgroup_swap_init(void)
 subsys_initcall(mem_cgroup_swap_init);
 
 #endif /* CONFIG_SWAP */
+
+int _obj_cgroup_move(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects, struct obj_cgroup *to)
+{
+	struct obj_cgroup **objcgs;
+	int i;
+
+	objcgs = slab_objcgs(slab);
+	if (!objcgs)
+		return 0;
+
+	for (i = 0; i < objects; i++) {
+		struct obj_cgroup *objcg;
+		unsigned int off;
+
+		off = obj_to_index(s, slab, p[i]);
+		objcg = objcgs[off];
+		if (!objcg)
+			continue;
+		objcgs[off] = to;
+		obj_cgroup_uncharge(objcg, obj_full_size(s));
+		obj_cgroup_charge(to, GFP_KERNEL, obj_full_size(s));
+		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
+				-obj_full_size(s));
+		mod_objcg_state(to, slab_pgdat(slab), cache_vmstat_idx(s),
+				obj_full_size(s));
+	}
+	return 0;
+}
+int kmem_cache_move(struct kmem_cache *s, void *addr, int objects, struct mem_cgroup *to)
+{
+	unsigned long space = mem_cgroup_margin(to);
+
+	s = cache_from_obj(s, addr);
+	if (space < obj_full_size(s))
+		return -1;
+	return _obj_cgroup_move(s, virt_to_slab(addr), &addr, objects, to->objcg);
+}
+int kmem_folio_move(struct folio *folio,  struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	struct obj_cgroup *objcg_to, *objcg_from;
+	int ret;
+	unsigned int order;
+	unsigned long space;
+
+	objcg_to = to->objcg;
+	if (!from || !to)
+		return 0;
+
+	if (!objcg_to)
+		return 0;
+
+	objcg_from = from->objcg;
+	if (!objcg_from)
+		return 0;
+
+	space = mem_cgroup_margin(to);
+	order = folio_order(folio);
+	if (space < (1 << order))
+		return -1;
+
+	__mem_cgroup_uncharge(folio);
+	ret = charge_memcg(folio, to, GFP_KERNEL & ~__GFP_DIRECT_RECLAIM);
+
+	return ret;
+}
+
+int kmem_cgroup_move(void *addr, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	struct folio *folio;
+	struct obj_cgroup *objcg_to, *objcg_from;
+	struct slab *slab;
+	struct kmem_cache *s;
+	unsigned int order;
+	int ret = 0;
+	unsigned long space = mem_cgroup_margin(to);
+
+	folio = virt_to_folio(addr);
+
+	if (folio == NULL)
+		return 0;
+
+	objcg_to = to->objcg;
+	objcg_from = from->objcg;
+	if (objcg_to == NULL || objcg_from == NULL)
+		return 0;
+
+	if (folio_test_slab(folio)) {
+		slab = folio_slab(folio);
+		if (slab == NULL)
+			return 0;
+
+		s = slab->slab_cache;
+		if (s == NULL)
+			return 0;
+
+		if (space < obj_full_size(s))
+			return -1;
+		ret = _obj_cgroup_move(s, virt_to_slab((void *)addr), &addr, 1, objcg_to);
+	} else {
+		order = folio_order(folio);
+
+		if (space < (1 << order))
+			return -1;
+
+		ret = obj_cgroup_charge_pages(objcg_to, GFP_KERNEL & ~__GFP_DIRECT_RECLAIM, 1 << order);
+		if (!ret) {
+			folio->memcg_data = (unsigned long)objcg_to |
+				MEMCG_DATA_KMEM;
+			obj_cgroup_uncharge_pages(objcg_from, 1 << order);
+			return 0;
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL(kmem_cgroup_move);
+extern int obj_cgroup_move(void *addr, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	struct vm_struct *area;
+	int i, ret;
+	unsigned long space = mem_cgroup_margin(to);
+
+	if (is_vmalloc_addr(addr)) {
+		area = find_vm_area(addr);
+		if (area == NULL)
+			return 0;
+
+		if (space < area->nr_pages)
+			return -1;
+
+		for (i = 0; i < area->nr_pages; i++) {
+			struct page *page = area->pages[i];
+
+			if (!page)
+				return 0;
+
+			try_charge(to, GFP_KERNEL & ~__GFP_DIRECT_RECLAIM, 1);
+			mem_cgroup_move_account(page, 0, from, to);
+		}
+	} else {
+		ret = kmem_cgroup_move(addr, from, to);
+	}
+	return ret;
+}
+
+int memory_max_set(struct mem_cgroup *memcg, unsigned long max_pages)
+{
+	if (memcg->memory.max > recycle_max_limit) {
+		xchg(&memcg->memory.max, max_pages);
+		return 0;
+	}
+	if (max_pages > memcg->memory.max)
+		xchg(&memcg->memory.max, max_pages);
+	return 0;
+}
+int page_set_shadow_max(struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	unsigned long from_max = from->memory.max;
+	unsigned long to_max = to->memory.max;
+	unsigned long tmp_from = recycle_max_limit;
+	unsigned long tmp_to = recycle_max_limit;
+
+	if (to_max <  recycle_max_limit)
+		tmp_to = to_max;
+	if (from_max < recycle_max_limit)
+		tmp_from = from_max;
+	memory_max_set(to, max(tmp_from, tmp_to));
+	return 0;
+}
diff --git a/mm/shmem.c b/mm/shmem.c
index 0005ab2c2..9bf756fe7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -39,6 +39,8 @@
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
 #include <linux/iversion.h>
+#include <linux/memcontrol.h>
+#include <linux/ipc_namespace.h>
 #include "swap.h"
 
 static struct vfsmount *shm_mnt;
@@ -4349,3 +4351,36 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 #endif
 }
 EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
+
+extern int ipc_shm_folio_move(struct inode *inode, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	struct address_space *mapping = inode->i_mapping;
+	loff_t lstart = 0;
+	pgoff_t start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pgoff_t end = -1;
+	struct folio_batch fbatch;
+	pgoff_t indices[PAGEVEC_SIZE];
+	struct folio *folio;
+	pgoff_t index;
+	int i;
+	int err = 0;
+
+	folio_batch_init(&fbatch);
+	index = start;
+	while (index < end && find_lock_entries(mapping, &index, end - 1,
+			&fbatch, indices)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			folio = fbatch.folios[i];
+			if (!folio)
+				continue;
+
+			folio_unlock(folio);
+			folio_put(folio);
+			if (err < 0)
+				continue;
+			err = kmem_folio_move(folio, from, to);
+		}
+		fbatch.nr = 0;
+	}
+	return err;
+}
diff --git a/net/core/dev.c b/net/core/dev.c
index fce980d53..b6d5a0fb7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -150,6 +150,12 @@
 #include <linux/pm_runtime.h>
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
+#include <linux/memcontrol.h>
+#include <linux/ref_tracker.h>
+#include <linux/inetdevice.h>
+#include <linux/cgroup.h>
+
+#include <net/neighbour.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -166,7 +172,7 @@ static int call_netdevice_notifiers_extack(unsigned long val,
 					   struct net_device *dev,
 					   struct netlink_ext_ack *extack);
 static struct napi_struct *napi_by_id(unsigned int napi_id);
-
+static int net_device_move(struct net_device *dev, struct mem_cgroup *from, struct mem_cgroup *to);
 /*
  * The @dev_base_head list is protected by @dev_base_lock and the rtnl
  * semaphore.
@@ -381,6 +387,23 @@ static void netdev_name_node_alt_flush(struct net_device *dev)
 static void list_netdevice(struct net_device *dev)
 {
 	struct net *net = dev_net(dev);
+	struct mem_cgroup *memcg;
+	struct cgroup_subsys_state *css;
+	struct cgroup *cgrp;
+	memcg = mem_cgroup_from_task(current);
+
+	if (memcg) {
+		css = &memcg->css;
+		if (css) {
+			cgrp = css->cgroup;
+			if (cgrp) {
+				dev->cgroup = cgrp;
+				if (cgrp->net_list)
+					net_ns_list_insert(cgrp->net_list, net);
+			}
+		}
+	}
+
 
 	ASSERT_RTNL();
 
@@ -733,9 +756,37 @@ EXPORT_SYMBOL_GPL(dev_fill_forward_path);
 struct net_device *__dev_get_by_name(struct net *net, const char *name)
 {
 	struct netdev_name_node *node_name;
+	struct net_device *dev;
+	struct net *ns;
+	struct mem_cgroup *memcg_owner, *memcg_recycle;
+	struct cgroup *cgrp_owner;
 
 	node_name = netdev_name_node_lookup(net, name);
-	return node_name ? node_name->dev : NULL;
+	if (!node_name)
+		return NULL;
+
+	dev = node_name->dev;
+
+	if (recycle_cgroup && dev->cgroup && dev->cgroup == recycle_cgroup) {
+		memcg_owner = mem_cgroup_from_task(current);
+		if (!memcg_owner)
+			return NULL;
+
+		cgrp_owner = memcg_owner->css.cgroup;
+		if (!cgrp_owner)
+			return NULL;
+
+		memcg_recycle = get_cg_from_cgrp(recycle_cgroup, "memory");
+		if (!memcg_recycle)
+			return NULL;
+
+		net_device_move(dev, memcg_recycle, memcg_owner);
+		dev->cgroup = cgrp_owner;
+		ns = current->nsproxy->net_ns;
+		net_ns_list_insert(cgrp_owner->net_list, ns);
+	}
+
+	return dev;
 }
 EXPORT_SYMBOL(__dev_get_by_name);
 
@@ -799,11 +850,33 @@ EXPORT_SYMBOL(dev_get_by_name);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex)
 {
 	struct net_device *dev;
+	struct mem_cgroup *memcg_owner, *memcg_recycle;
+	struct net *ns;
+	struct cgroup *cgrp_owner;
 	struct hlist_head *head = dev_index_hash(net, ifindex);
 
 	hlist_for_each_entry(dev, head, index_hlist)
-		if (dev->ifindex == ifindex)
+		if (dev->ifindex == ifindex) {
+			if (recycle_cgroup && dev->cgroup && dev->cgroup == recycle_cgroup) {
+				memcg_owner = mem_cgroup_from_task(current);
+				if (!memcg_owner)
+					return NULL;
+
+				cgrp_owner = memcg_owner->css.cgroup;
+				if (!cgrp_owner)
+					return NULL;
+
+				memcg_recycle = get_cg_from_cgrp(recycle_cgroup, "memory");
+				if (!memcg_recycle)
+					return NULL;
+
+				net_device_move(dev, memcg_recycle, memcg_owner);
+				dev->cgroup = cgrp_owner;
+				ns = current->nsproxy->net_ns;
+				net_ns_list_insert(cgrp_owner->net_list, ns);
+			}
 			return dev;
+		}
 
 	return NULL;
 }
@@ -11435,3 +11508,114 @@ static int __init net_dev_init(void)
 }
 
 subsys_initcall(net_dev_init);
+
+static int _net_device_move(struct net_device *dev, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	int err;
+	char *addr = (char *)dev - dev->padded;
+	struct inet6_dev *i6_dev;
+	struct in_device *i4_dev;
+
+	err = obj_cgroup_move(dev->_tx, from, to);
+	err = obj_cgroup_move(dev->_rx, from, to);
+	if (err < 0)
+		return err;
+
+	if (rcu_dereference_protected(dev->ingress_queue, 1))
+		err = kmem_cgroup_move(rcu_dereference_protected(dev->ingress_queue, 1), from, to);
+
+	if (rcu_access_pointer(dev->ifalias))
+		err = kmem_cgroup_move(rcu_access_pointer(dev->ifalias), from, to);
+
+	if (&dev->napi_list) {
+		struct napi_struct *p, *n;
+		struct sk_buff *skb;
+
+		list_for_each_entry_safe(p, n, &dev->napi_list, dev_list) {
+			skb = p->skb;
+			err = kmem_cache_move(skbuff_head_cache, skb, 1, to);
+		}
+	}
+	err = obj_cgroup_move(addr, from, to);
+	if (err < 0)
+		return err;
+
+	i4_dev = dev->ip_ptr;
+	if (i4_dev) {
+		err = neigh_move(i4_dev->arp_parms, from, to);
+		err = devinet_move(&i4_dev->cnf, from, to);
+	}
+	if (err < 0)
+		return err;
+
+	i6_dev = __in6_dev_get(dev);
+	if (i6_dev)
+		err = ipv6_dev_move(i6_dev, from, to);
+
+	return err;
+}
+
+static int net_device_move(struct net_device *dev, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	int err;
+	err = _net_device_move(dev, from, to);
+	return err;
+}
+
+extern int net_device_move_check(struct net *ns, struct cgroup *cgrp)
+{
+	struct net_device *ndev, *aux;
+	int clear_times = 5;
+	bool MAX_SET = true;
+	struct mem_cgroup *memcg_to, *memcg_from = get_cg_from_cgrp(cgrp, "memory");
+
+	if (!memcg_from)
+		return 0;
+
+	for_each_netdev_safe(ns, ndev, aux) {
+		if (ndev->cgroup == recycle_cgroup)
+			ndev->residual_time++;
+
+		if (ndev->cgroup == cgrp) {
+			memcg_to = get_cg_from_cgrp(recycle_cgroup, "memory");
+
+			if (MAX_SET) {
+				page_set_shadow_max(memcg_from, memcg_to);
+				MAX_SET = false;
+			}
+
+			ndev->cgroup = recycle_cgroup;
+			ndev->residual_time = 0;
+			net_ns_list_insert(recycle_cgroup->net_list, ns);
+
+			if (net_device_move(ndev, memcg_from, memcg_to) < 0) {
+				recycle_cgroup_clear(clear_times);
+				if (clear_times > 0)
+					clear_times--;
+			}
+		}
+	}
+	return 0;
+}
+
+extern void net_device_free(struct net *ns, int times)
+{
+	struct net_device *ndev, *aux;
+
+	LIST_HEAD(dev_kill_list);
+	rtnl_lock();
+
+	for_each_netdev_safe(ns, ndev, aux) {
+		if (ndev->cgroup == recycle_cgroup && ndev->residual_time >= times) {
+			if (ndev->features & NETIF_F_NETNS_LOCAL)
+				continue;
+			if (ndev->rtnl_link_ops && ndev->rtnl_link_ops->dellink)
+				ndev->rtnl_link_ops->dellink(ndev, &dev_kill_list);
+			else
+				unregister_netdevice_queue(ndev, &dev_kill_list);
+			continue;
+		}
+	}
+	unregister_netdevice_many(&dev_kill_list);
+	rtnl_unlock();
+}
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 4edd2176e..bab455963 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -26,6 +26,7 @@
 #endif
 #include <linux/times.h>
 #include <net/net_namespace.h>
+#include <linux/memcontrol.h>
 #include <net/neighbour.h>
 #include <net/arp.h>
 #include <net/dst.h>
@@ -3904,3 +3905,19 @@ static int __init neigh_init(void)
 }
 
 subsys_initcall(neigh_init);
+extern int neigh_move(struct neigh_parms *neigh_p, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	int err;
+	struct neigh_sysctl_table *neigh_st;
+
+	if (!neigh_p)
+		return 0;
+
+	neigh_st = neigh_p->sysctl_table;
+	if (!neigh_st)
+		return 0;
+
+	err = kmem_cgroup_move(neigh_st, from, to);
+	err = kmem_cgroup_move(neigh_st->sysctl_header, from, to);
+	return err;
+}
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 7b69cf882..745913603 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task.h>
 #include <linux/uidgid.h>
 #include <linux/cookie.h>
+#include <linux/cgroup-defs.h>
 
 #include <net/sock.h>
 #include <net/netlink.h>
@@ -1399,3 +1400,73 @@ const struct proc_ns_operations netns_operations = {
 	.owner		= netns_owner,
 };
 #endif
+
+struct net_ns_list *net_ns_list_init(void)
+{
+	struct net_ns_list *head;
+
+	head = kmalloc(sizeof(*head), GFP_KERNEL);
+	if (!head)
+		return NULL;
+
+	INIT_LIST_HEAD(&head->list);
+	return head;
+}
+
+int net_ns_list_add_tail(struct net_ns_list *head, struct net *net_ns)
+{
+	struct net_ns_list *new_node;
+
+	new_node = kmalloc(sizeof(*new_node), GFP_KERNEL);
+	if (!new_node)
+		return -1;
+
+	memset(new_node, 0, sizeof(struct net_ns_list));
+	new_node->net_ns = net_ns;
+
+	list_add_tail(&new_node->list, &head->list);
+	return 0;
+}
+
+int net_ns_list_free(struct net_ns_list *head)
+{
+	struct net_ns_list *p, *q;
+
+	list_for_each_entry_safe(p, q, &head->list, list) {
+		list_del(&p->list);
+		kfree(p);
+	}
+	list_del(&head->list);
+	kfree(head);
+	return 0;
+}
+
+int net_ns_list_delete_elem(struct net_ns_list *head, struct net *net_ns)
+{
+	struct net_ns_list *pos;
+
+	if (list_empty(&head->list))
+		return -1;
+
+	list_for_each_entry(pos,  &head->list, list) {
+		if (pos->net_ns == net_ns) {
+			list_del(&pos->list);
+			kfree(pos);
+			return 0;
+		}
+	}
+	return -2;
+}
+
+int net_ns_list_insert(struct net_ns_list *head, struct net *net_ns)
+{
+	int err;
+	struct net_ns_list *pos;
+
+	list_for_each_entry(pos, &head->list, list) {
+		if (pos->net_ns == net_ns)
+			return 0;
+	}
+	err = net_ns_list_add_tail(head, net_ns);
+	return err;
+}
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index b0acf6e19..f56180c6f 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -53,6 +53,7 @@
 #endif
 #include <linux/kmod.h>
 #include <linux/netconf.h>
+#include <linux/memcontrol.h>
 
 #include <net/arp.h>
 #include <net/ip.h>
@@ -2793,3 +2794,19 @@ void __init devinet_init(void)
 	rtnl_register(PF_INET, RTM_GETNETCONF, inet_netconf_get_devconf,
 		      inet_netconf_dump_devconf, 0);
 }
+extern int devinet_move(struct ipv4_devconf *ipv4_p, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	int err;
+	struct devinet_sysctl_table *devinet_st;
+
+	if (!ipv4_p)
+		return 0;
+
+	devinet_st = ipv4_p->sysctl;
+	if (!devinet_st)
+		return 0;
+
+	err = kmem_cgroup_move(devinet_st, from, to);
+	err = kmem_cgroup_move(devinet_st->sysctl_header, from, to);
+	return err;
+}
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index faa47f9ea..d5b6ff0c9 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -90,7 +90,7 @@
 #include <linux/seq_file.h>
 #include <linux/export.h>
 #include <linux/ioam6.h>
-
+#include <linux/memcontrol.h>
 #define	INFINITY_LIFE_TIME	0xFFFFFFFF
 
 #define IPV6_MAX_STRLEN \
@@ -7386,3 +7386,31 @@ void addrconf_cleanup(void)
 
 	destroy_workqueue(addrconf_wq);
 }
+
+extern int ipv6_dev_move(struct inet6_dev *in_dev, struct mem_cgroup *from, struct mem_cgroup  *to)
+{
+	int err;
+	struct ctl_table *table;
+	struct ipv6_devconf *p = &in_dev->cnf;
+
+	err = kmem_cgroup_move(in_dev, from, to);
+	if (!in_dev->nd_parms)
+		return 0;
+
+	err = neigh_move(in_dev->nd_parms, from, to);
+	if (!in_dev->stats.icmpv6msgdev)
+		return 0;
+
+	err = kmem_cgroup_move(in_dev->stats.icmpv6msgdev, from, to);
+	table = p->sysctl_header->ctl_table_arg;
+	if (!table)
+		return 0;
+
+	err = kmem_cgroup_move(table, from, to);
+	if (!p->sysctl_header)
+		return 0;
+
+	err = kmem_cgroup_move(p->sysctl_header, from, to);
+
+	return err;
+}
\ No newline at end of file
diff --git a/stuN8OnK b/stuN8OnK
new file mode 100644
index 000000000..e69de29bb
-- 
2.17.1


