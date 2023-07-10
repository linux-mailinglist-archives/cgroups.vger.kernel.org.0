Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A42E74DA12
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 17:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjGJPlW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 11:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGJPlV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 11:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C511A
        for <cgroups@vger.kernel.org>; Mon, 10 Jul 2023 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689003641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0D7PqDIktc2dtIxI/bE8WlEAjuSUexO7v405cL9P8Q=;
        b=FGtFc4daP/I6htFOtuxKHYQK+w9/v7jL8DXxGMHBYDWPiZtarSyzWeadYtwuUU1FdsNNTo
        NmYlfxnCEPQqE3A4QavPqLFaDiL/nadnWpLhnAdCTF1bMU/qyP2eehRdBw2uYj2sHdJRWZ
        UT8jPMtvSufeEYfKkDxyxCjyhs65WqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-gsY0jYqTNUyCCf89q1R_CQ-1; Mon, 10 Jul 2023 11:40:37 -0400
X-MC-Unique: gsY0jYqTNUyCCf89q1R_CQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF55D185A792;
        Mon, 10 Jul 2023 15:40:36 +0000 (UTC)
Received: from [10.22.33.187] (unknown [10.22.33.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67DFB2166B26;
        Mon, 10 Jul 2023 15:40:36 +0000 (UTC)
Message-ID: <74f1906e-fe58-c745-a851-b160374f7acf@redhat.com>
Date:   Mon, 10 Jul 2023 11:40:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup/cpuset: update parent subparts cpumask while
 holding css refcnt
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230701065049.1758266-1-linmiaohe@huawei.com>
 <fbabnjfly5w6fxrhe3eu6ebspngz2hd3tqs6rrbropcdvylnhs@ayjdpq73kwui>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <fbabnjfly5w6fxrhe3eu6ebspngz2hd3tqs6rrbropcdvylnhs@ayjdpq73kwui>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/10/23 11:11, Michal Koutný wrote:
> Hello.
>
> On Sat, Jul 01, 2023 at 02:50:49PM +0800, Miaohe Lin <linmiaohe@huawei.com> wrote:
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1806,9 +1806,12 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>   		cpuset_for_each_child(cp, css, parent)
>>   			if (is_partition_valid(cp) &&
>>   			    cpumask_intersects(trialcs->cpus_allowed, cp->cpus_allowed)) {
>> +				if (!css_tryget_online(&cp->css))
>> +					continue;
>>   				rcu_read_unlock();
>>   				update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
>>   				rcu_read_lock();
>> +				css_put(&cp->css);
> Apologies for a possibly noob question -- why is RCU read lock
> temporarily dropped within the loop?
> (Is it only because of callback_lock or cgroup_file_kn_lock (via
> notify_partition_change()) on PREEMPT_RT?)
>
>
>
> [
> OT question:
> 	cpuset_for_each_child(cp, css, parent)				(1)
> 		if (is_partition_valid(cp) &&
> 		    cpumask_intersects(trialcs->cpus_allowed, cp->cpus_allowed)) {
> 			if (!css_tryget_online(&cp->css))
> 				continue;
> 			rcu_read_unlock();
> 			update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
> 			  ...
> 			  update_tasks_cpumask(cp->parent)
> 			    ...
> 			    css_task_iter_start(&cp->parent->css, 0, &it);	(2)
> 			      ...
> 			rcu_read_lock();
> 			css_put(&cp->css);
> 		}
>
> May this touch each task same number of times as its depth within
> herarchy?

I believe the primary reason is because update_parent_subparts_cpumask() 
can potential run for quite a while. So we don't want to hold the 
rcu_read_lock for too long. There may also be a potential that 
schedule() may be called.

Cheers,
Longman

