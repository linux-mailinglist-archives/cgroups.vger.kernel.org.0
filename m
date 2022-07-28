Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FF8584681
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 21:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiG1TDG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 15:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiG1TDF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 15:03:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26953C15A;
        Thu, 28 Jul 2022 12:03:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 23so2238177pgc.8;
        Thu, 28 Jul 2022 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=PWjIAmKrG0eGARGnUAKYiT1lYkiSHVZ1Sr+4FZSAYxg=;
        b=ksr0sVCDXJtHVWTGYRs6udLXbSRcNqPqF8cH0ACW6cKjvQVmA5weo37e+Eopue0wU/
         ZNvMmqCx3FhEnbbDzsNh5oM30sf4voiO5TOuZGgUwgIUWbd8HVNH0EJpf1igfj7nCThO
         uYXY03CYxCcobHkUVOKBQLudEOxJJhMpvI7tE0Cfkt6zJyV7DkrjtHLIdRAk0meelh7d
         po6PXn9dUzyB3g83pYcmcs0a9NJiSxXWLJs02p8RIWAiEiW/HLMvB4AtTtJPKxrw7Wj/
         QEKX3x1t+/Dh2lcam+fpLLLXo+LGfU78S78F4HECzGv9eJMNzRr9L6+EJWY25fFknMmi
         TaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=PWjIAmKrG0eGARGnUAKYiT1lYkiSHVZ1Sr+4FZSAYxg=;
        b=R6hq9e7myYUcA6RDo1nZbMG4+xfWNShsUNCRDEnuauf5Ewsy1UTJO3AauIeMMeJMeg
         zw/3yBofWyUVbYrvhryGwR59F8s6MslD/iVKOnHAOm4J19Ew9gWFyB8OlU6Z87Q59tY3
         xt0VHqId9YrexXDVP1C9uWL9CLBFtG7f1YIS9UUCAqcNseooqyaVNUEFDrLyP6RAQmNe
         jWODm5E3bq8/LCrZRA3IRXf4Qsy0L1d+j0JYXDTGK/A9QdN0DnHJBSO7SQfVPQ/vJCJ6
         SDfRIvMM9w1mfqVzy84eKsxRak0PEPFL+BIgWs27e3o7nshjKqLuzLnokoTrB198Eq3Q
         esIw==
X-Gm-Message-State: AJIora/SDC0Nb4bu8+2aAX6mLM033ms3MgdKr/h/o2z+ifGR0ESEt/Ko
        GDQPX01ufvTDVf23yrElH1g=
X-Google-Smtp-Source: AGRyM1uHrDVG/cMBiaEmc094cji+F72tZjjruHBYb/AtSWLsyCjIa3CRmmESKjlAtNumvWNiAarMXA==
X-Received: by 2002:a05:6a00:150e:b0:52a:ee55:4806 with SMTP id q14-20020a056a00150e00b0052aee554806mr28075437pfu.37.1659034984146;
        Thu, 28 Jul 2022 12:03:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:23b6])
        by smtp.gmail.com with ESMTPSA id t128-20020a625f86000000b0052ad49292f0sm1128306pfb.48.2022.07.28.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 12:02:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jul 2022 09:02:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
Message-ID: <YuLdX7BYGvo57LNU@slm.duckdns.org>
References: <20220728005815.1715522-1-longman@redhat.com>
 <YuLF+xXaCzwWi2BR@slm.duckdns.org>
 <1ae1cc6c-dca9-4958-6b22-24a5777c5e8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ae1cc6c-dca9-4958-6b22-24a5777c5e8d@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jul 28, 2022 at 02:57:28PM -0400, Waiman Long wrote:
> There can be a counter argument that if a user found out that there is not
> enough cpus in a cpuset to meet its performance target, one can always
> increase the number of cpus in the cpuset. Generalizing this behavior to all
> the tasks irrespective if they have explicitly set cpus affinity before will
> disallow this use case.

This is nasty. The real solution here is separating out what user requested
and the mask that cpuset (or cpu hotplug) needs to apply on top. ie.
remember what the user requested in a separate cpumask and compute the
intersection into p->cpus_maks whenever something changes and apply
fallbacks on that final mask. Multiple parties updating the same variable is
never gonna lead to anything consistent and we're patching up for whatever
the immediate use case seems to need at the moment. That said, I'm not
necessarily against patching it up but if you're interested in delving into
it deeper, that'd be great.

Thanks.

-- 
tejun
