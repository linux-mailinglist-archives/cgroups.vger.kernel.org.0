Return-Path: <cgroups+bounces-17534-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XPQ9BOSdS2pJXAEAu9opvQ
	(envelope-from <cgroups+bounces-17534-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 14:21:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF7710750
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 14:21:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BDWTD7tY;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17534-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17534-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DC283052874
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 12:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3288B42467B;
	Mon,  6 Jul 2026 12:07:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2B424665
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 12:07:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339656; cv=none; b=ijol75APqLm7uYuaD8o8Rqe35yBFQdtrnpeIBRmfZk1tWVWlCNLHocBbiIBtoFf/7OIBvnxQAkWlvQ1+Xp98ArfRMns5TMn/nWAklfrVDFEoY/IVsFY5+YNG6B7FiLDdfl1IAVkjWXfvt2bKArfzURFX0tThaDmlbjgqf5/eBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339656; c=relaxed/simple;
	bh=b0uhyHgcitgdJu8EHxYVU9yrFQx/k/3SAU8gunPREJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nm0bEOwsSbuPhHBXRYUIuKpLa1M3LU4VXNVoRds4VOz2POgjYKV2u9nlUiJ8XNuEMwjTHxQCxBAtXH2CfycHi9WQuAc+xG1VB9gWgJrJ1AdMZ/etcGcN53oG95kMFZUAFVNSlDiSrpQqb69PALuGatLyP3QD/qzHavzX+D1z9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDWTD7tY; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783339653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y+J4mspfj+iaS4h6p2ZHVGaApKsDVI/YeTxxCK1gsE=;
	b=BDWTD7tYQsH4NuNQKACMFqPFZfz5UL7eE0kc0SAOUAfDuze4Pd+/lwyWKWvSFWVbYsMm9+
	Nxiu1b8nPWT+a0oJXRp7kTdFfjK6P2LfNWnjLgvtc92KgvRDSv4lWqaaG7FhtKmwgLVWEH
	QrY9AmIdtgJZbdYpRziaoBzrM9klXTU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-CzEl7AvrOSqwFywmpm4LnA-1; Mon,
 06 Jul 2026 08:07:32 -0400
X-MC-Unique: CzEl7AvrOSqwFywmpm4LnA-1
X-Mimecast-MFC-AGG-ID: CzEl7AvrOSqwFywmpm4LnA_1783339649
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB7561920C21;
	Mon,  6 Jul 2026 12:06:59 +0000 (UTC)
Received: from [192.168.1.153] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A49F01800591;
	Mon,  6 Jul 2026 12:06:57 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 06 Jul 2026 14:06:40 +0200
Subject: [PATCH v5 1/4] cgroup: Add dmem_selftest module
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-kunit_cgroups-v5-1-6c42c8753468@redhat.com>
References: <20260706-kunit_cgroups-v5-0-6c42c8753468@redhat.com>
In-Reply-To: <20260706-kunit_cgroups-v5-0-6c42c8753468@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783339614; l=7478;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=b0uhyHgcitgdJu8EHxYVU9yrFQx/k/3SAU8gunPREJQ=;
 b=teQKe3rIscRwQNL1c2jBzLnEg6vqgzsctGOFPFrC/rT4qAzwXJMt81+aOr4wGnLl0TvN3l/y+
 0IF1ocDEHScBZ/1eGSAfS3iDX50hAccriRKYAKpamxdXBvOMAY+Qldh
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17534-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:aesteve@redhat.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BAF7710750

Currently, dmem charging is driver-driven through direct
calls to dmem_cgroup_try_charge(), so cgroup selftests
do not have a generic way to trigger charge and uncharge
paths from userspace.

This limits any selftest coverage to configuration/readout
checks unless a specific driver exposing charge hooks is
present in the test environment.

Add kernel/cgroup/dmem_selftest.c as a helper module
(CONFIG_DMEM_SELFTEST) that registers a synthetic dmem region
(dmem_selftest) and exposes debugfs control files:
/sys/kernel/debug/dmem_selftest/charge
/sys/kernel/debug/dmem_selftest/uncharge

Writing a size to charge triggers dmem_cgroup_try_charge() for
the calling task's cgroup (the module calls kstrtou64()).
Writing to uncharge releases the outstanding charge via
dmem_cgroup_uncharge(). Only a single outstanding charge
is supported.

This provides a deterministic, driver-independent mechanism
for exercising dmem accounting paths in selftests.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 init/Kconfig                  |  12 +++
 kernel/cgroup/Makefile        |   1 +
 kernel/cgroup/dmem_selftest.c | 198 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 5230d4879b1c8..6fab65d6b44ea 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1267,6 +1267,18 @@ config CGROUP_DMEM
 	  As an example, it allows you to restrict VRAM usage for applications
 	  in the DRM subsystem.
 
+config DMEM_SELFTEST
+	tristate "dmem cgroup selftest helper module"
+	depends on CGROUP_DMEM && DEBUG_FS
+	default n
+	help
+	  Builds a small loadable module that registers a dmem region named
+	  "dmem_selftest" and exposes debugfs files under
+	  /sys/kernel/debug/dmem_selftest/ so kselftests can trigger
+	  dmem charge/uncharge operations from userspace.
+
+	  Say N unless you run dmem selftests or develop the dmem controller.
+
 config CGROUP_FREEZER
 	bool "Freezer controller"
 	help
diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index ede31601a363a..febc36e60f9f9 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_CPUSETS_V1) += cpuset-v1.o
 obj-$(CONFIG_CGROUP_MISC) += misc.o
 obj-$(CONFIG_CGROUP_DMEM) += dmem.o
