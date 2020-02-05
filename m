Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCD51531C4
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2020 14:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgBEN0x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Feb 2020 08:26:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56963 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBEN0w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Feb 2020 08:26:52 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1izKha-00035h-NT; Wed, 05 Feb 2020 13:26:46 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: [PATCH v6 5/6] clone3: allow spawning processes into cgroups
Date:   Wed,  5 Feb 2020 14:26:22 +0100
Message-Id: <20200205132623.670015-6-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200205132623.670015-1-christian.brauner@ubuntu.com>
References: <20200205132623.670015-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This adds support for creating a process in a different cgroup than its
parent. Callers can limit and account processes and threads right from
the moment they are spawned:
- A service manager can directly spawn new services into dedicated
  cgroups.
- A process can be directly created in a frozen cgroup and will be
  frozen as well.
- The initial accounting jitter experienced by process supervisors and
  daemons is eliminated with this.
- Threaded applications or even thread implementations can choose to
  create a specific cgroup layout where each thread is spawned
  directly into a dedicated cgroup.

This feature is limited to the unified hierarchy. Callers need to pass
a directory file descriptor for the target cgroup. The caller can
choose to pass an O_PATH file descriptor. All usual migration
restrictions apply, i.e. there can be no processes in inner nodes. In
general, creating a process directly in a target cgroup adheres to all
migration restrictions.

One of the biggest advantages of this feature is that CLONE_INTO_GROUP does
not need to grab the write side of the cgroup cgroup_threadgroup_rwsem.
This global lock makes moving tasks/threads around super expensive. With
clone3() this lock is avoided.

Cc: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
Link: https://lore.kernel.org/r/20191218173516.7875-3-christian.brauner@ubuntu.com

/* v2 */
Link: https://lore.kernel.org/r/20191223061504.28716-3-christian.brauner@ubuntu.com
- Oleg Nesterov <oleg@redhat.com>:
  - prevent deadlock from wrong locking order
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Rework locking. In the previous patch version we would have already
    acquired the cgroup_threadgroup_rwsem before we grabbed cgroup mutex
    we need to hold when CLONE_INTO_CGROUP is specified. This meant we
    could deadlock with other codepaths that all require it to be done
    the other way around. Fix this by first grabbing cgroup mutex when
    CLONE_INTO_CGROUP is specified and then grabbing
    cgroup_threadgroup_rwsem unconditionally after. This way we don't
    require the cgroup mutex be held in codepaths that don't need it.
  - Switch from mutex_lock() to mutex_lock_killable().

