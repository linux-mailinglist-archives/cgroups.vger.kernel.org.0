Return-Path: <cgroups+bounces-15420-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIjdOj4m52nV4QEAu9opvQ
	(envelope-from <cgroups+bounces-15420-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 09:24:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED3B4377EB
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 09:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8669D3031B6F
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 07:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B863A3E87;
	Tue, 21 Apr 2026 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajukfVsR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE139EF2A
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756030; cv=none; b=XtaUkKN20XLif6LHRAU+Ii7a91YMLq2Sxv79udm1ybdn1gHJ22n4qwIQvBM5HimWKnTq1jHdscKVcvRe2AK16JOIX7CesUw0n5X7VpftCZfy77Utmel7MbQgwIA4nShHVZjrASK77knGZr4+LQB+a50Xoy3/B9pHBfbgB5HszFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756030; c=relaxed/simple;
	bh=BZ2AunLdNbPVhERPo0uKCewyTQ3NmKL+DTJFDGx5KEg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JE3XpIq1AXaSxOz283csM5Ubza99jzqD0ESObosZ5PZhEaLcqPW5xEMhXTvLBJ+0jy3TQoS7LuTPC2VM6uqSCxSIbr0Bv5y13qs0ejv0PTHuFfUGbxWhERzrI6xGbh35GwXFwN+hYn62odY2qliE8A4W/HypL3OzFuB1gGCU69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajukfVsR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776756028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZF036EXcXXO3sY+n5l1QRXR2i08R4oiTYTb6LgXxFQM=;
	b=ajukfVsRAy+QlaAMBa8Da7/Xmzx0RYi5KAqGpxiMNC12VR3TBD7LExYcbdJOed5FRuKNrV
	oF1i2JQJGnYPQkB/XzLlWhmqKx1GmE6CibbBTxn8iM1NxrNFmR5a9B+ZuVWN9/eCnqPuyO
	p+RZa+LkSdFKkIZDOk+DQuuxluYNPY4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-sdmzgtJcNLut9r8ukKPwjA-1; Tue,
 21 Apr 2026 03:20:24 -0400
X-MC-Unique: sdmzgtJcNLut9r8ukKPwjA-1
X-Mimecast-MFC-AGG-ID: sdmzgtJcNLut9r8ukKPwjA_1776756023
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67F1D195609D;
	Tue, 21 Apr 2026 07:20:23 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3B35195608E;
	Tue, 21 Apr 2026 07:20:20 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v2 0/4] cgroup: dmem: add selftest helper, coverage, and VM
 runner
Date: Tue, 21 Apr 2026 09:19:46 +0200
Message-Id: <20260421-kunit_cgroups-v2-0-bb6675d8249c@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQ6CMBCF4auQWVszLYaKK+9hiGnLABMjJS0QD
 endrcSVy/8l79sgUmCKcCk2CLRyZD/mUIcC3GDGngS3uUGhqrCUZ/FYRp7vrg9+maLQnUVbU3V
 CqSF/pkAdv3bv1uQeOM4+vHd+ld/1Jyn9J61SoKi1tKXTZW0Qr4HawcxH55/QpJQ+5sITTasAA
 AA=
X-Change-ID: 20260318-kunit_cgroups-7fb0b9e64017
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@redhat.com, Eric Chanudet <echanude@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776756020; l=2765;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=BZ2AunLdNbPVhERPo0uKCewyTQ3NmKL+DTJFDGx5KEg=;
 b=dHyjmsXlsVNAM/u7xpOKHvuGyAfLWZnP9qONBtp8HUx0ciU4aHQKlsVLYhNktMYqn2q0EPt4h
 qmsEsU9WjxvB0CMrjx5j5/lq4wdRzev8poiqjOboJehdJ6sJ1a7nioY
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15420-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ED3B4377EB
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
 kernel/cgroup/dmem_selftest.c                 | 198 +++++++++++
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/config         |   1 +
 tools/testing/selftests/cgroup/test_dmem.c    | 490 ++++++++++++++++++++++++++
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 229 ++++++++++++
 8 files changed, 934 insertions(+)
---
base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
change-id: 20260318-kunit_cgroups-7fb0b9e64017

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>


