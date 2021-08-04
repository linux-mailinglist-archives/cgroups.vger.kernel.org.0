Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34493E0516
	for <lists+cgroups@lfdr.de>; Wed,  4 Aug 2021 18:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhHDQBG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Aug 2021 12:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239274AbhHDQBF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Aug 2021 12:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628092852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEsjrzEf989GiFesEbeonJ3m9TGKEwxRikvJxw0JX+4=;
        b=cXMGZoc1XvE4W9cQAKBpJWkPubhcJ9qMGvNcV4EmEML4tyhcmO3kYmSqJCxJ1i8cR2CODz
        kA7+oRqHSjZeIxAe98IMGZ0rM6eeh5iSL+5/rvr3Ch1C0Hp8nj7E1Pv9/vrA03HhAxvyLG
        zFLS6nEb6d2Mvb1v806pb1wkn3ZTwz0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-Cyjm2yTJMKWeLqauOBkm4w-1; Wed, 04 Aug 2021 12:00:51 -0400
X-MC-Unique: Cyjm2yTJMKWeLqauOBkm4w-1
Received: by mail-qt1-f197.google.com with SMTP id y12-20020ac8524c0000b029028acd693c6bso1213795qtn.20
        for <cgroups@vger.kernel.org>; Wed, 04 Aug 2021 09:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kEsjrzEf989GiFesEbeonJ3m9TGKEwxRikvJxw0JX+4=;
        b=Iuyb7+Ps3NnsPOfef06IGPSwZV6pSg/Mn0AjKmrOD8oUMpRjrlC3PeRfG1gsztmYUB
         mSeOVg/n0aH06ukKhRwVf3Pj42yFmRG2VSiukfxVxOKbRT+zY96ApSs1FE2HwmWLrgJl
         v6rE6Qhd+KJJ1rUs3qA++MgUophR8fJAvB7jOiPeB3iBkZUxyikPJ7N9FqsiwqG7oPsX
         mjfoi0dX9IThnBUgLFZaMaiVyEJxM2TAVfm7Yi/1nLu4Cw2l0scCunAfLlqYAJiY4OSi
         XeEUxPhi1JGTF7sy/L4YTqkJkems3DFGgyBmJYjs8cSBGf7Hxf9SKb7vw2MPIqC8NM4V
         1+pQ==
X-Gm-Message-State: AOAM532k5PyTd9fslZWqjSNvA4cQ3nMxhNzAB55nqTfZIEUYmuAOMp/z
        zs7fo6NNyd9/X1E1CzL0g5Z6MfsBz8FawiiysSLx98ne2EgfSQkjr72k/NBZ5DVGOhZc1GfeVaN
        KUaoIFezzDLxSKShfAQ==
X-Received: by 2002:a05:620a:3c8:: with SMTP id r8mr115988qkm.19.1628092850005;
        Wed, 04 Aug 2021 09:00:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1QX2uMiY0+tjFXi1oQjufonahM1RQ6aSelVwGVf8DR+eHT/HQ7Hgz4p3Zz9FvTypcufD6pQ==
X-Received: by 2002:a05:620a:3c8:: with SMTP id r8mr115953qkm.19.1628092849770;
        Wed, 04 Aug 2021 09:00:49 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j4sm1480452qkk.78.2021.08.04.09.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:00:49 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] mm/memcg: Disable task obj_stock for PREEMPT_RT
To:     Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210803175519.22298-1-longman@redhat.com> <87h7g62jxm.ffs@tglx>
 <8953e099-356e-ee09-a701-f4c7f4cda487@redhat.com>
Message-ID: <ce048e8b-bd2d-7517-d8e0-f74be98b8dee@redhat.com>
Date:   Wed, 4 Aug 2021 12:00:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8953e099-356e-ee09-a701-f4c7f4cda487@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/3/21 9:40 PM, Waiman Long wrote:
> On 8/3/21 7:21 PM, Thomas Gleixner wrote:
>> To complete the analysis of drain_local_stock(). AFAICT that function
>> can only be called from task context. So what is the purpose of this
>> in_task() conditional there?
>>
>>     if (in_task())
>>            drain_obj_stock(&stock->task_obj);
> I haven't done a full analysis to see if it can be called from task 
> context only. Maybe in_task() check isn't needed, but having it there 
> provides the safety that it will still work in case it can be called 
> from interrupt context. 

After looking at possible call chains that can lead to 
drain_local_stock(), one call chain comes from the allocation of slab 
objects which I had previously determined to be callable from interrupt 
context. So it is prudent to add a in_task() check here.

Cheers,
Longman

