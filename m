Return-Path: <cgroups+bounces-4364-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51021957BC8
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 05:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168EB28612A
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 03:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E457880;
	Tue, 20 Aug 2024 03:09:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6234C3D0;
	Tue, 20 Aug 2024 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123356; cv=none; b=i0r5aiCzAABDV4rvngjKOuVfYXAzwHqgASQTpHjO0jB4CjvZLTOppuF+vUYyIm92t8QccbafHITHWTqqcYK22SEEFRLhR5wiabowSyV+JWP3lnPDxcBhyASo039wCX21y9CQbkOR1eifysK7KVPR7DfIXEZ4fCSGZf++hh822T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123356; c=relaxed/simple;
	bh=bepKCGoqst6eH+DUZ7az0mUZRqS8C1/vgVf7Px2uuaw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g0DfTuFHmLX9hPG46+qu8ZpYyPXtAg9yrRKnwggMQzlcSAkLAnBkUV6qyjkRunP1pLyOC45GYKSZMOlGHauxjXZWeP7rimErJqOnD/pL9AjX4Zob9iLSi+M/vl9HYWOelJ0AOUZt4PcbqyzcVsYQ6zlPqE547g3htKRbBn1c03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WnvSQ1hqNz2Cn3q;
	Tue, 20 Aug 2024 11:04:06 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 87EB81402CD;
	Tue, 20 Aug 2024 11:09:05 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 20 Aug
 2024 11:09:04 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next 0/3] Some optimizations about cpuset
Date: Tue, 20 Aug 2024 03:01:23 +0000
Message-ID: <20240820030126.236997-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)

The first patch changes from v1:
	Rename PERR_PMT to PERR_ACCESS, and update comments.
	Move 'xcpus_empty() check' up for local and remote partition.

The follow patches have been reviewed by Longman.
cgroup/cpuset: remove fetch_xcpus
cgroup/cpuset: remove use_parent_ecpus of cpuset

Chen Ridong (3):
  cgroup/cpuset: Correct invalid remote parition prs
  cgroup/cpuset: remove fetch_xcpus
  cgroup/cpuset: remove use_parent_ecpus of cpuset

 kernel/cgroup/cpuset.c | 71 ++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 48 deletions(-)

-- 
2.34.1


