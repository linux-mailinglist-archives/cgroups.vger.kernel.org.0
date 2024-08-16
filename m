Return-Path: <cgroups+bounces-4325-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7246995448E
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 10:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE5B1F22042
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B83132117;
	Fri, 16 Aug 2024 08:35:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BFC82863;
	Fri, 16 Aug 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797309; cv=none; b=SQUlCtL0o2l88GZb6JYBn8syqk6E6pDfmUTcQUSwbo4l7X3KhE7MajQGdhVUf+P32Rh8Igb0m9B423vhAsBdgN8FAiK/5XE1wSBZbeEBumeuV/M/cG93kZYxeROeK0oBaHOdNY/2auBhXlvLxeKy+fSaBmK9wUzH2uiajBR5rQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797309; c=relaxed/simple;
	bh=5Ysjcp3lOOdxm/SCUt3KhxAH8oiD65AvEDLk4UX/dEo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c669699BmgreLKuQ05BmmsMw/93PvTbveMXlo6E1qgRNkDNdbJmph8i41T796ZgxjoPmTvU/I88nrRd/ztn/VX21yGatjLtFoEeMGpLI5TN63eQ6qA0QYOGzP9ZwpH0N/zc1xehrSYnEjcs0Iy7HPVdAe8rn4EP4GzRawiAlPXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WlZtS2W8nz1j6YT;
	Fri, 16 Aug 2024 16:30:08 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AFEF1A0190;
	Fri, 16 Aug 2024 16:35:02 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 16 Aug
 2024 16:35:01 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 0/3] Some optimizations about cpuset
Date: Fri, 16 Aug 2024 08:27:24 +0000
Message-ID: <20240816082727.2779-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)

Chen Ridong (3):
  cgroup/cpuset: Correct invalid remote parition prs
  cgroup/cpuset: remove fetch_xcpus
  cgroup/cpuset: remove use_parent_ecpus of cpuset

 kernel/cgroup/cpuset.c | 85 +++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 55 deletions(-)

-- 
2.34.1


