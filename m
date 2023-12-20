Return-Path: <cgroups+bounces-980-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6830181A266
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 16:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20372288A7B
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCE53F8FA;
	Wed, 20 Dec 2023 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEAtdslD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09DA3FB0B;
	Wed, 20 Dec 2023 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78113481f91so42895085a.3;
        Wed, 20 Dec 2023 07:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703086023; x=1703690823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0YmsiHiH2OTheWqPLRpv7rEgYFPWCHei0D2bGMni+hY=;
        b=OEAtdslD0yWrC6Bp6QtP4FyyDJt1ACl2qHmFTEfb/B/pXR7L2NajZqSS4rKatmlHwe
         PPVibYeklcG/i62a0HqEViLnuBAjZceF4FlFUXGU8rFl9ZJ94L9pSGsXVFPbRd1g/2La
         1eGaUmisv0DCA1QsB75BFEJIzi9ucufpEmUU4E/QKa2ikSlNyE7DBT++56nqLffehDGo
         84LfpY+ujVC6OXW3RMrTNQO19XsRupO/KOvgf2meaLTgSa1syaNbJJ40WpNu07wuxG02
         dzhhjO7gfmMSsKCcHoXfrbDGunmlaCscXfhqXsuoCH4HC/NK7bkphHlXB+Nrz3E1nm7q
         8cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086023; x=1703690823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YmsiHiH2OTheWqPLRpv7rEgYFPWCHei0D2bGMni+hY=;
        b=JyqjKddnKY5hPUFIeYRuVLiVQG+g4lmAz1fGKy8QO2ejxU3Jns1KDaIldysFrAnbue
         CZPzrWrnujYoLRpWPehGif7CqkRO4kVthvjX+7fYXjyb2kwzXcNZ/EJQdP5G3xTolZgd
         SOsOaQDtqAb2c/uSZyBA6WSRhOZ/sGsabjd0nzirV/IDOZMvlh2VlEW3CjSiA9fnCrOR
         LcURg3KE73Sp5QoBsSrdO4gujT/cBRH/eeDg/zLzNe/6PylMv5MY6gd8eOkeicYzrIlK
         2zRyJ+UlAvZTFJ4R95y6jy++13Hn57fCGHN1OEuHZqhyY6UyMPdonSVm+PNFfQ8TMlT5
         xUcQ==
X-Gm-Message-State: AOJu0YzXAQtOXvBIjci3IJWPP9DqOGeHfB61ki9tBhEpiUz5gjDZTkNg
	uJLTvKKo6QrGBRK+qzeGsdc=
X-Google-Smtp-Source: AGHT+IGNYVbytci62dp3FLra4LtlMZv7Z/KCegkh3b9fmkgZpKu25Qtk/Jt7Hk6pQ7MU580U5fb8uw==
X-Received: by 2002:a05:6214:b64:b0:67f:7630:2371 with SMTP id ey4-20020a0562140b6400b0067f76302371mr811828qvb.13.1703086023548;
        Wed, 20 Dec 2023 07:27:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:1124])
        by smtp.gmail.com with ESMTPSA id ev6-20020a0562140a8600b0067f370c7b04sm3397637qvb.68.2023.12.20.07.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:27:03 -0800 (PST)
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Huan Yang <link@vivo.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Nhat Pham <nphamcs@gmail.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>
Subject: [PATCH v5 0/2] Add swappiness argument to memory.reclaim
Date: Wed, 20 Dec 2023 07:26:49 -0800
Message-Id: <20231220152653.3273778-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 mm/vmscan.c                             | 27 ++++++++----
 4 files changed, 79 insertions(+), 29 deletions(-)

-- 
2.39.3


