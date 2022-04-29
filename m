Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2984B513FEA
	for <lists+cgroups@lfdr.de>; Fri, 29 Apr 2022 03:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353638AbiD2BGy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 21:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiD2BGy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 21:06:54 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4303ABC865;
        Thu, 28 Apr 2022 18:03:38 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id kd11so4428454qvb.2;
        Thu, 28 Apr 2022 18:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5W/PHVbvpSagVt8G3Hj3eW0IY7pmUgdHHakH22/epB8=;
        b=uIDzWEM6Nnw4tRtYVaj7+heGUYGsMg00iKD2Z3GOBWEh+0lHPjGFWED/wohlT/2kPb
         nWqdhj6Xjg8ikvXsIZny51dcPBj46OQuid2jqC5BQopaTSHMcnFckRLSoXwIvODs7gmU
         375YQicFz8s0Rodu72rtnZmCow+JAuSvpA668IIXiA6VuH4okicEMQ7HeTaerZJwxE+n
         WQHw7EPrwuN8XSYEH2tc9zx2xuOiXQqWUBtcssM8o3bt+McYgM10vMEtciN83DbdyKt5
         zflEalNBeueIlnVuBBVByHB1T/7+iTJNY9sRYih1yGexU1Ygl9e7jzE3WFRuuB4I4Fq1
         Ld/Q==
X-Gm-Message-State: AOAM5312Py8KpCr3ZjpzPV1KfGbvh+SBbnfYvpAgszbY0hVWoIScRtsW
        JTHujaQcMZQKhQVo5RyMG+4=
X-Google-Smtp-Source: ABdhPJycaAU4Fqd8i5oSVNbuNnJ/LKsV/SNu6Bwc8rsaXssptvFPXU9aCZhBc7ty0EIfRzyIKyvx3g==
X-Received: by 2002:a05:6214:f6d:b0:446:4c8b:b57d with SMTP id iy13-20020a0562140f6d00b004464c8bb57dmr26267591qvb.104.1651194217338;
        Thu, 28 Apr 2022 18:03:37 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-016.fbsv.net. [2a03:2880:20ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a249300b0069f805534d3sm814533qkn.89.2022.04.28.18.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 18:03:37 -0700 (PDT)
Date:   Thu, 28 Apr 2022 18:03:33 -0700
From:   David Vernet <void@manifault.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: Re: [PATCH v2 2/5] cgroup: Account for memory_recursiveprot in
 test_memcg_low()
Message-ID: <20220429010333.5rt2jwpiumnbuapf@dev0025.ash9.facebook.com>
References: <20220423155619.3669555-1-void@manifault.com>
 <20220423155619.3669555-3-void@manifault.com>
 <20220427140928.GD9823@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427140928.GD9823@blackbody.suse.cz>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On Wed, Apr 27, 2022 at 04:09:28PM +0200, Michal Koutný wrote:
> Hello David.
> 
> On Sat, Apr 23, 2022 at 08:56:19AM -0700, David Vernet <void@manifault.com> wrote:
> > This unfortunately broke the memcg tests, which asserts that a sibling
> > that experienced reclaim but had a memory.low value of 0, would not
> > observe any memory.low events. This patch updates test_memcg_low() to
> > account for the new behavior introduced by memory_recursiveprot.
> 
> I think the test is correct, there should be no (not even recursive)
> protection in this particular case (when the remaining siblings consume
> all of parental protection).
> 
> This should be fixed in the kernel (see also [1], no updates from me yet
> :-/)
> 
> Michal
> 
> [1] https://lore.kernel.org/lkml/20220322182248.29121-1-mkoutny@suse.com/
> 

I see, thanks for sharing that context. I think I see your point about the
implementation of the reclaim mechanism potentially overcounting, but my
interpretation of the rest of that discussion with Roman is that we haven't
yet decided whether we don't want to propagate memory.low events from
children cgroups with memory.low == 0. Or at the very least, some more
justification was requested on why not counting such events was prudent.

Would you be ok with merging this patch so that the cgroup selftests can
pass again based on the current behavior of the kernel, and we can then
revert the changes to test_memcg_low() later on if and when we decide that
we don't want to propagate memory.low events for memory.low == 0 children?

Thanks,
David
