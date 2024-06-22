Return-Path: <cgroups+bounces-3276-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D07E913281
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 09:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B111C213A3
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 07:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3679014B078;
	Sat, 22 Jun 2024 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XGkkWXcT"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7924C6B;
	Sat, 22 Jun 2024 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719040593; cv=none; b=PcyaTjtebj9ZxF1MDj/YB1fuiviEXU1nK4Coge0n4JllfebC6Z82cRNSfQ43IkGELwdOviNV12CGyyYwsAdwLpAxyPX9ZzlKk+Vb+7bHwiMZbMUhfAGOEbKDy74WnOhYf/S+mkhFuiKe7m6yGE+tHHIN9p7Wf77WwFP0ZeCqSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719040593; c=relaxed/simple;
	bh=TDCoAs/y9J2iOv6JYA2vREyxIp/36u4TOoNlpXdoDWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPFDipgBaZ9kOMbIPxdJC88IPY6KBeIP8l10Tx3TKGl0wbQkC3KwRVh5Mp5qstQGTPjFVQOR0ocs5jFbHFmNXaI71LflqOC+djmrUXj1FcCRI57R46wanCpQvi1BvECWt+/8/yRvwYi7aSJhZE9INUkTGZalX4uCNGkT6YVgZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XGkkWXcT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GW8Tk
	ERinCU+bytAq4l8EDJCeWID0aHV/IFiGnAJHec=; b=XGkkWXcT7qfZcCE8hu+Y5
	gmYxJsBzyt364Q4h3iyXUGun9fRVvL1J0XRDwUVE1eCw86q/rDZMNhfvZfn2Cee6
	sW7lGP3uwkWwhJTyLnk2Gu/t2ZjDGl+VtbY+ifLFIDkH+lV468/DB+SJx0ceaPJo
	Kwot7XTeUeNVnaRiayDavM=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3H3jReXZmjSoVAA--.6022S2;
	Sat, 22 Jun 2024 15:14:25 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: tj@kernel.org,
	longman@redhat.com
Cc: mkoutny@suse.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-cpuset v6 0/2] Add Union-Find and use it to optimize cpuset
Date: Sat, 22 Jun 2024 15:14:22 +0800
Message-Id: <20240622071424.215778-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZnXsUnAi7VnX0tZJ@slm.duckdns.org>
References: <ZnXsUnAi7VnX0tZJ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H3jReXZmjSoVAA--.6022S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1DJw18Zw4ftw4UtF1kXwb_yoW8GrWfpr
	Z7KF98Aa1DGrW7C34fGrW3u34fAas7G398KanrJw1ayr17AFnYyr45Kwn0vr95Gr9rKF18
	Xr43tw18uw1jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTrW7UUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/xtbBchYGEGWXvwSdPQAAsb

Hi all,

Add a Union-Find data structure in library, and use it to to optimize the
merging of cpumasks. It could potentially be used in network configuration
and topology management to manage the connectivity between different devices
or nodes, as well as in managing the merging and lookup operations of certain
complex file clusters or blocks.

To Tejun,
Since union_find operation does not require contiguous physical memory, I
have replaced the previous allocation method with vzalloc.

To Longman,
Based on your patch, the overlapping check and merge operations for cpusets are
skipped in the case of cgroup v2.

Kindly review.

Best Regards,
Xavier

Xavier (2):
  Union-Find: add a new module in kernel library
  cpuset: use Union-Find to optimize the merging of cpumasks

 Documentation/core-api/union_find.rst         | 110 ++++++++++++++++++
 .../zh_CN/core-api/union_find.rst             |  87 ++++++++++++++
 MAINTAINERS                                   |   9 ++
 include/linux/union_find.h                    |  30 +++++
 kernel/cgroup/cpuset.c                        |  97 ++++++---------
 lib/Makefile                                  |   2 +-
 lib/union_find.c                              |  38 ++++++
 7 files changed, 313 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/core-api/union_find.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

-- 
2.45.2


