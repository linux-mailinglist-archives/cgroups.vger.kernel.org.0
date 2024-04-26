Return-Path: <cgroups+bounces-2710-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC68B2F91
	for <lists+cgroups@lfdr.de>; Fri, 26 Apr 2024 06:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19C01F23168
	for <lists+cgroups@lfdr.de>; Fri, 26 Apr 2024 04:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980913A241;
	Fri, 26 Apr 2024 04:55:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20911335C7;
	Fri, 26 Apr 2024 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107312; cv=none; b=P59sBW5Iv72iJduGrgH02bf62v5rjs7WbePgwC/CoOu3ilkWUFjobaby7Aw/4Ez/9vzweU+FBOALGVvxf7mtmBYRtTVS9ygenuinJSWa4g55//LL9PV0w784i4fJpKEzTmMu8gBznCtzkzjpxI0ev/sLL0vlUkeFq40Q/u0GJS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107312; c=relaxed/simple;
	bh=BCoNOVbv1EcALw55loUqG1wks8q6Qvt0feIcYXhLxv4=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=qa7eYwzX05oy7UeuHVzgGfM2fmAoL5QZumgxvKVShYWD3NLzHAy/uA3IMPrqtrm+CdW/u9KbCSocF1/cW08oreeFEhe4Efq30S+jv1Ocv1ndPRsaAqTfLeCQOiXqYCnBolyvduBqDlXS/KkBSsflbDw8cUi0yPMyF94XvPDDTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VQgM44kNKzNnn1;
	Fri, 26 Apr 2024 12:52:32 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 0062214011D;
	Fri, 26 Apr 2024 12:55:06 +0800 (CST)
Received: from [10.67.109.150] (10.67.109.150) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 12:55:05 +0800
Message-ID: <5b5da2d3-37b3-60ee-5a94-149094cbe9dc@huawei.com>
Date: Fri, 26 Apr 2024 12:55:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes
 Weiner <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Lu Jialin <lujialin4@huawei.com>
Subject: [QUESTION]cgroup mount return -EBUSY
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Hello

I encountered a problem when I try to unmount the subsystem right after
all it's subcgroups are removed, the cgroup_root would remain. Mounting
this subsystem to another cgroup_root would return -EBUSY.

The problem could be reproduced with the following script.

test.sh:

mkdir /tmp/test1
mount -t cgroup -o pids pids /tmp/test1
mkdir /tmp/test1/test
rmdir /tmp/test1/test
umount /tmp/test1
mkdir /tmp/test
mount -t cgroup -o pids,cpu none /tmp/test

test.sh should return this.
mount: mounting none on /tmp/test failed: Device or resource busy.

It seems that when unmounting /tmp/test1, the original cgroup_root for
this PID is not released.
/test # cat /proc/cgroups

#subsys_name    hierarchy       num_cgroups     enabled

cpuset  0       1       1

cpu     0       1       1

cpuacct 0       1       1

blkio   0       1       1

devices 0       1       1

freezer 0       1       1

net_cls 0       1       1

perf_event      0       1       1

net_prio        0       1       1

hugetlb 0       1       1

pids    1       1       1

rdma    0       1       1

misc    0       1       1

debug   0       1       1

