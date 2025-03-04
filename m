Return-Path: <cgroups+bounces-6801-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E82A4D6BD
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 09:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF1E3AADC8
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711851FBCBD;
	Tue,  4 Mar 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YX2V8HV3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02F1F3B8B
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077673; cv=none; b=FqtJgXKldcxdPWs9nSrGAof3qoQs3QRs57k5zTc8k8TvmojkAw8ZhiBS3Z8oHoNZqEDNXnJO4uzCkxad/dWz0JBg6bZpYZdun07ny0qM+K9x2v7cQI4QvNrGwQMsmtz4KErKtDXwMInoC87/lEKfu+TtxPxlAaaxuvUYZScBCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077673; c=relaxed/simple;
	bh=TLYb6ifcofavLxHlAL0UmIuoJWOOBMKLI8mICFqhYCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCjwbGTp8uWe3Mj8c9SQOc7loOfqKrsRXjTLV5NGHNhnzY+vnpF5TJ+CuX8V38ubVX6QqgHLRv3lnfKyj/IoV/U6jWLKZFqCCNH4YxWVkQVYyW/iIZAAdSemPN28U+6wxQIdWhgXUCkchAIaPnt2oa9nQZbDgiW1HGOniVBdf7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YX2V8HV3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741077670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z3fYeTIzRI1z2TyRGuHxMSN4hiWg6QuoQU8pwKzI3WI=;
	b=YX2V8HV39aOeBe6tNYCNRAjBYH6EQ9GSnzLgYKvyf6kh9on23Zz/oitLlhc9EWzfzpwIr/
	H/jWycQuwzCs6RMbYR6qDlBQ02cnZwWRauoE4bJz1Gh074WnZJOyaNqN/scz74mZRKJBR6
	hZ7IdpQYyMRApQ071ltsQ/MbyDRZ6uI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-oM4FNMJzNHuY_74DZLS5nw-1; Tue, 04 Mar 2025 03:41:08 -0500
X-MC-Unique: oM4FNMJzNHuY_74DZLS5nw-1
X-Mimecast-MFC-AGG-ID: oM4FNMJzNHuY_74DZLS5nw_1741077667
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0a71aaf9fso799379385a.3
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 00:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077666; x=1741682466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3fYeTIzRI1z2TyRGuHxMSN4hiWg6QuoQU8pwKzI3WI=;
        b=gZx39PBaaZ1ICHoDJFB8m9/ckowT52RHWQXBG7KwC1yqJ/QbAx9apjdWaMEzLi4YtH
         pFaVGhDwNEk9RK3CZsmXMD6mg1hd35AjzMr9H/53oZ0V/2J8XJ3BH7rj92xXOAiO6K+a
         zNfph3ppfPu1kW1YzfjJ16XyY5vuxHn8lROpXLOCW98gr2FCKrTPT2illUcXAxq401fJ
         GoEv/W2fmaF/UxJzIA8qNbZdDe9tRSh1gQilv96jHED0hr+yn1lN8nTYwNZhH/HFlGv+
         pWex5O0C0SWRFX17CJ5vSQmrlji6pu0d9T7nHZcZiNlCoEts57IrNBvo/xCY7Qho7VP/
         PLdA==
X-Forwarded-Encrypted: i=1; AJvYcCWK1J26z3MvVSgQG0ExEJgTbU5moGKbM4wJlQ78EKvkLHHBk3xDjjtkEl2HiT6X95oIgCT6zi5d@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsjodwJCxRqj9LKy/nVpj5PH0teyypG8X7Wbz/u/qBXmtf8tU
	/DDwIylsiW9cLc3wr2AbY7N5Q6LXVaJaFNY7XeBLrOVjTE6cTz2bHbI9obGGuMgodqnknFMhbx/
	bli5/0qdQClT9wux8mC5WMBniAvAHnbU1TsBY5Zx61pmUfCalvYHdwsg=
