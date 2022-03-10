Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10B74D562D
	for <lists+cgroups@lfdr.de>; Fri, 11 Mar 2022 00:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbiCJX6h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Mar 2022 18:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbiCJX6g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Mar 2022 18:58:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFA62DD7
        for <cgroups@vger.kernel.org>; Thu, 10 Mar 2022 15:57:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b15so4903060edn.4
        for <cgroups@vger.kernel.org>; Thu, 10 Mar 2022 15:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OkAryEzutT6iAK7gGQZ0EX71N3D+2tmBltCJ6yrSjxw=;
        b=IZ7jNCsyI1YiomKE/iwIDgeEEkJXqEWgThkJSlbsnONKYJQVuGgW0mVeMkdfA+jZRH
         dNX+J5WhKU9aDgLZozigkohOsN23JbVUrVCEbKkIyM/HmVWPmsCDo+ve/OmcMY/R4L46
         wc+Lpbkm0irrf4LPBje32HvD7opm/vcqBJyRTGLFpMx/D1zcb1xYMpYJhf0+HgrDPAp5
         6tladH5AFii+KrgzJAR0ueHVwgFZUs3pXkyggWSMBbFFukQv65AhTfvyA0Ze4E0qEcDo
         PqrBduRvnl0lXJSkKKKVsmhC9wNqLAIbF2JT18xVIRI6ZIN+LUKgZZB2N2vgkv7hhx2T
         v1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OkAryEzutT6iAK7gGQZ0EX71N3D+2tmBltCJ6yrSjxw=;
        b=6vOHiFXN/RFRdBC1juoNX/A/nfMgjd7e2IHshrRN76bLKppgZ5jUVcJhJBmu0Vzy2C
         +2m25I73VAzTBKPoMh2yFzBtPHJ92Xz3QGXMAN9YSsE9fLTlIjmHqLxChJM1+s/mnIXO
         X7owdvpIhV+b8NwCTVE7shZcElduYBEeTsjEX1OReZPEn/yxhVfymLBuZzgcGgi3jtAN
         GFLfEyVhWP9Z0wGYrkZScf5C3QK/aTFqaxSlkOY37Zf3rvSm3Xn345vEPtZCHr6PxC8D
         Ur6STjpDlfc+LCZR2pjOs8jGMf1AI1hKjHrHhfQ6OadNIJjQa4kvPrRubedE4eFnPllu
         S3gQ==
X-Gm-Message-State: AOAM532QltznMApFs0x19wAAi6AIY+NTkr/QiP88/yMe5Nmfe3YciM0w
        Dg0fhTA6szCQ+gbSlHEbTsA=
X-Google-Smtp-Source: ABdhPJyQw+NoCzOJn9Js/MkKoWiVxSPTj6IHgbeVn2xwr6FxI3Y4MzlRCxRlKdnGUcNfr19UqKPDlg==
X-Received: by 2002:a05:6402:5304:b0:413:8a0c:c54a with SMTP id eo4-20020a056402530400b004138a0cc54amr6616765edb.172.1646956650673;
        Thu, 10 Mar 2022 15:57:30 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v5-20020a50c405000000b004161123bf7asm2548472edf.67.2022.03.10.15.57.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Mar 2022 15:57:30 -0800 (PST)
Date:   Thu, 10 Mar 2022 23:57:29 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 3/3] mm/memcg: add next_mz back if not reclaimed yet
Message-ID: <20220310235729.txnjuhcptsp2sc2a@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220308012047.26638-1-richard.weiyang@gmail.com>
 <20220308012047.26638-3-richard.weiyang@gmail.com>
 <YicRNofU+L1cKIQp@dhcp22.suse.cz>
 <20220309004620.fgotfh4wsquscbfn@master>
 <YiiwPaCESiTuH22a@dhcp22.suse.cz>
 <20220310011350.2b6fxa66it5nugcy@master>
 <Yim8p0C4CxC6SskI@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yim8p0C4CxC6SskI@dhcp22.suse.cz>
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

On Thu, Mar 10, 2022 at 09:53:59AM +0100, Michal Hocko wrote:
>On Thu 10-03-22 01:13:50, Wei Yang wrote:
>> On Wed, Mar 09, 2022 at 02:48:45PM +0100, Michal Hocko wrote:
>> >[Cc Tim - the patch is http://lkml.kernel.org/r/20220308012047.26638-3-richard.weiyang@gmail.com]
>> >
>> >On Wed 09-03-22 00:46:20, Wei Yang wrote:
>> >> On Tue, Mar 08, 2022 at 09:17:58AM +0100, Michal Hocko wrote:
>> >> >On Tue 08-03-22 01:20:47, Wei Yang wrote:
>> >> >> next_mz is removed from rb_tree, let's add it back if no reclaim has
>> >> >> been tried.
>> >> >
>> >> >Could you elaborate more why we need/want this?
>> >> >
>> >> 
>> >> Per my understanding, we add back the right most node even reclaim makes no
>> >> progress, so it is reasonable to add back a node if we didn't get a chance to
>> >> do reclaim on it.
>> >
>> >Your patch sounded familiar and I can remember now. The same fix has
>> >been posted by Tim last year
>> >https://lore.kernel.org/linux-mm/8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com/
>> >It was posted with other changes to the soft limit code which I didn't
>> >like but I have acked this particular one. Not sure what has happened
>> >with it afterwards.
>> 
>> Because of this ?
>> 4f09feb8bf:  vm-scalability.throughput -4.3% regression
>> https://lore.kernel.org/linux-mm/20210302062521.GB23892@xsang-OptiPlex-9020/
>
>That was a regression for a different patch in the series AFAICS:
>: FYI, we noticed a -4.3% regression of vm-scalability.throughput due to commit:
>: 
>: commit: 4f09feb8bf083be3834080ddf3782aee12a7c3f7 ("mm: Force update of mem cgroup soft limit tree on usage excess")
>
>That patch has played with how often memcg_check_events is called and
>that can lead to a visible performance difference.

Yes, I mean maybe because of this regression, the whole patch set is removed.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
