Return-Path: <cgroups+bounces-15074-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM+COdtGxmmgIAUAu9opvQ
	(envelope-from <cgroups+bounces-15074-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 09:59:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA8A341651
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 09:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99BC430EAE85
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35573DA5AA;
	Fri, 27 Mar 2026 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+J3EM/Q"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3783D3CF8
	for <cgroups@vger.kernel.org>; Fri, 27 Mar 2026 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601611; cv=none; b=dnVjQ+A0IrnIiKaxbRe5J+vzAynNGLhVMiioBIeJqNFO+7HRkCBQRFB8t0d5flXzW2AW8cBZSDlYBdWi/BalNn8+QXpzSA2putfBb06KDcXozJVDBfJfxLEd/QuQeM79X8Wx+lNslO6QGIJ+hEFPKeJF2zO5LJ6YdO0YCpje2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601611; c=relaxed/simple;
	bh=OkCEfuTkvZiaoB5N52knGFfxEgBkl/u/c3ItUbO0AfE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mfg9+FzV50ViRzFkzf1F9n3cPJMWfh0/3l/NIGDSkgiQcuB6YzxqoBhVcTQKh/0VToPfWx93PBPgOjSyLK8oTrx4GPWpkNYYI6YfX25B5LHGGILGIraggBai1C/CF66lILsqHcsv8nF6e7YQ2RT0o01ig7p3/TQhPldHhr3ZW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+J3EM/Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774601609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6V2laN0jUZw3fzRi+brKYUCENSji4guAxKdpVKjyDX4=;
	b=c+J3EM/Q/N0XTRtYyd7R8Cv+t37EseAHDORlSCJX3islKmmr91gbVU5sU0kPhIDTu5PVmy
	GD0xV0bvNiR0qrJOOIFdcPOZssLIweftKhkgTG/WkvrPGKICHVgk9E0+lKNhDTtfBN5Eb7
	wlsbexIy+1XXFFRSh3qCPJU32ICky90=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-q7tDOfw2N_uPSRtx19Z1oQ-1; Fri,
 27 Mar 2026 04:53:25 -0400
X-MC-Unique: q7tDOfw2N_uPSRtx19Z1oQ-1
X-Mimecast-MFC-AGG-ID: q7tDOfw2N_uPSRtx19Z1oQ_1774601604
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54C3519560A1;
	Fri, 27 Mar 2026 08:53:24 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.44.32.245])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27C5F1800673;
	Fri, 27 Mar 2026 08:53:19 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH 0/3] cgroup: dmem: add selftest helper, coverage, and VM
 runner
Date: Fri, 27 Mar 2026 09:53:02 +0100
Message-Id: <20260327-kunit_cgroups-v1-0-971b3c739a00@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0ML3ezSvMyS+OT0ovzSgmJd87QkgyTLVDMTA0NzJaCegqLUtMwKsHn
 RsbW1APKEibdfAAAA
X-Change-ID: 20260318-kunit_cgroups-7fb0b9e64017
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@redhat.com, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774601599; l=1999;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=OkCEfuTkvZiaoB5N52knGFfxEgBkl/u/c3ItUbO0AfE=;
 b=8Eek/d8K+Zbv4bPGE+S6e1wGM/tJLQPH1//T0TQLCrIBUzAWbq4nJyU9chE64hbl9/Dkzyhr3
 qtnSNtnu/vUCmOjQpJmMro5mIeU3xlawGUJhYFpQw6IMuz/Fh+yDMnm
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15074-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DA8A341651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

This small series adds practical test coverage for the dmem
cgroup controller.

The motivation came from following the recent dmem API discussion in
thread [1]. That discussion considered changing the dmem API and
adding a new knob. Currently there are no dedicated tests covering
dmem behaviour, which makes such changes riskier.

Adding selftests has an additional challenge: dmem charging paths
are driver-driven today, so regression testing harder unless a
suitable driver is present in the test environment.

This series addresses that by adding:
- a kernel-side selftest helper module to trigger charge/uncharge
  from userspace in a controlled way,
- cgroup selftests covering dmem accounting and protection semantics
  (including dmem.max enforcement and byte-granularity checks),
- a virtme-based VM runner for repeatable execution of the dmem tests.

The goal is to make dmem behavior easier to validate when evolving the API
and implementation, while keeping tests deterministic and driver-independent.

Thanks.

[1] - https://lore.kernel.org/all/aZoHfloupKvF2oSu@fedora/

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
Albert Esteve (3):
      cgroup: Add dmem_selftest module
      selftests: cgroup: Add dmem selftest coverage
      selftests: cgroup: Add vmtest-dmem runner based on hid vmtest

 init/Kconfig                                  |  12 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/dmem_selftest.c                 | 192 ++++++++++
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/test_dmem.c    | 487 ++++++++++++++++++++++++++
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 189 ++++++++++
 7 files changed, 884 insertions(+)
---
base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
change-id: 20260318-kunit_cgroups-7fb0b9e64017

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>


