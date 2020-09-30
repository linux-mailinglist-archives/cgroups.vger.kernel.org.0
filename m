Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F77127EF82
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 18:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgI3QoU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Sep 2020 12:44:20 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:37138 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3QoU (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 30 Sep 2020 12:44:20 -0400
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 08UGddCo016869;
        Wed, 30 Sep 2020 19:43:51 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 33vwb2815s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 19:43:51 +0300
Received: from localhost (87.92.44.32) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Sep
 2020 19:43:50 +0300
From:   Jouni Roivas <jouni.roivas@tuxera.com>
To:     <tj@kernel.org>, <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <mkoutny@suse.com>, <cgroups@vger.kernel.org>
Subject: [PATCH v2] cgroup: Zero sized write should be no-op
Date:   Wed, 30 Sep 2020 19:42:42 +0300
Message-ID: <20200930164242.332249-1-jouni.roivas@tuxera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200930163435.GB304403@tuxera.com>
References: <20200930163435.GB304403@tuxera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [87.92.44.32]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_09:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=4 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300130
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
 kernel/cgroup/cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd247747ec14..c26ba71c3d93 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3682,6 +3682,9 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 	struct cgroup_subsys_state *css;
 	int ret;
 
+	if (!nbytes)
+		return 0;
+
 	/*
 	 * If namespaces are delegation boundaries, disallow writes to
 	 * files in an non-init namespace root from inside the namespace
-- 
2.25.1

