Return-Path: <cgroups+bounces-6962-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC1A5C169
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EE5188C07A
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA54256C84;
	Tue, 11 Mar 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CGF+l0I5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C72222AB
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696618; cv=none; b=bBHBSZozuyCcauln2Orf4+maV5QZqN8s1yHk0FNNypv7iMGQp9zNgX2HPt/sxaS9yXCMPxavCiPS5zckjkuMcUMpBNVMgjY/JZZ49XSaKCleeYF0OHJkiZ5mK3mSOwI/uAUziO3O8FDLiiwGxLxmTHGwr1rLEdcdkDOpYPi/d2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696618; c=relaxed/simple;
	bh=CePJDN6866RNu5OilP7NSNORan/RA/RBfUihDSOHno8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eNYldpaLgdvKsOHYs7FwhjLFWuxI3ztEci6xl+krRTQZsA2N7TQ1FNE43AQvCuhOrZEcnQKMqY4kNrEnSOv+xf7DkqE+fgwaOwsvDKczuRTRcloTwNgVseCgI/kw3XAi/tCK00Ai0j5/8dW4yJU10g24ZCetejMj4PK19Yn6BKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CGF+l0I5; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-39133f709f5so2074817f8f.0
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696613; x=1742301413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qYs9YHqi3o8BYflhXgM2/h7DX07No2svICRJmWY6FQ=;
        b=CGF+l0I5Wsrch1iKaNhFNsc5fv4W/qTGaw/bNGmoseaXUOT+2ET757nQPK4LILnZQe
         NzPbI/T0cinS74vqEzOL4MjQI5edjxOoHs1Gns4eXwRbrRZnrQZTxpMS/viv6FBf86nT
         7yDM7hJFIPQP6hEIZlkEmyC8Qdw9ZylQpbjyWPqHgaPvVorEwplGVoiN2LAyRacz9MRT
         LQoyOY36HWdHQcCf3d3aSANd16Tr568SPBQndn3TWNr3yMoaAgtABiIIJHQ+itfHox6K
         hFX4lEOZt7+r+bFRpXkH4f2mx4imRji0yfcNNoTdiw9zoxVzuJX4yoPUzIqTAWs/C2YF
         cWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696613; x=1742301413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qYs9YHqi3o8BYflhXgM2/h7DX07No2svICRJmWY6FQ=;
        b=BtP5LZsgfEcuFt1PwQJCKiuABU1uvuyfTWi0Q3emVtLHWE6yqL9ip5ncK5D+yLbnCL
         fhi7zcF+yWJPLR8il//JxrkLAHCkHw12+uPEIsSwRoC/Jn5my3TU3gi5mX61BQ727oyf
         JiE7qbPwFbn3q5pKbWENnrh5ZraCSUtSsmqtYI88RHkp3xbQbGXQaMPHaJwJ132lTESC
         JVDhgTf747pYhliOtZquEn1VHSrnRdsfzGp9oqWPj+0cCQkVzL0xn8NXf9VQOF/+Xp7z
         ti9bw6/RXYO9pD37/qiN5lfjOHv9Qi9AlDdM6Z8L8nH39p6C/c/3tPVbsvhpPoZxJaSh
         cISQ==
X-Gm-Message-State: AOJu0YwFYh+DM5fIr7nFgiOUO1hSKLUu1MhUIfw+BmSO4zxozCwjPHXC
	LX2FzVd7YSMlpGy1s1YI3JhYf7HVHgy5+7AV1VkM8r0wo7gK33tUEFBVSiB+JraCwqF4FETuC5N
	e/d50TA==
X-Gm-Gg: ASbGncvSlDrv6b54hT12NzdVCO9rXeB22nGdxjqjM1Vud8J94O1hw+Eig45sljSVGy1
	9k7HsurAGqerqLR/Qwl/wbO1sh09tGfyzP3oLb2CNVG0vYDjHclNqZ/18dawPqDjrs6EpeL/a6c
	SlRUWetfwS8BkBliv9CL2pHknDbrDOZ+1HP97Fi6GUQfENPcxRf7VYaQL7KSagPNezfL5IcbQ5L
	1hhcLJ+r2lbEjXG4Ib2tVX0XLlnO1XOyUaNcr/HjZVCzKYKChwe9YwKl+y7JqMMlVbge6JH8GBa
	OfFaXPlydn9TdqCVwjyeV+hD5bMbkKPPh7yDM+yOwa3gnfV9cv7DfDw5rg==
