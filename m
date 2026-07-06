Return-Path: <cgroups+bounces-17532-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TBsLGaGdS2oyXAEAu9opvQ
	(envelope-from <cgroups+bounces-17532-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 14:20:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56354710723
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 14:20:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GacUHo+M;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17532-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17532-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3535304C19A
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EAF423795;
	Mon,  6 Jul 2026 12:07:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF30424647
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 12:07:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339649; cv=none; b=SsMk3aPBUokCGezM4laxqfF/72LxLkp8tnQps9Wdt9DzKVQn8tr6vz0COuZ/sDqH6PB0fgsuKd3+C38RTg9OarhwHCBoHmpXhn0KJKTZ+j8cTkRZ2NhQplGcx3kaQYsUkaLrWNQeRZ12TXvmlSwruuimegin2cZsnWWPr+hDVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339649; c=relaxed/simple;
	bh=apTiBjcxVK24LBvkYWNEBawfEW1dEeAN4dJhk3rDuQQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dMvwUha5+iYwAVcf3wUH2m3SH/nip1Fjk++xhvVB7guziSG2fifEpnEeDUuNYUOY9nXOoHtV6cZQeA9qEG8TWIUH7RKSH22v8xlqHnBQHCRTIk1Q66qvCqELHxOHjsAupDGMn9QJ5LRhDLOjyN4MpbPUCLA5IPLn2dDQNNJeEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GacUHo+M; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783339647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IpTCLpoP72HvCckwdmId2yggkVlEZn3IaRv8GeRmMF8=;
	b=GacUHo+Mg/fKnPe1znSRDrbyWZl7r0nrTbuTZ7cadwr40jrIfxnmDSyMAEWFaRjj42JCZx
	+ddYZnY+lp9lIl5LfIfPQgYEBT560qPw9Gjcs9AlDCLMi1Jf/mFO322msaLXjOJ3P7adMG
	piLzMxF9E9uEaNkDsdeJBZ2pM1ahw0I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-7DdviG42Oc-H-9yD8dCJ2A-1; Mon,
 06 Jul 2026 08:07:23 -0400
X-MC-Unique: 7DdviG42Oc-H-9yD8dCJ2A-1
X-Mimecast-MFC-AGG-ID: 7DdviG42Oc-H-9yD8dCJ2A_1783339642
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47C1E1845449;
	Mon,  6 Jul 2026 12:06:57 +0000 (UTC)
Received: from [192.168.1.153] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBEC918005B7;
	Mon,  6 Jul 2026 12:06:54 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v5 0/4] cgroup: dmem: add selftest helper, coverage, and VM
 runner
Date: Mon, 06 Jul 2026 14:06:39 +0200
Message-Id: <20260706-kunit_cgroups-v5-0-6c42c8753468@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XM0WrCMBTG8VeRXC9ykpwmjVe+h8hI0hMbxlpJa
 nFI390oA7d6+X3w+99YoZyosN3mxjLNqaRxqKP52LDQu+FEPHV1MwlSgxIt/7oMafoMpzxezoW
 b6MFb0gjCsGrOmWK6PnuHY919KtOYf575WTze35I0q9IsOHBrhFfBKOsA9pm63k3bMH6zR2qWL
 45SrLms3HutTdO1Em144+rFG8A1V5UjuWDBGx2teOP4hwu75lh51EFGtG10hP/4six3q0N5CGg
 BAAA=
X-Change-ID: 20260318-kunit_cgroups-7fb0b9e64017
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 Eric Chanudet <echanude@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783339614; l=3898;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=apTiBjcxVK24LBvkYWNEBawfEW1dEeAN4dJhk3rDuQQ=;
 b=iNuQ+fkdHFGf+OxI55Em3l9TA/NkJppdKoCSJigqbMbuNGI9lFETUPPtJvPC6OiMNG8lgoc8d
 HEwBO0B9bzDBtRdkHpsRSD+0wnbjsr6T2g/g/fHi9CudW58wdL6iKNZ
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17532-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:aesteve@redhat.com,m:echanude@redhat.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmtest-dmem.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56354710723

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
Changes in v5:
- Change parse_first_region() by find_selftest_region to scan
  dmem.capacity lines
- Use exact equality for limit readback, not values_close()
- Write VM tempfile to $SCRIPT_DIR
- Fix KTAP by dropping outer framing in test_dmem
- Use array for optional vng args to handle paths with spaces
- Respect O=/KBUILD_OUTPUT= when building, per bpf/vmtest.sh convention
- Link to v4: https://lore.kernel.org/r/20260519-kunit_cgroups-v4-0-f6c2f498fae4@redhat.com

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
 tools/testing/selftests/cgroup/test_dmem.c    | 486 ++++++++++++++++++++++++++
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 188 ++++++++++
 8 files changed, 891 insertions(+), 1 deletion(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260318-kunit_cgroups-7fb0b9e64017

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>


