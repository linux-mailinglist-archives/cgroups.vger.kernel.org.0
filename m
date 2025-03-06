Return-Path: <cgroups+bounces-6860-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADF0A54D12
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 15:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF7F3AB73E
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE0E14F9C4;
	Thu,  6 Mar 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoSijJv4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2362942A
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270259; cv=none; b=SeTn6wFkXFpH5O/wV1+d9LHZisyNh7CZRIsn9kgrDznNulfFD/zpkmzPv7jHgaBCtxnu6H0oNu5lmPMAixSGw7eDNEXRLQ1slETxsn87f9LF/Ml0qMhbutFw/kMzr8QQ7sqqOfm9fTXdIe8gFb7RBuoEE5lsDYp+BSWpR/VhXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270259; c=relaxed/simple;
	bh=vb1yMpDVAEn02NbneTokVcFGISNeAl4CsozM6DNbXrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nc1H6QBPbXJ9CWzjfcusxm98CqKnMJf9LYJKh2pY8BYxBi4c44DG3L+DIfdDtmwHtAzMe3Bw4RlfCoel1fXhbpyMRjss0aM4p202nvznlxMVg+LmDFlzJb4XPrp6597uF6AAozn8YkA2+SBXrnR2OzyX7y4xgAl6AR6tPg4BWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoSijJv4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OREnm9aUBj2V96zq2XupaDSMV0AJ0BW+JRJEQM5qOOs=;
	b=MoSijJv4k2SSLTMtvUTxOct2be1M8xgJWG5tDVESezNNDi/PbGZ4Gsq8HFwi56MezbMY4f
	tUf4v6xOIwZLe8oCOPesjMZy+unOEocHZEJWce2TV86pT1pUPT6Up/LUmpFx87TA7fJ3Q1
	63Ae5o9hOJNiY2efdGb2gxm/Z3j7xdw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-NEzJVIA3MhOziC-2K3JQ1Q-1; Thu, 06 Mar 2025 09:10:40 -0500
X-MC-Unique: NEzJVIA3MhOziC-2K3JQ1Q-1
X-Mimecast-MFC-AGG-ID: NEzJVIA3MhOziC-2K3JQ1Q_1741270240
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0922c5cfdso127721885a.3
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 06:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270235; x=1741875035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OREnm9aUBj2V96zq2XupaDSMV0AJ0BW+JRJEQM5qOOs=;
        b=FToSSGmyZLQKRCJRHtvh+1Dg13YeYQYB9w/koyto6kQ+4dDup4+0wFVyBFiq5XOhaL
         UjjVzF60J8g6wKTQU24e2DXxZJFwp4QATfaW3mFwhpVuoljAa9RAOSpwGnjgrUHc7lIf
         xvaKdsqHJ/ECNv1sB2v3dJ40Tny/iulPrvjiOQ98iq+kvSrp1YC5V7VhykyAT3HwGAKV
         jA3V8UseNS0X/J+eFzV/V41c5uqJDcx4CHXv9C1obGrIGdmJLYcwTEU+meZHR/vXgQJ4
         HF+vERB5KEOmES29LWv5GbV0AKqHElioxbT0e9D/qgIlbmoVCQJoL5MM6vEChUgL4WqQ
         SqtA==
X-Forwarded-Encrypted: i=1; AJvYcCXVSKnqXkNJcKI+XBKCjPe8DsEBOs0QGvECbSJRhwsD5Cc3t+FtTc1587JjgJI5VHJcQLVC8Gtp@vger.kernel.org
X-Gm-Message-State: AOJu0YxQc2QS9FUSqdiQqkYciDA2UtzpbAKxOMAHQPvt9ELr7shLXCNU
	kHU4OI7CNzRv0v3oU5X5uEZjJhrR+sPqGkMY04icDlpuYojdq2a5dv3cz7PSvwuPdp7xQ5EXs70
	myyzRvoFq2u3GoRGsEFJkXeEa4aMXf5RKfAL/5n03/eEfypn4gW1zdrg=
