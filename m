Return-Path: <cgroups+bounces-12345-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F076CB889C
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 10:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A030030505B6
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 09:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F97315D36;
	Fri, 12 Dec 2025 09:54:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E4314B66;
	Fri, 12 Dec 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765533245; cv=none; b=CYBAMIhzso6JajmsBi3KiijFnG956nICdp3dZWK7R06eCOJZ38NMPAKboH2uVeUXFv352KLVnR4JwTUj9t3JEgNw8Qmdbub5dqrSkckuO136f+NPzAMBrKvHLKWlc2tsXZyhr6Inx4Z1zFh+wg2tJurHVeE7se+GcrqqTjEf1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765533245; c=relaxed/simple;
	bh=e+PVJXn3SNu5RdUqOToWRAPThm1ywlKM0+e510R3cNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0gjrboDkDpa+xCwgZAHWHb1PZLju/nuSMGxq+UWQAkUhiHqhsXbCppBV2wTQEYPTWms/77u32IccypCgGElFN0/76mLnNxTano3b6m44l4q8aYCEflUoc8jaywIOzc1uMEerksl0rJgOU0Zy/x8LXs2eqguFTn+fGYz8VWpBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dSPsp34kFzYQv3y;
	Fri, 12 Dec 2025 17:53:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AA6FC1A018D;
	Fri, 12 Dec 2025 17:53:52 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBHJlAq5jtpR9fqBQ--.55492S2;
	Fri, 12 Dec 2025 17:53:48 +0800 (CST)
Message-ID: <5d9ae0e9-d1c3-46cb-9dee-f016359e90f8@huaweicloud.com>
Date: Fri, 12 Dec 2025 17:53:46 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/5] mm/mglru: extend shrink_one for both lrugen and
 non-lrugen
To: kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 david@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 corbet@lwn.net, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, zhengqi.arch@bytedance.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, lujialin4@huawei.com, zhongjinji@honor.com
References: <20251209012557.1949239-4-chenridong@huaweicloud.com>
 <202512121027.03z9qd08-lkp@intel.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <202512121027.03z9qd08-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHJlAq5jtpR9fqBQ--.55492S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyftw4xXrWkGrW3CrW5Awb_yoW8uF1rpF
	WUGw4jvr15Xrs29ayvgF4DWFyjyrs3Gry3GF1kXr1UAay2vF9rGFyI9r4Yqryjg3ykKrWa
	yr97Wrn5t3WjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/12 10:55, kernel test robot wrote:
> Hi Chen,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Ridong/mm-mglru-use-mem_cgroup_iter-for-global-reclaim/20251209-094913
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20251209012557.1949239-4-chenridong%40huaweicloud.com
> patch subject: [PATCH -next 3/5] mm/mglru: extend shrink_one for both lrugen and non-lrugen
> config: x86_64-randconfig-004-20251212 (https://download.01.org/0day-ci/archive/20251212/202512121027.03z9qd08-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251212/202512121027.03z9qd08-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512121027.03z9qd08-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> mm/vmscan.o: warning: objtool: shrink_one+0xeb2: sibling call from callable instruction with modified stack frame
> 

This is the first time I've encountered this warning. While adding
`STACK_FRAME_NON_STANDARD(shrink_one)` resolves it, I noticed this approach isn't widely used in the
codebase. Is this the standard solution, or are there better alternatives?

I've tested that the warning persists even when `shrink_one` is simplified to only call `shrink_lruvec`:

```
static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
{
    shrink_lruvec(lruvec, sc);
}
```

How can we properly avoid this warning without using STACK_FRAME_NON_STANDARD?

-- 
Best regards,
Ridong


