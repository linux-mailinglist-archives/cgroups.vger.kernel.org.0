Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9045181
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 03:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfFNB5F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 21:57:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36407 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfFNB5D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 21:57:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so579380pgi.3;
        Thu, 13 Jun 2019 18:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A05mWHOmfsigInNkDKwkywVwUp0nsKQ4hFNQifWjRGs=;
        b=Fp/d2yeBEsjvCMFyJSvq47R90hp6mXLlP7v5lpe4Jev3TLciOEZY4L+bM2xACJTFYI
         cFhkuNuxEV0k89V6SvKKNLQwcrsYna7omyvO1dXzVF+4g0kUW/lN6sLaaxeEnn8730Mb
         Wx+w8lzQ93K/rTMm7cqZCM4wDNecek7H6Uqp8nUkGI1c2Dfjpj+YWaHfxiUHEBZnQqkv
         o/dSWmA4lg+KVxyN7njSjjBb4g0HhgS9rCgXvj6V1p8rXNj8ybt5Q//gYYyDonSUwSht
         rE+FsEz6vtEZouB0OCpnO7OWua/NmUAGxszx3bcu7nNf3cRA7AiesVJd4/ATQl033zuL
         JyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=A05mWHOmfsigInNkDKwkywVwUp0nsKQ4hFNQifWjRGs=;
        b=CJ3J2NzSa56q8NOn5ijBb8JM5mNcm9TYQse7paSJPrtp6+YJzgt08gkt1jXQPxMa4B
         GMKthhpJehu1FA49kZRd9DDPUsuL9Zo38GoThbwaZdfRPbKN2HxFykjCNjJQAiYP/Dxf
         c16ruld6oedZL3EFHxsClmvLt5xF1doVRsq5q/2TTvkkV7BcFagSKxhCjfLTTfOcezvG
         qDpYGqkXoirei4pvQ/EynJVRxhhNEkOlvI1EE2jFdOT5sEYhbSiZMOlwYATt+X8vh1KF
         T2U33ody29G4uqD/dT42BGz1N2t8bcm5VGlKBuedGxSjD+w1SYjVXtJ91Q6nOZyeHb1w
         adEg==
X-Gm-Message-State: APjAAAUFgGeDTNSUYz3CnrEZqdQJcmrsCTF5BdXB4yDejsuulaQQaS76
        S7eh3Nrkhhx5m368hG+Skdo=
X-Google-Smtp-Source: APXvYqzjy/M4BLdQoAnGfo3N91F/oU6ASbRn7nKN8uL75E6wFqtcLQ5j8CPeImpyhgkl6PLqY+t2SA==
X-Received: by 2002:a63:5b5c:: with SMTP id l28mr32671485pgm.158.1560477421468;
        Thu, 13 Jun 2019 18:57:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id m24sm1002362pgh.75.2019.06.13.18.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 18:57:01 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/10] blkcg: implement BPF_PROG_TYPE_IO_COST
Date:   Thu, 13 Jun 2019 18:56:20 -0700
Message-Id: <20190614015620.1587672-11-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614015620.1587672-1-tj@kernel.org>
References: <20190614015620.1587672-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, blkcg implements one builtin IO cost model - lienar.  To
allow customization and experimentation, allow a bpf program to
override IO cost model.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/Kconfig                                 |   3 +
 block/blk-ioweight.c                          | 148 +++++++++++++++++-
 block/blk.h                                   |   8 +
 block/ioctl.c                                 |   4 +
 include/linux/bpf_types.h                     |   3 +
 include/uapi/linux/bpf.h                      |  11 ++
 include/uapi/linux/fs.h                       |   2 +
 tools/bpf/bpftool/feature.c                   |   3 +
 tools/bpf/bpftool/main.h                      |   1 +
 tools/include/uapi/linux/bpf.h                |  11 ++
 tools/include/uapi/linux/fs.h                 |   2 +
 tools/lib/bpf/libbpf.c                        |   2 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/iocost_ctrl.c     |  43 +++++
 .../selftests/bpf/progs/iocost_linear_prog.c  |  52 ++++++
 16 files changed, 287 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/iocost_ctrl.c
 create mode 100644 tools/testing/selftests/bpf/progs/iocost_linear_prog.c

