Return-Path: <cgroups+bounces-14967-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPItIGGxvWlBAgMAu9opvQ
	(envelope-from <cgroups+bounces-14967-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:43:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409752E0ED7
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1833C3018C3B
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF635FF6B;
	Fri, 20 Mar 2026 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MINLC3BH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703135DA7E
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039386; cv=none; b=nkrBsPdlZNlK1bT631lheO8uJQcaOKGsntqzMe0YkrQjrkd+paUR3eai0xaCht8N63qx2l9yZvks1LpLSD+gZFBxIuO8laBb3dl8Hr2S7GK/9fljGMMEuHcq6skwTOnaXIGUCXKsFh8TyFNxuAZvri+oypYhrIuA9lvGBSfVP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039386; c=relaxed/simple;
	bh=Qtl/QNQdwa3OFwEuizrnDJxBkh7tTWC+4itQ9zOUL18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaErgEZjWV3VtUd9GbV5Y356IsmMu4q8D0lXifMn8JGWy0QX5raUVb3y186B+LmCkFMx6kor2UHjZSlm7BbPT1h+s6CVzXSm1JfirzxaLJOvdWoyQ+2jKtnv7I2L9f2EKBY8h4LkCgEHKnUK05aABBSWZlTiJ38nSuGlIah3OTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MINLC3BH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774039384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mzDJOwyHBDBq1BCeO/lk8RpHfJAtuh1dPDmbb+C20QU=;
	b=MINLC3BHReWUSNlm9VwUgvusNl6Cl8mL8MSpIkhpph0fmIFq9RCmScwKWHsEvALws228Hk
	3f6HZkiT8EhUscmhh0L8Hb04PBJuymnm4VMywZQE9GwK98EruPr5eAUfiaJYfcOXl8nam3
	edfWEg+ZqCf+T2rKYNKZbJUy89CYfhk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-JHNhGB0_OU20nOz6yFSHTQ-1; Fri,
 20 Mar 2026 16:42:59 -0400
X-MC-Unique: JHNhGB0_OU20nOz6yFSHTQ-1
X-Mimecast-MFC-AGG-ID: JHNhGB0_OU20nOz6yFSHTQ_1774039377
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64FE61956055;
	Fri, 20 Mar 2026 20:42:56 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.139])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93657180075B;
	Fri, 20 Mar 2026 20:42:52 +0000 (UTC)
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
Subject: [PATCH v2 0/7] selftests: memcg: Fix test_memcontrol test failures with large page sizes
Date: Fri, 20 Mar 2026 16:42:34 -0400
Message-ID: <20260320204241.1613861-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	TAGGED_FROM(0.00)[bounces-14967-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 409752E0ED7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 v2:
  - Change vmstats flush threshold scaling from ilog2() to int_sqrt() as
    suggested by Li Wang
  - Fix a number of issues reported by AI review of the patch series

There are a number of test failures with the running of the
test_memcontrol selftest on a 128-core arm64 system on kernels with
4k/16k/64k page sizes. This patch series makes some minor changes to
the kernel and the test_memcontrol selftest to address these failures.

The first kernel patch scales the memcg vmstats flush threshold
with int_sqrt() instead of linearly with the total number of CPUs. The
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
  memcg: Scale up vmstats flush threshold with int_sqrt(nr_cpus+2)
  memcg: Scale down MEMCG_CHARGE_BATCH with increase in PAGE_SIZE
  selftests: memcg: Iterate pages based on the actual page size
  selftests: memcg: Increase error tolerance in accordance with page
    size
  selftests: memcg: Reduce the expected swap.peak with larger page size
  selftests: memcg: Don't call reclaim_until() if already in target
  selftests: memcg: Treat failure for zeroing sock in test_memcg_sock as
    XFAIL

 include/linux/memcontrol.h                    |  8 +-
 mm/memcontrol.c                               | 18 ++--
 .../cgroup/lib/include/cgroup_util.h          |  3 +-
 .../selftests/cgroup/test_memcontrol.c        | 87 +++++++++++++++----
 4 files changed, 93 insertions(+), 23 deletions(-)

-- 
2.53.0


