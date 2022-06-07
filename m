Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E44F53FF01
	for <lists+cgroups@lfdr.de>; Tue,  7 Jun 2022 14:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbiFGMjC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jun 2022 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244029AbiFGMi2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jun 2022 08:38:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71291FF5A3
        for <cgroups@vger.kernel.org>; Tue,  7 Jun 2022 05:37:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u23so28132827lfc.1
        for <cgroups@vger.kernel.org>; Tue, 07 Jun 2022 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7VWPEvvINNs28ioVlXIeYh81foNtBWzaOhBPLFOuk84=;
        b=XrDpP52+3EO0X6LweAf3F2Fn+6FcjsCkhpPi7cjUn8ibrMfSb3D2UbsdA6Orz2hz6W
         //fYF1I8NLKAdicy7sFdjyHXNKIREf3piAeuQEU3Z2Kf+IN/ONt/N0N7mgpRrygVEzRB
         +uUhMhRCs+Z5gNM2IRxJ24vhTiSjTVXTaghQVEWUPss4PLhOCP/yNOmaDmX7orALggYF
         xKeGKvLDPSJX6bLRhtSS63GFgPcMZcTyA0lY+Po8NSF7k54K5O3TbvZxudLTQPWbRZ81
         hffyMNvw50jHBWi7EJiXxKJbXdYVuHNEv+gXDpQiL6y/EmPXZw1ODm24jBWpW1vh1e2G
         ocIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7VWPEvvINNs28ioVlXIeYh81foNtBWzaOhBPLFOuk84=;
        b=pLf7oshXuQKIuaSzlRfcKNF5tiSHA+c31WNFhempn1gMf0nU2X8XIHhPmyFzX8k+iv
         HgCLG4bRylhE+R4s7+2JxVMcE27gZ2cKVte84OSCpYsZu4l0uwVWns/ghPKfhp6Giy0W
         +5suDeiKljMJOqCdoy+F7waor51SiLMkepX/eWgmYMvYGMJDqUBC8quX1LQDjSq6IuqE
         478YDz+eV//yn0gPlR/6i+/d5/UPTh7IAcLSJcZAv4FB5FKaOv20iRxR93LhyKSImmx/
         FenmcWDdkEKDAJ+ZCExsZCcxwyuudCEGTvvdfWMqwkZyCHmPuu30bAfTz4OPuJXq8LDE
         OADQ==
X-Gm-Message-State: AOAM532KYLXEIFKCFjGMLN1R8LaOxNnN/Mtkm8MswYm4aQ3bXhKXMMWo
        Mq/4CUTUBCIaolj7xjZiYtTzRw==
X-Google-Smtp-Source: ABdhPJzV9Qt/IJjZLnDs9mVZaiwTHIWH8UWlNQ4D39gnJl4yH8fvtKfqfo+tQeFCBSnZIFydBQ7JhA==
X-Received: by 2002:ac2:5d22:0:b0:478:9e46:ae85 with SMTP id i2-20020ac25d22000000b004789e46ae85mr18388836lfb.126.1654605473561;
        Tue, 07 Jun 2022 05:37:53 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id q23-20020a05651232b700b00478ffd14ac1sm3259016lfe.163.2022.06.07.05.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:37:53 -0700 (PDT)
Message-ID: <183333fc-e824-5c85-7c44-270474f5473a@openvz.org>
Date:   Tue, 7 Jun 2022 15:37:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH memcg v6] net: set proper memcg for net_init hooks
 allocations
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Cgroups <cgroups@vger.kernel.org>
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org> <Yp4F6n2Ie32re7Ed@qian>
 <360a2672-65a7-4ad4-c8b8-cc4c1f0c02cd@openvz.org>
 <CALvZod7+tpgKSQpMAgNKDtcsimcSjoh4rbKmUsy3G=QcRHci+Q@mail.gmail.com>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <CALvZod7+tpgKSQpMAgNKDtcsimcSjoh4rbKmUsy3G=QcRHci+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/7/22 08:58, Shakeel Butt wrote:
> On Mon, Jun 6, 2022 at 11:45 AM Vasily Averin <vvs@openvz.org> wrote:
>>
> [...]
>>
>> As far as I understand this report means that 'init_net' have incorrect
>> virtual address on arm64.
> 
> So, the two call stacks tell the addresses belong to the kernel
> modules (nfnetlink and nf_tables) whose underlying memory is allocated
> through vmalloc and virt_to_page() does not work on vmalloc()
> addresses.

However in both these cases get_mem_cgroup_from_obj() -> mem_cgroup_from_obj() ->
virt_to_folio() -> virt_to_page() -> virt_to_pfn() -> __virt_to_phys() 
handles address of struct net taken from for_each_net().
The only net namespace that exists at this stage is init_net,
and dmesg output confirms this:
"virt_to_phys used for non-linear address: ffffd8efe2d2fe00 (init_net)"

>> Roman, Shakeel, I need your help
>>
>> Should we perhaps verify kaddr via virt_addr_valid() before using virt_to_page()
>> If so, where it should be checked?
> 
> I think virt_addr_valid() check in mem_cgroup_from_obj() should work
> but I think it is expensive on the arm64 platform. The cheaper and a
> bit hacky way to avoid such addresses is to directly use
> is_vmalloc_addr() directly.

I do not understand why you mean that processed address is vmalloc-specific.
As far as I understand it is valid address of static variable, and for some reason
arm64 does not consider them valid virtual addresses.

Thank you,
	Vasily Averin
