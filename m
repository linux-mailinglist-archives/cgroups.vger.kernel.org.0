Return-Path: <cgroups+bounces-911-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E080CCE0
	for <lists+cgroups@lfdr.de>; Mon, 11 Dec 2023 15:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD281C202C9
	for <lists+cgroups@lfdr.de>; Mon, 11 Dec 2023 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA99482F8;
	Mon, 11 Dec 2023 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+PjGP21"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581AE5FF4;
	Mon, 11 Dec 2023 06:04:33 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77f43042268so294050685a.1;
        Mon, 11 Dec 2023 06:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702303472; x=1702908272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2chFAW6nomfA6igwhAmawml0spzXTHvMGYmVScTgkfQ=;
        b=U+PjGP213GI4hNtIWUPe262LuMfDqhaBcZL9+eHsEASuREbvJPsTGGpO6LYbFvnTSK
         kDlX/urZjCs9RZVRgWsc+DHhQREBF3NG9ELO5uTM9zZa3vwiNy+9l81Sj9n6oor6ylkK
         vSNg62A5VwdEiCBXKC1whO1mUSNhjfrUiw8D5aWoCfLv9wxIVQIz+Z49B/i9F0uMM72P
         /Rc2Jvj+8OsacqKO4DwSFIhRKg4/6eR2RcMgFfwZRitQWy2A4iWmkw86qPK6DVtGVEAM
         AQOMXF6+gCVi4xrXqpiO2iKdVTsK7vvfQQ3zjl/1+HSIarQM5Un6GktJ2lGgdc5tyhjm
         dFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702303472; x=1702908272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2chFAW6nomfA6igwhAmawml0spzXTHvMGYmVScTgkfQ=;
        b=N6VJdoAVtlSmG7KZ1zvrzemCjKZlBQDtzHoTsmB7H9c+MTi+LwGjJ+qXLX4SOUtqPy
         IRR6JC+71c1D7aHWCOJgj+LVlIx7jX+TsX0+2a2j8r3ZLK+oK1HvCJ5cG2KuMZpa7rDk
         AqylePy7kbs8NMS1ZAYOTY369r3GxG6DxAyW6kIjBR+IURW4UJS/SxJi/WDd/N2I7I61
         GEjyBdOqBkYhzn5sZYIpGyrtYvQzFoIbDpeRahrNANl92y1Ce3NULixR+MDBBW3jkcX4
         fqsyi0dvSGE9Cs7+GLLdnYkHiVjheh+FTNutxlwfRE9B5TQNTyZ9bqo9oTxyi0U6v1Yh
         frTA==
X-Gm-Message-State: AOJu0YxEKiBfqb9DfQgbRHId7Fg1TgxzY280BYAPq9of4gbyyH0JCx1A
	Bwax+8DDTKezRvJCJEjbiSQ=
X-Google-Smtp-Source: AGHT+IFgRujnHXjXhFSUn7kK/8s7CqS3KVm7yCtPcsrSSVcCgQGpBlc7NlQ4YODBMklLqCFxHk35kg==
X-Received: by 2002:ae9:f50b:0:b0:77e:fba3:3e7f with SMTP id o11-20020ae9f50b000000b0077efba33e7fmr5842778qkg.72.1702303472173;
        Mon, 11 Dec 2023 06:04:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:45f0])
        by smtp.gmail.com with ESMTPSA id bm33-20020a05620a19a100b0077eff6eece8sm2931655qkb.62.2023.12.11.06.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:04:31 -0800 (PST)
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
	Mina Almasry <almasrymina@google.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH V3 0/1] Add swappiness argument to memory.reclaim
Date: Mon, 11 Dec 2023 06:04:14 -0800
Message-Id: <20231211140419.1298178-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Dan Schatzberg (1):
  mm: add swapiness= arg to memory.reclaim

 Documentation/admin-guide/cgroup-v2.rst | 15 ++++++-
 include/linux/swap.h                    |  3 +-
 mm/memcontrol.c                         | 55 ++++++++++++++++++++-----
 mm/vmscan.c                             | 13 +++++-
 4 files changed, 70 insertions(+), 16 deletions(-)

-- 
2.34.1


