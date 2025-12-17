Return-Path: <cgroups+bounces-12388-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1A2CC5C26
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 03:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 837183009808
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F2E225402;
	Wed, 17 Dec 2025 02:18:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AAC2AD13;
	Wed, 17 Dec 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765937937; cv=none; b=f9Ogsy5pQvD8d8EzFZqUgmugp3d6XgZhhWOuiM04YWslgyoxrGzEP1VymiKMIbng5zMAlZwYchvzt3erDg3Kw26xDqWcYmXbqvvh+5YLQq7RsmiELBLlPARI8DlWsxfna8gbv3rwZfUTaewgv//1JE2KJG52SydiJpKomNwhYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765937937; c=relaxed/simple;
	bh=ox9eUnQJFWGv8IgaLd2c8Qr2KB/3lNq1vCnjgc+tUn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSBHnirNyyYFpSDQBaeScvy++vEoXbkGyfaRv2CMeo2FQQwQ0IMUdZm1DZyLFGpzR+JOfwWR1dxx6mRk/HS1G1LNaUqTN+M/q6YIgt6Hin1FS6Gqtu5M1rKBSz7PvWNN8MmNjq0pSNMniySRHyQm1lvHnxVVI/txi5HR+DeDk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dWHXd6j4KzKHMMY;
	Wed, 17 Dec 2025 10:18:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 610BD4057D;
	Wed, 17 Dec 2025 10:18:50 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgA3hRMJE0Jp2f7MAQ--.44126S2;
	Wed, 17 Dec 2025 10:18:50 +0800 (CST)
Message-ID: <503ec3db-b205-444a-9c92-08eaac14f015@huaweicloud.com>
Date: Wed, 17 Dec 2025 10:18:48 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: add cpuset1_online_css helper for
 v1-specific operations
To: Waiman Long <llong@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com
References: <20251216012845.2437419-1-chenridong@huaweicloud.com>
 <sowksqih3jeosuqa7cqnnwnexrgklttpjpfzdxjv2tmc7ym45r@vrmubshmlyqi>
 <a45617e5-7710-49e8-a231-511ae77b5e51@huaweicloud.com>
 <vprpzrc6g4ad4m2pwj6j5xp3do7pd7djivhgeoutp6z2qmeq22@ttgkqpew7uo4>
 <5a35692f-2800-4fd4-9c23-97d0284293df@redhat.com>
 <3785c9ca-5bdb-4ff2-9c8f-a3515ba58538@huaweicloud.com>
 <032b60c1-4a5d-44e1-be9c-05f84172a8ca@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <032b60c1-4a5d-44e1-be9c-05f84172a8ca@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgA3hRMJE0Jp2f7MAQ--.44126S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4UCr1kGF1rurW8XF1DZFb_yoW5JF13pF
	yUGa4UtFWkJrW2kwn2vw1fXF4Yq3WktFy5Xrn5uryYyrZ8t3ZF9rsF9FZI9FyUGr1kurW8
	tFW3KrZ3uFyDArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/17 10:03, Waiman Long wrote:
> 
> On 12/16/25 7:53 PM, Chen Ridong wrote:
>>
>> On 2025/12/16 22:58, Waiman Long wrote:
>>> On 12/16/25 9:03 AM, Michal Koutný wrote:
>>>> On Tue, Dec 16, 2025 at 08:13:53PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>>> Regarding the lock assertions: cpuset_mutex is defined in cpuset.c and is not visible in
>>>>> cpuset-v1.c. Given that cpuset v1 is deprecated, would you prefer that we add a helper to assert
>>>>> cpuset_mutex is locked? Is that worth?
>>>> It could be un-static'd and defined in cpuset-internal.h. (Hopefully, we
>>>> should not end up with random callers of the helper but it's IMO worth
>>>> it for docs and greater safety.)
>>> I would suggest defining a "assert_cpuset_lock_held(void)" helper function and put the declaration
>>> in include/linux/cpuset.h together with cpuset_lock/unlock() to complete the full set. This will
>>> allow other kernel subsystems to acquire the cpuset_mutex and assert that the mutex was held.
>> Considering potential use by other subsystems, this is worthwhile. I will add the helper.
>>
>>>>> Should we guard with !cpuset_v2() or !is_in_v2mode()?
>>>>>
>>>>> In cgroup v1, if the cpuset is operating in v2 mode, are these flags still valid?
>>>> I have no experience with this transitional option so that made me look
>>>> at the docs and there we specify it only affects behaviors of CPU masks,
>>>> not the extra flags. So I wanted to suggest !cpuset_v2(), correct?
>>> The "cpuset_v2_mode" mount flag is used for making the behavior of cpuset.{cpus,mems}.effective in
>>> v1 behave like in v2. It has no effect on other v1 specific control files. So cpuset1_online_css()
>>> should only be called if "!cpuset_v2()".
>>>
>> If cpuset1_online_css() is only called under the condition !cpuset_v2(), a compile-time option might
>> suffice? When CONFIG_CPUSETS_V1=n, cpuset1_online_css could be defined as an empty inline function.
> 
> cpuset_v2() includes "!IS_ENABLED(CONFIG_CPUSETS_V1)", so the compiler should compile out the call
> to cpuset1_online_css() if CONFIG_CPUSETS_V1 isn't defined. If you want to make cpuset1_online_css()
> conditional on CONFIG_CPUSETS_V1, I am fine with that too.
> 

The cpuset1_online_css() resides in cpuset-v1.c and is only compiled when CONFIG_CPUSETS_V1=y. For
cases where CONFIG_CPUSETS_V1=n, I have defined it as an empty inline function.

-- 
Best regards,
Ridong