+obj-$(CONFIG_DMEM_SELFTEST) += dmem_selftest.o
 obj-$(CONFIG_CGROUP_DEBUG) += debug.o
diff --git a/kernel/cgroup/dmem_selftest.c b/kernel/cgroup/dmem_selftest.c
new file mode 100644
index 0000000000000..625ab2d73923b
--- /dev/null
+++ b/kernel/cgroup/dmem_selftest.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kselftest helper for the dmem cgroup controller.
+ *
+ * Registers a dmem region and debugfs files so tests can trigger charges
+ * from the calling task's cgroup.
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cgroup_dmem.h>
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include "../../tools/testing/selftests/kselftest_module.h"
+
+#define DM_SELFTEST_REGION_NAME	"dmem_selftest"
+#define DM_SELFTEST_REGION_SIZE	(256ULL * 1024 * 1024)
+
+KSTM_MODULE_GLOBALS();
+
+static struct dmem_cgroup_region *selftest_region;
+static struct dentry *dbg_dir;
+
+static struct dmem_cgroup_pool_state *charged_pool;
+static u64 charged_size;
+static DEFINE_MUTEX(charge_lock);
+
+static ssize_t dmem_selftest_charge_write(struct file *file, const char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct dmem_cgroup_pool_state *pool = NULL, *limit = NULL;
+	u64 size;
+	char buf[32];
+	int ret;
+
+	if (!selftest_region)
+		return -ENODEV;
+
+	if (count == 0 || count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+	buf[count] = '\0';
+
+	ret = kstrtou64(strim(buf), 0, &size);
+	if (ret)
+		return ret;
+	if (!size || size > DM_SELFTEST_REGION_SIZE)
+		return -EINVAL;
+
+	mutex_lock(&charge_lock);
+	if (charged_pool) {
+		mutex_unlock(&charge_lock);
+		return -EBUSY;
+	}
+
+	ret = dmem_cgroup_try_charge(selftest_region, size, &pool, &limit);
+	if (ret == -EAGAIN && limit)
+		dmem_cgroup_pool_state_put(limit);
+	if (ret) {
+		mutex_unlock(&charge_lock);
+		return ret;
+	}
+
+	charged_pool = pool;
+	charged_size = size;
+	mutex_unlock(&charge_lock);
+
+	return count;
+}
+
+static ssize_t dmem_selftest_uncharge_write(struct file *file, const char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	if (!count)
+		return -EINVAL;
+
+	mutex_lock(&charge_lock);
+	if (!charged_pool) {
+		mutex_unlock(&charge_lock);
+		return -EINVAL;
+	}
+
+	dmem_cgroup_uncharge(charged_pool, charged_size);
+	charged_pool = NULL;
+	charged_size = 0;
+	mutex_unlock(&charge_lock);
+
+	return count;
+}
+
+static const struct file_operations dmem_selftest_charge_fops = {
+	.write = dmem_selftest_charge_write,
+	.llseek = noop_llseek,
+};
+
+static const struct file_operations dmem_selftest_uncharge_fops = {
+	.write = dmem_selftest_uncharge_write,
+	.llseek = noop_llseek,
+};
+
+static int __init dmem_selftest_register(void)
+{
+	int ret = 0;
+
+	selftest_region = dmem_cgroup_register_region(
+		DM_SELFTEST_REGION_SIZE, DM_SELFTEST_REGION_NAME);
+	if (IS_ERR(selftest_region))
+		return PTR_ERR(selftest_region);
+	if (!selftest_region)
+		return -EINVAL;
+
+	dbg_dir = debugfs_create_dir("dmem_selftest", NULL);
+	if (IS_ERR(dbg_dir)) {
+		ret = PTR_ERR(dbg_dir);
+		goto dbgfs_error;
+	}
+
+	debugfs_create_file("charge", 0200, dbg_dir, NULL, &dmem_selftest_charge_fops);
+	debugfs_create_file("uncharge", 0200, dbg_dir, NULL, &dmem_selftest_uncharge_fops);
+
+	pr_info("region '%s' registered; debugfs at dmem_selftest/{charge,uncharge}\n",
+		DM_SELFTEST_REGION_NAME);
+	return ret;
+
+dbgfs_error:
+	dmem_cgroup_unregister_region(selftest_region);
+	dbg_dir = NULL;
+	selftest_region = NULL;
+	return ret;
+}
+
+static void dmem_selftest_remove(void)
+{
+	debugfs_remove_recursive(dbg_dir);
+	dbg_dir = NULL;
+
+	if (selftest_region) {
+		dmem_cgroup_unregister_region(selftest_region);
+		selftest_region = NULL;
+	}
+
+	mutex_lock(&charge_lock);
+	if (charged_pool) {
+		dmem_cgroup_uncharge(charged_pool, charged_size);
+		charged_pool = NULL;
+	}
+	mutex_unlock(&charge_lock);
+}
+
+static void __init selftest(void)
+{
+	KSTM_CHECK_ZERO(!selftest_region);
+	KSTM_CHECK_ZERO(IS_ERR_OR_NULL(dbg_dir));
+}
+
+static int __init dmem_selftest_init(void)
+{
+	int report_rc;
+	int err;
+
+	err = dmem_selftest_register();
+	if (err)
+		return err;
+
+	pr_info("loaded.\n");
+	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
+	selftest();
+	report_rc = kstm_report(total_tests, failed_tests, skipped_tests);
+	if (report_rc) {
+		dmem_selftest_remove();
+		return report_rc;
+	}
+
+	return 0;
+}
+
+static void __exit dmem_selftest_exit(void)
+{
+	pr_info("unloaded.\n");
+	dmem_selftest_remove();
+}
+
+module_init(dmem_selftest_init);
+module_exit(dmem_selftest_exit);
+
+MODULE_AUTHOR("Albert Esteve <aesteve@redhat.com>");
+MODULE_DESCRIPTION("Kselftest helper for cgroup dmem controller");
+MODULE_LICENSE("GPL");

-- 
2.54.0


