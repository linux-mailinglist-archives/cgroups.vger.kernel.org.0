Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD964B5618
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 17:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiBNQXp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 11:23:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243769AbiBNQXn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 11:23:43 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF62660AA9
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 08:23:34 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r9so4703782qta.1
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x0S57OtD5YWbc+A1GxyslYvaWYv57bktzT6DJRKKi4o=;
        b=2KF50jQJOk201/VzTxLzvo9tjknPWNwu2jq/ZfgmRAUVpqtndEci1YGElVvMe9FLtS
         GEfQPmOnDIboOy2xW5TOVpQM9OThMYIKu5l0KeXWoW30aMdjupqwujmJ/pRkgFCbrWBn
         XGeLik/uEYbK2QO5lhy251iXcjVaIbny5gymo5CB+wGit2CHhHKfqyIToIviWlzyTrsA
         cilVLQw40SsmdtHZq73lUfhv3Skge2BiknSX0i4YI+KGEoZpL78HoSL1R3ahdQrq/c4D
         JtVmvLR3+a2yrPHIUSb0QlGWoNa9y33b+j8jakbnOySnimEPhzB0aqbdWYdq9UM1buCZ
         BJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x0S57OtD5YWbc+A1GxyslYvaWYv57bktzT6DJRKKi4o=;
        b=lUldYonfW81gYceicnkrcaUg35rptxssnQ56A4F5c6vQkrX61KFtKwU9DLtx5/AT/K
         FTVeoC0v3yaMdkHbk8II0vvugIa6N2D/BLqw1DKOk6pognvcLL7XXbkzZRY/v2H/fceX
         T3vkIw5tzimbOIb13DNlU+BHasigMgapY9MEbQn52A4IJ7L8jY+EYkZi0o6pJFG+h3Td
         GfiQaXaJgfiIgeFADOTyxF5zoaqslrOFiXjhz/xNveFKBU2bw8sTYN2QMiRXTGJkuYR3
         Yp6974orRC0XN2RFhH8ef75MddhV3MRsYk5g7DkJFqlSl4WDqxqSzVv2psCcUFwGasF+
         Z3vA==
X-Gm-Message-State: AOAM531cWcquuJm7cY2Fhpw6UsK2wqV7ln1OTE16WUX01L3lh9N+LZMM
        0UAur9mZIHbQMmkIY9Yi0rdP/w==
X-Google-Smtp-Source: ABdhPJxBJ/o/Xs1chmzwENOly7CtoT9aAOKUkKm2rW8grOwiwuDhzaMGP7xBHjue8HfewsMyVku9hQ==
X-Received: by 2002:a05:622a:1714:: with SMTP id h20mr462793qtk.198.1644855814104;
        Mon, 14 Feb 2022 08:23:34 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id l11sm16589303qkp.86.2022.02.14.08.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:23:33 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:23:33 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 1/4] mm/memcg: Revert ("mm/memcg: optimize user
 context object stock access")
Message-ID: <YgqCBU4mVwkgnBi2@cmpxchg.org>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
 <20220211223537.2175879-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211223537.2175879-2-bigeasy@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 11, 2022 at 11:35:34PM +0100, Sebastian Andrzej Siewior wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> The optimisation is based on a micro benchmark where local_irq_save() is
> more expensive than a preempt_disable(). There is no evidence that it is
> visible in a real-world workload and there are CPUs where the opposite is
> true (local_irq_save() is cheaper than preempt_disable()).
> 
> Based on micro benchmarks, the optimisation makes sense on PREEMPT_NONE
> where preempt_disable() is optimized away. There is no improvement with
> PREEMPT_DYNAMIC since the preemption counter is always available.
> 
> The optimization makes also the PREEMPT_RT integration more complicated
> since most of the assumption are not true on PREEMPT_RT.
> 
> Revert the optimisation since it complicates the PREEMPT_RT integration
> and the improvement is hardly visible.
> 
> [ bigeasy: Patch body around Michal's diff ]
> 
> Link: https://lore.kernel.org/all/YgOGkXXCrD%2F1k+p4@dhcp22.suse.cz
> Link: https://lkml.kernel.org/r/YdX+INO9gQje6d0S@linutronix.de
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
