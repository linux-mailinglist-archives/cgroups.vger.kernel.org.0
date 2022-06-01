Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D0753B0CD
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 02:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiFAXhV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 19:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiFAXhV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 19:37:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A220F10E8
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 16:37:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so3395275pjt.4
        for <cgroups@vger.kernel.org>; Wed, 01 Jun 2022 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=TEAUJ/ucXI4eKAlLgmvtjNFHQlDUXBOnD+LHuiraz3w=;
        b=g+g2a/h5fj4ekdhiBZVoem39IesHnm9DOBXVdr0u+GBT1FfE/6soJZwVcANNucrA2v
         9gLc+e6E0h/HUqewW/gcDTlpIKOE9B/nvi5VkwCdzUboCkGQ8HoHp+k1nY6S6no+hpdd
         R85LIIF3A+LnmFfmdZrp2gXNHbADZQMBIqyAxaLPbFeBYC7LfXf05cPAIJ/HB+YxrG8+
         0AuR6f8wWikFigxTB9vlidalsm5Ip4SDKp+5Jve4ENy8SNmi3hitf5WMdN1FvdBjp6dE
         WbwdwFOlfOUbT+9ZoCMY9tktSqMUi4+SKtRo1qnmshxELME/PknA+zT+oXorZKxdTZtk
         ymBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=TEAUJ/ucXI4eKAlLgmvtjNFHQlDUXBOnD+LHuiraz3w=;
        b=23tEHxWrcXnNa+QnUruoUTBVyKaYWiQNh8FCBsudbp/x80BsPT97xRV43H0hsq3KPa
         SWytqsPaxuAEdkcnmCWCjUwPSMKGs6+neOb2qBnwxyXeUq1jAs7mjQxxesTbbfEowZd0
         0ojyWfWyMzNF32iwjaUBf6Rh+6reofOdZ4vIJR4g7hr+qDB3LR0GmBnKRkLiSJBvefJC
         htk0hTtR7NKP5oJW9Ku9KfbhzEiBlEeCcIgUtSHHEwcQ0vLOS7CWfQ3uTPpav/yiMwrW
         SFI8x0JVsMupmogYsSRyZ3sIKZvShYqfisl+5oO2I1OOgCP5NygICjPp/P1hSP/0Vemm
         KkGQ==
X-Gm-Message-State: AOAM5332+M2+n3yXJ815b0LOMkOFgXzxyqWbj2uydg7/wvNIPpDUD5YS
        36H3/Qx2OSH+2qlOOV9RAplDxw==
X-Google-Smtp-Source: ABdhPJxRcI0rOEy0a+1EGjMyyqZA4sVfPwmdJmtXQ5oiGumpZyXXmdfYhUWDpjvuwdBKxvnlMNG4FQ==
X-Received: by 2002:a17:902:7594:b0:15e:bbac:8d49 with SMTP id j20-20020a170902759400b0015ebbac8d49mr1856801pll.124.1654126639097;
        Wed, 01 Jun 2022 16:37:19 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id m11-20020a62f20b000000b0050dc76281fasm1976744pfh.212.2022.06.01.16.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 16:37:18 -0700 (PDT)
Message-ID: <1fb4d8d7-ccc0-b020-715e-38c2dfd94c23@linaro.org>
Date:   Wed, 1 Jun 2022 16:37:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz> <Yo7KfEOz92kS2z5Y@blackbook>
 <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
 <Ypf0VnKUMiuRgZqT@slm.duckdns.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
