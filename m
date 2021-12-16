Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67670476864
	for <lists+cgroups@lfdr.de>; Thu, 16 Dec 2021 03:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhLPCzq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Dec 2021 21:55:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51912 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbhLPCzq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Dec 2021 21:55:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 716CDB82294;
        Thu, 16 Dec 2021 02:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57054C36AFE;
        Thu, 16 Dec 2021 02:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639623343;
        bh=YxjBxNV2YAEjL3Otuf0fLRGjWC0v4OV97wVEW+8DHIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRuP0CDN60MoeW2/tqT0uv6Adl6l8mH0wRjReH52felfjiUipyQ39pfE4ieMDmMas
         u7sy85vUmuWZoC3/K7bUaB/V+/LmSac/VuyA2JhIRDAHtAh+f9h9xIIkyzJaeCO8e/
         w7MMZo6ggUsr+JbWgAON4JKS1KXlehxYRfXqGY5FBcBb9LmwJ0RmFr+WnaV8gdcp+L
         8oKbiGj1fNww+rfCt+7JaCyIt9wbtpCUD6N1Nj4n2GKRi4HITq8LqVuIwsar9jgEqQ
         FDacedxEOUfD/HOOE/XDZ81KQ2EQmXw0GxBWBzb4RWy7amOu4Xd2ELfUMPEu8QlJk1
         oIeYUcbcgXUeQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Tejun Heo <tj@kernel.org>, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, rostedt@goodmis.org,
        mingo@redhat.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        jmorris@namei.org, serge@hallyn.com, cgroups@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v5 2/3] add missing bpf-cgroup.h includes
Date:   Wed, 15 Dec 2021 18:55:37 -0800
Message-Id: <20211216025538.1649516-3-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216025538.1649516-1-kuba@kernel.org>
References: <20211216025538.1649516-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We're about to break the cgroup-defs.h -> bpf-cgroup.h dependency,
make sure those who actually need more than the definition of
struct cgroup_bpf include bpf-cgroup.h explicitly.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: kafai@fb.com
CC: songliubraving@fb.com
CC: yhs@fb.com
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: lizefan.x@bytedance.com
CC: hannes@cmpxchg.org
CC: rostedt@goodmis.org
CC: mingo@redhat.com
CC: yoshfuji@linux-ipv6.org
CC: dsahern@kernel.org
CC: jmorris@namei.org
CC: serge@hallyn.com
CC: bpf@vger.kernel.org
CC: cgroups@vger.kernel.org
CC: linux-security-module@vger.kernel.org
---
 kernel/bpf/helpers.c        | 1 +
 kernel/bpf/syscall.c        | 1 +
 kernel/bpf/verifier.c       | 1 +
 kernel/cgroup/cgroup.c      | 1 +
 kernel/trace/trace_kprobe.c | 1 +
 kernel/trace/trace_uprobe.c | 1 +
 net/ipv4/udp.c              | 1 +
 net/ipv6/udp.c              | 1 +
 net/socket.c                | 1 +
 security/device_cgroup.c    | 1 +
 10 files changed, 10 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8babae03d30a..34d6f91dec1c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
  */
 #include <linux/bpf.h>
+#include <linux/bpf-cgroup.h>
 #include <linux/rcupdate.h>
 #include <linux/random.h>
 #include <linux/smp.h>
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ddd81d543203..da07bdf71697 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
  */
 #include <linux/bpf.h>
+#include <linux/bpf-cgroup.h>
 #include <linux/bpf_trace.h>
 #include <linux/bpf_lirc.h>
 #include <linux/bpf_verifier.h>
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d74e8a99412e..f0604796132f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2018 Covalent IO, Inc. http://covalent.io
  */
 #include <uapi/linux/btf.h>
+#include <linux/bpf-cgroup.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 919194de39c8..cd4c23f7e3df 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -30,6 +30,7 @@
 
 #include "cgroup-internal.h"
 
+#include <linux/bpf-cgroup.h>
 #include <linux/cred.h>
 #include <linux/errno.h>
 #include <linux/init_task.h>
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 33272a7b6912..4e1257f50aa3 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -7,6 +7,7 @@
  */
 #define pr_fmt(fmt)	"trace_kprobe: " fmt
 
+#include <linux/bpf-cgroup.h>
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f5f0039d31e5..4f35514a48f3 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -7,6 +7,7 @@
  */
 #define pr_fmt(fmt)	"trace_uprobe: " fmt
 
+#include <linux/bpf-cgroup.h>
 #include <linux/security.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 69d30053fed9..99536127650b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -74,6 +74,7 @@
 
 #define pr_fmt(fmt) "UDP: " fmt
 
+#include <linux/bpf-cgroup.h>
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
 #include <linux/memblock.h>
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6a0e569f0bb8..ba8986d12413 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -17,6 +17,7 @@
  *      YOSHIFUJI Hideaki @USAGI:	convert /proc/net/udp6 to seq_file.
  */
 
+#include <linux/bpf-cgroup.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/socket.h>
diff --git a/net/socket.c b/net/socket.c
index 7f64a6eccf63..721a5a1b1106 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -52,6 +52,7 @@
  *	Based upon Swansea University Computer Society NET3.039
  */
 
+#include <linux/bpf-cgroup.h>
 #include <linux/ethtool.h>
 #include <linux/mm.h>
 #include <linux/socket.h>
diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index 04375df52fc9..842889f3dcb7 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -5,6 +5,7 @@
  * Copyright 2007 IBM Corp
  */
 
+#include <linux/bpf-cgroup.h>
 #include <linux/device_cgroup.h>
 #include <linux/cgroup.h>
 #include <linux/ctype.h>
-- 
2.31.1

