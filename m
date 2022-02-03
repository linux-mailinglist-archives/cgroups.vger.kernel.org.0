Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D052C4A879E
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 16:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351838AbiBCPXb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 10:23:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351855AbiBCPXa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 10:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643901810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hSeQIZ/CtCE+d0vB+jizfse1LNxVSYoWhLdejmi7nC0=;
        b=RrP7Oz/LWFR9TSQrEfVSKMwBJWTgkrMqccWJRXCBVmkGCxiOF7P8V2SiualnRvbCvyrdqm
        IlVWY9xWOPqvY3AvGyoEVpfbc5drckvKtw3MMaAJ4pcgyo9/LCRb+8PPrN7pt4fC50J0Ls
        m37j2OlDVtubtWzXZv1V0KIxm3HqQ5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-7Tkyf_ElOHip_BSdOCUVyA-1; Thu, 03 Feb 2022 10:23:27 -0500
X-MC-Unique: 7Tkyf_ElOHip_BSdOCUVyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A065583DB83;
        Thu,  3 Feb 2022 15:23:25 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8373384A3C;
        Thu,  3 Feb 2022 15:23:24 +0000 (UTC)
Date:   Thu, 3 Feb 2022 10:23:22 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Fix "suspicious RCU usage" lockdep warning
Message-ID: <Yfvzaudy0hOduSMc@lorien.usersys.redhat.com>
References: <20220203033103.773030-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203033103.773030-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 02, 2022 at 10:31:03PM -0500 Waiman Long wrote:
> It was found that a "suspicious RCU usage" lockdep warning was issued
> with the rcu_read_lock() call in update_sibling_cpumasks().  It is
> because the update_cpumasks_hier() function may sleep. So we have
> to release the RCU lock, call update_cpumasks_hier() and reacquire
> it afterward.
> 
> Also add a percpu_rwsem_assert_held() in update_sibling_cpumasks()
> instead of stating that in the comment.
> 
> Fixes: 4716909cc5c5 ("cpuset: Track cpusets that use parent's effective_cpus")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index dc653ab26e50..b147acece984 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1522,10 +1522,15 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
>  	struct cpuset *sibling;
>  	struct cgroup_subsys_state *pos_css;
>  
> +	percpu_rwsem_assert_held(&cpuset_rwsem);
> +
>  	/*
>  	 * Check all its siblings and call update_cpumasks_hier()
>  	 * if their use_parent_ecpus flag is set in order for them
>  	 * to use the right effective_cpus value.
> +	 *
> +	 * The update_cpumasks_hier() function may sleep. So we have to
> +	 * release the RCU read lock before calling it.
>  	 */
>  	rcu_read_lock();
>  	cpuset_for_each_child(sibling, pos_css, parent) {
> @@ -1533,8 +1538,13 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
>  			continue;
>  		if (!sibling->use_parent_ecpus)
>  			continue;
> +		if (!css_tryget_online(&sibling->css))
> +			continue;
>  
> +		rcu_read_unlock();
>  		update_cpumasks_hier(sibling, tmp);
> +		rcu_read_lock();
> +		css_put(&sibling->css);
>  	}
>  	rcu_read_unlock();
>  }
> -- 
> 2.27.0
> 

This looks good. Thanks Waiman.

Tested-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil
-- 

