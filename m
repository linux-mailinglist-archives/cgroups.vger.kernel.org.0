Return-Path: <cgroups+bounces-4980-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A2989271
	for <lists+cgroups@lfdr.de>; Sun, 29 Sep 2024 03:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451D328405D
	for <lists+cgroups@lfdr.de>; Sun, 29 Sep 2024 01:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696B1AD51;
	Sun, 29 Sep 2024 01:30:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B84C69;
	Sun, 29 Sep 2024 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727573428; cv=none; b=QRCUxY0gSuUglA/8DvRYzeWKdGbZW6TXKrw4v4MIRvbJmR1KP2SINpD1SeasVZtOyQaBAoJouf5+1je3S5K4ES3mHolUy+OZ7lNll/TOm9mjDUI7e6QnoG0fiiCmKobx/ULNePTyxezhEBRcF4L8CliBpQgusJ/6TLVgeXOvJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727573428; c=relaxed/simple;
	bh=GIHJbKq1q/aZD8Nd2TOJpRnT1WL0TLFoYVxNvlFQxyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2bL/K7nxFui49gR/CljjPoFnqiaaPiu7qMzS+gwSuSray8/PhbVJobdbJPrGL6gqM5GjOWixFGjm5Rfue89gvaXdANEzPqk8DhAXXQJxqazpppXkxEGoS87S6vI77G2RTYxSu28eCNrJBOg3K1zuG+1N9efRJoCrhe0DoWs718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XGRTb1kHpz4f3jkq;
	Sun, 29 Sep 2024 09:30:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9622B1A08DC;
	Sun, 29 Sep 2024 09:30:22 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgC36sarrfhmybCPCg--.40394S2;
	Sun, 29 Sep 2024 09:30:20 +0800 (CST)
Message-ID: <369af074-f4e5-4442-9fb9-7804e4530e74@huaweicloud.com>
Date: Sun, 29 Sep 2024 09:30:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Hillf Danton <hdanton@sina.com>, Michal Koutny <mkoutny@suse.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, Boqun Feng
 <boqun.feng@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org
References: <20240817093334.6062-1-chenridong@huawei.com>
 <20240817093334.6062-2-chenridong@huawei.com>
 <20240911111542.2781-1-hdanton@sina.com>
 <4f35b6c1-c05f-4475-a4e6-3760eefbe6b0@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <4f35b6c1-c05f-4475-a4e6-3760eefbe6b0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC36sarrfhmybCPCg--.40394S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyDKr1xtF17Zw48Kw4rZrb_yoW8ZFyUpr
	WFyF4UtF48Kr47t3yIqw43Wa1xKw43Kr13JF97Xw1xJFW5ZFy5ur1IgrWrurZxWr93AFyj
	vFW2vFZ5tas0v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/28 16:11, Tetsuo Handa wrote:
> On 2024/09/11 20:15, Hillf Danton wrote:
>> On Mon, 9 Sep 2024 16:19:38 +0200 Michal Koutny <mkoutny@suse.com>
>>> On Sat, Aug 17, 2024 at 09:33:34AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
>>>> The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
>>>> acquired in different tasks, which may lead to deadlock.
>>>> It can lead to a deadlock through the following steps:
>>>> 1. A large number of cpusets are deleted asynchronously, which puts a
>>>>     large number of cgroup_bpf_release works into system_wq. The max_active
>>>>     of system_wq is WQ_DFL_ACTIVE(256). Consequently, all active works are
>>>>     cgroup_bpf_release works, and many cgroup_bpf_release works will be put
>>>>     into inactive queue. As illustrated in the diagram, there are 256 (in
>>>>     the acvtive queue) + n (in the inactive queue) works.
>> Given no workqueue work executed without being dequeued, any queued work,
>> regardless if they are more than 2048, that acquires cgroup_mutex could not
>> prevent the work queued by thread-T from being executed, so thread-T can
>> make safe forward progress, therefore with no chance left for the ABBA
>> deadlock you spotted where lockdep fails to work.
> 
> I made a simple test which queues many work items into system_wq and
> measures time needed for flushing last work item.
> 
> As number of work items increased, time needed also increased.
> Although nobody uses flush_workqueue() on system_wq, several users
> use flush_work() on work item in system_wq. Therefore, I think that
> queuing thousands of work items in system_wq should be avoided,
> regardless of whether there is possibility of deadlock.
> 

I have sent a patch to document this.

Link: 
https://lore.kernel.org/linux-kernel/20240923114352.4001560-3-chenridong@huaweicloud.com/

Michal and I are discussing how to make this constraint clear. If you 
can express this constraint more clearly, just reply.

Best regards,
Ridong


