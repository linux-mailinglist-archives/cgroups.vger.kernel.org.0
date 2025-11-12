Return-Path: <cgroups+bounces-11842-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD97C5041C
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 02:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41CE3A93B2
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 01:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628BD296BA2;
	Wed, 12 Nov 2025 01:58:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710F291C07;
	Wed, 12 Nov 2025 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912691; cv=none; b=PglijboaXmGjtxgKAW7Z0UT8e6r/SSMvkG6wdqvqwiN3PrqW6yZLtWFkSdFtDCurBAEO2QJRR+iR/zdpc8nYRYBPK9Gx7c+9f5Yx57/M5c/4RdVRArXiZQ8xvOcHbQkThC6nk7R6YXMNbxx0CNofuC0WNqyKQyGe8/r1brHIJvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912691; c=relaxed/simple;
	bh=RnDE77SJ1Nifeal2yc5LVDNUJAzdbJdwbn21a299e54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2i2bO2NWkLWXkfwthq8NxygNXPCHVzxbwUcSILsReQxYlN+GGsOiF89u9Hh734UyfPntEtP9cXBtCA/KnANgB7SMxeVhupSpDXBaQ2wxjndLfuO/JSXEEScJH+g/aTGIBmG9byg5PUssqzduhdxLYXv4400Z16PLUpGsKDlKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5mkf03ynzKHMMf;
	Wed, 12 Nov 2025 09:57:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E152E1A167A;
	Wed, 12 Nov 2025 09:58:02 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBXs3mp6RNpY5DBAQ--.52487S2;
	Wed, 12 Nov 2025 09:58:02 +0800 (CST)
Message-ID: <86361412-7de0-46bc-9188-a32b634e43a3@huaweicloud.com>
Date: Wed, 12 Nov 2025 09:58:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
To: Waiman Long <llong@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20251111132632.950430-1-chenridong@huaweicloud.com>
 <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
 <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>
 <sebxxc2px767l447xr7cmkvlsewvdiazp7ksee3u2hlqaka522@egghgtj4oowf>
 <a4e61aa0-5c1f-490e-9cae-5e478ba809ee@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <a4e61aa0-5c1f-490e-9cae-5e478ba809ee@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXs3mp6RNpY5DBAQ--.52487S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1fKryDJryfuFW5tw47urg_yoW5Wr4UpF
	WjgF17JFs0ywnrC397Ka4Iq3WSvwn7GFW5Jrn5Jw1rAasxWr1F9r17KFZYkF4rZrn7JrWY
	vFW5XrykWasFyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/11/12 4:35, Waiman Long wrote:
> On 11/11/25 2:25 PM, Michal Koutný wrote:
>> On Tue, Nov 11, 2025 at 10:16:33AM -0500, Waiman Long <llong@redhat.com> wrote:
>>> For internal helper like this one, we may not really need that as
>>> almost all the code in cpuset.c are within either a cpuset_mutex or
>>> callback_lock critical sections. So I am fine with or without it.
>> OK, cpuset_mutex and callback_lock are close but cgroup_is_populated()
>> that caught my eye would also need cgroup_mutex otherwise "the result
>> can only be used as a hint" (quote from cgroup.h).
>>
>> Or is it safe to assume that cpuset_mutex inside cpuset_attach() is
>> sufficient to always (incl. exits) ensure stability of
>> cgroup_is_populated() result?
>>
>> Anyway, I'd find some clarifications in the commit message or the
>> surrounding code about this helpful. (Judgment call, whether with a
>> lockdep macro. My opinion is -- why not.)
> 
> For attach_in_progress, it is protected by the cpuset_mutex. So it may make sense to add a
> lockdep_assert_held() for that.
> 

Will add.

> You are right that there are problems WRT the stability of cgroup_is_populated() value.
> 
> I think "cgrp->nr_populated_csets + cs->attach_in_progress" should be almost stable for the cgroup
> itself with cpuset_mutex, but there can be a small timing window after cpuset_attach(), but before
> the stat is updated where the sum is 0, but there are actually tasks in the cgroup.
> 
Do you mean there’s a small window after ss->attach (i.e., cpuset_attach) where
cgrp->nr_populated_csets + cs->attach_in_progress could be 0?

If I understand correctly:

ss->can_attach: cs->attach_in_progress++, sum > 0
css_set_move_task->css_set_update_populated: cgrp->nr_populated_csets++, sum > 0
ss->attach->cpuset_attach: cs->attach_in_progress--, sum > 0

What exactly is the small window you’re referring to where the sum equals 0?

> For "cgrp->nr_populated_domain_children + cgrp->nr_populated_threaded_children", it also has the
> problem that the sum can be 0 but there are attach_in_progress set in one or more of the child
> cgroups. So even with this patch, we can't guarantee 100% that there can be no task in the partition
> even if it has empty effective_cpus. It is only a problem for nested local partitions though as
> remote partitions are not allowed to exhaust all the CPUs from root cgroup.
> 
> We should probably document that limitation to warn users if they try to create nested local
> partitions where the parent partition root of the child partitions has empty effective_cpus.
> 

Hmm, but it was what the commit e2d59900d936 ("cgroup/cpuset: Allow no-task partition to have empty
cpuset.cpus.effective") allowed, and it makes sense.


-- 
Best regards,
Ridong


