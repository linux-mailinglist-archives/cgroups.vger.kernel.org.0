Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F12A66B29D
	for <lists+cgroups@lfdr.de>; Sun, 15 Jan 2023 17:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjAOQlx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 15 Jan 2023 11:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjAOQlw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 15 Jan 2023 11:41:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660D9030
        for <cgroups@vger.kernel.org>; Sun, 15 Jan 2023 08:41:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so949983wmb.0
        for <cgroups@vger.kernel.org>; Sun, 15 Jan 2023 08:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wyXeq2MEr1J+e0QY6nAt4hvGGGXhRFe/SJyt1uQjd+M=;
        b=HVKsp/vf0AVRuU856/IGt6skrRZgxXhP5I4Y/qoLNwpTmzYThPiVRxsVlvJJmA2Hg8
         tV7IHYq1EnC+YIpW7nqTWWsd259d0i6s++jbssfomjbxGF0jqnK5YIE9DH/SkAO3JLxM
         uS3s6sDNNElol4/q/sxBwK4HKwEwolb4mt0ZDnNTvQYzoD6hXCHFYV8wQWFiWwjYg7Rl
         uoYg9AkFXmyKNC4d7x4HjFxlkLF43etPXh1w5UD9EU9MiBBJ1CV7f6PikjHHNpIaCbMk
         Hgh+DGvyf19Jvt03Vhtv6xgnvLiGGsToOPXr97ilY6D6nQjhYAwKouUCVxcIeq3VXDwf
         A3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyXeq2MEr1J+e0QY6nAt4hvGGGXhRFe/SJyt1uQjd+M=;
        b=Ae5Bp5o0tEezOXliekTe5iEb7Iy/WkecPvyVccKrbUxTf6ytauRjmYM5GmAByIsIYb
         a8I29E/Nzsa9yqNZTP2hfmcCfEGJ9g9sRfywvQNPbnVn8cCZ0BLPxSAqaP6rrQJDqVQk
         C5jeN7wU+OwP1TX4mQ+9a8opMiZ2nDIlljNM6dDXi096o8OTypm+OJlOWI2QbbzmLD1H
         T4hKCGYgkktQzL1kt+kKxs99u5fkomf63Idj0jI2pxB3/aahoqxF65jRTbXP9tYJiZyL
         pj19ZXbtUxssxNHjVNv4I1VnkhO0xcRBOtd9pc8z3mHT1xRJ1UM6C4XootjjuxpI3rk+
         J3WA==
X-Gm-Message-State: AFqh2kq5AeP8Xm22beLFZW0KpHNb7dcNMQ8gjCBy/XkMIvkGHFOWg0xj
        m5O5mPuUVidngyK06Ym9GavP/w==
X-Google-Smtp-Source: AMrXdXuLY36cyQqAcwRVTO690f1UhyNmBsCwlXmkS44xRrGENHV8GwdmqHv1oESJrNIujBaVma3e0A==
X-Received: by 2002:a05:600c:34d3:b0:3c6:e61e:ae74 with SMTP id d19-20020a05600c34d300b003c6e61eae74mr76812959wmq.4.1673800910197;
        Sun, 15 Jan 2023 08:41:50 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003d9dee823a3sm34029777wmq.5.2023.01.15.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 08:41:49 -0800 (PST)
Date:   Sun, 15 Jan 2023 16:41:48 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20230115164148.lnoqfpg7em334ts3@airbuntu>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-4-juri.lelli@redhat.com>
 <20221216233501.gh6m75e7s66dmjgo@airbuntu>
 <CAKfTPtA0M5XOP4UdkFeSNen98e842OfKTBDOt0r-y_TD4w54jw@mail.gmail.com>
 <20221220114309.coi2o4ewosgouy6o@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221220114309.coi2o4ewosgouy6o@airbuntu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/20/22 11:43, Qais Yousef wrote:
> On 12/19/22 09:07, Vincent Guittot wrote:
> > On Sat, 17 Dec 2022 at 00:35, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > Hi
> > >
> > > On 07/19/19 15:59, Juri Lelli wrote:
> > > > When the topology of root domains is modified by CPUset or CPUhotplug
> > > > operations information about the current deadline bandwidth held in the
> > > > root domain is lost.
> > > >
> > > > This patch addresses the issue by recalculating the lost deadline
> > > > bandwidth information by circling through the deadline tasks held in
> > > > CPUsets and adding their current load to the root domain they are
> > > > associated with.
> > > >
> > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > > > ---
> > >
> > > We see that rebuild_root_domain() can take 10+ ms (I get a max of 20ms quite
> > > consistently) on suspend/resume.
> > >
> > > Do we actually need to rebuild_root_domain() if we're going through
> > > a suspend/resume cycle?
> > 
> > During suspend to ram, there are cpus hotplug operation but If you use
> > suspend to idle, you will skip cpus hotplug operation and its
> > associated rebuild.
> 
> Thanks Vincent. I'll check on that - but if we want to keep suspend to ram?
> Do we really to incur this hit?

Using s2idle is not an option actually. I'll prepare v2 to address Waiman
comment if I don't get more feedback in the next few days.


Thanks!

--
Qais Yousef
