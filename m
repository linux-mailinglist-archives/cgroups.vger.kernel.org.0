Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CE52F9B4
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 09:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiEUH2x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 03:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiEUH2w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 03:28:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302A479399
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 00:28:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t25so17704109lfg.7
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7V73RXe3dU41vM2yXc5RdFK0d/D3JpjuPldiMy6fTKw=;
        b=Esn+ulXtp2NG4hm6JqTfL5/p0EfkrSuWUCOO9w7zITqkI+Wwl0e6DtqieOfHEaVUKT
         CB1xY2oebbxCY3E8LwiqBz+y2Zf2z9agssq/85w0pSqE/4dqYAPZBtarkvx2muFGrykT
         EZ2UKFoJT8TmJ5oJv7ZyDvNWs08PxumdZ4lgVtdlpMVYHdQqHDUZ0N02osjAQ0fSHNjw
         Vy049oSifghAwEI6PVkb5XQ8uUEeCz3gQ2UzxnUvmlvpcmm+yyr53Y8OHR04t0s8wPnF
         e7PcC3M+g8ioR3SvtmreqXQJ3ku+cu9rH1uB4Meyz3/UKxJ5w+ehGz4L4RnJmh6r52bp
         aosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7V73RXe3dU41vM2yXc5RdFK0d/D3JpjuPldiMy6fTKw=;
        b=2wUoLuFGBdGaAqzqvPkRO/7iPMmZ+gS6ZHsSFATF7Skun86DwnygIEOFVNJxOxySc4
         sGy/Cd2vtdkbKyqPR1jKFXkNshkdHFhUL1+8iX2uAuVeVwEnbG8qNcJOowDjSB8RuzK4
         uLRcYL76/qvWqReGbsLeLNMuxgKgZrmyF8ph2PvMsQzqzuefDrjQeanJ74dEViWaw1UI
         FsGZ317sYLmdj1FwJd84+np2mFY+vX9cG/PrvNOWEPXuoLnNckrMxGLQHRfVb8ziyZYk
         0Atlx4XO0PZ12+Bo/CmU93s8KeA4pZyO5PIUwaspGO64lwH/dx5crTqJ2Ofq1c2MuU/W
         337w==
X-Gm-Message-State: AOAM531gJveuOP+69VwZ25n4L3TEZPOExPSdxT6PJwTcKspBb5MdyCBB
        5d7Dty5ZfdmVK8Rv2yIBL75esg==
X-Google-Smtp-Source: ABdhPJy8dJsO28tYQXR1SlsZ1sX3R6DcdHNk1mOeJjQZ21k3u6ki9d4E/+FSVYEDZ7GwfjP8JwT2ug==
X-Received: by 2002:a05:6512:31ce:b0:473:be54:ba76 with SMTP id j14-20020a05651231ce00b00473be54ba76mr9467947lfe.627.1653118129567;
        Sat, 21 May 2022 00:28:49 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id d13-20020ac24c8d000000b00477a61abff4sm953722lfl.63.2022.05.21.00.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 00:28:49 -0700 (PDT)
Message-ID: <c8835a1c-2266-0131-7fd6-e6449750353b@openvz.org>
Date:   Sat, 21 May 2022 10:28:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/4] memcg: enable accounting for struct cgroup
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Ynv7+VG+T2y9rpdk@carbon>
 <a17be77f-dc3b-d69a-16e2-f7309959c525@openvz.org>
 <20220519165325.GA2434@blackbody.suse.cz>
 <740dfcb1-5c5f-6a40-0f71-65f277f976d6@openvz.org>
 <d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org> <Yog4jCygrYPtPXg5@carbon>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <Yog4jCygrYPtPXg5@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/21/22 03:55, Roman Gushchin wrote:
> On Fri, May 20, 2022 at 11:16:32PM +0300, Vasily Averin wrote:

>> common part:
>> 16  ~   352     5632    5632    KERNFS (*)
>> 1   +   4096    4096    9728    (cgroup_mkdir+0xe4)
>> 1       584     584     10312   (radix_tree_node_alloc.constprop.0+0x89)
>> 1       192     192     10504   (__d_alloc+0x29)
>> 2       72      144     10648   (avc_alloc_node+0x27)
>> 2       64      128     10776   (percpu_ref_init+0x6a)
>> 1       64      64      10840   (memcg_list_lru_alloc+0x21a)
>>
>> 1   +   192     192     192     call_site=psi_cgroup_alloc+0x1e
>> 1   +   96      96      288     call_site=cgroup_rstat_init+0x5f
>> 2       12      24      312     call_site=percpu_ref_init+0x23
>> 1       6       6       318     call_site=__percpu_counter_init+0x22
> 
> I'm curios, how do you generate these data?

trace_cmd + awk + /dev/hand

> Just an idea: it could be a nice tool, placed somewhere in tools/cgroup/...

I'm agree, nice idea. I'll try to implement it.
