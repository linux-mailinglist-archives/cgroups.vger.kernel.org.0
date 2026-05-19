Return-Path: <cgroups+bounces-16077-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB/qOgxHDGoMdAUAu9opvQ
	(envelope-from <cgroups+bounces-16077-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 13:18:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6267D57D639
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E57C130DE5BE
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97C8480340;
	Tue, 19 May 2026 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X99aqFp2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05F3DD503
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188623; cv=none; b=LHliKDHei8HrCeXu5/igjRvsdnRM7ItAugWbxEwZWFBh640fEDahDRZ4D3XuRx8jI0SRu6IqZ1jm6lnzepiCiKsNJQrps7fYx24z8dYQD/N+MWzxyMXGhTOnf0uO/F2JYV/4u3YGcgMqHPlt8wV7iK2RU7iwVPEKyBIpcFzu710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188623; c=relaxed/simple;
	bh=n6BBrq+FrC4yrmdE/lDjXJKloZJFhROP8N/VMk0IHcc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r2tiZ8bD5hOGcwFaSjehgZDvWUe/OKTosZ3ISlgNvYybQHi/8jb5X08qEel/bscNAlOdAzsNdwT7knb5wbfxptuCPNcnuV4hajMFGeHd5popqXlSTBxNXM+QPA/RTklkR79D3pHrfOQxeb+BymfBRxC3sDIAB02HEXbRJi+oFK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X99aqFp2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779188619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RXb08deqJbmS1OubRYA6i/YgljNJA7lkuSyxZCr/zzU=;
	b=X99aqFp2cC7XSABi5MO4iiNsPhohy2ZoeltkWtxZSka3+06SAdeKvEqDr8Yrr+n5JXc3Ot
	JG/Pt5K3K/VEouCpkJctePxpNZvXKauokF5V4ERV8A3BlLgaWuOO0yP1EnC+eenpMkjqU3
	jQFAte67Vew6f0G1lgNc6IBFxa7xQHw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-EtFNG__2O06Nnvmf6QJHjg-1; Tue,
 19 May 2026 07:03:36 -0400
X-MC-Unique: EtFNG__2O06Nnvmf6QJHjg-1
X-Mimecast-MFC-AGG-ID: EtFNG__2O06Nnvmf6QJHjg_1779188614
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60E7119560B4;
	Tue, 19 May 2026 11:03:34 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA6A130002DF;
	Tue, 19 May 2026 11:03:31 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v4 0/4] cgroup: dmem: add selftest helper, coverage, and VM
 runner
Date: Tue, 19 May 2026 13:03:10 +0200
Message-Id: <20260519-kunit_cgroups-v4-0-f6c2f498fae4@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XM3wqCMByG4VuJHbf47Y+b66j7iAg3p47IyaZSi
 PfelECyw++D551QtMHZiM6HCQU7uuh8mwY/HpBpira22JVpIwpUACM5fgyt6++mDn7oIpaVBq2
 s4EAkSqYLtnKvtXe9pd242PvwXvMjWd5vicpdaSQYsJJEMyOZKgAuwZZN0Z+Mf6IlNdKNc0r2n
 CautRAyK3PKlfnjbOMZ8D1niXNbGAVaikqRHz7P8wcCW5p7KQEAAA==
X-Change-ID: 20260318-kunit_cgroups-7fb0b9e64017
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@kernel.org, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779188611; l=3416;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=n6BBrq+FrC4yrmdE/lDjXJKloZJFhROP8N/VMk0IHcc=;
 b=GBIB4rmj06pcr586fL9pr7XWioZVP5M/IHaf0TH4UuHDab6a3ZSsrc6twrB+WjXE1++DTou+G
 9qQoO1yPbElDlBIWTqp7BhrCp3380NnLwtyHfTd6n/3KEhslguH5L95
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16077-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmtest-dmem.sh:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6267D57D639
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
are driver-driven today, so regression testing is harder unless a
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
Changes in v4:
- Fix charged_pool leak in dmem_selftest_init()
- Replace ssh-based VM approach in vmtest-dmem.sh with vng --exec
- Add main() wrapper to vmtest-dmem.sh
- Other small fixes suggested by Sashiko
- Link to v3: https://lore.kernel.org/r/20260504-kunit_cgroups-v3-0-4eac90b76f91@redhat.com

Changes in v3:
- Set charged flag on unexpected over-limit charge success.
- Add CONFIG_DMEM_SELFTEST=m to selftest config.
- Simplify -v to a boolean; single -v was a no-op.
- Unquote kernel_opt to avoid empty-string arg to vng.
- Document -b in usage() output.
- Link to v2: https://lore.kernel.org/r/20260421-kunit_cgroups-v2-0-bb6675d8249c@redhat.com

Changes in v2:
- Fix debugfs_create_dir() error check
- Fix module teardown race: call dmem_selftest_remove() before
  uncharging so debugfs files are torn down
- Use IS_ERR_OR_NULL() in selftest() sanity check
- Add CONFIG_CGROUP_DMEM=y to the cgroup selftest config
- Replace config-file parsing in check_guest_requirements() with
  a direct check of /sys/fs/cgroup/cgroup.controllers
- Add new patch 4 (from Eric Chanudet): vmtest-dmem.sh -b flag
  to configure and build a local kernel tree
- Link to v1: https://lore.kernel.org/r/20260327-kunit_cgroups-v1-0-971b3c739a00@redhat.com

---
Albert Esteve (4):
      cgroup: Add dmem_selftest module
      selftests: cgroup: Add dmem selftest coverage
      selftests: cgroup: Add vmtest-dmem runner script
      selftests: cgroup: handle vmtest-dmem -b to test locally built kernel

 init/Kconfig                                  |  12 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/dmem_selftest.c                 | 198 +++++++++++
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   4 +-
 tools/testing/selftests/cgroup/config         |   2 +
 tools/testing/selftests/cgroup/test_dmem.c    | 492 ++++++++++++++++++++++++++
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 177 +++++++++
 8 files changed, 886 insertions(+), 1 deletion(-)
---
base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
change-id: 20260318-kunit_cgroups-7fb0b9e64017

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>


