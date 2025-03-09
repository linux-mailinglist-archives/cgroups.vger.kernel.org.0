Return-Path: <cgroups+bounces-6903-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA84A5843E
	for <lists+cgroups@lfdr.de>; Sun,  9 Mar 2025 14:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038663ACBA3
	for <lists+cgroups@lfdr.de>; Sun,  9 Mar 2025 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC84E1DC05F;
	Sun,  9 Mar 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EwEG3bY8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6B1D8A0D
	for <cgroups@vger.kernel.org>; Sun,  9 Mar 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526981; cv=none; b=IpgbP21kBXermamc/EMo6pFK7stAuF6f0mZVl5OXTS4+CFDRO4ojiLs6U0bgL2z+N99ywm5M3q1yo8Fs6R+BK4IyC5WuhPmnsalC5yDirrMn8pxWv22BTffb/Bc3LowklmT7EN3kDExxmnEmqPmUEmJX4MT1fry69Xmsa1W64K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526981; c=relaxed/simple;
	bh=BFBez99hJQWF8yQf0dUSZg1LTudTSAcMT/T2RWUc2CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i9ffX2FLBX80j3/NtckjxBTTJFg/dsGjkmdWBiJXiip4yLhfK3yfGZcRK84pG+erSX+WmjmWyB1gJ9nLInDqf93VdanfhJeH1P6HIPX2IFMaA+J8ECHdHqJ84+cFjCva7cBD8YQWzpFqgX0CwwqWra4+xpbkJSUMzdQJ2X36M8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EwEG3bY8; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DAEE63F869
	for <cgroups@vger.kernel.org>; Sun,  9 Mar 2025 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526976;
	bh=mqFbLsvDYgZMcATbnfiiqW+yfZu2sdh4iXGZzYCmKWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=EwEG3bY8PoFwKAJrElrgPsV8oM3u4z/j+kr6bEwMnyrTmXmJQf2Ft3raQvdWeYlOc
	 TC50RgqmyK+93mh9VD864wLit07eugfcN0d6+WEUsQUUePSD8MEOW77Hx+t/Xw/QeX
	 C32anb3Z7zJbqeF4FJwV1oUaMXX80HyvE18jyAIrjyBgJgt8CPTF2DJh38C0DGcYb/
	 QXW562ZwKSTzzXIGqCGb6+F/33k9cAIXPZpN5dUENuzmGewQ3lF9Jg+uq6SOkwy0Vm
	 8aUNK3aLaIjRWW8R83FnYRqYHoPCQSDHg0zcD6WKJxO5ym6BUuPLsX+7rv4C813Wa+
	 HjII/VD3yktFg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac297c7a0c2so19229066b.3
        for <cgroups@vger.kernel.org>; Sun, 09 Mar 2025 06:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526975; x=1742131775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqFbLsvDYgZMcATbnfiiqW+yfZu2sdh4iXGZzYCmKWw=;
        b=aT/mAooXX3nJW7VCpsngpz7gn29dm1bjah4oC4YByA/3aDlLjMa+Gnn8SdDcqAiuT6
         hUrjfK9CjHeGJI/pXlBGB4WKS5eHSYEkNV8hk7ahtxMuNNdyOgh+TScA/n7aWaq77TUh
         Evg6NZorcg1Iz4EpHAQjEDKzRfGEyYLyj1d+AkprRy1oncdP64wdB3kObztjkoMYG4+D
         1vdjeMKntVrsEBHPTuUYwqBK2xafCgLtfnys36n06l5DRD+6WBy/jMXgm1p4fu5GyOIc
         WfUMJcJtGx6YGqc778b7H0A+gDRCKmZ8vXB6C8l32aKoTozLTXarUV3Xf+82bMEBduqU
         d2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVJiYZH+RsqneU9rriZ+QFLNWVZ+SOow6DVk6EgRLYBdaw1VLhGzzybwn5MpY3eE1BmXDsYPOy/@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtWBUwv1G49gueqt0CoC/R2i1n6nAN0wPVNg2HJNDTiT3LtyP
	+Hj0+jSVwmmTHse2MCrbMroM+5Uwqav5CZusVXAzAfJHjSaQ4NZSQYExwl54uSHqtYEcXDabfvd
	nIyKhsrKFPT44SsCruGI/YstnPzkrzA5qY/3gAKU4dKyYR6Xc7fpo3pCXXfxtxNTvapoB0tY=
