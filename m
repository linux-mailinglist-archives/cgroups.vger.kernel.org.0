Return-Path: <cgroups+bounces-9347-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B586B32666
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 04:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D868CAA5947
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 02:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBA81F584C;
	Sat, 23 Aug 2025 02:09:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FA11CA0;
	Sat, 23 Aug 2025 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755914947; cv=none; b=jEBIxsE1PzuCdE7zS/CGoy2ZXTTK7/es0UBiM5XkSwuocIRwrr4m+sVFZIzdLTQ9AqAmhnbxkHP6sWLBn/F2b5mNquqQf+QoDpWYPRYcEY0gGP16R7pZzdeSVQyigiQFYRg73GttHC6/iRFKQYr5xdsvj1zf26QfADgHctdQFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755914947; c=relaxed/simple;
	bh=cqkDWPR8RC8oj4EZLTDgS6ebNF9YbeDoHZokRo9CFOM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZdeGtOcAB3/ozX6YLoYc+MmNRG/CpdrerH33L7l0nwmKustZqR+qvPTX4yyxnTdaA+GxXyp3sJNXUwDuhN+l71YsMLBAESbahmQVkTy4jVBXlldKNlgb1fldgVRzYjswUDJ7cV6iY+mTnx954dsdDACK0H9bWPWZtbJ+6T1Tzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c80q146KhzKHMwB;
	Sat, 23 Aug 2025 10:09:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 183371A0AEB;
	Sat, 23 Aug 2025 10:09:01 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgDnoq67IqloteMZEg--.14315S2;
	Sat, 23 Aug 2025 10:09:00 +0800 (CST)
Message-ID: <cb11ed18-b50e-4c2c-ae59-ae7dd8b51921@huaweicloud.com>
Date: Sat, 23 Aug 2025 10:08:59 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 0/3] some optimization for cpuset
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250818064141.1334859-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250818064141.1334859-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDnoq67IqloteMZEg--.14315S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1kuw43Ary8uryUXF1rXrb_yoWDtrb_CF
	y8ZFy0kry3JF4xta1Skrn3ArWvgF4UCrykAFykXr42yFn3Arn7Zr1Ut3yrXr17Xw1fJr15
	ZasFyFn5JwsrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/18 14:41, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> This patch series contains several cpuset improvements:
> 
> 1. Decouple cpuset and tmpmasks allocation/freeing.
> 2. Add cpuset_full_[un]lock helpers.
> 
> ---
> v4:
>  - update the commit message for patch 3.
> 
> v3:
>  - fix typos and comment errors.
>  - rename cpus_read_cpuset_[un]lock to cpuset_full_[un]lock
> 
> v2:
>  - dropped guard helper approach, nusing new helper instead.
>  - added patches for decoupling cpuset/tmpmasks allocation
> 
> Chen Ridong (3):
>   cpuset: decouple tmpmasks and cpumasks freeing in cgroup
>   cpuset: separate tmpmasks and cpuset allocation logic
>   cpuset: add helpers for cpus read and cpuset_mutex locks
> 
>  kernel/cgroup/cpuset-internal.h |   2 +
>  kernel/cgroup/cpuset-v1.c       |  12 +-
>  kernel/cgroup/cpuset.c          | 220 +++++++++++++++++---------------
>  3 files changed, 122 insertions(+), 112 deletions(-)
> 

Hi Longman,

Looking forward to your review of this series again. Would greatly appreciate it.

-- 
Best regards,
Ridong


