Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763545F13A8
	for <lists+cgroups@lfdr.de>; Fri, 30 Sep 2022 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiI3Uag (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 16:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiI3Uab (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 16:30:31 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70CF6C74B;
        Fri, 30 Sep 2022 13:30:30 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1318106fe2cso6702606fac.13;
        Fri, 30 Sep 2022 13:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ydbseSGCiGhWnegJ4/rTEcMK4rWRsSZqxah9FKyfgJM=;
        b=bIzkqsn4783z8j1qQkimP5fgaAXpv2k0/E/2AfnEZ+O2bp9W8/RAjI55CbD/WDGecD
         TTKsP3NWGwwf4CLkPC4+m90JRG7d416W+0NF/V7yBzST5z8Zb1toOQWGo+r2YMrim71I
         bqAnsZbI1dBKBaWDCOHOf85hOcJW1NGsKWgbyi71nVo+as7Uy0FTCcwJ2elm0EdWa6gR
         cA1MlrGCp0TBHvjaPNajXNoQYKz5fkDUTRX3MdJK36CmpCvWb5Ml7cGGyJk7tXaVxjSV
         C0ZLHt8iA+5FG6ESzoxSD2agE4tHNIUNvrektQwIpY+QtLn+EQViGgW83XnCVjyXWqXC
         nw9g==
X-Gm-Message-State: ACrzQf1t8UxW2+GDVcGjnviA6OLFSGfmYX2VqqKj2l+eUvbvx7C4MQAA
        8CgB/2rPxBl6yiVH9afEcHqAZqCTWqs6XEwbzaqZj80h
X-Google-Smtp-Source: AMsMyM7T6nr1BYvKp1AkuXZqHWeDItxN8pCYcfsR+CT6+Sgm6Sj6OPqdGn2ty4UfIFNxy+DduZb1q3ohlShJYoxUS80=
X-Received: by 2002:a05:6871:14f:b0:131:a644:7c58 with SMTP id
 z15-20020a056871014f00b00131a6447c58mr5957oab.209.1664569829912; Fri, 30 Sep
 2022 13:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
 <20220922041435.709119-1-namhyung@kernel.org> <Yy54CwK84JY/o+Ci@slm.duckdns.org>
In-Reply-To: <Yy54CwK84JY/o+Ci@slm.duckdns.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Sep 2022 13:30:18 -0700
Message-ID: <CAM9d7chMdGwxED8rt6-DWDCnRrbuNAJFFty3i5uqqeTBZJFzTA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
To:     Tejun Heo <tj@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 23, 2022 at 8:22 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 09:14:35PM -0700, Namhyung Kim wrote:
> > The recent change in the cgroup will break the backward compatiblity in
> > the BPF program.  It should support both old and new kernels using BPF
> > CO-RE technique.
> >
> > Like the task_struct->__state handling in the offcpu analysis, we can
> > check the field name in the cgroup struct.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > Arnaldo, I think this should go through the cgroup tree since it depends
> > on the earlier change there.  I don't think it'd conflict with other
> > perf changes but please let me know if you see any trouble, thanks!
>
> FWIW, looks fine to me and I'd be happy to route this through the cgroup
> tree once it gets acked.

Thanks Tejun!

Can any perf + bpf folks take a look?
