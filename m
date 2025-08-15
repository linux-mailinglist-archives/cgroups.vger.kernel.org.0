Return-Path: <cgroups+bounces-9196-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D87B27433
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 02:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553B0582FF8
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 00:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA633770B;
	Fri, 15 Aug 2025 00:44:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A51448E0;
	Fri, 15 Aug 2025 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218669; cv=none; b=WPTYXAKF5l5eUdd5gzxfx6Tr3VPcC2JGYsn6PAde3RY6c/E3AFI+AXCkpzN+/sUut1zZPgxfZufte/bccT6iBSHiCRZJOvt916WNt7yx0pmiJC8ZePlHMAbMS9anJdIazNKrLlibdeDIUApEzDs09DlgWTRWhfcGr8CbxI7x++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218669; c=relaxed/simple;
	bh=in5/e9K29POYK+w2j7fguaF7LGKrAYCxoSjAZejQTvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYJHDv12rVroE+E+ltka4K65NDogpOv86MIcf4mVMAyEyousk2eo3WFR8FHKUGFnzHvOMv9OH3uhJhXRbCDFqvkweVGptd1wl6eJie24vaj2Kxi5c4SIVn9f0C1sTdRdSPCu+T8UT32EdLoHqmYIN3IM4VQi3GcImeK5taziGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c33K52gHhzYQv42;
	Fri, 15 Aug 2025 08:44:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EF1221A06DC;
	Fri, 15 Aug 2025 08:44:23 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgBn39nigp5oRAeWDg--.35570S2;
	Fri, 15 Aug 2025 08:44:20 +0800 (CST)
Message-ID: <bd043822-29b2-49f4-864d-6658741f572c@huaweicloud.com>
Date: Fri, 15 Aug 2025 08:44:17 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 3/4] cpuset: separate tmpmasks and cpuset allocation
 logic
To: kernel test robot <lkp@intel.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, longman@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com,
 christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-4-chenridong@huaweicloud.com>
 <202508140524.S2O4D57k-lkp@intel.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <202508140524.S2O4D57k-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBn39nigp5oRAeWDg--.35570S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyftw4xXrWkJr4fXr4DCFg_yoW8CFW3pa
	y8W390yrs5Xr1xGa1kWa1jvF1Sgan8Jry5Ww1DWr1UZa9FvF1UWr4I9r45JFnF9F1vgFyf
	GFZI9Fn3tw18u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/14 5:28, kernel test robot wrote:
> Hi Chen,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on tj-cgroup/for-next]
> [also build test WARNING on linus/master v6.17-rc1 next-20250813]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Ridong/cpuset-remove-redundant-CS_ONLINE-flag/20250813-164651
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
> patch link:    https://lore.kernel.org/r/20250813082904.1091651-4-chenridong%40huaweicloud.com
> patch subject: [-next v2 3/4] cpuset: separate tmpmasks and cpuset allocation logic
> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250814/202508140524.S2O4D57k-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508140524.S2O4D57k-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508140524.S2O4D57k-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> Warning: kernel/cgroup/cpuset.c:422 function parameter 'pmasks' not described in 'alloc_cpumasks'
> 

Hi all,

Thank you for the warning about the comment issue - I will fix it in the next version.

I will be appreciate if you can review this patch. If you have any feedback, I can update the entire
series together.

-- 
Best regards,
Ridong


