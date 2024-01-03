Return-Path: <cgroups+bounces-1060-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C4F82317D
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 17:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2041F23E37
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720A91BDFA;
	Wed,  3 Jan 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJiaCM98"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850C1BDEA;
	Wed,  3 Jan 2024 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dbbc637df7so7010411a34.2;
        Wed, 03 Jan 2024 08:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704300547; x=1704905347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7YOxkBSsy8gVCBj2wU1um2RFxkUEv6eBM3fBzmTk6ZQ=;
        b=aJiaCM98BnS3fYhsCP3DsODw3GPWi4RbCFzT0gmuuuKo72cWhg4JvGRymxn+Q3+dlj
         kH/47gDzHjwK0Fw8IB44F0RC+4Qjy+pFd0UAqkDgYgMQHja9l8OD0FDO/g8KOdjWWZ82
         ZV+eNEuQt1IKQwWel28JZzcuRXz+jEW4DpzWP++IhdO/oEBM3xsG7LoDG6IVdPHxC3VJ
         id7GLk+n3wyHnytpdgIGrIF2N+WxcOFp0iwZtGSdNvM6czMln0WxaIVCIi4dlc1mMAyI
         RVSYz8c770XcEqIqIesEk+TvR9mnzduf5APsxm91kXyStSASBIe7uavEF/YoBcE76YRZ
         S7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300547; x=1704905347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YOxkBSsy8gVCBj2wU1um2RFxkUEv6eBM3fBzmTk6ZQ=;
        b=JpW1C5ZRz8xCTS0Qz4k8qWaWM5qC65LarxcDKnqHi4nVAs/xLTZm6KtKd7s99nNu/2
         0bIXZ8ZFcWskYpnwmK7atvunJCsOLTGeD1ajAsWsQU51DZxG+hWh6233LgkiyNrttAkW
         DEPqvHJl6g2sAmFlUNW9RUCEPBdnl3vy/2HPgYSh43INq5KMdd3xVaLghdVRaq9CpGTL
         5QKDbtOseOwf9II8o45YUoxq62fc/my2HOz92dan2qu9Ulu3HounSLkeDNVdEdWZSTco
         jieEH17GG7OT1RQxzmbXKGxb/CMxh/ZstdaHFnuYrIJxuNeHAzR3vg/o3Uo6DqPJEl7+
         xk9g==
X-Gm-Message-State: AOJu0YwhJGi79cN9RlK0B0UBqltoUL5aBBvQEcPsNAsvNVp/jdz1qQXj
	d+d16VLh7VgkUZbXCW8J0Ww=
X-Google-Smtp-Source: AGHT+IFLNd6r4sLlBUDIfHH5k+tFiPZb3cLEvcFpPURN1hrp6Tu+pnN5zSuJjq33t8jB9TXNfanpxg==
X-Received: by 2002:a9d:63d6:0:b0:6db:b08d:67b6 with SMTP id e22-20020a9d63d6000000b006dbb08d67b6mr12936091otl.53.1704300547484;
        Wed, 03 Jan 2024 08:49:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:fcab])
        by smtp.gmail.com with ESMTPSA id k15-20020ac8478f000000b004240481cee0sm14234406qtq.58.2024.01.03.08.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:49:07 -0800 (PST)
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 0/2] Add swappiness argument to memory.reclaim
Date: Wed,  3 Jan 2024 08:48:35 -0800
Message-Id: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since V5:
  * Made the scan_control behavior limited to proactive reclaim explicitly
  * created sc_swappiness helper to reduce chance of mis-use

Changes since V4:
  * Fixed some initialization bugs by reverting back to a pointer for swappiness
  * Added some more caveats to the behavior of swappiness in documentation

Changes since V3:
  * Added #define for MIN_SWAPPINESS and MAX_SWAPPINESS
  * Added explicit calls to mem_cgroup_swappiness

Changes since V2:
  * No functional change
  * Used int consistently rather than a pointer

Changes since V1:
  * Added documentation

This patch proposes augmenting the memory.reclaim interface with a
swappiness=<val> argument that overrides the swappiness value for that instance
of proactive reclaim.

