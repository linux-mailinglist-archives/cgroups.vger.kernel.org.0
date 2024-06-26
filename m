Return-Path: <cgroups+bounces-3378-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CCF9184FC
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 16:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693D81C227F1
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F5B49632;
	Wed, 26 Jun 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4cJOABb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE0186285
	for <cgroups@vger.kernel.org>; Wed, 26 Jun 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413778; cv=none; b=bqJl67nJB+Giv+UpxJuZQp6FVtJHuoQbiKbQSh+PBWWHHWQGEzfzEm8SCRTTbOkeSKsup/7Lf1PWntH+9c9mhb7tu4uWX4L0gCSzwtXVhcYFmoqFzQlrSjzOmbNJjUYoj0sj/yR0cISETgMRaMmFQvnCZIvkkEoOxRSyokiabks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413778; c=relaxed/simple;
	bh=qcpv/PEkN7/dnb9WgjxI74Dt2WxRgk6JL9ZvdSkmrTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sT+tjedsZiehYMb/ikDd1fwAPnHLk5UJxB72gEp3N/Gqaguxf0KEc+74nmZNX2PJaw99wHwKX+d5MIhor3aD6LZ4O06dOkZAo0dOxFctlzN7kUwRabM3yOMIxCMzjXAT0NlK9JcMK6xC75GQp2FhCmjakXfkldfec9z/k6hUgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4cJOABb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719413775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgH2VmVylsgvJB0IG2XE9dX80Rg9UYW9RXvREHo32vo=;
	b=V4cJOABbovnywIv8n6SobQziqmn6wGu4kMaVEc9lFUIx4c4zTdbxWzKiNOyxP/H8YlNI+K
	4dEpAJI4hNZ/RsbL3a9WZmb989RHSevsNJ0gAyU/5PlalBv0J2HsWH/UeJAOPIYe8IGXQo
	jDpuzoi2dHXab09t9M60WpDr9jhaL10=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-KAkyj4uvPMehwgcU63vvKw-1; Wed,
 26 Jun 2024 10:56:12 -0400
X-MC-Unique: KAkyj4uvPMehwgcU63vvKw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D16A1956096;
	Wed, 26 Jun 2024 14:56:10 +0000 (UTC)
Received: from [10.22.16.126] (unknown [10.22.16.126])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5FE60300070E;
	Wed, 26 Jun 2024 14:56:08 +0000 (UTC)
Message-ID: <7cc422b6-8437-455a-9d3f-718b4504ae9a@redhat.com>
Date: Wed, 26 Jun 2024 10:56:07 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240626094101.472912-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240626094101.472912-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 6/26/24 05:41, Chen Ridong wrote:
> An UAF can happen when /proc/cpuset is read as reported in [1].
>
> This can be reproduced by the following methods:
> 1.add an mdelay(1000) before acquiring the cgroup_lock In the
>   cgroup_path_ns function.
> 2.$cat /proc/<pid>/cpuset   repeatly.
> 3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
> $umount /sys/fs/cgroup/cpuset/   repeatly.
>
> The race that cause this bug can be shown as below:
>
> (umount)		|	(cat /proc/<pid>/cpuset)
> css_release		|	proc_cpuset_show
> css_release_work_fn	|	css = task_get_css(tsk, cpuset_cgrp_id);
> css_free_rwork_fn	|	cgroup_path_ns(css->cgroup, ...);
> cgroup_destroy_root	|	mutex_lock(&cgroup_mutex);
> rebind_subsystems	|
> cgroup_free_root 	|
> 			|	// cgrp was freed, UAF
> 			|	cgroup_path_ns_locked(cgrp,..);
>
> When the cpuset is initialized, the root node top_cpuset.css.cgrp
> will point to &cgrp_dfl_root.cgrp. In cgroup v1, the mount operation will
> allocate cgroup_root, and top_cpuset.css.cgrp will point to the allocated
> &cgroup_root.cgrp. When the umount operation is executed,
> top_cpuset.css.cgrp will be rebound to &cgrp_dfl_root.cgrp.
>
> The problem is that when rebinding to cgrp_dfl_root, there are cases
> where the cgroup_root allocated by setting up the root for cgroup v1
> is cached. This could lead to a Use-After-Free (UAF) if it is
> subsequently freed. The descendant cgroups of cgroup v1 can only be
> freed after the css is released. However, the css of the root will never
> be released, yet the cgroup_root should be freed when it is unmounted.
> This means that obtaining a reference to the css of the root does
> not guarantee that css.cgrp->root will not be freed.
>
> Fix this problem by using rcu_read_lock in proc_cpuset_show().
> As cgroup root_list is already RCU-safe, css->cgroup is safe.
> This is similar to commit 9067d90006df ("cgroup: Eliminate the
> need for cgroup_mutex in proc_cgroup_show()")
>
> [1] https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd
>
> Fixes: a79a908fd2b0 ("cgroup: introduce cgroup namespaces")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c12b9fdb22a4..7f4536c9ccce 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -21,6 +21,7 @@
>    *  License.  See the file COPYING in the main directory of the Linux
>    *  distribution for more details.
>    */
> +#include "cgroup-internal.h"
>   
>   #include <linux/cpu.h>
>   #include <linux/cpumask.h>
> @@ -5052,8 +5053,15 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>   		goto out;
>   
>   	css = task_get_css(tsk, cpuset_cgrp_id);
> -	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
> -				current->nsproxy->cgroup_ns);
> +	rcu_read_lock();
> +	spin_lock_irq(&css_set_lock);
> +	/* In case the root has already been unmounted */
> +	if (css->cgroup)
> +		retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
> +					       current->nsproxy->cgroup_ns);
> +
> +	spin_unlock_irq(&css_set_lock);
> +	rcu_read_unlock();
>   	css_put(css);
>   	if (retval == -E2BIG)
>   		retval = -ENAMETOOLONG;
Reviewed-by: Waiman Long <longman@redhat.com>