X-Gm-Gg: ASbGncs8SG/lGVJaG0/s3BEjUp2wQ6qmUnoNyNQoRf98fSyxfHBjhamqgPrA1JOS+GZ
	ljoWaTMr3I1HJ4mHTXbjFdoiJ5Xe2RMamREt7XD2a9rOzDfsm+hAwc+c3Ve70g/vIE/Q1nBeA1C
	upaa5svBRqNYxE/1UrsBsFVlOXSP78HubwNeCuHUtK1vVItdd5OjlfePI6M5Si/2gs+0Pz/xPI3
	IK0WJaTAdnbrxFGyFQXOIziX1kPGpDGyenj+RvUI4xtL4GHdXSGFbcu2uch6RJNjxPwWXAthlXH
	Nj2ng2IJqtG/rBwKQZG+6N6LWKDfxhdJ3lbk8mVKg1ID4SUm8MNt8I4txi50GxB2HcKLEA+Ebo0
	2jBu0XH3M5q8GObKDOg==
X-Received: by 2002:a17:906:c514:b0:abf:4e8b:73e with SMTP id a640c23a62f3a-ac252e9cd5bmr962215566b.39.1741526974742;
        Sun, 09 Mar 2025 06:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWUIep2IRy9s5FbXJl+MjjuqqYaufw0PZ6Ppq51ixYq/v5+9VpIwIXq+cg1UIFg1fYCs++7g==
X-Received: by 2002:a17:906:c514:b0:abf:4e8b:73e with SMTP id a640c23a62f3a-ac252e9cd5bmr962212766b.39.1741526974364;
        Sun, 09 Mar 2025 06:29:34 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:33 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 0/4] Add getsockopt(SO_PEERCGROUPID) and fdinfo API to retreive socket's peer cgroup id
Date: Sun,  9 Mar 2025 14:28:11 +0100
Message-ID: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

1. Add socket cgroup id and socket's peer cgroup id in socket's fdinfo
2. Add SO_PEERCGROUPID which allows to retrieve socket's peer cgroup id
3. Add SO_PEERCGROUPID kselftest

Generally speaking, this API allows race-free resolution of socket's peer cgroup id.
Currently, to do that SCM_CREDENTIALS/SCM_PIDFD -> pid -> /proc/<pid>/cgroup sequence
is used which is racy.

As we don't add any new state to the socket itself there is no potential locking issues
or performance problems. We use already existing sk->sk_cgrp_data.

We already have analogical interfaces to retrieve this
information:
- inet_diag: INET_DIAG_CGROUP_ID
- eBPF: bpf_sk_cgroup_id

Having getsockopt() interface makes sense for many applications, because using eBPF is
not always an option, while inet_diag has obvious complexety and performance drawbacks
if we only want to get this specific info for one specific socket.

Idea comes from UAPI kernel group:
https://uapi-group.org/kernel-features/

Huge thanks to Christian Brauner, Lennart Poettering and Luca Boccassi for proposing
and exchanging ideas about this.

Git tree:
https://github.com/mihalicyn/linux/tree/so_peercgroupid

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Shuah Khan <shuah@kernel.org>

Alexander Mikhalitsyn (4):
  net: unix: print cgroup_id and peer_cgroup_id in fdinfo
  net: core: add getsockopt SO_PEERCGROUPID
  tools/testing/selftests/cgroup/cgroup_util: add cg_get_id helper
  tools/testing/selftests/cgroup: add test for SO_PEERCGROUPID

 arch/alpha/include/uapi/asm/socket.h          |   2 +
 arch/mips/include/uapi/asm/socket.h           |   2 +
 arch/parisc/include/uapi/asm/socket.h         |   2 +
 arch/sparc/include/uapi/asm/socket.h          |   2 +
 include/uapi/asm-generic/socket.h             |   2 +
 net/core/sock.c                               |  17 +
 net/unix/af_unix.c                            |  84 +++++
 tools/include/uapi/asm-generic/socket.h       |   2 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  15 +
 tools/testing/selftests/cgroup/cgroup_util.h  |   2 +
 .../selftests/cgroup/test_so_peercgroupid.c   | 308 ++++++++++++++++++
 12 files changed, 440 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_so_peercgroupid.c

-- 
2.43.0


