Return-Path: <cgroups+bounces-4889-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BCC97A010
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 13:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5281F22DBE
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA1814F11E;
	Mon, 16 Sep 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xOKkjPAN"
X-Original-To: cgroups@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9271514FB
	for <cgroups@vger.kernel.org>; Mon, 16 Sep 2024 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726485121; cv=none; b=rVAV1tBbEM2fJnJreCYJGvnfXQaTId2/RA/qJecDS0jEdf9XKvTQd8aQ8ecEvYhi88MRA0ob0ksWXedRJIU4sJLLl2ISb54+IV3wkDW1YTpldr5Cb1Ih03NjpKc2hlLxy+jq8rdvemDEu9arnAWaHOhQLIvCBlGVkU7ZS/eY07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726485121; c=relaxed/simple;
	bh=CqjTExi0nVJOYYGL4y1xlHEK5+lGpTDJkRCk+Iu/hDk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=D0jnl+y9B8PdwjidqsbmYjU6czFFrpMyEiqr6FuIUKCyR+Dwv+oUdtE03Lph/+w9ZEfkO6FpLW7E6GTqvCToSRXCWIPzMGPKM4PLzKGElFD2By6lux5I/E58Jd+locF4aH66t3Y+0pFcFBNCsI2qzhEGDDI7O7yNp5DLbfCZ++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xOKkjPAN; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1726484786;
	bh=d+5l5yBy7julBAMQ4hwQH0GuJOA3l2oUT47tpoixet4=;
	h=From:To:Cc:Subject:Date;
	b=xOKkjPANSapmLMn3/bWtxvNevz5/JCjqkNGpoBZR7/T7xQ3knzZkx49MTWYnzAHrE
	 om71FEfkH71OnXR4LDYjd5Pbah1GmF06GYZWmtOD2btaxcdo8/aX6hjB2PjLOBFEM2
	 E2t7REPVCVdV4OjWJzSe9fzjLWbb0VtW4NjMYvqQ=
Received: from liuweijie-Inspiron-5502.. ([180.213.133.106])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 10B1961F; Mon, 16 Sep 2024 19:04:11 +0800
X-QQ-mid: xmsmtpt1726484651trz6p6hyi
Message-ID: <tencent_07DB577F971DBB31388C3A51807914977E08@qq.com>
X-QQ-XMAILINFO: OcN56dxiYj5Th4I3yCsoOBoEjabTUrmF7TLiFFi/lkK5sxelnGZM78d2adpqlG
	 XQZKxfThcoF4K7hBpNloSP8GoSOUeC2BewtGvhwFjM4JzNw9oCTU5K+RIkXWfWq62whMDNpw9wQ7
	 zwZjT4o8IdQkrd+i09Euo4pG4Fo27DL6M4D1090aOUqINS5cXhTUKMzcdYtoqhtQ+9Xl7LLoKd9a
	 w8T4Y/dkmogdGRAux3TZygLJO8pO0r71EjyUrxhC8AHbF2sedY7jy2AkI06g0+l4KZPQ3I3kNK5o
	 sZDfSRAbZZACEih++tPcTh9yXOc/VUqsRELYbiivECjK0mDsbH0yHbZ2ybKAAZC55ramcwWf6gIb
	 MdIFZfO+ALDj41IT2D0hVCKK9CmV5b6HqvI5JjuKCPDMWTa8RWX/6ayCD1vORKVyxjdIxJhbhLP0
	 J8TdjMsHrbLT48oNUZiQsdMSXUrduE4GhCA1VKpAkC1taXCzXcibvufP/yPKzEzjP/MnS2BmPRKv
	 8N8xWkwe1hdc2NDJhlMcSL/vILxfpFnCB6MmZ6M8aKmHr0mjeuOns88o7AXb92ipUAKzNq6HQAMq
	 ZJpY+pyhpIuI47JBWkXmtYQedhTs1kY4IL2DnzqoYC4hBIuWm0NejR2qzUZnGWI3dI/U53gMY7xf
	 KvD4ddulr9HHdpM2TJXMUtg5vPbG/UCE+MIaKqIsddyowgnT2SX6dgDEd9adGPcMQKvk4aJU+Hd8
	 i7hJ1smZPp5y3LJZVo0VNpYvohjfDxYz8ysFbvEmLW22ii/FisbxAAA524KiWIk0tds31ZlwNDuY
	 xcKaZ/O6ccV7MGrerT2yz37kPagQPIm/uAWO+lynVAgCg/zUKV1BNoksZjjLlvPVqDdQyvtKfv6J
	 G3b3Wbyh8hBQHJ1j45TtghEo1/U+elr7fWDUxfJy7tALvT9CJCndkjR4jbOlVWdwcB+LzIdMgtvz
	 JuykrJ89cYoVWiuLnXo+D4KmHIe+yE5d1KEMWr84C92nJa5hWaw386X0myHb3h0kJIQQsYDdMmZK
	 RMm0jsH/wgG3DEv0r1yXbkzFlORq9rQxR2eY+Bo8aimzVwvXcmmgeTGZ9fURQ=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: StanPlatinum <liuwj0129@foxmail.com>
To: tj@kernel.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	weijieliu@nankai.edu.cn,
	lizhi16@hust.edu.cn,
	15086729272@163.com,
	StanPlatinum <liuwj0129@foxmail.com>
Subject: [PATCH] Proposal of Integrating Namespaces and Cgroups for Enhanced Resource Management
Date: Mon, 16 Sep 2024 19:03:57 +0800
X-OQ-MSGID: <20240916110357.7947-1-liuwj0129@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear Tejun,

Thank you for your feedback on our previous patch titled "<Integrating Namespaces and Cgroups for Enhanced Resource Management>". We have carefully reviewed the comments and have made the necessary adjustments to the patch to align with the Linux kernel development conventions.

Here are the main changes we have made:

1. We have adjusted the version to the linux-next version.

2. We have used `scripts/checkpatch.pl` to check our patch and have achieved 0 warnings and 0 errors.

We believe these revisions will make the patch more suitable for consideration and increase the likelihood of it being accepted.

Attached you will find the revised patch. Thank you for your time and assistance.
Below is the content of the previous email for reference.

---

Recently, we found some vulnerabilities/bugs in container runtimes (Docker, Kubernetes, Podman, etc.), discovering that the 'rolling updates' function is vulnerable to DoS attacks. Exploiting such a problem, the attacker can bypass the cgroup limit and exhaust the host memory.

The 'IPC=shareable' option enables multiple containers to share the same IPC namespace. One of these containers (container A) can constantly create IPC resources under its cgroup's memory restriction to communicate with other containers (container B) in the same IPC namespace. The memory usage of these IPC resources is counted by the cgroup of container A, and this count will be cleared if container A exits. However, these IPC resources are not released after the exit of container A but are destroyed with the end of this container's IPC namespace. This means that these IPC resources will continue to occupy memory if container B does not exit. In this case, attackers can start two containers in the 'IPC=shareable' mode and repetitively restart one of the containers to ignore the cgroup restriction. This restarted container can create lots of IPC resources until it exhausts the host’s memory.

The same thing will happen when using the 'rolling updates' in Kubernetes. By modifying the ‘spec.containers[*].image’ field, Kubernetes will update a pod by creating a container with the new image to replace the old container. The replacement will reset the new container’s memory counts in cgroup but does not release the IPC resources allocated to the old container. An attacker can repeat the rolling update and IPC resources allocation to bypass cgroup restrictions, which will exhaust the host’s memory eventually. Our research reveals that popular container tools, including Docker, Podman, and Kubernetes, all involve this namespace-cgroup desynchronization vulnerability.

We have reported those issues to Podman/Kubernetes/Docker. When we talk with them, we get a piece of information that this kind of vulnerability might be caused by the Linux kernel. The main insight is that the isolation offered by containers (leveraging Linux namespaces and cgroups) is achieved in a highly coordinated way. This foundation for container protection, however, has been shaken by the evolution of computing paradigms, particularly the emergence of serverless computing with strong demands for resource sharing across namespaces. Such sharing weakens the container's isolation model. We conduct a serious study on such risks, aiming at identifying their root causes and understanding their implications.


Summary of Namespace-Cgroup Desynchronization Vulnerabilities

While individual containers maintain namespace and cgroup synchrony, shared namespaces disrupt this balance. Termination of a container does not dissolve shared namespaces, leaving allocated resources accessible to others, untracked by the destroyed cgroup.


Our Approach

Therefore, this patch would like to solve such namespace-cgroup desynchronization vulnerabilities by merging namespace-based resource management with cgroup-enforced restrictions. The primary objective is to address the potential desynchronization between namespaces and cgroups, particularly in multi-container environments where shared namespaces can evade cgroup constraints.


Key Highlights

Unified Resource Tracking: Introduces a unified balloon cgroup to oversee resources that have eluded cgroup limitations, ensuring consistent management across shared namespaces.

Enhanced Namespace-Cgroup Synchronization: Integrates namespace chains into the cgroup structure, tagging shared resources like memory and IPC objects to monitor bypassed restrictions.


Patch Implementation Details

1) Namespace-Cgroup Linkage and Resource Tagging: Extends cgroup structure to track namespaces associated with processes within a cgroup, ensuring resource accountability. Assigns cgroup tags to virtual resources, facilitating precise tracking and management.

To mitigate the vulnerabilities, this patch bridges the namespace and the cgroups by placing a cgroup tag on all the resources mentioned above. These tags identify which cgroup is responsible for charging and restricting these resources. Furthermore, this tag can be used to identify the residual resources which belongs to the exiting cgroup.

2) Balloon Cgroup Setup: Establishes a universal cgroup for residual resources, with configurable limits to prevent system-wide resource overflow.

To re-manage these residual resources. this patch creates a balloon cgroup specifically for limiting these residual resources. First, resources requested by each container are tagged with the cgroup of that container. When a cgroup is about to be destroyed, the patch will reclaim the resources and transfer all the resources and their records to the balloon cgroup. Later, when a container reuses these resources, the residual resources become owned by the container in need, are tagged and governed by the container’s cgroup, and are removed from the balloon cgroup.

3) Resource Reallocation: Transforms and reallocates residual resources to active containers, maintaining cgroup governance.

The resources that are shared between the containers through a sharing namespace are transformed to the balloon cgroup and tagged as residual resources when the container exits. When these residual resources are reused, they will be transformed into the cgroup of the user.
The balloon cgroup is equipped with a dedicated queue that meticulously tracks the residual resources associated with that namespace. Upon reaching full capacity, release all the resources in the queue with the highest volume of residual resources.


