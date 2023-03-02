Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD39C6A8239
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 13:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCBMbX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 07:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCBMbU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 07:31:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB43D3C00
        for <cgroups@vger.kernel.org>; Thu,  2 Mar 2023 04:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677760237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0BNagDX901NGIZENJZlE/kKlDXQ8u0vxMy0FsNxfXdA=;
        b=aPec2EFXbg+f/IWDxlrzA/Xe4IkaLhgwFLKuMnxErYuwgTWagF6IAMRED1OxU4zps/naE4
        UkRJUXMe7eHC+668t11d6JwCWGTPfb/TEOwx4gfBHdPZSsI9sOUrVqknBb+r3o8t0xCkVW
        d2bMC/fBOg1uGVGl84r5LAP/C6j84Hk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85--S-v8dkuOZ-iGg_RoIK6mQ-1; Thu, 02 Mar 2023 07:30:36 -0500
X-MC-Unique: -S-v8dkuOZ-iGg_RoIK6mQ-1
Received: by mail-wm1-f69.google.com with SMTP id f14-20020a7bcc0e000000b003dd41ad974bso1016957wmh.3
        for <cgroups@vger.kernel.org>; Thu, 02 Mar 2023 04:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677760235;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BNagDX901NGIZENJZlE/kKlDXQ8u0vxMy0FsNxfXdA=;
        b=sJE/NWYcWgqNjW1+YS5qh4z1QDQhqblRfnPKsmA8DdYctghD7KUgdTIRU4IWb+k4bN
         fsrr93eVh5aOHCOy/MalWzroD/Z4k0xOQA69nXj7S3ELhblM3Yxh/he9t+BlgD45f2l1
         /bFrNjlsiDsVOdR6aHmi8xvatjJKIz1pJA/kho/xWARaz9l4xLqIuqm3e4mSfb3bMXCu
         vf6QTIoirhZcIfUYKrPYo0ZsjD7bHmARTV6jNAEbF5ZFwKgIDpXzqjYmeyIaRVVDUD7m
         jkbMmB/NPFyBAqUR8lCPQ8juggU210Z20RPa6TUH1/jSItFZKNVIsv02C8GP7a2KmJEA
         JPbw==
X-Gm-Message-State: AO0yUKV5Eqk1uJXL1tyd7FdyL7G28FVXGbohrK36St6nAuDmYisDADea
        x2KqOGqjodbTeErqDsTyxGK6XlbyrllpxYHqLuXlkLl80IveVk0Z6pIzU1xKQhmEjc5l2JIe30O
        GcnCh+lqWoGPTWW9UNw==
X-Received: by 2002:a5d:504e:0:b0:2c5:48ed:d258 with SMTP id h14-20020a5d504e000000b002c548edd258mr7506837wrt.35.1677760235542;
        Thu, 02 Mar 2023 04:30:35 -0800 (PST)
X-Google-Smtp-Source: AK7set8qGb9TJB25GsUgYAXlpb2DDMq1WMmS3R0tU/RjBs2WSPq9E+n0/I/NuaRFHSTyv5x8uRwx/A==
X-Received: by 2002:a5d:504e:0:b0:2c5:48ed:d258 with SMTP id h14-20020a5d504e000000b002c548edd258mr7506815wrt.35.1677760235277;
        Thu, 02 Mar 2023 04:30:35 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d51c5000000b002c70d97af78sm15422565wrv.85.2023.03.02.04.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:30:34 -0800 (PST)
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
In-Reply-To: <ZACHa4wrtwpQbmP2@dhcp22.suse.cz>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-3-bigeasy@linutronix.de>
 <xhsmh4jr4pbzc.mognet@vschneid.remote.csb>
 <ZABUMit05SZBDXRQ@dhcp22.suse.cz>
 <xhsmh1qm7pibs.mognet@vschneid.remote.csb>
 <ZACHa4wrtwpQbmP2@dhcp22.suse.cz>
Date:   Thu, 02 Mar 2023 12:30:33 +0000
Message-ID: <xhsmhy1ofnxna.mognet@vschneid.remote.csb>
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

On 02/03/23 12:24, Michal Hocko wrote:
> On Thu 02-03-23 10:18:31, Valentin Schneider wrote:
>> On 02/03/23 08:45, Michal Hocko wrote:
>> > On Wed 01-03-23 18:23:19, Valentin Schneider wrote:
> [...]
>> >> I want cgroupv1 to die as much as the next person, but in that specific
>> >> situation I kinda need cgroupv1 to behave somewhat sanely on RT with
>> >> threshold events :/
>> >
>> > Could you expand on the usecase?
>> >
>>
>> In this case it's just some middleware leveraging memcontrol cgroups and
>> setting up callbacks for in-cgroup OOM events. This is a supported feature
>> in cgroupv2, so this isn't a problem of cgroupv1 vs cgroupv2 feature
>> parity, but rather one of being in a transitional phase where the
>> middleware itself hasn't fully migrated to using cgroupv2.
>
> How is this related to the RT kernel config? memcg OOM vs any RT
> assumptions do not really get along well AFAICT.
>

Yep. AIUI the tasks actually relying on RT guarantees DTRT (at least
regarding memory allocations, or lack thereof), but other non-RT-reliant
tasks on other CPUs come and go, hence the memcg involvement.

> --
> Michal Hocko
> SUSE Labs

