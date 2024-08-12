Return-Path: <cgroups+bounces-4199-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F8994E808
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 09:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B43B21D39
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 07:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F3F1547F6;
	Mon, 12 Aug 2024 07:45:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF44D8D1;
	Mon, 12 Aug 2024 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448736; cv=none; b=BtfeTNEjq8YsNTbuC+uTt6Y6XrTN8t3Fs6pmYyGZ7MqgnC19iRkr5P3ajRRG/jkbOMDAbhsPsCg5RjGI4yTaWJrlFdm+KMmg9ZXvuBI/h2GroB/4BdK3laEuyGWd104rdjz4mxD8VLFzHpVnJDqUBzEEQP7zEow3QiJ5y3sADOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448736; c=relaxed/simple;
	bh=6WSeuLaXwifPRAaTM0LFwnZeTHbNCde6+9WvhSmdpfQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E5RPP2OQ2qp9beR3F5bDJYHSTmUSm/gMYPL7lGWj7xw5tTZoqQv1QS9vUHkMzt+2EH3mIqlIcLKdbnzrTIWMIKUepCHeB2992OYsx+4nwGTYWZZWpu1PKUIngEQYfS4wbBZSV0FkZKt2U6UW2bWkOt3XxRhHL8lY8PdmfeW0w/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wj62h4Tv6z3Rrkh;
	Mon, 12 Aug 2024 15:43:40 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 086111A0188;
	Mon, 12 Aug 2024 15:45:31 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 12 Aug
 2024 15:45:30 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 0/2] Fixes about delegation.
Date: Mon, 12 Aug 2024 07:37:44 +0000
Message-ID: <20240812073746.3070616-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)

Fixes about delegation.

Chen Ridong (2):
  cgroup: update comment about delegation
  cgroup: Disallow delegatee to write all interfaces outsize of cgroup
    ns

 Documentation/admin-guide/cgroup-v2.rst | 6 +++---
 kernel/cgroup/cgroup.c                  | 8 +++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.34.1


