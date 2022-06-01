Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F124853B07D
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiFAXNg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 19:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiFAXNg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 19:13:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4EAF5BA
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 16:13:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e24so3405332pjt.0
        for <cgroups@vger.kernel.org>; Wed, 01 Jun 2022 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=avJEEUv9TwoQxp5JDkd8KBVEKkaG/hcczSaXXKCQTHE=;
        b=h6rYPumu3aj7CwpyNNPdUBXXKfiKD8gGz3B045bl8MP0WngMSGl8ix8vfn1QpNRDcP
         Ac1tUfpAbNsIYSozT3egxW8Gs72wfXxjoR414paoffvEDq2yomjCnROY+FnfRXriMFaV
         3zqE0L/mXRymN13gHNbzn+4Qlhh5f+QVP9Ab2rKwsxos1HFwstgJUYtfWX1v/n1IMSP4
         9utIf6WHEWywo8eukE6uJOVedlTD0LRCllXWYs5bDUzrmQp3o0xF7rL2ZXa2P24qXL6Y
         OML1E941w/IBG/gK3vrnI/Cz/RhLiGAHokjs3WJfpVO92zUZ1NMNxQEzlRL8X1+pvuww
         Z/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=avJEEUv9TwoQxp5JDkd8KBVEKkaG/hcczSaXXKCQTHE=;
        b=x+EbpNOee5ZFs41WipCqnpUr9M1XZhdH2RbwfgcPC4AwnYF0ZhO1fdTjanr97FmAJA
         xA1Z1wMTXoTlNbk7/2JRA33+FjF7avFs2QKcjHo72oP8lX7g/OoXJH0JaiCQ4ngnLdx8
         NL6fZdHuQ1bTMCVpznDEeL3N7rQID8aX9L7F565QuLMY+git+ynhgiETijZ59F9cZB8J
         zZIjeDOwBpcaJZhao2gU9cmVhVgF+/KAdMpuCU2WZmOys6j8brg2j0Q5GURTNH2RghR4
         MvXYZADlZiuVRoM64Y1mQfTv0LVqVN//P4Mj2zkKzP4l4dk0OuAlnufinGlEXnSV3C2Y
         ugVw==
X-Gm-Message-State: AOAM532zcUYjCEytmL8TE2ict+FoSDemPaUivzI+4EegJTlaxxMHTiPi
        p5AZVfR2CGmKN1SCIuJ9Au0BaA==
X-Google-Smtp-Source: ABdhPJz3o+kcqv8ytM/orIzvAU3q3jZGB5/OAzGm4ATZu+1ZtKJJUD5PZCVNbotdbNumkSDu9J1KJA==
X-Received: by 2002:a17:902:bd42:b0:164:bea:65bf with SMTP id b2-20020a170902bd4200b001640bea65bfmr1745502plx.111.1654125214527;
        Wed, 01 Jun 2022 16:13:34 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b0051bb0be7109sm1990292pfa.78.2022.06.01.16.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 16:13:33 -0700 (PDT)
Message-ID: <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
Date:   Wed, 1 Jun 2022 16:13:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz> <Yo7KfEOz92kS2z5Y@blackbook>
 <Yo/DtjEU/kYr190u@slm.duckdns.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
