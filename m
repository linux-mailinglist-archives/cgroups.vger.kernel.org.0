Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172A46A89C8
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 20:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCBTxA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 14:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCBTxA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 14:53:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F7B2ED64
        for <cgroups@vger.kernel.org>; Thu,  2 Mar 2023 11:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677786735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KwpX3YFb316Y6Yz0MMigE20cUWOeVNyriSBJ2SDd4TE=;
        b=GqtNoW/DN3JOJuswvA+ExgNcSfKlgoqRCvLy1rphrdM8pDNLtfrw8Ybrzv5Cylnbug3MJl
        elJ1Bu3cFQ/4oYhy8CPlr6hytgbFJYrt0+IYqSr/6rBXx3AUIv5r6kCFldnbx8+D1MesRR
        RoUGcpDz6ACIRgmgwfp7capDbZ+QiW4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-1OyD9CiPNMK1owDIzc10zw-1; Thu, 02 Mar 2023 14:52:14 -0500
X-MC-Unique: 1OyD9CiPNMK1owDIzc10zw-1
Received: by mail-wm1-f71.google.com with SMTP id k36-20020a05600c1ca400b003eac86e4387so1737019wms.8
        for <cgroups@vger.kernel.org>; Thu, 02 Mar 2023 11:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677786733;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwpX3YFb316Y6Yz0MMigE20cUWOeVNyriSBJ2SDd4TE=;
        b=3wksKHoKVtPIPlLn2YM0zq8WssfC7L91HO255l8XV+0Z1Kzhf7KloPl+ZwqGbbj2bl
         XLLUwZr3EbweCnvhjZCAdAyU74KTlyD8Rl/JKqyKYVCcaLsNwkTkL2LgwBgUl//SiwYj
         7O6fAJAJnzEPG5gZzRX6CJWwnzIulYPvJcgtKJgT3spM4ICpNNpfX3cnTMXXOZ1+VG7t
         zvtAgjSv5EWhXdqJByys3DCrVKKu20YkvpqlY0SJecSZkr97Hnw5sax7pv8HhMqiI0DP
         Mqyla778uXbcuncWulxMbIxmYHeNCx9FEJbi6ArnRNtXDhs4q9T2RKMMjSOPnFTzVM1y
         n+Uw==
X-Gm-Message-State: AO0yUKUzGypblgAjzpGoTepKWdBh4nlQLghPHJK+FxmKSGT8XF6OLWp+
        RuwU47PQp7btqkZPBJRhchXWdPsRssXQ3+LcGm2V+7YJQgd3wycvnihfTqLUWpbe9SMif9i66Jp
        xXozFAAwVDOvEnmtUfw==
X-Received: by 2002:a05:600c:46c9:b0:3d2:392e:905f with SMTP id q9-20020a05600c46c900b003d2392e905fmr8479909wmo.24.1677786732924;
        Thu, 02 Mar 2023 11:52:12 -0800 (PST)
X-Google-Smtp-Source: AK7set9F1G6JtF5DGOq6j8cbXWBmcpu8b83cZrJwsXL9wg3gwV4tF1cFLK0Rsx6WeyshNzx3NRsVBQ==
X-Received: by 2002:a05:600c:46c9:b0:3d2:392e:905f with SMTP id q9-20020a05600c46c900b003d2392e905fmr8479899wmo.24.1677786732690;
        Thu, 02 Mar 2023 11:52:12 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c468e00b003eb369abd92sm4702803wmo.2.2023.03.02.11.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 11:52:12 -0800 (PST)
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
In-Reply-To: <xhsmhv8jjnrwu.mognet@vschneid.remote.csb>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-3-bigeasy@linutronix.de>
 <xhsmh4jr4pbzc.mognet@vschneid.remote.csb>
 <ZABUMit05SZBDXRQ@dhcp22.suse.cz>
 <xhsmh1qm7pibs.mognet@vschneid.remote.csb>
 <ZACHa4wrtwpQbmP2@dhcp22.suse.cz>
 <xhsmhy1ofnxna.mognet@vschneid.remote.csb>
 <ZACdBuVBHZ/AMAh/@dhcp22.suse.cz>
 <xhsmhv8jjnrwu.mognet@vschneid.remote.csb>
Date:   Thu, 02 Mar 2023 19:52:11 +0000
Message-ID: <xhsmhmt4vnd78.mognet@vschneid.remote.csb>
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

On 02/03/23 14:34, Valentin Schneider wrote:
> On 02/03/23 13:56, Michal Hocko wrote:
>> What I am trying to evaluate here is whether it makes sense to support
>> and maintain a non-trivial code for something that might be working
>> sub-optimally or even not working properly in some corner cases. The
>> price for the maintenance is certainly not free.
>
> That's also what I'm trying to make sense of. Either way this will be
> frankenkernel territory, the cgroupv1 ship has already sailed for upstream
> IMO.

So, if someone ends up in a similar situation and considers kludging those
notifications back in:

Don't.


Have a look at:

  memcg_check_events()
  `\
    mem_cgroup_threshold()
    `\
      __mem_cgroup_threshold()
      `\
        eventfd_signal()

Having IRQs off, percpu reads, and the the eventfd signal is a nice recipe
for disaster.

The OOM notification sits outside of that, but any other memcg notification
will cause pain.

