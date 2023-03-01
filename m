Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E3F6A7359
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 19:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCASYH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Mar 2023 13:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCASYH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Mar 2023 13:24:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0BF196B5
        for <cgroups@vger.kernel.org>; Wed,  1 Mar 2023 10:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677695003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZOs1ZrtyzBGWlUNy3rirmBNUl52qHVNx2XoNoPG8A8=;
        b=hc76BNDgvY8IMQpJNOk3dV2Yqfhm5n4/YEELrTkp5pC3ZaZfhb7ANwv7ONetCJzdnInxJ6
        tZp9yvzKIB03Ch0M5RUV5MaAThn+e4X0yx+//mOzUAq2BcHqVzcbhF20UU9ftVqy0n8PuC
        HV+jAxZyvaOppOFlVNkQPut2XKvWp6A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-PMYLR0qVMAyR_5hEELvYUg-1; Wed, 01 Mar 2023 13:23:22 -0500
X-MC-Unique: PMYLR0qVMAyR_5hEELvYUg-1
Received: by mail-wm1-f70.google.com with SMTP id e17-20020a05600c219100b003e21fa60ec1so47043wme.2
        for <cgroups@vger.kernel.org>; Wed, 01 Mar 2023 10:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677695001;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZOs1ZrtyzBGWlUNy3rirmBNUl52qHVNx2XoNoPG8A8=;
        b=YGrAhA1ycz6yKywMKQWKkK3kWlHtGiMmmW2eyGrfMfEdNuvnStkApYBkGbiRr6D5OQ
         yE6ggPeEFGNEYMkNX+sLAwzorhwkbcq7d7FjZw7jGqMaEkmdFKTNZucO/ASfigFtvnrQ
         9V05H6qysUYFBB8RYZPFyR5Y000h0O1r1HDugB+iEYRGUPMRCjw4usW5mE5szfMC1i3v
         vtOaXKiyZasM+44FG8DzqMV4s3NftynTqqyN9v4uNbq1HWCZRQhMAMd03G9JUerwSUm7
         C7dl6NG4dOOqBYyhvA2k5o1W18TqZGJSR82Q22CK9DQrji8jMxmMNAcoPMyaaHcxdVOG
         L4Hw==
X-Gm-Message-State: AO0yUKVEREJP0n4FlhloyjJpbgAXaUv34vLtsdNtzhhzmjCb/DhFTXF0
        rzx/u4le9B+d6YoXnircxT2YBm+tiui28xOakneR2cvTowxf9U62l9OZ1KG3O9yJ70jAQJRaLkk
        Fn5MWBOICJh+TkG6F1Q==
X-Received: by 2002:adf:dd49:0:b0:2c7:ae2:56df with SMTP id u9-20020adfdd49000000b002c70ae256dfmr5831046wrm.70.1677695001015;
        Wed, 01 Mar 2023 10:23:21 -0800 (PST)
X-Google-Smtp-Source: AK7set+hh4qTKevxZ2Zg/AVz4ilic3h8zzImt+NubfkZPcwe1MT8NeAPx2k+sDTtoLXldr+E7Zd09Q==
X-Received: by 2002:adf:dd49:0:b0:2c7:ae2:56df with SMTP id u9-20020adfdd49000000b002c70ae256dfmr5831036wrm.70.1677695000749;
        Wed, 01 Mar 2023 10:23:20 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id f12-20020adfe90c000000b002c3f9404c45sm13221718wrm.7.2023.03.01.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 10:23:20 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5 2/6] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
In-Reply-To: <20220226204144.1008339-3-bigeasy@linutronix.de>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-3-bigeasy@linutronix.de>
Date:   Wed, 01 Mar 2023 18:23:19 +0000
Message-ID: <xhsmh4jr4pbzc.mognet@vschneid.remote.csb>
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

On 26/02/22 21:41, Sebastian Andrzej Siewior wrote:
> During the integration of PREEMPT_RT support, the code flow around
> memcg_check_events() resulted in `twisted code'. Moving the code around
> and avoiding then would then lead to an additional local-irq-save
> section within memcg_check_events(). While looking better, it adds a
> local-irq-save section to code flow which is usually within an
> local-irq-off block on non-PREEMPT_RT configurations.
>

Hey, sorry for necro'ing a year-old thread - would you happen to remember
what the issues were with memcg_check_events()? I ran tests against
cgroupv1 using an eventfd on OOM with the usual debug arsenal and didn't
detect anything, I'm guessing it has to do with the IRQ-off region
memcg_check_events() is called from?

I want cgroupv1 to die as much as the next person, but in that specific
situation I kinda need cgroupv1 to behave somewhat sanely on RT with
threshold events :/

Cheers

