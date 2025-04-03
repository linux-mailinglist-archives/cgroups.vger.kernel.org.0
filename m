Return-Path: <cgroups+bounces-7312-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D10BBA79B39
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 07:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D6318952A1
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEC919CC3D;
	Thu,  3 Apr 2025 05:25:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12B5339D;
	Thu,  3 Apr 2025 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743657947; cv=none; b=NjjVOw/b4oUDTdg9MWXhLdv/rYMKZFQCRfTkImAUDsjGN17tnjeQmaZ1xiLFDobumBNv0AfdXB2bJateN9yv8Vpm6GBGmWaOEB/gaT5c5kLtnKm83sxSman8DPgV4q9jxFJFW1Wx7c6HdkfD6+vTQ7SUiV5wODD7GLTh74tPpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743657947; c=relaxed/simple;
	bh=gMAjSp48Ugj5wxq2Lyt6sD3ImTh42BsXs7Jo1laFeWg=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=fJ5TTI3N4XMg9UceweBPScF0pGt/Rl6AgWqDrIDC1AgD/eM2dTcPX1KVZxI49pzPqUhb7Q1+X4VsjaPO9JUt9XhEWudh6nepfzCiEYkV5BG9WEKNgOHqCS3oH3kepBL55330YgTxpSgFwml64+g4MUfibwbhfdEx/z1HdqDCIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZSqvS4D7yz5B1Jb;
	Thu,  3 Apr 2025 13:25:40 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 5335PWS5010892;
	Thu, 3 Apr 2025 13:25:33 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 3 Apr 2025 13:25:34 +0800 (CST)
Date: Thu, 3 Apr 2025 13:25:34 +0800 (CST)
X-Zmail-TransId: 2afc67ee1bceffffffffc76-6612a
X-Mailer: Zmail v1.0
Message-ID: <20250403132534636XLwK7CWiCj1J4-FENz0vk@zte.com.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>, <mhocko@kernel.org>
Cc: <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>, <muchun.song@linux.dev>,
        <shakeel.butt@linux.dev>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <chen.haonan2@zte.com.cn>, <wang.yaxin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMC82XSBzdXBwb3J0IGtzbV9zdGF0IHNob3dpbmcgYXQgY2dyb3Vw?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5335PWS5010892
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EE1BD4.002/4ZSqvS4D7yz5B1Jb

From: xu xin <xu.xin16@zte.com.cn>

With the enablement of container-level KSM (e.g., via prctl [1]), there is
a growing demand for container-level observability of KSM behavior. However,
current cgroup implementations lack support for exposing KSM-related
metrics.

This patch introduces a new interface named ksm_stat
at the cgroup hierarchy level, enabling users to monitor KSM merging
statistics specifically for containers where this feature has been
activated, eliminating the need to manually inspect KSM information for
each individual process within the cgroup.

Users can obtain the KSM information of a cgroup just by:

# cat /sys/fs/cgroup/memory.ksm_stat
ksm_rmap_items 76800
ksm_zero_pages 0
ksm_merging_pages 76800
ksm_process_profit 309657600

Current implementation supports cgroup v1 temporarily; cgroup v2
compatibility is planned for future versions.

---
[1] commit d7597f59d1d3 ("mm: add new api to enable ksm per process").

xu xin (6):
  memcontrol: rename mem_cgroup_scan_tasks()
  memcontrol: introduce the new mem_cgroup_scan_tasks()
  memcontrol-v1: introduce ksm_stat at cgroup level
  memcontrol-v1: add ksm_zero_pages in cgroup/memory.ksm_stat
  memcontrol-v1: add ksm_merging_pages in cgroup/memory.ksm_stat
  memcontrol-v1: add ksm_profit in cgroup/memory.ksm_stat

 include/linux/memcontrol.h |  7 ++++++
 mm/memcontrol-v1.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c            | 28 +++++++++++++++++++++--
 mm/oom_kill.c              |  6 ++---
 4 files changed, 91 insertions(+), 5 deletions(-)

-- 
2.15.2