X-Gm-Gg: ASbGncvx6uQUL8clrADxE0AJOQGyOkS+vNfGqfLOB16SeaN6jL4K65HWLZTjThnFHXB
	xcuyjJwzMjNKFNIjE0lEiQVZ3foxeR7CeWv7V1qefecBAaGOLntuTFNGAGbZpbkAfeH1KgqBhkg
	e4MDwIX1EIAB6IJ4abqziMKJtUp/hxsOVgx5eQREuW2KMIKhbSMMMQRCFlN6eeZCX+/7Ewhud+G
	NYA8WZ6MS7qkdpGi0iARtlufnQziZlzItanC2NwrF8nzLf12rqIWwXP/udqJWq8/ElICUIXd9rh
	lcxTBGgmHhAz22B08NbgL2gdArIiY3Rxszisd2Wh0JgvBI1jk1TbMtJqtp8LZ/v2s1gwAB+ttjC
	0Ov7X
X-Received: by 2002:a05:620a:8908:b0:7c0:c650:e243 with SMTP id af79cd13be357-7c3d8dec097mr1160589585a.30.1741270234907;
        Thu, 06 Mar 2025 06:10:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4KmIqhzBVjcz2IYjNdsy7lmCjF1K/BOG8oys1LjVuBp57JX/6tNcFHNRLX3rFOWSlP/72JA==
X-Received: by 2002:a05:620a:8908:b0:7c0:c650:e243 with SMTP id af79cd13be357-7c3d8dec097mr1160585085a.30.1741270234427;
        Thu, 06 Mar 2025 06:10:34 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:10:33 -0800 (PST)
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
Subject: [PATCH v2 0/8] Fix SCHED_DEADLINE bandwidth accounting during suspend
Date: Thu,  6 Mar 2025 14:10:08 +0000
Message-ID: <20250306141016.268313-1-juri.lelli@redhat.com>
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

This is v2 [2] of the proposed approach to fix the issue. With respect
to v1, the following implements the approach by:

- 01: filter out DEADLINE special tasks
- 02: preparatory wrappers to be able to grab sched_domains_mutex on
      UP (remove !SMP wrappers - Waiman)
- 03: generalize unique visiting of root domains so that we can
      re-use the mechanism elsewhere
- 04: the bulk of the approach, clean and rebuild after changes
- 05: clean up a now redundant call
- 06: remove partition_and_rebuild_sched_domains() (Waiman)
- 07: stop exposing partition_sched_domains_locked (Waiman)

Please test and review. The set is also available at

git@github.com:jlelli/linux.git upstream/deadline/domains-suspend

Best,
Juri

1 - https://lore.kernel.org/lkml/ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com/
2 - v1 https://lore.kernel.org/lkml/20250304084045.62554-1-juri.lelli@redhat.com

Juri Lelli (8):
  sched/deadline: Ignore special tasks when rebuilding domains
  sched/topology: Wrappers for sched_domains_mutex
  sched/deadline: Generalize unique visiting of root domains
  sched/deadline: Rebuild root domain accounting after every update
  sched/topology: Remove redundant dl_clear_root_domain call
  cgroup/cpuset: Remove partition_and_rebuild_sched_domains
  sched/topology: Stop exposing partition_sched_domains_locked
  include/{topology,cpuset}: Move dl_rebuild_rd_accounting to cpuset.h

 include/linux/cpuset.h         |  5 +++++
 include/linux/sched.h          |  2 ++
 include/linux/sched/deadline.h |  7 +++++++
 include/linux/sched/topology.h | 10 ---------
 kernel/cgroup/cpuset.c         | 27 +++++++++----------------
 kernel/sched/core.c            |  4 ++--
 kernel/sched/deadline.c        | 37 ++++++++++++++++++++--------------
 kernel/sched/debug.c           |  8 ++++----
 kernel/sched/rt.c              |  2 ++
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        | 32 +++++++++++++----------------
 11 files changed, 69 insertions(+), 67 deletions(-)


base-commit: 48a5eed9ad584315c30ed35204510536235ce402
-- 
2.48.1


