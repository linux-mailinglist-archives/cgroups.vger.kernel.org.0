Return-Path: <cgroups+bounces-15586-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNpnMl9b+GnatQIAu9opvQ
	(envelope-from <cgroups+bounces-15586-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 10:39:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AAA4BA59F
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57FF7301913D
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2026 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F1634028F;
	Mon,  4 May 2026 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3yQTNMv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E13033EC
	for <cgroups@vger.kernel.org>; Mon,  4 May 2026 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883979; cv=none; b=IHWF02nVMu57iJsDF5KnX/CI/e1+raqhx5nRC4L9RdNsErViDFfcIIJ0FbTfE45bzKWJZZxKFHBQdWtHtWcp1ItcKZD0BRNNzRR6JJnNUxK9G/ToARj44XwhHoDlxHsSP0VD/r2g2ke2pbO0SO3NRVAElnj/v4bKRVZnaXFXYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883979; c=relaxed/simple;
	bh=yJ3isu6hXRqj3+UJugPSYKRTpH3FBi2ttz36cNQsA4s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TApdFkDcrDRg/IrDHYfpYASa2urOb1uecSLA40g+kXJivhfQu3LimBK9v46NCq/9ws/K+M4cjUOzGrOVjv/mtreJqraI5ArV+6Em051/2Q1zBsm7BWPBd6OPG120ez9am4CcCXpmjVFMAbJTPMpjeztHdbnjcBNUmlpUyhlLnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3yQTNMv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777883976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OXMJcNXcYKJnBsGpi0Xvu31OxRYiE4MQSQGjJq48ni4=;
	b=V3yQTNMvsj8jHDmMpnq/uuXf05hp+ZgYY7e9pXlKqNTjROfthl30imvUt45kGuiM+blLji
	6zU/8Wrvx3evXukoEiX5qHNfHbNc1WC7MN0sRFMfYgke5co0dTJzqn0B9NhnU1woD3b4sj
	4/CNaqTFde3zNKIFvnoN/37ccAeUj6I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-__1zxbWDP8Kwped1kdK_BA-1; Mon,
 04 May 2026 04:39:33 -0400
X-MC-Unique: __1zxbWDP8Kwped1kdK_BA-1
X-Mimecast-MFC-AGG-ID: __1zxbWDP8Kwped1kdK_BA_1777883971
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D26C18003FC;
	Mon,  4 May 2026 08:39:31 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 005351800446;
	Mon,  4 May 2026 08:39:28 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v3 0/4] cgroup: dmem: add selftest helper, coverage, and VM
 runner
Date: Mon, 04 May 2026 10:39:22 +0200
Message-Id: <20260504-kunit_cgroups-v3-0-4eac90b76f91@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13M0QrCIBiG4VsZHmf86tLZUfcREdO5TSIdukkxd
 u+5EUQ7/D54nxlFE6yJ6FzMKJhko/UuD3YokO5r1xlsm7wRBcqBkQo/JmfHu+6Cn4aIRatAScN
 LIALlZgimta/Nu97y7m0cfXhvfCLr+5Wo2EmJYMBSEMW0YLIGuATT9PV41P6JVirRX15Sss9pz
 pXiXJyaipZS/+XLsnwAQ6cvS+oAAAA=
X-Change-ID: 20260318-kunit_cgroups-7fb0b9e64017
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@redhat.com, Eric Chanudet <echanude@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777883968; l=3129;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=yJ3isu6hXRqj3+UJugPSYKRTpH3FBi2ttz36cNQsA4s=;
 b=sK5dMvKkXt9QAi5e9jaw4wYph84kRS8T20ZmztaVM+KpluMJrubB2s68y7EP5sHgQuFzLxR+m
 +cUSrU+rqX/DRNUPkT4fyzcyMI7B1+YFwHiCbZ9+kJj35uFxRtAKmxp
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 89AAA4BA59F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15586-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmtest-dmem.sh:url]

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
Albert Esteve (3):
      cgroup: Add dmem_selftest module
      selftests: cgroup: Add dmem selftest coverage
      selftests: cgroup: Add vmtest-dmem runner based on hid vmtest

Eric Chanudet (1):
      selftests: cgroup: handle vmtest-dmem -b to test locally built kernel

 init/Kconfig                                  |  12 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/dmem_selftest.c                 | 199 +++++++++++
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/config         |   2 +
 tools/testing/selftests/cgroup/test_dmem.c    | 492 ++++++++++++++++++++++++++
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 230 ++++++++++++
 8 files changed, 939 insertions(+)
---
base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
change-id: 20260318-kunit_cgroups-7fb0b9e64017

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>


