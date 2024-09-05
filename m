Return-Path: <cgroups+bounces-4715-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4897196DAC9
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 15:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC03A1F234F8
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB119DF86;
	Thu,  5 Sep 2024 13:49:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352F19DF64;
	Thu,  5 Sep 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544180; cv=none; b=bC3xYJJFpY9Ci4mZOSRBFpT2FN0H+DtYKNr9MRIm709WOEQPNG71AwaIk2MRf7LI6O+Nex90WLldqFThJrshSXvzP9jegdxPp9wA/6XaYykMZ1dcrti5Hyk4TI3zfZNxtA0YuneZrLnKd/ILifLa1C4dpoO1EP+zT+Ir7+3+bQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544180; c=relaxed/simple;
	bh=LtV2yQTT4sOAKEHM9y6Wr1M4o+wkb+zsIagiNZ1gyXE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CrzYoLfm6Aa8ndBdQSowXtscc35JJTfhOnmgj0i8bQT3Hip1LjtK4zrGk9VwQfDmCrf+0wWeo/cIgk0HewKutsfqE5X88fUOT01JHUF9PHWCQfZ9+2Vm8TDqZUxgl1kNEEXAch6fv6u2ClQidWQRR6Ch5yMkaHfG+YM/CnDBtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X01134FlmzyRF4;
	Thu,  5 Sep 2024 21:48:55 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id D70D0180AE6;
	Thu,  5 Sep 2024 21:49:34 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 5 Sep
 2024 21:49:34 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v1 -next 0/3] Some optimizations about freezer
Date: Thu, 5 Sep 2024 13:41:27 +0000
Message-ID: <20240905134130.1176443-1-chenridong@huawei.com>
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

We optimized the freezer to reduce redundant loops. We add a selftest to
ensure our optimizations cause no harm, and we confirmed that the
performance can be improved.

We tested the following subtree: D, E, F and G each have n children.
        A
       / \
      B   C
    / | \  \
    D E F   G
   /  |  \   \
 1-n 1-n 1-n  0-n

Our test is to freeze A B C D E F G, and then unfreeze A B C D E F G.
We measured the elapsed time.

	BEFORE(ns)	AFTER(ns)	SAVED(ns)
n=10	142679950	139666014	3,013,936
n=100	199832160	192773032	7,059,128
n=1000	488595100	414901570	73,693,530

As shown above, the larger the value of n, the more significant the time
savings can be. If tested with a deeper hierarchy, the difference could
become even more apparent.

Chen Ridong (3):
  cgroup/freezer: Reduce redundant traversal for cgroup_freeze
  cgroup/freezer: Reduce redundant propagation for
    cgroup_propagate_frozen
  cgroup/freezer: Add freeze selftest

 include/linux/cgroup-defs.h                   |   2 +-
 kernel/cgroup/freezer.c                       |  72 ++++++++----
 .../testing/selftests/cgroup/test_freezer.sh  | 111 ++++++++++++++++++
 3 files changed, 160 insertions(+), 25 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_freezer.sh

-- 
2.34.1


