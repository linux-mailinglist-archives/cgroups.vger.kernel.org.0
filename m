Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC759D129
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 08:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiHWGSh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 02:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiHWGSe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 02:18:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD670EE2B
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 23:18:31 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id d71so11394828pgc.13
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 23:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3/lhotbB4Uar/lt4peIcoGTYHkX7iv9Q8q1pdoozNu0=;
        b=HPvGXZlhi0nU7N1qbXgghsfXNeuVWNupf6HJIuUeCRUD+8IoJow9QQ7ZaoAYF9g2+C
         hnnO0pM7HFbyVhJxv18B1ycqujMTc2vX71070Q9FFIBweuSgou7ZSEJMdRBijO0HA1/v
         FziVPVgeu9nU3FeEU+XGUMmiPxP6Tqr6OUBx2ErNlGlCivCeGIEakr0+82PSQi4eaz/D
         l2UYL0w2n9VktS8Ugo3FsCCvW+76y9QaTh8c387K5RFQD/DsfSQpgidjQvcDNGSloG4v
         naUMJYfoeUsvz0VFr0vC18XrBtpusuu0Zoh2D1f673+pqa0E0rBuJnPgWiIanuG/4h8S
         2JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3/lhotbB4Uar/lt4peIcoGTYHkX7iv9Q8q1pdoozNu0=;
        b=4UDdx/Bz4PTrJSteSOf8CTSppiHzcwywF2/YfHxbZv2rU4eHoFFpls34NUYX4habOv
         +qaNN6ryHuw7Xf7Cb5qCtpujt5zfsM7rwP5Z6VW+sdxod0SXN6PP8vizeCIgOCgYd00G
         cWcEEmRVvBhuUfJ45uWLH5VEpiRJA97slw8Rdvo+tr5DR81gmzGO9gHbSTZXlHOi4tVg
         a4HZyf2i6QZ0vIPypeCoslhsrkGrt6yvSuv1Rx8qhr0Yv2LYc6EbOdqAQCjYyskvZpMy
         xXjdJge6wgB4lza+YXeFcjat2fPRYMSwBtnAQ+7NiLaQpSj8LIpFrExtBWf90ch3D+8A
         te4w==
X-Gm-Message-State: ACgBeo1VyN1cddBUT9mkJKqrB/ewWWwnvRt91F8l4WdRysY/fCTWwOLr
        0FCECtcDIJ+6rGEMgpPgrAKZvg==
X-Google-Smtp-Source: AA6agR4M47/Yf8Et3r8O9o96m8U+PWHhEeW9jgpZEjIOsqKpb7rtFRp/rPaUtx23rNWLMFjQ6aj99A==
X-Received: by 2002:a65:6d14:0:b0:41d:5f95:179d with SMTP id bf20-20020a656d14000000b0041d5f95179dmr19300579pgb.580.1661235511395;
        Mon, 22 Aug 2022 23:18:31 -0700 (PDT)
Received: from [10.4.208.12] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b00172ccb3f4ebsm6285338plh.160.2022.08.22.23.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 23:18:30 -0700 (PDT)
Message-ID: <9d1997a4-9278-07bd-7f57-952306b28b14@bytedance.com>
Date:   Tue, 23 Aug 2022 14:18:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, corbet@lwn.net, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvKd6dezPM6UxfD/@slm.duckdns.org>
 <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
 <b89155d3-9315-fefc-408b-4cf538360a1c@bytedance.com>
 <YvPN07UlaPFAdlet@cmpxchg.org> <20220815132343.GA22640@blackbody.suse.cz>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220815132343.GA22640@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/15 21:23, Michal Koutný wrote:
> On Wed, Aug 10, 2022 at 11:25:07AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
>> cgroup.pressure.enable sounds good to me too. Or, because it's
>> default-enabled and that likely won't change, cgroup.pressure.disable.
> 
> Will it not change?
> 
> I'd say that user would be interested in particular level or even just
> level in subtree for PSI, so the opt-out may result in lots of explicit
> disablements (or even watch for cgroups created and disable PSI there)
> to get some performance back.
> 
> I have two suggestions based on the above:
> 1) Make the default globally configurable (mount option?)
> 2) Allow implicit enablement upon trigger creation
> 

I think suggestion 1) make sense in some use case, like make per-cgroup
PSI disabled by default using a mount option, then enable using the
"cgroup.pressure" interface.

But suggestion 2) auto enable upon trigger creation, if we hide the
{cpu,memory,io}.pressure files when disabled, how can we create trigger?

Want to see what do Johannes and Tejun think about these suggestions?

Thanks.