This patch not only strengthens the Linux kernel's resource management framework but also enhances security and efficiency in containerized environments. We expect the community to take heed of this issue and collaborate in enhancing the security of cgroups.

Hope we can discuss about it.

Best regards!



Signed-off-by: StanPlatinum <liuwj0129@foxmail.com>
---
 include/linux/cgroup-defs.h   |  33 +++
 include/linux/cgroup.h        |   2 +
 include/linux/inetdevice.h    |   7 +-
 include/linux/ipc.h           |   2 +
 include/linux/ipc_namespace.h |  15 +
 include/linux/memcontrol.h    |  18 ++
 include/linux/netdevice.h     |   4 +
 include/linux/pid_namespace.h |   1 +
 include/linux/sem.h           |   2 +
 include/net/neighbour.h       |   2 +
 include/net/net_namespace.h   |   1 +
 ipc/msg.c                     | 179 +++++++++++-
 ipc/msgutil.c                 |  22 ++
 ipc/namespace.c               |  27 ++
 ipc/sem.c                     | 180 +++++++++++-
 ipc/shm.c                     | 202 +++++++++++++-
 ipc/util.c                    |   2 +-
 ipc/util.h                    |   1 +
 kernel/cgroup/cgroup.c        | 498 +++++++++++++++++++++++++++++++++-
 kernel/cgroup/pids.c          |  41 ++-
 kernel/exit.c                 |  25 ++
 kernel/sysctl.c               |   7 +
 mm/memcontrol-v1.c            |   2 +-
 mm/memcontrol-v1.h            |   8 +
 mm/memcontrol.c               | 198 ++++++++++++++
 mm/shmem.c                    |  65 +++++
 mm/slab.h                     |   1 +
 mm/slub.c                     |   2 +-
 net/core/dev.c                | 266 +++++++++++++++++-
 net/core/neighbour.c          |  35 +++
 net/ipv4/devinet.c            |  35 +++
 net/ipv6/addrconf.c           |  57 ++++
 32 files changed, 1927 insertions(+), 13 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 47ae4c4d924c..d3467412a6f6 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -411,6 +411,39 @@ struct cgroup_freezer_state {
 	int nr_frozen_tasks;
 };
 
+#define CGROUP_NS_HASH_COUNT 2048
+#define BALLOON_CGROUP_HASH_COUNT 2048
+struct cgroup_ns_entry {
+	struct hlist_node hnode;
+	struct cgroup *cgroup;
+	struct ipc_namespace *ipc_ns;
+	struct net *net_ns;
+	struct pid_namespace *pid_ns;
+};
+
+struct balloon_cgroup_entry {
+	struct hlist_node hnode;
+	struct cgroup *balloon_cgroup;
+	struct cgroup *cgroup;
+};
+
+extern struct hlist_head *cg_ns_map;
+extern struct hlist_head *balloon_to_cgroup;
+extern int cg_ns_insert(struct cgroup *cgroup, struct ipc_namespace *ipc_ns,
+				struct net *net_ns, struct pid_namespace *pid_ns);
+extern struct cgroup *find_shared_cg(struct ipc_namespace *ipc_ns, struct net *net_ns,
+				struct pid_namespace *pid_ns, const struct cgroup *cgroup);
+extern int delete_cg_ns_node(struct hlist_head *head, struct cgroup *cgroup);
+
+extern int init_hash_balloon_cg(void);
+extern unsigned int find_balloon_index_from_cgroup(struct cgroup *cgroup);
+extern struct cgroup *find_balloon_from_cgroup(struct cgroup *cgroup);
+extern int insert_cgroup_to_balloon(struct hlist_head *head, struct cgroup *cgroup,
+				struct cgroup *balloon_cgroup);
+extern int init_balloon_cgroup_to_balloon(struct hlist_head *head, struct cgroup *balloon_cgroup);
+extern int delete_balloon_cgroup_node(struct hlist_head *head, struct cgroup *cgroup);
+
+extern struct cgroup *balloon_cgroup_create(unsigned int index);
 struct cgroup {
 	/* self css with NULL ->ss, points back to this cgroup */
 	struct cgroup_subsys_state self;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f8ef47f8a634..534561016008 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -70,6 +70,7 @@ extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
 extern spinlock_t css_set_lock;
+extern struct cgroup *init_balloon;
 
 #define SUBSYS(_x) extern struct cgroup_subsys _x ## _cgrp_subsys;
 #include <linux/cgroup_subsys.h>
@@ -858,3 +859,4 @@ struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id);
 struct cgroup_of_peak *of_peak(struct kernfs_open_file *of);
 
 #endif /* _LINUX_CGROUP_H */
+extern int free_oldest_volume(struct cgroup *target_cgroup, unsigned int limit);
diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index cb5280e6cc21..84d6bdb8d3f5 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -301,5 +301,10 @@ static __inline__ int inet_mask_len(__be32 mask)
 	return 32 - ffz(~hmask);
 }
 
-
+extern unsigned long devinet_size(struct ipv4_devconf *ipv4_p);
+extern int devinet_move(struct ipv4_devconf *ipv4_p, struct mem_cgroup *from,
+				struct mem_cgroup *to);
+extern int ipv6_dev_move(struct inet6_dev *in_dev, struct mem_cgroup  *from,
+				struct mem_cgroup  *to);
+extern unsigned long ipv6_size(struct inet6_dev *in_dev);
 #endif /* _LINUX_INETDEVICE_H */
diff --git a/include/linux/ipc.h b/include/linux/ipc.h
index 9b1434247aab..2180e6fb2741 100644
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
diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index e8240cf2611a..437f7100204c 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -12,6 +12,8 @@
 #include <linux/rhashtable-types.h>
 #include <linux/sysctl.h>
 #include <linux/percpu_counter.h>
+#include <linux/cgroup-defs.h>
+#include <linux/msg.h>
 
 struct user_namespace;
 
@@ -211,3 +213,16 @@ static inline bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
 #endif /* CONFIG_SYSVIPC_SYSCTL */
 #endif
+void free_recycle_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
+	       void (*free)(struct ipc_namespace *, struct kern_ipc_perm *), unsigned int limit);
+extern int ipc_sem_move_check(struct ipc_namespace *ns, struct cgroup *cgrp);
+extern void ipc_sem_free(struct ipc_namespace *ns, unsigned int limit);
+
+extern int ipc_shm_move_check(struct ipc_namespace *ns, struct cgroup *cgrp);
+extern int ipc_shm_folio_move(struct inode *inode, struct mem_cgroup *from, struct mem_cgroup *to);
+extern unsigned long shm_total_pages(struct inode *inode);
+extern void ipc_shm_free(struct ipc_namespace *ns, unsigned int limit);
+
+extern int ipc_msq_move_check(struct ipc_namespace *ns, struct cgroup *cgrp);
+extern int ipc_msg_move(struct msg_msg *msg, struct mem_cgroup *from, struct mem_cgroup *to);
+extern void ipc_msq_free(struct ipc_namespace *ns, unsigned int limit);
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2ef94c74847d..b65a58f0bfb2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -23,6 +23,8 @@
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
 #include <linux/shrinker.h>
+#include <linux/device.h>
+#include <linux/cgroup-defs.h>
 
 struct mem_cgroup;
 struct obj_cgroup;
@@ -1952,4 +1954,20 @@ static inline void mem_cgroup_exit_user_fault(void)
 
 #endif /* CONFIG_MEMCG_V1 */
 
+extern int _obj_cgroup_move(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects, struct obj_cgroup *to);
+extern int kmem_cache_move(struct kmem_cache *s, void *addr,
+					 int objects, struct mem_cgroup *to);
+extern int obj_cgroup_move(void *addr, struct mem_cgroup *from, struct mem_cgroup *to);
+extern int kmem_folio_move(struct folio *folio,  struct mem_cgroup *from, struct mem_cgroup *to);
+
+extern struct mem_cgroup *get_cg_from_cgrp(struct cgroup *cgrp, const char *subsys_name);
+
+#define RECYCLE_MEM_MAX (1 << 15)
+extern long recycle_max_limit;
+extern int page_set_balloon_max(struct mem_cgroup *memcg);
+extern int kmem_cgroup_move(void *addr, struct mem_cgroup *from, struct mem_cgroup *to);
+extern unsigned long caculate_space(void *addr);
+int check_balloon_limits(unsigned long mem_delta, struct mem_cgroup *memcg_balloon);
+
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ca5f0dda733b..00c0f96f64b9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2092,6 +2092,9 @@ struct net_device {
 	char			name[IFNAMSIZ];
 	struct netdev_name_node	*name_node;
 	struct dev_ifalias	__rcu *ifalias;
+
+	struct cgroup *cgroup;
+	unsigned int residual_time;
 	/*
 	 *	I/O specific fields
 	 *	FIXME: Merge these and struct ifmap into one
@@ -5229,3 +5232,4 @@ extern struct net_device *blackhole_netdev;
 #define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__##FIELD)
 
 #endif	/* _LINUX_NETDEVICE_H */
+extern int net_device_move_check(struct net *ns, struct cgroup *cgrp);
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index f9f9931e02d6..13e29f1d814f 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -124,3 +124,4 @@ static inline bool task_is_in_init_pid_ns(struct task_struct *tsk)
 }
 
 #endif /* _LINUX_PID_NS_H */
+extern void check_pid_zombie(struct pid_namespace *pid_ns, struct cgroup *cgrp);
diff --git a/include/linux/sem.h b/include/linux/sem.h
index c4deefe42aeb..e002b248cdf9 100644
--- a/include/linux/sem.h
+++ b/include/linux/sem.h
@@ -7,11 +7,13 @@
 
 struct task_struct;
 
+struct sem_array;
 #ifdef CONFIG_SYSVIPC
 
 extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
 extern void exit_sem(struct task_struct *tsk);
 
+extern struct sem_array *find_sem_from_perm(struct kern_ipc_perm *perm);
 #else
 
 static inline int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index a44f262a7384..1c648a808fa1 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -601,3 +601,5 @@ static inline void neigh_update_is_router(struct neighbour *neigh, u32 flags,
 	}
 }
 #endif
+extern int neigh_move(struct neigh_parms *neigh_p, struct mem_cgroup *from, struct mem_cgroup *to);
+extern unsigned long neigh_size(struct neigh_parms *neigh_p);
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index e67b483cc8bb..297c1c9869f3 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -556,3 +556,4 @@ static inline void net_ns_init(void) {}
 #endif
 
 #endif /* __NET_NET_NAMESPACE_H */
