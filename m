Return-Path: <cgroups+bounces-9207-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B701EB27A0E
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 09:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A40A283F7
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D702C21D7;
	Fri, 15 Aug 2025 07:30:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047E2512C8;
	Fri, 15 Aug 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243006; cv=none; b=BYBBuZ1q3y6l6qqANViXS0efjZTd2tfNmqvITUkSd6S7jp4iwOfuMOORx7TDyp5uQZ3WWCvvWgXPHwqG4BH8OlWNYyq53jFDxhJTSeYMRWys/EfttKEBy1173gNyTV3B8b2+F+LKLZQsv3Tu5KvtTI4dF/fC0DZdOslfsPUs6s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243006; c=relaxed/simple;
	bh=DhC9SGkYHwiUI0wmFFUNGK9U8n+Ue83vAsYgf7Kb6O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uW9JuolT2dxW7zpVU8chcxVppuK9nxKyglegIZnPLo4f+J6OjcP3ID54O2+fQ5cVBcNu28wZA2MVg4yWfj4W6+QZ5FSgx0mpKjaPt0hPemlS4vvOIWaeno5aGfD7SlK2oH/VBzNhabpiB45/ySYDeiB12siub7CZf5zNK4TwLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3DK34jLrzKHMT3;
	Fri, 15 Aug 2025 15:29:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F36481A1973;
	Fri, 15 Aug 2025 15:29:58 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgCXo7X04Z5ookfFDg--.11707S2;
	Fri, 15 Aug 2025 15:29:58 +0800 (CST)
Message-ID: <dd1418f9-93d0-45c9-bcc2-d67f48d050f6@huaweicloud.com>
Date: Fri, 15 Aug 2025 15:29:56 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
To: Hillf Danton <hdanton@sina.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, gaoyingjie@uniontech.com
References: <20250722112733.4113237-1-chenridong@huaweicloud.com>
 <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs>
 <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com>
 <20250815024020.4579-1-hdanton@sina.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250815024020.4579-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXo7X04Z5ookfFDg--.11707S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1DuF4kAw1ftFWkKF4rKrg_yoW8Kr4xpF
	WrAa45Aan5Xr4UCw4vya1Yga4FgF4Iqw47Xr1fWw48ta1Yqr92qa109F1YkF4rArn7C342
	qw1avwnxJa4jyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aZX5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/15 10:40, Hillf Danton wrote:
> On Fri, Jul 25, 2025 at 09:42:05AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>> On Tue, Jul 22, 2025 at 11:27:33AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>> CPU0                            CPU1
>>>> mount perf_event                umount net_prio
>>>> cgroup1_get_tree                cgroup_kill_sb
>>>> rebind_subsystems               // root destruction enqueues
>>>> 				// cgroup_destroy_wq
>>>> // kill all perf_event css
>>>>                                 // one perf_event css A is dying
>>>>                                 // css A offline enqueues cgroup_destroy_wq
>>>>                                 // root destruction will be executed first
>>>>                                 css_free_rwork_fn
>>>>                                 cgroup_destroy_root
>>>>                                 cgroup_lock_and_drain_offline
>>>>                                 // some perf descendants are dying
>>>>                                 // cgroup_destroy_wq max_active = 1
>>>>                                 // waiting for css A to die
>>>>
>>>> Problem scenario:
>>>> 1. CPU0 mounts perf_event (rebind_subsystems)
>>>> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
>>>> 3. A dying perf_event CSS gets queued for offline after root destruction
>>>> 4. Root destruction waits for offline completion, but offline work is
>>>>    blocked behind root destruction in cgroup_destroy_wq (max_active=1)
>>>
>>> What's concerning me is why umount of net_prio hierarhy waits for
>>> draining of the default hierachy? (Where you then run into conflict with
>>> perf_event that's implicit_on_dfl.)
>>>
> /*
>  * cgroup destruction makes heavy use of work items and there can be a lot
>  * of concurrent destructions.  Use a separate workqueue so that cgroup
>  * destruction work items don't end up filling up max_active of system_wq
>  * which may lead to deadlock.
>  */
> 
> If task hung could be reliably reproduced, it is right time to cut
> max_active off for cgroup_destroy_wq according to its comment.

Hi Danton,

Thank you for your feedback.

While modifying max_active could be a viable solution, I’m unsure whether it might introduce other
side effects. Instead, I’ve proposed an alternative approach in v3 of the patch, which I believe
addresses the issue more comprehensively.

I’d be very grateful if you could take a look and share your thoughts. Your review would be greatly
appreciated!

v3: https://lore.kernel.org/cgroups/20250815070518.1255842-1-chenridong@huaweicloud.com/T/#u

-- 
Best regards,
Ridong