Userspace proactive reclaimers use the memory.reclaim interface to trigger
reclaim. The memory.reclaim interface does not allow for any way to effect the
balance of file vs anon during proactive reclaim. The only approach is to adjust
the vm.swappiness setting. However, there are a few reasons we look to control
the balance of file vs anon during proactive reclaim, separately from reactive
reclaim:

* Swapout should be limited to manage SSD write endurance. In near-OOM
  situations we are fine with lots of swap-out to avoid OOMs. As these are
  typically rare events, they have relatively little impact on write endurance.
  However, proactive reclaim runs continuously and so its impact on SSD write
  endurance is more significant. Therefore it is desireable to control swap-out
  for proactive reclaim separately from reactive reclaim

* Some userspace OOM killers like systemd-oomd[1] support OOM killing on swap
  exhaustion. This makes sense if the swap exhaustion is triggered due to
  reactive reclaim but less so if it is triggered due to proactive reclaim (e.g.
  one could see OOMs when free memory is ample but anon is just particularly
  cold). Therefore, it's desireable to have proactive reclaim reduce or stop
  swap-out before the threshold at which OOM killing occurs.

In the case of Meta's Senpai proactive reclaimer, we adjust vm.swappiness before
writes to memory.reclaim[2]. This has been in production for nearly two years
and has addressed our needs to control proactive vs reactive reclaim behavior
but is still not ideal for a number of reasons:

* vm.swappiness is a global setting, adjusting it can race/interfere with other
  system administration that wishes to control vm.swappiness. In our case, we
  need to disable Senpai before adjusting vm.swappiness.

* vm.swappiness is stateful - so a crash or restart of Senpai can leave a
  misconfigured setting. This requires some additional management to record the
  "desired" setting and ensure Senpai always adjusts to it.

With this patch, we avoid these downsides of adjusting vm.swappiness globally.

Previously, this exact interface addition was proposed by Yosry[3]. In response,
Roman proposed instead an interface to specify precise file/anon/slab reclaim
amounts[4]. More recently Huan also proposed this as well[5] and others
similarly questioned if this was the proper interface.

Previous proposals sought to use this to allow proactive reclaimers to
effectively perform a custom reclaim algorithm by issuing proactive reclaim with
different settings to control file vs anon reclaim (e.g. to only reclaim anon
from some applications). Responses argued that adjusting swappiness is a poor
interface for custom reclaim.

In contrast, I argue in favor of a swappiness setting not as a way to implement
custom reclaim algorithms but rather to bias the balance of anon vs file due to
differences of proactive vs reactive reclaim. In this context, swappiness is the
existing interface for controlling this balance and this patch simply allows for
it to be configured differently for proactive vs reactive reclaim.

Specifying explicit amounts of anon vs file pages to reclaim feels inappropriate
for this prupose. Proactive reclaimers are un-aware of the relative age of file
vs anon for a cgroup which makes it difficult to manage proactive reclaim of
different memory pools. A proactive reclaimer would need some amount of anon
reclaim attempts separate from the amount of file reclaim attempts which seems
brittle given that it's difficult to observe the impact.

[1]https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
[2]https://github.com/facebookincubator/oomd/blob/main/src/oomd/plugins/Senpai.cpp#L585-L598
[3]https://lore.kernel.org/linux-mm/CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com/
[4]https://lore.kernel.org/linux-mm/YoPHtHXzpK51F%2F1Z@carbon/
[5]https://lore.kernel.org/lkml/20231108065818.19932-1-link@vivo.com/

Dan Schatzberg (2):
  mm: add defines for min/max swappiness
  mm: add swapiness= arg to memory.reclaim

 Documentation/admin-guide/cgroup-v2.rst | 18 +++++---
 include/linux/swap.h                    |  5 ++-
 mm/memcontrol.c                         | 58 ++++++++++++++++++++-----
 mm/vmscan.c                             | 39 ++++++++++++-----
 4 files changed, 90 insertions(+), 30 deletions(-)

-- 
2.39.3