X-Gm-Gg: ASbGncv7Yo3n1dr/Xs84l0M5odZSBr/tJBeZ/u9fYWSc9FWey1IeOUfk6+4OXm9g7Xw
	PPyldlcyO+Ql/93X7Fq2oyz9/b2DLuGeBTImE0Xg6j4Et8WB4T8daTASySpemp3lNtyi4GIxGmF
	3lYgoPQXaSP1DGRomlqmOgYxKgRgYXBwXfrwifOm/hHw4WCW8poA2EzQKX/Mn+00qrxUJrouD9d
	zOCGn1aRALjCEv5jREZY+y6oUonqeoL02OGxk1GZX7PBYxtQIUH59CvVtR8+NPYiY0/ogbsUfzj
	1+XzCC4TPDVEF5ZRWv4s6w/rkdzbvYbnzCCOQAGz82GJq5VovHHYPvTtbNtZHqNovx7jjqwpysI
	2WYxg
X-Received: by 2002:a05:620a:f04:b0:7c0:a28e:4970 with SMTP id af79cd13be357-7c39c4c6cfbmr2293011485a.29.1741077666036;
        Tue, 04 Mar 2025 00:41:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh1Ar/3n2takoeAU9NBJEIshtRgWQMbkT9RWqfadPHDzU4n7cEE/uqENKwYoR4DzRsJlBuRA==
X-Received: by 2002:a05:620a:f04:b0:7c0:a28e:4970 with SMTP id af79cd13be357-7c39c4c6cfbmr2293008685a.29.1741077665729;
        Tue, 04 Mar 2025 00:41:05 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm218395285a.1.2025.03.04.00.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:41:04 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 0/5] Fix SCHED_DEADLINE bandwidth accounting during suspend
Date: Tue,  4 Mar 2025 08:40:40 +0000
Message-ID: <20250304084045.62554-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

Jon reported [1] a suspend regression on a Tegra board configured to
boot with isolcpus and bisected it to commit 53916d5fd3c0
("sched/deadline: Check bandwidth overflow earlier for hotplug").

Root cause analysis pointed out that we are currently failing to
correctly clear and restore bandwidth accounting on root domains after
changes that initiate from partition_sched_domains(), as it is the case
for suspend operations on that board.

The way we currently make sure that accounting properly follows root
domain changes is quite convoluted and was indeed missing some corner
cases. So, instead of adding yet more fragile operations, I thought we
could simplify things by always clearing and rebuilding bandwidth
information on all domains after an update is complete. Also, we should
be ignoring DEADLINE special tasks when doing so (e.g. sugov), since we
ignore them already for runtime enforcement and admission control
anyway.

The following implements the approach by:

- 01/05: filter out DEADLINE special tasks
- 02/05: preparatory wrappers to be able to grab sched_domains_mutex on
         UP
- 03/05: generalize unique visiting of root domains so that we can
         re-use the mechanism elsewhere
- 04/05: the bulk of the approach, clean and rebuild after changes
- 05/05: clean up a now redundant call

Please test and review. The set is also available at

git@github.com:jlelli/linux.git upstream/deadline/domains-suspend

Waiman, could you please double check this doesn't break the cpuset
kselftest? It returns PASS on my end, but you never know.

Best,
Juri

1 - https://lore.kernel.org/lkml/ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com/

Juri Lelli (5):
  sched/deadline: Ignore special tasks when rebuilding domains
  sched/topology: Wrappers for sched_domains_mutex
  sched/deadline: Generalize unique visiting of root domains
  sched/deadline: Rebuild root domain accounting after every update
  sched/topology: Remove redundant dl_clear_root_domain call

 include/linux/sched.h          |  2 ++
 include/linux/sched/deadline.h |  7 +++++++
 include/linux/sched/topology.h |  2 ++
 kernel/cgroup/cpuset.c         | 20 ++++++++++---------
 kernel/sched/core.c            |  4 ++--
 kernel/sched/deadline.c        | 36 ++++++++++++++++++++--------------
 kernel/sched/debug.c           |  8 ++++----
 kernel/sched/rt.c              |  2 ++
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        | 33 +++++++++++++++----------------
 10 files changed, 68 insertions(+), 48 deletions(-)


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.48.1


