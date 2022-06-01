Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E00F53B073
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 02:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiFAXU6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 19:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiFAXU6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 19:20:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534431B4344;
        Wed,  1 Jun 2022 16:20:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so3383293pjq.2;
        Wed, 01 Jun 2022 16:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=36roVZgMS1TrHEl/hciT9eVdk9tIyXzVYQtLf5keg5w=;
        b=as+c6RbTd6/t+lttkVFCmzXeOCYASpRwEFg4XfRTRrS2LdV5Un0pnO7xYF0y27WzpT
         5d+ZZTK7hm/ZiZAp/FOFqeiC3CU+m+e/lPWNrSeEvzRT8LBgYIAiOt0CpMkvczf2LAfX
         8jEmfXgghu2pN7ieABMzqzEow559x5Of29y5klmNBKj/OlxZBype6Q5wtU1A5Mi+K+cG
         BXqjH410uz2PLbvHehC41ilcRkVRDYFJ1tHLuW/lVUnBCc5eyBVXjwU9x6QtwaI9bOqS
         NDhqpD5PAM9ymzyvcBv7BxGor0gIUwWeut1J3dXnqaX02GYRwO3X5cWCgXi3I3of7UvP
         UzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=36roVZgMS1TrHEl/hciT9eVdk9tIyXzVYQtLf5keg5w=;
        b=RYNJvMZfXyHHIxkIFofDXYOT4YdvMM1uh1V1ipWpODBwNE1ZwR9NaVSIawaloDxOyE
         N+WUM/N7iLkGJE6YfBotDHg0gaHzGpslPsvV3hsxH7ldeNAMaMAAv5lqr2SnDIAN3ydB
         T4gq6pVt3B3kUIfXkf+wd9U58+vxfrj5PiW/A7hvqNQiHkZvfCsooZwebJgp1ruFSe/4
         bIKXchZD69Kn8T2DR9NJl5jLbeD7rj5YSLUDRGuZbLGFYCnMdCnYlwc982juY/piVwqQ
         5BrhAO7qSi961nbHaKYPOW0NeVfOR5EnWdjyqYOQ1L4t+Q69OZOr95Vm+tKEpRLrbPGs
         58BQ==
X-Gm-Message-State: AOAM533ZQEgzq6BhE2+eSr0mR0KQekolQgBsd1A+37AghzzO8SeUb6ra
        IFxidqFEmGmm3+R5DWvcoSA=
X-Google-Smtp-Source: ABdhPJxT7BH4lX65PiGp5rSDj1Q9H7sqxS3DJrU6IvB8+JntDvJvEbEoeWUCDHHWSUWvIYBQuCbtwg==
X-Received: by 2002:a17:903:215:b0:15e:cae9:7622 with SMTP id r21-20020a170903021500b0015ecae97622mr1857738plh.28.1654125656631;
        Wed, 01 Jun 2022 16:20:56 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090ad31000b001e2afd35791sm1916085pju.18.2022.06.01.16.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 16:20:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Jun 2022 13:20:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
Message-ID: <Ypf0VnKUMiuRgZqT@slm.duckdns.org>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz>
 <Yo7KfEOz92kS2z5Y@blackbook>
 <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 01, 2022 at 04:13:32PM -0700, Tadeusz Struk wrote:
> > On Thu, May 26, 2022 at 11:56:34AM +0200, Michal Koutný wrote:
> > > // ref=A: initial state
> > > kill_css()
> > >    css_get // ref+=F == A+F: fuse
> > >    percpu_ref_kill_and_confirm
> > >      __percpu_ref_switch_to_atomic
> > >        percpu_ref_get
> > >          // ref += 1 == A+F+1: atomic mode, self-protection
> > >      percpu_ref_put
> > >        // ref -= 1 == A+F: kill the base reference
> > >    [via rcu]
> > >    percpu_ref_switch_to_atomic_rcu
> > >      percpu_ref_call_confirm_rcu
> > >        css_killed_ref_fn == refcnt.confirm_switch
> > >          queue_work(css->destroy_work)        (1)
> > >                                                       [via css->destroy_work]
> > >                                                       css_killed_work_fn == wq.func
> > >                                                         offline_css() // needs fuse
> > >                                                         css_put // ref -= F == A: de-fuse
> > >        percpu_ref_put
> > >          // ref -= 1 == A-1: remove self-protection
> > >          css_release                                   // A <= 1 -> 2nd queue_work explodes!
> > 
> > I'm not sure I'm following it but it's perfectly fine to re-use the work
> > item at this point. The work item actually can be re-cycled from the very
> > beginning of the work function. The only thing we need to make sure is that
> > we don't css_put() prematurely to avoid it being freed while we're using it.
> 
> Yes, it is ok to reuse a work struct, but it's not ok to have the same
> work struct enqueued twice on the same WQ when list debug is enabled.
> That's why we are getting this "BUG: corrupted list.."

The above scenario isn't that tho. Once the work item starts executing, wq
doesn't care about what happens to it and as killed_work_fn is holding a
reference, the release scheduling shouldn't happen before it starts
executing unless somebody is screwing up the refcnting.

> That's right. Michal was on the right track for the kill_css() part.
> What I think is going on is that once css_create() fails then
> cgroup_subtree_control_write() ends up calling first kill_css() and
> then css_put() on the same css, I think it's &cgrp->self of the kernfs_node.
> The each_live_descendant_post() also iterates on the root.
> Here is the call flow (sorry for long lines):
> 
> cgroup_subtree_control_write(of)->cgroup_apply_control(cgrp)->cgroup_apply_control_enable(cgrp)->css_create() <- fails here and returns error
>   |
>   |-> cgroup_finalize_control(cgrp)->cgroup_apply_control_disable(cgrp)->each_live_descendant_post(cgrp)->kill_css()->percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn) <- this triggers css_killed_ref_fn() to be called
>   |
>   |  css_killed_ref_fn() <- first css->destroy_work enqueue
>   |    |
>   |    |->  INIT_WORK(&css->destroy_work, css_killed_work_fn); queue_work(cgroup_destroy_wq, &css->destroy_work);
>   |
>   |
>   |-> goto out_unlock;
>   |     |
>   |     |-> cgroup_kn_unlock(kernfs_node)->cgroup_put(cgrp)->css_put(&cgrp->self)->percpu_ref_put(&css->refcnt) <- this triggers css_release() to be called
>   |
>   |
>      css_release(percpu_ref) <- second css->destroy_work enqueue
>        |
>        |->  INIT_WORK(&css->destroy_work, css_release_work_fn); queue_work(cgroup_destroy_wq, &css->destroy_work) <- and it fails here with BUG: corrupted list in insert_work; list_add corruption.
> 
> 
> What seems to work for me as the simplest fix is to prevent enqueuing a dying
> css in css_release() as below. Please let me know if that makes sense to you.
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 1779ccddb734..5618211487cc 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5210,8 +5210,10 @@ static void css_release(struct percpu_ref *ref)
>  	struct cgroup_subsys_state *css =
>  		container_of(ref, struct cgroup_subsys_state, refcnt);
> -	INIT_WORK(&css->destroy_work, css_release_work_fn);
> -	queue_work(cgroup_destroy_wq, &css->destroy_work);
> +	if (!(css->flags & CSS_DYING)) {
> +		INIT_WORK(&css->destroy_work, css_release_work_fn);
> +		queue_work(cgroup_destroy_wq, &css->destroy_work);
> +	}

When the problem is ref imbalance, how can above be the solution? Of course
release path won't cause an issue if they don't run, but we still need to
free the thing, right?

Thanks.

-- 
tejun
