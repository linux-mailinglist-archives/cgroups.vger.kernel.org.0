Return-Path: <cgroups+bounces-14915-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAUCKEU1vGl3uwIAu9opvQ
	(envelope-from <cgroups+bounces-14915-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 18:41:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 246782D0284
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 18:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70EC23056E69
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5E396D1E;
	Thu, 19 Mar 2026 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0My+wZW"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203234887C
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941941; cv=none; b=hWx01I5swwcdK16TXQSNKWmSATpKgFwlFrtUL/hy/VrYy99yIc0nA/dNZlr+hGyaURUsnAqFJpD51LU553GrmWvlMW9hzsIgNCxysHTES+zMEOxMYWo3RNyTLAt9cNCJhpoNbx5uHxldeaFb0C7Z3d7ofyB1wggotqmAS9GFuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941941; c=relaxed/simple;
	bh=NxL4EPN9Ba+XKIC2o5o6oDG5HiOcSSMFcUWcSwWrObo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLVF4rbNTVZ1gaYzx6N/o4arWG6kaw4UZnC9ALCxRzoW1+J9t+ksHUFGUnIAdIQT8jY05HdyhKwJAYO4g2ecL+lY0CLZnZwMvxHuPYFXeGPXuXhss/O96i2sr4I/2eUnzj+owkmWnrEG+L1emnj298dypySXXSLC2hc+dnPhs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0My+wZW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773941934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GolfCpcwvGX7ESq6QSakQqV8SX3HQ4CiS3Tfxd8agvs=;
	b=L0My+wZWjskaCgSBHVjXYRpDgC7NMTowprkIwv88OYiNZug1gTMmjr9MX8xpKfhlQ5VxgT
	rQpXNnICsAPkygCBHw6xZhdZidR/lm9KtbuJAxhwaMbiFOUFWvdlNe691m8CgopXpXeODh
	NzkCDWD6p2atEtJZa+rDa7Fhr8KT8o0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-oho6wAX6O5KCaQuvtplSuQ-1; Thu,
 19 Mar 2026 13:38:51 -0400
X-MC-Unique: oho6wAX6O5KCaQuvtplSuQ-1
X-Mimecast-MFC-AGG-ID: oho6wAX6O5KCaQuvtplSuQ_1773941929
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B87518002CB;
	Thu, 19 Mar 2026 17:38:48 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA7F430001A1;
	Thu, 19 Mar 2026 17:38:43 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	James Houghton <jthoughton@google.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>,
	Li Wang <liwan@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/7] selftests: memcg: Fix test_memcontrol test failures with large page sizes
Date: Thu, 19 Mar 2026 13:37:45 -0400
Message-ID: <20260319173752.1472864-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14915-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.958];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 246782D0284
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are a number of test failures with the running of the
test_memcontrol selftest on a 128-core arm64 system on kernels with
4k/16k/64k page sizes. This patch series makes some minor changes to
the kernel and the test_memcontrol selftest to address these failures.

The first kernel patch scales the memcg vmstats flush threshold
logarithmetically instead of linearly with the total number of CPUs. The
second kernel patch scale down MEMCG_CHARGE_BATCH with increases in page
size. These 2 patches help to reduce the discrepancies between the
reported usage data with the real ones.

The next 5 test_memcontrol selftest patches adjust the testing code to
greatly reduce the chance that it will report failure, though some
occasional failures is still possible.

To verify the changes, the test_memcontrol selftest was run 100
times each on a 128-core arm64 system on kernels with 4k/16k/64k
page sizes.  No failure was observed other than some failures of the
test_memcg_reclaim test when running on a 16k page size kernel. The
reclaim_until() call failed because of the unexpected over-reclaim of
memory. This will need a further look but it happens with the 16k page
size kernel only and I don't have a production ready kernel config file
to use in buildinig this 16k page size kernel. The new test_memcontrol
selftest and kernel were also run on a 96-core x86 system to make sure
there was no regression.

Waiman Long (7):
  memcg: Scale up vmstats flush threshold with log2(nums_possible_cpus)
  memcg: Scale down MEMCG_CHARGE_BATCH with increase in PAGE_SIZE
  selftests: memcg: Iterate pages based on the actual page size
  selftests: memcg: Increase error tolerance in accordance with page
    size
  selftests: memcg: Reduce the expected swap.peak with larger page size
  selftests: memcg: Don't call reclaim_until() if already in target
  selftests: memcg: Treat failure for zeroing sock in test_memcg_sock as
    XFAIL

 include/linux/memcontrol.h                    |  8 +-
 mm/memcontrol.c                               | 17 ++--
 .../cgroup/lib/include/cgroup_util.h          |  1 +
 .../selftests/cgroup/test_memcontrol.c        | 83 +++++++++++++++----
 4 files changed, 87 insertions(+), 22 deletions(-)

-- 
2.53.0


