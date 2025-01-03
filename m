Return-Path: <cgroups+bounces-6024-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BEEA00281
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BCC3A3B04
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F115442A;
	Fri,  3 Jan 2025 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoUdWUfQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089AD14A08E
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869034; cv=none; b=gnEUMWdxeW4iy/xt2mqvP9MTfvsh6Wh2fjFbxN86J7Mp+r7jnbf6zMahtPjlfA75VrXrfZ6Za9hLwMaKo1B7Yzs+m7axnFRVMAShE64rmpSs/dfAI/Zhco9ZfhzrMrUaMsyjOOEBtxFnPxp1oQVPDJbbOEN75CP7HrLxxIGPaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869034; c=relaxed/simple;
	bh=myqcVJWsNBx4GkFoYUwsjxERr9ffoXXR/DEhw/nJqKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H6b2OY3UTktPrgMpGe8n6yYomud1oXYSD/DKCqQzikMDyQspEAwjgnh/CfpDurT9DnwcOC24mLA9ZFbV8joVI7ixaT7FUYb7Fd83oBIHK5TT6kI6kyXdsV1vtA9bCaAbA6uSPQfq4MTzlihCCqHPy9Wn3dX6cWwgeQwl0RYhXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoUdWUfQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21636268e43so77945785ad.2
        for <cgroups@vger.kernel.org>; Thu, 02 Jan 2025 17:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735869031; x=1736473831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uMJ2bk+hGWZvNadkXxWhE1x2YHiVwI+Nwe/vTX7uNLI=;
        b=RoUdWUfQaSSVk/PrLA+K1xTnTYOYbGMDDQlTGHmeuzfEZnIrkLvApT2nPt+PRMQfRU
         QIp4G4T7sdHQvlQYygr+qxKu7DqNCg6YFjPyMOXQcj25Nf5QGxLACfuHgGBwjmN4frbQ
         lZeEsCaj++x6IHTgoq0nuISw91yzHuRLw/jEGvUNkZO0Rf5OnyoH0oBHJXyzAJpjUxMu
         cbnXyC1aZA2jrjCM/upSQ0j9GRh8IBP5HFfoMoz168sNTe+7i5PmVx4gXfHv1YfobiSO
         KkG8lQBAN2F/17NI1YTWKfNCIbNx+a+ai/yHK5aFfKj0QXhfPICSsyAsboLfEaOSeoyD
         QGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869031; x=1736473831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMJ2bk+hGWZvNadkXxWhE1x2YHiVwI+Nwe/vTX7uNLI=;
        b=feNHAg2VgnPHKu6ldCaI7QZiZh+YtgOPrqOo8fhfywlS/vrPTlWIAZlTBsXJIE9MnL
         w//0/rhk3Bx76U1+aol2/QxOBHiBz9LIR+MDBnvsassYw3rk9ixaHXoZJA/r+tG6tuJe
         SpIFm2lJRfADSL9IAGAj5aCvetMb0FVOB9NdiK9B7kosQRpGowvCGZJOb6m5NOLFhRic
         g56m/6uvLvSto48RJRotNc6QDOEv4apUB0N2M9ABRbTcD89BhfUR+lIRv0GY3VY9QVyZ
         UHl/50aZmmukLy2rHYrE6IaVGJpJExREyw75VBDT4zfPaBJMY9d89WkRlzmMt0njtKvx
         yvVA==
X-Forwarded-Encrypted: i=1; AJvYcCW2Tp/lT0hB57yflrEnnzssnhMGml/G1FxCvObzdcFlmngqIvaXpYf6iNTX0WOqjklWfl4qPL/8@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJD4oDV0muCvUXABORT5zmzexf9y/bI2xOB4ogtu5LTnZV1RG
	hXjrpNIfm+BeqyBrNZbIJwgWTu90IFsEZqBhpCe6stGnbDcy9sez
X-Gm-Gg: ASbGncuu/oqBVV1c+AeoHI9T554SqHIcUzAVHtlIVYJX1e/dqV8a9CwTG+AXONZWmx3
	paJICExDNsoabpNeijbyPeWIRwrdUZbXeYjqPQXzxvpUOJsu8OjKshSNGow36TUivZqbkQQ2fiR
	wjbLf/IweLG2izLxvTVVDHvFRI/EDps0NjwG4cwPYh/UHqKWBy0vx6W+29fhQSZyC9xCTAxkEHC
	87vULouNxTFsEu1x2RUNMfiSorBo/fgzV80zVq5Ti2VQp1Rpd+LjKmSgKBZ7+R8o+BykQHyHNuJ
	gB1KdNjcfYSPwIR8tQ==
