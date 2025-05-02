Return-Path: <cgroups+bounces-7976-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C0EAA6826
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 03:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793C9983DD1
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 01:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438F16C850;
	Fri,  2 May 2025 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rq2JIXbq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C414EC62
	for <cgroups@vger.kernel.org>; Fri,  2 May 2025 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746147909; cv=none; b=KJ9O4RZ9dbZFqxLlwpQbvII2b4yO7JO7xIOUqBQnrbi4rJTIFLEuTjdehw2q4hVHq8tWQEpLAONCpqVBNtoxxNoymyqXrd/fvY87yUyMx8ZzfjHzBvDQoyyw0TtILTqp87ufMnW5pZzlW5MHZqPKvYKo51yYECY/k1XHSBYDFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746147909; c=relaxed/simple;
	bh=WuUNHPlcI34OGoe9k9uvk9UDw9MeHqo8z2kKd7VdYWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtTRKvFx6sCO0sCe97ZtdanJ42jv7SOOUoouNBHkCX1mdFiC7CDGNXstw38i+8ejT1VzJNA3VoDUEA9VXq7789y2iwKEYJAwGDtLWmAAzMB8+2lOybzOxUklb4przHtH8RPNqXANfTTMRqlzrD2KRZNoKrhMuILWG6qyJTqV7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rq2JIXbq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746147906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owySU7dSCB78ZpCQgHbvTjigjXxf+YL8mNc7nb45BJM=;
	b=Rq2JIXbq6BVw5B4l91GPKR1IHxzFz1RAI6Ut4A5fWibJYIPx86ua6ljnYVAjKviBjslh6b
	53Wgefd5z7Fnzk/qV7KZHVd/0W4OyFh0zHAOnSfbOSXr2JuW1FVK+z/gtj8MHyrOY093Qw
	e8dwI8HiZgC0ldyzR064tqUm/EH/3EA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-KfkMnat2MGqM4eXr5_nv4A-1; Thu,
 01 May 2025 21:05:02 -0400
X-MC-Unique: KfkMnat2MGqM4eXr5_nv4A-1
X-Mimecast-MFC-AGG-ID: KfkMnat2MGqM4eXr5_nv4A_1746147900
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DC641800264;
	Fri,  2 May 2025 01:05:00 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.189])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5377719560A3;
	Fri,  2 May 2025 01:04:57 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v8 2/2] selftests: memcg: Increase error tolerance of child memory.current check in test_memcg_protection()
Date: Thu,  1 May 2025 21:04:43 -0400
Message-ID: <20250502010443.106022-3-longman@redhat.com>
In-Reply-To: <20250502010443.106022-1-longman@redhat.com>
References: <20250502010443.106022-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The test_memcg_protection() function is used for the test_memcg_min and
test_memcg_low sub-tests. This function generates a set of parent/child
cgroups like:

  parent:  memory.min/low = 50M
  child 0: memory.min/low = 75M,  memory.current = 50M
  child 1: memory.min/low = 25M,  memory.current = 50M
  child 2: memory.min/low = 0,    memory.current = 50M

After applying memory pressure, the function expects the following
actual memory usages.

  parent:  memory.current ~= 50M
  child 0: memory.current ~= 29M
  child 1: memory.current ~= 21M
  child 2: memory.current ~= 0

In reality, the actual memory usages can differ quite a bit from the
expected values. It uses an error tolerance of 10% with the values_close()
helper.

Both the test_memcg_min and test_memcg_low sub-tests can fail
sporadically because the actual memory usage exceeds the 10% error
tolerance. Below are a sample of the usage data of the tests runs
that fail.

  Child   Actual usage    Expected usage    %err
  -----   ------------    --------------    ----
    1       16990208         22020096      -12.9%
    1       17252352         22020096      -12.1%
    0       37699584         30408704      +10.7%
    1       14368768         22020096      -21.0%
    1       16871424         22020096      -13.2%

The current 10% error tolerenace might be right at the time
test_memcontrol.c was first introduced in v4.18 kernel, but memory
reclaim have certainly evolved quite a bit since then which may result
in a bit more run-to-run variation than previously expected.

Increase the error tolerance to 15% for child 0 and 20% for child 1 to
minimize the chance of this type of failure. The tolerance is bigger
for child 1 because an upswing in child 0 corresponds to a smaller
%err than a similar downswing in child 1 due to the way %err is used
in values_close().

Before this patch, a 100 test runs of test_memcontrol produced the
following results:

     17 not ok 1 test_memcg_min
     22 not ok 2 test_memcg_low

After applying this patch, there were no test failure for test_memcg_min
and test_memcg_low in 100 test runs. However, these tests may still fail
once in a while if the memory usage goes beyond the newly extended range.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 58602c1831f1..d6534d7301a2 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -496,10 +496,10 @@ static int test_memcg_protection(const char *root, bool min)
 	for (i = 0; i < ARRAY_SIZE(children); i++)
 		c[i] = cg_read_long(children[i], "memory.current");
 
-	if (!values_close(c[0], MB(29), 10))
+	if (!values_close(c[0], MB(29), 15))
 		goto cleanup;
 
-	if (!values_close(c[1], MB(21), 10))
+	if (!values_close(c[1], MB(21), 20))
 		goto cleanup;
 
 	if (c[3] != 0)
-- 
2.49.0