+extern void net_device_free(struct net *ns, unsigned int limit);
diff --git a/ipc/msg.c b/ipc/msg.c
index fd08b3cb36d7..c3ef9c550ec9 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -40,6 +40,7 @@
 #include <linux/ipc_namespace.h>
 #include <linux/rhashtable.h>
 #include <linux/percpu_counter.h>
+#include <linux/memcontrol.h>
 
 #include <asm/current.h>
 #include <linux/uaccess.h>
@@ -98,6 +99,8 @@ struct msg_sender {
 #define SEARCH_NUMBER		5
 
 #define msg_ids(ns)	((ns)->ids[IPC_MSG_IDS])
+struct msg_queue *find_msq_from_perm(struct kern_ipc_perm *perm);
+static int ipc_msq_move(struct msg_queue *msq, struct mem_cgroup *from, struct mem_cgroup *to);
 
 static inline struct msg_queue *msq_obtain_object(struct ipc_namespace *ns, int id)
 {
@@ -295,9 +298,67 @@ static void freeque(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 	ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
 }
 
+static int ipc_msq_size(struct msg_queue *msq)
+{
+	return caculate_space(msq);
+}
+
+static void msg_tag(struct kern_ipc_perm *ipcp, struct nsproxy *ns)
+{
+	struct msg_queue *msq;
+	struct mem_cgroup *memcg_owner, *memcg_recycle;
+	struct cgroup *cgrp_owner, *balloon_cgrp, *shared_cgrp;
+	unsigned int balloon_index;
+
+	memcg_owner = mem_cgroup_from_task(current);
+	if (!memcg_owner)
+		return;
+
+	cgrp_owner = memcg_owner->css.cgroup;
+	if (!cgrp_owner)
+		return;
+
+	shared_cgrp = find_shared_cg(ns->ipc_ns, NULL, NULL, cgrp_owner);
+	cg_ns_insert(cgrp_owner, ns->ipc_ns, NULL, NULL);
+
+	if (!ipcp)
+		return;
+	if (!shared_cgrp) {
+		balloon_index = find_balloon_index_from_cgroup(cgrp_owner);
+		if (balloon_index > BALLOON_CGROUP_HASH_COUNT) {
+			ipcp->cgroup = cgrp_owner;
+			ipcp->residual_time = 0;
+			return;
+		}
+		insert_cgroup_to_balloon(&balloon_to_cgroup[balloon_index], cgrp_owner, NULL);
+	} else {
+		balloon_cgrp = find_balloon_from_cgroup(shared_cgrp);
+		balloon_index = find_balloon_index_from_cgroup(shared_cgrp);
+		insert_cgroup_to_balloon(&balloon_to_cgroup[balloon_index],
+						cgrp_owner, balloon_cgrp);
+
+		if (ipcp->cgroup && balloon_cgrp && ipcp->cgroup == balloon_cgrp) {
+			msq = find_msq_from_perm(ipcp);
+			if (!msq)
+				return;
+			memcg_recycle = get_cg_from_cgrp(balloon_cgrp, "memory");
+			ipc_msq_move(msq, memcg_recycle, memcg_owner);
+		}
+	}
+	ipcp->cgroup = cgrp_owner;
+	ipcp->residual_time = 0;
+}
+
+extern void ipc_msq_free(struct ipc_namespace *ns, unsigned int limit)
+{
+	free_recycle_ipcs(ns, &msg_ids(ns), freeque, limit);
+}
+
 long ksys_msgget(key_t key, int msgflg)
 {
 	struct ipc_namespace *ns;
+	int err;
+	struct kern_ipc_perm *ipcp;
 	static const struct ipc_ops msg_ops = {
 		.getnew = newque,
 		.associate = security_msg_queue_associate,
@@ -309,7 +370,20 @@ long ksys_msgget(key_t key, int msgflg)
 	msg_params.key = key;
 	msg_params.flg = msgflg;
 
-	return ipcget(ns, &msg_ids(ns), &msg_ops, &msg_params);
+	err = ipcget(ns, &msg_ids(ns), &msg_ops, &msg_params);
+	if (err >= 0) {
+		down_write(&msg_ids(ns).rwsem);
+		ipcp = ipc_findkey(&msg_ids(ns), key);
+
+		msg_tag(ipcp, current->nsproxy);
+		if (!ipcp)
+			goto no_lock;
+		ipc_unlock(ipcp);
+
+no_lock:
+		up_write(&msg_ids(ns).rwsem);
+	}
+	return err;
 }
 
 SYSCALL_DEFINE2(msgget, key_t, key, int, msgflg)
@@ -1374,3 +1448,106 @@ void __init msg_init(void)
 				"       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n",
 				IPC_MSG_IDS, sysvipc_msg_proc_show);
 }
+
+struct msg_queue *find_msq_from_perm(struct kern_ipc_perm *perm)
+{
+	struct msg_queue *msq = container_of(perm, struct msg_queue, q_perm);
+	return msq;
+}
+
+static int ipc_msq_move(struct msg_queue *msq, struct mem_cgroup *from, struct mem_cgroup *to)
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
+	int next_id, i;
+	int total, in_use;
+	struct msg_queue *msq;
+	unsigned int balloon_index;
+	struct cgroup *balloon_cgroup;
+	unsigned long mem_volume;
+	struct mem_cgroup *memcg_to, *memcg_from = get_cg_from_cgrp(cgrp, "memory");
+
+	ids = &msg_ids(ns);
+	if (ids == NULL)
+		return 0;
+
+	if (memcg_from == NULL)
+		return 0;
+
+	in_use = ids->in_use;
+	balloon_cgroup = find_balloon_from_cgroup(cgrp);
+
+	for (total = 0, next_id = 0; total < in_use; next_id++) {
+		perm = idr_find(&ids->ipcs_idr, next_id);
+		if (perm == NULL)
+			continue;
+
+		msq = find_msq_from_perm(perm);
+		if (msq == NULL)
+			continue;
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
+		if (balloon_cgroup && perm->cgroup == balloon_cgroup)
+			perm->residual_time++;
+
+		if (perm->cgroup == cgrp) {
+			if (!balloon_cgroup) {
+				balloon_index = find_balloon_index_from_cgroup(cgrp);
+				balloon_cgroup = balloon_cgroup_create(balloon_index);
+				init_balloon_cgroup_to_balloon(&balloon_to_cgroup[balloon_index],
+								balloon_cgroup);
+				memcg_to = get_cg_from_cgrp(balloon_cgroup, "memory");
+				page_set_balloon_max(memcg_to);
+			}
+			memcg_to = get_cg_from_cgrp(balloon_cgroup, "memory");
+			if (!memcg_to)
+				return 0;
+
+			mem_volume = ipc_msq_size(msq);
+			if (check_balloon_limits(mem_volume, memcg_to)) {
+				for (i = 5; i > 0; i--) {
+					free_oldest_volume(cgrp, i);
+					cond_resched();
+					if (!check_balloon_limits(mem_volume, memcg_to))
+						goto move_resources;
+				}
+				down_write(&msg_ids(ns).rwsem);
+				rcu_read_lock();
+				ipc_lock_object(perm);
+				freeque(ns, perm);
+				up_write(&msg_ids(ns).rwsem);
+				total++;
+				continue;
+			}
+move_resources:
+			perm->cgroup = balloon_cgroup;
+			perm->residual_time = 1;
+			ipc_msq_move(msq, memcg_from, memcg_to);
+		}
+		total++;
+	}
+	return 0;
+}
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index c7be0c792647..459a9610e9ea 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -15,6 +15,7 @@
 #include <linux/proc_ns.h>
 #include <linux/uaccess.h>
 #include <linux/sched.h>
+#include <linux/memcontrol.h>
 
 #include "util.h"
 
@@ -193,3 +194,24 @@ void free_msg(struct msg_msg *msg)
 		seg = tmp;
 	}
 }
+
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
index 6ecc30effd3e..d8421bcc8f08 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -16,6 +16,8 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
+#include <linux/cgroup-defs.h>
+#include <linux/cgroup.h>
 
 #include "util.h"
 
@@ -256,3 +258,28 @@ const struct proc_ns_operations ipcns_operations = {
 	.install	= ipcns_install,
 	.owner		= ipcns_owner,
 };
+
+void free_recycle_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
+	       void (*free)(struct ipc_namespace *, struct kern_ipc_perm *), unsigned int limit)
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
+		if (perm->residual_time >= limit) {
+			rcu_read_lock();
+			ipc_lock_object(perm);
+			free(ns, perm);
+		}
+		total++;
+	}
+	up_write(&ids->rwsem);
+}
diff --git a/ipc/sem.c b/ipc/sem.c
index a39cdc7bf88f..32bae46952ca 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -87,6 +87,9 @@
 #include <linux/sched/wake_q.h>
 #include <linux/nospec.h>
 #include <linux/rhashtable.h>
+#include <linux/cgroup-defs.h>
+#include <linux/memcontrol.h>
+#include <linux/page_counter.h>
 
 #include <linux/uaccess.h>
 #include "util.h"
@@ -599,9 +602,171 @@ static int sem_more_checks(struct kern_ipc_perm *ipcp, struct ipc_params *params
 	return 0;
 }
 
