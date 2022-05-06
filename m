Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0B651DB84
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352071AbiEFPJK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 11:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346922AbiEFPIz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 11:08:55 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5000B6D181
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 08:05:12 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f4so8332863iov.2
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2LpI0DImiuDC2UzRqfJHQ2qAza8P08IbEZJSnDfETww=;
        b=C3DmY9zqQpuSybTFOak9V+J6u4wDYDHiArS7riORo4yB6KdqsWLxhsWFUXdp5Zs75r
         KlULlrzTb6vVdS+TmD/jo/bV8PW3aZ5GW7HeytlG87S0bd1BJT21JxJdPWnjs0hSF3SU
         zV/hZEYf+9AtoPpN49UXruQAhUzGe606FESKKBMPigXxbhAw9OFDNrCDZXxjxGJZYD/A
         VBaa9IqZP05rI4wxT6MUkVDoNQOipok6hfIKKdi9UVogn/sEkGZSRfzgP16cJnQki1Il
         D8XmaVr2p3CeL/fFfwnlhIqGTkcSaaLAssco5zlEM4tyNawoaqQiJXtR6lcRyYHVaZPU
         +lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LpI0DImiuDC2UzRqfJHQ2qAza8P08IbEZJSnDfETww=;
        b=q36u5l1PIkr9RvnfJHVX9jb9z0Pf7fwE9dfelv6I7QHMb6weJfQxdRQnVa/6b44u2X
         fMhbAtuY+NtKk/iN2y5ZSCS84e+g3fqZVufk35+mdzCRy00Of2bep5Ir08Y4GfEJ5wAn
         ZGRf7k3HmmY2spTYHNRgD/67HdHNo84ivwlUalEgJhap4kvUCFY0F60st/5/u/ZjiFKb
         ngDVSvhuUrnnAoD3otjvhylJWBiMK/u+9dXVeIurcqGH4S4tH33+F7HFG2mJlVS0eoE6
         mwv4vea+1syFeJXrlrVFK+cWnOPsB14Bo2Sc8gJ6YMBkQinWQdXCVn4ZWDTcLVzKJ05m
         uCCg==
X-Gm-Message-State: AOAM532WAvlsqOjWTNobUdFik+nnEXO+VnCMsk1PRhwv5e8g+QpMkXTS
        UzJgJ4rRspOJRZPXpCqbrmawM65fv9Xd5B4K4cdWUO0kHKI=
X-Google-Smtp-Source: ABdhPJxeb79WtbUmSsuNP/GjVqnX8MbYvhajHJu6C3ecnqMNPy2jQSs2AQGuAJ8tlrZ+czv/9fyK+O6wejD/c8fhKsg=
X-Received: by 2002:a05:6638:140d:b0:32b:c643:e334 with SMTP id
 k13-20020a056638140d00b0032bc643e334mr1250057jad.125.1651849511454; Fri, 06
 May 2022 08:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220505121329.GA32827@us192.sjc.aristanetworks.com> <YnU3EuaWCKL5LZLy@cmpxchg.org>
In-Reply-To: <YnU3EuaWCKL5LZLy@cmpxchg.org>
From:   Ganesan Rajagopal <rganesan@arista.com>
Date:   Fri, 6 May 2022 20:34:34 +0530
Message-ID: <CAPD3tpEStjm02QXE=vpUKhttc3RroJ8LNdX7iBaAgCOpdcy8-A@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: Export memcg->watermark via sysfs for v2 memcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 6, 2022 at 8:27 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, May 05, 2022 at 05:13:30AM -0700, Ganesan Rajagopal wrote:
> > v1 memcg exports memcg->watermark as "memory.mem_usage_in_bytes" in
> > sysfs. This is missing for v2 memcg though "memory.current" is exported.
> > There is no other easy way of getting this information in Linux.
> > getrsuage() returns ru_maxrss but that's the max RSS of a single process
> > instead of the aggregated max RSS of all the processes. Hence, expose
> > memcg->watermark as "memory.watermark" for v2 memcg.
> >
> > Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
>
> This wasn't initially added to cgroup2 because its usefulness is very
> specific: it's (mostly) useless on limited cgroups, on long-running
> cgroups, and on cgroups that are recycled for multiple jobs. And I
> expect these categories apply to the majority of cgroup usecases.
>
> However, for the situation where you want to measure the footprint of
> a short-lived, unlimited one-off cgroup, there really is no good
> alternative. And it's a legitimate usecase. It doesn't cost much to
> maintain this info. So I think we should go ahead with this patch.
>
> But please add a blurb to Documentation/admin-guide/cgroup-v2.rst.

Thank you for the review. I'll refresh the patch with the documentation blurb.

Ganesan
