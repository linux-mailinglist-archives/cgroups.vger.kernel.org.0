Return-Path: <cgroups+bounces-703-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8267FF3BA
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 16:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4FC1F20D46
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D30B524D4;
	Thu, 30 Nov 2023 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOuj9+RS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B710DF;
	Thu, 30 Nov 2023 07:38:15 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77d708e4916so48385285a.3;
        Thu, 30 Nov 2023 07:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701358694; x=1701963494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHt5GWpmh8+9rwkGRbQdmAOL6TBISUyjYNzzHw7DKOw=;
        b=dOuj9+RSpq9WraSpu5bJ234WW3s6vfaOPQKzEMhTDaH71NXQXVwJ13UDh5qSW9wNwZ
         KVkS3R9JmsdIVGyuMkcH0i4NanhNjhBSfkZQS/7vYKsmHZ71IXsKSHuh3XKSaZHFdbNL
         MLxTJYwvRCf5CWF8OvvxZdBKDG2015kAcj7Sf0lK1vv/RULLUKg62vV3UOmfiPDlax/l
         UDl6KESb4pSzxsx0XAiFLwVGTNHzHgmoa2IB5sq3T1p+Uq8xPsgIP7RvZ5xagsIdsZ0D
         lurj30nPCJjW8s1YnzpE8VvdHZewJ7Gqi96zdWCPD+3W2lGmGd4QToCyLUW41OWBwpwz
         nVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701358694; x=1701963494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHt5GWpmh8+9rwkGRbQdmAOL6TBISUyjYNzzHw7DKOw=;
        b=qYZ28o2gDXbaJ796rhD9Bl9fpr4sGad+swi8bl3ztUxhJpSYuXA8uUBKq+6gVO2peS
         qDXdQ7oJoBUerdL+L93wj0eDna//YjXTqjW/2ZrGeYs9kMq1TU+qZfBJkV6XH9g7/uzP
         SUgYJ9bAImJrmlaPwtVnM95tP5dWmcBxNIkWfvnqjYSlQVJRHRbHuf6xcgNIhGEhMla+
         VXBeKPg8fR7qVK8GlczSNWMXnOJX8418MRQv9NioQid1S8dP/jPpHshtjGlXTz1rVh3u
         WSbbJIcSI1r5bUNj5bzWWZ8wIINFd/vqYEW2Hr37yZUTj1XzyHxicGpVDN9tmyhyq1uG
         sL8w==
X-Gm-Message-State: AOJu0YyJ96bTy2Z1kmPo2kA4foXTUDxkTMCPc5T6nE/QMInR4UeoZ6WH
	g2ulwuHpmrpBFPsv/WbnxPg=
X-Google-Smtp-Source: AGHT+IG+YeVQU9bOA8JsYBiNqgPoYpCg7li0RkAm6JM0YUNx3+QG1A+NWtwQO9eyBgDbPmFnHT4o8g==
X-Received: by 2002:a05:620a:3913:b0:77d:8659:ee65 with SMTP id qr19-20020a05620a391300b0077d8659ee65mr25383275qkn.67.1701358693897;
        Thu, 30 Nov 2023 07:38:13 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::4:edc5])
        by smtp.gmail.com with ESMTPSA id bi32-20020a05620a31a000b0077d9f83e691sm593708qkb.35.2023.11.30.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:38:13 -0800 (PST)
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Huan Yang <link@vivo.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 0/1] Add swappiness argument to memory.reclaim
Date: Thu, 30 Nov 2023 07:36:53 -0800
Message-Id: <20231130153658.527556-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Sorry for the resend - forgot to cc the mailing lists)

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

 include/linux/swap.h |  3 ++-
 mm/memcontrol.c      | 55 +++++++++++++++++++++++++++++++++++---------
 mm/vmscan.c          | 13 +++++++++--
 3 files changed, 57 insertions(+), 14 deletions(-)

-- 
2.34.1


