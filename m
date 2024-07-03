Return-Path: <cgroups+bounces-3514-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 353079253C7
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 08:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5314B23E25
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 06:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4F131BDD;
	Wed,  3 Jul 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kWCkUr3o"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0810130A4D;
	Wed,  3 Jul 2024 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988754; cv=none; b=L9nN7dernSMLig6y1gfn7qN3eQdVxF0GsG+uaGU0hrUfahUtlIkk4DWLBBZLbuEzI68nOmGLh0TxYC7TRIpohWwl3uf3P83ofsnpeAwqok9JMpSPnsEW8l+Au3HVJJHmlRsaJCl58ZSAiYtYRntNOJGThOe9DsKrgYoh4Iqlhv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988754; c=relaxed/simple;
	bh=YtF5km8cVaM3xxkWxd9nXrDDcYt04/mc+bKwK9djk10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BMrFic4nu6btCtkx/0soOYbfkJJZhNSO5qvex3AWcPbOqYt/ZZJzAP14Pjbmbus5bBjYMkoODmGH7jeIC6BtWGQ06AhNsCrm9JVbTUJOUSyWOPWgjM9uA+JvfC2781RH4LHPsLpZzaGFk66sfbond2fp4poY8Aza0Gj8bUNsavM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kWCkUr3o; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MPH8c
	X+M9F6ljdADbJ95yi7S10RAty+yWLX1qeeJzKg=; b=kWCkUr3otpV+UJYWdDnTF
	8fPmojipHFfTHsi5ITzWye+s24/5eYl8q7L8FioWn/0bAcdtpBG7rafMLLgb1PYr
	D73SPWyi6W1uNJipBnkDPgcgb8a8j+d55NdhVHMhAo+9ugViC6jVQgAXlkqVvu52
	g7cBDsSpYFOv2FMl/IGvpI=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wD3P62q8YRm357BAw--.8878S2;
	Wed, 03 Jul 2024 14:37:30 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: tj@kernel.org,
	longman@redhat.com,
	akpm@linux-foundation.org
Cc: mkoutny@suse.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-cpuset v10 0/2] Add Union-Find and use it to optimize cpuset
Date: Wed,  3 Jul 2024 14:37:25 +0800
Message-Id: <20240703063727.258722-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZoRThI4lcZLxBlwc@slm.duckdns.org>
References: <ZoRThI4lcZLxBlwc@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P62q8YRm357BAw--.8878S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xry3ZrWfAw17ArWDtF4UCFg_yoWfCFX_Wr
	WkXayjkw1UWFn2gay8CFyrtFZF9FWYgryvk3WDKFZrXF4UJrZrGr1DJa4DXay5XF4kAr43
	Gas8Jr4xtrnrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUcyCJUUUUU==
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZQwREGXAmyucugAAsb

Hi all,

All the pointed out comment issues have been addressed. Moving forward, I will
continue to look for applications of the union-find algorithm in other parts
of the kernel.

Kindly review.

Xavier (2):
  Union-Find: add a new module in kernel library
  cpuset: use Union-Find to optimize the merging of cpumasks

 Documentation/core-api/union_find.rst         | 102 ++++++++++++++++
 .../zh_CN/core-api/union_find.rst             |  87 +++++++++++++
 MAINTAINERS                                   |   9 ++
 include/linux/union_find.h                    |  41 +++++++
 kernel/cgroup/cpuset.c                        | 114 +++++++-----------
 lib/Makefile                                  |   2 +-
 lib/union_find.c                              |  48 ++++++++
 7 files changed, 332 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/core-api/union_find.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

-- 
2.45.0


