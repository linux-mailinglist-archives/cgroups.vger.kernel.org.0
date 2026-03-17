Return-Path: <cgroups+bounces-14854-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPXcFJzguWk7PAIAu9opvQ
	(envelope-from <cgroups+bounces-14854-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:15:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD532B4076
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC3AB30B0B2B
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756B034676D;
	Tue, 17 Mar 2026 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R97arZgQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D31E5B7B
	for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788844; cv=none; b=POQJEk+s6AF1MC/zy+ocTrQvN5gD4xUlk/68SGfX1P8lhAkrA7G4xY9HAdkTkJo0Tf1JbxvfaDTkISnlIRb2edOuaRfO+iO7E/197yAzlqwagOdfztk3j7KuLEGPjp1vB5v3SXJieaPLUtHr1f9sLaR3ix8u51LQdZLXeFkRZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788844; c=relaxed/simple;
	bh=FK+9YKQ/DIUq0kXP72niYHWDNfO5DIOWYPw/t2u7uU0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MaiRzMI9Ej6wD5OU9N4XNGB25MOIVjYZ1Hs0UZY87mMREiHMw3rIyte9GGoZmiUbmg+HmWyagAGqbH+bItc+HqlpFMD2SqyqioLnanXk5IWmYnoJUNIyEZbwAfm4Le2VEsIAKOYwP46RT/9smKQJ+vx8JWnDdUogS0xkvlhyH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R97arZgQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bead0a9123so3287853eec.1
        for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 16:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773788842; x=1774393642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lb4d72Dw6v8zTFjLSshGhZJgBDqi5O2Bbx7kiArqy98=;
        b=R97arZgQQwZCl2Lhn6y/oiy1W53Wsn4aEo24Jd+S4uU0KZh/HvTLJy0HE4Zu/wV6XS
         gtw3HoI96xdOGSKXEBGroASyvZM28b+K9I6pLADv97eprqXCLTjgEhf3nw3Df+GqR+yA
         uA9sQEX4FymB0I8Pd2QahatZSeQ8l2G7C2tMJEOKqV3R+lWaiBM6hR6qyMK4O6P2kpav
         LGfau3krwvdtfVlNF1F0SwoPnZd87EcMKKiF8FtrEE8WvBiTV8fFXQyfNsPncxnjmnL3
         CaS6wAEONJwFV7SiMgsSRsC9kzoR9hIGP7pFtKRBN1M2LRusJw/s7B7pWqR/I0+Z/lcK
         0M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773788842; x=1774393642;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lb4d72Dw6v8zTFjLSshGhZJgBDqi5O2Bbx7kiArqy98=;
        b=IgQHynpIDatXdnZLwkM2e5E8hHM+6SwOTe6VEJzl9KAlnDamesPFGA67K7CwHT0UgT
         1NR0WK8k9X+q4adZZYeAsGqAZtMum/8ZtrZcYO8ydFWhL+j+SL3rKk2bCZ6lKfm1R7q2
         1LbD7w57pT/akbLAqcjLz4lRPAeRx1aO3UI4Wn+9SQfTU2YvPpHb+Lo/EtrFr533Z6UZ
         c1HMQ4YGm4HFBJS45qeqg866dqq9IZf5d2CzwMX0k+KMKF6CDjbbuQo+xQQjgxw4lJLL
         gDvWpGlMCuXFUJGgRmJSGxkDGDv4aMWhFttixF4HPDw7mmz1wOwdn3hUToDhlvKSOlnY
         HKTg==
X-Forwarded-Encrypted: i=1; AJvYcCWOg36ZvK1nY8jgPVMI+BCh6i8izOj3Qwt5MIpcv3wi/pSo37kgSlKe8UiMVKtBN3trVnOXrHa9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvp/tkIX77Q4GD9IFj0aviMIcg5Cggy16kttIW8ZCuuCwhyJVJ
	KvqTQKMOL6IBOk1FN9xzEe9Zyai+/f6r4QwtQsluRQ/RglgPAtffbYCE5bm5agu5K+ZDzgvvZ0H
	NAH1v7FCuwXM0yg==
X-Received: from dybb24.prod.google.com ([2002:a05:693c:6098:b0:2c0:ccba:438b])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:7316:b0:2be:3cd:62bc with SMTP id 5a478bee46e88-2c0e4f9f0f1mr601175eec.13.1773788841723;
 Tue, 17 Mar 2026 16:07:21 -0700 (PDT)
Date: Tue, 17 Mar 2026 23:06:59 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317230720.990329-1-bingjiao@google.com>
Subject: [PATCH 0/3] mm/memcontrol: control demotion in memcg reclaim
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: Bing Jiao <bingjiao@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Yosry Ahmed <yosry@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14854-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bingjiao@google.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,vger.kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,bytedance.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFD532B4076
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In tiered-memory systems, NUMA demotion counts towards reclaim targets
in shrink_folio_list(), but it does not reduce the total memory usage of
a memcg.

In memcg direct reclaim paths (charge-triggered or manual limit writes),
this leads to "fake progress" where the reclaim loop concludes it has
satisfied the memory request without actually reducing the cgroup's charge.
This results in inefficient reclaim loops, CPU waste, moving all pages
to far-tier nodes, and potentially premature OOM kills, and potentially
premature OOM kills when the cgroup is under memory pressure but demotion
is still possible.

This series fixes this issue by disabling demotion in memcg-specific
direct reclaim paths and provides user control for proactive reclaim.

Patch 1: Fixes a state leak in try_charge_memcg() where reclaim_options
were modified and carried over to retries improperly.

Patch 2: Introduces MEMCG_RECLAIM_NO_DEMOTION and disables demotion in
memcg direct reclaim paths.

Patch 3: Adds a 'demote=' option to the proactive reclaim interface
(memory.reclaim), allowing users to explicitly enable demotion if
desired, while defaulting it to disabled for consistency.

Bing Jiao (3):
  mm/memcontrol: fix reclaim_options leak in try_charge_memcg()
  mm/memcontrol: disable demotion in memcg direct reclaim
  mm/vmscan: add demote= option to proactive reclaim

 include/linux/swap.h |  1 +
 mm/memcontrol-v1.c   | 10 ++++++++--
 mm/memcontrol.c      | 17 ++++++++++++-----
 mm/vmscan.c          | 11 +++++++++++
 4 files changed, 32 insertions(+), 7 deletions(-)

--
2.53.0.851.ga537e3e6e9-goog