/* v3 */
Link: https://lore.kernel.org/r/20200117002143.15559-5-christian.brauner@ubuntu.com
- Tejun Heo <tj@kernel.org>:
  - s/mutex_lock_killable()/mutex_lock()/ because it should only ever
    be held for a short time:
    diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
    index a9fedcfeae4b..d68d3fb6af1d 100644
    --- a/kernel/cgroup/cgroup.c
    +++ b/kernel/cgroup/cgroup.c
    @@ -5927,11 +5927,8 @@ static int cgroup_css_set_fork(struct task_struct *parent,
            struct super_block *sb;
            struct file *f;

    -       if (kargs->flags & CLONE_INTO_CGROUP) {
    -               ret = mutex_lock_killable(&cgroup_mutex);
    -               if (ret)
    -                       return ret;
    -       }
    +       if (kargs->flags & CLONE_INTO_CGROUP)
    +               mutex_lock(&cgroup_mutex);

            cgroup_threadgroup_change_begin(parent);
  - s/task_cgroup_from_root/cset->dfl_cgrp/:
    diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
    index d68d3fb6af1d..3ceef006d144 100644
    --- a/kernel/cgroup/cgroup.c
    +++ b/kernel/cgroup/cgroup.c
    @@ -5922,7 +5922,7 @@ static int cgroup_css_set_fork(struct task_struct *parent,
            __acquires(&cgroup_mutex) __acquires(&cgroup_threadgroup_rwsem)
     {
            int ret;
    -       struct cgroup *dst_cgrp = NULL, *src_cgrp;
    +       struct cgroup *dst_cgrp = NULL;
            struct css_set *cset;
            struct super_block *sb;
            struct file *f;
    @@ -5956,11 +5956,7 @@ static int cgroup_css_set_fork(struct task_struct *parent,
                    goto err;
            }

    -       spin_lock_irq(&css_set_lock);
    -       src_cgrp = task_cgroup_from_root(parent, &cgrp_dfl_cgrp);
    -       spin_unlock_irq(&css_set_lock);
    -
    -       ret = cgroup_attach_permissions(src_cgrp, dst_cgrp, sb,
    +       ret = cgroup_attach_permissions(cset->dfl_cgrp, dst_cgrp, sb,
                                            !!(kargs->flags & CLONE_THREAD));
            if (ret)
                    goto err;
  - pass struct css_set instead of struct kernel_clone_args into cgroup
    fork subsystem callbacks:
    diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
    index cd848c6bac4a..058bb16d073f 100644
    --- a/include/linux/cgroup-defs.h
    +++ b/include/linux/cgroup-defs.h
    @@ -630,9 +630,8 @@ struct cgroup_subsys {
     	void (*attach)(struct cgroup_taskset *tset);
     	void (*post_attach)(void);
     	int (*can_fork)(struct task_struct *parent, struct task_struct *child,
    -			struct kernel_clone_args *kargs);
    -	void (*cancel_fork)(struct task_struct *child,
    -			    struct kernel_clone_args *kargs);
    +			struct css_set *cset);
    +	void (*cancel_fork)(struct task_struct *child, struct css_set *cset);
     	void (*fork)(struct task_struct *task);
     	void (*exit)(struct task_struct *task);
     	void (*release)(struct task_struct *task);
    diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
    index 3ceef006d144..2ac1c37a3fcb 100644
    --- a/kernel/cgroup/cgroup.c
    +++ b/kernel/cgroup/cgroup.c
    @@ -6044,7 +6044,7 @@ int cgroup_can_fork(struct task_struct *parent, struct task_struct *child,
     		return ret;

     	do_each_subsys_mask(ss, i, have_canfork_callback) {
    -		ret = ss->can_fork(parent, child, kargs);
    +		ret = ss->can_fork(parent, child, kargs->cset);
     		if (ret)
     			goto out_revert;
     	} while_each_subsys_mask();
    @@ -6056,7 +6056,7 @@ int cgroup_can_fork(struct task_struct *parent, struct task_struct *child,
     		if (j >= i)
     			break;
     		if (ss->cancel_fork)
    -			ss->cancel_fork(child, kargs);
    +			ss->cancel_fork(child, kargs->cset);
     	}

     	cgroup_css_set_put_fork(parent, kargs);
    @@ -6082,7 +6082,7 @@ void cgroup_cancel_fork(struct task_struct *parent, struct task_struct *child,

     	for_each_subsys(ss, i)
     		if (ss->cancel_fork)
    -			ss->cancel_fork(child, kargs);
    +			ss->cancel_fork(child, kargs->cset);

     	cgroup_css_set_put_fork(parent, kargs);
     }
    diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
    index e5955bc1fb00..4e7c8819c8df 100644
    --- a/kernel/cgroup/pids.c
    +++ b/kernel/cgroup/pids.c
    @@ -216,20 +216,16 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
      * on cgroup_threadgroup_change_begin() held by the copy_process().
      */
     static int pids_can_fork(struct task_struct *parent, struct task_struct *child,
    -			 struct kernel_clone_args *args)
    +			 struct css_set *cset)
     {
    -	struct css_set *new_cset = NULL;
     	struct cgroup_subsys_state *css;
     	struct pids_cgroup *pids;
     	int err;

    -	if (args)
    -		new_cset = args->cset;
    -
    -	if (!new_cset)
    -		css = task_css_check(current, pids_cgrp_id, true);
    +	if (cset)
    +		css = cset->subsys[pids_cgrp_id];
     	else
    -		css = new_cset->subsys[pids_cgrp_id];
    +		css = task_css_check(current, pids_cgrp_id, true);
     	pids = css_pids(css);
     	err = pids_try_charge(pids, 1);
     	if (err) {
    @@ -244,20 +240,15 @@ static int pids_can_fork(struct task_struct *parent, struct task_struct *child,
     	return err;
     }

    -static void pids_cancel_fork(struct task_struct *task,
    -			     struct kernel_clone_args *args)
    +static void pids_cancel_fork(struct task_struct *task, struct css_set *cset)
     {
    -	struct css_set *new_cset = NULL;
     	struct cgroup_subsys_state *css;
     	struct pids_cgroup *pids;

    -	if (args)
    -		new_cset = args->cset;
    -
    -	if (!new_cset)
    -		css = task_css_check(current, pids_cgrp_id, true);
    +	if (cset)
    +		css = cset->subsys[pids_cgrp_id];
     	else
    -		css = new_cset->subsys[pids_cgrp_id];
    +		css = task_css_check(current, pids_cgrp_id, true);
     	pids = css_pids(css);
     	pids_uncharge(pids, 1);
     }
- Michal Koutný <mkoutny@suse.com>:
  - update comment for cgroup_fork()
  - if CLONE_NEWCGROUP and CLONE_INTO_CGROUP is requested, set the
    root_cset of the new cgroup namespace to the child's cset

/* v4 */
Link: https://lore.kernel.org/r/20200117181219.14542-6-christian.brauner@ubuntu.com
- Tejun Heo <tj@kernel.org>:
  - verify that we can write to the target cgroup since we're not going through
    the vfs layer which would do it for us
    diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
    index 61d1a6cd0059..6b38b2545667 100644
    --- a/kernel/cgroup/cgroup.c
    +++ b/kernel/cgroup/cgroup.c
    @@ -5966,6 +5966,15 @@ static int cgroup_css_set_fork(struct task_struct *parent,
                    goto err;
            }

    +       /*
    +        * Verify that we can the target cgroup is writable for us. This is
    +        * usally done by the vfs layer but since we're not going through the
    +        * vfs layer here we need to do it.
    +        */
    +       ret = cgroup_may_write(dst_cgrp, sb);
    +       if (ret)
    +               goto err;
    +
            ret = cgroup_attach_permissions(cset->dfl_cgrp, dst_cgrp, sb,
                                            !!(kargs->flags & CLONE_THREAD));
            if (ret)
/* v5 */
Link: https://lore.kernel.org/r/20200121154844.411-6-christian.brauner@ubuntu.com
- Oleg Nesterov <oleg@redhat.com>:
  - remove struct task_struct *parent argument from clone helpers in favor of
    using current directly
  - remove cgroup_same_domain_helper()
    diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
    index f4379401327a..4d36255ef25f 100644
    --- a/kernel/cgroup/cgroup.c
    +++ b/kernel/cgroup/cgroup.c
    @@ -4696,12 +4696,6 @@ static int cgroup_procs_write_permission(struct cgroup *src_cgrp,
            return 0;
     }

    -static inline bool cgroup_same_domain(const struct cgroup *src_cgrp,
    -                                     const struct cgroup *dst_cgrp)
    -{
    -       return src_cgrp->dom_cgrp == dst_cgrp->dom_cgrp;
    -}
    -
     static int cgroup_attach_permissions(struct cgroup *src_cgrp,
                                         struct cgroup *dst_cgrp,
                                         struct super_block *sb, bool thread)
    @@ -4716,8 +4710,7 @@ static int cgroup_attach_permissions(struct cgroup *src_cgrp,
            if (ret)
                    return ret;

    -       if (thread &&
    -           !cgroup_same_domain(src_cgrp->dom_cgrp, dst_cgrp->dom_cgrp))
    +       if (thread && (src_cgrp->dom_cgrp != dst_cgrp->dom_cgrp))
                    ret = -EOPNOTSUPP;

            return ret;
  - put kargs->cset on failure
    diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
    index 4d36255ef25f..482055d1e64a 100644
    --- a/kernel/cgroup/cgroup.c
    +++ b/kernel/cgroup/cgroup.c
    @@ -5994,6 +5994,8 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
            if (dst_cgrp)
                    cgroup_put(dst_cgrp);
            put_css_set(cset);
    +       if (kargs->cset)
    +               put_css_set(kargs->cset);
            return ret;
     }

/* v6 */
- Michal Koutný <mkoutny@suse.com>:
  - Move check whether cgroup is still alive right after getting it from the
    passed-in file descriptor:
    diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
    index 30a24ab3d74f..99bd4c1cea52 100644
    --- a/kernel/cgroup/cgroup.c
    +++ b/kernel/cgroup/cgroup.c
    @@ -5956,6 +5956,11 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
     		goto err;
     	}

    +	if (cgroup_is_dead(dst_cgrp)) {
    +		ret = -ENODEV;
    +		goto err;
    +	}
    +
     	/*
     	 * Verify that we the target cgroup is writable for us. This is
     	 * usually done by the vfs layer but since we're not going through
    @@ -5976,11 +5981,6 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
     		goto err;
     	}

    -	if (cgroup_is_dead(dst_cgrp)) {
    -		ret = -ENODEV;
    -		goto err;
    -	}
    -
     	put_css_set(cset);
     	fput(f);
     	kargs->cgrp = dst_cgrp;
    - put old root cset and get new root cset:
      diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
      index 99bd4c1cea52..2cb93b11ebf5 100644
      --- a/kernel/cgroup/cgroup.c
      +++ b/kernel/cgroup/cgroup.c
      @@ -6153,8 +6153,14 @@ void cgroup_post_fork(struct task_struct *child,
              }

              /* Make the new cset the root_cset of the new cgroup namespace. */
      -       if (kargs->flags & CLONE_NEWCGROUP)
      +
      +       if (kargs->flags & CLONE_NEWCGROUP) {
      +               struct css_set *rcset = child->nsproxy->cgroup_ns->root_cset;
      +
      +               get_css_set(cset);
                      child->nsproxy->cgroup_ns->root_cset = cset;
      +               put_css_set(rcset);
      +       }
       }
    - use cgroup_css_set_put_fork() in cgroup_post_fork() too:
      diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
      index 2cb93b11ebf5..9b11e7f44686 100644
      --- a/kernel/cgroup/cgroup.c
      +++ b/kernel/cgroup/cgroup.c
      @@ -6104,9 +6104,12 @@ void cgroup_post_fork(struct task_struct *child,
       	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
       {
       	struct cgroup_subsys *ss;
      -	struct css_set *cset = kargs->cset;
      +	struct css_set *cset;
       	int i;

      +	cset = kargs->cset;
      +	kargs->cset = NULL;
      +
       	spin_lock_irq(&css_set_lock);

       	WARN_ON_ONCE(!list_empty(&child->cg_list));
      @@ -6143,15 +6146,6 @@ void cgroup_post_fork(struct task_struct *child,
       		ss->fork(child);
       	} while_each_subsys_mask();

      -	cgroup_threadgroup_change_end(current);
      -
      -	if (kargs->flags & CLONE_INTO_CGROUP) {
      -		mutex_unlock(&cgroup_mutex);
      -
      -		cgroup_put(kargs->cgrp);
      -		kargs->cgrp = NULL;
      -	}
      -
       	/* Make the new cset the root_cset of the new cgroup namespace. */

       	if (kargs->flags & CLONE_NEWCGROUP) {
      @@ -6161,6 +6155,8 @@ void cgroup_post_fork(struct task_struct *child,
       		child->nsproxy->cgroup_ns->root_cset = cset;
       		put_css_set(rcset);
       	}
      +
      +	cgroup_css_set_put_fork(kargs);
       }
- Christian Brauner <christian.brauner@ubuntu.com>:
  - remove struct kernel_clone_args forward declaration from cgroup-defs.h
    header. This was needed in a previous version of the series but isn't
    needed anymore.
    diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
    index 89d627abcbd6..68c391f451d1 100644
    --- a/include/linux/cgroup-defs.h
    +++ b/include/linux/cgroup-defs.h
    @@ -33,7 +33,6 @@ struct kernfs_ops;
     struct kernfs_open_file;
     struct seq_file;
     struct poll_table_struct;
    -struct kernel_clone_args;

     #define MAX_CGROUP_TYPE_NAMELEN 32
     #define MAX_CGROUP_ROOT_NAMELEN 64
---
 include/linux/cgroup-defs.h |   5 +-
 include/linux/cgroup.h      |  20 ++--
 include/linux/sched/task.h  |   4 +
 include/uapi/linux/sched.h  |   5 +
 kernel/cgroup/cgroup.c      | 188 +++++++++++++++++++++++++++++++-----
 kernel/cgroup/pids.c        |  15 ++-
 kernel/fork.c               |  13 ++-
 7 files changed, 211 insertions(+), 39 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 63097cb243cb..68c391f451d1 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -628,8 +628,9 @@ struct cgroup_subsys {
 	void (*cancel_attach)(struct cgroup_taskset *tset);
 	void (*attach)(struct cgroup_taskset *tset);
 	void (*post_attach)(void);
-	int (*can_fork)(struct task_struct *task);
-	void (*cancel_fork)(struct task_struct *task);
+	int (*can_fork)(struct task_struct *task,
+			struct css_set *cset);
+	void (*cancel_fork)(struct task_struct *task, struct css_set *cset);
 	void (*fork)(struct task_struct *task);
 	void (*exit)(struct task_struct *task);
 	void (*release)(struct task_struct *task);
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index d7ddebd0cdec..fbbaeac9fe29 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -27,6 +27,8 @@
 
 #include <linux/cgroup-defs.h>
 
+struct kernel_clone_args;
+
 #ifdef CONFIG_CGROUPS
 
 /*
@@ -121,9 +123,12 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		     struct pid *pid, struct task_struct *tsk);
 
 void cgroup_fork(struct task_struct *p);
-extern int cgroup_can_fork(struct task_struct *p);
-extern void cgroup_cancel_fork(struct task_struct *p);
-extern void cgroup_post_fork(struct task_struct *p);
+extern int cgroup_can_fork(struct task_struct *p,
+			   struct kernel_clone_args *kargs);
+extern void cgroup_cancel_fork(struct task_struct *p,
+			       struct kernel_clone_args *kargs);
+extern void cgroup_post_fork(struct task_struct *p,
+			     struct kernel_clone_args *kargs);
 void cgroup_exit(struct task_struct *p);
 void cgroup_release(struct task_struct *p);
 void cgroup_free(struct task_struct *p);
@@ -707,9 +712,12 @@ static inline int cgroupstats_build(struct cgroupstats *stats,
 				    struct dentry *dentry) { return -EINVAL; }
 
 static inline void cgroup_fork(struct task_struct *p) {}
-static inline int cgroup_can_fork(struct task_struct *p) { return 0; }
-static inline void cgroup_cancel_fork(struct task_struct *p) {}
-static inline void cgroup_post_fork(struct task_struct *p) {}
+static inline int cgroup_can_fork(struct task_struct *p,
+				  struct kernel_clone_args *kargs) { return 0; }
+static inline void cgroup_cancel_fork(struct task_struct *p,
+				      struct kernel_clone_args *kargs) {}
+static inline void cgroup_post_fork(struct task_struct *p,
+				    struct kernel_clone_args *kargs) {}
 static inline void cgroup_exit(struct task_struct *p) {}
 static inline void cgroup_release(struct task_struct *p) {}
 static inline void cgroup_free(struct task_struct *p) {}
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index f1879884238e..38359071236a 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -13,6 +13,7 @@
 struct task_struct;
 struct rusage;
 union thread_union;
+struct css_set;
 
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
@@ -29,6 +30,9 @@ struct kernel_clone_args {
 	pid_t *set_tid;
 	/* Number of elements in *set_tid */
 	size_t set_tid_size;
+	int cgroup;
+	struct cgroup *cgrp;
+	struct css_set *cset;
 };
 
 /*
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 4a0217832464..08620c220f30 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -35,6 +35,7 @@
 
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
+#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
 
 #ifndef __ASSEMBLY__
 /**
@@ -75,6 +76,8 @@
  * @set_tid_size: This defines the size of the array referenced
  *                in @set_tid. This cannot be larger than the
  *                kernel's limit of nested PID namespaces.
+ * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
+ *                a file descriptor for the cgroup.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -91,11 +94,13 @@ struct clone_args {
 	__aligned_u64 tls;
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
+	__aligned_u64 cgroup;
 };
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
+#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
 
 /*
  * Scheduling policies
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 43c841596226..20fbae07e7b8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5876,8 +5876,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
  * @child: pointer to task_struct of forking parent process.
  *
  * A task is associated with the init_css_set until cgroup_post_fork()
- * attaches it to the parent's css_set.  Empty cg_list indicates that
- * @child isn't holding reference to its css_set.
+ * attaches it to the target css_set.
  */
 void cgroup_fork(struct task_struct *child)
 {
@@ -5903,24 +5902,154 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
 	return cgrp;
 }
 
+/**
+ * cgroup_css_set_fork - find or create a css_set for a child process
+ * @kargs: the arguments passed to create the child process
+ *
+ * This functions finds or creates a new css_set which the child
+ * process will be attached to in cgroup_post_fork(). By default,
+ * the child process will be given the same css_set as its parent.
+ *
+ * If CLONE_INTO_CGROUP is specified this function will try to find an
+ * existing css_set which includes the requested cgroup and if not create
+ * a new css_set that the child will be attached to later. If this function
+ * succeeds it will hold cgroup_threadgroup_rwsem on return. If
+ * CLONE_INTO_CGROUP is requested this function will grab cgroup mutex
+ * before grabbing cgroup_threadgroup_rwsem and will hold a reference
+ * to the target cgroup.
+ */
+static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
+	__acquires(&cgroup_mutex) __acquires(&cgroup_threadgroup_rwsem)
+{
+	int ret;
+	struct cgroup *dst_cgrp = NULL;
+	struct css_set *cset;
+	struct super_block *sb;
+	struct file *f;
+
+	if (kargs->flags & CLONE_INTO_CGROUP)
+		mutex_lock(&cgroup_mutex);
+
+	cgroup_threadgroup_change_begin(current);
+
+	spin_lock_irq(&css_set_lock);
+	cset = task_css_set(current);
+	get_css_set(cset);
+	spin_unlock_irq(&css_set_lock);
+
+	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
+		kargs->cset = cset;
+		return 0;
+	}
+
+	f = fget_raw(kargs->cgroup);
+	if (!f) {
+		ret = -EBADF;
+		goto err;
+	}
+	sb = f->f_path.dentry->d_sb;
+
+	dst_cgrp = cgroup_get_from_file(f);
+	if (IS_ERR(dst_cgrp)) {
+		ret = PTR_ERR(dst_cgrp);
+		dst_cgrp = NULL;
+		goto err;
+	}
+
+	if (cgroup_is_dead(dst_cgrp)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/*
+	 * Verify that we the target cgroup is writable for us. This is
+	 * usually done by the vfs layer but since we're not going through
+	 * the vfs layer here we need to do it "manually".
+	 */
+	ret = cgroup_may_write(dst_cgrp, sb);
+	if (ret)
+		goto err;
+
+	ret = cgroup_attach_permissions(cset->dfl_cgrp, dst_cgrp, sb,
+					!(kargs->flags & CLONE_THREAD));
+	if (ret)
+		goto err;
+
+	kargs->cset = find_css_set(cset, dst_cgrp);
+	if (!kargs->cset) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	put_css_set(cset);
+	fput(f);
+	kargs->cgrp = dst_cgrp;
+	return ret;
+
+err:
+	cgroup_threadgroup_change_end(current);
+	mutex_unlock(&cgroup_mutex);
+	if (f)
+		fput(f);
+	if (dst_cgrp)
+		cgroup_put(dst_cgrp);
+	put_css_set(cset);
+	if (kargs->cset)
+		put_css_set(kargs->cset);
+	return ret;
+}
+
+/**
+ * cgroup_css_set_put_fork - drop references we took during fork
+ * @kargs: the arguments passed to create the child process
+ *
+ * Drop references to the prepared css_set and target cgroup if
+ * CLONE_INTO_CGROUP was requested.
+ */
+static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
+	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
+{
+	cgroup_threadgroup_change_end(current);
+
+	if (kargs->flags & CLONE_INTO_CGROUP) {
+		struct cgroup *cgrp = kargs->cgrp;
+		struct css_set *cset = kargs->cset;
+
+		mutex_unlock(&cgroup_mutex);
+
+		if (cset) {
+			put_css_set(cset);
+			kargs->cset = NULL;
+		}
+
+		if (cgrp) {
+			cgroup_put(cgrp);
+			kargs->cgrp = NULL;
+		}
+	}
+}
+
 /**
  * cgroup_can_fork - called on a new task before the process is exposed
  * @child: the child process
  *
+ * This prepares a new css_set for the child process which the child will
+ * be attached to in cgroup_post_fork().
  * This calls the subsystem can_fork() callbacks. If the cgroup_can_fork()
  * callback returns an error, the fork aborts with that error code. This
  * allows for a cgroup subsystem to conditionally allow or deny new forks.
  */
-int cgroup_can_fork(struct task_struct *child)
-	__acquires(&cgroup_threadgroup_rwsem) __releases(&cgroup_threadgroup_rwsem)
+int cgroup_can_fork(struct task_struct *child, struct kernel_clone_args *kargs)
 {
 	struct cgroup_subsys *ss;
 	int i, j, ret;
 
-	cgroup_threadgroup_change_begin(current);
+	ret = cgroup_css_set_fork(kargs);
+	if (ret)
+		return ret;
 
 	do_each_subsys_mask(ss, i, have_canfork_callback) {
-		ret = ss->can_fork(child);
+		ret = ss->can_fork(child, kargs->cset);
 		if (ret)
 			goto out_revert;
 	} while_each_subsys_mask();
@@ -5932,32 +6061,34 @@ int cgroup_can_fork(struct task_struct *child)
 		if (j >= i)
 			break;
 		if (ss->cancel_fork)
-			ss->cancel_fork(child);
+			ss->cancel_fork(child, kargs->cset);
 	}
 
-	cgroup_threadgroup_change_end(current);
+	cgroup_css_set_put_fork(kargs);
 
 	return ret;
 }
 
 /**
-  * cgroup_cancel_fork - called if a fork failed after cgroup_can_fork()
-  * @child: the child process
-  *
-  * This calls the cancel_fork() callbacks if a fork failed *after*
-  * cgroup_can_fork() succeded.
-  */
-void cgroup_cancel_fork(struct task_struct *child)
-	__releases(&cgroup_threadgroup_rwsem)
+ * cgroup_cancel_fork - called if a fork failed after cgroup_can_fork()
+ * @child: the child process
+ * @kargs: the arguments passed to create the child process
+ *
+ * This calls the cancel_fork() callbacks if a fork failed *after*
+ * cgroup_can_fork() succeded and cleans up references we took to
+ * prepare a new css_set for the child process in cgroup_can_fork().
+ */
+void cgroup_cancel_fork(struct task_struct *child,
+			struct kernel_clone_args *kargs)
 {
 	struct cgroup_subsys *ss;
 	int i;
 
 	for_each_subsys(ss, i)
 		if (ss->cancel_fork)
-			ss->cancel_fork(child);
+			ss->cancel_fork(child, kargs->cset);
 
-	cgroup_threadgroup_change_end(current);
+	cgroup_css_set_put_fork(kargs);
 }
 
 /**
@@ -5967,18 +6098,20 @@ void cgroup_cancel_fork(struct task_struct *child)
  * Attach the child process to its css_set calling the subsystem fork()
  * callbacks.
  */
-void cgroup_post_fork(struct task_struct *child)
-	__releases(&cgroup_threadgroup_rwsem)
+void cgroup_post_fork(struct task_struct *child,
+		      struct kernel_clone_args *kargs)
+	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
 {
 	struct cgroup_subsys *ss;
 	struct css_set *cset;
 	int i;
 
+	cset = kargs->cset;
+	kargs->cset = NULL;
+
 	spin_lock_irq(&css_set_lock);
 
 	WARN_ON_ONCE(!list_empty(&child->cg_list));
-	cset = task_css_set(current); /* current is @child's parent */
-	get_css_set(cset);
 	cset->nr_tasks++;
 	css_set_move_task(child, NULL, cset, false);
 
@@ -6012,7 +6145,16 @@ void cgroup_post_fork(struct task_struct *child)
 		ss->fork(child);
 	} while_each_subsys_mask();
 
-	cgroup_threadgroup_change_end(current);
+	/* Make the new cset the root_cset of the new cgroup namespace. */
+	if (kargs->flags & CLONE_NEWCGROUP) {
+		struct css_set *rcset = child->nsproxy->cgroup_ns->root_cset;
+
+		get_css_set(cset);
+		child->nsproxy->cgroup_ns->root_cset = cset;
+		put_css_set(rcset);
+	}
+
+	cgroup_css_set_put_fork(kargs);
 }
 
 /**
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 138059eb730d..511af87f685e 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -33,6 +33,7 @@
 #include <linux/atomic.h>
 #include <linux/cgroup.h>
 #include <linux/slab.h>
+#include <linux/sched/task.h>
 
 #define PIDS_MAX (PID_MAX_LIMIT + 1ULL)
 #define PIDS_MAX_STR "max"
@@ -214,13 +215,16 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
  * task_css_check(true) in pids_can_fork() and pids_cancel_fork() relies
  * on cgroup_threadgroup_change_begin() held by the copy_process().
  */
-static int pids_can_fork(struct task_struct *task)
+static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 {
 	struct cgroup_subsys_state *css;
 	struct pids_cgroup *pids;
 	int err;
 
-	css = task_css_check(current, pids_cgrp_id, true);
+	if (cset)
+		css = cset->subsys[pids_cgrp_id];
+	else
+		css = task_css_check(current, pids_cgrp_id, true);
 	pids = css_pids(css);
 	err = pids_try_charge(pids, 1);
 	if (err) {
@@ -235,12 +239,15 @@ static int pids_can_fork(struct task_struct *task)
 	return err;
 }
 
-static void pids_cancel_fork(struct task_struct *task)
+static void pids_cancel_fork(struct task_struct *task, struct css_set *cset)
 {
 	struct cgroup_subsys_state *css;
 	struct pids_cgroup *pids;
 
-	css = task_css_check(current, pids_cgrp_id, true);
+	if (cset)
+		css = cset->subsys[pids_cgrp_id];
+	else
+		css = task_css_check(current, pids_cgrp_id, true);
 	pids = css_pids(css);
 	pids_uncharge(pids, 1);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index ca5de25690c8..2853e258fe1f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2171,7 +2171,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 * between here and cgroup_post_fork() if an organisation operation is in
 	 * progress.
 	 */
-	retval = cgroup_can_fork(p);
+	retval = cgroup_can_fork(p, args);
 	if (retval)
 		goto bad_fork_put_pidfd;
 
@@ -2278,7 +2278,7 @@ static __latent_entropy struct task_struct *copy_process(
 	write_unlock_irq(&tasklist_lock);
 
 	proc_fork_connector(p);
-	cgroup_post_fork(p);
+	cgroup_post_fork(p, args);
 	perf_event_fork(p);
 
 	trace_task_newtask(p, clone_flags);
@@ -2289,7 +2289,7 @@ static __latent_entropy struct task_struct *copy_process(
 bad_fork_cancel_cgroup:
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
-	cgroup_cancel_fork(p);
+	cgroup_cancel_fork(p, args);
 bad_fork_put_pidfd:
 	if (clone_flags & CLONE_PIDFD) {
 		fput(pidfile);
@@ -2618,6 +2618,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     !valid_signal(args.exit_signal)))
 		return -EINVAL;
 
+	if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup < 0)
+		return -EINVAL;
+
 	*kargs = (struct kernel_clone_args){
 		.flags		= args.flags,
 		.pidfd		= u64_to_user_ptr(args.pidfd),
@@ -2628,6 +2631,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		.stack_size	= args.stack_size,
 		.tls		= args.tls,
 		.set_tid_size	= args.set_tid_size,
+		.cgroup		= args.cgroup,
 	};
 
 	if (args.set_tid &&
@@ -2671,7 +2675,8 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
 static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
-	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND))
+	if (kargs->flags &
+	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP))
 		return false;
 
 	/*
-- 
2.25.0

