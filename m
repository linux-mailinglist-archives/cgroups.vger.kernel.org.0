Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6A753785C
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiE3Jii (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 05:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiE3Jii (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 05:38:38 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCE75231
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 02:38:35 -0700 (PDT)
Message-ID: <ca0ba233-ed09-5dce-5f38-2e05b1114610@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653903513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tAu1yDybljG9v6H3XFTvFlglCilUlg/TAc4Sssj5FY=;
        b=nb/TIC8Z25okb0Miptwsm4FaawVL2rNW/B9T1O0x0tFfmsH0CSEdbsxRXUnG4LxdbB3pyf
        SNmmhDVwMyuNGJIHhLB1libYq6Iwt1Oh8nSnW35aQjnDPVOFrt2pJJXWwXJOqFinxElI7Q
        G/JjfHmMV0OVdoZhyoIdK9HzHvergAo=
Date:   Mon, 30 May 2022 12:38:28 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] memcg: enable accounting in keyctl subsys
Content-Language: en-US
Cc:     Yutian Yang <nglaive@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, shenwenbo@zju.edu.cn,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        Jarkko Sakkinen <jarkko@kernel.org>
References: <1626682667-10771-1-git-send-email-nglaive@gmail.com>
 <0017e4c6-84d8-6d62-2ceb-4851771fec18@linux.dev>
 <YovnzLqXqEHY6SAC@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <YovnzLqXqEHY6SAC@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear Andrew,
could you please pick up this patch too?

Thank you,
	Vasily Averin

On 5/23/22 23:00, Jarkko Sakkinen wrote:
> On Mon, May 23, 2022 at 12:45:09PM +0300, Vasily Averin wrote:
>> On 7/19/21 11:17, Yutian Yang wrote:
>>> This patch enables accounting for key objects and auth record objects.
>>> Allocation of the objects are triggerable by syscalls from userspace.
>>>
>>> We have written a PoC to show that the missing-charging objects lead to
>>> breaking memcg limits. The PoC program takes around 2.2GB unaccounted
>>> memory, while it is charged for only 24MB memory usage. We evaluate the
>>> PoC on QEMU x86_64 v5.2.90 + Linux kernel v5.10.19 + Debian buster. All
>>> the limitations including ulimits and sysctl variables are set as default.
>>> Specifically, we set kernel.keys.maxbytes = 20000 and 
>>> kernel.keys.maxkeys = 200.
>>>
>>> /*------------------------- POC code ----------------------------*/
>> [skipped]
>>> /*-------------------------- end --------------------------------*/
>>
>> I experimented with "keyctl request2 user debug: X:Y Z" inside the container
>> and found that the problem is still relevant and the proposed patch solves it
>> correctly.
>>
>> I didn't find any complaints about this patch, could someone explain why
>> it wasn't applied? If no one objects, I'd like to push it.
>>
>>> Signed-off-by: Yutian Yang <nglaive@gmail.com>
>> Reviewed-by: Vasily Averin <vvs@openvz.org>
>>
>> Thank you,
>> 	Vasily Averin
>>
>> PS. Should I perhaps resend it?
>>
>>> ---
>>>  security/keys/key.c              | 4 ++--
>>>  security/keys/request_key_auth.c | 4 ++--
>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/security/keys/key.c b/security/keys/key.c
>>> index e282c6179..925d85c2e 100644
>>> --- a/security/keys/key.c
>>> +++ b/security/keys/key.c
>>> @@ -279,7 +279,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
>>>  		goto no_memory_2;
>>>  
>>>  	key->index_key.desc_len = desclen;
>>> -	key->index_key.description = kmemdup(desc, desclen + 1, GFP_KERNEL);
>>> +	key->index_key.description = kmemdup(desc, desclen + 1, GFP_KERNEL_ACCOUNT);
>>>  	if (!key->index_key.description)
>>>  		goto no_memory_3;
>>>  	key->index_key.type = type;
>>> @@ -1198,7 +1198,7 @@ void __init key_init(void)
>>>  {
>>>  	/* allocate a slab in which we can store keys */
>>>  	key_jar = kmem_cache_create("key_jar", sizeof(struct key),
>>> -			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
>>> +			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
>>>  
>>>  	/* add the special key types */
>>>  	list_add_tail(&key_type_keyring.link, &key_types_list);
>>> diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
>>> index 41e973500..ed50a100a 100644
>>> --- a/security/keys/request_key_auth.c
>>> +++ b/security/keys/request_key_auth.c
>>> @@ -171,10 +171,10 @@ struct key *request_key_auth_new(struct key *target, const char *op,
>>>  	kenter("%d,", target->serial);
>>>  
>>>  	/* allocate a auth record */
>>> -	rka = kzalloc(sizeof(*rka), GFP_KERNEL);
>>> +	rka = kzalloc(sizeof(*rka), GFP_KERNEL_ACCOUNT);
>>>  	if (!rka)
>>>  		goto error;
>>> -	rka->callout_info = kmemdup(callout_info, callout_len, GFP_KERNEL);
>>> +	rka->callout_info = kmemdup(callout_info, callout_len, GFP_KERNEL_ACCOUNT);
>>>  	if (!rka->callout_info)
>>>  		goto error_free_rka;
>>>  	rka->callout_len = callout_len;
>>
> 
> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko

