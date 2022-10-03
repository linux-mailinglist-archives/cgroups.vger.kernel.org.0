Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0775F323D
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJCPBn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJCPBl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 11:01:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F4933367
        for <cgroups@vger.kernel.org>; Mon,  3 Oct 2022 08:01:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k10so16992533lfm.4
        for <cgroups@vger.kernel.org>; Mon, 03 Oct 2022 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=9rAQZSDFLx6oyudqXJUAKh8EPFf5CZriEW2Q/puz7cw=;
        b=R8sv2LFCszyDp3XyJnq6sBvDNnGkSMQYnrP0Lc3g+w4Yp8MnStv2rONOs0pMHKHcfd
         b1HwUh/xsuxD6nwHgRLiKUWcF23LKLGO3t3trUjyZC1CnwmHORgYdieP+o8PO5wklJjZ
         gvvs6uXlyJ2PsOJYOa/Xi3YiaNhGR2lFYaOqLZ6MZ1/sHkr/mKvS76+s1GvLAKF6leys
         CryJL6jxaaUc1b8uatBJ/TDxAMK7CvHL5sBQYWQWhzPYNOEcuOeosg+tj3FWXixEaYbK
         6feHOwigK9z4PuRHCKdXAFlm5jhOu7kw/YrGgQumu4diYCXnfDawjwmf7Yv730voEpEL
         znWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=9rAQZSDFLx6oyudqXJUAKh8EPFf5CZriEW2Q/puz7cw=;
        b=0IIEzkbw1CjvISUsrwgUSiipGGxs/VbIEH5cu47BXTWmKLh/m350vrD9fz82Wy7yda
         z0t4iXQElH6AtjQhf1LAh4x9xYEX1+9z0xKsURuk5vV03cC6UleF2Arixvi3lQ7Kre//
         mfjySAYD5w0REENrMqiy/7sLCCwVFf5UxJooNGOTpGPB2bruXr6vrfC9/tw9HIISk0Fy
         DtXHo2R1gtGCRAL2TLTofyATtXbG2jaK8cccTiJbuYLSQnryyCBRxWMNwq2tNy+Oyc85
         qVjCxCLP/Zw7gGNtAQ4PNfQ5+f4knBg/HFrp4XX2ra6DSKB7YQ4EGSZo9jLUugAN7HmJ
         Qd4A==
X-Gm-Message-State: ACrzQf1mFkcNHUoFNR/IVvuwlFHzX5iEey9wfa4cjo29g/ebvCAGRt9J
        onC9CxK6Sm89TKTJuGPNVBQ=
X-Google-Smtp-Source: AMsMyM7sHpygU+KbInUJWX2tRggNVSc8JmSzUbVltsBYyqZ+reOPbJxrmcMdzi49gQ2Qb8oMaPYUNA==
X-Received: by 2002:a19:f713:0:b0:4a2:2eda:dbc7 with SMTP id z19-20020a19f713000000b004a22edadbc7mr2913849lfe.511.1664809298701;
        Mon, 03 Oct 2022 08:01:38 -0700 (PDT)
Received: from ?IPV6:2a02:2168:a11:244b::1? ([2a02:2168:a11:244b::1])
        by smtp.gmail.com with ESMTPSA id x7-20020a2e9c87000000b0026dcfe9c7dasm509453lji.14.2022.10.03.08.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 08:01:38 -0700 (PDT)
Message-ID: <2f9bdffd-062e-a364-90c4-da7f09c95619@gmail.com>
Date:   Mon, 3 Oct 2022 18:01:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Possible race in obj_stock_flush_required() vs drain_obj_stock()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <1664546131660.1777662787.1655319815@gmail.com>
 <Yzc0yZwDB8GG+4t7@P9FQF9L96D.corp.robot.car>
 <b91e75f4-b09c-85aa-c6ad-2364dab9af92@gmail.com>
 <Yzm5cukBe6IfyAs7@P9FQF9L96D.lan>
 <d3cf9c69-19a1-53f9-cf97-5d40ce5cda44@gmail.com>
 <YzrkaKZKYqx+c325@dhcp22.suse.cz>
 <821923d8-17c3-f1c2-4d6a-5653c88db3e8@gmail.com>
 <YzrxNGpf7sSwSWy2@dhcp22.suse.cz>
From:   Alexander Fedorov <halcien@gmail.com>
In-Reply-To: <YzrxNGpf7sSwSWy2@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03.10.2022 17:27, Michal Hocko wrote:
> On Mon 03-10-22 17:09:15, Alexander Fedorov wrote:
>> On 03.10.2022 16:32, Michal Hocko wrote:
>>> On Mon 03-10-22 15:47:10, Alexander Fedorov wrote:
>>>> @@ -3197,17 +3197,30 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>>>>  		stock->nr_bytes = 0;
>>>>  	}
>>>>  
>>>> -	obj_cgroup_put(old);
>>>> +	/*
>>>> +	 * Clear pointer before freeing memory so that
>>>> +	 * drain_all_stock() -> obj_stock_flush_required()
>>>> +	 * does not see a freed pointer.
>>>> +	 */
>>>>  	stock->cached_objcg = NULL;
>>>> +	obj_cgroup_put(old);
>>>
>>> Do we need barrier() or something else to ensure there is no reordering?
>>> I am not reallyu sure what kind of barriers are implied by the pcp ref
>>> counting.
>>
>> obj_cgroup_put() -> kfree_rcu() -> synchronize_rcu() should take care
>> of this:
> 
> This is a very subtle guarantee. Also it would only apply if this is the
> last reference, right?

Hmm, yes, for the last reference only, also not sure about pcp ref
counter ordering rules for previous references.

> Is there any reason to not use
> 	WRITE_ONCE(stock->cached_objcg, NULL);
> 	obj_cgroup_put(old);
> 
> IIRC this should prevent any reordering. 

Now that I think about it we actually must use WRITE_ONCE everywhere
when writing cached_objcg because otherwise compiler might split the
pointer-sized store into several smaller-sized ones (store tearing),
and obj_stock_flush_required() would read garbage instead of pointer.

And thinking about memory barriers, maybe we need them too alongside
WRITE_ONCE when setting pointer to non-null value?  Otherwise
drain_all_stock() -> obj_stock_flush_required() might read old data.
Since that's exactly what rcu_assign_pointer() does, it seems
that we are going back to using rcu_*() primitives everywhere?