+struct sem_array *find_sem_from_perm(struct kern_ipc_perm *perm)
+{
+	struct sem_array *sma = container_of(perm, struct sem_array, sem_perm);
+	return sma;
+}
+
+static unsigned long ipc_sem_size(struct sem_array *sma)
+{
+	return caculate_space(sma);
+}
+
+static int ipc_sem_move(struct sem_array *sma, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	return obj_cgroup_move(sma, from, to);
+}
+
+void ipc_sem_free(struct ipc_namespace *ns, unsigned int limit)
+{
+	free_recycle_ipcs(ns, &sem_ids(ns), freeary, limit);
+}
+
+int ipc_sem_move_check(struct ipc_namespace *ns, struct cgroup *cgrp)
+{
+	struct ipc_ids *ids;
+	struct kern_ipc_perm *perm;
+	int next_id, i;
+	int total, in_use;
+	struct sem_array *sma;
+	unsigned long mem_volume;
+	unsigned int balloon_index;
+	struct cgroup *balloon_cgroup;
+	struct mem_cgroup *memcg_to, *memcg_from = get_cg_from_cgrp(cgrp, "memory");
+
+	ids =  &sem_ids(ns);
+
+	if (ids == NULL)
+		return 0;
+
+	if (memcg_from == NULL)
+		return 0;
+
+	in_use = ids->in_use;
+	balloon_cgroup = find_balloon_from_cgroup(cgrp);
+
+	for (total = 0, next_id = 0; total < in_use; next_id++) {
+		perm = idr_find(&ids->ipcs_idr, next_id);
+		if (perm == NULL)
+			continue;
+
+		sma = find_sem_from_perm(perm);
+
+		if (sma == NULL)
+			continue;
+
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
+		if (balloon_cgroup && perm->cgroup == balloon_cgroup)
+			perm->residual_time++;
+
+		if (perm->cgroup == cgrp) { //belongs to the exiting cgorup.
+			if (!balloon_cgroup) {
+				balloon_index = find_balloon_index_from_cgroup(cgrp);
+				balloon_cgroup = balloon_cgroup_create(balloon_index);
+				if (balloon_cgroup == NULL)
+					return 0;
+
+				init_balloon_cgroup_to_balloon(&balloon_to_cgroup[balloon_index],
+							balloon_cgroup);
+				memcg_to = get_cg_from_cgrp(balloon_cgroup, "memory");
+				if (memcg_to == NULL)
+					return 0;
+
+				page_set_balloon_max(memcg_to);
+			}
+			memcg_to = get_cg_from_cgrp(balloon_cgroup, "memory");
+			if (!memcg_to)
+				return 0;
+
+			mem_volume = ipc_sem_size(sma);
+			if (check_balloon_limits(mem_volume, memcg_to)) {
+				for (i = 5; i > 0; i--) {
+					free_oldest_volume(cgrp, i);
+					cond_resched();
+					if (!check_balloon_limits(mem_volume, memcg_to))
+						goto move_resources;
+				}
+				down_write(&sem_ids(ns).rwsem);
+				rcu_read_lock();
+				ipc_lock_object(perm);
+				freeary(ns, perm);
+				up_write(&sem_ids(ns).rwsem);
+				total++;
+				continue;
+			}
+move_resources:
+			perm->cgroup = balloon_cgroup;
+			perm->residual_time = 1;
+			ipc_sem_move(sma, memcg_from, memcg_to);
+		}
+		total++;
+	}
+	return 0;
+}
+
+
+static void sem_tag(struct kern_ipc_perm *ipcp, struct nsproxy *ns)
+{
+	struct sem_array *sma;
+	struct mem_cgroup *memcg_owner, *memcg_recycle;
+	struct cgroup *cgrp_owner, *balloon_cgrp, *shared_cgrp;
+	unsigned int balloon_index;
+
+	memcg_owner = mem_cgroup_from_task(current);
+	if (!memcg_owner)
+		return;
+
+	cgrp_owner = memcg_owner->css.cgroup;
+	if (!cgrp_owner)
+		return;
+
+	shared_cgrp = find_shared_cg(ns->ipc_ns, NULL, NULL, cgrp_owner);
+	cg_ns_insert(cgrp_owner, ns->ipc_ns, NULL, NULL);
+
+	if (!ipcp)
+		return;
+
+	if (!shared_cgrp) {
+		balloon_index = find_balloon_index_from_cgroup(cgrp_owner);
+
+		if (balloon_index > BALLOON_CGROUP_HASH_COUNT) {
+			ipcp->cgroup = cgrp_owner;
+			ipcp->residual_time = 0;
+			return;
+		}
+		insert_cgroup_to_balloon(&balloon_to_cgroup[balloon_index], cgrp_owner, NULL);
+	} else {
+		balloon_cgrp = find_balloon_from_cgroup(shared_cgrp);
+		balloon_index = find_balloon_index_from_cgroup(shared_cgrp);
+		insert_cgroup_to_balloon(&balloon_to_cgroup[balloon_index], cgrp_owner,
+						balloon_cgrp);
+		if (ipcp->cgroup && balloon_cgrp && ipcp->cgroup == balloon_cgrp) {
+			sma = find_sem_from_perm(ipcp);
+			if (!sma)
+				return;
+			memcg_recycle = get_cg_from_cgrp(balloon_cgrp, "memory");
+			ipc_sem_move(sma, memcg_recycle, memcg_owner);
+		}
+	}
+	ipcp->cgroup = cgrp_owner;
+	ipcp->residual_time = 0;
+}
+
 long ksys_semget(key_t key, int nsems, int semflg)
 {
 	struct ipc_namespace *ns;
+	int err;
+	struct kern_ipc_perm *ipcp;
 	static const struct ipc_ops sem_ops = {
 		.getnew = newary,
 		.associate = security_sem_associate,
@@ -618,7 +783,20 @@ long ksys_semget(key_t key, int nsems, int semflg)
 	sem_params.flg = semflg;
 	sem_params.u.nsems = nsems;
 
-	return ipcget(ns, &sem_ids(ns), &sem_ops, &sem_params);
+	err = ipcget(ns, &sem_ids(ns), &sem_ops, &sem_params);
+	if (err >= 0) {
+		down_write(&sem_ids(ns).rwsem);
+		ipcp = ipc_findkey(&sem_ids(ns), key);
+
+		sem_tag(ipcp, current->nsproxy);
+
+		if (!ipcp)
+			goto no_lock;
+		ipc_unlock(ipcp);
+no_lock:
+		up_write(&sem_ids(ns).rwsem);
+	}
+	return err;
 }
 
 SYSCALL_DEFINE3(semget, key_t, key, int, nsems, int, semflg)
diff --git a/ipc/shm.c b/ipc/shm.c
index 99564c870084..315601fdd0ea 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -45,6 +45,7 @@
 #include <linux/mount.h>
 #include <linux/ipc_namespace.h>
 #include <linux/rhashtable.h>
+#include <linux/memcontrol.h>
 
 #include <linux/uaccess.h>
 
@@ -102,6 +103,7 @@ static int newseg(struct ipc_namespace *, struct ipc_params *);
 static void shm_open(struct vm_area_struct *vma);
 static void shm_close(struct vm_area_struct *vma);
 static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp);
+static int ipc_shm_move(struct shmid_kernel *shp, struct mem_cgroup *from, struct mem_cgroup *to);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_shm_proc_show(struct seq_file *s, void *it);
 #endif
@@ -820,9 +822,90 @@ static int shm_more_checks(struct kern_ipc_perm *ipcp, struct ipc_params *params
 	return 0;
 }
 
+static struct shmid_kernel *find_shp_from_perm(struct kern_ipc_perm *perm)
+{
+	struct shmid_kernel *shp = container_of(perm, struct shmid_kernel, shm_perm);
+	return shp;
+}
+
+static unsigned long ipc_shm_size(struct shmid_kernel *shp)
+{
+	unsigned long space = 0;
+	struct file *file;
+	struct inode *inode;
+
+	space += caculate_space(shp);
+
+	file = shp->shm_file;
+	if (!file)
+		return space;
+
+	inode = file->f_inode;
+	if (!inode)
+		return space;
+
+	space += shm_total_pages(inode) * PAGE_SIZE;
+
+	return space;
+}
+
+void shm_tag(struct kern_ipc_perm *ipcp, struct nsproxy *ns)
+{
+	struct shmid_kernel *shp;
+	struct mem_cgroup *memcg_owner, *memcg_recycle;
+	struct cgroup *cgrp_owner, *balloon_cgrp, *shared_cgrp;
+	unsigned int balloon_index;
+
+	memcg_owner = mem_cgroup_from_task(current);
+	if (!memcg_owner)
+		return;
+
+	cgrp_owner = memcg_owner->css.cgroup;
+	if (!cgrp_owner)
+		return;
+
+	shared_cgrp = find_shared_cg(ns->ipc_ns, NULL, NULL, cgrp_owner);
+	cg_ns_insert(cgrp_owner, ns->ipc_ns, NULL, NULL);
+
+	if (!ipcp)
+		return;
+	if (!shared_cgrp) {
+		balloon_index = find_balloon_index_from_cgroup(cgrp_owner);
+		if (balloon_index > BALLOON_CGROUP_HASH_COUNT) {
+			ipcp->cgroup = cgrp_owner;
+			ipcp->residual_time = 0;
+			return;
+		}
+		insert_cgroup_to_balloon(&balloon_to_cgroup[balloon_index], cgrp_owner, NULL);
+	} else {
+		balloon_cgrp = find_balloon_from_cgroup(shared_cgrp);
+		balloon_index = find_balloon_index_from_cgroup(shared_cgrp);
+		insert_cgroup_to_balloon(&balloon_to_cgroup[balloon_index], cgrp_owner,
+					balloon_cgrp);
+
+		if (ipcp->cgroup && balloon_cgrp && ipcp->cgroup == balloon_cgrp) {
+			shp = find_shp_from_perm(ipcp);
+			if (!shp)
+				return;
+			memcg_recycle = get_cg_from_cgrp(balloon_cgrp, "memory");
+			ipc_shm_move(shp, memcg_recycle, memcg_owner);
+		}
+	}
+	ipcp->cgroup = cgrp_owner;
+	ipcp->residual_time = 0;
+}
+
+extern void ipc_shm_free(struct ipc_namespace *ns, unsigned int limit)
+{
+	free_recycle_ipcs(ns, &shm_ids(ns), do_shm_rmid, limit);
+}
+
 long ksys_shmget(key_t key, size_t size, int shmflg)
 {
 	struct ipc_namespace *ns;
+	int err;
+	struct kern_ipc_perm *ipcp;
+
 	static const struct ipc_ops shm_ops = {
 		.getnew = newseg,
 		.associate = security_shm_associate,
@@ -836,7 +919,19 @@ long ksys_shmget(key_t key, size_t size, int shmflg)
 	shm_params.flg = shmflg;
 	shm_params.u.size = size;
 
-	return ipcget(ns, &shm_ids(ns), &shm_ops, &shm_params);
+	err = ipcget(ns, &shm_ids(ns), &shm_ops, &shm_params);
+	if (err >= 0) {
+		down_write(&shm_ids(ns).rwsem);
+		ipcp = ipc_findkey(&shm_ids(ns), key);
+
+		shm_tag(ipcp, current->nsproxy);
+		if (!ipcp)
+			goto no_lock;
+		ipc_unlock(ipcp);
+no_lock:
+		up_write(&shm_ids(ns).rwsem);
+	}
+	return err;
 }
 
 SYSCALL_DEFINE3(shmget, key_t, key, size_t, size, int, shmflg)
@@ -1873,3 +1968,108 @@ static int sysvipc_shm_proc_show(struct seq_file *s, void *it)
 	return 0;
 }
 #endif
