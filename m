Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3EE7C4795
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 03:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbjJKB7c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 21:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbjJKB7b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 21:59:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3D48E
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 18:59:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-69af8a42066so3852412b3a.1
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 18:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1696989570; x=1697594370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIetvc1RCzHeFJQBRUPPPlIX4XH2j0AA3ULxkOAJjLY=;
        b=hrPUu/bTiT0DpSpeqOjMpUyBYiaAQqOClLwfI6L6WC+5tJ6rWJaE1fbGXRsOPsORxE
         ppElwpK5+ySoXGhGsazk71VxarzXhb/Ma6jjYWbR8jZ7giCUwtq8oV04SCqr6kr1UFfm
         3EsgxsgmXYiOCIyH8tDhO/4+IXGA8pryY8+aF8r7Tk1glpc3H/dk8+A4y8fCdTwnS0As
         ALnPEoyT1f74R9GRSg5OA7RmsEdepaM2XH23T5oqKo7IdO0T0SzEdh3EfG3mEzuvo13k
         KXvaW3RPgY3jNiZfhth667j+DTgQDaRI8OKvsg8xichapcCu3kJNJ0eFccdyoIq4Dlr+
         SPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696989570; x=1697594370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LIetvc1RCzHeFJQBRUPPPlIX4XH2j0AA3ULxkOAJjLY=;
        b=wY+MJbbkT/boA7M1bc8vzBYTEBJWFpiwAjY6trU8Rg9Iim3Fph7AdyaDv/89Tb0Q57
         L9DHgrP3pqYTE0hJaWZaW2khEFMSEu3tYHvlMEQBqWlHb2YjfalWeC+77XUU3wYqZzqY
         7NC+1jxsijWok55gd+KzziOOGwN5PU2Xgqd/wAQzhRKIvSEVh2sFaWKZMWZPKwWDyX6a
         ELzOGttAR80Vblql1eJJhP5rWDQJd0OOonKsPfpG/HoGYrLROXFOdUdkYonqMhL6Xq7F
         KM0yPEEe5S6XRb6M0KXUJVT/kEF1C+i0hOFFBNmtXMKFn1C7JthCuccPqAD1EmsQtTzQ
         bdCQ==
X-Gm-Message-State: AOJu0YxodJvF6JfHBLUGYxpu3lQhbqbJn01yrhID/yRB/7dIMjqIDVY/
        ZGftye1v5Sj2+2hcL5lz829elg==
X-Google-Smtp-Source: AGHT+IEqkTNN2T+hfCHJ/ViHfWdxArtT0gp28rpF3xhdPwJzWeQ3Ga8d3gt1tPf8eIV/mbMvs+M1cw==
X-Received: by 2002:a05:6a00:248b:b0:692:b539:28ff with SMTP id c11-20020a056a00248b00b00692b53928ffmr19360914pfv.24.1696989570062;
        Tue, 10 Oct 2023 18:59:30 -0700 (PDT)
Received: from [10.54.24.52] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b0068fb783d0c6sm9125148pfa.141.2023.10.10.18.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 18:59:29 -0700 (PDT)
Message-ID: <1a8ee686-e416-466b-4f6d-1dd26212b360@shopee.com>
Date:   Wed, 11 Oct 2023 09:59:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] memcg, oom: unmark under_oom after the oom killer is
 done
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20230922070529.362202-1-haifeng.xu@shopee.com>
 <ZRE9fAf1dId2U4cu@dhcp22.suse.cz>
 <6b7af68c-2cfb-b789-4239-204be7c8ad7e@shopee.com>
 <ZRFxLuJp1xqvp4EH@dhcp22.suse.cz>
 <94b7ed1d-9ca8-7d34-a0f4-c46bc995a3d2@shopee.com>
 <ZRF/CTk4MGPZY6Tc@dhcp22.suse.cz>
 <fe80b246-3f92-2a83-6e50-3b923edce27c@shopee.com>
 <ZRQv+E1plKLj8Xe3@dhcp22.suse.cz>
 <9b463e7e-4a89-f218-ec5c-7f6c16b685ea@shopee.com>
 <ZRvH2UzJ+VlP/12q@dhcp22.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZRvH2UzJ+VlP/12q@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/10/3 15:50, Michal Hocko wrote:
> On Thu 28-09-23 11:03:23, Haifeng Xu wrote:
> [...]
>>>> for example, we want to run processes in the group but those parametes related to 
>>>> memory allocation is hard to decide, so use the notifications to inform us that we
>>>> need to adjust the paramters automatically and we don't need to create the new processes
>>>> manually.
>>>
>>> I do understand that but OOM is just way too late to tune anything
>>> upon. Cgroup v2 has a notion of high limit which can throttle memory
>>> allocations way before the hard limit is set and this along with PSI
>>> metrics could give you a much better insight on the memory pressure
>>> in a memcg.
>>>
>>
>> Thank you for your suggestion. We will try to use memory.high instead.
> 
> OK, is the patch still required? 
Yes
As I've said I am not strongly opposed,
> it is just that the justification is rather weak.
> 
