Return-Path: <cgroups+bounces-9438-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCECB37A44
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 08:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1532721A97
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 06:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A651F2D6E77;
	Wed, 27 Aug 2025 06:23:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A6EADC;
	Wed, 27 Aug 2025 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275804; cv=none; b=YnUjDSBzILKqESiEp035FdlLbH9PHVRwMrJIWW6EMmg2HKBxPpMHas79HDxbGvUyenbbUWizv57dOXlGYbuffREr2i06HtRbgb9Qmz2Uj0/aiKGgczQNVgwYLsw6Ig8itEQh6BS19RU2TEesDQ3Mppw9h222kiFhnJVhSAB3zRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275804; c=relaxed/simple;
	bh=Ke8lXNIdOXkz+jWlK0W2U+rUKizzpn/yCf4X+98NMpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdZjZuVyQSDMaxsTlCgWG/NuGXNoNM/JDMg5Htwk59SGYRZW4Q1k+vzOTBAVNVWxb8i6YAaODzrVrb4Zeq+tbACuHov5qGDy1v/IyFWRTKtUrCGVH6hlVvnX60LSnaMA6E1KGk4meYX45oUdosc9SoUaxLX6DOShAc3rJtSj/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cBZGb6JV9zKHNVw;
	Wed, 27 Aug 2025 14:23:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 85E071A0902;
	Wed, 27 Aug 2025 14:23:19 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgDH75ZWpK5o_ivCAQ--.56900S2;
	Wed, 27 Aug 2025 14:23:19 +0800 (CST)
Message-ID: <2b574bb7-0192-4a91-8925-bd4c6cc8a407@huaweicloud.com>
Date: Wed, 27 Aug 2025 14:23:17 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v5 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
To: Waiman Long <llong@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20250825032352.1703602-1-chenridong@huaweicloud.com>
 <20250825032352.1703602-4-chenridong@huaweicloud.com>
 <luegqrbloxpshm6niwre2ys3onurhttd5i3dudxbh4xzszo6bo@vqqxdtgrxxsm>
 <312f3e07-0eb9-4bdf-b5bd-24c84ef5fcc1@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <312f3e07-0eb9-4bdf-b5bd-24c84ef5fcc1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDH75ZWpK5o_ivCAQ--.56900S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF17XryDtw18CFWDur1Utrb_yoW8Zr4xpF
	1jgFyUtF1jvF4fuwn7Za4rXw18tw1xKFWDJF97Jw18ZF9rtFW2vryxKanxuw1Fqr1xC3ya
	va4qgws2934DAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/26 22:43, Waiman Long wrote:
> 
> On 8/26/25 10:23 AM, Michal Koutný wrote:
>> (I wrote this yesterday before merging but I'm still sending it to give
>> my opinion ;-))
>>
>> On Mon, Aug 25, 2025 at 03:23:52AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> cpuset: add helpers for cpus_read_lock and cpuset_mutex locks.
>>>
>>> Replace repetitive locking patterns with new helpers:
>>> - cpuset_full_lock()
>>> - cpuset_full_unlock()
>> I don't see many precedents elsewhere in the kernel for such naming
>> (like _lock and _full_lock()). Wouldn't it be more illustrative to have
>> cpuset_read_lock() and cpuset_write_lock()? (As I'm looking at current
>> users and your accompanying comments which could be substituted with
>> the more conventional naming.)
> Good naming is always an issue. Using cpuset_read_lock/cpuset_write_lock will be more confusing as
> the current locking scheme is exclusive.
>> (Also if you decide going this direction, please mention commit
>> 111cd11bbc548 ("sched/cpuset: Bring back cpuset_mutex") in the message
>> so that it doesn't tempt to do further changes.)
>>
>>
>>> This makes the code cleaner and ensures consistent lock ordering.
>> Lock guards anyone? (When you're touching this and seeking clean code.)
> 
> Yes, I guess we can use lock guards here. You are welcome to send a patch to do that.
> 

I attempted to define the cpuset_full_lock() macro, but the initial implementation was inconsistent
with our coding conventions.
Initial version:

#define cpuset_full_lock() \
  guard(cpus_read_lock)(); \
  guard(mutex)(&cpuset_mutex);

It was suggested to use a do-while construct for proper scoping. but it could not work if we define as:

#define cpuset_full_lock() \
 do { 			   \
  guard(cpus_read_lock)(); \
  guard(mutex)(&cpuset_mutex); \
 } while(0)

So I sent this patch version.

-- 
Best regards,
Ridong


