Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482233A0D98
	for <lists+cgroups@lfdr.de>; Wed,  9 Jun 2021 09:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhFIHVJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Jun 2021 03:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbhFIHVI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Jun 2021 03:21:08 -0400
X-Greylist: delayed 99 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Jun 2021 00:19:14 PDT
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAB7C061574
        for <cgroups@vger.kernel.org>; Wed,  9 Jun 2021 00:19:14 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 8B5932E14A4
        for <cgroups@vger.kernel.org>; Wed,  9 Jun 2021 10:17:29 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 318fp9ia5Z-HS1a1tcl;
        Wed, 09 Jun 2021 10:17:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1623223049; bh=S7Jlb+iv+KHJKh1j38RnlbemQ1r5YpudVR63I/AHP4g=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=LcAPHm6KcvWyTPgYpN1ov4qiG2AxRpwbRbWE5UjFP42/uAcjKEOBwj8ppR5mWdf0m
         fAFEzaTFf1rqpYf11DLSax+ERn0rArOZf84jo/Rsddo29Mz0sdRPIwSabKsPDRE3UF
         2eYodyV4wOpDx0/ekFAdJQ9QuWSJ5W5TnE6TtPWM=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from wwfq3.sas.yp-c.yandex.net (wwfq3.sas.yp-c.yandex.net [2a02:6b8:c1b:2907:0:696:4f1c:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id CFH2I7bFe8-HRo0lCpZ;
        Wed, 09 Jun 2021 10:17:27 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Alexander Kuznetsov <wwfq@yandex-team.ru>
To:     cgroups@vger.kernel.org
Cc:     zeil@yandex-team.ru, dmtrmonakhov@yandex-team.ru
Subject: [PATCH] cgroup1: don't allow '\n' in renaming
Date:   Wed,  9 Jun 2021 10:17:19 +0300
Message-Id: <1623223039-35764-1-git-send-email-wwfq@yandex-team.ru>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_mkdir() have restriction on newline usage in names:
$ mkdir $'/sys/fs/cgroup/cpu/test\ntest2'
mkdir: cannot create directory
'/sys/fs/cgroup/cpu/test\ntest2': Invalid argument

But in cgroup1_rename() such check is missed.
This allows us to make /proc/<pid>/cgroup unparsable:
$ mkdir /sys/fs/cgroup/cpu/test
$ mv /sys/fs/cgroup/cpu/test $'/sys/fs/cgroup/cpu/test\ntest2'
$ echo $$ > $'/sys/fs/cgroup/cpu/test\ntest2'
$ cat /proc/self/cgroup
11:pids:/
10:freezer:/
9:hugetlb:/
8:cpuset:/
7:blkio:/user.slice
6:memory:/user.slice
5:net_cls,net_prio:/
4:perf_event:/
3:devices:/user.slice
2:cpu,cpuacct:/test
test2
1:name=systemd:/
0::/

Signed-off-by: Alexander Kuznetsov <wwfq@yandex-team.ru>
Reported-by: Andrey Krasichkov <buglloc@yandex-team.ru>
Acked-by: Dmitry Yakunin <zeil@yandex-team.ru>
---
 kernel/cgroup/cgroup-v1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 391aa57..cf2a3e8 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -820,6 +820,10 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
 	struct cgroup *cgrp = kn->priv;
 	int ret;
 
+	/* do not accept '\n' to prevent making /proc/<pid>/cgroup unparsable */
+	if (strchr(new_name_str, '\n'))
+		return -EINVAL;
+
 	if (kernfs_type(kn) != KERNFS_DIR)
 		return -ENOTDIR;
 	if (kn->parent != new_parent)
-- 
2.7.4

