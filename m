Return-Path: <cgroups+bounces-2786-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B238BC598
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 03:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FDD2823FC
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 01:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458163C463;
	Mon,  6 May 2024 01:50:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025DC42052;
	Mon,  6 May 2024 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714960211; cv=none; b=E8y/Z3PGM+HQJn0QC8/r+EpMevD3A9M/I0Sk9/owOHjT8e/Pusx3X5+T0HogvTpgA2PCRLoD8K9aYY5tZMEpTJ23SSuoj7R4DyVtiAj8UgcAf5LMVAEVbSvEB6EgJWOGUvlp5G4j/26puE0yI5YrGGHHqYZ24JlpgqnBlQQ/FlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714960211; c=relaxed/simple;
	bh=k8CAQVXY/1SB5nrtKOe5IPn90LXyDKDIfdFZpHC2h7A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=QSTUD7df5tXNhjHK2KBSEPaMqWUCr4v7xc0JJINK0yhFzuUOb3L58fNyR/1VwJCbW1tLQa+z1Dn38aYqCPvIO3ZYZD2UIDBijSzA8PiBPHBOQE5WsTOuGhT5KzTNPyuWP1JEIWq9T8fjkfRoJvn5dpQyiB2qP9V5R8xsT8L2mnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VXklY4qgxzYspc;
	Mon,  6 May 2024 09:46:17 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id C46E3140444;
	Mon,  6 May 2024 09:50:04 +0800 (CST)
Received: from [10.67.109.150] (10.67.109.150) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 09:50:04 +0800
Message-ID: <7fd75461-2083-3da5-f25b-d77a0e21b7bc@huawei.com>
Date: Mon, 6 May 2024 09:50:03 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION]cgroup mount return -EBUSY
Content-Language: en-US
From: Lu Jialin <lujialin4@huawei.com>
To: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes
 Weiner <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <5b5da2d3-37b3-60ee-5a94-149094cbe9dc@huawei.com>
In-Reply-To: <5b5da2d3-37b3-60ee-5a94-149094cbe9dc@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)

ping

On 2024/4/26 12:55, Lu Jialin wrote:
> Hello
> 
> I encountered a problem when I try to unmount the subsystem right after
> all it's subcgroups are removed, the cgroup_root would remain. Mounting
> this subsystem to another cgroup_root would return -EBUSY.
> 
> The problem could be reproduced with the following script.
> 
> test.sh:
> 
> mkdir /tmp/test1
> mount -t cgroup -o pids pids /tmp/test1
> mkdir /tmp/test1/test
> rmdir /tmp/test1/test
> umount /tmp/test1
> mkdir /tmp/test
> mount -t cgroup -o pids,cpu none /tmp/test
> 
> test.sh should return this.
> mount: mounting none on /tmp/test failed: Device or resource busy.
> 
> It seems that when unmounting /tmp/test1, the original cgroup_root for
> this PID is not released.
> /test # cat /proc/cgroups
> 
> #subsys_name    hierarchy       num_cgroups     enabled
> 
> cpuset  0       1       1
> 
> cpu     0       1       1
> 
> cpuacct 0       1       1
> 
> blkio   0       1       1
> 
> devices 0       1       1
> 
> freezer 0       1       1
> 
> net_cls 0       1       1
> 
> perf_event      0       1       1
> 
> net_prio        0       1       1
> 
> hugetlb 0       1       1
> 
> pids    1       1       1
> 
> rdma    0       1       1
> 
> misc    0       1       1
> 
> debug   0       1       1
> 