+
+static int ipc_shm_move(struct shmid_kernel *shp, struct mem_cgroup *from, struct mem_cgroup *to)
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
+int ipc_shm_move_check(struct ipc_namespace *ns, struct cgroup *cgrp)
+{
+	struct ipc_ids *ids;
+	struct kern_ipc_perm *perm;
+	int next_id, i;
+	int total, in_use;
+	struct shmid_kernel *shp;
+	unsigned long mem_volume;
+	unsigned int balloon_index;
+	struct cgroup *balloon_cgroup;
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
+	balloon_cgroup = find_balloon_from_cgroup(cgrp);
+
+	for (total = 0, next_id = 0; total < in_use; next_id++) {
+		perm = idr_find(&ids->ipcs_idr, next_id);
+		if (perm == NULL) {
+			// total++;
+			continue;
+		}
+
+		shp = find_shp_from_perm(perm);
+		if (shp == NULL) {
+			// total++;
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
+		if (balloon_cgroup && perm->cgroup == balloon_cgroup)
+			perm->residual_time++;
+
+		if (perm->cgroup == cgrp) {
+			if (!balloon_cgroup) {
+				balloon_index = find_balloon_index_from_cgroup(cgrp);
+				balloon_cgroup = balloon_cgroup_create(balloon_index);
+				init_balloon_cgroup_to_balloon(&balloon_to_cgroup[balloon_index],
+							balloon_cgroup);
+				memcg_to = get_cg_from_cgrp(balloon_cgroup, "memory");
+				page_set_balloon_max(memcg_to);
+			}
+			memcg_to = get_cg_from_cgrp(balloon_cgroup, "memory");
+			if (!memcg_to)
+				return 0;
+
+			mem_volume = ipc_shm_size(shp);
+			if (check_balloon_limits(mem_volume, memcg_to)) {
+				for (i = 5; i > 0; i--) {
+					free_oldest_volume(cgrp, i);
+					cond_resched();
+					if (!check_balloon_limits(mem_volume, memcg_to))
+						goto move_resources;
+				}
+				down_write(&shm_ids(ns).rwsem);
+				rcu_read_lock();
+				ipc_lock_object(perm);
+				do_shm_rmid(ns, perm);
+				up_write(&shm_ids(ns).rwsem);
+				total++;
+				continue;
+			}
+move_resources:
+			perm->cgroup = balloon_cgroup;
+			perm->residual_time = 1;
+			ipc_shm_move(shp, memcg_from, memcg_to);
+		}
+		total++;
+	}
+	return 0;
+}
diff --git a/ipc/util.c b/ipc/util.c
index 05cb9de66735..0701fa10505f 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -169,7 +169,7 @@ void __init ipc_init_proc_interface(const char *path, const char *header,
  *
  * Called with writer ipc_ids.rwsem held.
  */
-static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
+struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 {
 	struct kern_ipc_perm *ipcp;
 
diff --git a/ipc/util.h b/ipc/util.h
index a55d6cebe6d3..46db525455c9 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -244,6 +244,7 @@ int ipcget(struct ipc_namespace *ns, struct ipc_ids *ids,
 			const struct ipc_ops *ops, struct ipc_params *params);
 void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 		void (*free)(struct ipc_namespace *, struct kern_ipc_perm *));
+extern struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key);
 
 static inline int sem_check_semmni(struct ipc_namespace *ns) {
 	/*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2032dc501427..33a20e5562b6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -60,6 +60,22 @@
 #include <linux/sched/deadline.h>
 #include <linux/psi.h>
 #include <net/sock.h>
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
+#include <linux/pid_namespace.h>
+#include <linux/namei.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/percpu_counter.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/cgroup.h>
@@ -5938,6 +5954,385 @@ static void kill_css(struct cgroup_subsys_state *css)
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
+static struct hlist_head *call_hash_cg_ns(struct cgroup *cgroup)
+{
+	unsigned int val = 0;
+	unsigned long location = (unsigned long)cgroup;
+
+	val = location % CGROUP_NS_HASH_COUNT;
+	return &cg_ns_map[val];
+}
+
+static int init_hash_cg_ns(void)
+{
+	int i = 0;
+
+	cg_ns_map = kmalloc(sizeof(struct hlist_head) * CGROUP_NS_HASH_COUNT, GFP_ATOMIC);
+	if (!cg_ns_map)
+		return -1;
+
+	for (i = 0; i < CGROUP_NS_HASH_COUNT; i++)
+		INIT_HLIST_HEAD(&cg_ns_map[i]);
+
+	return 0;
+}
+EXPORT_SYMBOL(cg_ns_map);
+
+int cg_ns_insert(struct cgroup *cgroup, struct ipc_namespace *ipc_ns,
+	struct net *net_ns, struct pid_namespace *pid_ns)
+{
+	struct hlist_head *hash_bucket = NULL;
+	struct cgroup_ns_entry *pNode = NULL;
+
+	hash_bucket = call_hash_cg_ns(cgroup);
+	if (!hash_bucket)
+		return -1;
+
+	hlist_for_each_entry(pNode, hash_bucket, hnode) {
+		if (!pNode)
+			return -1;
+
+		if (pNode->cgroup == cgroup) {
+			if (ipc_ns && ipc_ns != pNode->ipc_ns)
+				pNode->ipc_ns = ipc_ns;
+
+			if (net_ns && net_ns != pNode->net_ns)
+				pNode->net_ns = net_ns;
+
+			if (pid_ns && pid_ns != pNode->pid_ns)
+				pNode->pid_ns = pid_ns;
+			return 0;
+		}
+	}
+
+	pNode = kmalloc(sizeof(struct cgroup_ns_entry), GFP_ATOMIC);
+	if (!pNode)
+		return -1;
+
+	INIT_HLIST_NODE(&pNode->hnode);
+
+	pNode->cgroup = cgroup;
+	pNode->net_ns = net_ns;
+	pNode->pid_ns = pid_ns;
+	pNode->ipc_ns = ipc_ns;
+
+	hlist_add_head(&pNode->hnode, hash_bucket);
+
+	return 0;
+}
+
+static struct ipc_namespace *find_ipc_ns_from_cg(struct cgroup *cgroup)
+{
+	struct hlist_head *hash_bucket = NULL;
+	struct cgroup_ns_entry *pNode = NULL;
+
+	hash_bucket = call_hash_cg_ns(cgroup);
+	if (hash_bucket == NULL)
+		return NULL;
+
+	hlist_for_each_entry(pNode, hash_bucket, hnode) {
+		if (pNode->cgroup == cgroup)
+			return pNode->ipc_ns;
+	}
+	return NULL;
+}
+
+static struct net *find_net_ns_from_cg(struct cgroup *cgroup)
+{
+	struct hlist_head *hash_bucket = NULL;
+	struct cgroup_ns_entry *pNode = NULL;
+
+	hash_bucket = call_hash_cg_ns(cgroup);
+	if (hash_bucket == NULL)
+		return NULL;
+
+	hlist_for_each_entry(pNode, hash_bucket, hnode) {
+		if (pNode->cgroup == cgroup)
+			return pNode->net_ns;
+	}
+	return NULL;
+}
+
+struct cgroup *find_shared_cg(struct ipc_namespace *ipc_ns, struct net *net_ns,
+		struct pid_namespace *pid_ns, const struct cgroup *cgroup)
+{
+	struct cgroup_ns_entry *pNode = NULL;
+	int i;
+
+	if (!cg_ns_map)
+		return NULL;
+
+	if (ipc_ns == &init_ipc_ns || net_ns ==  &init_net || pid_ns ==  &init_pid_ns)
+		return NULL;
+
+	for (i = 0; i < CGROUP_NS_HASH_COUNT; i++) {
+		hlist_for_each_entry(pNode, &cg_ns_map[i], hnode) {
+			if (!pNode)
+				return NULL;
+			if (ipc_ns) {
+				if (pNode->ipc_ns == ipc_ns && pNode->cgroup != cgroup)
+					return pNode->cgroup;
+			}
+
+			if (net_ns) {
+				if (pNode->net_ns == net_ns && pNode->cgroup != cgroup)
+					return pNode->cgroup;
+			}
+
+			if (pid_ns) {
+				if (pNode->pid_ns == pid_ns && pNode->cgroup != cgroup)
+					return pNode->cgroup;
+			}
+		}
+	}
+	return NULL;
+}
+
+int delete_cg_ns_node(struct hlist_head *head, struct cgroup *cgroup)
+{
+	struct cgroup_ns_entry *pNode = NULL;
+
+	if (!cg_ns_map)
+		return -1;
+
+	if (!head)
+		return -1;
+	hlist_for_each_entry(pNode, head, hnode) {
+		if (pNode->cgroup == cgroup) {
+			hlist_del(&pNode->hnode);
+			return 0;
+		}
+	}
+	return 0;
+}
+
+int init_hash_balloon_cg(void)
+{
+	int i = 0;
+
+	balloon_to_cgroup = kmalloc(sizeof(struct hlist_head) * BALLOON_CGROUP_HASH_COUNT,
+					GFP_ATOMIC);
+	if (balloon_to_cgroup == NULL)
+		return -1;
+
+	for (i = 0; i < BALLOON_CGROUP_HASH_COUNT; i++)
+		INIT_HLIST_HEAD(&balloon_to_cgroup[i]);
+
+	return 0;
+}
+EXPORT_SYMBOL(balloon_to_cgroup);
+
+unsigned int find_balloon_index_from_cgroup(struct cgroup *cgroup)
+{
+	struct hlist_node *first;
+	struct balloon_cgroup_entry *balloon_cg;
+	int i;
+
+	if (!balloon_to_cgroup)
+		return -1;
+
+	for (i = 0; i < BALLOON_CGROUP_HASH_COUNT; i++) {
+		first = (&balloon_to_cgroup[i])->first;
+		if (!first)
+			break;
+
+		hlist_for_each_entry(balloon_cg, &balloon_to_cgroup[i], hnode) {
+			if (balloon_cg->cgroup == cgroup)
+				return i;
+		}
+	}
+	return i;
+}
+
+struct cgroup *find_balloon_from_cgroup(struct cgroup *cgroup)
+{
+	struct hlist_node *first;
+	struct balloon_cgroup_entry *balloon_cg;
+	int i;
+
+	if (!balloon_to_cgroup)
+		return NULL;
+
+	for (i = 0; i < BALLOON_CGROUP_HASH_COUNT; i++) {
+		first = (&balloon_to_cgroup[i])->first;
+		if (!first)
+			break;
+
+		hlist_for_each_entry(balloon_cg, &balloon_to_cgroup[i], hnode) {
+			if (balloon_cg->cgroup == cgroup)
+				return balloon_cg->balloon_cgroup;
+		}
+	}
+	return NULL;
+}
+
+int insert_cgroup_to_balloon(struct hlist_head *head, struct cgroup *cgroup,
+		struct cgroup *balloon_cgroup)
+{
+	struct balloon_cgroup_entry *pNode;
+
+	hlist_for_each_entry(pNode, head, hnode) {
+		if (!pNode)
+			continue;
+
+		if (pNode->cgroup == cgroup)
+			return 0;
+	}
+	pNode = kmalloc(sizeof(struct balloon_cgroup_entry), GFP_ATOMIC);
+	if (pNode == NULL)
+		return -1;
+
+	INIT_HLIST_NODE(&pNode->hnode);
+	pNode->cgroup = cgroup;
+	pNode->balloon_cgroup = balloon_cgroup;
+	hlist_add_head(&pNode->hnode, head);
+
+	return 0;
+}
+
+int delete_balloon_cgroup_node(struct hlist_head *head, struct cgroup *cgroup)
+{
+	struct balloon_cgroup_entry *pNode;
+
+	hlist_for_each_entry(pNode, head, hnode) {
+		if (!pNode)
+			continue;
+
+		if (pNode->cgroup == cgroup) {
+			hlist_del(&pNode->hnode);
+			return 0;
+		}
+	}
+	return 0;
+}
+
+int init_balloon_cgroup_to_balloon(struct hlist_head *head, struct cgroup *balloon_cgroup)
+{
+	struct balloon_cgroup_entry *pNode;
+
+	if (!head)
+		return -1;
+	hlist_for_each_entry(pNode, head, hnode) {
+		pNode->balloon_cgroup  = balloon_cgroup;
+	}
+	return 0;
+}
+
+static int memcg_ipc_net_pid_check(struct cgroup *cgrp)
+{
+	struct ipc_namespace *ipc_ns;
+	struct net *net_ns;
+	struct pid_namespace *pid_ns;
+	struct hlist_head *hash_bucket;
+	struct cgroup_ns_entry *pNode;
+	struct task_struct *tmp, *reaper, *pos;
+	struct cgroup *to;
+	int balloon_index;
+
+	hash_bucket = call_hash_cg_ns(cgrp);
+	if (!hash_bucket)
+		return 0;
+
+	hlist_for_each_entry(pNode, hash_bucket, hnode) {
+		if (!pNode)
+			continue;
+
+		if (pNode->cgroup != cgrp)
+			continue;
+
+		ipc_ns = pNode->ipc_ns;
+		net_ns = pNode->net_ns;
+		pid_ns = pNode->pid_ns;
+
+		if (ipc_ns) {
+			if (ipc_ns->used_sems != 0)
+				ipc_sem_move_check(ipc_ns, cgrp);
+
+			if (ipc_ns->shm_tot != 0)
+				ipc_shm_move_check(ipc_ns, cgrp);
+
+			ipc_msq_move_check(ipc_ns, cgrp);
+		}
+		if (net_ns) {
+			if (!list_empty(&net_ns->dev_base_head))
+				net_device_move_check(net_ns, cgrp);
+		}
+
+		if (pid_ns && pid_ns != &init_pid_ns) {
+			reaper = pid_ns->child_reaper;
+
+			if (!reaper)
+				break;
+
+			if (list_empty(&reaper->children))
+				break;
+
+			list_for_each_entry_safe(pos, tmp, &reaper->children, sibling) {
+				if (!pos)
+					continue;
+				to = task_cgroup(pos, pids_cgrp_id);
+				if (pos->exit_state == EXIT_ZOMBIE && to == cgrp)
+					release_task(pos);
+			}
+		}
+		break;
+	}
+	delete_cg_ns_node(hash_bucket, cgrp);
+	balloon_index = find_balloon_index_from_cgroup(cgrp);
+	delete_balloon_cgroup_node(&balloon_to_cgroup[balloon_index], cgrp);
+	return 0;
+}
+
+static void ipc_residual_clear(struct ipc_namespace *ipc_ns, unsigned int limit)
+{
+	if (ipc_ns->used_sems != 0)
+		ipc_sem_free(ipc_ns, limit);
+
+	if (ipc_ns->shm_tot != 0)
+		ipc_shm_free(ipc_ns, limit);
+
+	ipc_msq_free(ipc_ns, limit);
+}
+
+static void net_residual_clear(struct net *net_ns, unsigned int limit)
+{
+	net_device_free(net_ns, limit);
+}
+
+extern int free_oldest_volume(struct cgroup *target_cgroup, unsigned int limit)
+{
+	struct ipc_namespace *ipc_ns;
+	struct net *net_ns;
+
+	ipc_ns = find_ipc_ns_from_cg(target_cgroup);
+	net_ns = find_net_ns_from_cg(target_cgroup);
+
+	if (ipc_ns)
+		ipc_residual_clear(ipc_ns, limit);
+
+	if (net_ns)
+		net_residual_clear(net_ns, limit);
+	return 0;
+}
+
 /**
  * cgroup_destroy_locked - the first stage of cgroup destruction
  * @cgrp: cgroup to be destroyed
@@ -6043,6 +6438,8 @@ int cgroup_rmdir(struct kernfs_node *kn)
 	if (!cgrp)
 		return 0;
 
+	memcg_ipc_net_pid_check(cgrp);
+
 	ret = cgroup_destroy_locked(cgrp);
 	if (!ret)
 		TRACE_CGROUP_PATH(rmdir, cgrp);
@@ -6058,6 +6455,105 @@ static struct kernfs_syscall_ops cgroup_kf_syscall_ops = {
 	.show_path		= cgroup_show_path,
 };
 
+struct cgroup *init_balloon;
+struct hlist_head *cg_ns_map;
+struct hlist_head *balloon_to_cgroup;
+
+struct cgroup *balloon_cgroup_create(unsigned int index)
+{
+	struct kernfs_node *balloon_root_kn;
+	char balloon_name[10];
+	struct cgroup *cgrp = ERR_PTR(-ENOENT);
+	struct cgroup *balloon_root_cgrp;
+	int ret;
+
+	balloon_root_cgrp = init_balloon;
+	if (!balloon_root_cgrp)
+		return NULL;
+
+	if (balloon_root_cgrp->subtree_control == 0) {
+		balloon_root_cgrp->subtree_control |= 16;
+		ret = cgroup_apply_control(balloon_root_cgrp);
+		cgroup_finalize_control(balloon_root_cgrp, ret);
+	}
+
+	balloon_root_kn = balloon_root_cgrp->kn;
+	if (!balloon_root_kn)
+		return NULL;
+
+	sprintf(balloon_name, "%u.service", index);
+
+	cgrp = cgroup_create(balloon_root_cgrp, balloon_name, 0x755);
+
+	if (!cgrp)
+		return NULL;
+	/*
+	 * This extra ref will be put in cgroup_free_fn() and guarantees
+	 * that @cgrp->kn is always accessible.
+	 */
+	kernfs_get(cgrp->kn);
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
+
+	goto out_unlock;
+
+out_destroy:
+	cgroup_destroy_locked(cgrp);
+	return NULL;
+
+out_unlock:
+	return cgrp;
+}
+
+static void recycle_cgroup_create(void)
+{
+	struct kernfs_node *root_kn;
+	struct cgroup *cgrp = ERR_PTR(-ENOENT);
+	struct cgroup *root_cgrp;
+	int ret;
+
+	root_cgrp = current_cgns_cgroup_dfl();
+	root_kn = root_cgrp->kn;
+	cgrp = cgroup_create(root_cgrp, "balloon.slice", 0x0744);
+	/*
+	 * This extra ref will be put in cgroup_free_fn() and guarantees
+	 * that @cgrp->kn is always accessible.
+	 */
+	kernfs_get(cgrp->kn);
+
+	ret = css_populate_dir(&cgrp->self);
+	if (ret)
+		goto out_destroy;
+
+	ret = cgroup_apply_control_enable(cgrp);
+	if (ret)
+		goto out_destroy;
+	/* let's create and online css's */
+	kernfs_activate(cgrp->kn);
+	ret = 0;
+
+	goto out_unlock;
+
+out_destroy:
+	cgroup_destroy_locked(cgrp);
+
+out_unlock:
+	init_balloon = cgrp;
+	init_hash_cg_ns();
+	init_hash_balloon_cg();
+}
+EXPORT_SYMBOL(init_balloon);
+
 static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 {
 	struct cgroup_subsys_state *css;
@@ -6248,7 +6744,7 @@ int __init cgroup_init(void)
 #ifdef CONFIG_CPUSETS
 	WARN_ON(register_filesystem(&cpuset_fs_type));
 #endif
-
+	recycle_cgroup_create();
 	return 0;
 }
 
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 8f61114c36dd..6275c110da26 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -273,10 +273,47 @@ static void pids_event(struct pids_cgroup *pids_forking,
 static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 {
 	struct pids_cgroup *pids, *pids_over_limit;
-	int err;
+	struct cgroup_subsys_state *css;
+	int err, balloon_index;
+	struct pid_namespace *pid_ns;
+	struct pid *pid;
+	struct cgroup *cgrp_owner, *shared_cgrp, *balloon_cgrp;
+
+	css = cset->subsys[pids_cgrp_id];
+	pids = css_pids(css);
 
-	pids = css_pids(cset->subsys[pids_cgrp_id]);
 	err = pids_try_charge(pids, 1, &pids_over_limit);
+	pid = task->thread_pid;
+	if (!pid)
+		return 0;
+
+	pid_ns = pid->numbers[pid->level].ns;
+	if (!pid_ns)
+		return 0;
+
+	cgrp_owner = css->cgroup;
+	if (!cgrp_owner)
+		return 0;
+
+	if (pid_ns != &init_pid_ns) {
+		shared_cgrp = find_shared_cg(task->nsproxy->ipc_ns, task->nsproxy->net_ns,
+						pid_ns, cgrp_owner);
+		cg_ns_insert(cgrp_owner, task->nsproxy->ipc_ns, task->nsproxy->net_ns, pid_ns);
+
+		if (!shared_cgrp) {
+			balloon_index = find_balloon_index_from_cgroup(cgrp_owner);
+			if (balloon_index > BALLOON_CGROUP_HASH_COUNT)
+				return err;
+			insert_cgroup_to_balloon(&balloon_to_cgroup[balloon_index], cgrp_owner,
+							NULL);
+		} else {
+			balloon_cgrp = find_balloon_from_cgroup(shared_cgrp);
+			balloon_index = find_balloon_index_from_cgroup(shared_cgrp);
+			insert_cgroup_to_balloon(&balloon_to_cgroup[balloon_index], cgrp_owner,
+							balloon_cgrp);
+		}
+	}
+
 	if (err)
 		pids_event(pids, pids_over_limit);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 619f0014c33b..3a84aeaceb51 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -70,6 +70,7 @@
 #include <linux/sysfs.h>
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
+#include <linux/memcontrol.h>
 
 #include <uapi/linux/wait.h>
 
@@ -1972,3 +1973,27 @@ __weak __function_aligned void abort(void)
 	panic("Oops failed to kill thread");
 }
 EXPORT_SYMBOL(abort);
+
+void check_pid_zombie(struct pid_namespace *pid_ns, struct cgroup *cgrp)
+{
+	struct task_struct *tmp, *reaper, *pos;
+	struct cgroup *to;
+
+	if (!pid_ns)
+		return;
+
+	reaper = pid_ns->child_reaper;
+	if (!reaper)
+		return;
+
+	if (list_empty(&reaper->children))
+		return;
+
+	list_for_each_entry_safe(pos, tmp, &reaper->children, sibling) {
+		if (!pos)
+			continue;
+		to = task_cgroup(pos, pids_cgrp_id);
+		if (pos->exit_state == EXIT_ZOMBIE && to == cgrp)
+			release_task(pos);
+	}
+}
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48..6d23531d3e6c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1618,6 +1618,13 @@ static struct ctl_table kern_table[] = {
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
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 44803cbea38a..35e1a6fbbee8 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -757,7 +757,7 @@ static void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
  * This function doesn't do "charge" to new cgroup and doesn't do "uncharge"
  * from old cgroup.
  */
-static int mem_cgroup_move_account(struct folio *folio,
+int mem_cgroup_move_account(struct folio *folio,
 				   bool compound,
 				   struct mem_cgroup *from,
 				   struct mem_cgroup *to)
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 3bb8b3030e61..9b81724c3239 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -101,6 +101,10 @@ void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
 void memcg1_oom_recover(struct mem_cgroup *memcg);
 
 void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
+int mem_cgroup_move_account(struct folio *folio,
+				   bool compound,
+				   struct mem_cgroup *from,
+				   struct mem_cgroup *to);
 void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg);
 void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
 			   unsigned long nr_memory, int nid);
@@ -139,6 +143,10 @@ static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}
 
 static inline void memcg1_commit_charge(struct folio *folio,
 					struct mem_cgroup *memcg) {}
+static inline int mem_cgroup_move_account(struct folio *folio,
+				   bool compound,
+				   struct mem_cgroup *from,
+				   struct mem_cgroup *to) { return 0; }
 
 static inline void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg) {}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bda6f75d22ff..bd82ca25a602 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
 #include <linux/kmemleak.h>
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
@@ -5446,3 +5449,198 @@ static int __init mem_cgroup_swap_init(void)
 subsys_initcall(mem_cgroup_swap_init);
 
 #endif /* CONFIG_SWAP */
