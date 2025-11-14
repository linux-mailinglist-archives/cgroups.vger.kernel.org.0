Return-Path: <cgroups+bounces-11957-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3896FC5E2F4
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 17:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C121D501AF0
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858933D6E6;
	Fri, 14 Nov 2025 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FAsvS4Xy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F233E344
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134539; cv=none; b=iWcsRM3YR3o00vBF7TCy1tofIrE0ivcLfxFo98cCqy7m3vNkpKmmXLrkVaPji2SdghNuRHk64NmS+nKJx/K8H0h3EAhQVFw7Cv/478VsVGeLSscnNa7JCblSnnoW+lCCw4OBaxBMtYVy0JmCCxuL6l1n1aADM4Z0jJK5jpFJXlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134539; c=relaxed/simple;
	bh=j0qsxl3uniKIqQftjyMY8DYAOdAo/FWnUDwzouYThaQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bLUjxz6L9zki81FFx1AEgCRZJVA4VOBNU6+zurl7I9Tv04Y1NaqRCTmyN3oNE+oVkDJcDQvQlCMZ4ea3meAgt4Es3T9UBL7L1XvSng/3zE5+HyNiK12NEopU0wcyHF++4faF9TgxxUZUi6tIW/6YmsBAfAO/8qrjNHnj9sxug80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FAsvS4Xy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-341988c720aso1842282a91.3
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 07:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763134537; x=1763739337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do1ulcbjwbox5pHRl0C2qYb8sHFbD2Rm8Vw+uifoI+o=;
        b=FAsvS4XyJcyJNZAuxXQhBPcH5N/7Z+GXTgiCQVQ9uh7APCXWaD9ixqA9GJbflsKAr8
         B7TL+2HwCEewn+oeahWAtkhB5mVdm1kDOHMyv+30ainnpDWi6e2hLgh6ZVMPnaMKkeaW
         of33afaZ5BdXDemJi9jzV6H0qFxJTqfIg/vkbYqIf2nehUiP1iIz5NgOKSwtKN0LmMH1
         xD4+/pVHrpnuJIZFhOqSn+k4F1RfiALWjg+VNNQ1+PPgqzMu+nA5exZbd9/y8p9xosPO
         OVKJ4fZKYqmyFEuGLh0/sNW4Wou7J5Jef9orO2VGSVeLxAFy4WDWVIr2mUdHXuaqlIOz
         33Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763134537; x=1763739337;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Do1ulcbjwbox5pHRl0C2qYb8sHFbD2Rm8Vw+uifoI+o=;
        b=KP/EPcEnt2XspNFcEQg4ojag1XvX0EF/eDtdR3ItdbiUyxBenSuHEyp+2k2JHd4KLx
         vhf/b6gg/uFyanZDYajP7JwThvbscRLe3cHjr4RBd5UyB8xHN0iT9xOLvPaUC86chwuW
         LA0YjCIjuBUY4Jbz4gh71sVUMp3mwhnbs20oZNe9UslHGInI2msEf2OIRl+Wy+oP7AQL
         kmRXd5vbRq0qNawT/jMOzGJB2bfPavzC5lIO+S5/EQ6agNHwqiYZylksJKNgKx/Ab0uq
         1lb+9/7zGg9oMfe/J7NHWmqWbF+QY/sTjKm/DtOhpuDXz+/TJnEqFByL8NnGYE9YzkqQ
         5bvA==
X-Forwarded-Encrypted: i=1; AJvYcCX0V7cyUaUsENRLcBVLGqb5rdAPrjEoQqvN4rCjn5NZTSQc/Ir/v0YTqqUO4YnvQjEBVHy9HfoJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxxbjWPS+LMVL6qsJoYccLvsJalAxxCi7+WtSNn9Cpd3U04m1mm
	tx48Qao12jsWUJNe3UFTHXR8nybSdoua0lUhDB8bEYEoaE74MPCpn28ZFR9oxxriL98=
X-Gm-Gg: ASbGncudCLD3ELWLa1ABXsKWOHskHcqVD7APptqML91nnop/XwYtTjV8ybjzEcbd3OY
	OgAHGgePx1SxtOsAni163AbkXabnesEby9QywzDEZhG0PyKWQjl9kYCjL8CvTubvQnp3GLmP7v6
	xwYVvovpE8lNIzrMcH1NUYPFS0/vE+Sf0rcoBH43Hkkn4FqHVvGrF1BbqqSR/4heiclcVKHnn3w
	KqC5Wy86L6gaCGBWKVaDYP7Aap53ippqbjPfQh2OTO+OSM4dwe5SJIma8jl4CKu2C49zkQpH4H9
	Na8hEeWe4hd5H/aKh/thniCTkWEzLvVuXFUEE/5+pDORIFHd0NE8NfFgF/ooLG/NpSNWRkYvqkh
	dW164kb0XfsmmQNKvSLrzM+Ln04+MEk2yXbC1MIU6aiZUBQ/rY2xDh0Ft5Oi0w/ixODqsmvVMig
	vF0XG9JObM1ORu9XtPS0wUy0jXAlCYENY8ZdTochQHZYTSv/5taaAG2w==
X-Google-Smtp-Source: AGHT+IGBHe7K6SGFeVpyBf3c0o9rjTnklEYPnZPi2oxzPisjCfoarypHSGn+M9BsKCfr5lRJ/wDM3A==
X-Received: by 2002:a17:90b:2ccc:b0:340:ba29:d3b6 with SMTP id 98e67ed59e1d1-343f9e92724mr4004932a91.6.1763134537310;
        Fri, 14 Nov 2025 07:35:37 -0800 (PST)