diff --git a/block/Kconfig b/block/Kconfig
index 15b3de28a264..2882fdd573ca 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -204,4 +204,7 @@ config BLK_MQ_RDMA
 config BLK_PM
 	def_bool BLOCK && PM
 
+config BLK_BPF_IO_COST
+	def_bool BLK_CGROUP_IOWEIGHT && BPF_SYSCALL
+
 source "block/Kconfig.iosched"
diff --git a/block/blk-ioweight.c b/block/blk-ioweight.c
index 3d9fc1a631be..de4fc57bb77c 100644
--- a/block/blk-ioweight.c
+++ b/block/blk-ioweight.c
@@ -43,6 +43,10 @@
  * parameters can be configured from userspace via
  * /sys/block/DEV/queue/io_cost_model.
  *
+ * For experimentations and refinements, the IO model can also be replaced
+ * by a IO_COST bpf program.  Take a look at progs/iocost_linear_prog.c and
+ * iocost_ctrl.c under tools/testing/selftests/bpf for details on how-to.
+ *
  * 2. Control Strategy
  *
  * The device virtual time (vtime) is used as the primary control metric.
@@ -176,6 +180,7 @@
 #include <linux/parser.h>
 #include <linux/sched/signal.h>
 #include <linux/blk-cgroup.h>
+#include <linux/filter.h>
 #include "blk-rq-qos.h"
 #include "blk-stat.h"
 #include "blk-wbt.h"
@@ -387,6 +392,10 @@ struct iow {
 	bool				enabled;
 
 	struct iow_params		params;
+#ifdef CONFIG_BPF_SYSCALL
+	/* if non-NULL, bpf cost model is being used */
+	struct bpf_prog __rcu		*cost_prog;
+#endif
 	u32				period_us;
 	u32				margin_us;
 	u64				vrate_min;
@@ -1565,6 +1574,45 @@ static void iow_timer_fn(struct timer_list *timer)
 	spin_unlock_irq(&iow->lock);
 }
 
