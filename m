Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34F85F31BD
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 16:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJCOJW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJCOJU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 10:09:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F1932AA7
        for <cgroups@vger.kernel.org>; Mon,  3 Oct 2022 07:09:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d18so3713185lfb.0
        for <cgroups@vger.kernel.org>; Mon, 03 Oct 2022 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=OkDSfRBfMfa9dHxVwKJ+wwTsdFDoWYNDFZsgi6+fnhw=;
        b=b44I5aVKf2QZdbcjnF3DCef/sNHnxlRPl59CirotEqe+gPg6iAqRv7GYfqX3AJJDKo
         BnCleimNr9v+1c8ek++HQHptK3w/zGV7ieDXGnG3A0KoTB9p7eXNEMTYhLHrowURQe0X
         4dT/FB2+Dwp4yt0qtzOl4dgxbVxj3EXU5eGnanDSiMJlbSKpKMvn5sizEmsE7kuINxGt
         E/9S4xInFOXsoGOxRZNPImSIY10RERzzV6o4tnvrydS6Bv0vsw5czS6JWonr8KuqnLHs
         j5rKKBotrsFBBp9GTdBJ3WPw2m+lAxC4hA6QwR1aWMTSku8eEf7CWhMhozUaGm71TXX8
         zFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=OkDSfRBfMfa9dHxVwKJ+wwTsdFDoWYNDFZsgi6+fnhw=;
        b=S2ezYgTNS+nfQnCo//5CMgdKQ9w2LzFvc33cCZ8UOW1nBoqSrNjABg/r+qKnQ0W5IM
         6RXnaNVB7aU4YaI3nzhTLlK9XnKcZhPviId6X7EjMyGoqyT4FL9WsbyZqjuaIi9aGh8s
         CZgdxnU6vAsaIot/CK5YYW+EqqUwZ9RYE4IQRlMDog6HESdEvIxXlwwQO15QWrjyaT8C
         BxGDEuZ39+AW01+8MWiNYByWbwVYc1nFPyTQzRAmDU1ZhqHvaGDtHYJsYWuMD+fjhOfj
         ZcAe+rpu4l003TeaCHbDknWTlueAT3jtgVRE9IChGMein2cH7twOIdYRsiVd3XGGHGkJ
         M34Q==
X-Gm-Message-State: ACrzQf3FjvLpZKeFwAZ+1PycEHdb/j3MOlHpuX+UidY/3ePSDx7cPUSm
        hoY0NAzFdcvL/EQMS3lRsfk=
X-Google-Smtp-Source: AMsMyM7lOvJCHYhKtvEGDxnGf+CIiYDbElv58/e74PYavgMpy3ovgyDNOWnZYem+g5hgkh82QnCwXg==
X-Received: by 2002:a05:6512:1056:b0:498:efaf:5bd1 with SMTP id c22-20020a056512105600b00498efaf5bd1mr6990091lfb.64.1664806157470;
        Mon, 03 Oct 2022 07:09:17 -0700 (PDT)
Received: from ?IPV6:2a02:2168:a11:244b::1? ([2a02:2168:a11:244b::1])
        by smtp.gmail.com with ESMTPSA id b1-20020ac247e1000000b00498f51af149sm1458750lfp.308.2022.10.03.07.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 07:09:16 -0700 (PDT)
Message-ID: <821923d8-17c3-f1c2-4d6a-5653c88db3e8@gmail.com>
Date:   Mon, 3 Oct 2022 17:09:15 +0300
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
From:   Alexander Fedorov <halcien@gmail.com>
In-Reply-To: <YzrkaKZKYqx+c325@dhcp22.suse.cz>
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

On 03.10.2022 16:32, Michal Hocko wrote:
> On Mon 03-10-22 15:47:10, Alexander Fedorov wrote:
>> @@ -3197,17 +3197,30 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>>  		stock->nr_bytes = 0;
>>  	}
>>  
>> -	obj_cgroup_put(old);
>> +	/*
>> +	 * Clear pointer before freeing memory so that
>> +	 * drain_all_stock() -> obj_stock_flush_required()
>> +	 * does not see a freed pointer.
>> +	 */
>>  	stock->cached_objcg = NULL;
>> +	obj_cgroup_put(old);
> 
> Do we need barrier() or something else to ensure there is no reordering?
> I am not reallyu sure what kind of barriers are implied by the pcp ref
> counting.

obj_cgroup_put() -> kfree_rcu() -> synchronize_rcu() should take care
of this:

3670  * Furthermore, if CPU A invoked synchronize_rcu(), which returned
3671  * to its caller on CPU B, then both CPU A and CPU B are guaranteed
3672  * to have executed a full memory barrier during the execution of
3673  * synchronize_rcu() -- even if CPU A and CPU B are the same CPU (but
3674  * again only if the system has more than one CPU).
3675  */
3676 void synchronize_rcu(void)

If I'm reading this correctly:
 - on SMP A==B and there will be a full memory barrier;
 - on UP we instead rely on the guarantee that schedule() implies a full
   memory barrier (and if there is no schedule() then there is no race).
