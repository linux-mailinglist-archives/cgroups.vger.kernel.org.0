Return-Path: <cgroups+bounces-3492-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9221A923BDB
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 12:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522442835F3
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1E158DBF;
	Tue,  2 Jul 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JI23kSYk"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3278B51004;
	Tue,  2 Jul 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917569; cv=none; b=F9BMcWGqQdBTShfiOCe5edDsGvITpvrBFigGVHtmwCMkjljzl1nfDVfJMqTVh2YbgBgaeU4GyDyRsFY+K+MuTU0wLrEai/LKUzPZfd3s7O7SGFElvSvtSzxUylf70RB6yJ7eDpWOHDVYk8IBTdC7AuGWaV8gALkjWUr/AN1HJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917569; c=relaxed/simple;
	bh=bJbqoa2/V77ycGTVTB4yMvL+A2a6H6WoXcij3BEJddw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EV8RgXdzZprSIg+oebSvGrgd1DXCPYnmTkJsKmq5pSC1Ss9qspePdAvhbB18DqTlGmlFMv9obH/9N+0uEH1QihxqPUnJ66Xh0u4am+QD4v8sTGN3X3cU80Thw6C+9y49i5yXMsJiRfl8phQlhba572vfOUuwD6/Znh/JoBuFjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JI23kSYk; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FG5H+
	ft0OjPF2pTiykVUW81Gz4xzczdC/iL7+HTzPjg=; b=JI23kSYktFuqRPIpjp9KR
	zsxHeNo/zGCPNgEl+ID8I83ZvXvpYh8728b2QhXjhPdVQ885idPEKgnzGDD2ouOC
	MHFhE48QYwwsl2+LIUKoCkUQfzAH1W+77PffIqug8YwkJTynWGKaBelNwsz3kpJn
	AhnNQGMwL8l/oik5VEI7AU=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wC339Zj24NmFCz9AA--.25261S2;
	Tue, 02 Jul 2024 18:50:11 +0800 (CST)
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
Subject: [PATCH-cpuset v9 0/2] Add Union-Find and use it to optimize cpuset
Date: Tue,  2 Jul 2024 18:50:08 +0800
Message-Id: <20240702105010.253933-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZoMXN3G72xtCLjgp@slm.duckdns.org>
References: <ZoMXN3G72xtCLjgp@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC339Zj24NmFCz9AA--.25261S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr13CF1UWFW8Xr47Xr1DJrb_yoWfZFcE9w
	4kZay2kw1UuF1xWFW8CFyrtFZF9rW0gryvk3Z8tFy7XF4UArZrGr1vqa4DXayUXa1DAr45
	GF98Xr4IqrnrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUcyCJUUUUU==
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiYwQQEGV4JGHXbAAAsE

Hi Tejun,

Thank you for thoroughly reviewing the code and pointing out the issues.
I have made the necessary changes to the code, comments, and documentation
based on your suggestions.

Kindly review.

Xavier (2):
  Union-Find: add a new module in kernel library
  cpuset: use Union-Find to optimize the merging of cpumasks

 Documentation/core-api/union_find.rst         | 102 ++++++++++++++++++
 .../zh_CN/core-api/union_find.rst             |  87 +++++++++++++++
 MAINTAINERS                                   |   9 ++
 include/linux/union_find.h                    |  41 +++++++
 kernel/cgroup/cpuset.c                        |  95 +++++++---------
 lib/Makefile                                  |   2 +-
 lib/union_find.c                              |  48 +++++++++
 7 files changed, 324 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/core-api/union_find.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

-- 
2.45.0


