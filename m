Return-Path: <cgroups+bounces-17782-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LwD9Lc5IVmpY2wAAu9opvQ
	(envelope-from <cgroups+bounces-17782-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:33:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41164755E17
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:33:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=fHw8f9x8;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17782-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17782-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD5F23089315
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6109A47DD63;
	Tue, 14 Jul 2026 14:29:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25DA47DD40
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 14:29:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039377; cv=none; b=a9b8VqZyv+novcxZYDMyzXY2nCw1vE8jLPSTVYrwElC/7ITFYcKl63Rct46WA7wb+OoVK1IswpW5KoC+qDbFbqslQODeSkaWIVS4hzuITrGE8paQJkUMitdo0ft6nzT/fM56EQijHJYdD4qFXGDpMvCz+3At4SmQzIXruQX5VgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039377; c=relaxed/simple;
	bh=HV4KXx3jCDo5tnyS2SR083CFGU4A98rHzoR25fN+NeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5ZXO3PfOM068/SW9XWXK02dGMW7rBzjaXr1uFWbDb0x/svvTkVo60W3PneGlMMovLD7kCM8LvDZvDw7G0GRwaoQhUmvG+iGMxI3NIcPXNEX7ZvtZYvWHI8fvhws0hXyNcMZmayyIxH07O1jPtwgcqFqk7eYguarx/25KJPSgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=fHw8f9x8; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so7054825e9.3
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039371; x=1784644171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nvrKYD5ArwJczv3P3+Ce5/GBU6hZFow7WIOmjK2Noeg=;
        b=fHw8f9x8RZOOPQd8Mm2kUYt4NWzctTLq5X2G/diUH3e100eOXh2xfWHZC3lMNsx2Xl
         FbHBTlfuqaVpv2pAX5O0iXv/ivF0qRh6D4/xBC1qfrSPafw2ykft9iy4nAitxLt9VFn2
         +VcUlbWF/2sg7v3RViTMXZMVlHDYt0BdhY7bFIYOrVcGv3JUF5qFn524qP9RJm92lZ2q
         oTeXvc80c5HvgK7A4q4tlRkcAcxcwuejvsEgKMP1HufBI3gnJvqcg0gKx2SggDVQ74FE
         m4Zux397TbjkfELO+lLOP91U2j2ysQ1gdg6q/QFv7IYn9N9ps20LShRH8GY5it15bbgR
         ksig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039371; x=1784644171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvrKYD5ArwJczv3P3+Ce5/GBU6hZFow7WIOmjK2Noeg=;
        b=so+xvfT5zrmROfQvdeMAaK6iqVNj5DkBErPbg6jEsKb0b1TfQjf5oZESS57OKCl+ZF
         i5gKDPEa87HNtu3mZGm9AQvHTV5Rj3bACbRW6KgzLj8j23HGupE0+dfcpyShHpDGm4Qo
         XOLg0ck4BDgVG0k+PbpS0T8ARxrb8ewdhC8fEuSOE4WzSReNMGOnK7J3k9dHofE3018S
         vATbzFzg8wARnLS+ywipaQWHmvaoiUiA2p7GW/PyoWwW3nlYTDm9pRBCG6rAHKNJ+3Y1
         pKcb7ZG08L/J7XPbHb2itaYoeBFb4mqRG3lr3+mjD6If0e2ET2TZrOdhcA2cv8gBbmhV
         q/JA==
X-Gm-Message-State: AOJu0Yxqji7R1lbZ3ku8SV8wg7KCtShz4lapke8i8yxU/qD6DiqM60hW
	B3b2d+10XyiWZ/2Bm1hwyRjg9XFipd9a4gLaBGwCedp1//ycO+uS42kkY5kMaplpxl0=
X-Gm-Gg: AfdE7cnp6wg9tVPymnQZ0wDeuY5FQEGMEsWQoms0vlXaXVnNZR3f5aR6xJDaxew6HqX
	GO6Y8notB+T7fjXxlrkMgEw9tJHxrdwwzbymBHM296kGn1myr5JAr+7lKuTeE5bfxgNAVS1K1WI
	wIg+PN31H+sbf+Bltu/5md0tp6I1+Ub66zzpTVQOWyW3Y21PM299QbUGjZA9KE7k73AypynoaXq
	qgT+DxQ5evT7UqDVU/ikgDvlM1EX6jJVRopcrQiwTjtLT0nFBvK6z2oxTCqZbNJuKEDfyzCAB0Z
	FLSLTHCDgTH9gYjIJ7PqLA+Q5uPAEhZcNbuAmSl0VBtshRKZZQUnJI3NAT8jYN8cP0FjESrrcLI
	2XHOfUNFdthkcRNlXq+q6vOPPaamB15mKWuQsPVyscHvZf55jE2GukmdavRIyWa2643++hB4Q/+
	yxiwvKR3nwQ09xEsz1JrgQNg==
X-Received: by 2002:a05:600c:8108:b0:495:39a9:f8bb with SMTP id 5b1f17b1804b1-49539a9f8cbmr17623035e9.27.1784039370894;
        Tue, 14 Jul 2026 07:29:30 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49506a1fbcesm81645145e9.0.2026.07.14.07.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:29:30 -0700 (PDT)
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
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v2 00/14] RDMA: Make device names unique per net namespace
Date: Tue, 14 Jul 2026 16:29:13 +0200
Message-ID: <20260714142927.1298897-1-jiri@resnulli.us>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17782-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:yanjun.zhu@linux.dev,m:cui.tao@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli.us:from_mime,resnulli.us:mid,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41164755E17

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