In-Reply-To: <Ypf0VnKUMiuRgZqT@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/1/22 16:20, Tejun Heo wrote:
> On Wed, Jun 01, 2022 at 04:13:32PM -0700, Tadeusz Struk wrote:
>>> On Thu, May 26, 2022 at 11:56:34AM +0200, Michal Koutný wrote:
>>>> // ref=A: initial state
>>>> kill_css()
>>>>     css_get // ref+=F == A+F: fuse
>>>>     percpu_ref_kill_and_confirm
>>>>       __percpu_ref_switch_to_atomic
>>>>         percpu_ref_get
>>>>           // ref += 1 == A+F+1: atomic mode, self-protection
>>>>       percpu_ref_put
>>>>         // ref -= 1 == A+F: kill the base reference
>>>>     [via rcu]
>>>>     percpu_ref_switch_to_atomic_rcu
>>>>       percpu_ref_call_confirm_rcu
>>>>         css_killed_ref_fn == refcnt.confirm_switch
>>>>           queue_work(css->destroy_work)        (1)
>>>>                                                        [via css->destroy_work]
>>>>                                                        css_killed_work_fn == wq.func
>>>>                                                          offline_css() // needs fuse
>>>>                                                          css_put // ref -= F == A: de-fuse
>>>>         percpu_ref_put
>>>>           // ref -= 1 == A-1: remove self-protection
>>>>           css_release                                   // A <= 1 -> 2nd queue_work explodes!
>>>
>>> I'm not sure I'm following it but it's perfectly fine to re-use the work
>>> item at this point. The work item actually can be re-cycled from the very
>>> beginning of the work function. The only thing we need to make sure is that
>>> we don't css_put() prematurely to avoid it being freed while we're using it.
>>
>> Yes, it is ok to reuse a work struct, but it's not ok to have the same
>> work struct enqueued twice on the same WQ when list debug is enabled.
>> That's why we are getting this "BUG: corrupted list.."
> 
> The above scenario isn't that tho. Once the work item starts executing, wq
> doesn't care about what happens to it and as killed_work_fn is holding a
> reference, the release scheduling shouldn't happen before it starts
> executing unless somebody is screwing up the refcnting.
> 
>> That's right. Michal was on the right track for the kill_css() part.
>> What I think is going on is that once css_create() fails then
>> cgroup_subtree_control_write() ends up calling first kill_css() and
>> then css_put() on the same css, I think it's &cgrp->self of the kernfs_node.
>> The each_live_descendant_post() also iterates on the root.
>> Here is the call flow (sorry for long lines):
>>
>> cgroup_subtree_control_write(of)->cgroup_apply_control(cgrp)->cgroup_apply_control_enable(cgrp)->css_create() <- fails here and returns error
>>    |
>>    |-> cgroup_finalize_control(cgrp)->cgroup_apply_control_disable(cgrp)->each_live_descendant_post(cgrp)->kill_css()->percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn) <- this triggers css_killed_ref_fn() to be called
>>    |
>>    |  css_killed_ref_fn() <- first css->destroy_work enqueue
>>    |    |
>>    |    |->  INIT_WORK(&css->destroy_work, css_killed_work_fn); queue_work(cgroup_destroy_wq, &css->destroy_work);
>>    |
>>    |
>>    |-> goto out_unlock;
>>    |     |
>>    |     |-> cgroup_kn_unlock(kernfs_node)->cgroup_put(cgrp)->css_put(&cgrp->self)->percpu_ref_put(&css->refcnt) <- this triggers css_release() to be called
>>    |
>>    |
>>       css_release(percpu_ref) <- second css->destroy_work enqueue
>>         |
>>         |->  INIT_WORK(&css->destroy_work, css_release_work_fn); queue_work(cgroup_destroy_wq, &css->destroy_work) <- and it fails here with BUG: corrupted list in insert_work; list_add corruption.
>>
>>
>> What seems to work for me as the simplest fix is to prevent enqueuing a dying
>> css in css_release() as below. Please let me know if that makes sense to you.
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 1779ccddb734..5618211487cc 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -5210,8 +5210,10 @@ static void css_release(struct percpu_ref *ref)
>>   	struct cgroup_subsys_state *css =
>>   		container_of(ref, struct cgroup_subsys_state, refcnt);
>> -	INIT_WORK(&css->destroy_work, css_release_work_fn);
>> -	queue_work(cgroup_destroy_wq, &css->destroy_work);
>> +	if (!(css->flags & CSS_DYING)) {
>> +		INIT_WORK(&css->destroy_work, css_release_work_fn);
>> +		queue_work(cgroup_destroy_wq, &css->destroy_work);
>> +	}
> 
> When the problem is ref imbalance, how can above be the solution? Of course
> release path won't cause an issue if they don't run, but we still need to
> free the thing, right?

Yes, but as far as I can see the percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn)
doesn't change the value of the refcnt, it just causes the css_killed_ref_fn() to be called
on it. Only css_get() & css_put() modify the refcnt value.
And for the "free the thing" the css_killed_work_fn() does that.
It calls offline_css(css) and css_put(css) for the whole css hierarchy.

-- 
Thanks,
Tadeusz
