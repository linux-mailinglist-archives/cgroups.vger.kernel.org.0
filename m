Return-Path: <cgroups+bounces-17603-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aL5hCllxT2pFgwIAu9opvQ
	(envelope-from <cgroups+bounces-17603-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:00:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B691F72F40C
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:00:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=tVF77iwP;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17603-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17603-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2618B3029E49
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01B401A08;
	Thu,  9 Jul 2026 09:55:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0333F1670
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 09:55:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590939; cv=none; b=NxaeTi2JulEvU+gfPlSDt9e4h3JqLSFVnuCq6TyQ1yVrhWn74/VCWz0ECiRzqbtnM/PdTWUGiVN/EJVuQ3yWwfpnyUU81wA8/s8a6PcXoxaSPy4UzwL4V7J9v9gDIcn5JPhfsBXBcmLU22uuLBS3iN4aOzmTjGa8a6CTeiZlyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590939; c=relaxed/simple;
	bh=6v4UEKMGI0CObOrgOsS9xS28THfpqNdtIwk41b4i1C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWtZfK+eKu2rT+6rXGcJrCTyULeQCvPBUOryHtefFhCRyhAz5BQQHLqqe+qR21y6/1D4m29Zx4X9HjSHe/rKwOq3kRnh6PfkSw8iYBO/pg0GvYrhFp5esEuX3qWC58UWbfbeovyIfMsmLFPB95vM38ED5LYO/+QmaPBFoIHem30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=tVF77iwP; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so856457f8f.3
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590936; x=1784195736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FmCpTn/G1BPPqIynBfpobYxeMvV2yASv7FeNNa9VjUc=;
        b=tVF77iwP1Ox/DAzUEBzdrOQ8mS6gW+oByL/ghjEynEnKN+tjSSSmc/M0RT+qrXQZHw
         BRK2YhNV4rAqY0PimJRQCX6t8kyx8IRm8j/r/EjpwWFlBCfKAA80psHboQv/KKdI+gH0
         s3UCnon8+ODyAp+fSGaZvODXKrsZDAW/CCxPZXI9Hgv8bZzhHCPUO45d1tv9RaHr4AaW
         tbhz/uwntIp7F2ELvMwIrVNi2xcK9mQM1TKCMW+TWnSCf6sQaCNvg0GIP5jMsBlLE2r4
         iEM5JeRYs6GXj2Wn5/us9A8wLGK1WrOYWk0CkwmWAsA2zt4CFHNK6Cy4qw/ndvMj1iOU
         MvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590936; x=1784195736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FmCpTn/G1BPPqIynBfpobYxeMvV2yASv7FeNNa9VjUc=;
        b=VtHFP+ecGOH5JqxBle1AfjUYNzmQABsOD/tqBiZpnLSgsRzDcTmophF0yX8Sp09jxZ
         TWaHNO+ziPtCx4uGEOqMQQH2OovDbe8MpJG0uOy6A3q+q2D1Cv9L1JaDM05DX2PUk/aU
         8z4klzL66Tv820vLeSbdaqzjy/zReEGO+sKU8vCUpno38tXybdq755jA/WYWMygoVeUM
         VRYj1EcpqTe5Ho3K5G+Dwlngnzg5HK8hDywrOBEoSOfz2QFIt8WeiIMNxEvbiZPuHOcU
         P/SUZcuK5SSAU34jnsGxbojrKHEDFNTTOTN6qMWDeRggzHgQlkWcq1FTjb53R4h4jqAK
         jWRw==
X-Gm-Message-State: AOJu0YzV8U1M4aw1w1pNyxjGaFRkmSVmOLC7bsHEKlDVSNNOTctyAG2i
	nt/W+l3PA0IGdMl++pJOIRqXAITLFRPPV32pgTPUtqB0ZatbSbV9MNIxYiWHx5AO404=
X-Gm-Gg: AfdE7cnc7XXKUto4b+lUft4lxku+pHJjtDCZC2rOLSqdsDZcO6suwIz8ePggDQu3MyZ
	5ukdnrDlVmZ0HGrKxrVlICoA1pU1eCpXDyiqSVH+ftRv2KByciSr24XJoPNFBEXu7k+pqCzIjuY
	p4aqjMCNWto1Mx+ZxCQB8FG5u0jqagj/UWkESEEwutYSCeDIilGhsnApX38+/fY1e4EabJdgBKt
	fFfrsM7Zt/8/KQrRnPP9NcXfhITTzgrvvr+B2jS7VfL+ZGS4/EsD52kUNsG4Zu3QHTu2axixwL4
	wSquZQtYOAUgXV2wKQhotyQzQ/MSKpi1WcsFnoQ/ULrL1SxWVDCVBEZBp6bnym7/QhlQcmmE8mA
	i/XcKA2WZOOD6ehiuxvDinKk+qfjtBhVfLQ3aTkvYwLGXA2fmhr2AYxRdlIAJ6rPrpVkXb5DTZb
	E7d7rv2vKglmde4oyCAH9Fbw==
X-Received: by 2002:a05:6000:144e:b0:47d:dfea:f729 with SMTP id ffacd0b85a97d-47df07a18bcmr7413288f8f.4.1783590935982;
        Thu, 09 Jul 2026 02:55:35 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47df6a31dd5sm5243415f8f.16.2026.07.09.02.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:55:35 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Subject: [PATCH rdma-next 00/13] RDMA: Make device names unique per net namespace
Date: Thu,  9 Jul 2026 11:55:19 +0200
Message-ID: <20260709095532.855647-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17603-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	FORGED_SENDER(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[resnulli-us.20251104.gappssmtp.com:query timed out,nvidia.com:query timed out];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B691F72F40C

From: Jiri Pirko <jiri@nvidia.com>

RDMA device names are unique system-wide today:
__ib_device_get_by_name() checks a requested name against every
registered device regardless of the network namespace it lives in.
A device in one network namespace therefore cannot use a name already
taken in another, even in exclusive netns mode (netns_mode=0) where
the two are otherwise isolated. Net devices have no such restriction -
their names only need to be unique within a network namespace.

This series makes RDMA device names unique per network namespace,
matching net device semantics, and adapts the users that assumed
system-wide unique names.

Scoping reuses the existing rdma_dev_access_netns() predicate, so
behavior only changes in exclusive mode:
  - shared mode (default): names stay unique system-wide, no change;
  - exclusive mode: names only need to be unique within a namespace;
  - CONFIG_NET_NS=n: everything is init_net, names stay system-wide
    unique.

There are two users that cannot be made per-namespace and are
documented as known limitations instead of changed:
  - the rdma_cm configfs tree: configfs has no network namespace
    support, so it cannot represent two same-named devices;
  - SELinux ibendport labelling: endports are labelled by (device
    name, port) from a global policy; distinguishing same-named
    devices would need net namespace support in the SELinux policy
    language and tooling.

Tested with the new rxe_netns_names kselftest added in the last patch.

Jiri Pirko (13):
  RDMA/core: Pass the net namespace to the device name lookups
  RDMA/core: Handle device name conflicts when changing net namespace
  RDMA/core: Support renaming a device when changing its net namespace
  RDMA/nldev: Report net namespace move errors through extack
  RDMA/nldev: Allow setting the device name while changing net namespace
  net/smc: Look up the pnetid ib device within the net namespace
  RDMA/srp: Make the SRP sysfs class net namespace aware
  RDMA/cgroup: Scope rdma cgroup device visibility to the net namespace
  RDMA/cma: Document that CM configfs cannot be net namespace scoped
  RDMA/core: Document the SELinux ibendport net namespace limitation
  RDMA/core: Make device names unique per net namespace
  RDMA/rxe: Implement disassociate_ucontext callback
  RDMA/selftests: Add rxe_netns_names test

 Documentation/ABI/testing/configfs-rdma_cm    |   4 +
 Documentation/admin-guide/cgroup-v2.rst       |   7 +
 drivers/infiniband/core/cgroup.c              |  12 +
 drivers/infiniband/core/cma_configfs.c        |   4 +
 drivers/infiniband/core/core_priv.h           |  15 +-
 drivers/infiniband/core/device.c              | 256 +++++++++++++---
 drivers/infiniband/core/nldev.c               |  26 +-
 drivers/infiniband/core/security.c            |   6 +
 drivers/infiniband/sw/rxe/rxe_verbs.c         |   5 +
 drivers/infiniband/ulp/srp/ib_srp.c           |  16 +-
 include/linux/cgroup_rdma.h                   |  10 +
 include/uapi/rdma/rdma_netlink.h              |   5 +-
 kernel/cgroup/rdma.c                          |  20 +-
 net/smc/smc_pnet.c                            |  20 +-
 tools/testing/selftests/rdma/Makefile         |   3 +-
 tools/testing/selftests/rdma/config           |   2 +
 .../testing/selftests/rdma/rxe_netns_names.sh | 282 ++++++++++++++++++
 17 files changed, 639 insertions(+), 54 deletions(-)
 create mode 100755 tools/testing/selftests/rdma/rxe_netns_names.sh

-- 
2.54.0


