Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5C759EA00
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiHWRoF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 13:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiHWRnP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 13:43:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD9D99242
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 08:36:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k17so7409692wmr.2
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=SYAHudUPI5QrzKudcquORH0On1C/OknqZBdmjmshgeU=;
        b=TqFj1ebLWjLYSVrPYFRfxKAk4n77SoNLZgCsLhn0knY5tExJE/V2jF9McNhX7QbXRM
         tsHXX5ZujFybQNyugpk/MKa89GXitAbOP3FmFpuxt4Slt9wrk1vRPJAlXS3AHz5OC0wP
         IY6ua704/P81xOXq4ZBiv2LeoGWa9Rv64tY5FkZomGZCjciVHs+0Qa8KeK5GXx6EUzHZ
         YYndDjyQghXOPttvHBtgaocZN97llsr5NB0k063X9ya9zlTx0VC70GZfgEOHisEVatHP
         zSEGKrtkandeoNYaCxVmhGi0XPphUdZglVUGQcP6MJCSqbn53eBBWj80kxWNGMMP5s/W
         R++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=SYAHudUPI5QrzKudcquORH0On1C/OknqZBdmjmshgeU=;
        b=zy+sOOS7l7noinDWlUymeWt+HxAxWivGYl0Kdzr9vnSiugatPmsODTdwkLj4MvVgHU
         l6JiEfLBUhwoZyHqHSQDuWp0Vx25LNRT+ESsNrHKzGANxksDI3JMwZVoRjYI/wuRAgqj
         pdSz8yUFRxxSqpIzzmJT0WlksjInXpkAtuQAmgjF1fDKwxkCrXx+SE7//rqG/uVXGf9M
         7i02hWJkyGTLC7Kh8dRgvXkI95NkObLopFdtLoB1O4lSGxD5lY/NH2RE2zy858FnfzZL
         zi/jHvWjBkThP9D/OcR0ifyRsYPI7ZJLW5InCdw0HrTKHK9/XtjtgDBD0w/iAl5PnP8E
         oNAA==
X-Gm-Message-State: ACgBeo1JwPdDfxZAGAKMDgvn6T6ucBGbfDNwZVx+WttTQqPzh1NyqsVy
        m51A15JXeMywpVLD2uGqIsnwOA==
X-Google-Smtp-Source: AA6agR5iV5tDp452keAkcfj8eHE0ldf6wsqqBPQO4hVoOx73NDThvYM7aP7HWzf/4wTVXcTUQS9KVA==
X-Received: by 2002:a05:600c:5114:b0:3a5:cb1f:6bf3 with SMTP id o20-20020a05600c511400b003a5cb1f6bf3mr2642833wms.65.1661268961233;
        Tue, 23 Aug 2022 08:36:01 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:a4c0:2ca9:6d59:782b:fff3])
        by smtp.gmail.com with ESMTPSA id f2-20020a1cc902000000b003a5f783abb8sm20848646wmb.30.2022.08.23.08.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 08:36:00 -0700 (PDT)
Date:   Tue, 23 Aug 2022 11:35:59 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, corbet@lwn.net, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Message-ID: <YwTz32VWuZeLHOHe@cmpxchg.org>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvKd6dezPM6UxfD/@slm.duckdns.org>
 <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
 <b89155d3-9315-fefc-408b-4cf538360a1c@bytedance.com>
 <YvPN07UlaPFAdlet@cmpxchg.org>
 <20220815132343.GA22640@blackbody.suse.cz>
 <9d1997a4-9278-07bd-7f57-952306b28b14@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d1997a4-9278-07bd-7f57-952306b28b14@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 23, 2022 at 02:18:21PM +0800, Chengming Zhou wrote:
> On 2022/8/15 21:23, Michal Koutný wrote:
> > On Wed, Aug 10, 2022 at 11:25:07AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> >> cgroup.pressure.enable sounds good to me too. Or, because it's
> >> default-enabled and that likely won't change, cgroup.pressure.disable.
> > 
> > Will it not change?
> > 
> > I'd say that user would be interested in particular level or even just
> > level in subtree for PSI, so the opt-out may result in lots of explicit
> > disablements (or even watch for cgroups created and disable PSI there)
> > to get some performance back.
> > 
> > I have two suggestions based on the above:
> > 1) Make the default globally configurable (mount option?)
> > 2) Allow implicit enablement upon trigger creation
> > 
> 
> I think suggestion 1) make sense in some use case, like make per-cgroup
> PSI disabled by default using a mount option, then enable using the
> "cgroup.pressure" interface.
> 
> But suggestion 2) auto enable upon trigger creation, if we hide the
> {cpu,memory,io}.pressure files when disabled, how can we create trigger?
> 
> Want to see what do Johannes and Tejun think about these suggestions?

Re 1: I agree. If desired in the future we can make the default
configurable. Kconfig, mount option, what have you. cgroup.pressure
will work fine as a name regardless of what the default is.

Re 2: Not all consumers of the pressure metrics create trigger. I
would argue that few do. So it isn't the best signal to decide on
whether aggregation should occur. And yes, it's further complicated by
the triggers being written to the very pressure files. If we don't
hide them, we have to come up with another way to mark them as stale,
lest they confuse the heck out of users. Without breaking format...

So IMO, default-enable, "cgroup.pressure" as a name, and hiding the
pressure files should be good for now while allowing to make the
default configurable down the line.