X-Google-Smtp-Source: AGHT+IG6fpUSL0tZv+jydrobqKI1mBJ8YAEJbqhK4E9lRyHA5kN6wKF1I83wPcwL84o/V523VNNzcw==
X-Received: by 2002:a17:903:234d:b0:216:42fd:79d2 with SMTP id d9443c01a7336-219e6f2669dmr724433925ad.49.1735869030820;
        Thu, 02 Jan 2025 17:50:30 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04ce7sm228851505ad.283.2025.01.02.17.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:50:30 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH 0/9 v2] cgroup: separate per-subsystem rstat trees
Date: Thu,  2 Jan 2025 17:50:11 -0800
Message-ID: <20250103015020.78547-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current rstat model is set up to keep track of cgroup stats on a per-cpu
basis. When a stat (of any subsystem) is updated, the updater notes this change
using the cgroup_rstat_updated() API call. This change is propagated to the
cpu-specific rstat tree, by appending the updated cgroup to the tree (unless
it's already on the tree). So for each cpu, an rstat tree will consist of the
cgroups that reported one or more updated stats. Later on when a flush is
requested via cgroup_rstat_flush(), each per-cpu rstat tree is traversed
starting at the requested cgroup and the subsystem-specific flush callbacks
(via css_rstat_flush) are invoked along the way. During the flush, the section
of the tree starting at the requested cgroup through its descendants are
removed.

Using the cgroup struct to represent nodes of change means that the changes
represented by a given tree are heterogeneous - the tree can consist of nodes
that have changes from different subsystems; i.e. changes in stats from the
memory subsystem and the io subsystem can coexist in the same tree. The
implication is that when a flush is requested, usually in the context of a
single subsystem, all other subsystems need to be flushed along with it. This
seems to have become a drawback due to how expensive the flushing of the
memory-specific stats have become [0][1]. Another implication is when updates
are performed, subsystems may contend with each other over the locks involved.

I've been experimenting with an idea that allows for isolating the updating and
flushing of cgroup stats on a per-subsystem basis. The idea was instead of
having a per-cpu rstat tree for managing stats across all subsystems, we could
split up the per-cpu trees into separate trees for each subsystem. So each cpu
would have separate trees for each subsystem. It would allow subsystems to
update and flush their stats without any contention or extra overhead from
other subsystems. The core change is moving ownership of the the rstat entities
from the cgroup struct onto the cgroup_subsystem_state struct.

To complement the ownership change, the lockng scheme was adjusted. The global
cgroup_rstat_lock for synchronizing updates and flushes was replaced with
subsystem-specific locks (in the cgroup_subsystem struct). An additional global
lock was added to allow the base stats pseudo-subsystem to be synchronized in a
similar way. The per-cpu locks called cgroup_rstat_cpu_lock have changed to a
per-cpu array of locks which is indexed by subsystem id. Following suit, there
is also a per-cpu array of locks dedicated to the base subsystem. The dedicated
locks for the base stats was added since the base stats have a NULL subsystem
so it did not fit the subsystem id index approach.

I reached a point where this started to feel stable in my local testing, so I
wanted to share and get feedback on this approach.

[0] https://lore.kernel.org/all/CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com/
[1] https://github.blog/engineering/debugging-network-stalls-on-kubernetes/

Changelog
v2: updated cover letter and some patch text. no code changes.

JP Kobryn (8):
  change cgroup to css in rstat updated and flush api
  change cgroup to css in rstat internal flush and lock funcs
  change cgroup to css in rstat init and exit api
  split rstat from cgroup into separate css
  separate locking between base css and others
  isolate base stat flush
  remove unneeded rcu list
  remove bpf rstat flush from css generic flush

 block/blk-cgroup.c              |   4 +-
 include/linux/cgroup-defs.h     |  35 ++---
 include/linux/cgroup.h          |   8 +-
 kernel/cgroup/cgroup-internal.h |   4 +-
 kernel/cgroup/cgroup.c          |  79 ++++++-----
 kernel/cgroup/rstat.c           | 225 +++++++++++++++++++-------------
 mm/memcontrol.c                 |   4 +-
 7 files changed, 203 insertions(+), 156 deletions(-)

-- 
2.47.1


