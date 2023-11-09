Return-Path: <cgroups+bounces-256-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C47E6158
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 01:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54BF1C209E9
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 00:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2D365;
	Thu,  9 Nov 2023 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHGJhXeG"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF08360;
	Thu,  9 Nov 2023 00:25:25 +0000 (UTC)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4354D1BFF;
	Wed,  8 Nov 2023 16:25:25 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1cc0e78ec92so1910595ad.3;
        Wed, 08 Nov 2023 16:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699489524; x=1700094324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYg0/Bwt2k4uqOXp/QqUKQgISPeVRvmg1I3hb80MjOo=;
        b=CHGJhXeGhweO2qVG9W6tcLH8olTOQr33shVNPBjeXwhvObqegpvfMs5T0TJ4YaMiSe
         mI30o0kKWgq3h0bOLEpCgCS882IQf02qrgkn8lT1j6v1z7RJbQR+9YDJtP/0XvG3HXd8
         XiX0d8r17kNe9uo8J6KdYXHSWBhzSkGi1ZoOt0cBGWJCMuocv7YPvEounGrJOiVWJUor
         iKrtpmeTSOD1YASLt6wXgK3pVIvsM/le3azQVoPjf6b93d86oH7fJmea9gADCo19dLcj
         s/fD4Ka0RDQnlNi1PYtbBnHw10g7ZOz0Q2uFdJJx3ZoN7bF7gJPhssBFQRm7zW+sUIV/
         Mprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699489524; x=1700094324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYg0/Bwt2k4uqOXp/QqUKQgISPeVRvmg1I3hb80MjOo=;
        b=xJLzmNoMD8+N+lt0OeMao/mA2w7yxWdgJsYbhp8s1tuFSOMe3cY4V3FCRhaK0PyrHW
         s3pjAyL/iIW6iy5Kh+nEgR8c2IQGPtWlw8XMRJeDZjATiu6UBjtDdL+RjHhnMsfwtrIc
         8Bb9nKz8hCvry44Pm6b0dy9mXAsAhrXSRKpZVal/s/VAQgqqm/7ajQvQUpKsZhPrcWaR
         HCN7cD14owaDubgXhlX602bpKdZqeAUWsiaXkzbPPCt44J5sl/horoj24+2+yrVyi4+X
         Mq4k1Z9/EXxJZyoE7GvIfthUBGEuBe9QMSQ5V6Kz3/zjYqt7KVM+PZrsFzWHE1yjydAx
         Y4Jw==
X-Gm-Message-State: AOJu0YxSXnqEcala9s1G0HBCAfSuyfaT5iJsEUNgq0WAgNe9okDHdGb9
	AzJQIAGvsM01sZMnZPsO8CweWGsFUeG3
X-Google-Smtp-Source: AGHT+IGPnnbBYTYzVdIicc6PZI3X0xu/feSIqiTtziNRP5jwGNx+9qgUA2enN/eKVIV4FBs7qh+FHw==
X-Received: by 2002:a17:902:ec8e:b0:1cc:482c:bc4d with SMTP id x14-20020a170902ec8e00b001cc482cbc4dmr4126391plg.5.1699489524241;
        Wed, 08 Nov 2023 16:25:24 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902a9ca00b001bc21222e34sm2219073plr.285.2023.11.08.16.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 16:25:23 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	ying.huang@intel.com,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Date: Wed,  8 Nov 2023 19:25:14 -0500
Message-Id: <20231109002517.106829-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset implements weighted interleave and adds a new cgroup
sysfs entry: cgroup/memory.interleave_weights (excluded from root).

The il_weight of a node is used by mempolicy to implement weighted
interleave when `numactl --interleave=...` is invoked.  By default
il_weight for a node is always 1, which preserves the default round
robin interleave behavior.

Interleave weights denote the number of pages that should be
allocated from the node when interleaving occurs and have a range
of 1-255.  The weight of a node can never be 0, and instead the
preferred way to prevent allocation is to remove the node from the
cpuset or mempolicy altogether.

For example, if a node's interleave weight is set to 5, 5 pages
will be allocated from that node before the next node is scheduled
for allocations.

# Set node weight for node 0 to 5
echo 0:5 > /sys/fs/cgroup/user.slice/memory.interleave_weights

# Set node weight for node 1 to 3
echo 1:3 > /sys/fs/cgroup/user.slice/memory.interleave_weights

# View the currently set weights
cat /sys/fs/cgroup/user.slice/memory.interleave_weights
0:5,1:3

Weights will only be displayed for possible nodes.

With this it becomes possible to set an interleaving strategy
that fits the available bandwidth for the devices available on
the system. An example system:

Node 0 - CPU+DRAM, 400GB/s BW (200 cross socket)
Node 1 - CXL Memory. 64GB/s BW, on Node 0 root complex

In this setup, the effective weights for a node set of [0,1]
may be may be [86, 14] (86% of memory on Node 0, 14% on node 1)
or some smaller fraction thereof to encourge quicker rounds
for better overall distribution.

This spreads memory out across devices which all have different
latency and bandwidth attributes in a way that can maximize the
available resources.

~Gregory

=============
Version Notes:

= v4 notes

Moved interleave weights to cgroups from nodes.

Omitted them from the root cgroup for initial testing/comment, but
it seems like it may be a reasonable idea to place them there too.

== Weighted interleave

mm/mempolicy: modify interleave mempolicy to use node weights

The mempolicy MPOL_INTERLEAVE utilizes the node weights defined in
the cgroup memory.interleave_weights interfaces to implement weighted
interleave.  By default, since all nodes default to a weight of 1,
the original interleave behavior is retained.

============
RFC History

Node based weights
By: Gregory Price
https://lore.kernel.org/linux-mm/20231031003810.4532-1-gregory.price@memverge.com/

Memory-tier based weights
By: Ravi Shankar
https://lore.kernel.org/all/20230927095002.10245-1-ravis.opensrc@micron.com/

Mempolicy multi-node weighting w/ set_mempolicy2:
By: Gregory Price
https://lore.kernel.org/all/20231003002156.740595-1-gregory.price@memverge.com/

Hasan Al Maruf: N:M weighting in mempolicy
https://lore.kernel.org/linux-mm/YqD0%2FtzFwXvJ1gK6@cmpxchg.org/T/

Huang, Ying's presentation in lpc22, 16th slide in
https://lpc.events/event/16/contributions/1209/attachments/1042/1995/\
Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf

===================

Gregory Price (3):
  mm/memcontrol: implement memcg.interleave_weights
  mm/mempolicy: implement weighted interleave
  Documentation: sysfs entries for cgroup.memory.interleave_weights

 Documentation/admin-guide/cgroup-v2.rst       |  45 +++++
 .../admin-guide/mm/numa_memory_policy.rst     |  11 ++
 include/linux/memcontrol.h                    |  31 ++++
 include/linux/mempolicy.h                     |   3 +
 mm/memcontrol.c                               | 172 ++++++++++++++++++
 mm/mempolicy.c                                | 153 +++++++++++++---
 6 files changed, 387 insertions(+), 28 deletions(-)

-- 
2.39.1