+int _obj_cgroup_move(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects, struct obj_cgroup *to)
+{
+	struct slabobj_ext *obj_exts;
+	int i;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return 0;
+
+	for (i = 0; i < objects; i++) {
+		struct obj_cgroup *objcg;
+		unsigned int off;
+
+		off = obj_to_index(s, slab, p[i]);
+		objcg = obj_exts[off].objcg;
+		if (!objcg)
+			continue;
+		obj_exts[off].objcg = to;
+		obj_cgroup_uncharge(objcg, obj_full_size(s));
+		obj_cgroup_charge(to, GFP_KERNEL, obj_full_size(s));
+		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
+				-obj_full_size(s));
+		mod_objcg_state(to, slab_pgdat(slab), cache_vmstat_idx(s),
+				obj_full_size(s));
+	}
+	return 0;
+}
+
+int kmem_cache_move(struct kmem_cache *s, void *addr, int objects, struct mem_cgroup *to)
+{
+	s = cache_from_obj(s, addr);
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
+		ret = _obj_cgroup_move(s, virt_to_slab((void *)addr), &addr, 1, objcg_to);
+	} else {
+		order = folio_order(folio);
+
+		ret = obj_cgroup_charge_pages(objcg_to, GFP_KERNEL & ~__GFP_DIRECT_RECLAIM,
+							1 << order);
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
+
+int page_set_balloon_max(struct mem_cgroup *memcg)
+{
+	xchg(&memcg->memory.max, recycle_max_limit);
+	return 0;
+}
+
+/**
+ * caculate_space - Calculate how much memory the given object occupies.
+ * @addr: the address of the given object.
+ *
+ * Returns the maximum amount of memory @addr occupies, in
+ * bytes.
+ */
+unsigned long caculate_space(void *addr)
+{
+	struct vm_struct *area;
+	unsigned long space;
+
+	if (is_vmalloc_addr(addr)) {
+		area = find_vm_area(addr);
+		if (area == NULL)
+			return 0;
+		space = area->nr_pages * PAGE_SIZE;
+	} else {
+		struct folio *folio;
+		struct slab *slab;
+		struct kmem_cache *s;
+		unsigned int order;
+
+		folio = virt_to_folio(addr);
+
+		if (folio == NULL)
+			return 0;
+
+		if (folio_test_slab(folio)) {
+			slab = folio_slab(folio);
+			if (slab == NULL)
+				return 0;
+
+			s = slab->slab_cache;
+			if (s == NULL)
+				return 0;
+
+			space = obj_full_size(s);
+		} else {
+			order = folio_order(folio);
+			space = (1 << order) * PAGE_SIZE;
+		}
+	}
+	return space;
+}
+
+int check_balloon_limits(unsigned long mem_delta, struct mem_cgroup *memcg_balloon)
+{
+	if (mem_cgroup_margin(memcg_balloon)*PAGE_SIZE < mem_delta)
+		return 1;
+
+	return 0;
+}
+
+int obj_cgroup_move(void *addr, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	struct vm_struct *area;
+	int i, ret;
+	struct page *page;
+	struct folio *folio;
+
+	if (is_vmalloc_addr(addr)) {
+		area = find_vm_area(addr);
+		if (area == NULL)
+			return 0;
+
+		for (i = 0; i < area->nr_pages; i++) {
+			page = area->pages[i];
+
+			if (!page)
+				return 0;
+			folio = page_folio(page);
+			try_charge(to, GFP_KERNEL & ~__GFP_DIRECT_RECLAIM, 1);
+			mem_cgroup_move_account(folio, 0, from, to);
+		}
+	} else {
+		ret = kmem_cgroup_move(addr, from, to);
+	}
+	return ret;
+}
+
diff --git a/mm/shmem.c b/mm/shmem.c
index c994fee2156f..c15d2c67b4e1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -40,6 +40,8 @@
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
 #include <linux/iversion.h>
+#include <linux/memcontrol.h>
+#include <linux/ipc_namespace.h>
 #include "swap.h"
 
 static struct vfsmount *shm_mnt __ro_after_init;
@@ -5374,3 +5376,66 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 	return page;
 }
 EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
