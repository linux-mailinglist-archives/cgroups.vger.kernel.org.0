Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E66B4509D8
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhKOQof (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Nov 2021 11:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhKOQof (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Nov 2021 11:44:35 -0500
X-Greylist: delayed 93 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Nov 2021 08:41:36 PST
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD175C061570
        for <cgroups@vger.kernel.org>; Mon, 15 Nov 2021 08:41:35 -0800 (PST)
Received: from iva8-d2cd82b7433e.qloud-c.yandex.net (iva8-d2cd82b7433e.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:a88e:0:640:d2cd:82b7])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 299732E0AF9;
        Mon, 15 Nov 2021 19:39:39 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by iva8-d2cd82b7433e.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 8I2AdDC1uF-dbsqo6gk;
        Mon, 15 Nov 2021 19:39:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com; s=default;
        t=1636994379; bh=sJgNHnb3hOQwurINlS2X7YNRsTmHCa/JxTtjIM5qnfg=;
        h=In-Reply-To:References:Date:From:To:Subject:Message-ID:Cc;
        b=3JyafGaHD9qpsnhQ+lmPh5DLKs3kKIfHRnHasFGDpCRLUjaMtamqq+j7Dpx6hylln
         E4brZ/IlP8Aj4+b/OtVJTlqFno0lfwi8foBxXxIsj7hGrqhBHyrjq+SFCop8KTAaG/
         NqPhOgcmv/OH/N6sEeEKE84jBu0wU/BH+ACBVx6k=
Authentication-Results: iva8-d2cd82b7433e.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.com
Received: from [IPv6:2a02:6b8:0:107:3e85:844d:5b1d:60a] (dynamic-red3.dhcp.yndx.net [2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPS id Phoahep5KZ-daxCbT90;
        Mon, 15 Nov 2021 19:39:37 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Subject: Re: [PATCH] cgroup: Fix rootcg cpu.stat guest double counting
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Boris Burkov <boris@bur.io>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20211028221528.2174284-1-schatzberg.dan@gmail.com>
 <20211029172129.smeyk5adocjrwtlb@oracle.com>
From:   Andrey Ryabinin <arbn@yandex-team.com>
Message-ID: <161a70b7-ee6f-bbc7-8a2e-1fd42fcba3eb@yandex-team.com>
Date:   Mon, 15 Nov 2021 19:41:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211029172129.smeyk5adocjrwtlb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 10/29/21 8:21 PM, Daniel Jordan wrote:
> On Thu, Oct 28, 2021 at 03:15:27PM -0700, Dan Schatzberg wrote:
>> In account_guest_time in kernel/sched/cputime.c guest time is
>> attributed to both CPUTIME_NICE and CPUTIME_USER in addition to
>> CPUTIME_GUEST_NICE and CPUTIME_GUEST respectively. Therefore, adding
>> both to calculate usage results in double counting any guest time at
>> the rootcg.
> 
> Yes, definitely a bug.  The same fix was posted a couple months ago as
> part of a series but never picked up:
> 
>   https://x-lore.kernel.org/all/20210820094005.20596-3-arbn@yandex-team.com/
> 
> The series also touched cputime, so we might be waiting for scheduler
> folks?   +Ingo +Peter +Andrey
> 

Yeah, I'll do rebase and send v3
