Return-Path: <cgroups+bounces-9239-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABFB28930
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 02:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F591CC4001
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 00:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E38E55A;
	Sat, 16 Aug 2025 00:21:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E736BA4A;
	Sat, 16 Aug 2025 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755303695; cv=none; b=ovfv6FJ1KEiV43LSCSgjmJGFQ1a7n46LiLbfNpaUVZFW6Doh36q94tBD+JRPaxRkmUsMig3jV8pPcyYAGqB9Tyr9GpjoTe3LxTZNdplYvjt0hdWJo2TMR6t14wRpFb5lBKEoMxsSRcHI/fJAY/6wsIe8YR5QHDNotf/wsngo+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755303695; c=relaxed/simple;
	bh=whir1zdGiHIN02BGkjkiwOncIcFAOkCAozZd0GwWNP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cK/QwOABzZpCdqGUkR7IeKIpuW3i9DwCPpzoH2hHN2EOF1MIfVAuuYzVTQYA8BEcTRYHu2wxWdeY8tyycxwx6DmL3/ii6LAs9nBZRrwag1aageeRxi4xj74AgYfP/nhzQCLnR7n2tBStsPC++5c0zVn5PvdMNGyKxDr9gNG7ILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3fmB32TXzYQtsk;
	Sat, 16 Aug 2025 08:21:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0848A1A018D;
	Sat, 16 Aug 2025 08:21:29 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgD3A7YEz59on7ATDw--.30859S2;
	Sat, 16 Aug 2025 08:21:25 +0800 (CST)
Message-ID: <2f4b260d-a4a7-458f-966c-17fab945fc37@huaweicloud.com>
Date: Sat, 16 Aug 2025 08:21:23 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 3/4] cpuset: separate tmpmasks and cpuset allocation
 logic
To: Waiman Long <llong@redhat.com>, kernel test robot <lkp@intel.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com,
 christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-4-chenridong@huaweicloud.com>
 <202508140524.S2O4D57k-lkp@intel.com>
 <bd043822-29b2-49f4-864d-6658741f572c@huaweicloud.com>
 <15b47a34-ea8a-4a07-bc1e-5ba886010721@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <15b47a34-ea8a-4a07-bc1e-5ba886010721@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3A7YEz59on7ATDw--.30859S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWfCryUtF1rWw47Kw4xXrb_yoW8Kr1fpF
	W8Xa90yFs8Xr1xGan2gw1vvF1jgan5Jry5Wwn8Gr1UZFZFvF1UWr4I9r45WFnFg3ZagFyS
	yFZxWFySvw1UuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/16 3:15, Waiman Long wrote:
> 
> On 8/14/25 8:44 PM, Chen Ridong wrote:
>>
>> On 2025/8/14 5:28, kernel test robot wrote:
>>> Hi Chen,
>>>
>>> kernel test robot noticed the following build warnings:
>>>
>>> [auto build test WARNING on tj-cgroup/for-next]
>>> [also build test WARNING on linus/master v6.17-rc1 next-20250813]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url:   
>>> https://github.com/intel-lab-lkp/linux/commits/Chen-Ridong/cpuset-remove-redundant-CS_ONLINE-flag/20250813-164651
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
>>> patch link:    https://lore.kernel.org/r/20250813082904.1091651-4-chenridong%40huaweicloud.com
>>> patch subject: [-next v2 3/4] cpuset: separate tmpmasks and cpuset allocation logic
>>> config: x86_64-defconfig
>>> (https://download.01.org/0day-ci/archive/20250814/202508140524.S2O4D57k-lkp@intel.com/config)
>>> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
>>> reproduce (this is a W=1 build):
>>> (https://download.01.org/0day-ci/archive/20250814/202508140524.S2O4D57k-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202508140524.S2O4D57k-lkp@intel.com/
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> Warning: kernel/cgroup/cpuset.c:422 function parameter 'pmasks' not described in 'alloc_cpumasks'
>> Hi all,
>>
>> Thank you for the warning about the comment issue - I will fix it in the next version.
>>
>> I will be appreciate if you can review this patch. If you have any feedback, I can update the entire
>> series together.
>>
> Sorry for not responding to this patch. It looked reasonable to me. I did miss the error in the
> comment though. Fortunately it was caught by the test robot.
> 
> Cheers,
> Longman

Thank you for your feedback.

-- 
Best regards,
Ridong


