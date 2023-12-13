Return-Path: <cgroups+bounces-929-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C78107BD
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 02:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0989282305
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC9ECA;
	Wed, 13 Dec 2023 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdF7K4E6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79327B7;
	Tue, 12 Dec 2023 17:38:37 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d04c097e34so50739475ad.0;
        Tue, 12 Dec 2023 17:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702431517; x=1703036317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gVAw6lRJ7pahWlf8sMC/DMXTEVU+Aq26rrCAm60sOZA=;
        b=YdF7K4E6l+QhrvxnRq79rkDqeLY9d0lsCL/ouXRi6SJRKE63jkJdOBDDBNS8z9bUg4
         80hn5cDRMZTO6nu21Aa2Gx5vnViakb1Q7zXw2oHDr/8aYNc9MOsanR5x2E+oYbJWth8S
         g77HOZgZhqkOvryTFctnSf3qFyxO15Q3Gc84q/1I5GASgFbABsz0D70p8bjBvsB/Spz5
         0HkSk3xypxdbiDS8vwmbJ30xG+3QGOjqBvbolX+fIgKDghJP+bFWTZMU6FMUVuviPd0G
         vQlD89jAeyyNpfa1KBWubgdfhL9nDs54o1aGRbUMMAV0IQmCH8CyPRzLxs2bWtksNDBd
         bjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702431517; x=1703036317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVAw6lRJ7pahWlf8sMC/DMXTEVU+Aq26rrCAm60sOZA=;
        b=Xeju37ldoyUIFPI4SWSRQUgxsbsBmfRGVxJSjByaTeAwuQNGXuLDYLpNheHnaMZi0N
         YuMeDRfP9R3ptAynPd3ZzQQcGnG8rcUkZHZHoNoBWNOUB7y/hIdju7Q22HhdrQTjQAUI
         Vs4wtrZ25jbb2XhaI3BiqTUPKvuPsaZv+gJ17rwsemh3ZOX3bLASDxmoxKSFLFHnmQhZ
         Lk40nn8ypF/GU3oFwy4u3h6eZqdX6KmB0xT/qhJoazo2jOeCuj4cwbU4RFKMUOobjRqN
         ovnluNILcHQTHMy2g97YHIctW/jCaqgmy4zSx5DfEGCgFvPU2Q1+5cJj6rxel3jcdAQ5
         PGCg==
X-Gm-Message-State: AOJu0YzOqwVfXiC0UME+nX4CcrgACm9gwQqoEScPH6M/3HG3hnLnE8KI
	iNQ0Ih0fzv14ew0HGNbbIx8=
X-Google-Smtp-Source: AGHT+IG+Utuvu8ZvE9vrymMXlr3GYp04H1W7WNZnphwE7A9ZGjxfEuhstXGM/YzQUUo4jJbO2uKA9g==
X-Received: by 2002:a17:902:c081:b0:1cf:f868:5b8c with SMTP id j1-20020a170902c08100b001cff8685b8cmr7770470pld.8.1702431516563;
        Tue, 12 Dec 2023 17:38:36 -0800 (PST)
Received: from localhost ([2620:10d:c090:500::7:1c76])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001cf511aa772sm9254767plg.145.2023.12.12.17.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 17:38:34 -0800 (PST)
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
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Yue Zhao <findns94@gmail.com>
Subject: [PATCH V4 0/1] Add swappiness argument to memory.reclaim
Date: Tue, 12 Dec 2023 17:38:01 -0800
Message-Id: <20231213013807.897742-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 Documentation/admin-guide/cgroup-v2.rst | 19 +++++---
 include/linux/swap.h                    |  5 +-
 mm/memcontrol.c                         | 63 ++++++++++++++++++++-----
 mm/vmscan.c                             | 21 +++++----
 4 files changed, 80 insertions(+), 28 deletions(-)

-- 
2.34.1