X-Google-Smtp-Source: AGHT+IEBZYqz4EXYjBrQl7MEBAEBtNENBPTwZcu8eE/AXSvpLAC27EkQUSrI1TFPSdtbH6FbRzmNrg==
X-Received: by 2002:adf:b312:0:b0:390:f6cd:c89f with SMTP id ffacd0b85a97d-39132db6f86mr10434242f8f.53.1741696613012;
        Tue, 11 Mar 2025 05:36:53 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:36:52 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Waiman Long <longman@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 00/11] cgroup v1 deprecation messages
Date: Tue, 11 Mar 2025 13:36:17 +0100
Message-ID: <20250311123640.530377-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Memory controller had begun to print warning messages when using some
attributes that do no have a counterpart in its cgroup v2
implementation. This is informative to users who run (unwittingly) on v1
or to distros that run v1 (they can learn about such users or prepare
for disabling v1 configs).

I consider the deprecated files in three categories:
  - RE) replacement exists,
  - DN) dropped as non-ideal concept (e.g. non-hierarchical resources),
  - NE) not evaluated (yet).

For RE, I added the replacement into the warning message, DN have only a
plain deprecation message and I marked the commits with NE as RFC.
Also I'd be happy if you would point out some forgotten knobs that'd
deserve similar warnings.

The level of messages is info to avoid too much noise (may be increased
in future when there are fewer users). Some knobs from DN have warn
level.

The net_cls and net_prio controllers that only exist on v1 hierarchies
have no straightforward action for users (replacement would rely on net
NS or eBPF), so messages for their usage are omitted, although it'd be
good to eventually retire that code in favor of aforementioned.

At the end are some cleanup patches I encountered en route.

Changes from v1 (https://lore.kernel.org/r/20250304153801.597907-1-mkoutny@suse.com/)
- cpuset load_balance/pressure warn wording (Waiman)
- comment typo (Waiman)
- collect Acks
- drop bouncing Cc: and respective RFC (self)
- change level warn -> info, except for spread slab (Tejun)
- add memory.swappiness (self)
- add legacy freezer message (self)
- update cover wrt net* controllers (self)

Michal Koutný (11):
  cgroup/cpuset-v1: Add deprecation messages to sched_load_balance and
    memory_pressure_enabled
  cgroup/cpuset-v1: Add deprecation messages to memory_spread_page and
    memory_spread_slab
  cgroup/blkio: Add deprecation messages to reset_stats
  cgroup: Print message when /proc/cgroups is read on v2-only system
  cgroup/cpuset-v1: Add deprecation messages to mem_exclusive and
    mem_hardwall
  cgroup/cpuset-v1: Add deprecation messages to memory_migrate
  RFC cgroup/cpuset-v1: Add deprecation messages to
    sched_relax_domain_level
  mm: Add transformation message for per-memcg swappiness
  cgroup: Add deprecation message to legacy freezer controller
  cgroup: Update file naming comment
  blk-cgroup: Simplify policy files registration

 .../cgroup-v1/freezer-subsystem.rst           |  4 ++++
 .../admin-guide/cgroup-v1/memory.rst          |  1 +
 block/blk-cgroup.c                            |  8 +++++--
 block/blk-ioprio.c                            | 23 ++++++-------------
 include/linux/cgroup-defs.h                   |  5 ++--
 include/linux/cgroup.h                        |  1 +
 kernel/cgroup/cgroup-internal.h               |  1 +
 kernel/cgroup/cgroup-v1.c                     |  7 ++++++
 kernel/cgroup/cgroup.c                        |  4 ++--
 kernel/cgroup/cpuset-v1.c                     |  8 +++++++
 kernel/cgroup/legacy_freezer.c                |  6 +++--
 mm/memcontrol-v1.c                            |  6 +++--
 12 files changed, 47 insertions(+), 27 deletions(-)


base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
-- 
2.48.1


