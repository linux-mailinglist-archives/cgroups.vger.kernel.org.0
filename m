Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A375FA8D2
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 01:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJJX7r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 19:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiJJX7d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 19:59:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33DF7FFA0;
        Mon, 10 Oct 2022 16:59:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 70so11042968pjo.4;
        Mon, 10 Oct 2022 16:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XATmXDDouGmZ8eVmg2gOICME3agw6HNrb3TQMDuvm/4=;
        b=AS5j0WakWcXloGTMkDVqd2Cneha7BIrjvG2XXT41mxwinS7nhAdmQDYDl1IzutSN7N
         GtfRRcfzd/xXbKbIdHhfHCn7qpzNdjU25NUUUIt8Lj2MXVutYNCUSLZczrKNSg7HShqK
         G+LNdMzkSzzqM2Tl1x5FWduRvauGP8dZvRrRveXpg9Iv9KPDRJID+v0C8uufmRDysenO
         7AB7VUpvwZQibh3eFsy3F4vSq9HU8M+WE4BnUTlc/ZJpGSmRtHMdsfNXIFkmygCi03+G
         UlASbuOBE7FXyQhJNlcCOZIYSvSritHqCB5kuLO4I2L4te6Ox7aSJyuxic4Kwee29AwF
         Qfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XATmXDDouGmZ8eVmg2gOICME3agw6HNrb3TQMDuvm/4=;
        b=YzC9UbzCGS1M10wGcBPzpbacrVzCBXQxFQhtGRwWKEnHKF/SbCzaiLU6uEDVHY9tc+
         X3ucV1OxiOxJzpOdQr0j7EuudeeZc2WeFHWn5owhHEMPkjdHUQQ5mu9H2IHSaM3Fq5hM
         AQFurdZnW9m/CIZ5V/CB+tsRcD1wJVDV11L6tO0dqStsV7OW79huR+PJhzOoNwWnvWKv
         ODWibtyb9XQWpD62KTWt8doGIjer50Bs6U4l4FXdN+CQDJvMbnX9Xs1rrFLz5Ep+e33g
         b8kRbozselQtltWKrO5j1JR2yxyB/9YMUPfeYJhWwFlbMtex5tSRtXnB+gYem93bLZfk
         ivKQ==
X-Gm-Message-State: ACrzQf1pa/MQOQqWLkw6n10NFstqbaX6zkRdPvp97GI1TYqQODuJDhaN
        4IdsUs1+YmYsIoICCJJUVDI=
X-Google-Smtp-Source: AMsMyM55f6qfG3GKGkE8TBhQ7GPkPeadXYHc9TiiKUZFs2qxbbAURTiSOOoDjD0fLcDWjglf0PH1/Q==
X-Received: by 2002:a17:902:d2cc:b0:182:d901:5d28 with SMTP id n12-20020a170902d2cc00b00182d9015d28mr5580837plc.142.1665446361746;
        Mon, 10 Oct 2022 16:59:21 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902f38d00b00172fc5b0764sm7111255ple.270.2022.10.10.16.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 16:59:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 13:59:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
Message-ID: <Y0Sx2KWX4gPlLytq@slm.duckdns.org>
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
 <20220922041435.709119-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922041435.709119-1-namhyung@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 21, 2022 at 09:14:35PM -0700, Namhyung Kim wrote:
> The recent change in the cgroup will break the backward compatiblity in
> the BPF program.  It should support both old and new kernels using BPF
> CO-RE technique.
> 
> Like the task_struct->__state handling in the offcpu analysis, we can
> check the field name in the cgroup struct.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Looks like it's acked enough but the patch doesn't apply anymore. Namhyung,
can you please refresh the patch? I'll route this through
cgroup/for-6.1-fixes unless somebody objects.

Thanks.

-- 
tejun
