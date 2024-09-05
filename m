Return-Path: <cgroups+bounces-4717-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7096DACD
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 15:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6038CB20D45
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D96719DFB8;
	Thu,  5 Sep 2024 13:49:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945519DF76;
	Thu,  5 Sep 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544181; cv=none; b=ukccfLgTlMV3sFZu4PM3zNAK4jzf5d0poOsGO/jGry3zGaSFd17WpTK7W5HZQERlpq82PBhUPH0gCcGrgISGo9PZgD+rCTJV5tuWoAjJVjmR2T7slfAfOJb3pSchGhqPjMiueb9NcKiX9UZ4Bdfz26aY6qIY0t92jUz0+dDLFjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544181; c=relaxed/simple;
	bh=duIcmcapnLvgS8EADyMQQhxQqGvNu2gkdOzmng6AXAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ro0IMQC3iSLNqQqBI2W5FH6BD5fQRLoDS7TynSpEurUR+jXEmDehHFndSC97ImdZtjN5Ja2lC1ffpq52Tu6LpIc5LRlBLCXplLlGWfF8+H9l+1u7n/MSUM3jMbEFwBYowPvuRBaT9aXFtghyHf2sYuv5cU15NQ+It3N/oNilrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X011Q4rTMz1j89M;
	Thu,  5 Sep 2024 21:49:14 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 4647E14037C;
	Thu,  5 Sep 2024 21:49:36 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 5 Sep
 2024 21:49:35 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v1 -next 3/3] cgroup/freezer: Add freeze selftest
Date: Thu, 5 Sep 2024 13:41:30 +0000
Message-ID: <20240905134130.1176443-4-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905134130.1176443-1-chenridong@huawei.com>
References: <20240905134130.1176443-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)

Add selftest to test cgroup.freeze and check cgroup.events state.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 .../testing/selftests/cgroup/test_freezer.sh  | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100755 tools/testing/selftests/cgroup/test_freezer.sh

diff --git a/tools/testing/selftests/cgroup/test_freezer.sh b/tools/testing/selftests/cgroup/test_freezer.sh
new file mode 100755
index 000000000000..7178980b1db8
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_freezer.sh
@@ -0,0 +1,111 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test freeze hierarchy state
+#
+ROOT_PATH=/sys/fs/cgroup
+skip_test() {
+	echo "$1"
+	echo "Test SKIPPED"
+	exit 4 # ksft_skip
+}
+
+write_freeze() {
+	path=$1
+	value=$2
+	echo $value > $ROOT_PATH/$path/cgroup.freeze
+}
+
+get_event_frozen()
+{
+	path=$1
+	return $(cat $ROOT_PATH/$path/cgroup.events | grep frozen | awk '{print $2}')
+}
+
+# the test subtree:
+#        A
+#       / \
+#      B   C
+#    / | \  \
+#    D E F   G
+#   /
+#  H
+
+PATH_MATRIX=(
+	'A'
+	'A/B'
+	'A/C'
+	'A/B/D'
+	'A/B/E'
+	'A/B/F'
+	'A/C/G'
+	'A/B/D/H'
+)
+CGRP_CNT=${#PATH_MATRIX[@]}
+
+# Interface value to set/check
+ITF_MATRIX=(
+	#value write to freeze         expect event value
+	#A  B  C  D  E  F  G  H  |  A  B  C  D  E  F  G  H
+	'1  0  0  0  0  0  0  0     1  1  1  1  1  1  1  1'
+	'1  1  0  0  0  0  0  0     1  1  1  1  1  1  1  1'
+	'1  0  1  0  0  0  0  0     1  1  1  1  1  1  1  1'
+	'0  0  0  0  0  0  0  0     0  0  0  0  0  0  0  0'
+
+	'1  1  1  1  0  0  0  0     1  1  1  1  1  1  1  1'
+	'1  1  1  0  0  0  0  0     1  1  1  1  1  1  1  1'
+	'1  1  0  0  0  0  0  0     1  1  1  1  1  1  1  1'
+	'1  0  0  0  0  0  0  0     1  1  1  1  1  1  1  1'
+
+	'0  0  0  1  0  0  0  0     0  0  0  1  0  0  0  1'
+	'0  0  0  1  0  0  0  1     0  0  0  1  0  0  0  1'
+	'0  0  0  1  0  0  0  0     0  0  0  1  0  0  0  1'
+	'0  0  1  1  0  0  0  0     0  0  1  1  0  0  1  1'
+	'0  0  0  0  0  0  0  0     0  0  0  0  0  0  0  0'
+)
+
+prepare()
+{
+	for i in "${PATH_MATRIX[@]}" ; do
+		path="$ROOT_PATH/$i"
+		mkdir $path
+	done
+}
+
+do_clean()
+{
+	for(( i=$CGRP_CNT-1; i>=0; i-- ));do
+		path="/sys/fs/cgroup/${PATH_MATRIX[i]}"
+		rmdir $path
+	done
+}
+
+run_test()
+{
+	prepare
+	cgrp_cnt="${PATH_MATRIX[@]}"
+	for i in "${ITF_MATRIX[@]}" ; do
+		args=($i)
+		#write freeze
+		for(( j=0; j<$CGRP_CNT; j++ ));do
+			write_freeze "${PATH_MATRIX[j]}" ${args[j]}
+		done
+		#event frozen should eq expected value
+		for(( j=0; j<$CGRP_CNT; j++ ));do
+			get_event_frozen "${PATH_MATRIX[j]}"
+			if [ $? -ne ${args[j + $CGRP_CNT]} ];then
+				echo "failed: $i"
+				do_clean
+				exit 1
+			fi
+		done
+	done
+	do_clean
+}
+
+start_time=$(date +%s%N)
+run_test
+end_time=$(date +%s%N)
+elapsed_time=$((end_time - start_time))
+echo "Test PASSED, elapsed_time:$elapsed_time (ns)"
+exit 0
-- 
2.34.1


