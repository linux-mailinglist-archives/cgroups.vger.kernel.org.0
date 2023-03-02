Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB0C6A8444
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 15:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCBOfh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 09:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCBOfg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 09:35:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BF612864
        for <cgroups@vger.kernel.org>; Thu,  2 Mar 2023 06:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677767669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5V3alQcVkOJNOkTm4XGYWiJj17BscHIm8UZULKEJ6sI=;
        b=IsHYNie5blTXeBOuDT+Mf45PxS2KSfdzsVBMoaM+MNwHvbkzINbwkAaUdAyejC6M48v39B
        qwZsqszXChqaan5YDf+6glKH6UULrCM9CkTzETgpOD/Y4w7JKDb4/Q+oWwzuL95tz0JRAd
        zLLvLJ/3AoSVfXhC/bnA5jZKcEBNuyw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-Gua4dMAiN56751292Xjp5w-1; Thu, 02 Mar 2023 09:34:28 -0500
X-MC-Unique: Gua4dMAiN56751292Xjp5w-1
Received: by mail-wm1-f72.google.com with SMTP id x18-20020a1c7c12000000b003e1e7d3cf9fso1355291wmc.3
        for <cgroups@vger.kernel.org>; Thu, 02 Mar 2023 06:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677767667;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5V3alQcVkOJNOkTm4XGYWiJj17BscHIm8UZULKEJ6sI=;
        b=sBfJIFelGE7RcyJsgWaGvXwB1pfTAI4mznjrnctvLMnloDPfHnHL36+tR74x7HMDXV
         5RGOUvAUPSuqw0yRZN/HJXYMMY657JTnbsPNKINWFhogAWiekG1u/3K53EUeUDvfl4de
         4mx0OVtqtdqfM184GkzkhRT+eDnZsoitvR0j64wov6kLRC7+5Hoq3xpMMBi09ANQisfN
         9OUGrtqTk8PJCb94hERvl3SCMY5eJwCeQ09cqSbbSBYpLoTwdr6cGkrzn2HTSTcdGQnl
         UQuUo9AyadqlIQc03MRy5xNyuwF2VOp6AwbN01IVAQN0suxYk05SX39xHxXsVdfZoSDf
         PjpQ==
X-Gm-Message-State: AO0yUKUf6wGCj7NApgDs1lk+DLJF5GzA8jf6+vr/DJe6W1NcmqU8qRVC
        VBNuwYcoNCyEdah8klkXj9p5KUjfWIwRYKA8ZUq/NE28XJOM3yXugn1Z6pN5iNxajIgU2GEoE6V
        vBO/+Ct2d+9D95pjcuQ==
X-Received: by 2002:a05:600c:920:b0:3eb:36fa:b78d with SMTP id m32-20020a05600c092000b003eb36fab78dmr7098001wmp.23.1677767667065;
        Thu, 02 Mar 2023 06:34:27 -0800 (PST)
X-Google-Smtp-Source: AK7set/4wSWGfskIqZwg2PojVYKWuDr8WCSFjAix0fVOutM6MiZoj7w/IS6U3kZIOGQxTqcYrTZwJQ==
X-Received: by 2002:a05:600c:920:b0:3eb:36fa:b78d with SMTP id m32-20020a05600c092000b003eb36fab78dmr7097979wmp.23.1677767666831;
        Thu, 02 Mar 2023 06:34:26 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id bi12-20020a05600c3d8c00b003de2fc8214esm3227766wmb.20.2023.03.02.06.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 06:34:26 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v5 2/6] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
In-Reply-To: <ZACdBuVBHZ/AMAh/@dhcp22.suse.cz>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-3-bigeasy@linutronix.de>
 <xhsmh4jr4pbzc.mognet@vschneid.remote.csb>
 <ZABUMit05SZBDXRQ@dhcp22.suse.cz>
 <xhsmh1qm7pibs.mognet@vschneid.remote.csb>
 <ZACHa4wrtwpQbmP2@dhcp22.suse.cz>
 <xhsmhy1ofnxna.mognet@vschneid.remote.csb>
 <ZACdBuVBHZ/AMAh/@dhcp22.suse.cz>
Date:   Thu, 02 Mar 2023 14:34:25 +0000
Message-ID: <xhsmhv8jjnrwu.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 02/03/23 13:56, Michal Hocko wrote:
> On Thu 02-03-23 12:30:33, Valentin Schneider wrote:
>> On 02/03/23 12:24, Michal Hocko wrote:
>> > On Thu 02-03-23 10:18:31, Valentin Schneider wrote:
>> >> On 02/03/23 08:45, Michal Hocko wrote:
>> >> > On Wed 01-03-23 18:23:19, Valentin Schneider wrote:
>> > [...]
>> >> >> I want cgroupv1 to die as much as the next person, but in that specific
>> >> >> situation I kinda need cgroupv1 to behave somewhat sanely on RT with
>> >> >> threshold events :/
>> >> >
>> >> > Could you expand on the usecase?
>> >> >
>> >>
>> >> In this case it's just some middleware leveraging memcontrol cgroups and
>> >> setting up callbacks for in-cgroup OOM events. This is a supported feature
>> >> in cgroupv2, so this isn't a problem of cgroupv1 vs cgroupv2 feature
>> >> parity, but rather one of being in a transitional phase where the
>> >> middleware itself hasn't fully migrated to using cgroupv2.
>> >
>> > How is this related to the RT kernel config? memcg OOM vs any RT
>> > assumptions do not really get along well AFAICT.
>> >
>>
>> Yep. AIUI the tasks actually relying on RT guarantees DTRT (at least
>> regarding memory allocations, or lack thereof), but other non-RT-reliant
>> tasks on other CPUs come and go, hence the memcg involvement.
>
> So are you suggesting that the RT kernel is used for mixed bag of
> workloads with RT and non RT assumptions? Is this really a reasonable
> and reliable setup?
>

To some extent :-)

> What I am trying to evaluate here is whether it makes sense to support
> and maintain a non-trivial code for something that might be working
> sub-optimally or even not working properly in some corner cases. The
> price for the maintenance is certainly not free.

That's also what I'm trying to make sense of. Either way this will be
frankenkernel territory, the cgroupv1 ship has already sailed for upstream
IMO.

