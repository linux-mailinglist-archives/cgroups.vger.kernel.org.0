Return-Path: <cgroups+bounces-4085-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F59947308
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 03:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF17B20C2F
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 01:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E521420B0;
	Mon,  5 Aug 2024 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abZ6vx6m"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52A13CA8D
	for <cgroups@vger.kernel.org>; Mon,  5 Aug 2024 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821466; cv=none; b=SjgrAixijoTd/dNzTJqO5QD196bLxWsvXaZLxboO8jHJpkfL+O+DlKCJnQmCSeRxgQEoJOCdgkuwfCGIEaSWSyYAC9syy505tVNnFL86yAHH3TOLRUtUzGu2Vu7YAthtK933U8MSi9JiqNhNFHeP8e911CMjW5s2DBKSnZZCygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821466; c=relaxed/simple;
	bh=39sLqkK1hW5EV6YFEtmuk1YEgFv6Iqi71UFgllFK/p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFobZyaDO7jsVtyHmU0d7g2orGhoxsxurzs3K5cyXI/f8VT9TSsxGXjO0TYtKy5H3Uu38m1Aknz0ZzBOSFxjPbIZ4ShO9HEv/ppxNcS9FdPdRN5kTZ5ECumHfs9MXfizoy5c96IIvbulpoaRASpGPCXqUuEaQgF/4NDLnGfiQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abZ6vx6m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722821464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URmVA8EbEW4iZr2WAUB//HEv0SoOzbHc2nBPlkzxeFI=;
	b=abZ6vx6mbXC1BlzY/nqe53nRKPYCiQ76KUKFqjC4LLK0OZxA8YkUboy63IyumdoA6Uah+c
	ueWHudyCzJu0nA5DZELT6U5FVYMbKSbM5VlFu2Dw9ztqE5wtNPkMOnHFiWd0MVcvUg1iYm
	nwpbTIx65F1SJ7x7RzNUX6TWvrwDhmY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-tO7IIqb3Obu4ALm3Mbn3eA-1; Sun,
 04 Aug 2024 21:31:01 -0400
X-MC-Unique: tO7IIqb3Obu4ALm3Mbn3eA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C25BD1955D50;
	Mon,  5 Aug 2024 01:30:59 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AEFA11955E80;
	Mon,  5 Aug 2024 01:30:57 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 5/5] selftest/cgroup: Add new test cases to test_cpuset_prs.sh
Date: Sun,  4 Aug 2024 21:30:19 -0400
Message-ID: <20240805013019.724300-6-longman@redhat.com>
In-Reply-To: <20240805013019.724300-1-longman@redhat.com>
References: <20240805013019.724300-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add new test cases to test_cpuset_prs.sh to cover corner cases reported
in previous fix commits.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 7c08cc153367..7295424502b9 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -321,7 +321,7 @@ TEST_MATRIX=(
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
 	#
-	# Incorrect change to cpuset.cpus invalidates partition root
+	# Incorrect change to cpuset.cpus[.exclusive] invalidates partition root
 	#
 	# Adding CPUs to partition root that are not in parent's
 	# cpuset.cpus is allowed, but those extra CPUs are ignored.
@@ -365,6 +365,16 @@ TEST_MATRIX=(
 	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
 	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3,B1:4-5"
 
+	# Child partition root that try to take all CPUs from parent partition
+	# with tasks will remain invalid.
+	" C1-4:P1:S+ P1     .      .       .     .      .      .     0 A1:1-4,A2:1-4 A1:P1,A2:P-1"
+	" C1-4:P1:S+ P1     .      .       .   C1-4     .      .     0 A1,A2:1-4 A1:P1,A2:P1"
+	" C1-4:P1:S+ P1     .      .       T   C1-4     .      .     0 A1:1-4,A2:1-4 A1:P1,A2:P-1"
+
+	# Clearing of cpuset.cpus with a preset cpuset.cpus.exclusive shouldn't
+	# affect cpuset.cpus.exclusive.effective.
+	" C1-4:X3:S+ C1:X3  .      .       .     C      .      .     0 A2:1-4,XA2:3"
+
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
 	# Failure cases:
-- 
2.43.5


