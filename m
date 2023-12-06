Return-Path: <cgroups+bounces-867-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81F8074F2
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 17:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771CAB20DDB
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC9A47770;
	Wed,  6 Dec 2023 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciSihS5X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4E2D47;
	Wed,  6 Dec 2023 08:29:20 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77f3183f012so33369085a.0;
        Wed, 06 Dec 2023 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701880159; x=1702484959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wd9dmNFWVV3wZN+V4jSJjxu24qyO9wHRcayLWIoq474=;
        b=ciSihS5X1O8h4ci4GGguyECDBinXW/Kltvw4tF6hL5rhD22IZMjB5gclMaueuWlrkd
         H/tgLZ8SXZZ5ORAPj3sThrgTaYLsg9WVdzTMV37VeUlq+Ar6mdVmbb0OKCEtSE1e9c9w
         U1RCBARjuEJahKzPKTsKcfQHly3EIKb/WbeAzWj7EXNRvWADkFt/LeUsnP8eSUSJ6TXN
         uParrsAvtxdeygcvhhKkvXZrrDgNP/jcdt+V/ua2hmh97aygLL0vhieOprPU1Rmak2+y
         ApCfYxW7Mn7GYShkkBiFdLe895QSS5H2N3cP+hddoaPKkxjg1dOJ+RQvjl6uM/5MZwyH
         Tfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880159; x=1702484959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wd9dmNFWVV3wZN+V4jSJjxu24qyO9wHRcayLWIoq474=;
        b=H+bqR7nrZffoGgfrWyl1bAUE5R+wfPhomI6fgJs0U0SA+YDH5edmwCmlpsDmqCdnTb
         KqeEfKCseivRTu7YUC+qcMqUiSoZu+j+5gOJQnRxnubUqpZWgaAidaTix1Z2hBjjLTw8
         CgHOKrJKCYF600SvrKxek4bGAqdwNMqXWLK8SAfI4BceQtGlZ5cw4x3KqygzkrUYz+cb
         ETiq4hSk+LUsDp+ulPWQPpi6NfaUeMD80UdBmVE9ABQn3WBQpN3c5UcRCSCJFG81I5t4
         He+eeolSRfWMWnkRLCNzwdFmaT005cLVTkfq67ZAbod3Qc6MZTJ+3ON5Xpsj6TdrTEPA
         94aA==
X-Gm-Message-State: AOJu0YxM2zNWAMs/PasvkI8k/zuz3jh62w85/iv7Cx1WuPu5A6Xu5ey3
	YL2tWZ5PN054GOdVhVQU418=
X-Google-Smtp-Source: AGHT+IHhiuALx2hZ1zKntduTCjGsG1MfwXfwX9syFNhffyevENPJR9W/FQbEfj2xzCDrmW4Gb0rfuA==
X-Received: by 2002:a05:620a:3b07:b0:77f:37e7:bd6e with SMTP id tl7-20020a05620a3b0700b0077f37e7bd6emr396533qkn.121.1701880159169;
        Wed, 06 Dec 2023 08:29:19 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::6:c65f])
        by smtp.gmail.com with ESMTPSA id uw5-20020a05620a4d8500b007749dc7881dsm69759qkn.48.2023.12.06.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:29:18 -0800 (PST)
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
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH V2 0/1] Add swappiness argument to memory.reclaim
Date: Wed,  6 Dec 2023 08:28:55 -0800
Message-Id: <20231206162900.1571025-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Dan Schatzberg (1):
  mm: add swapiness= arg to memory.reclaim

 Documentation/admin-guide/cgroup-v2.rst | 15 ++++++-
 include/linux/swap.h                    |  3 +-
 mm/memcontrol.c                         | 55 ++++++++++++++++++++-----
 mm/vmscan.c                             | 13 +++++-
 4 files changed, 70 insertions(+), 16 deletions(-)

-- 
2.34.1


