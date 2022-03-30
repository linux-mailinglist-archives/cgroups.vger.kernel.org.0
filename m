Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE84EC664
	for <lists+cgroups@lfdr.de>; Wed, 30 Mar 2022 16:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbiC3OXx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 10:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiC3OXx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 10:23:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B903CD329
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 07:22:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lr4so33421465ejb.11
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4iTANxmONAKu4RDVv0y+koCJEtwISqaQFOKub5KCpYY=;
        b=ARDCeatE6ITj6RrVssEpi4soZXUTx10fHOsOPABcN7zK7iIsBrhSpbv2Mi3z4nezHM
         XGnjs2pQBWfUgxWDY1Byh5zkoIucQsUZ2Pim338F7IkFcpYpQY5cdrYy8oKnm1UGsXIl
         /R1JQXydQ6N4QMnX2+PLyOntQjkcwYNpfO/f43dmHUEAMTWp9tZzD4zmrRwFqJXFnDOa
         6mnpTxbxUh0DQN6mH1jNcIgCf67RAsDnR4Mbb99c8M/CSvWszvQ5GThgYys4Gh5ndMcd
         +4B4cLdEnUnPJtoxiYwi3yr28PPlraTvMkSygErs72lyr2tVIz+zI4tjPc1K4anGFQp8
         xeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4iTANxmONAKu4RDVv0y+koCJEtwISqaQFOKub5KCpYY=;
        b=xO2jxYGtKT549iW43DgeAu3iydCV9hxFHFFJsy9vmdnHgTL/G9R+8LfhASykYlh8+R
         Yj4Dy5YjOxxZNRzbVCJI7/wV2tpqfUNAISaEnthhOF6qGEj17oemcTFQDso2UMvpTw9n
         CLabx0xL4VZR3h5KWTTEGZpUcZdJwUGB/Ew13APvCyB7mmR2DcSSK7Hk7Ovj9yYL6+Z9
         yM/08g70RhF2nWrL32RabwH0t8O+8HzsHuosWz15lqFDlPzAPJOarSba/IxsHzUhm2WX
         NmcsmSwLncMJY0u+SfOiKTX14ZMiwqY1rpZGEssHrQgrfEHxdEFYKOV9X7vHg5kMhOR7
         q3tw==
X-Gm-Message-State: AOAM533il16FkznDZGln6ceJHDW/soPh2tA/rAoEi1O3i9QtLIlYP81i
        t35kDMGhoZR2mkjtQoa3vGA=
X-Google-Smtp-Source: ABdhPJzXVCXPTVNzet0Qhi1syNJDEUtoTmJGonpuAY0FK5Rzlw97jdcABj6E3ChkjPw2pSWrLdjJhQ==
X-Received: by 2002:a17:907:7f9e:b0:6e0:d34b:7d98 with SMTP id qk30-20020a1709077f9e00b006e0d34b7d98mr25886639ejc.574.1648650126648;
        Wed, 30 Mar 2022 07:22:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id bm23-20020a170906c05700b006d597fd51c6sm8422830ejb.145.2022.03.30.07.22.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 07:22:06 -0700 (PDT)
Date:   Wed, 30 Mar 2022 14:22:05 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, mhocko@kernel.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/memcg: set pos to prev unconditionally
Message-ID: <20220330142205.iaw6apqxkngp3bdz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220225003437.12620-1-richard.weiyang@gmail.com>
 <20220225003437.12620-3-richard.weiyang@gmail.com>
 <YkNUZYrSHPjJ1XOb@cmpxchg.org>
 <20220330004750.fx4jr4bnehz4ynpf@master>
 <YkRIUbEGHVIbVRNO@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRIUbEGHVIbVRNO@cmpxchg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 30, 2022 at 08:08:49AM -0400, Johannes Weiner wrote:
>On Wed, Mar 30, 2022 at 12:47:50AM +0000, Wei Yang wrote:
>> Something like this?
>> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index eed9916cdce5..5d433b79ba47 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1005,9 +1005,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>>  	if (!root)
>>  		root = root_mem_cgroup;
>>  
>> -	if (prev && !reclaim)
>> -		pos = prev;
>> -
>>  	rcu_read_lock();
>>  
>>  	if (reclaim) {
>> @@ -1033,6 +1030,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>>  			 */
>>  			(void)cmpxchg(&iter->position, pos, NULL);
>>  		}
>> +	} else if (prev) {
>> +		pos = prev;
>>  	}
>>  
>>  	if (pos)
>
>Yep!

Sure, I would prepare a v2.

BTW, do you have some comment on patch 3?

-- 
Wei Yang
Help you, Help me
