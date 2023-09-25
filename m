Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A377AD807
	for <lists+cgroups@lfdr.de>; Mon, 25 Sep 2023 14:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjIYM2O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 08:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjIYM2N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 08:28:13 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD19BFB
        for <cgroups@vger.kernel.org>; Mon, 25 Sep 2023 05:28:06 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-69101d33315so4747494b3a.3
        for <cgroups@vger.kernel.org>; Mon, 25 Sep 2023 05:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695644886; x=1696249686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa2JeZg/HCJGKJydYD0Nz2S/LzX+OYJQg4QuWBQON58=;
        b=MEpYnwf4Pl4Bj2krIsn3N9AxU4VlcmWsDxlkCuMHr3FXZp2tH1X7uRnBSr8sjWpmyQ
         W2mne8Jc54vRy069rzYM6CITgEU6T7tbQPJf03dujzOgofp8mrB+m/WhBZNds4gT0CBj
         dW/9g6fgjLZISmaH9AIZGyBviouTMP7a9ZThfOa3HzxmWy86u0bbo0ZOG4PBmM/O/D6y
         pCti5/CHQseAHHij6nO8vA72pnj6nFhIw5CECRx5QrRQewWvKDEdMvoNdlbZTI/Vp7ht
         yKfWuFTsE87GGQ+ckvLIWShTchnLcAUluQwD0fxrJWOMmYEQ1bdFmp4Fuyt2yrd4qVIE
         LLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695644886; x=1696249686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sa2JeZg/HCJGKJydYD0Nz2S/LzX+OYJQg4QuWBQON58=;
        b=LKysOzaZXmHwzFYrVAjr9hG341vjepiKfu7qHTrHKbdMhOjN9aNlpJY6CGfDRsGAnd
         oQe0GlhXkbi/1qmOEyrLa4MFpnYw+dSnjsSBL3N7i1wLIJwLl4nLjThJUickR3MDgbNA
         unOulgkCxuGgYk7fMHbrwvEs5vSd0Iov6KD6sm3yI0REjyMMLMeXdMG5fY3ffph1t4A3
         2v0/TCY9BhTrOSqSosjQKi0/86l4jn5h2m8Qx6k3CCY1Y9n83zAhD7wKtEoOtsAuohXd
         N7hg4iv1rIelrXiiRvyPVwjsbrVPi3Ly/SAfEN02HzGkgORFtY8h3TMaj7DXHFrwEAGh
         7F1w==
X-Gm-Message-State: AOJu0Yy7zpnsU5/560ctg0vG/X2iMEjn4WLXHIahfDogMpKN3IPfv1kv
        Zx2jy6Gws6YOBsDhX4yXs/0lF1tjEwTHp7E1biKBYM+g
X-Google-Smtp-Source: AGHT+IGQl+/qNdx05UHGvgtq0pWDgEQ0LdwTrhKAZvm/SX5mzX7tagHv2WiAw5GmtI6bxnrgnlUC+Q==
X-Received: by 2002:a05:6a20:6aaf:b0:157:eb32:e775 with SMTP id bi47-20020a056a206aaf00b00157eb32e775mr3448966pzb.62.1695644886337;
        Mon, 25 Sep 2023 05:28:06 -0700 (PDT)
Received: from [10.54.24.10] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id fn1-20020a056a002fc100b00692e9bf82fcsm1897323pfb.182.2023.09.25.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 05:28:05 -0700 (PDT)
Message-ID: <94b7ed1d-9ca8-7d34-a0f4-c46bc995a3d2@shopee.com>
Date:   Mon, 25 Sep 2023 20:28:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] memcg, oom: unmark under_oom after the oom killer is
 done
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20230922070529.362202-1-haifeng.xu@shopee.com>
 <ZRE9fAf1dId2U4cu@dhcp22.suse.cz>
 <6b7af68c-2cfb-b789-4239-204be7c8ad7e@shopee.com>
 <ZRFxLuJp1xqvp4EH@dhcp22.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZRFxLuJp1xqvp4EH@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/9/25 19:38, Michal Hocko wrote:
> On Mon 25-09-23 17:03:05, Haifeng Xu wrote:
>>
>>
>> On 2023/9/25 15:57, Michal Hocko wrote:
>>> On Fri 22-09-23 07:05:28, Haifeng Xu wrote:
>>>> When application in userland receives oom notification from kernel
>>>> and reads the oom_control file, it's confusing that under_oom is 0
>>>> though the omm killer hasn't finished. The reason is that under_oom
>>>> is cleared before invoking mem_cgroup_out_of_memory(), so move the
>>>> action that unmark under_oom after completing oom handling. Therefore,
>>>> the value of under_oom won't mislead users.
>>>
>>> I do not really remember why are we doing it this way but trying to track
>>> this down shows that we have been doing that since fb2a6fc56be6 ("mm:
>>> memcg: rework and document OOM waiting and wakeup"). So this is an
>>> established behavior for 10 years now. Do we really need to change it
>>> now? The interface is legacy and hopefully no new workloads are
>>> emerging.
>>>
>>> I agree that the placement is surprising but I would rather not change
>>> that unless there is a very good reason for that. Do you have any actual
>>> workload which depends on the ordering? And if yes, how do you deal with
>>> timing when the consumer of the notification just gets woken up after
>>> mem_cgroup_out_of_memory completes?
>>
>> yes, when the oom event is triggered, we check the under_oom every 10 seconds. If it
>> is cleared, then we create a new process with less memory allocation to avoid oom again.
> 
> OK, I do understand what you mean and I could have made myself
> more clear previously. Even if the state is cleared _after_
> mem_cgroup_out_of_memory then you won't get what you need I am
> afraid. The memcg stays under OOM until a memory is freed (uncharged)
> from that memcg. mem_cgroup_out_of_memory itself doesn't really free
> any memory on its own. It relies on the task to wake up and die or
> oom_reaper to do the work on its behalf. All of that is time dependent.
> under_oom would have to be reimplemented to be cleared when a memory is
> unchanrged to meet your demands. Something that has never really been
> the semantic.
> 

yes, but at least before we create the new process, it has more chance to get some memory freed.

> Btw. is this something new that you are developing on top of v1? And if
> yes, why don't you use v2?
> 

yes, v2 doesn't have the "cgroup.event_control" file.
