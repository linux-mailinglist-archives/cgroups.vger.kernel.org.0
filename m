Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4CD5B039A
	for <lists+cgroups@lfdr.de>; Wed,  7 Sep 2022 14:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiIGMGm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 08:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIGMGl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 08:06:41 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D28F895C0
        for <cgroups@vger.kernel.org>; Wed,  7 Sep 2022 05:06:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v4so13340973pgi.10
        for <cgroups@vger.kernel.org>; Wed, 07 Sep 2022 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=0OMCYXdwR40VgBJEbCb1Ib7nAC/48wQOIhHqsm4Pyls=;
        b=HO4kjKdkDS/f97yEF+pCNPTD9Qua8BJsV2g6HRDvYYsaGXiL8d/7kvtOrUIj5FpP3u
         Do171ILfzUr9ll+GMVbtMMkKuLFktC0LuKZYHCj8Aj4GRzOmL0kbSz+a68UvVjzMcfj0
         kA6/ZHwpyBfxdjfjVvSOzG5SRoSZp9doRxmZrHtV9n6DsoCTRobj2aQgvGKLTd4t60L5
         6xaJKWiPrdjfPfveb0kURb/8K3B6ViCYRGZl8yCKYPZ354MstcHpOPR7RalIFLu5a9IO
         JqF8kEkTl/jJgocmBPv7hxEajpLVtL4HScdT5HN4ZgdHcuCinfyXB8Z7P5yPSwLct9bF
         MDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=0OMCYXdwR40VgBJEbCb1Ib7nAC/48wQOIhHqsm4Pyls=;
        b=EfD2gRo6dEfTpLuLtMrWI1l5WZbcsNS4uzaZrMWee+V1F5n05OVXIif4DEt4Orx5j0
         NaHbbNuEO5TJjlislcCwxxQkkl3FiBS1slvvHkjoe4fwa6DVFPjtYkVP3RJ85wpxKfzv
         mYWXAj/mb67KbFiHZbCZiejoHtyCXD9680plRCkNcZPsPFEoDh2duCES89AlIIrA+Bsv
         QFFArvJtrGYWAreNKOkCtetmBMrPdocTeB4gw2DRPuuiijVM/HC3lK9C4FgYRnyvNcQA
         eTT62Xh0dqw/HPp6ezd6GPgHU7bHj/ZrMvh+JKb72u3M7GdNWTd28k+vgBJiRtiE3dCv
         OUKQ==
X-Gm-Message-State: ACgBeo32t0OTFptaW0T45ff1Bi9Z3RU9stiBTkIThR4S1BIiCnDSwPrY
        zD85p5VEHla4AF9CatyadWEauQ==
X-Google-Smtp-Source: AA6agR4tfDHmSiKzt3i01SAQZYBf7IAftYvaZ9oaAAQ6MJ+FVM062Gti6IBQ5YC8Fh5KKcjl9nRAzw==
X-Received: by 2002:a63:4d66:0:b0:434:8301:53e1 with SMTP id n38-20020a634d66000000b00434830153e1mr3070042pgl.369.1662552399617;
        Wed, 07 Sep 2022 05:06:39 -0700 (PDT)
Received: from [10.255.85.171] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a474100b001fdbb2e38acsm14714571pjg.5.2022.09.07.05.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 05:06:39 -0700 (PDT)
Message-ID: <d323bd95-476b-0901-855e-14c8796d1b23@bytedance.com>
Date:   Wed, 7 Sep 2022 20:06:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [Phishing Risk] Re: [Phishing Risk] [External] Re: [PATCH]
 cgroup/cpuset: Add a new isolated mems.policy type.
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220902063303.1057-1-hezhongkun.hzk@bytedance.com>
 <YxT/liaotbiOod51@slm.duckdns.org>
 <c05bdeac-b354-0ac7-3233-27f8e5cbb38a@bytedance.com>
 <YxeBGeOaQxvlPLzo@slm.duckdns.org>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <YxeBGeOaQxvlPLzo@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> Hello,
> 
> On Mon, Sep 05, 2022 at 06:30:38PM +0800, Zhongkun He wrote:
>> We usually use numactl to set the memory policy, but it cannot be changed
>> dynamically. In addition, the mempolicy of cpuset can provide a more
>> convenient interface for management and control panel.
> 
> But you can write a better tool easily in userspace to do whatever you wanna
> do, right? If you're worried about racing against forks, you can freeze the
> cgroup, iterate all pids applying whatever new policy and then unfreeze. We
> can probably improve the freezer interface so that multiple users don't
> conflict with each other but that shouldn't be too difficult to do and is
> gonna be useful generically.
> 
> I don't see much point in adding something which can be almost trivially
> implemented in userspace as a built-in kernel feature.
> 
>> Sorry,I don't quite understand the meaning of "don't enforce anything
>> resource related". Does it mean mempolicy, such as "prefer:2" must specify
>> node? Or "cpuset.mems.policy" need to specify a default value?
>> (cpuset.mems.policy does not require a default value.)
> 
> In that there's no real resource being distributed hierarchically like cpu
> cycles or memory capacities. All it's doing is changing attributes for a
> group of processes, which can be done from userspace all the same.
> 
> Thanks.
> 
Hi Tejun, thanks for your reply.

It would be better if one process had a way to dynamically modify the
mempolicy of another process. But unfortunately there is no interface or
system call to do that in userspace.

In our use case, we hope to combine memory policy with cgroup for
better use of resources. The current implementation may not be suitable, 
I'll keep trying other approaches.

Thanks again.
