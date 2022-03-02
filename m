Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D4D4CA96B
	for <lists+cgroups@lfdr.de>; Wed,  2 Mar 2022 16:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiCBPsE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Mar 2022 10:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbiCBPsC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Mar 2022 10:48:02 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3295DC681E
        for <cgroups@vger.kernel.org>; Wed,  2 Mar 2022 07:47:19 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a5so2269904pfv.9
        for <cgroups@vger.kernel.org>; Wed, 02 Mar 2022 07:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+TXEHf/Ffw9IRANu1j/U09cF+iyN1ryNSiaGmtROC/c=;
        b=E9TP1aQWp7/Dq8MS1gRXWqpotSaejMD0Vl/XuhfYiXbfMlpPINIjlSdESYNCIXZsUH
         iKLdYY+9gbkouxRibpbnlb/+rF4+t+FUMd4+3SR57L5gyqaWzlC6BfnDV0Krffq13wzI
         q3UChBYZk4RTPQao8TEy6OdZWUFWwUck+ou32qXsoJ/6bDf4XADKkTSCEvM+xSUhLYup
         sbApjAGmkm6UfcSLTDMfqsVToQ/zJMi1j5mAxsYFdRuMP+7Y2Li8GRp4qvsMRMIgDOOz
         3zC9BacGl7B5rjFLqmhtRsFcN/cU92MBf4/awNcFN0hWrYoUJX/+isEqApPRtxLDOuIu
         QiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+TXEHf/Ffw9IRANu1j/U09cF+iyN1ryNSiaGmtROC/c=;
        b=kvMUROSxhAU0FRYfObzevPB6b1FBe7p/Y+sLKsivjSTTs8YK3IaXk8hh2HWoBoj1uT
         qwXzXoXYbfA7tuNzqPKlhE/BPfIMYk5mbtMYnCbMZcmIx90v3BuUsCdrOak2arqrTjG+
         km8SwFSafMwhoyL7dTL9yJKDBB4jdmL+EPTAy139+koTvzHZuXJzp0SsXPvVPqII/ADi
         sZoFm23fQzkVwLhYDQZS7xKzy4pkIYP53c0HpvjitXWCqPUQ9hYBmLSMRtI5p9S9q3LU
         Q6/fZC0nQ1g6WkJA0Q6aM1eQt07FM0daCpe4rsz5uWYsj6OxqN5RI6rucVAr3lqTrTTE
         wZzg==
X-Gm-Message-State: AOAM530gzk3L7Hq2hSjOr9te7cYJHWv4UTADNpTU5zI1ZhNfA+SwHiPw
        YGViqo0l6nOt4ys4Vo+763E=
X-Google-Smtp-Source: ABdhPJyoYh07lMjBuBomRI5JgoaB7rWOYjQlf/YyT320uasBvrJ3TCq8aca9m3/kK+sfGAMpgSSMsw==
X-Received: by 2002:a63:9311:0:b0:372:710e:2263 with SMTP id b17-20020a639311000000b00372710e2263mr25909143pge.223.1646236038411;
        Wed, 02 Mar 2022 07:47:18 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090acd0500b001b9c05b075dsm5530501pju.44.2022.03.02.07.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 07:47:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Mar 2022 05:47:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cgroup: Add a comment to cgroup_rstat_flush_locked().
Message-ID: <Yh+RhFuPKGL+wpA0@slm.duckdns.org>
References: <[PATCH0/2]CorrectlockingassumptiononPREEMPT_RT>
 <20220301122143.1521823-1-bigeasy@linutronix.de>
 <20220301122143.1521823-2-bigeasy@linutronix.de>
 <Yh8Q+wjgk6dkDphR@slm.duckdns.org>
 <Yh+DOK73hfVV5ThX@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh+DOK73hfVV5ThX@linutronix.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 02, 2022 at 03:46:16PM +0100, Sebastian Andrzej Siewior wrote:
> Add a comment why spin_lock_irq() -> raw_spin_lock_irqsave() is needed.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> On 2022-03-01 20:38:51 [-1000], Tejun Heo wrote:
> > Hello,
> 
> Hello Tejun,
> 
> > Can you please add a comment explaining why irqsave is being used? As it
> > stands, it just looks spurious.
> 
> Something like this?

Yeah, looks good to me.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
