Return-Path: <cgroups+bounces-4665-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD05967D19
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 02:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BA72818B3
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 00:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F5847C;
	Mon,  2 Sep 2024 00:56:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A7469D;
	Mon,  2 Sep 2024 00:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725238612; cv=none; b=X7say8u1LF0gVRAGPI6r8qTFy+rRekbNVDQ8rOtlqQzIbps7X4H4+rkE0sRzeJv0HgSx3M1nMgnYD+crWVAdocKQdf22nIzLdMM4IQ5h7pNVi+i22PUK/WjKsoCC45rhde2aFomiczWXhX6Hk5nBWEx0T0GYjlgbhgefhBqRewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725238612; c=relaxed/simple;
	bh=ZK+ox3o1MRSdl2hAx8rO2qtiUlqpQxKb4PV3QSJeewE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocXzcx7EkNEGZm6lDyuUI8qkhe1qaH8m2HJqDNy/jw0hSA3TQuCNfn5DEqCIT0u7eAEmQjwINcLGO0lBKmXHul6sK20By9kA8mXVvnR6AgW7CEULzlRZ2Zw8YKVtscFNf9CLrcLiqJQMiReK24NG8UcsVmm1jyW9YirbRQamHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wxr1C0zqkz4f3jY3;
	Mon,  2 Sep 2024 08:56:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 032B11A018D;
	Mon,  2 Sep 2024 08:56:46 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgBHfGFLDdVmjfqQAA--.28726S2;
	Mon, 02 Sep 2024 08:56:44 +0800 (CST)
Message-ID: <5fc72de4-3894-4d97-99b3-940615b961ba@huaweicloud.com>
Date: Mon, 2 Sep 2024 08:56:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup] cgroup/cpuset: Move cpu.h include to
 cpuset-internal.h
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, kernel test robot <lkp@intel.com>
References: <20240831135703.881282-1-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20240831135703.881282-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHfGFLDdVmjfqQAA--.28726S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1fJw17ArWrGw1fAFyDtrb_yoW8Cw1kpF
	4qkFy5Jw45AF1UCw1Du3Wa9F9Ygw4rGr1UK34DWw1DZ3W2yF1v9r1DurnIqr10kFZFgr1j
	qFZI9r4S9a4jqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/8/31 21:57, Waiman Long wrote:
> The newly created cpuset-v1.c file uses cpus_read_lock/unlock() functions
> which are defined in cpu.h but not included in cpuset-internal.h yet
> leading to compilation error under certain kernel configurations.  Fix it
> by moving the cpu.h include from cpuset.c to cpuset-internal.h. While
> at it, sort the include files in alphabetic order.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408311612.mQTuO946-lkp@intel.com/
> Fixes: dd46bd00ab4c ("cgroup/cpuset: move relax_domain_level to cpuset-v1.c")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset-internal.h | 7 ++++---
>   kernel/cgroup/cpuset.c          | 1 -
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 8c113d46ddd3..976a8bc3ff60 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -3,11 +3,12 @@
>   #ifndef __CPUSET_INTERNAL_H
>   #define __CPUSET_INTERNAL_H
>   
> -#include <linux/union_find.h>
> +#include <linux/cgroup.h>
> +#include <linux/cpu.h>
>   #include <linux/cpumask.h>
> -#include <linux/spinlock.h>
>   #include <linux/cpuset.h>
> -#include <linux/cgroup.h>
> +#include <linux/spinlock.h>
> +#include <linux/union_find.h>
>   
>   /* See "Frequency meter" comments, below. */
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 13016ad284a1..a4dd285cdf39 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -24,7 +24,6 @@
>   #include "cgroup-internal.h"
>   #include "cpuset-internal.h"
>   
> -#include <linux/cpu.h>
>   #include <linux/init.h>
>   #include <linux/interrupt.h>
>   #include <linux/kernel.h>

Thank you for fixing this.

Best regards,
Ridong


