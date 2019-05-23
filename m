Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFFA27604
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2019 08:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfEWGeP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 May 2019 02:34:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33260 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWGeO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 May 2019 02:34:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id x132so3536363lfd.0;
        Wed, 22 May 2019 23:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Swt/tviFVrdldllTFG/toozpt7fqGqxTKnQaLDortqI=;
        b=lO0JJAIWi1WnPSQPaPIuid2u68WP+WhUJuNyCvZI79YGdtuRiQRPCcf0GktLHTa1kN
         /dK8euMc1YrZ+zOrqb8JhNfgaH8lUiQG3MhaXxE1ColBWerBKteh71FT5uA9eQ9ZglWs
         SbzCudHbL1KrQ/HHDR6IgIltiocI+RRWdgCxZXN0hGVndwR1+9FuErrvhUOlYNeDDOPz
         2yuan168Lv8vQQVfVYg53FZW3lXRuq/4ogJfzLcIA4W93qDXZaexiQxIoXiorqNVkLi+
         RY+MOY1+B49KX7XO1loYVWXHUFGSAFKxtBLwzgWcWWAr4bTFdB9xIR5TvFHOlDFSUP2Z
         klJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Swt/tviFVrdldllTFG/toozpt7fqGqxTKnQaLDortqI=;
        b=Syn7/gpEv88kh9JDBUBAAP6+1uWEkStvf/ZyvLvCIqLEdl5lPBYKemc/u19/cvtmiq
         HCRYlXFUBe5aZl5FeD2QHAP+X4qg2AFPIS8/shXrAMS/1cGZI5dXBPt74iS0Aw87bVAK
         05dG78de3RW2/cyTy/FQ4Ce3kSqx+hUvKgp3f9fYCWrtFxoQOyhpLwBPI/N7cWigI9EP
         NxauEsPx/J6sVBUvGglBN90balbUXgnSP5EOI1lJL7F4l/WlpIoMKnsh4ds4Irhmg+RP
         81yRTKmO2008ZAeEI8i41re31xN13/KH8G68X8S4FQuI4hpt+y5uyWQi0/4CQLAPw5fy
         SZdg==
X-Gm-Message-State: APjAAAVrcCSPB4lYld3v1XfEnBixCJto2Knhd5jqkTU0v8YTF1DknEQH
        8xX7xi3YPWx77lCLqcUszustetJhCsDLnaMegL1/0g==
X-Google-Smtp-Source: APXvYqyzpVdikFV6gbLoyfHsrIB9h6AoHZWikoBMYQd/PJBtmbYKadWdBCKxTKWoZc2Bd1oNs6ZZtf/rI+ew5GtIGlU=
X-Received: by 2002:ac2:5a1b:: with SMTP id q27mr41334833lfn.63.1558593251773;
 Wed, 22 May 2019 23:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190430120534.5231-1-xxhdx1985126@gmail.com>
In-Reply-To: <20190430120534.5231-1-xxhdx1985126@gmail.com>
From:   Xuehan Xu <xxhdx1985126@gmail.com>
Date:   Thu, 23 May 2019 14:33:46 +0800
Message-ID: <CAJACTuczjByPgDmBb1vgPdX5U0LWhygVNzRS+VPXt3ZSEo+eTQ@mail.gmail.com>
Subject: Fwd: [PATCH 1/2] cgroup: add a new group controller for cephfs
To:     ceph-devel <ceph-devel@vger.kernel.org>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Xuehan Xu <xuxuehan@360.cn>
cgroup: add a new cgroup controller dedicated to cephfs client ops limiting

this controller is supposed to limit the metadata
ops or data ops issued to the underlying cluster.

Signed-off-by: Xuehan Xu <xuxuehan@360.cn>
---
 include/linux/cgroup_cephfs.h |  57 +++++
 include/linux/cgroup_subsys.h |   4 +
 init/Kconfig                  |   5 +
 kernel/cgroup/Makefile        |   1 +
 kernel/cgroup/cephfs.c        | 398 ++++++++++++++++++++++++++++++++++
 5 files changed, 465 insertions(+)
 create mode 100644 include/linux/cgroup_cephfs.h
 create mode 100644 kernel/cgroup/cephfs.c

