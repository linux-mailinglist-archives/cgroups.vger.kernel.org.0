Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD773D7F3F
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 22:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhG0U0i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 16:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232346AbhG0U0h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 16:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627417595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14yyXo490T12NnJQD+zcubFFrNkcCdNPIIlyx7xSn8U=;
        b=FCeyBepd1lOeuzAS3lfmeLiw6vUCHYpymxLQIJRGKoGdZRC+P/wdFTMWyQFSQLZL4QuBos
        bIxtlX+CsfaKDdDWm0qalDSV2VEb8h6ojYEdwmmx0gzRRIX4W0N1FtB9pktukfZt1LKzbL
        beCL4sCBxo7yF+6jLgG1MV26bS6MFPg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-n0PRyIoVNV6xuQKcSWDDBA-1; Tue, 27 Jul 2021 16:26:34 -0400
X-MC-Unique: n0PRyIoVNV6xuQKcSWDDBA-1
Received: by mail-qv1-f70.google.com with SMTP id v16-20020a0562140510b029032511e85975so357377qvw.23
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 13:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=14yyXo490T12NnJQD+zcubFFrNkcCdNPIIlyx7xSn8U=;
        b=cm/ZXiUEIw2NM/M0aJwV2TVZ13PBg0p3juDBukrIEaBxCx7jMic3ZdXphdU5Ulk2b1
         B2Tp57J1ldK6omyH302TM4h66yQkGn0XweHRyHK2dWc0f3kpZNXTH9L16kz2XwBCvHc5
         o+RaYooD7ABBrLK/HshnO7/uwR6s0L8FC9D8RIRgZECQXY5ZaNGlXe//RHWsKLvWIGta
         PT67xXjacRZ9A2tiJ26TkMW98yv6Fl6yJd1A2mwlhfTBz5LVrsCiezkxLLFx8MMzGB0v
         I6G+Uafu2lIsZmQ62NNxbp75t98/VcMd6OcxAmDh3cHbxh5DEm/e5wDl4hVTOTMH3Skq
         DlMg==
X-Gm-Message-State: AOAM530r46WZEUvfsc/YVtx5BWTmFxNtPFcklTrMkuOBqxchcFp24fuT
        vcsfiTbuQ3onhkrWeblhv/wrwAbqLYq52g38jGbsxbRjIts0zVvRiJP+EWEU25KEPesMJML6AAq
        BZ4zPZdtf7o1nKI3IjQ==
X-Received: by 2002:a05:620a:22ad:: with SMTP id p13mr11842340qkh.378.1627417593660;
        Tue, 27 Jul 2021 13:26:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz0X7Wdw9Hoe/zftts1a4c+yW5GwWyHLqUOZDdF2Y/H8a1gqvebbvx75yzB1cm4Lc+fjTLBg==
X-Received: by 2002:a05:620a:22ad:: with SMTP id p13mr11842310qkh.378.1627417593498;
        Tue, 27 Jul 2021 13:26:33 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b132sm2226831qkg.122.2021.07.27.13.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 13:26:32 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 4/9] cgroup/cpuset: Enable event notification when
 partition become invalid
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20210720141834.10624-1-longman@redhat.com>
 <20210720141834.10624-5-longman@redhat.com>
 <YP9BxKXfhaoTE+LO@slm.duckdns.org>
Message-ID: <8bed1ac2-f5f4-6d17-d539-4cd274b0f39e@redhat.com>
Date:   Tue, 27 Jul 2021 16:26:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP9BxKXfhaoTE+LO@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/26/21 7:14 PM, Tejun Heo wrote:
> On Tue, Jul 20, 2021 at 10:18:29AM -0400, Waiman Long wrote:
>> +static inline void notify_partition_change(struct cpuset *cs,
>> +					   int old_prs, int new_prs)
>> +{
>> +	if ((old_prs == new_prs) ||
>> +	   ((old_prs != PRS_ERROR) && (new_prs != PRS_ERROR)))
>> +		return;
>> +	cgroup_file_notify(&cs->partition_file);
> I'd generate an event on any state changes. The user have to read the file
> to find out what happened anyway.
>
> Thanks.

 From my own testing with "inotify_add_watch(fd, file, IN_MODIFY)", 
poll() will return with a event whenever a user write to 
cpuset.cpus.partition control file. I haven't really look into the sysfs 
code yet, but I believe event generation will be automatic in this case. 
So I don't think I need to explicitly add a cgroup_file_notify() when 
users modify the control file directly. Other indirect modification may 
cause the partition value to change to/from PRS_ERROR and I should have 
captured all those changes in this patchset. I will update the patch to 
note this point to make it more clear.

Cheers,
Longman


