Return-Path: <cgroups+bounces-7507-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EA1A875C5
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 04:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97547A260C
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 02:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9106118EFD1;
	Mon, 14 Apr 2025 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFpQJF34"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E55E55B
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744596786; cv=none; b=Snyb90rsR0l2DmXpB0U5aJ6qgnuO5+awV/CLG7u8xf1eIfL6J7jwOwEAAKPMjfpfACYu7QNaX8lrl9+P8pS7H+ozP0zGyhzw1ovty0coQXByMH5ed4/LwWxE2jlxUSpi0mYvg/rLgud2dazIluIA/hnODEz9uT7iqFffhmo8JJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744596786; c=relaxed/simple;
	bh=yNa0PStB4b8MFLv5cYNKPnXACGQ1t7hOUt2Y9lAgYaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U3O9aRXe+0yA+bLExrw9nfTYaLsyjX7njWea3A5NygMdDTOPDcQlWP4wCOfPb2F7VfPMN0lTgoMCLJYBedKkgn3kPDw7C76ba7CjMpNCsQgZNflQ2QWdOmEW7xOV09uaXl1jThMe2fZie6UA3h6HRqHWmvSjrkk/ZIQ2loY/vkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFpQJF34; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744596782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QZBobq1OYBjlQedM++FCOYQhXUdMrey2OHi1cswFKkY=;
	b=CFpQJF346GNv8eNQQDbSUe5LZMIODXG+vZFzM5UKd7B7x1ff8r9ombo0+vQXnyNJ1hm3rk
	bBGoE8YFM0Ibsps7ImQU3lbakNUYi/P/Ufiap4t7m2MxlzaWvoD6Z6vJzOE5dh2/52m9XL
	mcYo3ZcupT/iUy6N0HKTmhreOXT+6VQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-05CzWhbhOLuIQfzXk4bZ1Q-1; Sun,
 13 Apr 2025 22:13:01 -0400
X-MC-Unique: 05CzWhbhOLuIQfzXk4bZ1Q-1
X-Mimecast-MFC-AGG-ID: 05CzWhbhOLuIQfzXk4bZ1Q_1744596779
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A6A2180035E;
	Mon, 14 Apr 2025 02:12:58 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0B97180B488;
	Mon, 14 Apr 2025 02:12:54 +0000 (UTC)
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
Subject: [PATCH v6 0/2] memcg: Fix test_memcg_min/low test failures
Date: Sun, 13 Apr 2025 22:12:47 -0400
Message-ID: <20250414021249.3232315-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

v6:
 - The memcg_test_low failure is indeed due to the memory_recursiveprot
   mount option which is enabled by default in systemd cgroup v2 setting.
   So adopt Michal's suggestion to adjust the low event checking
   according to whether memory_recursiveprot is enabled or not.

v5:
 - Use mem_cgroup_usage() in patch 1 as originally suggested by Johannes.

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test (with memory_recursiveprot enabled) and sporadically fails
its test_memcg_min sub-test. This patchset fixes the test_memcg_min
and test_memcg_low failures by skipping the !usage case in
shrink_node_memcgs() and adjust the test_memcontrol selftest to fix
other causes of the test failures.

Waiman Long (2):
  mm/vmscan: Skip memcg with !usage in shrink_node_memcgs()
  selftests: memcg: Increase error tolerance of child memory.current
    check in test_memcg_protection()

 mm/internal.h                                 |  9 +++++++++
 mm/memcontrol-v1.h                            |  2 --
 mm/vmscan.c                                   |  4 ++++
 .../selftests/cgroup/test_memcontrol.c        | 20 ++++++++++++-------
 4 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.48.1