+#ifdef CONFIG_BLK_BPF_IO_COST
+static bool calc_vtime_cost_bpf(struct bio *bio, struct iow_gq *iowg,
+				bool is_merge, u64 *costp)
+{
+	struct iow *iow = iowg->iow;
+	struct bpf_prog *prog;
+	bool ret = false;
+
+	if (!iow->cost_prog)
+		return ret;
+
+	rcu_read_lock();
+	prog = rcu_dereference(iow->cost_prog);
+	if (prog) {
+		struct bpf_io_cost ctx = {
+			.cost = 0,
+			.opf = bio->bi_opf,
+			.nr_sectors = bio_sectors(bio),
+			.sector = bio->bi_iter.bi_sector,
+			.last_sector = iowg->cursor,
+			.is_merge = is_merge,
+		};
+
+		BPF_PROG_RUN(prog, &ctx);
+		*costp = ctx.cost;
+		ret = true;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+#else
+static bool calc_vtime_cost_bpf(struct bio *bio, struct iow_gq *iowg,
+				bool is_merge, u64 *costp)
+{
+	return false;
+}
+#endif
+
 static void calc_vtime_cost_builtin(struct bio *bio, struct iow_gq *iowg,
 				    bool is_merge, u64 *costp)
 {
@@ -1610,6 +1658,9 @@ static u64 calc_vtime_cost(struct bio *bio, struct iow_gq *iowg, bool is_merge)
 {
 	u64 cost;
 
+	if (calc_vtime_cost_bpf(bio, iowg, is_merge, &cost))
+		return cost;
+
 	calc_vtime_cost_builtin(bio, iowg, is_merge, &cost);
 	return cost;
 }
@@ -2214,14 +2265,17 @@ static u64 iow_cost_model_prfill(struct seq_file *sf,
 	if (!dname)
 		return 0;
 
-	seq_printf(sf, "%s ctrl=%s model=linear "
-		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
-		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
-		   dname, iow->user_cost_model ? "user" : "auto",
-		   u[I_LCOEF_RBPS],
-		   u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
-		   u[I_LCOEF_WBPS],
-		   u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
+	if (iow->cost_prog)
+		seq_printf(sf, "%s ctrl=bpf\n", dname);
+	else
+		seq_printf(sf, "%s ctrl=%s model=linear "
+			   "rbps=%llu rseqiops=%llu rrandiops=%llu "
+			   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
+			   dname, iow->user_cost_model ? "user" : "auto",
+			   u[I_LCOEF_RBPS],
+			   u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
+			   u[I_LCOEF_WBPS],
+			   u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
 	return 0;
 }
 
@@ -2363,6 +2417,84 @@ static struct blkcg_policy blkcg_policy_iow = {
 	.pd_free_fn	= iow_pd_free,
 };
 
+#ifdef CONFIG_BLK_BPF_IO_COST
+static bool io_cost_is_valid_access(int off, int size,
+				    enum bpf_access_type type,
+				    const struct bpf_prog *prog,
+				    struct bpf_insn_access_aux *info)
+{
+	if (off < 0 || off >= sizeof(struct bpf_io_cost) || off % size)
+		return false;
+
+	if (off != offsetof(struct bpf_io_cost, cost) && type != BPF_READ)
+		return false;
+
+	switch (off) {
+	case bpf_ctx_range(struct bpf_io_cost, opf):
+		bpf_ctx_record_field_size(info, sizeof(__u32));
+		return bpf_ctx_narrow_access_ok(off, size, sizeof(__u32));
+	case offsetof(struct bpf_io_cost, nr_sectors):
+		return size == sizeof(__u32);
+	case offsetof(struct bpf_io_cost, cost):
+	case offsetof(struct bpf_io_cost, sector):
+	case offsetof(struct bpf_io_cost, last_sector):
+		return size == sizeof(__u64);
+	case offsetof(struct bpf_io_cost, is_merge):
+		return size == sizeof(__u8);
+	}
+
+	return false;
+}
+
+const struct bpf_prog_ops io_cost_prog_ops = {
+};
+
+const struct bpf_verifier_ops io_cost_verifier_ops = {
+	.is_valid_access	= io_cost_is_valid_access,
+};
+
+int blk_bpf_io_cost_ioctl(struct block_device *bdev, unsigned cmd,
+			  char __user *arg)
+{
+	int prog_fd = (int)(long)arg;
+	struct bpf_prog *prog = NULL;
+	struct request_queue *q;
+	struct iow *iow;
+	int ret = 0;
+
+	q = bdev_get_queue(bdev);
+	if (!q)
+		return -ENXIO;
+	iow = q_to_iow(q);
+
+	if (prog_fd >= 0) {
+		prog = bpf_prog_get_type(prog_fd, BPF_PROG_TYPE_IO_COST);
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+
+		spin_lock_irq(&iow->lock);
+		if (!iow->cost_prog) {
+			rcu_assign_pointer(iow->cost_prog, prog);
+			prog = NULL;
+		} else {
+			ret = -EEXIST;
+		}
+		spin_unlock_irq(&iow->lock);
+	} else {
+		spin_lock_irq(&iow->lock);
+		if (iow->cost_prog) {
+			prog = iow->cost_prog;
+			rcu_assign_pointer(iow->cost_prog, NULL);
+		}
+		spin_unlock_irq(&iow->lock);
+	}
+
+	if (prog)
+		bpf_prog_put(prog);
+	return ret;
+}
+#endif /* CONFIG_BLK_BPF_IO_COST */
+
 static int __init iow_init(void)
 {
 	return blkcg_policy_register(&blkcg_policy_iow);
diff --git a/block/blk.h b/block/blk.h
index 7814aa207153..98fa2283534f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -317,6 +317,14 @@ static inline void blk_queue_bounce(struct request_queue *q, struct bio **bio)
 }
 #endif /* CONFIG_BOUNCE */
 
+#ifdef CONFIG_BLK_BPF_IO_COST
+int blk_bpf_io_cost_ioctl(struct block_device *bdev, unsigned cmd,
+			  char __user *arg);
+#else
+static inline int blk_bpf_io_cost_ioctl(struct block_device *bdev, unsigned cmd,
+					char __user *arg) { return -ENOTTY; }
+#endif
+
 #ifdef CONFIG_BLK_CGROUP_IOLATENCY
 extern int blk_iolatency_init(struct request_queue *q);
 #else
diff --git a/block/ioctl.c b/block/ioctl.c
index 15a0eb80ada9..89d48d7dea0f 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -11,6 +11,8 @@
 #include <linux/pr.h>
 #include <linux/uaccess.h>
 
+#include "blk.h"
+
 static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user *arg)
 {
 	struct block_device *bdevp;
@@ -590,6 +592,8 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case BLKTRACESETUP:
 	case BLKTRACETEARDOWN:
 		return blk_trace_ioctl(bdev, cmd, argp);
+	case BLKBPFIOCOST:
+		return blk_bpf_io_cost_ioctl(bdev, cmd, argp);
 	case IOC_PR_REGISTER:
 		return blkdev_pr_register(bdev, argp);
 	case IOC_PR_RESERVE:
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 5a9975678d6f..fb0a91c655c2 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -37,6 +37,9 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LIRC_MODE2, lirc_mode2)
 #ifdef CONFIG_INET
 BPF_PROG_TYPE(BPF_PROG_TYPE_SK_REUSEPORT, sk_reuseport)
 #endif
+#ifdef CONFIG_BLK_BPF_IO_COST
+BPF_PROG_TYPE(BPF_PROG_TYPE_IO_COST, io_cost)
+#endif
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 63e0cf66f01a..1664ef4ccc79 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -170,6 +170,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
+	BPF_PROG_TYPE_IO_COST,
 };
 
 enum bpf_attach_type {
@@ -3472,6 +3473,16 @@ struct bpf_flow_keys {
 	};
 };
 
+struct bpf_io_cost {
+	__u64	cost;				/* output */
+
+	__u32	opf;
+	__u32	nr_sectors;
+	__u64	sector;
+	__u64	last_sector;
+	__u8	is_merge;
+};
+
 struct bpf_func_info {
 	__u32	insn_off;
 	__u32	type_id;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 59c71fa8c553..ddf3c80c9407 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -181,6 +181,8 @@ struct fsxattr {
 #define BLKSECDISCARD _IO(0x12,125)
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
+#define BLKBPFIOCOST _IO(0x12, 128)
+
 /*
  * A jump here: 130-131 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index d672d9086fff..beeac8ac48f3 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -383,6 +383,9 @@ static void probe_kernel_image_config(void)
 		/* bpftilter module with "user mode helper" */
 		"CONFIG_BPFILTER_UMH",
 
+		/* Block */
+		"CONFIG_BLK_IO_COST",
+
 		/* test_bpf module for BPF tests */
 		"CONFIG_TEST_BPF",
 	};
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 3d63feb7f852..298e53f35573 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -74,6 +74,7 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_SK_REUSEPORT]		= "sk_reuseport",
 	[BPF_PROG_TYPE_FLOW_DISSECTOR]		= "flow_dissector",
 	[BPF_PROG_TYPE_CGROUP_SYSCTL]		= "cgroup_sysctl",
+	[BPF_PROG_TYPE_IO_COST]			= "io_cost",
 };
 
 extern const char * const map_type_name[];
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 63e0cf66f01a..1664ef4ccc79 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -170,6 +170,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
+	BPF_PROG_TYPE_IO_COST,
 };
 
 enum bpf_attach_type {
@@ -3472,6 +3473,16 @@ struct bpf_flow_keys {
 	};
 };
 
+struct bpf_io_cost {
+	__u64	cost;				/* output */
+
+	__u32	opf;
+	__u32	nr_sectors;
+	__u64	sector;
+	__u64	last_sector;
+	__u8	is_merge;
+};
+
 struct bpf_func_info {
 	__u32	insn_off;
 	__u32	type_id;
diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 59c71fa8c553..ddf3c80c9407 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -181,6 +181,8 @@ struct fsxattr {
 #define BLKSECDISCARD _IO(0x12,125)
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
+#define BLKBPFIOCOST _IO(0x12, 128)
+
 /*
  * A jump here: 130-131 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 197b574406b3..6dbee409f3b0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2266,6 +2266,7 @@ static bool bpf_prog_type__needs_kver(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_IO_COST:
 		return false;
 	case BPF_PROG_TYPE_KPROBE:
 	default:
@@ -3168,6 +3169,7 @@ static const struct {
 	BPF_PROG_SEC("lwt_out",			BPF_PROG_TYPE_LWT_OUT),
 	BPF_PROG_SEC("lwt_xmit",		BPF_PROG_TYPE_LWT_XMIT),
 	BPF_PROG_SEC("lwt_seg6local",		BPF_PROG_TYPE_LWT_SEG6LOCAL),
+	BPF_PROG_SEC("io_cost",			BPF_PROG_TYPE_IO_COST),
 	BPF_APROG_SEC("cgroup_skb/ingress",	BPF_PROG_TYPE_CGROUP_SKB,
 						BPF_CGROUP_INET_INGRESS),
 	BPF_APROG_SEC("cgroup_skb/egress",	BPF_PROG_TYPE_CGROUP_SKB,
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5e2aa83f637a..024831756151 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -101,6 +101,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_IO_COST:
 	default:
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 66f2dca1dee1..c28f308c9575 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -23,7 +23,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
 	test_socket_cookie test_cgroup_storage test_select_reuseport test_section_names \
-	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl
+	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl iocost_ctrl
 
 BPF_OBJ_FILES = $(patsubst %.c,%.o, $(notdir $(wildcard progs/*.c)))
 TEST_GEN_FILES = $(BPF_OBJ_FILES)
diff --git a/tools/testing/selftests/bpf/iocost_ctrl.c b/tools/testing/selftests/bpf/iocost_ctrl.c
new file mode 100644
index 000000000000..d9d3eb70d0ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/iocost_ctrl.c
@@ -0,0 +1,43 @@
+#include <stdio.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <fcntl.h>
+
+#include <linux/bpf.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include <linux/fs.h>
+
+int main(int argc, char **argv)
+{
+	struct bpf_object *obj;
+	int dev_fd, prog_fd = -1;
+
+	if (argc < 2) {
+		fprintf(stderr, "Usage: iocost-attach BLKDEV [BPF_PROG]");
+		return 1;
+	}
+
+	dev_fd = open(argv[1], O_RDONLY);
+	if (dev_fd < 0) {
+		perror("open(BLKDEV)");
+		return 1;
+	}
+
+	if (argc > 2) {
+		if (bpf_prog_load(argv[2], BPF_PROG_TYPE_IO_COST,
+				  &obj, &prog_fd)) {
+			perror("bpf_prog_load(BPF_PROG)");
+			return 1;
+		}
+	}
+
+	if (ioctl(dev_fd, BLKBPFIOCOST, (long)prog_fd)) {
+		perror("ioctl(BLKBPFIOCOST)");
+		return 1;
+	}
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/iocost_linear_prog.c b/tools/testing/selftests/bpf/progs/iocost_linear_prog.c
new file mode 100644
index 000000000000..4e202c595658
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iocost_linear_prog.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/version.h>
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
+
+#define REQ_OP_READ	0
+#define REQ_OP_WRITE	1
+#define REQ_OP_BITS	8
+#define REQ_OP_MASK	((1 << REQ_OP_BITS) - 1)
+
+#define LCOEF_RSEQIO	14663889
+#define LCOEF_RRANDIO	248752010
+#define LCOEF_RPAGE	28151808
+#define LCOEF_WSEQIO	32671670
+#define LCOEF_WRANDIO	63150006
+#define LCOEF_WPAGE	7323648
+
+#define RAND_IO_CUTOFF	10
+
+SEC("io_cost")
+int func(struct bpf_io_cost *ctx)
+{
+	int op;
+	__u64 seqio, randio, page;
+	__s64 delta;
+
+	switch (ctx->opf & REQ_OP_MASK) {
+	case REQ_OP_READ:
+		seqio = LCOEF_RSEQIO;
+		randio = LCOEF_RRANDIO;
+		page = LCOEF_RPAGE;
+		break;
+	case REQ_OP_WRITE:
+		seqio = LCOEF_WSEQIO;
+		randio = LCOEF_WRANDIO;
+		page = LCOEF_WPAGE;
+		break;
+	default:
+		return 0;
+	}
+
+	delta = ctx->sector - ctx->last_sector;
+	if (delta >= -RAND_IO_CUTOFF && delta <= RAND_IO_CUTOFF)
+		ctx->cost += seqio;
+	else
+		ctx->cost += randio;
+	if (!ctx->is_merge)
+		ctx->cost += page * (ctx->nr_sectors >> 3);
+
+	return 0;
+}
-- 
2.17.1