+
+extern unsigned long shm_total_pages(struct inode *inode)
+{
+	struct address_space *mapping = inode->i_mapping;
+	loff_t lstart = 0;
+	pgoff_t start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pgoff_t end = -1;
+	struct folio_batch fbatch;
+	struct folio *folio;
+	pgoff_t indices[PAGEVEC_SIZE];
+	pgoff_t index;
+	int i;
+	unsigned long pages = 0;
+
+	folio_batch_init(&fbatch);
+	index = start;
+	while (index < end && find_lock_entries(mapping, &index, end - 1,
+			&fbatch, indices)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			folio = fbatch.folios[i];
+			if (!folio)
+				continue;
+			folio_unlock(folio);
+			folio_put(folio);
+			pages += 1;
+		}
+		fbatch.nr = 0;
+	}
+	return pages;
+}
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
diff --git a/mm/slab.h b/mm/slab.h
index f22fb760b286..5efc82c3bc73 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -591,6 +591,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  gfp_t flags, size_t size, void **p);
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			    void **p, int objects, struct slabobj_ext *obj_exts);
+struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x);
 #endif
 
 size_t __ksize(const void *objp);
diff --git a/mm/slub.c b/mm/slub.c
index e474a6717827..9e8d201097ba 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4645,7 +4645,7 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
 	return slab->slab_cache;
 }
 
