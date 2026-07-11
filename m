Return-Path: <cgroups+bounces-17659-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QBiSA0qlUWpEHAMAu9opvQ
	(envelope-from <cgroups+bounces-17659-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 04:07:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD7C73FFD3
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 04:07:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QvCNRxiR;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17659-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17659-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A7F9302EE99
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 02:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28D12FA0C6;
	Sat, 11 Jul 2026 02:06:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F13286A7
	for <cgroups@vger.kernel.org>; Sat, 11 Jul 2026 02:06:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783735596; cv=none; b=UXS1H6CmliaBxyNc+M+1dKhemuIXm5K9ebxe3AOp5o8MSwlyRRsqPKKiiAyAFZnHIWhYTdHBfPv6Gm7MsQ69ALEfajdPrbwS/9e7TDE7x5rjYQ1BHNLjmpfCM0UBckiyVBq5245J4Yl52REZSf1tWPj8k0B8s2oIG7j8DnyO1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783735596; c=relaxed/simple;
	bh=uWvFI/eVIIM5pKQO1Td7QghFFLWSDsZw5+VMwnMK/m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dv9GjWuuYl5b402n/7QgUeM+/JWuUE01QNZhs3IdnP+Cp9iP/jQM0fxtDvTEXB8LXQbXJhwygO2pqw7mvlVNEOoKbcIsQ1LYQnZH9kIH+IZ5VcpPJ014/a1ct5u9R8c9ZfhU4S8u2DmpEB2rlDJ3e3Qe803q0v1ZftVUVQ2dE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvCNRxiR; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783735594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/NztoyCLvg4UiSlfkQ5LeMJ1fB1cR0kulNLdHmCoJYw=;
	b=QvCNRxiRba4OYQcDagEyjfs7MdPuxaJYNcWrd/pfrlRngS0VdrO/IHWw+I2yE4+nae3M+2
	L0GgwjSv0l5HQnnxYIeA4nDWGz4HLxJ4cQVRin4XKjx9Ha/NHdXd6jMkjcFE+jVleYnd1A
	YVyjYmPzotL+qt9WVslBqFVeabB43PI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-sRNboGEoNdmNjZ9dQnkZbQ-1; Fri,
 10 Jul 2026 22:06:28 -0400
X-MC-Unique: sRNboGEoNdmNjZ9dQnkZbQ-1
X-Mimecast-MFC-AGG-ID: sRNboGEoNdmNjZ9dQnkZbQ_1783735587
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9F681800639;
	Sat, 11 Jul 2026 02:06:26 +0000 (UTC)
Received: from llong-thinkpadp1gen5.rmtusnh.csb (unknown [10.22.88.253])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2032195419F;
	Sat, 11 Jul 2026 02:06:24 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next 0/3] cgroup/cpuset: Support multiple destination cpusets for cpuset_*attach()
Date: Fri, 10 Jul 2026 22:05:37 -0400
Message-ID: <20260711020540.176740-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17659-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FD7C73FFD3

This is a follow-up patch series to [1] to properly handle a special case
for cpuset task migration operation where the source and destination
cpusets are the same. Patch 1 handle this special cases by skipping
tasks are not migrating with respect to cpuset. Patch 2 enables
cpuset_*attach() to handle the case where thare many destination cpusets
which when a cpuset controller is enabled. Patch 3 adds a new test case
into test_cpuset to test proper handling of cpu affinity when cpuset
controller is disabled.

[1] https://lore.kernel.org/lkml/20260702214757.579012-1-longman@redhat.com

Michal Koutný (1):
  selftests/cgroup: Add test for cpuset affinity on controller disable

Waiman Long (2):
  cgroup/cpuset: Handle the special case of non-moving tasks in
    cpuset_can_attach()
  cgroup/cpuset: Support multiple destination cpusets for
    cpuset_*attach()

 kernel/cgroup/cpuset.c                       | 116 +++++----
 tools/testing/selftests/cgroup/test_cpuset.c | 243 +++++++++++++++++++
 2 files changed, 310 insertions(+), 49 deletions(-)

-- 
2.55.0


