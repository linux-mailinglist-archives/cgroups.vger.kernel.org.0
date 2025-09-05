Return-Path: <cgroups+bounces-9718-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A88B44C70
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 05:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5223AAD95
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 03:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AE625742C;
	Fri,  5 Sep 2025 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fHtko7zr"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6252214801;
	Fri,  5 Sep 2025 03:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757043906; cv=none; b=amgDq5tntQq3lcaaIjPlrjj6/N0lM2SX3h1CmSRvPqBWUU2iWUvQ5d28fdXJJb22QmUsz/EfHVXR8ZBdAPOHd8f3ksPRGqdWj5qSiiJh3fVl8xnTnYEuZIkSB/4NgB9ZHheEWZcBLJUP4SpdOZOPH75jZL/Fc7+PtgU9OUmsaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757043906; c=relaxed/simple;
	bh=SKXz5+gJpe7vLnNPYx7aREtRZh5QCQXznrSmeqMvKvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ez7A/VMxQttgtOitr1U9fhp+b+K1dfxz03LgjUVsvctsnIcKRJwBoWla9dq+G8Xea/yIIkCRAcgfLE/U5uar4w9yZPyNOV34skCxj+nDUBTHF/5RkeBWxp6bJXP1ZMtPA8p4WLtQk3S7Aaw3bkkUHyMPrlesW1xEenfSDjWBdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fHtko7zr; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757043895; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I/4dsPBT5BQithObF8p15Q2iEGxmgkcnU0FM5Ioh94U=;
	b=fHtko7zraJOmpPeQypN+FrVRMxIebWsEJirkphEciV05S5hn4coK81VBObh2e8Iv0r052BtMcsbDOZLa/xPEz/iUxInQ6sjxZC2POa/KYjXUkgUtZZUWodbXgrekzbXYRhImX+xaXFPYMxn7xovD7Qxmt7MCECURnwcV11AFW8M=
Received: from 30.221.148.72(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnJ6SCa_1757043894 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 11:44:54 +0800
Message-ID: <93b146e5-08e4-4c10-bb90-8149e82263f0@linux.alibaba.com>
Date: Fri, 5 Sep 2025 11:44:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1756985260.git.escape@linux.alibaba.com>
 <068d58f1f497bc4971c6ac0bae58bf53b98451fd.1756985260.git.escape@linux.alibaba.com>
 <aLm-2Lcnu602AB85@slm.duckdns.org>
 <11edd1da-7162-4f5a-b909-72c2f65e9db7@linux.alibaba.com>
 <aLpKr6_r5exdc3EQ@slm.duckdns.org>
From: escape <escape@linux.alibaba.com>
In-Reply-To: <aLpKr6_r5exdc3EQ@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2025/9/5 10:27, Tejun Heo 写道:
> Hello,
>
> On Fri, Sep 05, 2025 at 10:16:30AM +0800, escape wrote:
>>>> +	if (have_favordynmods)
>>>> +		up_read(&tsk->signal->group_rwsem);
>>>>    	percpu_up_read(&cgroup_threadgroup_rwsem);
>>> Hmm... I wonder whether turning on/off the flag is racy. ie. what prevents
>>> have_favordynmods flipping while a task is between change_begin and end?
>> have_favordynmods is read-only after initialization and will not change
>> during runtime.
> I don't think that's necessarily true. favordynmods can also be specified as
> a mount option and mount can race against forks, execs and exits. Also,
> IIRC, cgroup2 doesn't allow remounts but there's nothing preventing someone
> from unmounting and mounting it again with different options.
There are two ways to set favordynmods. The first is through kernel 
config or
the kernel command line parameter cgroup_favordynmods, which sets the 
value of
the variable have_favordynmods and automatically sets the 
CGRP_ROOT_FAVOR_DYNMODS
flag on cgroup_root->flags at mount time. The second is by passing a 
mount option,
which only sets the CGRP_ROOT_FAVOR_DYNMODS flag on cgroup_root->flags 
during mount.

In this patch, the decision whether to use the per-threadgroup rwsem is 
based on
have_favordynmods, not on cgroup_root->flags. An umount & mount affects 
cgroup_root->flags,
but does not change have_favordynmods.

Indeed, there is a minor flaw here: if favordynmods is enabled via a 
mount option rather
than the kernel command line, the per-threadgroup rwsem will not take 
effect.

To avoid the complexity of runtime changes to favordynmods, perhaps a 
better approach
would be to introduce a separate control variable, configured via a 
kernel command line
parameter such as cgroup_migration_lock=[global|thread_group] to 
explicitly govern
this behavior. What do you think about this approach?
>>>> @@ -3010,15 +3008,27 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>>>>    	 */
>>>>    	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
>>>>    		tsk = ERR_PTR(-EINVAL);
>>>> -		goto out_unlock_threadgroup;
>>>> +		goto out_unlock_rcu;
>>>>    	}
>>>> -
>>>>    	get_task_struct(tsk);
>>>> -	goto out_unlock_rcu;
>>>> -out_unlock_threadgroup:
>>>> -	cgroup_attach_unlock(*threadgroup_locked);
>>>> -	*threadgroup_locked = false;
>>>> +	rcu_read_unlock();
>>>> +
>>>> +	/*
>>>> +	 * If we migrate a single thread, we don't care about threadgroup
>>>> +	 * stability. If the thread is `current`, it won't exit(2) under our
>>>> +	 * hands or change PID through exec(2). We exclude
>>>> +	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
>>>> +	 * callers by cgroup_mutex.
>>>> +	 * Therefore, we can skip the global lock.
>>>> +	 */
>>>> +	lockdep_assert_held(&cgroup_mutex);
>>>> +	*threadgroup_locked = pid || threadgroup;
>>>> +
>>>> +	cgroup_attach_lock(tsk, *threadgroup_locked);
>>> I'm not sure this relocation is safe. What prevents e.g. @tsk changing its
>>> group leader or signal struct before lock is grabbed?
>> When a non-leader thread in a thread group executes the exec system call,
>> the thread group leader is updated, but the signal_struct remains unchanged,
>> so this part is safe.
> But the leader can change, right? So, we can end up in a situation where
> threadgroup is set but the task is not the leader which I think can lead to
> really subtle incorrect behaviors like write succeeding but nothing
> happening when racing against exec.
>
> Thanks.
>
You are right. If the thread group leader changes, the task passed to
cgroup_attach_task may not be the leader, which could lead to errors when
iterating through all threads in while_each_thread.


Similar to commit b78949ebfb56 ("cgroup: simplify double-check locking in
cgroup_attach_proc"), it should check whether the leader has changed after
acquiring the lock, to determine if a retry is needed. I will fix this in
the next version patch.

Thanks.