Jiri Pirko (14):
  RDMA/core: Pass the net namespace to the device name lookups
  RDMA/core: Handle device name conflicts when changing net namespace
  RDMA/core: Support renaming a device when changing its net namespace
  RDMA/nldev: Report net namespace move errors through extack
  RDMA/nldev: Allow setting the device name while changing net namespace
  net/smc: Look up the pnetid ib device within the net namespace
  RDMA/srp: Make the SRP sysfs class net namespace aware
  RDMA/cgroup: Disambiguate devices across net namespaces
  RDMA/cma: Document that CM configfs cannot be net namespace scoped
  RDMA/core: Document the SELinux ibendport net namespace limitation
  RDMA/core: Make device names unique per net namespace
  RDMA/rxe: Allow queue VMAs to outlive ucontexts
  RDMA/rxe: Implement disassociate_ucontext callback
  RDMA/selftests: Add rxe_netns_names test

 Documentation/ABI/testing/configfs-rdma_cm    |   4 +
 Documentation/admin-guide/cgroup-v1/rdma.rst  |   8 +
 Documentation/admin-guide/cgroup-v2.rst       |  15 +-
 drivers/infiniband/core/cgroup.c              |   1 +
 drivers/infiniband/core/cma_configfs.c        |   4 +
 drivers/infiniband/core/core_priv.h           |   3 +-
 drivers/infiniband/core/device.c              | 245 ++++++++++++---
 drivers/infiniband/core/nldev.c               |  26 +-
 drivers/infiniband/core/security.c            |   6 +
 drivers/infiniband/sw/rxe/rxe_mmap.c          |  35 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c         |   5 +
 drivers/infiniband/ulp/srp/ib_srp.c           |  16 +-
 include/linux/cgroup_rdma.h                   |   1 +
 include/uapi/rdma/rdma_netlink.h              |   5 +-
 kernel/cgroup/rdma.c                          |  71 ++++-
 net/smc/smc_pnet.c                            |  20 +-
 tools/testing/selftests/rdma/Makefile         |   3 +-
 tools/testing/selftests/rdma/config           |   2 +
 .../testing/selftests/rdma/rxe_netns_names.sh | 282 ++++++++++++++++++
 19 files changed, 653 insertions(+), 99 deletions(-)
 create mode 100755 tools/testing/selftests/rdma/rxe_netns_names.sh

-- 
2.54.0


