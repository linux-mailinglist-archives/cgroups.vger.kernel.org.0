Return-Path: <cgroups+bounces-9716-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC82B44B8A
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 04:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BD03A7D0A
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 02:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008121FECB0;
	Fri,  5 Sep 2025 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bbRAOku6"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D31F4CA9;
	Fri,  5 Sep 2025 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038603; cv=none; b=CZQS6lF5iGzKc3JDdFDcnsV0rNXLx+sI0xQ1XVjXM0c2aS7bJi9xUJjveA1uRTOezGw+aOAlIqBTLaUbRthYycBkl9pgu5l/tZ4QDq7xBSHwY54UfGqzx5nkYcwI5PV3caG7K8L/bzCGtMzgr2vdsrgufbr/9ne8ALnzSnM2ZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038603; c=relaxed/simple;
	bh=YPjJE0hUW8Ymcc2ZzFk+iwe9acZ4n3zf65pmGhxg5wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oB1E9UXgw6cqZAPq1nQUGxT4fjz5C3tvCmLqgCoafoO9KnOzjxtpDjkgUq5zoaJmjCQMi252+5DnuERJFYtzF/a707WwxX7jIAJKQNjHD+rYYvrgJOAXVOBYUHXZ8aJLxUgLiI2dqpw9bjT6zLgv7Q337+/6ZqZA81IdwtDtkl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bbRAOku6; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757038592; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1xlUx97XLvAy2xa8m7uFNrIw4cF2sdfqp6b1RBGJRVk=;
	b=bbRAOku68a7q5VqhP581qaUIECxFYKeCFHKwfPzSmVH5xZ3VO6wBOcSkOVjJdRoa6rJKzJsI8EL8objtRracOkSc1DKbLlt+o7NcbanVD9+x7doD6jX7DJ0ZVbf8kG16HLsUqvVeFIyPFYD4+alAf5DHscp+ZMrSveZLjuK5fU4=
Received: from 30.221.148.72(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnIliIf_1757038591 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 10:16:31 +0800
Message-ID: <11edd1da-7162-4f5a-b909-72c2f65e9db7@linux.alibaba.com>
Date: Fri, 5 Sep 2025 10:16:30 +0800
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
From: escape <escape@linux.alibaba.com>
In-Reply-To: <aLm-2Lcnu602AB85@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for your review.

在 2025/9/5 00:31, Tejun Heo 写道:
> Hello,
>
> On Thu, Sep 04, 2025 at 07:39:32PM +0800, Yi Tao wrote:
> ...
>> To avoid affecting other users, the per-thread-group rwsem is only used
>> when the `favordynmods` flag is enabled.
> Can you please:
>
> - Note that this isn't necessary for cgroup2's recommended workflow and is
>    thus gated behind favordynmods.
>
> - Include performance numbers briefly.
>
>> +extern bool have_favordynmods;
>> +
>>   /**
>>    * cgroup_threadgroup_change_begin - threadgroup exclusion for cgroups
>>    * @tsk: target task
>> @@ -838,6 +840,8 @@ struct cgroup_of_peak {
>>   static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>>   {
>>   	percpu_down_read(&cgroup_threadgroup_rwsem);
>> +	if (have_favordynmods)
>> +		down_read(&tsk->signal->group_rwsem);
>>   }
>>   
>>   /**
>> @@ -848,6 +852,8 @@ static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>>    */
>>   static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
>>   {
>> +	if (have_favordynmods)
>> +		up_read(&tsk->signal->group_rwsem);
>>   	percpu_up_read(&cgroup_threadgroup_rwsem);
> Hmm... I wonder whether turning on/off the flag is racy. ie. what prevents
> have_favordynmods flipping while a task is between change_begin and end?
have_favordynmods is read-only after initialization and will not change 
during runtime.
>> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
>> index 1ef1edbaaf79..86fbc99a9174 100644
>> --- a/include/linux/sched/signal.h
>> +++ b/include/linux/sched/signal.h
>> @@ -226,6 +226,10 @@ struct signal_struct {
>>   	struct tty_audit_buf *tty_audit_buf;
>>   #endif
>>   
>> +#ifdef CONFIG_CGROUPS
>> +	struct rw_semaphore group_rwsem;
>> +#endif
> Maybe name it more specific - e.g. cgroup_threadgroup_rwsem?
>
>>   /**
>>    * cgroup_attach_lock - Lock for ->attach()
>> - * @lock_threadgroup: whether to down_write cgroup_threadgroup_rwsem
>> + * @tsk: thread group to lock
>> + * @lock_threadgroup: whether to down_write rwsem
>>    *
>>    * cgroup migration sometimes needs to stabilize threadgroups against forks and
>>    * exits by write-locking cgroup_threadgroup_rwsem. However, some ->attach()
>> @@ -2480,21 +2481,30 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
>>    * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
>>    * CPU hotplug is disabled on entry.
>>    */
> Please expand the function comment to explain what's going on and why and
> maybe point to it from a comment on top of favor_dynmods.
>
>> -void cgroup_attach_lock(bool lock_threadgroup)
>> +void cgroup_attach_lock(struct task_struct *tsk, bool lock_threadgroup)
> As @tsk is an optional argument, it'd probably make more sense to put it at
> the end.
>
>> @@ -3010,15 +3008,27 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>>   	 */
>>   	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
>>   		tsk = ERR_PTR(-EINVAL);
>> -		goto out_unlock_threadgroup;
>> +		goto out_unlock_rcu;
>>   	}
>> -
>>   	get_task_struct(tsk);
>> -	goto out_unlock_rcu;
>>   
>> -out_unlock_threadgroup:
>> -	cgroup_attach_unlock(*threadgroup_locked);
>> -	*threadgroup_locked = false;
>> +	rcu_read_unlock();
>> +
>> +	/*
>> +	 * If we migrate a single thread, we don't care about threadgroup
>> +	 * stability. If the thread is `current`, it won't exit(2) under our
>> +	 * hands or change PID through exec(2). We exclude
>> +	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
>> +	 * callers by cgroup_mutex.
>> +	 * Therefore, we can skip the global lock.
>> +	 */
>> +	lockdep_assert_held(&cgroup_mutex);
>> +	*threadgroup_locked = pid || threadgroup;
>> +
>> +	cgroup_attach_lock(tsk, *threadgroup_locked);
> I'm not sure this relocation is safe. What prevents e.g. @tsk changing its
> group leader or signal struct before lock is grabbed?
When a non-leader thread in a thread group executes the exec system call,
the thread group leader is updated, but the signal_struct remains unchanged,
so this part is safe.
>
> Thanks.

I will accept the remaining comments and apply them in the next version of
the patch.

Thanks.


