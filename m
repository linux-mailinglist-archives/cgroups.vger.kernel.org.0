Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAAC76DD03
	for <lists+cgroups@lfdr.de>; Thu,  3 Aug 2023 03:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjHCBJA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Aug 2023 21:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjHCBI7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Aug 2023 21:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B732E4D
        for <cgroups@vger.kernel.org>; Wed,  2 Aug 2023 18:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691024887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNCl3TS6o3J06UrSCjbBrl21cvR06Nfa+qdUrrTWUOw=;
        b=a6hjxVzP4VbUzknaBHrQcQaolSiHo9/QTSiZt92Rrd6LoX55WkNFQLGEYXZgiaXaoidNEF
        8O1lC/rE2Ytv4U0DzCWTHiG9AyeHn/YMoNlZ8mgMVtNpieLuKWesQ36HIckinu48w3HjLv
        Ts6mQ8u5S7HcUZKtXq0lELjcsTZoXRg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-kT90DbMtPA-AfZ-sdNrgZQ-1; Wed, 02 Aug 2023 21:08:04 -0400
X-MC-Unique: kT90DbMtPA-AfZ-sdNrgZQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7DC228237CB;
        Thu,  3 Aug 2023 01:08:03 +0000 (UTC)
Received: from [10.22.18.41] (unknown [10.22.18.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C0D7492CA6;
        Thu,  3 Aug 2023 01:08:01 +0000 (UTC)
Message-ID: <0c019181-7e9b-0a19-c477-f8630ea98124@redhat.com>
Date:   Wed, 2 Aug 2023 21:08:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 4/5] cgroup/cpuset: Documentation update for partition
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230713172601.3285847-1-longman@redhat.com>
 <20230713172601.3285847-5-longman@redhat.com>
 <ZMrERWeIeEOGzXHO@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZMrERWeIeEOGzXHO@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/2/23 17:01, Tejun Heo wrote:
> Hello, Waiman.
>
> On Thu, Jul 13, 2023 at 01:26:00PM -0400, Waiman Long wrote:
> ...
>> +	When a valid partition is created, the value of this file will
>> +	be automatically set to the largest subset of "cpuset.cpus"
>> +	that can be granted for exclusive access from its parent if
>> +	its value isn't explicitly set before.
>> +
>> +	Users can also manually set it to a value that is different from
>> +	"cpuset.cpus".	In this case, its value becomes invariant and
>> +	may no longer reflect the effective value that is being used
>> +	to create a valid partition if some dependent cpuset control
>> +	files are modified.
>> +
>> +	There are constraints on what values are acceptable to this
>> +	control file.  If a null string is provided, it will invalidate a
>> +	valid partition root and reset its invariant state.  Otherwise,
>> +	its value must be a subset of the cgroup's "cpuset.cpus" value
>> +	and the parent cgroup's "cpuset.cpus.exclusive" value.
> As I wrote before, the hidden state really bothers me. This is fine when
> there is one person configuring the system, but working with automated
> management and monitoring tools can be really confusing at scale when there
> are hidden states like this as there's no way to determine the current state
> by looking at what's visible at the interface level.
>
> Can't we do something like the following?
>
> * cpuset.cpus.exclusive can be set to any possible cpus. While I'm not
>    completely against failing certain writes (e.g. siblings having
>    overlapping masks is never correct or useful), expanding that to
>    hierarchical checking quickly gets into trouble around what happens when
>    an ancestor retracts a CPU.
>
>    I don't think it makes sense to reject writes if the applied rules can't
>    be invariants for the same reason given for avoiding hidden states - the
>    system can be managed by multiple agents at different delegation levels.
>    One layer changing resource configuration shouldn't affect the success or
>    failure of configuration operations in other layers.
>
> * cpuset.cpus.exclusive.effective shows what's currently available for
>    exclusive usage - ie. what'd be used for a partition if the cgroup is to
>    become a partition at that point.
>
>    This, I think, gets rid of the need for the hidden states. If .exclusive
>    of a child of a partition is empty, its .exclusive.effective can show all
>    the CPUs allowed in it. If .exclusive is set then, .exclusive.effective
>    shows the available subset.
>
> What do you think?
>
Sure, I can add cpuset.cpus.exclusive.effective and allow users to set 
cpuset.cpus.exclusive to whatever they want, just like cpuset.cpus. I 
will rework the patch series and send out a new version sometimes next 
week.

With the new cpuset.cpus.exclusive.effective file, cpuset.cpus.exclusive 
will really be invariant and become whatever the users set. 
cpuset.cpus.exclusive.effective file will only have value if 
cpuset.cpus.exclusive set or it becomes a local partition.

Hopefully this will be the final version.

Cheers,
Longman

