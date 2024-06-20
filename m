Return-Path: <cgroups+bounces-3243-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D347E90FFA3
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 10:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86511282412
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3BB1AB502;
	Thu, 20 Jun 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oK0gWrkh"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F319AD7E;
	Thu, 20 Jun 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873602; cv=none; b=OnSMIYQVyUkhpFX0ZQcKZiU/leMtYKuSVi0bdaldYy32dPk/azjgUsqa6B1xsHZ6GO+jMkc7uoynTakSTBMEK/roI5ql3PZ4Cp0rsa5q8b2U89atFVCWZVXYtrevewU1vU0X1E/GUIZkNkJmCYhd6QXdTTL6W3LiZvf5cg+mHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873602; c=relaxed/simple;
	bh=bwpHiqfV3NR9ZNI5PhU7nc3iTqkQEhyq1Z4buAeV7pE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trTT2ARx7u89gdTe+16DRTbTOYbWA+RYwgwBcxDPsMP+RZTswQdAbA7IZQKnW2lRXmI23rxiqsymjCse7Q8G9WXqTM2ASMy6fmlDOZ5tRR8OtiuYFkyJtIjHfOSmCWQCl/OB0onnQJlzUYuSGvACf7u8+dM1m1xGnWWXI4Uwkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oK0gWrkh; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5sH8h
	xhoOeNYDft5EdEon6W33nt0SARFkjDRTog6ETM=; b=oK0gWrkhZmY56FLE4hy9w
	MbFVSwYh4ABTgF2LZa2y+DpTHVASdeTd07Ka+gNhjV1TjW6JS5dVH4eQBldVcdem
	e4OlET5vEKBeUdShS5U3DJfXngb42WOV9EW6yF2FbJAUI393s/7iPewcvCPg4Z2g
	/ot+dnBv7mTRXUeJC64PO4=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDnLxfS7XNmCTWKBg--.31671S2;
	Thu, 20 Jun 2024 16:52:34 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: longman@redhat.com,
	mkoutny@suse.com
Cc: lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH v4 v4 0/2] cpuset: use Union-Find to optimize
Date: Thu, 20 Jun 2024 16:52:31 +0800
Message-Id: <20240620085233.205690-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603123101.590760-1-ghostxavier@sina.com>
References: <20240603123101.590760-1-ghostxavier@sina.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnLxfS7XNmCTWKBg--.31671S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw43WF18tw47Kr4xtFyUAwb_yoW3Xrg_Xa
	48Za4qk3WjgFn2gayrKF9IqFW2k3y0gwn5C3WDJF4UXF17JrsxGw1kJFZrZry7XF1kJr43
	JF15tr4Fqr1qgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREgAwJUUUUU==
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiYwEEEGV4I1gq4AABsb

Hi all,

According to Michal's suggestion, I have divided the patch into two
 separate submissions.
Kindly review.

By the way,I changed my email from "ghostxavier@sina.com" to "xavier_qy@163.com"
because the previous one was inconvenient to use.

Best Regards,
Xavier

patch (2):
  Union-Find: add a new module in kernel library
  cpuset: use Union-Find to optimize the merging of cpumasks

 MAINTAINERS                |  7 +++
 include/linux/union_find.h | 30 ++++++++++++
 kernel/cgroup/cpuset.c     | 95 ++++++++++++++------------------------
 lib/Makefile               |  2 +-
 lib/union_find.c           | 38 +++++++++++++++
 5 files changed, 110 insertions(+), 62 deletions(-)
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

-- 
2.45.2


