Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C555F1546
	for <lists+cgroups@lfdr.de>; Fri, 30 Sep 2022 23:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiI3V4y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 17:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiI3V4x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 17:56:53 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42546114028;
        Fri, 30 Sep 2022 14:56:52 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-131b7bb5077so6966537fac.2;
        Fri, 30 Sep 2022 14:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SHZXv7fnk7yZA/aI9ZkjN8+8GPWTiYo1+x7IglxTMXc=;
        b=4yXfcXMDRyTJdYMf/i/yc79kyTxCsr5194UsLv/YwsWhhMwgAbw9nbUSGNfiefbg7j
         5halYyabDgNLs9Dfi8t5pw5ArmjjY+kfpvVY8X6IxUCgU2NxwkJx+A6UnBhVIfpfTChi
         4boCj6n27TWv+bFeF3f+j8x85gfZphDNLL+2B07Nwxd6ZSs4bKrCIvo1OHWskX5XIQ/u
         EouLsU12WEK4tTzqY1pTRh2SNHkWbcnqKhnnTZZ15RfYxERi4lUCNaUMhUJeV8I4t69B
         yJBJsnB1YhVphtpndgx7DSTfk9Mf44MnnwVd14M+wkXOEwdI3c1RPI6PKzGzL8Oy20CW
         sG2g==
X-Gm-Message-State: ACrzQf3d8oHrsH7fhSMUNJoOPIVGtWofPr2L1XwUZI3SBy2YKF/05X25
        1NNoNNoFGvFQ1pYdD3yDCWa5WbZB305fcp2PpY4=
X-Google-Smtp-Source: AMsMyM75drO3gcy+t7avN5r18ykI66HfMQXRgkh0JqaWPcknj+S5Jnu4CvHcDjhQeiZoU1Psdpv5nFHY8wFCY+52bQ8=
X-Received: by 2002:a05:6871:14f:b0:131:a644:7c58 with SMTP id
 z15-20020a056871014f00b00131a6447c58mr116486oab.209.1664575011561; Fri, 30
 Sep 2022 14:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
 <20220922041435.709119-1-namhyung@kernel.org> <YzdjHenrJpooKMjv@krava>
In-Reply-To: <YzdjHenrJpooKMjv@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Sep 2022 14:56:40 -0700
Message-ID: <CAM9d7cjKaZvWQUwGwoTLNzAgHS7ndL_V_5+O+WqMUvuHJ7cWNg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jiri,

On Fri, Sep 30, 2022 at 2:44 PM Jiri Olsa <olsajiri@gmail.com> wrote:
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
> could you please paste the cgroup tree link?

Do you mean this?

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git

Thanks,.
Namhyung
