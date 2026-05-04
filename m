Return-Path: <cgroups+bounces-15587-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELeaDG5b+GnatQIAu9opvQ
	(envelope-from <cgroups+bounces-15587-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 10:40:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADFA4BA5CB
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 10:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9B2F300DD51
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2026 08:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23254342509;
	Mon,  4 May 2026 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rpyw90R2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AF2EA468
	for <cgroups@vger.kernel.org>; Mon,  4 May 2026 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883980; cv=none; b=nJM6ltqNFRZhLiD9M+BedNfLegF+As3sJ+9xCvm+TrqyFmJEng3DMSgwsZsUoOC36PE9jTVyYjNna8q3GKS8ZhXheJEsqmg8ccNY3xWeTK8d1sqo/Fy8SYaHonsvAE3KwOpOX+lKGc4qz8Fog85Nru9SsumXZBqSetgYQtVpNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883980; c=relaxed/simple;
	bh=pJd60wbLypgMU61U+DU70Fjl3v119u5fGZsjoBbN8Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swro66R8JkRLDN7LNPoTS8J/ShttEh8lKmJ2gbfhzyZPl++Gd6xTgXKszROAG2WPqN+b6J19sKCP/L44oUNi9JErl+QbOwCHhBE7xLQiDeK/bjLNsaAmKi1XKUsc0mVzsPpuj26CpsVzodp+OsxYAcKxpQhsXBMBflz8BU5Y9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rpyw90R2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777883978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkLS8kO2m4APQscuVIfZ1FfJanC+NFBqJUSsaAOTf70=;
	b=Rpyw90R2os1SH3G/DHxdLcc3bjBASAGLJaxtrEfrLqWGufLPxoPWto5aOHdLAb0hb6G1zG
	svr0mmWyyt6GuENBhqS/K8HlkKlg900EMz95VXX0qGOB3UjFHR1WGbRCZ8cRhZickY11U0
	EFobQZVgUdsx3tJ13Buq2IFQmCZUUZI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-R26usSUVNV227Ysf7rPXuA-1; Mon,
 04 May 2026 04:39:35 -0400
X-MC-Unique: R26usSUVNV227Ysf7rPXuA-1
X-Mimecast-MFC-AGG-ID: R26usSUVNV227Ysf7rPXuA_1777883974
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE0BC1800473;
	Mon,  4 May 2026 08:39:33 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E275A1800446;
	Mon,  4 May 2026 08:39:31 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 04 May 2026 10:39:23 +0200
Subject: [PATCH v3 1/4] cgroup: Add dmem_selftest module
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-kunit_cgroups-v3-1-4eac90b76f91@redhat.com>
References: <20260504-kunit_cgroups-v3-0-4eac90b76f91@redhat.com>
In-Reply-To: <20260504-kunit_cgroups-v3-0-4eac90b76f91@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777883968; l=7447;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=pJd60wbLypgMU61U+DU70Fjl3v119u5fGZsjoBbN8Mg=;
 b=eTvPmlMxXAJfqwea/pCZYkVz4JWQAc6SR1PvSExo/P2c/C/fsDgFvwuu39D/P91quu5THt3Zi
 C46eImAEO4ND1bE9BwGKe/aMlKp6ic5BG4qnry+1jqQAc0H+reFaVGX
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 8ADFA4BA5CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15587-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
 kernel/cgroup/dmem_selftest.c | 199 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 444ce811ea674..060ba8ca49333 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1238,6 +1238,18 @@ config CGROUP_DMEM
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
index 0000000000000..15520807e2dc8
--- /dev/null
+++ b/kernel/cgroup/dmem_selftest.c
@@ -0,0 +1,199 @@
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
+	if (!size)
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
+
+	dmem_selftest_remove();
+
+	mutex_lock(&charge_lock);
+	if (charged_pool) {
+		dmem_cgroup_uncharge(charged_pool, charged_size);
+		charged_pool = NULL;
+	}
+	mutex_unlock(&charge_lock);
+}
+
+module_init(dmem_selftest_init);
+module_exit(dmem_selftest_exit);
+
+MODULE_AUTHOR("Albert Esteve <aesteve@redhat.com>");
+MODULE_DESCRIPTION("Kselftest helper for cgroup dmem controller");
+MODULE_LICENSE("GPL");

-- 
2.53.0


