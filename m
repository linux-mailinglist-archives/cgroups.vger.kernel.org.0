Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252C227AEFD
	for <lists+cgroups@lfdr.de>; Mon, 28 Sep 2020 15:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1NVi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Sep 2020 09:21:38 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:51478 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgI1NVi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 28 Sep 2020 09:21:38 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 09:21:36 EDT
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 08SDBeUv045153;
        Mon, 28 Sep 2020 16:11:40 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 33ueu9g50w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 16:11:39 +0300
Received: from localhost (87.92.44.32) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Sep
 2020 16:11:39 +0300
From:   Jouni Roivas <jouni.roivas@tuxera.com>
To:     <tj@kernel.org>, <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>
Subject: [PATCH] cgroup: Zero sized write should be no-op
Date:   Mon, 28 Sep 2020 16:10:13 +0300
Message-ID: <20200928131013.3816044-1-jouni.roivas@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [87.92.44.32]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_11:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 malwarescore=0 mlxlogscore=999
 adultscore=2 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280105
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Do not report failure on zero sized writes, and handle them as no-op.

There's issues for example in case of writev() when there's iovec
containing zero buffer as a first one. It's expected writev() on below
example to successfully perform the write to specified writable cgroup
file expecting integer value, and to return 2. For now it's returning
value -1, and skipping the write:

	int writetest(int fd) {
	  const char *buf1 = "";
	  const char *buf2 = "1\n";
          struct iovec iov[2] = {
                { .iov_base = (void*)buf1, .iov_len = 0 },
                { .iov_base = (void*)buf2, .iov_len = 2 }
          };
	  return writev(fd, iov, 2);
	}

This patch fixes the issue by checking if there's nothing to write,
and handling the write as no-op by just returning 0.

Signed-off-by: Jouni Roivas <jouni.roivas@tuxera.com>
---
 kernel/cgroup/cgroup.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd247747ec14..331b050fd5f1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3222,6 +3222,9 @@ static ssize_t cgroup_subtree_control_write(struct kernfs_open_file *of,
 	char *tok;
 	int ssid, ret;
 
+	if (!nbytes)
+		return 0;
+
 	/*
 	 * Parse input - space separated list of subsystem names prefixed
 	 * with either + or -.
@@ -3385,6 +3388,9 @@ static ssize_t cgroup_type_write(struct kernfs_open_file *of, char *buf,
 	struct cgroup *cgrp;
 	int ret;
 
+	if (!nbytes)
+		return 0;
+
 	/* only switching to threaded mode is supported */
 	if (strcmp(strstrip(buf), "threaded"))
 		return -EINVAL;
@@ -3421,6 +3427,9 @@ static ssize_t cgroup_max_descendants_write(struct kernfs_open_file *of,
 	int descendants;
 	ssize_t ret;
 
+	if (!nbytes)
+		return 0;
+
 	buf = strstrip(buf);
 	if (!strcmp(buf, "max")) {
 		descendants = INT_MAX;
@@ -3464,6 +3473,9 @@ static ssize_t cgroup_max_depth_write(struct kernfs_open_file *of,
 	ssize_t ret;
 	int depth;
 
+	if (!nbytes)
+		return 0;
+
 	buf = strstrip(buf);
 	if (!strcmp(buf, "max")) {
 		depth = INT_MAX;
@@ -3569,6 +3581,9 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 	struct psi_trigger *new;
 	struct cgroup *cgrp;
 
+	if (!nbytes)
+		return 0;
+
 	cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!cgrp)
 		return -ENODEV;
@@ -3638,6 +3653,9 @@ static ssize_t cgroup_freeze_write(struct kernfs_open_file *of,
 	ssize_t ret;
 	int freeze;
 
+	if (!nbytes)
+		return 0;
+
 	ret = kstrtoint(strstrip(buf), 0, &freeze);
 	if (ret)
 		return ret;
@@ -3682,6 +3700,9 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 	struct cgroup_subsys_state *css;
 	int ret;
 
+	if (!nbytes)
+		return 0;
+
 	/*
 	 * If namespaces are delegation boundaries, disallow writes to
 	 * files in an non-init namespace root from inside the namespace
@@ -4777,6 +4798,9 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 	ssize_t ret;
 	bool locked;
 
+	if (!nbytes)
+		return 0;
+
 	buf = strstrip(buf);
 
 	dst_cgrp = cgroup_kn_lock_live(of->kn, false);
-- 
2.25.1

