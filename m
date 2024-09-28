Return-Path: <cgroups+bounces-4979-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1572B988E68
	for <lists+cgroups@lfdr.de>; Sat, 28 Sep 2024 10:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96E5B21646
	for <lists+cgroups@lfdr.de>; Sat, 28 Sep 2024 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65519DF9F;
	Sat, 28 Sep 2024 08:11:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF919DF82
	for <cgroups@vger.kernel.org>; Sat, 28 Sep 2024 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727511109; cv=none; b=g1/Cooo6xFIXBnF8DiboG+lJsY0cAHU43tMv0zYT6VjXhSfDfwqAPVpsx4rKRQoS1kP6ewHJlUgHS/7l+DWIK3Zf1T4VcVVdQhgguYwpdHPaAHjkEzk7eoAd5V60XpzRKpdTlwF7RfOOhnKHYx4uKMV86GnCCkioOgZPIMA014Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727511109; c=relaxed/simple;
	bh=lF7oWfVNPWoj+tqpSVRTYTEtBKR4j+C9DYvfCQxL0v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QluREIj63I/xAvt/vUbIcNls6DoXyl8z1GVN8u0ocMyzpkTwD08fbFn+jJdvysPtZKCsayefQm5ztF8lWTkXzIw6YHlbxvLTrhjXd57p4KrKZU6Iw3amIwD8WCWjb/TlCc77Jl+vuzBiQ32xU5yCm+45x3tTnKqJIQoEcBmp7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48S8BBx7052959;
	Sat, 28 Sep 2024 17:11:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 28 Sep 2024 17:11:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48S8BBYs052955
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 28 Sep 2024 17:11:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4f35b6c1-c05f-4475-a4e6-3760eefbe6b0@I-love.SAKURA.ne.jp>
Date: Sat, 28 Sep 2024 17:11:09 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
To: Hillf Danton <hdanton@sina.com>, Michal Koutny <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
        cgroups@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20240817093334.6062-1-chenridong@huawei.com>
 <20240817093334.6062-2-chenridong@huawei.com>
 <20240911111542.2781-1-hdanton@sina.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240911111542.2781-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/11 20:15, Hillf Danton wrote:
> On Mon, 9 Sep 2024 16:19:38 +0200 Michal Koutny <mkoutny@suse.com>
>> On Sat, Aug 17, 2024 at 09:33:34AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
>>> The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
>>> acquired in different tasks, which may lead to deadlock.
>>> It can lead to a deadlock through the following steps:
>>> 1. A large number of cpusets are deleted asynchronously, which puts a
>>>    large number of cgroup_bpf_release works into system_wq. The max_active
>>>    of system_wq is WQ_DFL_ACTIVE(256). Consequently, all active works are
>>>    cgroup_bpf_release works, and many cgroup_bpf_release works will be put
>>>    into inactive queue. As illustrated in the diagram, there are 256 (in
>>>    the acvtive queue) + n (in the inactive queue) works.
> Given no workqueue work executed without being dequeued, any queued work,
> regardless if they are more than 2048, that acquires cgroup_mutex could not
> prevent the work queued by thread-T from being executed, so thread-T can
> make safe forward progress, therefore with no chance left for the ABBA 
> deadlock you spotted where lockdep fails to work.

I made a simple test which queues many work items into system_wq and
measures time needed for flushing last work item.

As number of work items increased, time needed also increased.
Although nobody uses flush_workqueue() on system_wq, several users
use flush_work() on work item in system_wq. Therefore, I think that
queuing thousands of work items in system_wq should be avoided,
regardless of whether there is possibility of deadlock.

----------------------------------------
#include <linux/module.h>
#include <linux/workqueue.h>

static void worker_func(struct work_struct *work)
{
        schedule_timeout_uninterruptible(HZ);
}

#define MAX_WORKS 8192
static struct work_struct works[MAX_WORKS];

static int __init test_init(void)
{
        int i;
        unsigned long start, end;

        for (i = 0; i < MAX_WORKS; i++) {
                INIT_WORK(&works[i], worker_func);
                schedule_work(&works[i]);
        }
        start = jiffies;
        flush_work(&works[MAX_WORKS - 1]);
        end = jiffies;
        printk("%u: Took %lu jiffies. (HZ=%u)\n", MAX_WORKS, end - start, HZ);
        for (i = 0; i < MAX_WORKS; i++)
                flush_work(&works[i]);
        return -EINVAL;
}

module_init(test_init);
MODULE_LICENSE("GPL");
----------------------------------------

12 CPUs
256: Took 1025 jiffies. (HZ=1000)
512: Took 2091 jiffies. (HZ=1000)
1024: Took 4105 jiffies. (HZ=1000)
2048: Took 8321 jiffies. (HZ=1000)
4096: Took 16382 jiffies. (HZ=1000)
8192: Took 32770 jiffies. (HZ=1000)

1 CPU
256: Took 1133 jiffies. (HZ=1000)
512: Took 2047 jiffies. (HZ=1000)
1024: Took 4117 jiffies. (HZ=1000)
2048: Took 8210 jiffies. (HZ=1000)
4096: Took 16424 jiffies. (HZ=1000)
8192: Took 32774 jiffies. (HZ=1000)


