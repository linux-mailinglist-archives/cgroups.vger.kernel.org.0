Return-Path: <cgroups+bounces-3263-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173F4911F4C
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 10:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C701028BC34
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194B318E20;
	Fri, 21 Jun 2024 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nDdB9LT7"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B6E16C856;
	Fri, 21 Jun 2024 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959864; cv=none; b=ROeusKtlwqZO6N8mTRB0gK1pa4p0cXBGdgrKzOv0xxKNv37HWh1xSecQ6BM8K2LG+iNBJXtiLJm6QyN5KK15rKoOgz8e5bo/TT1IOsfUPoxAijeLAtc0qbDTXn3Dn85M9NMeVX6OHTl8nFWvseEI4m0x8MUKIMUnyMtkzaN2nFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959864; c=relaxed/simple;
	bh=5QYROOWaGcvbXXs7cTnbAtHbsH2oX4In9WLxiDZb1MY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Afxmg7c6z9qp8ANBN5XaeaxHf0aGtP/pSl2Ki1w5r8HR9huFxQtXtVhN76eEO3lOVwVY+HCD11Ku6LtlEMUuVLBMsmSQ3HVHUpPbL/XqLNWELLiZ19Aij7kz9Y04BPixiDB1DsYfUMqXCdZUjbcRnnmgV0QRuhWe6py3vEwm4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nDdB9LT7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NEUI6
	8AFczxDnCoNcvvy8d5kEzbCqj+XKf0377HnJrU=; b=nDdB9LT7lwwiJXN3nEyoc
	MCcbCYxZPuVGfNXYMQ5NK/6n6duy+gkPv1HuoObd3Eekb+sWO7U/6QB8tKHJyUJ7
	+2OhhBmiiSnucVa+PYnHx+xqqZq/Dl/1KHPmjLEdJemBPgbPCZtfq1y9n5v3uytM
	cNRW7oxIsfsvdhVX1cSpf4=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wDnH6+xPnVmQz_YAw--.49218S2;
	Fri, 21 Jun 2024 16:49:53 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: longman@redhat.com,
	mkoutny@suse.com
Cc: lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-cpuset v5 0/2] cpuset: use Union-Find to optimize
Date: Fri, 21 Jun 2024 16:49:50 +0800
Message-Id: <20240621084952.209770-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b511173c-53fe-4a93-8030-d99ed1b65bd6@redhat.com>
References: <b511173c-53fe-4a93-8030-d99ed1b65bd6@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnH6+xPnVmQz_YAw--.49218S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFyUWFWUXF43tF48XFy7Jrb_yoWfJrgE9r
	4kuayjk3WxWF1IqayrCF95tFW29FWj9r9Yk3Z8tFZrXFsrArZrGrykXa4DX3yUXF4kAr45
	GFyrtr4SqrnrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREMKuUUUUUU==
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/xtbBchIFEGWXvvEkjAAAsg

Hi all,

According to Longman's suggestion, I have added documentation describing Union-Find.
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
 kernel/cgroup/cpuset.c                        |  95 ++++++---------
 lib/Makefile                                  |   2 +-
 lib/union_find.c                              |  38 ++++++
 7 files changed, 309 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/core-api/union_find.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

-- 
2.45.2


