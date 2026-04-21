Return-Path: <cgroups+bounces-15421-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC3tBq4m52nV4QEAu9opvQ
	(envelope-from <cgroups+bounces-15421-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 09:26:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B6769437874
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 09:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 247D6304578F
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 07:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957B93A7827;
	Tue, 21 Apr 2026 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCqU+6lL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603903A5E8C
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 07:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756034; cv=none; b=hFoVPQgZWD5UDqG9Nbej7arQzgZPfNdhD3p00z5pZkhgCcmbxDYnBmUZxksJbpnXPsrLEpNzaCzzbAIg0ymSJQKJ6z+GBLqz3Whc2fablM1z41nokvYnJuRstgKEcVqUm7b6k9tt6kuhf8Y16dYLFmmAwmi+E97QrmhiX9+6GhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756034; c=relaxed/simple;
	bh=1e1KhCvryqKFpVtz6TOWbsxuiJgrgIG91ZabQbycaMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L3pnbBemDyZCoHF5W1hVpMtxiSID2591JusGMcqa3uvu28qpIC1uXRplix8VKrwq4hup5XFSiD0AqoE5BsBgdIwlgR0RTzM3VWcX/EEkAj4BgzimhJvpJBIvEG+l92n5lw+R601nt+Pal1gQG5UsQliKeJnpFFofTw42T16Ac6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCqU+6lL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776756031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27dck25DEHrFITTKWwMw71w88rwhcYunZuau1b1GRVQ=;
	b=NCqU+6lLgvmyEFEQqnj9HwboiUm56SziTErAojIE44N7SYrL+90+inwcVmlF+2fbNylnSQ
	wauvGoT9DoZfSeMgUgupB8LB45Gryt03Ja8aMVTI5qjWlDV4/4MQAxJ6Zz9fV+CYMot7Pz
	B+qeL9j3ykk6nB3HaPSk0u+oBi8UmaM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-eX4DVp9RPju6fEGD8UXNoQ-1; Tue,
 21 Apr 2026 03:20:27 -0400
X-MC-Unique: eX4DVp9RPju6fEGD8UXNoQ-1
X-Mimecast-MFC-AGG-ID: eX4DVp9RPju6fEGD8UXNoQ_1776756026
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12834195608F;
	Tue, 21 Apr 2026 07:20:26 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C55BB195608E;
	Tue, 21 Apr 2026 07:20:23 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 21 Apr 2026 09:19:47 +0200
Subject: [PATCH v2 1/4] cgroup: Add dmem_selftest module
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-kunit_cgroups-v2-1-bb6675d8249c@redhat.com>
References: <20260421-kunit_cgroups-v2-0-bb6675d8249c@redhat.com>
In-Reply-To: <20260421-kunit_cgroups-v2-0-bb6675d8249c@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776756020; l=7444;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=1e1KhCvryqKFpVtz6TOWbsxuiJgrgIG91ZabQbycaMY=;
 b=nHPLJcVkLX+/AFkMfoEUWByCj9a4vzrG7kKugS/BIJf3/qzfgBWCnshUSSj5jo3WXfou4An/Y
 jGOOjLy6qWWDaB0TVY1H6LiSE6UIxHaSxPY8ads3HEfSD6CB4UC6Uj8
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15421-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6769437874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 0000000000000..cf7274eb02f71
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
2.52.0


