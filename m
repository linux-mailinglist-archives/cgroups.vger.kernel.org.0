Return-Path: <cgroups+bounces-3453-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8148091C398
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C973284A41
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53AD1CB317;
	Fri, 28 Jun 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YrcbyJAZ"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A011C9ED6;
	Fri, 28 Jun 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591323; cv=none; b=VmtvkwzGusnmy+2G45xolCEKPpLXklYbVLez4+PwxOwyTUpccLjdQ8oLyJ+cVR03GZ5BTF/VnuCNpvk/29FX/Arl6Wlcfxpbu3ci1WCcp5PKcdhFZm/6pgesAnpt+Pl9Dg27HGnmz2hpaXWJhOjpxav7AoS+LN3DfT1MXoykxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591323; c=relaxed/simple;
	bh=bhI5kE4hAd1o3laQddk5jl4FZovXpusYq/ZppIDUcA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYhY6a2kxYKhXLBIEvcPIujzqxkB0535CllHDb0cDElNycX5uBSMafpD9daxAsr3up+dkJI7Hq8Ed3rtiiZgUiaZd5OhYFqCD6l2EOC6p3q2eu+lbXMG4NZBuE+bn7Dmb0BUmvC32tqWc9u6iaeSKS0GPT05toQJJBCDegt/2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YrcbyJAZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=p/G4v
	yxvP45JZ+F3kYh7ClYPIcW38TqkgmgFskTyUuE=; b=YrcbyJAZKH9BIs9uT5J1g
	VcxX154iBscXazc5XMFqsKEXVinyTS1Kr7SurHhOImVU2FGUOdIeCtSGniGs0if3
	HcjTrgpFIuSLmUeXOw+VEu00wTSq7BGmAhbuaHBYzq1oqtO3Uj6mGZf9U7cnV4xw
	wnVdPw9agqDZHl4XM0H4xo=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3f0sP4X5mIE2ZAw--.25173S2;
	Sat, 29 Jun 2024 00:13:03 +0800 (CST)
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
Subject: [PATCH-cpuset v8 0/2] Add Union-Find and use it to optimize cpuset
Date: Sat, 29 Jun 2024 00:13:00 +0800
Message-Id: <20240628161302.240043-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Zn3UaMouBYYIMQr_@slm.duckdns.org>
References: <Zn3UaMouBYYIMQr_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f0sP4X5mIE2ZAw--.25173S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4xKFy5Ar4UJFW5JF4ruFg_yoWkZwcEgF
	WkWa4ak3W8WF1xtFWxCFyftFZFvrWF934vk3WUtFZrXF1DJrZrGr1Dtas8X3y8XF4kJr43
	GFyDtr4IvrnrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUO6pPUUUUU==
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZRIMEGXAmsmNBwABsW

Hi Tejun,

Thank you for your suggestion. I agree with your point that it is indeed more
appropriate to place it within the cpuset structure, and I have already made
the modification. Additionally, I looked into the relevant modules of the
kernel, and it seems that the union-find data structure may have optimization
potential in network topology management and the Open vSwitch module. I will
further investigate this in the future.

Kindly review.

Xavier (2):
  Union-Find: add a new module in kernel library
  cpuset: use Union-Find to optimize the merging of cpumasks

 Documentation/core-api/union_find.rst         | 101 ++++++++++++++++++
 .../zh_CN/core-api/union_find.rst             |  86 +++++++++++++++
 MAINTAINERS                                   |   9 ++
 include/linux/union_find.h                    |  24 +++++
 kernel/cgroup/cpuset.c                        |  96 +++++++----------
 lib/Makefile                                  |   2 +-
 lib/union_find.c                              |  33 ++++++
 7 files changed, 291 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/core-api/union_find.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

-- 
2.45.2


