Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5B6A7FD7
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 11:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCBKTZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 05:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCBKTX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 05:19:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F4313D4F
        for <cgroups@vger.kernel.org>; Thu,  2 Mar 2023 02:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677752316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=drADIWeR5WqaFv7Oh+ltYqYvRuiCs23o1kgF+pSQhdM=;
        b=CDti7wZ+wXGOtIfEqtmEadMGDgbQfhS7CkKLTH6TYpOqfS9FdTu6+6NwMvp5PPbsUxlhVR
        92UV3pAIzKBaHw13CobGSps6JZ1EJtndfuBPDkRVpM+IsHZNDx3qEKNOxJdlV3edXe67h2
        w1Hy8lQCkKbam0M2Cu6Lp+Cs8oI8ccE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-617-Uspiun9sMrSbbl6TWsPbBg-1; Thu, 02 Mar 2023 05:18:35 -0500
X-MC-Unique: Uspiun9sMrSbbl6TWsPbBg-1
Received: by mail-wm1-f69.google.com with SMTP id az39-20020a05600c602700b003e97eb80524so1054848wmb.4
        for <cgroups@vger.kernel.org>; Thu, 02 Mar 2023 02:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677752313;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drADIWeR5WqaFv7Oh+ltYqYvRuiCs23o1kgF+pSQhdM=;
        b=VTog1A4b7GdTsa6P5CoysMzxbT+hOXYvrbYEUyeBkgicg6SvQ/6ab162qPB2yaMTuA
         uRKLw3DWHwoAYEngEy6nU5iW0n08QYHdTgTIepZlEnSSxQjJjeLGWX04pizSFQG3mJK5
         Ph5bccn2BSSEMPeLGmuH4rRUdko3DkY1fNSE1Nxiq9jVU/Oo+Ez2KkVuNtKhUgpD2/xv
         IIJsI4ZvbBwAXnCwiXHB6bDqCj5ZDPzhOhiUS7sfcADBhRyH0NK8oWzjP3XGxdVJQfpl
         bsyDDaH/FzfHNFWcXc/8zahfMoo8dXHJklxfRLvUQzvck272VgHhOfFJVzRWD2UcrSSU
         Ud6A==
X-Gm-Message-State: AO0yUKWb4vUtDjwfRW3DSwweW3IZ6PE7bmCLIxF4vYDW4qUB30lv9Elh
        d/vfKK+58CLMcJkkFi06DwHYxhhGtz1tNOSnlztZqMUaRidOXt6OP1akfYykNXAXacbd2HQ/AvK
        B6vqHqbxl/FY3G+K/kdL4Rz8=
X-Received: by 2002:a5d:558d:0:b0:2c7:694:aa18 with SMTP id i13-20020a5d558d000000b002c70694aa18mr6612423wrv.15.1677752313580;
        Thu, 02 Mar 2023 02:18:33 -0800 (PST)
X-Google-Smtp-Source: AK7set/uxV1v23Oh/sg3P74SBCZjjX//Q96d/fEGultmNCbYhqze+hDU7mOVq32IblaxwcWQxNVqMQ==
X-Received: by 2002:a5d:558d:0:b0:2c7:694:aa18 with SMTP id i13-20020a5d558d000000b002c70694aa18mr6612409wrv.15.1677752313305;
        Thu, 02 Mar 2023 02:18:33 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d4d86000000b002ca864b807csm12635217wru.0.2023.03.02.02.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:18:32 -0800 (PST)
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
In-Reply-To: <ZABUMit05SZBDXRQ@dhcp22.suse.cz>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-3-bigeasy@linutronix.de>
 <xhsmh4jr4pbzc.mognet@vschneid.remote.csb>
 <ZABUMit05SZBDXRQ@dhcp22.suse.cz>
Date:   Thu, 02 Mar 2023 10:18:31 +0000
Message-ID: <xhsmh1qm7pibs.mognet@vschneid.remote.csb>
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

On 02/03/23 08:45, Michal Hocko wrote:
> On Wed 01-03-23 18:23:19, Valentin Schneider wrote:
>> On 26/02/22 21:41, Sebastian Andrzej Siewior wrote:
>> > During the integration of PREEMPT_RT support, the code flow around
>> > memcg_check_events() resulted in `twisted code'. Moving the code around
>> > and avoiding then would then lead to an additional local-irq-save
>> > section within memcg_check_events(). While looking better, it adds a
>> > local-irq-save section to code flow which is usually within an
>> > local-irq-off block on non-PREEMPT_RT configurations.
>> >
>>
>> Hey, sorry for necro'ing a year-old thread - would you happen to remember
>> what the issues were with memcg_check_events()? I ran tests against
>> cgroupv1 using an eventfd on OOM with the usual debug arsenal and didn't
>> detect anything, I'm guessing it has to do with the IRQ-off region
>> memcg_check_events() is called from?
>
> I would have to look into details but IIRC the resulting code to make
> the code RT safe was dreaded and hard to maintain as a result. As we
> didn't really have any real life usecase, disabling the code was an
> easier way to go forward. So it is not the code would be impossible to
> be enabled for RT it just doeasn't seam to be worth all the complexity.
>

Right, thanks for having a look.

>> I want cgroupv1 to die as much as the next person, but in that specific
>> situation I kinda need cgroupv1 to behave somewhat sanely on RT with
>> threshold events :/
>
> Could you expand on the usecase?
>

In this case it's just some middleware leveraging memcontrol cgroups and
setting up callbacks for in-cgroup OOM events. This is a supported feature
in cgroupv2, so this isn't a problem of cgroupv1 vs cgroupv2 feature
parity, but rather one of being in a transitional phase where the
middleware itself hasn't fully migrated to using cgroupv2.

> --
> Michal Hocko
> SUSE Labs

