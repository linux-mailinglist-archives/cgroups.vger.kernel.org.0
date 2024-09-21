Return-Path: <cgroups+bounces-4925-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B917F97DB6A
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 04:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5705F1F221D3
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 02:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B58D7462;
	Sat, 21 Sep 2024 02:06:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62286801;
	Sat, 21 Sep 2024 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726884405; cv=none; b=Sj2L1anj+fUQcQDvzg/Zik8A0Yi2NI5KW6UoKE9BoZRKtEeaW+RPaqYa5KECDKWBB4MGWm687ThDPNbo64ruIeLhUgU9kEPryL87OTPskyIgL65VdtJIimCkmcLVoQiK7zllMdk8WCplnqvotjw7PScGsVRAzg+KCb2mHMe98HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726884405; c=relaxed/simple;
	bh=BokMpfsodCxPgOmoQVW8Mzihk/kLw9fm+azE3LogcqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5uFANzIHGWi4LeYobfdnmcznDirTTBYf61wiBPlOV3mT5p1IeGTUAtMNgXzX4FdM1zeaWzeJiaHnOE5D4NBWyQmpk1CK5z2rR/cU8ARG6/lUSkRmHEekAWmRHBtXueve3Q+39XcD0AhU6DqtwtF5WsBzn06ZoZRYUrFcUBLfj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X9Xg06PT1z4f3jkj;
	Sat, 21 Sep 2024 10:06:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E47AE1A0359;
	Sat, 21 Sep 2024 10:06:31 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgBnm2AmKu5mO5eaBw--.3729S2;
	Sat, 21 Sep 2024 10:06:31 +0800 (CST)
Message-ID: <07168cb9-7d26-4256-bcdc-0f261aba9d53@huaweicloud.com>
Date: Sat, 21 Sep 2024 10:06:30 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
To: Tejun Heo <tj@kernel.org>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, bpf@vger.kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240913131720.1762188-1-chenridong@huawei.com>
 <eaa664da-8d88-486c-9793-09a97d8c607a@huaweicloud.com>
 <Zu3LtU9HUY3XH1WV@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Zu3LtU9HUY3XH1WV@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnm2AmKu5mO5eaBw--.3729S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17Zw13tF1DKF1Utw1fJFb_yoW8GFy8pF
	Z5AF4Yyan5Jryqva4vqw42gw48Kw4fKF4Uta4fJw1jyryUXr1av342yrykWFZavF929rWY
	va1Yvas0k3y0vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2024/9/21 3:23, Tejun Heo wrote:
> On Wed, Sep 18, 2024 at 05:44:47PM +0800, Chen Ridong wrote:
> ...
>>>     cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
>>>     workqueue: doc: Add a note saturating the system_wq is not permitted
>>>     workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048
>>>
>>>    Documentation/core-api/workqueue.rst | 8 ++++++--
>>>    include/linux/workqueue.h            | 2 +-
>>>    kernel/bpf/cgroup.c                  | 2 +-
>>>    kernel/cgroup/cgroup-internal.h      | 1 +
>>>    kernel/cgroup/cgroup.c               | 2 +-
>>>    5 files changed, 10 insertions(+), 5 deletions(-)
>>>
>> Friendly ping.
> 
> I don't know why but this series isn't in my inbox for some reason. Here are
> some feedbacks after looking at the thread from lore:
> 
> - Can you create a separate workqueue for cgrp->bpf.release_work instead of
>    exporting cgroup_destroy_wq? Workqueues aren't that expensive. No reason
>    to share like this.
> 
> - The patch title is rather misleading. The deadlock isn't really caused
>    between cgroup_mutex and cpu_hotplug_lock. They're just victims of
>    system_wq concurrency depletion. Can you please update accordingly?
> 
> - Can you add a new line before the note paragraph? Also, I'd say "deadlock"
>    rather than "block" to properly convey the imapct of such saturation
>    events. I don't think "eg. cgroup release work" is adding much.
> 
> Thanks.
> 

Thanks, TJ, I will do that.

Best regards,
Ridong


