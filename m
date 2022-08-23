Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA43959EA96
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 20:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiHWSKv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 14:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbiHWSK2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 14:10:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3A3659D7;
        Tue, 23 Aug 2022 09:20:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id l64so12729008pge.0;
        Tue, 23 Aug 2022 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=MkchlG+vC7eeExntyPywB6o/N2CwihE3Mv9oTg/XCfA=;
        b=XxzpYtA2pnvxm7jj/aZsB1ovGYgGFFOxiJHjtvxhSaQ2REDVDoCQIjB/GtHH3oVwse
         NbSR71cHM3UNRFgLwyej9TpI0L9rWYkF3KkrxZ2C2kw/EhuAh1C8pna4IXsnCDF3BF2V
         8IhM33IU1xrqLpTtcYD8/GGzjVMCaXX2XEfzTFIJp+wjFzbfTmxY37Dv4svHZMG0+KEo
         aRjhTxwWgpoysJLCODS4LSRitnpLJHVgILVZtGtASuPTh6vMwSzxhp5+JZNm5nJ5IYCo
         b3Dy8XSRPGHhnsPawF9cGPvUjeBwgKkMqHXYvYuy4cvIN6PNJjDppSYfrn2gz9H3zm6h
         9Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=MkchlG+vC7eeExntyPywB6o/N2CwihE3Mv9oTg/XCfA=;
        b=EpQxwuYkO6H1Ov9BejHnLRtDiWaXH08YPEf6DEYt4Ihc8mGCkn9iFPQXw7IuqMiTE+
         53TC+bwoqqS47kWfDYoqMi5eiNdgtk+V6aHVqNBgsL1MSBIuXkSkqmTjqHV2IihCw8oV
         hSnWFQXZlvldnUHwBes4VOGj/1xE0oJ4okmeyqSwOSPOypAOzhvlG+40Rk0824YmvyHl
         1MkQQ/kkRz/HkhQ1LTocje5+ZlhrNMecQpxa/9afJWrfdFCpCD/j4Ex76zvR6gclroeP
         pqvctdpSM2hzu9+wQvaZQhRwp+yoUrCmPoq0tbxiE7EJXzoyemT3CShB6xFujyDbzaWB
         ensA==
X-Gm-Message-State: ACgBeo10+z7Ke1MtBXU9L1W+sD371L/6+5ho6rt5ziK2UKRW1fMWezOS
        rROXm3g+bW+Hu3D7ojQnZGU=
X-Google-Smtp-Source: AA6agR4cW34xCWONe1DFQhmDIqb/ilOQuYVa7OvNWr8Tj8a5MCNIZ+ylQxDsXgma0bv+PadMQYQ2jA==
X-Received: by 2002:a63:131c:0:b0:427:7f15:470f with SMTP id i28-20020a63131c000000b004277f15470fmr21682374pgl.232.1661271622771;
        Tue, 23 Aug 2022 09:20:22 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d135-20020a621d8d000000b0052d4b0d0c74sm11029697pfd.70.2022.08.23.09.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 09:20:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 06:20:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        corbet@lwn.net, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Message-ID: <YwT+RDZyszAQ/Vro@slm.duckdns.org>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvKd6dezPM6UxfD/@slm.duckdns.org>
 <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
 <b89155d3-9315-fefc-408b-4cf538360a1c@bytedance.com>
 <YvPN07UlaPFAdlet@cmpxchg.org>
 <20220815132343.GA22640@blackbody.suse.cz>
 <9d1997a4-9278-07bd-7f57-952306b28b14@bytedance.com>
 <YwTz32VWuZeLHOHe@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwTz32VWuZeLHOHe@cmpxchg.org>
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

Hello,

On Tue, Aug 23, 2022 at 11:35:59AM -0400, Johannes Weiner wrote:
> Re 1: I agree. If desired in the future we can make the default
> configurable. Kconfig, mount option, what have you. cgroup.pressure
> will work fine as a name regardless of what the default is.

Given that there's already cgroup_disable=pressure for cases which want it
fully disabled, I'm not sure we'd need to add more complex disabling
options. The only difference that'd make is for users who are configuring
cgroups manually which is pretty rare and it'd create a clear downside of
increasing confusion as the base assumption becomes dynamic. So, I think the
current default-on with opting-out is and will be just fine.

> Re 2: Not all consumers of the pressure metrics create trigger. I
> would argue that few do. So it isn't the best signal to decide on
> whether aggregation should occur. And yes, it's further complicated by
> the triggers being written to the very pressure files. If we don't
> hide them, we have to come up with another way to mark them as stale,
> lest they confuse the heck out of users. Without breaking format...
> 
> So IMO, default-enable, "cgroup.pressure" as a name, and hiding the
> pressure files should be good for now while allowing to make the
> default configurable down the line.

Sounds great.

Thanks.

-- 
tejun
