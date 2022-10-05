Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3322B5F592F
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 19:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJERnA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiJERm6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 13:42:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FB2357F5
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 10:42:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b2so11112349plc.7
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rH6mIZfviwrycSmWdDaZAhXLCNY90027cxpX58MWWN4=;
        b=e+UiZaH7mX/rn0iDl2OGvojLjy1qpQQPt9uPJFVFT4kf60gWjlXFYLj34i23DMavAr
         BLndmyJyLVDXkKAxOK8h0A4Nle8Yxzo41yeII4R+bOLzRFK0WIa+pfDMCWnNOLsQ5XO6
         v2JY9sofXArGDOkK1ieQgGOqeDIPdG2f2o5rkt9E+rj1VQGRqKIBIZbkYveYHcRbQ3wB
         OmaUnNsYE7BwrFxCV2SyMa0nVXkcArpG+OvQCquJp8bQNq20rwhEAxBikni7cLDM9AED
         UewhKYeF+Z4GVxwlf5RiROYfcMWw0iPaYs2aO43v2hBVlWa89OnbnsboZUTb8XwP1tFh
         ulAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rH6mIZfviwrycSmWdDaZAhXLCNY90027cxpX58MWWN4=;
        b=yFz9P7AkuKuhOfX7L4B3ZorJ1s8f+elW8y/bRTAvTqZnLOAB7PRfQOUNcIniV9ZJh7
         buejDe2hqtCzEYanD8ETfONH/T8HO/xciMyH7bQSEmaWNzBQwT74hFhpBW7SzllKsRoh
         iQSI6HG4o/fTDZUW8PlnCW8o5Haf2QsnZPwDtZC122ahgMOfEiegE4GBHxdgl31GD1x4
         d2Bv/5f9IQuIWKYpaFyDkc8wJVz2c1hDjQtVZ457hSJyFNRg4zb1QZoMYXYwdJdcir2k
         arSKmafLSNJah1MW/SaNZNT2vI+r98nisfPzgjpns5daW2V+afx2sUJcppz6D8T8ikJ9
         KN1w==
X-Gm-Message-State: ACrzQf1EKDdsq17EB2Cv0US66pAquAxLzPPEBsZSWDYf/Y8rzUPhJxLj
        sAClV01bt9C76Lkywuslss0=
X-Google-Smtp-Source: AMsMyM4LkYUXkvDJmdP7ShXaaHp4Ct4phsnoAhJ0/6hE9qpU+pcbCMzQByMQEnHAtdiNT0RVUjCwgw==
X-Received: by 2002:a17:90b:3803:b0:203:a31c:e2e9 with SMTP id mq3-20020a17090b380300b00203a31ce2e9mr837406pjb.13.1664991777529;
        Wed, 05 Oct 2022 10:42:57 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id gd10-20020a17090b0fca00b0020ad53b5883sm1452528pjb.14.2022.10.05.10.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:42:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 5 Oct 2022 07:42:55 -1000
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
Message-ID: <Yz3CH7caP7H/C3gL@slm.duckdns.org>
References: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
 <Yz2xDq0jo1WZNblz@slm.duckdns.org>
 <CAJD7tkawcrpmacguvyWVK952KtD-tP+wc2peHEjyMHesdM1o0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkawcrpmacguvyWVK952KtD-tP+wc2peHEjyMHesdM1o0Q@mail.gmail.com>
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

On Wed, Oct 05, 2022 at 10:20:54AM -0700, Yosry Ahmed wrote:
> > How long were the stalls? Given that rstats are usually flushed by its
> 
> I think 10 seconds while interrupts are disabled is what we need for a
> hard lockup, right?

Oh man, that's a long while. I'd really like to learn more about the
numbers. How many cgroups are being flushed across how many CPUs?

> IIUC you mean that the caller of cgroup_rstat_flush() can call a
> different variant that only flushes a part of the rstat tree then
> returns, and the caller makes several calls interleaved by re-enabling
> irq, right? Because the flushing code seems to already do this
> internally if the non irqsafe version is used.

I was thinking more that being done inside the flush function.

> I think this might be tricky. In this case the path that caused the
> lockup was memcg_check_events()->mem_cgroup_threshold()->__mem_cgroup_threshold()->mem_cgroup_usage()->mem_cgroup_flush_stats().
> Interrupts are disabled by callers of memcg_check_events(), but the
> rstat flush call is made much deeper in the call stack. Whoever is
> disabling interrupts doesn't have access to pause/resume flushing.

Hmm.... yeah I guess it's worthwhile to experiment with selective flushing
for specific paths. That said, we'd still need to address the whole flush
taking long too.

> There are also other code paths that used to use
> cgroup_rstat_flush_irqsafe() directly before mem_cgroup_flush_stats()
> was introduced like mem_cgroup_wb_stats() [1].
> 
> This is why I suggested a selective flushing variant of
> cgroup_rstat_flush_irqsafe(), so that flushers that need irq disabled
> have the ability to only flush a subset of the stats to avoid long
> stalls if possible.

I have nothing against selective flushing but it's not a free thing to do
both in terms of complexity and runtime overhead, so let's get some numbers
on how much time is spent where.

Thanks.

-- 
tejun
