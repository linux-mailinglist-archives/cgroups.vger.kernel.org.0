Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7C3CBE9C
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 23:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhGPVb6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 17:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235125AbhGPVb5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 17:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626470941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YABHDSw9b5sWUS8tb4/mSbwzJgD3Ug0F6zV+ryBO8W8=;
        b=L6e5tkVhaRSc5L4Z++0GnAfZ9RkQMD1kWHT4uI2smNMQh0paOnoeztbcvxl/7PRaKnVnVK
        EJHhxoHtg2T7oalrLidI+Ys7hx/qRfFLDrjQgIBfqSPG+WjIv7Ve5gWuL51O7PBkrBX5KR
        CxRHTlNXJaS+LcXlXOKpuZQb0rRU2l8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-EUIsBtWlP_CTj_qCYpLrFQ-1; Fri, 16 Jul 2021 17:29:00 -0400
X-MC-Unique: EUIsBtWlP_CTj_qCYpLrFQ-1
Received: by mail-qk1-f198.google.com with SMTP id i190-20020a3786c70000b02903b54f40b442so7389053qkd.0
        for <cgroups@vger.kernel.org>; Fri, 16 Jul 2021 14:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YABHDSw9b5sWUS8tb4/mSbwzJgD3Ug0F6zV+ryBO8W8=;
        b=MxZQa1ON8TOBGPBDyJok0AGjrV6uh0jSwkrQ2jhPt3KM7Gg7VnVdiPqnFh65oLb/WC
         WA49HvmF+1QaSYv8vaEZP2bSYM0fV9ShHdCtvfunXf1qtM555VsHkmaUMhUJcrlHOBPk
         oa2m1DSn9rIP3BjjW7He7HHOq3fEp58S2tWvrfomDNGdZ9fEudGBkNlBpXszVQYEVzEM
         y2Bd/3VMOmqX6jQCMSLrdIYWU1m5KCdCOmtOuLeiBvplzsGNG/yLx+/F3+kCT2M02XMN
         yw7VA7pA9iVOplJdsNyoUbBImwbguBPyVxgodUieYZXfZHa0FNOtu3vK+u1CQ0MZzsnh
         Sb1g==
X-Gm-Message-State: AOAM531egxR84lifCjIzwsiy8iNNpU58dIhR1ppK+v0vBaNBVfC/vnhV
        8NkJx87GqFG0LrsphTOaYzOGrdOZXxQ13+7ABqk8JDiiAA+oZsZ9vKVkUX+7XLwASTm06ElptH/
        Mkfv3ONyHA9Z6rgLarQ==
X-Received: by 2002:ac8:6ec1:: with SMTP id f1mr11059654qtv.294.1626470940409;
        Fri, 16 Jul 2021 14:29:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/rGIlMZXPU7T3qfOnTizDJI9I0dX2kqwDbKljo69VftMGZBefLuWX+uvFXWRvzofzBsFBCg==
X-Received: by 2002:ac8:6ec1:: with SMTP id f1mr11059637qtv.294.1626470940260;
        Fri, 16 Jul 2021 14:29:00 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id p3sm3716072qti.31.2021.07.16.14.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 14:28:59 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/6] cgroup/cpuset: Clarify the use of invalid
 partition root
To:     Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20210621184924.27493-1-longman@redhat.com>
 <20210621184924.27493-3-longman@redhat.com>
 <YNcHOe3o//pIiByh@mtj.duckdns.org>
 <6ea1ac38-73e1-3f78-a5d2-a4c23bcd8dd1@redhat.com>
 <YONGk3iw/zrNzwLK@mtj.duckdns.org>
 <c6ae2d9b-ad6e-9bbd-b25c-f52b0ff6fb9b@redhat.com>
 <1bb119a1-d94a-6707-beac-e3ae5c03fae5@redhat.com>
 <8c44b659-3fe4-b14f-fac1-cbd5b23010c3@redhat.com>
 <YPHwG61qGDa3h6Wg@mtj.duckdns.org>
 <e8c538a8-bf5c-b04c-1b21-ac22cd158dd1@redhat.com>
 <YPH3sF56gK71CxXY@mtj.duckdns.org>
Message-ID: <4a804edc-17ec-d8fa-d8c1-273252ba0ee4@redhat.com>
Date:   Fri, 16 Jul 2021 17:28:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPH3sF56gK71CxXY@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/16/21 5:18 PM, Tejun Heo wrote:
> Hello,
>
> On Fri, Jul 16, 2021 at 05:12:17PM -0400, Waiman Long wrote:
>> Are you suggesting that we add a cpuset.cpus.events file that allows
>> processes to be notified if an event (e.g. hotplug) that changes a partition
>> root to invalid partition happens or when explicit change to a partition
>> root fails? Will that be enough to satisfy your requirement?
> Yeah, something like that or make the current state file generate events on
> state transitions.


Sure. I will change the patch to make cpuset.cpus.partition generates 
event when its state change. Thanks for the suggestion. It definitely 
makes it better.

Cheers,
Longman

