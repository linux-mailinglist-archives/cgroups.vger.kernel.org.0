Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E645F5F59CC
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 20:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJESWd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 14:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJESWa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 14:22:30 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D257FF9E
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 11:22:29 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso3423538pjq.1
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kOunpUwcD5B3LDxquXvMevQ7y8E8fEOG4N0wZf8Bfk=;
        b=WpMwCgvgGsA0PuBsnwhYNtJ0CK98v4OtYMf88jz1gMNhlOCoJTZkzylvAsRYIFsECA
         moN8UIUNqopRtKF76bR2MQaZRo0AKL/m7neTmV/WJeyFe9i/sUGa9JMaAtDuNR/q+P1Y
         lrkxNcDnYdeF5DiFn7bvBC0lZpQbOGQ63z6xl7UuLV/LUJZUdSlE3s7yOih61aXEcGLO
         knTvvOAPH9/7p8jMvcn1wEMMlvTGN7iFuojaVGOMyvXFWoVvwlvKyKMWnnn8TM9ySBGd
         MyaIj7a82TPsH/h5af28QagxWU3CuwJoEx3GDOcNX8riHVd/ej6F9gnMKslv9VO8TT/T
         3OVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kOunpUwcD5B3LDxquXvMevQ7y8E8fEOG4N0wZf8Bfk=;
        b=kZi/TnxaWR59GA5kSx91oi4VFqr9hCH7TuXYofCg8X5WZWE7oc9hV2B8In8unpGb53
         9J6NBSsKPDEknYAKD3UfhMq1RqhrmYxWq0eYet5nIoM5yuDH5/C0NaHtRfXgT5OLRTxs
         aXKqqJzGuEArkF2URkULASuvzvuc80MIz7jCRu8kDKFkQP7nwLPHxcmFJMOYIj7Q5Fb3
         uyTgjkpC+S41Q9EjF7PjHUAKQ5Zxsse/kD3LUjVGpj/vXRv2g99qkFpdkG3DdtE6+cS8
         rt1mu0DB/TWF1dJ53opMvWzYA5BaGTfBZjoDFshPPLGhXQsfjtqPR6rxaAURWEHy27m9
         jgWA==
X-Gm-Message-State: ACrzQf0sIn/oTIV0FPHYOOpsdWterZ/TX0zh8YCeHVaWwc+M7j0mQW8F
        1zWwh6Hhr15HZ7rsoBsQSrQ=
X-Google-Smtp-Source: AMsMyM4YyitnMq+UVEGMY49eaAawysEwKS8u2EvRmUfqBnw8GZqWEmldTX6QcsACNpEDPEOFrSQZ7g==
X-Received: by 2002:a17:90b:f02:b0:20a:9965:eeee with SMTP id br2-20020a17090b0f0200b0020a9965eeeemr1006936pjb.182.1664994148322;
        Wed, 05 Oct 2022 11:22:28 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0017f8edd3d8asm53290pll.177.2022.10.05.11.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:22:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 5 Oct 2022 08:22:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [RFC] memcg rstat flushing optimization
Message-ID: <Yz3LYoxhvGW/b9yz@slm.duckdns.org>
References: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
 <Yz2xDq0jo1WZNblz@slm.duckdns.org>
 <CAJD7tkawcrpmacguvyWVK952KtD-tP+wc2peHEjyMHesdM1o0Q@mail.gmail.com>
 <Yz3CH7caP7H/C3gL@slm.duckdns.org>
 <CAJD7tkY8gNNaPneAVFDYcWN9irUvE4ZFW=Hv=5898cWFG1p7rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkY8gNNaPneAVFDYcWN9irUvE4ZFW=Hv=5898cWFG1p7rg@mail.gmail.com>
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

On Wed, Oct 05, 2022 at 11:02:23AM -0700, Yosry Ahmed wrote:
> > I was thinking more that being done inside the flush function.
> 
> I think the flush function already does that in some sense if
> might_sleep is true, right? The problem here is that we are using

Oh I forgot about that. Right.

...
> I took a couple of crashed machines kdumps and ran a script to
> traverse updated memcgs and check how many cpus have updates and how
> many updates are there on each cpu. I found that on average only a
> couple of stats are updated per-cpu per-cgroup, and less than 25% of
> cpus (but this is on a large machine, I expect the number to go higher
> on smaller machines). Which is why I suggested a bitmask. I understand
> though that this depends on whatever workloads were running on those
> machines, and that in case where most stats are updated the bitmask
> will actually make things slightly worse.

One worry I have about selective flushing is that it's only gonna improve
things by some multiples while we can reasonably increase the problem size
by orders of magnitude.

The only real ways out I can think of are:

* Implement a periodic flusher which keeps the stats needed in irqsafe path
  acceptably uptodate to avoid flushing with irq disabled. We can make this
  adaptive too - no reason to do all this if the number to flush isn't huge.

* Shift some work to the updaters. e.g. in many cases, propagating per-cpu
  updates a couple levels up from update path will significantly reduce the
  fanouts and thus the number of entries which need to be flushed later. It
  does add on-going overhead, so it prolly should adaptive or configurable,
  hopefully the former.

Thanks.

-- 
tejun