Received: from [10.254.116.28] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345651183b2sm856644a91.2.2025.11.14.07.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 07:35:36 -0800 (PST)
Message-ID: <4d9119a1-0541-4bf1-9ac1-5abc756609d6@bytedance.com>
Date: Fri, 14 Nov 2025 23:35:32 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wenyu Liu <liuwenyu.0311@bytedance.com>
Subject: Re: [PATCH] cgroup: Improve cgroup_addrm_files remove files handling
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251111134427.96430-1-liuwenyu.0311@bytedance.com>
 <gbmz65zlanqe7p4iw6or4jqxilpv626zp4ktf6bigxs6ni2vdo@kprxb7s73qgb>
In-Reply-To: <gbmz65zlanqe7p4iw6or4jqxilpv626zp4ktf6bigxs6ni2vdo@kprxb7s73qgb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 11/11/25 21:54, Michal Koutný 写道:
> Hi Wenyu.
> 
> On Tue, Nov 11, 2025 at 09:44:27PM +0800, Wenyu Liu <liuwenyu.0311@bytedance.com> wrote:
>> Consider this situation: if we have two cftype arrays A and B
>> which contain the exact same files, and we add this two cftypes
>> with cgroup_add_cftypes().
> 
> Do you have more details about this situation?
> Does this happen with any of the mainline controllers?
> 
> Thanks,
> Michal
And here is a simple test module that will reproduce this problem. I know that using the symbol not exported is not recommended, but judging from the code, it seems to be indeed a bug: it should always return -EXEIST, however this module can be loaded successfully and make creating a new cgroup dirictory failed with the 'File exists' error.
---
 Makefile       |  9 +++++
 cft_add_test.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 Makefile
 create mode 100644 cft_add_test.c

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..160a718
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+kernelver ?= $(shell uname -r)
+obj-m += cft_add_test.o
+
+all:
+       $(MAKE) -C /lib/modules/$(kernelver)/build M=$(CURDIR) modules
+clean:
+       $(MAKE) -C /lib/modules/$(kernelver)/build M=$(CURDIR) clean
\ No newline at end of file
diff --git a/cft_add_test.c b/cft_add_test.c
new file mode 100644
index 0000000..473b988
--- /dev/null
+++ b/cft_add_test.c
@@ -0,0 +1,99 @@
+//SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kprobes.h>
+#include <linux/cgroup.h>
+#include <linux/kernfs.h>
+#include <linux/dcache.h>
+
+typedef unsigned long (*kallsyms_lookup_name_t)(const char *name);
+
+static struct kprobe kp = {
+    .symbol_name = "kallsyms_lookup_name",
+};
+
+#define LOOKUP_SYMS(name)                                               \
+do {                                                                    \
+        kallsyms_lookup_name_t kallsyms_lookup_name;                    \
+        register_kprobe(&kp);                                           \
+        kallsyms_lookup_name = (kallsyms_lookup_name_t)kp.addr;         \
+        unregister_kprobe(&kp);                                         \
+        m_##name = (void *)kallsyms_lookup_name(#name);                 \
+        if (!m_##name) {                                                \
+                pr_err("kallsyms loopup failed: %s\n", #name);          \
+                return -ENXIO;                                          \
+        }                                                               \
+} while (0)                                                             \
+
+static int (*m_cgroup_add_dfl_cftypes)(struct cgroup_subsys *ss, struct cftype *cfts);
+static int (*m_cgroup_rm_cftypes)(struct cftype *cfts);
+static struct cgroup_subsys *m_cpu_cgrp_subsys;
+
+static int show_cft_cgroup(struct seq_file *m, void *v)                
+{
+        struct cgroup *cgrp;
+        char path[1024];
+
+        cgrp = seq_css(m)->cgroup;
+        kernfs_path_from_node(cgrp->kn, NULL, path, sizeof(path));
+        seq_printf(m, "cgroup dir:%s\n", path);
+        return 0;
+}
+
+static struct cftype cft_add_files[] = {
+        {
+                .name = "cft_test_0",
+                .seq_show = show_cft_cgroup,
+        },
+        {
+                .name = "cft_test_1",
+                .seq_show = show_cft_cgroup,
+        },
+        {
+                .name = "cft_test_2",
+                .seq_show = show_cft_cgroup,
+        },
+        { } /* terminate */
+};
+
+static struct cftype cft_add_files_duplicate[] = {
+        {
+                .name = "cft_test_0",
+                .seq_show = show_cft_cgroup,
+        },
+        {
+                .name = "cft_test_1",
+                .seq_show = show_cft_cgroup,
+        },
+        { } /* terminate */
+};
+
+static int __init cft_add_test_init(void)
+{
+        int ret = 0;
+
+        LOOKUP_SYMS(cgroup_add_dfl_cftypes);
+        LOOKUP_SYMS(cgroup_rm_cftypes);
+        LOOKUP_SYMS(cpu_cgrp_subsys);
+
+        ret = m_cgroup_add_dfl_cftypes(m_cpu_cgrp_subsys, cft_add_files);
+        if (ret) {
+            pr_err("failed to add cft_add_files\n"); 
+            return ret;
+        }
+
+        ret = m_cgroup_add_dfl_cftypes(m_cpu_cgrp_subsys, cft_add_files_duplicate);
+        if (ret) {
+            //try again, this time will success
+            return m_cgroup_add_dfl_cftypes(m_cpu_cgrp_subsys, cft_add_files_duplicate);
+        } 
+        return ret;
+}
+
+static void __exit cft_add_test_exit(void)
+{
+        m_cgroup_rm_cftypes(cft_add_files);
+        m_cgroup_rm_cftypes(cft_add_files_duplicate);
+}
+
+module_init(cft_add_test_init);
+module_exit(cft_add_test_exit);
+MODULE_LICENSE("GPL v2");
-- 