-static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
+struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 {
 	struct kmem_cache *cachep;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 05d9624f360f..53588bfe2d0e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -159,6 +159,11 @@
 #include <net/page_pool/helpers.h>
 #include <net/rps.h>
 #include <linux/phy_link_topology.h>
+#include <linux/memcontrol.h>
+#include <linux/ref_tracker.h>
+#include <linux/inetdevice.h>
+#include <linux/cgroup.h>
+#include <net/neighbour.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -170,7 +175,7 @@ static int netif_rx_internal(struct sk_buff *skb);
 static int call_netdevice_notifiers_extack(unsigned long val,
 					   struct net_device *dev,
 					   struct netlink_ext_ack *extack);
-
+static int net_device_move(struct net_device *dev, struct mem_cgroup *from, struct mem_cgroup *to);
 static DEFINE_MUTEX(ifalias_mutex);
 
 /* protects napi_hash addition/deletion and napi_gen_id */
@@ -399,6 +404,33 @@ static void list_netdevice(struct net_device *dev)
 {
 	struct netdev_name_node *name_node;
 	struct net *net = dev_net(dev);
+	struct mem_cgroup *memcg;
+	struct nsproxy *ns;
+	struct cgroup *cgrp_owner, *shared_cgrp, *balloon_cgrp;
+	int balloon_index;
+
+	memcg = mem_cgroup_from_task(current);
+
+	cgrp_owner = memcg->css.cgroup;
+	ns = current->nsproxy;
+	shared_cgrp = find_shared_cg(NULL, ns->net_ns, NULL, cgrp_owner);
+	cg_ns_insert(cgrp_owner, NULL, ns->net_ns, NULL);
+	if (!shared_cgrp) {
+		balloon_index = find_balloon_index_from_cgroup(cgrp_owner);
+		if (balloon_index > BALLOON_CGROUP_HASH_COUNT) {
+			dev->cgroup = cgrp_owner;
+			dev->residual_time = 0;
+			return;
+		}
+		insert_cgroup_to_balloon(&balloon_to_cgroup[balloon_index], cgrp_owner, NULL);
+	} else {
+		balloon_cgrp = find_balloon_from_cgroup(shared_cgrp);
+		balloon_index = find_balloon_index_from_cgroup(shared_cgrp);
+		insert_cgroup_to_balloon(&balloon_to_cgroup[balloon_index], cgrp_owner,
+					balloon_cgrp);
+	}
+	dev->cgroup = cgrp_owner;
+	dev->residual_time = 0;
 
 	ASSERT_RTNL();
 
@@ -752,6 +784,46 @@ int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 }
 EXPORT_SYMBOL_GPL(dev_fill_forward_path);
 
+static unsigned long net_device_size(struct net_device *dev)
+{
+	struct inet6_dev *i6_dev;
+	struct in_device *i4_dev;
+	unsigned long space = 0;
+
+	if (!dev)
+		return 0;
+
+	space += caculate_space(dev->_tx);
+	space += caculate_space(dev->_rx);
+	if (rcu_dereference_protected(dev->ingress_queue, 1))
+		space += caculate_space(rcu_dereference_protected(dev->ingress_queue, 1));
+
+	if (rcu_access_pointer(dev->ifalias))
+		space += caculate_space(rcu_access_pointer(dev->ifalias));
+
+	if (&dev->napi_list) {
+		struct napi_struct *p, *n;
+		struct sk_buff *skb;
+
+		list_for_each_entry_safe(p, n, &dev->napi_list, dev_list) {
+			skb = p->skb;
+			space += kmem_cache_size(net_hotdata.skbuff_cache);  //obj_full_size(s)
+		}
+	}
+	space += caculate_space(dev);
+
+	i4_dev = dev->ip_ptr;
+	if (i4_dev) {
+		space += neigh_size(i4_dev->arp_parms);
+		space += devinet_size(&i4_dev->cnf);
+	}
+
+	i6_dev = __in6_dev_get(dev);
+	if (i6_dev)
+		space += ipv6_size(i6_dev);
+	return space;
+}
+
 /**
  *	__dev_get_by_name	- find a device by its name
  *	@net: the applicable net namespace
@@ -767,9 +839,36 @@ EXPORT_SYMBOL_GPL(dev_fill_forward_path);
 struct net_device *__dev_get_by_name(struct net *net, const char *name)
 {
 	struct netdev_name_node *node_name;
+	struct net_device *dev;
+	struct mem_cgroup *memcg_owner, *memcg_recycle;
+	struct cgroup *cgrp_owner, *balloon_cgrp;
 
 	node_name = netdev_name_node_lookup(net, name);
-	return node_name ? node_name->dev : NULL;
+
+	if (!node_name)
+		return NULL;
+
+	dev = node_name->dev;
+
+	balloon_cgrp = find_balloon_from_cgroup(dev->cgroup);
+	if (dev->cgroup && balloon_cgrp && dev->cgroup == balloon_cgrp) {
+		memcg_owner = mem_cgroup_from_task(current);
+		if (!memcg_owner)
+			return NULL;
+
+		cgrp_owner = memcg_owner->css.cgroup;
+		if (!cgrp_owner)
+			return NULL;
+
+		memcg_recycle = get_cg_from_cgrp(balloon_cgrp, "memory");
+		if (!memcg_recycle)
+			return NULL;
+		net_device_move(dev, memcg_recycle, memcg_owner);
+		dev->cgroup = cgrp_owner;
+		dev->residual_time = 0;
+	}
+
+	return dev;
 }
 EXPORT_SYMBOL(__dev_get_by_name);
 
@@ -846,11 +945,31 @@ EXPORT_SYMBOL(netdev_get_by_name);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex)
 {
 	struct net_device *dev;
+	struct mem_cgroup *memcg_owner, *memcg_recycle;
+	struct cgroup *cgrp_owner, *balloon_cgrp;
 	struct hlist_head *head = dev_index_hash(net, ifindex);
 
 	hlist_for_each_entry(dev, head, index_hlist)
-		if (dev->ifindex == ifindex)
+		if (dev->ifindex == ifindex) {
+			balloon_cgrp = find_balloon_from_cgroup(dev->cgroup);
+			if (dev->cgroup && balloon_cgrp && dev->cgroup == balloon_cgrp) {
+				memcg_owner = mem_cgroup_from_task(current);
+				if (!memcg_owner)
+					return NULL;
+
+				cgrp_owner = memcg_owner->css.cgroup;
+				if (!cgrp_owner)
+					return NULL;
+
+				memcg_recycle = get_cg_from_cgrp(balloon_cgrp, "memory");
+				if (!memcg_recycle)
+					return NULL;
+				net_device_move(dev, memcg_recycle, memcg_owner);
+				dev->cgroup = cgrp_owner;
+				dev->residual_time = 0;
+			}
 			return dev;
+		}
 
 	return NULL;
 }
@@ -12150,3 +12269,144 @@ static int __init net_dev_init(void)
 }
 
 subsys_initcall(net_dev_init);
+
+static int _net_device_move(struct net_device *dev, struct mem_cgroup *from, struct mem_cgroup *to)
+{
+	int err;
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
+			err = kmem_cache_move(net_hotdata.skbuff_cache, skb, 1, to);
+		}
+	}
+	err = obj_cgroup_move(dev, from, to);
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
+
+	err = _net_device_move(dev, from, to);
+	return err;
+}
+
+extern int net_device_move_check(struct net *ns, struct cgroup *cgrp)
+{
+	int i;
+	struct net_device *ndev, *aux;
+	unsigned long mem_volume;
+	unsigned int balloon_index;
+	struct mem_cgroup *memcg_to, *memcg_from;
+	struct cgroup *balloon_cgroup;
+
+	memcg_from = get_cg_from_cgrp(cgrp, "memory");
+	if (!memcg_from)
+		return 0;
+
+	balloon_cgroup = find_balloon_from_cgroup(cgrp);
+
+	for_each_netdev_safe(ns, ndev, aux) {
+		if (!ndev)
+			continue;
+		if (balloon_cgroup && ndev->cgroup == balloon_cgroup)
+			ndev->residual_time++;
+
+		if (ndev->cgroup == cgrp) {
+			if (!balloon_cgroup) {
+				balloon_index = find_balloon_index_from_cgroup(cgrp);
+				balloon_cgroup = balloon_cgroup_create(balloon_index);
+				if (!balloon_cgroup)
+					return 0;
+
+				init_balloon_cgroup_to_balloon(&balloon_to_cgroup[balloon_index],
+						balloon_cgroup);
+				memcg_to = get_cg_from_cgrp(balloon_cgroup, "memory");
+				page_set_balloon_max(memcg_to);
+			}
+			memcg_to = get_cg_from_cgrp(balloon_cgroup, "memory");
+			if (!memcg_to)
+				return 0;
+
+			mem_volume = net_device_size(ndev);
+			if (check_balloon_limits(mem_volume, memcg_to)) {
+				for (i = 5; i > 0; i++) {
+					free_oldest_volume(cgrp, i);
+					cond_resched();
+					if (!check_balloon_limits(mem_volume, memcg_to))
+						goto move_resources;
+				}
+				LIST_HEAD(dev_kill_list);
+
+				rtnl_lock();
+				if (ndev->netns_local)
+					continue;
+				if (ndev->rtnl_link_ops && ndev->rtnl_link_ops->dellink)
+					ndev->rtnl_link_ops->dellink(ndev, &dev_kill_list);
+				else
+					unregister_netdevice_queue(ndev, &dev_kill_list);
+				unregister_netdevice_many(&dev_kill_list);
+				rtnl_unlock();
+			}
+move_resources:
+			ndev->cgroup = balloon_cgroup;
+			ndev->residual_time = 1;
+			net_device_move(ndev, memcg_from, memcg_to);
+		}
+	}
+	return 0;
+}
+
+extern void net_device_free(struct net *ns, unsigned int limit)
+{
+	struct net_device *ndev, *aux;
+	LIST_HEAD(dev_kill_list);
+
+	rtnl_lock();
+
+	for_each_netdev_safe(ns, ndev, aux) {
+		if (ndev->residual_time >= limit) {
+			if (ndev->netns_local)
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
index 77b819cd995b..44cdf1e3661a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -38,6 +38,7 @@
 #include <linux/log2.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
+#include <linux/memcontrol.h>
 
 #include <trace/events/neigh.h>
 
@@ -3901,3 +3902,37 @@ static int __init neigh_init(void)
 }
 
 subsys_initcall(neigh_init);
+
+extern unsigned long neigh_size(struct neigh_parms *neigh_p)
+{
+	int space;
+	struct neigh_sysctl_table *neigh_st;
+
+	if (!neigh_p)
+		return 0;
+
+	neigh_st = neigh_p->sysctl_table;
+	if (!neigh_st)
+		return 0;
+
+	space += caculate_space(neigh_st);
+	space += caculate_space(neigh_st->sysctl_header);
+	return space;
+}
+
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
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index ab76744383cf..3a49801f04f4 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -53,6 +53,7 @@
 #endif
 #include <linux/kmod.h>
 #include <linux/netconf.h>
+#include <linux/memcontrol.h>
 
 #include <net/arp.h>
 #include <net/ip.h>
@@ -2803,3 +2804,37 @@ void __init devinet_init(void)
 		      inet_netconf_dump_devconf,
 		      RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED);
 }
+
+extern unsigned long devinet_size(struct ipv4_devconf *ipv4_p)
+{
+	unsigned long space;
+	struct devinet_sysctl_table *devinet_st;
+
+	if (!ipv4_p)
+		return 0;
+
+	devinet_st = ipv4_p->sysctl;
+	if (!devinet_st)
+		return 0;
+
+	space += caculate_space(devinet_st);
+	space += caculate_space(devinet_st->sysctl_header);
+	return space;
+}
+
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
index d680beb91b0a..e144f2f357b3 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -91,6 +91,7 @@
 #include <linux/seq_file.h>
 #include <linux/export.h>
 #include <linux/ioam6.h>
+#include <linux/memcontrol.h>
 
 #define IPV6_MAX_STRLEN \
 	sizeof("ffff:ffff:ffff:ffff:ffff:ffff:255.255.255.255")
@@ -7528,3 +7529,59 @@ void addrconf_cleanup(void)
 
 	destroy_workqueue(addrconf_wq);
 }
+
+extern unsigned long ipv6_size(struct inet6_dev *in_dev)
+{
+	int space = 0;
+	struct ctl_table *table;
+	struct ipv6_devconf *p = &in_dev->cnf;
+
+	space += caculate_space(in_dev);
+	if (!in_dev->nd_parms)
+		return space;
+
+	space += neigh_size(in_dev->nd_parms);
+	if (!in_dev->stats.icmpv6msgdev)
+		return space;
+
+	space += caculate_space(in_dev->stats.icmpv6msgdev);
+	table = p->sysctl_header->ctl_table_arg;
+	if (!table)
+		return space;
+
+	space += caculate_space(table);
+	if (!p->sysctl_header)
+		return space;
+
+	space += caculate_space(p->sysctl_header);
+
+	return space;
+}
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
-- 
2.34.1


