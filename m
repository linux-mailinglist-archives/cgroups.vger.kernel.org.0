Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C101409C81
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhIMSrZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 14:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240520AbhIMSrY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 14:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631558768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/URbjttbgh/qE1agh24JiENV0g90v5EslC9AJDtoVI=;
        b=RKysiDFKcvko/M+htPF8E9xQxbmZnGO7lD2F0vnmLwFQVTjoeOgCYUOdYnuPioeT32XlJc
        S0ovkqa2kONyR6tyqS3J4v0a65fov7F9Nrlt/BCY9cNbvE4Mu8fAG3bpt9FxlUyWaFT2e9
        IEe5hL4lLESTwvl/kRV2imXfGt/s2w4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-DXUHuv7DOeWXdT71JBTsXg-1; Mon, 13 Sep 2021 14:46:07 -0400
X-MC-Unique: DXUHuv7DOeWXdT71JBTsXg-1
Received: by mail-qk1-f199.google.com with SMTP id k9-20020a05620a138900b003d59b580010so41943944qki.18
        for <cgroups@vger.kernel.org>; Mon, 13 Sep 2021 11:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j/URbjttbgh/qE1agh24JiENV0g90v5EslC9AJDtoVI=;
        b=K+BJDC7il9nuNnMg194K/5Jq35CWPtuki8f6C6J6j6BRzIq7bKftW6BItSQVjztTTF
         Ywj0WaXuDTf2lldirJ5XJxCvBrMCC7UDo3OQhKDAik5vmK1HPtEDtvYeZVJDQS40vNum
         Kkq9alvawy+VZm1QgT2hR+BLc4KdujIP2Pw8kaxV33H8r5g2lEa6tvTqE0zUNkCiZWXS
         glVuY6XUIN0jkXewzUxG2Rk+nqIbozrYJdgK8Q/Ll0wSLfTrEmOZR4WomcynP/HUFBGe
         foqtxRkKNIKzN8HK3GuOR0573QBRf12nm49EEij2oPHRBaz1Fb8yeFfq0N3oTWhzj9h8
         ghMQ==
X-Gm-Message-State: AOAM530x+B7VW8yn7WBPDMVUFsUkLAJhOXDzpQd0rjroEIKTYT8IBJmm
        Mvh/FMaPNpAf0jeydPhCoQuyW0n0meI3DVXhbuj+xS6xp3mcaqpHwyAOj4ddGqfb3hbYjjiE37R
        tQMiUzO5DQPIBX2BN5w==
X-Received: by 2002:a05:620a:2e4:: with SMTP id a4mr1076398qko.288.1631558766948;
        Mon, 13 Sep 2021 11:46:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfX00oXtW3TpE4cR7tFJDu/VKjM6MMAOeUkfZHdsIs+TOtMYZvnnkkIGQGHcMsFFf8+hRQwg==
X-Received: by 2002:a05:620a:2e4:: with SMTP id a4mr1076383qko.288.1631558766792;
        Mon, 13 Sep 2021 11:46:06 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id l126sm5983384qke.96.2021.09.13.11.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 11:46:06 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/2] cgroup: Fix incorrect warning from
 cgroup_apply_control_disable()
To:     Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juri Lelli <juri.lelli@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210910024256.7615-1-longman@redhat.com>
 <YT+TA6ItnF9xM3cR@slm.duckdns.org>
 <125c4202-68d1-1a4e-03d6-2b18f0794ba4@redhat.com>
 <dbb1a221-b3d2-5086-e47b-8a2c764d60ad@redhat.com>
 <YT+cPPyDPimHibSC@slm.duckdns.org>
Message-ID: <e1190877-f5b7-b052-cd80-a7e558c379a4@redhat.com>
Date:   Mon, 13 Sep 2021 14:46:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YT+cPPyDPimHibSC@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/13/21 2:45 PM, Tejun Heo wrote:
> On Mon, Sep 13, 2021 at 02:43:44PM -0400, Waiman Long wrote:
>>> The problem with percpu_ref_is_dying() is the fact that it becomes true
>>> after percpu_ref_exit() is called in css_free_rwork_fn() which has an
>>> RCU delay. If you want to catch the fact that kill_css() has been
>>> called, we can check the CSS_DYING flag which is set in kill_css() by
>>> commit 33c35aa481786 ("cgroup: Prevent kill_css() from being called more
>>> than once"). Will that be an acceptable alternative?
>> Something like
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 881ce1470beb..851e54800ad8 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -3140,6 +3140,9 @@ static void cgroup_apply_control_disable(struct cgroup
>> *cg
>>                          if (!css)
>>                                  continue;
>>
>> +                       if (css->flags & CSS_DYING)
>> +                               continue;
>> +
> So, I don't think this would be correct. It is assumed that there are no
> dying csses when control reaches this point. The right fix is making sure
> that remount path clears up dying csses before calling into this path.

Thanks for the suggestion. I will look into that.

Cheers,
Longman