diff --git a/include/linux/cgroup_cephfs.h b/include/linux/cgroup_cephfs.h
new file mode 100644
index 000000000000..91809862b8f8
--- /dev/null
+++ b/include/linux/cgroup_cephfs.h
@@ -0,0 +1,57 @@
+#ifndef _CEPHFS_CGROUP_H
+#define _CEPHFS_CGROUP_H
+
+#include <linux/cgroup.h>
+
+#define META_OPS_IOPS_IDX 0
+#define DATA_OPS_IOPS_IDX 0
+#define DATA_OPS_BAND_IDX 1
+#define META_OPS_TB_NUM 1
+#define DATA_OPS_TB_NUM 2
+
+/*
+ * token bucket throttle
+ */
+struct token_bucket {
+    u64 remain;
+    u64 max;
+    u64 target_throughput;
+};
+
+struct token_bucket_throttle {
+    struct token_bucket* tb;
+    u64 tick_interval;
+    int tb_num;
+    struct list_head reqs_blocked;
+    struct mutex bucket_lock;
+    struct delayed_work tick_work;
+    unsigned long tbt_timeout;
+};
+
+struct queue_item {
+    struct list_head token_bucket_throttle_item;
+    u64* tokens_requested;
+    int tb_item_num;
+    struct completion throttled;
+    unsigned long tbt_timeout;
+};
+
+struct cephfscg {
+    struct cgroup_subsys_state  css;
+    spinlock_t          lock;
+
+    struct token_bucket_throttle meta_ops_throttle;
+    struct token_bucket_throttle data_ops_throttle;
+};
+
+extern void schedule_token_bucket_throttle_tick(struct
token_bucket_throttle* ptbt, u64 tick_interval);
+
+extern void token_bucket_throttle_tick(struct work_struct* work);
+
+extern int get_token_bucket_throttle(struct token_bucket_throttle*
ptbt, struct queue_item* req);
+
+extern int queue_item_init(struct queue_item* qitem, struct
token_bucket_throttle* ptbt, int tb_item_num);
+
+extern int token_bucket_throttle_init(struct token_bucket_throttle*
ptbt, int token_bucket_num);
+
+#endif /*_CEPHFS_CGROUP_H*/
diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
index acb77dcff3b4..577a276570a5 100644
--- a/include/linux/cgroup_subsys.h
+++ b/include/linux/cgroup_subsys.h
@@ -61,6 +61,10 @@ SUBSYS(pids)
 SUBSYS(rdma)
 #endif

+#if IS_ENABLED(CONFIG_CGROUP_CEPH_FS)
+SUBSYS(cephfs)
+#endif
+
 /*
  * The following subsystems are not supported on the default hierarchy.
  */
diff --git a/init/Kconfig b/init/Kconfig
index 4592bf7997c0..e22f3aea9e23 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -867,6 +867,11 @@ config CGROUP_RDMA
          Attaching processes with active RDMA resources to the cgroup
          hierarchy is allowed even if can cross the hierarchy's limit.

+config CGROUP_CEPH_FS
+    bool "cephfs controller"
+    help
+        cephfs cgroup controller
+
 config CGROUP_FREEZER
        bool "Freezer controller"
        help
diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index bfcdae896122..aaf836181f1a 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_CGROUP_PIDS) += pids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_CGROUP_DEBUG) += debug.o
+obj-$(CONFIG_CGROUP_CEPH_FS) += cephfs.o
diff --git a/kernel/cgroup/cephfs.c b/kernel/cgroup/cephfs.c
new file mode 100644
index 000000000000..65b9e9618a5d
--- /dev/null
+++ b/kernel/cgroup/cephfs.c
@@ -0,0 +1,398 @@
+#include <linux/cgroup_cephfs.h>
+#include <linux/slab.h>
+
+struct cephfscg cephfscg_root;
+
+static void put_token(struct token_bucket_throttle* ptbt, u64 tick_interval)
+{
+    struct token_bucket* ptb = NULL;
+    u64 tokens_to_put = 0;
+    int i = 0;
+
+    for (i = 0; i < ptbt->tb_num; i++) {
+        ptb = &ptbt->tb[i];
+
+        if (!ptb->max)
+            continue;
+
+        tokens_to_put = ptb->target_throughput * tick_interval / HZ;
+
+        if (ptb->remain + tokens_to_put >= ptb->max)
+            ptb->remain = ptb->max;
+        else
+            ptb->remain += tokens_to_put;
+        pr_debug("%s: put_token: token bucket remain: %lld\n",
__func__, ptb->remain);
+    }
+}
+
+static bool should_wait(struct token_bucket_throttle* ptbt, struct
queue_item* qitem)
+{
+    struct token_bucket* ptb = NULL;
+    int i = 0;
+
+    BUG_ON(ptbt->tb_num != qitem->tb_item_num);
+    for (i = 0; i < ptbt->tb_num; i++) {
+        ptb = &ptbt->tb[i];
+
+        if (!ptb->max)
+            continue;
+
+        if (ptb->remain < qitem->tokens_requested[i])
+            return true;
+    }
+    return false;
+}
+
+static void get_token(struct token_bucket_throttle* ptbt, struct
queue_item* qitem)
+{
+    struct token_bucket* ptb = NULL;
+    int i = 0;
+    BUG_ON(should_wait(ptbt, qitem));
+
+    for (i = 0; i < ptbt->tb_num; i++) {
+        ptb = &ptbt->tb[i];
+        if (!ptb->max)
+            continue;
+        ptb->remain -= qitem->tokens_requested[i];
+    }
+}
+
+void schedule_token_bucket_throttle_tick(struct
token_bucket_throttle* ptbt, u64 tick_interval)
+{
+    if (tick_interval)
+        schedule_delayed_work(&ptbt->tick_work, tick_interval);
+}
+EXPORT_SYMBOL(schedule_token_bucket_throttle_tick);
+
+void token_bucket_throttle_tick(struct work_struct* work)
+{
+    struct token_bucket_throttle* ptbt =
+        container_of(work, struct token_bucket_throttle, tick_work.work);
+    struct queue_item* req = NULL, *tmp = NULL;
+    LIST_HEAD(reqs_to_go);
+    u64 tick_interval = ptbt->tick_interval;
+
+    mutex_lock(&ptbt->bucket_lock);
+    put_token(ptbt, tick_interval);
+    if (!tick_interval)
+        pr_debug("%s: tick_interval set to 0, turning off the
throttle, item: %p\n", __func__, req);
+
+    list_for_each_entry_safe(req, tmp, &ptbt->reqs_blocked,
token_bucket_throttle_item) {
+        pr_debug("%s: waiting item: %p\n", __func__, req);
+        if (tick_interval) {
+            if (should_wait(ptbt, req))
+                break;
+            get_token(ptbt, req);
+        }
+        list_del(&req->token_bucket_throttle_item);
+        list_add_tail(&req->token_bucket_throttle_item, &reqs_to_go);
+        pr_debug("%s: tokens got for req: %p\n", __func__, req);
+    }
+    mutex_unlock(&ptbt->bucket_lock);
+
+    list_for_each_entry_safe(req, tmp, &reqs_to_go,
token_bucket_throttle_item) {
+        pr_debug("%s: notifying req: %p, list head: %p\n", __func__,
req, &reqs_to_go);
+        complete_all(&req->throttled);
+        list_del(&req->token_bucket_throttle_item);
+    }
+
+    if (tick_interval)
+        schedule_token_bucket_throttle_tick(ptbt, tick_interval);
+}
+EXPORT_SYMBOL(token_bucket_throttle_tick);
+
+int get_token_bucket_throttle(struct token_bucket_throttle* ptbt,
struct queue_item* req)
+{
+    int ret = 0;
+    long timeleft = 0;
+
+    mutex_lock(&ptbt->bucket_lock);
+    if (should_wait(ptbt, req)) {
+        pr_debug("%s: wait for tokens, req: %p\n", __func__, req);
+        list_add_tail(&req->token_bucket_throttle_item, &ptbt->reqs_blocked);
+        mutex_unlock(&ptbt->bucket_lock);
+        timeleft =
wait_for_completion_killable_timeout(&req->throttled, req->tbt_timeout
?: MAX_SCHEDULE_TIMEOUT);
+        if (timeleft > 0)
+            ret = 0;
+        else if (!timeleft)
+            ret = -EIO; /* timed out */
+        else {
+            /* killed */
+            pr_debug("%s: killed, req: %p\n", __func__, req);
+            mutex_lock(&ptbt->bucket_lock);
+            list_del(&req->token_bucket_throttle_item);
+            mutex_unlock(&ptbt->bucket_lock);
+            ret = timeleft;
+        }
+    } else {
+        pr_debug("%s: no need to wait for tokens, going ahead, req:
%p\n", __func__, req);
+        get_token(ptbt, req);
+        mutex_unlock(&ptbt->bucket_lock);
+    }
+    return ret;
+}
+EXPORT_SYMBOL(get_token_bucket_throttle);
+
+int queue_item_init(struct queue_item* qitem, struct
token_bucket_throttle* ptbt, int tb_item_num)
+{
+    qitem->tokens_requested =
kzalloc(sizeof(*qitem->tokens_requested) * tb_item_num, GFP_KERNEL);
+    if (!qitem->tokens_requested)
+        return -ENOMEM;
+
+    qitem->tb_item_num = tb_item_num;
+    INIT_LIST_HEAD(&qitem->token_bucket_throttle_item);
+    init_completion(&qitem->throttled);
+    qitem->tbt_timeout = ptbt->tbt_timeout;
+
+    return 0;
+}
+EXPORT_SYMBOL(queue_item_init);
+
+int token_bucket_throttle_init(struct token_bucket_throttle* ptbt,
+        int token_bucket_num)
+{
+    int i = 0;
+
+    INIT_LIST_HEAD(&ptbt->reqs_blocked);
+    mutex_init(&ptbt->bucket_lock);
+    ptbt->tb_num = token_bucket_num;
+    ptbt->tb = kzalloc(sizeof(*ptbt->tb) * ptbt->tb_num, GFP_KERNEL);
+    if (!ptbt->tb) {
+        return -ENOMEM;
+    }
+
+    for (i = 0; i < ptbt->tb_num; i++) {
+        ptbt->tb[i].target_throughput = 0;
+        ptbt->tb[i].max = 0;
+    }
+    ptbt->tick_interval = 0;
+    ptbt->tbt_timeout = 0;
+    INIT_DELAYED_WORK(&ptbt->tick_work, token_bucket_throttle_tick);
+
+    return 0;
+}
+EXPORT_SYMBOL(token_bucket_throttle_init);
+
+static int set_throttle_params(struct token_bucket_throttle* ptbt,
char* param_list)
+{
+    char* options = strstrip(param_list);
+    char* val = NULL;
+    int res = 0;
+    unsigned long interval = 0, timeout = 0, last_interval =
ptbt->tick_interval;
+
+    val = strsep(&options, ",");
+    if (!val)
+        return -EINVAL;
+
+    res = kstrtol(val, 0, &interval);
+    if (res)
+        return res;
+
+    val = strsep(&options, ",");
+    if (!val)
+        return -EINVAL;
+
+    res = kstrtol(val, 0, &timeout);
+    if (res)
+        return res;
+
+    if (last_interval && !interval) {
+        int i = 0;
+
+        for (i = 0; i<ptbt->tb_num; i++) {
+            if (ptbt->tb[i].max) {
+                /* all token bucket must be unset
+                 * before turning off the throttle */
+                return -EINVAL;
+            }
+        }
+    }
+    ptbt->tick_interval = msecs_to_jiffies(interval);
+    ptbt->tbt_timeout = timeout;
+
+    if (ptbt->tick_interval && !last_interval) {
+        schedule_token_bucket_throttle_tick(ptbt, ptbt->tick_interval);
+    }
+
+    return 0;
+}
+
+static int set_tb_params(struct token_bucket_throttle* ptbt, int
tb_idx, char* param_list)
+{
+    char* options = strstrip(param_list);
+    char* val = NULL;
+    int res = 0;
+    unsigned long throughput = 0, burst = 0;
+
+    val = strsep(&options, ",");
+    if (!val)
+        return -EINVAL;
+
+    res = kstrtol(val, 0, &throughput);
+    if (res)
+        return res;
+
+    val = strsep(&options, ",");
+    if (!val)
+        return -EINVAL;
+
+    res = kstrtol(val, 0, &burst);
+    if (res)
+        return res;
+
+    if (!(throughput && burst) && (throughput || burst)) {
+        /* either both or none of throughput and burst are set*/
+        return -EINVAL;
+    }
+    if (throughput && !ptbt->tick_interval) {
+        /* all token bucket must be unset
+         * before turning off the throttle */
+        return -EINVAL;
+    }
+    ptbt->tb[tb_idx].target_throughput = throughput;
+    ptbt->tb[tb_idx].max = burst;
+
+    return 0;
+}
+
+static ssize_t cephfscg_set_throttle_params(struct kernfs_open_file *of,
+        char *buf, size_t nbytes, loff_t off)
+{
+    const char *throttle_name;
+    int ret = 0;
+    struct cephfscg* cephfscg_p =
+        container_of(seq_css(of->seq_file), struct cephfscg, css);
+
+    throttle_name = of->kn->name;
+    if (!strcmp(throttle_name, "cephfs.meta_ops")) {
+        ret = set_throttle_params(&cephfscg_p->meta_ops_throttle, buf);
+    } else if (!strcmp(throttle_name, "cephfs.data_ops")) {
+        ret = set_throttle_params(&cephfscg_p->data_ops_throttle, buf);
+    } else if (!strcmp(throttle_name, "cephfs.meta_ops.iops")) {
+        ret = set_tb_params(&cephfscg_p->meta_ops_throttle,
META_OPS_IOPS_IDX, buf);
+    } else if (!strcmp(throttle_name, "cephfs.data_ops.iops")) {
+        ret = set_tb_params(&cephfscg_p->data_ops_throttle,
DATA_OPS_IOPS_IDX, buf);
+    } else if (!strcmp(throttle_name, "cephfs.data_ops.band")) {
+        ret = set_tb_params(&cephfscg_p->data_ops_throttle,
DATA_OPS_BAND_IDX, buf);
+    }
+
+    return ret ?: nbytes;
+}
+
+static int cephfscg_throttle_params_read(struct seq_file *sf, void *v)
+{
+    const char *throttle_name;
+    struct cephfscg* cephfscg_p =
+        container_of(seq_css(sf), struct cephfscg, css);
+
+    throttle_name = ((struct kernfs_open_file*)sf->private)->kn->name;
+    if (!strcmp(throttle_name, "cephfs.meta_ops")) {
+        seq_printf(sf, "%llu,%lu\n",
+                cephfscg_p->meta_ops_throttle.tick_interval,
+                cephfscg_p->meta_ops_throttle.tbt_timeout);
+    } else if (!strcmp(throttle_name, "cephfs.data_ops")) {
+        seq_printf(sf, "%llu,%lu\n",
+                cephfscg_p->data_ops_throttle.tick_interval,
+                cephfscg_p->data_ops_throttle.tbt_timeout);
+    } else if (!strcmp(throttle_name, "cephfs.data_ops.iops")) {
+        seq_printf(sf, "%llu,%llu\n",
+
cephfscg_p->data_ops_throttle.tb[DATA_OPS_IOPS_IDX].target_throughput,
+                cephfscg_p->data_ops_throttle.tb[DATA_OPS_IOPS_IDX].max);
+    } else if (!strcmp(throttle_name, "cephfs.data_ops.band")) {
+        seq_printf(sf, "%llu,%llu\n",
+
cephfscg_p->data_ops_throttle.tb[DATA_OPS_BAND_IDX].target_throughput,
+                cephfscg_p->data_ops_throttle.tb[DATA_OPS_BAND_IDX].max);
+    } else if (!strcmp(throttle_name, "cephfs.meta_ops.iops")) {
+        seq_printf(sf, "%llu,%llu\n",
+
cephfscg_p->meta_ops_throttle.tb[META_OPS_IOPS_IDX].target_throughput,
+                cephfscg_p->meta_ops_throttle.tb[META_OPS_IOPS_IDX].max);
+    }
+
+    return 0;
+}
+
+static struct cftype cephfscg_files[] = {
+    {
+        .name = "meta_ops.iops",
+        .write = cephfscg_set_throttle_params,
+        .seq_show = cephfscg_throttle_params_read,
+    },
+    {
+        .name = "meta_ops",
+        .write = cephfscg_set_throttle_params,
+        .seq_show = cephfscg_throttle_params_read,
+    },
+    {
+        .name = "data_ops.iops",
+        .write = cephfscg_set_throttle_params,
+        .seq_show = cephfscg_throttle_params_read,
+    },
+    {
+        .name = "data_ops.band",
+        .write = cephfscg_set_throttle_params,
+        .seq_show = cephfscg_throttle_params_read,
+    },
+    {
+        .name = "data_ops",
+        .write = cephfscg_set_throttle_params,
+        .seq_show = cephfscg_throttle_params_read,
+    },
+    { }
+};
+
+static struct cgroup_subsys_state *
+cephfscg_css_alloc(struct cgroup_subsys_state *parent_css) {
+
+    struct cephfscg* cephfscg_p = NULL;
+    struct cgroup_subsys_state *ret = NULL;
+    int r = 0;
+
+    if (!parent_css) {
+        cephfscg_p = &cephfscg_root;
+    } else {
+        cephfscg_p = kzalloc(sizeof(*cephfscg_p), GFP_KERNEL);
+        if (!cephfscg_p) {
+            ret = ERR_PTR(-ENOMEM);
+            goto err;
+        }
+    }
+
+    spin_lock_init(&cephfscg_p->lock);
+
+    r = token_bucket_throttle_init(&cephfscg_p->meta_ops_throttle, 1);
+    if (r) {
+        ret = ERR_PTR(r);
+        goto err;
+    }
+
+    r = token_bucket_throttle_init(&cephfscg_p->data_ops_throttle, 2);
+    if (r) {
+        ret = ERR_PTR(r);
+        goto err;
+    }
+
+    return &cephfscg_p->css;
+err:
+    return ret;
+}
+
+static void cephfscg_css_free(struct cgroup_subsys_state *css) {
+    struct cephfscg* cephfscg_p =
+        css ? container_of(css, struct cephfscg, css) : NULL;
+
+    cancel_delayed_work_sync(&cephfscg_p->meta_ops_throttle.tick_work);
+    cancel_delayed_work_sync(&cephfscg_p->data_ops_throttle.tick_work);
+
+    kfree(cephfscg_p->meta_ops_throttle.tb);
+    kfree(cephfscg_p->data_ops_throttle.tb);
+
+    kfree(cephfscg_p);
+}
+
+struct cgroup_subsys cephfs_cgrp_subsys = {
+    .css_alloc = cephfscg_css_alloc,
+    .css_free = cephfscg_css_free,
+    .dfl_cftypes = cephfscg_files,
+    .legacy_cftypes = cephfscg_files,
+};
+EXPORT_SYMBOL_GPL(cephfs_cgrp_subsys);
--
2.20.1
