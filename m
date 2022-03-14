Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7962A4D9005
	for <lists+cgroups@lfdr.de>; Tue, 15 Mar 2022 00:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiCNXHC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 19:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiCNXHB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 19:07:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC04139BBC
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 16:05:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qt6so37390365ejb.11
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qviwn+qqmEMoumEZT2BJtbr5DY+V57MiiCdripFWHEs=;
        b=oWwPhqNJsbdbfbBEvYxrbM0l6Anq0/f5kesf3PtfoAYrvrPg0pv3IZh1/A9zTnTx++
         eWJ/nZLUEdArGsuk25+IHuZA6tO1dK2E8uTUfmZzYzSJ28Oya28iZ1W74uc0T5DcfmZG
         RI5GDkYYG4dKRoL6xf34peOMoUHy2JqYZoSbzHkg3wNLPo5fEoFsn3pOcZ0m2nW2AFtB
         S02gITXU151YZ7SeK9tv+xerQaq4J/IF2de6aMO1Qd/gYePQlogovXbOmGIP9kMz8JRm
         ZfaGBrHO1Vy2N4tKxhclnKj074FuOSdgE0zQQxk0SynlzkCIScyZZQTgsZmysNBjnPPF
         JQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qviwn+qqmEMoumEZT2BJtbr5DY+V57MiiCdripFWHEs=;
        b=lkrO16KOqwq/zJBkFWKVNMComf8JcSvubV13nYEtI0OJCmkFKHyfkOEThQbpn0v6Wu
         XxNId4oRA7q23yyTUrPjg9VLOcQD1hoZtXB/Hscm8Kipw1vXdbC+CGYw3j+PYLNfbCRN
         Qx86/kb3dZbX9zDm7Lu6PU+G9wn9zdn2H30P2jjcVYi9lfHzQeysJ/Qo4+dWXxFXKMyE
         mn1aLdLFxDyR9FbtcuRuDmVCW7QdXiuyfeiPtsVcopRezElgyIhPFhfBbfnGDdazUuN+
         cpHnXCTFuhZCoTV2q/01cTtzdbXsgxagPLccEwcs91C/OQ6168FN6fJ/YyJhBMVu8kwi
         BZ/Q==
X-Gm-Message-State: AOAM532WOpR6H2pdJk32K8Mlj8LbgjC33jytn32K7h1sHZb1IzRwAEJ+
        kzKdQYgrxgW4YzCJKXBzRIBxQEm1Z/w=
X-Google-Smtp-Source: ABdhPJxHgz2JPy5b0xn1sH77pqHfHXBZibuYxyiNvQF1Sc9W9ZEicH98JO7j/VJdFZVmwl9D1YElSQ==
X-Received: by 2002:a17:906:2584:b0:6d6:e5c9:221b with SMTP id m4-20020a170906258400b006d6e5c9221bmr20510612ejb.514.1647299149069;
        Mon, 14 Mar 2022 16:05:49 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q5-20020aa7cc05000000b004129baa5a94sm8630861edt.64.2022.03.14.16.05.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Mar 2022 16:05:48 -0700 (PDT)
Date:   Mon, 14 Mar 2022 23:05:48 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org
Cc:     Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Patch v2 3/3] mm/memcg: add next_mz back to soft limit tree if
 not reclaimed yet
Message-ID: <20220314230548.wo4colcwqxhhf3mx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220312071623.19050-1-richard.weiyang@gmail.com>
 <20220312071623.19050-3-richard.weiyang@gmail.com>
 <Yi8NudEX/sZsO2nO@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi8NudEX/sZsO2nO@dhcp22.suse.cz>
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

On Mon, Mar 14, 2022 at 10:41:13AM +0100, Michal Hocko wrote:
>On Sat 12-03-22 07:16:23, Wei Yang wrote:
>> When memory reclaim failed for a maximum number of attempts and we bail
>> out of the reclaim loop, we forgot to put the target mem_cgroup chosen
>> for next reclaim back to the soft limit tree. This prevented pages in
>> the mem_cgroup from being reclaimed in the future even though the
>> mem_cgroup exceeded its soft limit.
>> 
>> Let's say there are two mem_cgroup and both of them exceed the soft
>> limit, while the first one is more active then the second. Since we add
>> a mem_cgroup to soft limit tree every 1024 event, the second one just
>> get a rare chance to be put on soft limit tree even it exceeds the
>> limit.
>
>yes, 1024 could be just 4MB of memory or 2GB if all the charged pages
>are THPs. So the excess can build up considerably.
>
>> As time goes on, the first mem_cgroup was kept close to its soft limit
>> due to reclaim activities, while the memory usage of the second
>> mem_cgroup keeps growing over the soft limit for a long time due to its
>> relatively rare occurrence.
>> 
>> This patch adds next_mz back to prevent this sceanrio.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>Even though your changelog is different the change itself is identical to
>https://lore.kernel.org/linux-mm/8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com/
>In those cases I would preserve the the original authorship by
>From: Tim Chen <tim.c.chen@linux.intel.com>
>and add his s-o-b before yours.

TBH I don't think this is fair.

I didn't see his original change before I sent this patch. This is a
coincidence we found the same point for improvement.

It hurts me if you want to change authorship. Well, if you really thinks this
is what it should be, please remove my s-o-b.

>
>Acked-by: Michal Hocko <mhocko@suse.com>
>
>Thanks!

-- 
Wei Yang
Help you, Help me
