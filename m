Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02768DCDB
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 16:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjBGPWh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 10:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjBGPWg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 10:22:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E6212B0
        for <cgroups@vger.kernel.org>; Tue,  7 Feb 2023 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675783300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mcb+6eBv4ysUkvKYOCW9Qw2SLWinzQcLfFwr3z2U8Vw=;
        b=WgZhleChQd756gVgKwwOUo+OZyUMwxK6aPE7H5t7VW+zmlFauCsb/U71XskXe0VI6tVhUk
        M7JdNAgWlNi6n6jCC5E9nBVbruyHE47+LmdfL4pxLRGAeYuuS+opZz/WcemXN2J/4VB8JC
        k2Bx+4rqIMOi+E69nDKLPwPUgqUjsrE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-_yGM4cXaPLWBVPPhq1meyg-1; Tue, 07 Feb 2023 10:21:37 -0500
X-MC-Unique: _yGM4cXaPLWBVPPhq1meyg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CBAF811E9C;
        Tue,  7 Feb 2023 15:21:36 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A23F7492B21;
        Tue,  7 Feb 2023 15:21:35 +0000 (UTC)
Message-ID: <a264c69a-8dd9-3724-bfc8-97c60b45630b@redhat.com>
Date:   Tue, 7 Feb 2023 10:21:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] sched/isolation: Merge individual nohz_full features
 into a common housekeeping flag
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20230203232409.163847-1-frederic@kernel.org>
 <20230203232409.163847-2-frederic@kernel.org>
 <20230206155107.GA31453@blackbody.suse.cz> <Y+I61dp5qPkWK4s2@lothringen>
 <20230207125900.GA24523@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230207125900.GA24523@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/7/23 07:59, Michal Koutný wrote:
> On Tue, Feb 07, 2023 at 12:49:41PM +0100, Frederic Weisbecker <frederic@kernel.org> wrote:
>> But what do we need these annotations for? The only outcome I've ever
>> seen with these is that it confuses everyone.
> Take that as a note of a lone actor then who found it useful documenting
> relations between various parts of the code.
>
>> This way I can add the support for each part smoothly.
> Yeah, that makes sense.
>
>> For example first patch moves HK_TYPE_TIMER to HK_TYPE_KERNEL_NOISE
>> and unbound timers are supported by cpuset.kernel_noise, second patch
>> moves HK_TYPE_WQ to HK_TYPE_KERNEL_NOISE and unbound workqueues are
>> supported by cpuset.kernel_noise, etc until all of them turned by
>> nohz_full= are supported...
> So does this mean you'll re-introduce the finer grained HK_* flags
> again?
>
> The idea (not only mine?) is that this would extend
> cpuset.cpus.partition that only allows HK_TYPE_DOMAIN analogy. The
> mapping to individual flags may not be exposed to users. The graduality
> could be achieved by adding more flags under user_exposed_term.
>
> Just to be on the same page -- that's how I understand it, the original
> HK_* resolution turned out impractical for users and that's why the
> direction is towards some loose combinations representing user
> intentions. Is that right?

What I am envisioning is to have additional isolation attributes to an 
isolated partition that correspond to what a user can specify on the 
kernel command line today. That requires the minimal amount of learning 
from the user community. Any finer grained separation of isolation 
features will just confuse user. I don't see a problem with a generic 
HK_TYPE_KERNEL_NOISE that gets enabled when an attribute that correspond 
to nohz_full is used.

Cheers,
Longman

