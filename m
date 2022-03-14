Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDE64D8FE3
	for <lists+cgroups@lfdr.de>; Mon, 14 Mar 2022 23:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiCNWxE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 18:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbiCNWxE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 18:53:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF836173
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 15:51:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bg10so37422513ejb.4
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wCeR5z7Z9I0OZ5CW9/ENgLziIVfJwONuLcSxsmCrGvQ=;
        b=C0C8NN3xNrpb0KoqYriDF0/coODFEYWWLzYOmoHnZsjra3mm06pm8YS0CMGKFLt21h
         d4xtohTHd3MOFp9xPgAKmy0nXJ9B7PV7He5Eh6K+4Cb4BXdxHUMBQ8gR0gTnvwhdqfqQ
         d8QZA0r26ZW7orl+WkOUjr1mqXxWk1UeBzJRuoMT0TRM6Vm3xzLfA8OYL8OE+Qa+Wc2s
         oo72lh8kFvnijMO8WnuQDRAvIQDQuQEVGDu4/LdvDKzpjyVDEi6SZk2+0ouqqAIiwoAc
         qMCkkLK+Vy/bRn4QOskN46wbNMNVONWyeZtF/FI9lTRWxBh0RChuviSAXIRryv8SvqoX
         +n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wCeR5z7Z9I0OZ5CW9/ENgLziIVfJwONuLcSxsmCrGvQ=;
        b=LCqK28QTLmopVLs2vSc+sjLn3IfdigTY9YJujZEQ7J2Ee7fuRSt8uLQrgfCEeXLkn/
         5tju1bJlM7WqQcHlTiyYe+QbN7YFYq7waInfRHlxyHKgSFXCSv3qpmUDN/CghpTv9d4l
         GUaWc7q64Xh9DcG82I1U0r6XFrFvKs0ajoLJUMaSBAjt6UoGZ8VbxpdrlLKs5jPrJ7wP
         Bo1rclPZlQlwY7AL1O/O6wM1khfnQXncN5+VAxyE7d9BHJlrOYjWBQ02qH98WFuAv4zi
         tlAnke+Oyo4NPisGs1GclvgTvZCaOTLW5QDJxDNiGUYLa5nzguLnsEWut4oYkfUSd1J/
         Cmhg==
X-Gm-Message-State: AOAM533JHhtkey73BUQkFxdixvtLLy2THIVRquf4lrrt3qIMoxAb0bvI
        Qo6zxedywZ9A4rUXP/EQOCPUhlmbZuA=
X-Google-Smtp-Source: ABdhPJz2iFWYlpahGGyqdkRdhh/60lKzlbsCAsF3zu4k2xuvC579SqvfVVIF4SxOSeriVqJIp+5TwQ==
X-Received: by 2002:a17:906:30d1:b0:6cf:c116:c9d3 with SMTP id b17-20020a17090630d100b006cfc116c9d3mr19545523ejb.245.1647298311650;
        Mon, 14 Mar 2022 15:51:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm7360040ejj.142.2022.03.14.15.51.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Mar 2022 15:51:51 -0700 (PDT)
Date:   Mon, 14 Mar 2022 22:51:50 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Patch v2 2/3] mm/memcg: __mem_cgroup_remove_exceeded could
 handle a !on-tree mz properly
Message-ID: <20220314225150.fhwny4yhxgjevwxx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220312071623.19050-1-richard.weiyang@gmail.com>
 <20220312071623.19050-2-richard.weiyang@gmail.com>
 <Yi8Qu/1V4H1M9qZV@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi8Qu/1V4H1M9qZV@dhcp22.suse.cz>
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

On Mon, Mar 14, 2022 at 10:54:03AM +0100, Michal Hocko wrote:
>On Sat 12-03-22 07:16:22, Wei Yang wrote:
>> There is no tree operation if mz is not on-tree.
>
>This doesn't explain problem you are trying to solve nor does it make
>much sense to me TBH.
>

This just tries to make the code looks consistent.

>> Let's remove the extra check.
>
>What would happen if the mz was already in the excess tree and the
>excess has grown?

The purpose mem_cgroup_update_tree() is to update the soft limit tree. And the
approach is to remove and add it back to the tree with new excess.

I don't get your point for this question.


-- 
Wei Yang
Help you, Help me
