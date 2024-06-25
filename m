Return-Path: <cgroups+bounces-3358-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4967916A18
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 16:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D67B25212
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C916A95F;
	Tue, 25 Jun 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQXqTN4S"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E300916A382
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325090; cv=none; b=VMH3C42ANNJGMw6SYXTjI8W2uipOLPp9d16xUkmTK3ZR1R7Ajzgse574+KOjbG4NFelivDAzD1E9SbjKZJBwvRoQK/QMG3DRmLGkqhgZnURyaribsb2ZuGg3h7HbQS5p/3bRY4LIQ/WHGintBv9LiOwMx/+r0tzQEX/Bjn52MA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325090; c=relaxed/simple;
	bh=258aHTwJ8PHNVShdBmlRwFk5MhWBCxeonA2f0yI3uGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwhIlX6hwx76WjzhM1QTU1SbnAHyU778ez79xq6oG15icqAKD6vqBOeEpuUUkGRsx3sfVdrkegQYNJfnrGZ6sN7LekrsW+k+Nx0Y2qG0NXks293xgJoV1SLAnHj4sYrZH2GNutGYLJkPZo+KcPYpqMyhMYjhTHHNg5yvX5dPeoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQXqTN4S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719325088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDJanHJKnbiJNPYotPkVO2c6RbIzDk3MVlTTgVCykxk=;
	b=SQXqTN4St4YLwrqePXiDxgLc7iRQLuDYk81viqRKYPCaj4/RoAQ93F48e1JcoxbmUDJLG8
	rJpBGIgslYXSCTBDB+ToJnaTPC4zoO8yjDB8YXJy3DfXPYf8Mr9dShfQdAzBtCcyzuWWYR
	8dQxSGmgMiJyOtv4Z2Ydl6ItWTkLKeQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-KsnVk9qGMTCAI2eoQhCkRg-1; Tue,
 25 Jun 2024 10:18:04 -0400
X-MC-Unique: KsnVk9qGMTCAI2eoQhCkRg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F28E318DB6FA;
	Tue, 25 Jun 2024 14:17:14 +0000 (UTC)
Received: from [10.22.10.23] (unknown [10.22.10.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9BD18301BD32;
	Tue, 25 Jun 2024 14:16:16 +0000 (UTC)
Message-ID: <80e87513-aa48-4548-893e-ed339690c941@redhat.com>
Date: Tue, 25 Jun 2024 10:16:15 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: fix uaf when proc_cpuset_show
To: chenridong <chenridong@huawei.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240622113814.120907-1-chenridong@huawei.com>
 <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
 <52f72d1d-602e-4dca-85a3-adade925b056@huawei.com>
 <71a9cc3a-1b58-4051-984b-dd4f18dabf84@redhat.com>
 <8f83ecb3-4afa-4e0b-be37-35b168eb3c7c@huawei.com>
 <ee30843f-2579-4dcf-9688-6541fd892678@redhat.com>
 <3322ce46-78a1-45c5-ad07-a982dec21c8e@huawei.com>
 <gke4hn67e2js2wcia4gopr6u26uy5epwpu7r6sepjwvp5eetql@nuwvwzg2k4dy>
 <920bbfaa-bb76-4aa1-bd07-9a552e3bfdf2@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <920bbfaa-bb76-4aa1-bd07-9a552e3bfdf2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 6/25/24 10:11, chenridong wrote:
>
>
> On 2024/6/25 18:10, Michal Koutný wrote:
>> Hello.
>>
>> On Tue, Jun 25, 2024 at 11:12:20AM GMT, chenridong<chenridong@huawei.com>  wrote:
>>> I am considering whether the cgroup framework has a method to fix this
>>> issue, as other subsystems may also have the same underlying problem.
>>> Since the root css will not be released, but the css->cgrp will be
>>> released.
>> <del>First part is already done in
>> 	d23b5c5777158 ("cgroup: Make operations on the cgroup root_list RCU safe")
>> second part is that</del>
>> you need to take RCU read lock and check for NULL, similar to
>> 	9067d90006df0 ("cgroup: Eliminate the need for cgroup_mutex in proc_cgroup_show()")
>>
>> Does that make sense to you?
>>
>> A Fixes: tag would be nice, it seems at least
>> 	a79a908fd2b08 ("cgroup: introduce cgroup namespaces")
>> played some role. (Here the RCU lock is not for cgroup_roots list but to
>> preserve the root cgrp itself css_free_rwork_fn/cgroup_destroy_root.
>>
>> HTH,
>> Michal
>
> Thank you, Michal, that is a good idea. Do you mean as below?
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>
> index c12b9fdb22a4..2ce0542067f1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -5051,10 +5051,17 @@ int proc_cpuset_show(struct seq_file *m, 
> struct pid_namespace *ns,
>         if (!buf)
>                 goto out;
>
> +       rcu_read_lock();
> +       spin_lock_irq(&css_set_lock);
>         css = task_get_css(tsk, cpuset_cgrp_id);
> -       retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
> - current->nsproxy->cgroup_ns);
> +
> +       retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
> +               current->nsproxy->cgroup_ns);
>         css_put(css);
> +
> +       spin_unlock_irq(&css_set_lock);
> +       cgroup_unlock();
> +
>         if (retval == -E2BIG)
>                 retval = -ENAMETOOLONG;
>
>         if (retval < 0)
>
That should work. However, I would suggest that you take task_get_css() 
and css_put() outside of the critical section. The task_get_css() is a 
while loop that may take a while to execute and you don't want run it 
with interrupt disabled.

Cheers,
Longman


