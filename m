Return-Path: <cgroups+bounces-12313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BB2CB1C56
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 04:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4617307F8C8
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 03:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF3023EAAA;
	Wed, 10 Dec 2025 03:07:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB3D8F5B;
	Wed, 10 Dec 2025 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765336030; cv=none; b=F7l8DRx/3I2Gj7Qhb6Utp8LVM9ZvAIDtggNUkjeFwYCFwTP7ATmlLRROndQ2lI5XlxEot0YIdI+jv4BFFR+2j8ZXK/fF0UuuOxNfNY2p77v4gbBPCGiNXE2kmQToPAiK+HKZYPFOc4YBAjSVeTWrJiE3dZ2wZX9a2b/c90yJ+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765336030; c=relaxed/simple;
	bh=gA9MCm18S13ALbZjWHailNhGRkiICjoA+omBT6zshmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A143HSwNx9ts2pAowqzxmCz768I7zqWpxa4aEpvIxtzZt3FqEiVXCrOyAr9wKr+dgpDQt2FdaOzTYmj0BF3CpxSjrdLGj+pdGfltb/zKJ4Teln+2Kb3nXqWwCKl7RM91ikGLRN7tLjg5pl16HsBFoqu5bzlqQEKHyfMB/0HkWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dR0wS4BQWzKHLxs;
	Wed, 10 Dec 2025 11:06:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 056D41A06DD;
	Wed, 10 Dec 2025 11:07:00 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgC34J3Q4zhpH3jjBA--.16323S2;
	Wed, 10 Dec 2025 11:06:57 +0800 (CST)
Message-ID: <1189acd5-4908-4a51-a7bc-8b52a8489140@huaweicloud.com>
Date: Wed, 10 Dec 2025 11:06:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/2] memcg: remove mem_cgroup_size()
To: kernel test robot <lkp@intel.com>, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, zhengqi.arch@bytedance.com,
 lorenzo.stoakes@oracle.com
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
References: <20251209130251.1988615-3-chenridong@huaweicloud.com>
 <202512100924.LqJqXM7P-lkp@intel.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <202512100924.LqJqXM7P-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC34J3Q4zhpH3jjBA--.16323S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr17ZrWkCF13AryfuF1UGFg_yoW8XF48pa
	yruw4DtF4rWryfWa1kK3yjvayFqa1kXw13Wr98uw18Za429r1DAFyS9r43trWjgr97Kryf
	Zan8WF1ft3yUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/12/10 9:35, kernel test robot wrote:
> Hi Chen,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on next-20251209]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Ridong/memcg-move-mem_cgroup_usage-memcontrol-v1-c/20251209-211854
> base:   next-20251209
> patch link:    https://lore.kernel.org/r/20251209130251.1988615-3-chenridong%40huaweicloud.com
> patch subject: [PATCH -next 2/2] memcg: remove mem_cgroup_size()
> config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20251210/202512100924.LqJqXM7P-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251210/202512100924.LqJqXM7P-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512100924.LqJqXM7P-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    mm/vmscan.c: In function 'apply_proportional_protection':
>>> mm/vmscan.c:2488:63: error: invalid use of undefined type 'struct mem_cgroup'
>     2488 |                 unsigned long usage = page_counter_read(&memcg->memory);
>          |                                                               ^~
> 
> 
> vim +2488 mm/vmscan.c
> 

Oh, I missed CONFIG_MEMCG=n case, will fix it, thanks.

-- 
Best regards,
Ridong


