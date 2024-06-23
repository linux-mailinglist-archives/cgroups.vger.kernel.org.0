Return-Path: <cgroups+bounces-3288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9C2913768
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 04:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27071C20F0F
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 02:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36221944D;
	Sun, 23 Jun 2024 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SOoQgaPA"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107511A291;
	Sun, 23 Jun 2024 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719110389; cv=none; b=ach3mSKj1OEp/umuuLQyu2Qx01gsjBOYeZILf1a6PzwGvFCY5MhKJ10/0BtY9kBf9PqQ0q+PkJxs8yEWzvH2SeY1M9eMIDMpeLOMKez+iJXdoXGrGqVH1UXMaS157lTUJOBxYHEs/FDkhPAGgIQp9QVQeTjWIZJBtJbHhU8Qqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719110389; c=relaxed/simple;
	bh=BMn1MArJM/6ZCAFTCTbaaSt2HVXS4rjE85L3iR7L6Js=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgbwemJGP6hJdc1L7JK/yLIT/9bfa0JtnxxJ0WgPm1uYPOKQCaWn0a2gAQ93WqzURVESbslqByQCWqz5o9/qrC8L5ly22CUJdmXHNAfGpUBI7WKWSpkUlZh+bd1PPrmYFAqzO2lMHHJcIpUERIi1KdW0FI7RSKko7ve29b5vIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SOoQgaPA; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Tiih6
	EAP0ggAT1d+qrR4Zqur9FSo7xtNmrDNNQ58LEg=; b=SOoQgaPA31mStHzHjFznv
	yCHlbgK6ynTR9N7spT0i8gipt0sQ4jidwASOO00txLR+vYdA3cwQeCuN2B//49S6
	WNqT8lxnmIZPqQC/MapsxUzMOfaQe/NVrsen3U+b0mytmIY+9e06nw9wB1k7YZ+M
	N2JUWu4WB/u/PbBrVTUgqA=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wDXXx3GindmZEN3AA--.40763S2;
	Sun, 23 Jun 2024 10:39:02 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: tj@kernel.org
Cc: longman@redhat.com,
	mkoutny@suse.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-cpuset v7 0/2] Add Union-Find and use it to optimize cpuset
Date: Sun, 23 Jun 2024 10:38:59 +0800
Message-Id: <20240623023901.218892-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Znb4JBpJoGZ3LS1W@slm.duckdns.org>
References: <Znb4JBpJoGZ3LS1W@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXXx3GindmZEN3AA--.40763S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWruF4rGr4fuF17WryxGrg_yoWDXrbEgF
	4kWayjk3WxWF1xXFWSkFyrtFW29rW8ury0k3Z8KFW7XFZrArZrGryvqas8Xw47XF4kAr45
	GF9xtr4IqrnFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjdWFUUUUUU==
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/xtbBcggHEGWXvxFyGgACsb

Hi Tejun,

I think I understand your point now. I have modified the Union-Find
implementation so that the allocation and deallocation are handled by the
user, providing only the initialization interface. Thanks for your
suggestion.

Kindly review.

Best Regards,
Xavier


Xavier (2):
  Union-Find: add a new module in kernel library
  cpuset: use Union-Find to optimize the merging of cpumasks

 Documentation/core-api/union_find.rst         | 101 ++++++++++++++++++
 .../zh_CN/core-api/union_find.rst             |  86 +++++++++++++++
 MAINTAINERS                                   |   9 ++
 include/linux/union_find.h                    |  24 +++++
 kernel/cgroup/cpuset.c                        |  99 +++++++----------
 lib/Makefile                                  |   2 +-
 lib/union_find.c                              |  33 ++++++
 7 files changed, 295 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/core-api/union_find.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

-- 
2.45.2