In-Reply-To: <Yo/DtjEU/kYr190u@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/26/22 11:15, Tejun Heo wrote:
> Hello, Michal.
> 
> On Thu, May 26, 2022 at 11:56:34AM +0200, Michal Koutný wrote:
>> // ref=A: initial state
>> kill_css()
>>    css_get // ref+=F == A+F: fuse
>>    percpu_ref_kill_and_confirm
>>      __percpu_ref_switch_to_atomic
>>        percpu_ref_get
>>          // ref += 1 == A+F+1: atomic mode, self-protection
>>      percpu_ref_put
>>        // ref -= 1 == A+F: kill the base reference
>>    [via rcu]
>>    percpu_ref_switch_to_atomic_rcu
>>      percpu_ref_call_confirm_rcu
>>        css_killed_ref_fn == refcnt.confirm_switch
>>          queue_work(css->destroy_work)        (1)
>>                                                       [via css->destroy_work]
>>                                                       css_killed_work_fn == wq.func
>>                                                         offline_css() // needs fuse
>>                                                         css_put // ref -= F == A: de-fuse
>>        percpu_ref_put
>>          // ref -= 1 == A-1: remove self-protection
>>          css_release                                   // A <= 1 -> 2nd queue_work explodes!
> 
> I'm not sure I'm following it but it's perfectly fine to re-use the work
> item at this point. The work item actually can be re-cycled from the very
> beginning of the work function. The only thing we need to make sure is that
> we don't css_put() prematurely to avoid it being freed while we're using it.

Yes, it is ok to reuse a work struct, but it's not ok to have the same
work struct enqueued twice on the same WQ when list debug is enabled.
That's why we are getting this "BUG: corrupted list.."

> For the sharing to be a problem, we should be queueing the release work item
> while the destroy instance is still pending, and if that is the case, it
> doesn't really matter whether we use two separate work items or not. We're
> already broken and would just be shifting the problem to explode elsewhere.
> 
> The only possibility that I can think of is that somehow we're ending up
> with an extra css_put() somewhere thus triggering the release path
> prematurely. If that's the case, we'll prolly need to trace get/puts to find
> out who's causing the ref imbalance.

That's right. Michal was on the right track for the kill_css() part.
What I think is going on is that once css_create() fails then
cgroup_subtree_control_write() ends up calling first kill_css() and
then css_put() on the same css, I think it's &cgrp->self of the kernfs_node.
The each_live_descendant_post() also iterates on the root.
Here is the call flow (sorry for long lines):

cgroup_subtree_control_write(of)->cgroup_apply_control(cgrp)->cgroup_apply_control_enable(cgrp)->css_create() <- fails here and returns error
   |
   |-> cgroup_finalize_control(cgrp)->cgroup_apply_control_disable(cgrp)->each_live_descendant_post(cgrp)->kill_css()->percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn) <- this triggers css_killed_ref_fn() to be called
   |
   |  css_killed_ref_fn() <- first css->destroy_work enqueue
   |    |
   |    |->  INIT_WORK(&css->destroy_work, css_killed_work_fn); queue_work(cgroup_destroy_wq, &css->destroy_work);
   |
   |
   |-> goto out_unlock;
   |     |
   |     |-> cgroup_kn_unlock(kernfs_node)->cgroup_put(cgrp)->css_put(&cgrp->self)->percpu_ref_put(&css->refcnt) <- this triggers css_release() to be called
   |
   |
      css_release(percpu_ref) <- second css->destroy_work enqueue
        |
        |->  INIT_WORK(&css->destroy_work, css_release_work_fn); queue_work(cgroup_destroy_wq, &css->destroy_work) <- and it fails here with BUG: corrupted list in insert_work; list_add corruption.


What seems to work for me as the simplest fix is to prevent enqueuing a dying
css in css_release() as below. Please let me know if that makes sense to you.

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734..5618211487cc 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5210,8 +5210,10 @@ static void css_release(struct percpu_ref *ref)
  	struct cgroup_subsys_state *css =
  		container_of(ref, struct cgroup_subsys_state, refcnt);
  
-	INIT_WORK(&css->destroy_work, css_release_work_fn);
-	queue_work(cgroup_destroy_wq, &css->destroy_work);
+	if (!(css->flags & CSS_DYING)) {
+		INIT_WORK(&css->destroy_work, css_release_work_fn);
+		queue_work(cgroup_destroy_wq, &css->destroy_work);
+	}
  }
  
  static void init_and_link_css(struct cgroup_subsys_state *css,

-- 
Thanks,
Tadeusz
