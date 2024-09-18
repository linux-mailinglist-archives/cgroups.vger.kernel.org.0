Return-Path: <cgroups+bounces-4904-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFDD97BA4E
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2024 11:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759FC28280D
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2024 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F0B17A590;
	Wed, 18 Sep 2024 09:44:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A816C84B;
	Wed, 18 Sep 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652697; cv=none; b=Fj7BKd5EkMZZwTHPao508soXzZCFV/So6lPFteR0ESKZg0dKxVEDzDhqtdCYnNN6C47ved/uyRUmas0LhFkOurNs18/X05S+QP5d+WMktDqfRfN2niDm1n0b73QovDLNzmH/E9S+427INrfr4Jaiui42KH1nyyC7E4AVBsn+IQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652697; c=relaxed/simple;
	bh=J+xlb3JjU3ObgVrsDkpQPTfkjVcFKet5vIWJwjciZsU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ubrpz0ZOPBYFo9mPgjJK6cGtqn7yoTcuySVBU+Q8PbKCnK2l+KAumhTqeSN4sW1Hkfbt8E+sSp402De6awTCdlNkfU5QrRGkCS37ORpsV4VJ1g9q3i0kIOSffHc9HR75s4m/YfyOynat83+FKJqlnQV0RoKDw/wJvhyB3+f3uD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X7tz70z37z4f3jMf;
	Wed, 18 Sep 2024 17:44:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EA8391A018D;
	Wed, 18 Sep 2024 17:44:50 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgAHiMQPoepmcYGjBg--.10672S2;
	Wed, 18 Sep 2024 17:44:48 +0800 (CST)
Message-ID: <eaa664da-8d88-486c-9793-09a97d8c607a@huaweicloud.com>
Date: Wed, 18 Sep 2024 17:44:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
From: Chen Ridong <chenridong@huaweicloud.com>
To: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240913131720.1762188-1-chenridong@huawei.com>
Content-Language: en-US
In-Reply-To: <20240913131720.1762188-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHiMQPoepmcYGjBg--.10672S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4UXryDZw13Aw4DZw1DJrb_yoWDKFb_C3
	yxuF9Y9ryfJr12vanakFn3uF40kr45C3WFkr1UtrZIqFnxXrn3WFs2gryYvwsru3Z7Xry0
	yasIyw4vvFn8XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/13 21:17, Chen Ridong wrote:
> The patch 1 have been reviewed by Michal Koutný.
> Add two patches as follow.
> 
> v4:
> - add a patch to document that saturating the system_wq is not permitted.
> - add a patch to adjust WQ_MAX_ACTIVE from 512 to 2048.
> 
> v3:
> - optimize commit msg.
> 
> Link v1: https://lore.kernel.org/cgroups/20240607110313.2230669-1-chenridong@huawei.com/
> Link v2: https://lore.kernel.org/cgroups/20240719025232.2143638-1-chenridong@huawei.com/
> Link v3: https://lore.kernel.org/cgroups/20240817093334.6062-1-chenridong@huawei.com/
> 
> 
> Chen Ridong (3):
>    cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
>    workqueue: doc: Add a note saturating the system_wq is not permitted
>    workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048
> 
>   Documentation/core-api/workqueue.rst | 8 ++++++--
>   include/linux/workqueue.h            | 2 +-
>   kernel/bpf/cgroup.c                  | 2 +-
>   kernel/cgroup/cgroup-internal.h      | 1 +
>   kernel/cgroup/cgroup.c               | 2 +-
>   5 files changed, 10 insertions(+), 5 deletions(-)
> 
Friendly ping.


