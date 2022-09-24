Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4325E87EC
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 05:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiIXDW6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 23:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiIXDWz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 23:22:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B21C120BEB;
        Fri, 23 Sep 2022 20:22:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c7so1842825pgt.11;
        Fri, 23 Sep 2022 20:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=pVZ/vufAufJqpHyXPbOtKj2Be+zfIdhN74kmWcGVahk=;
        b=MDlwjG16Co36ivQru9yTmqGAh8rRKn57/5yL7cl6/Y4KJK6KlPGTOSgnHKufNpTyTJ
         HF5+9/Z9psnwV/TYIRz/lPeiWCNFTZw855a8Iatejwa1KbFJAHciym7KrtWwGG26cNtY
         PI/gg4xkwmVdcKyQYpPyI4tSlUHbMk09fG4urMx6Re4sEiTKYhrGZECV1fvWiphnkhZm
         H+pGIlsXbC8b5GmdnHLAT+PzIbOjlqYq8fLlS67nIxlM88VwXqBLAIG3ETpkei8oLi2o
         vuKEnO5bqgThdWimNby2WYiK3CYiXc6sWGoV9N2dre373lqDLVb57wP5LhEn21nD1pBL
         8sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pVZ/vufAufJqpHyXPbOtKj2Be+zfIdhN74kmWcGVahk=;
        b=Si2U3zoRZqS7qN4MISwqIITqIZYu07BsnXOm8BOcG3sHxI4mWNHQLGVQG2k28cE+hf
         oZK9LGpume4F3dtMY8ejov1PW9mtcO60FcwHPKh2DCgvYYSg87z1bluw4dD8HnGCNCCF
         wNoHZSaq3s4HoTyW32KSaafha947trvQijWnTXbNeBLHV+NwuSQ/dVcPyCY1w6lMqE66
         nQ2A6V5w9Ne2jcBZIqfuLMHy9mqPoO4kTTVywGXUI5fuh+IV6XwexnwAFLd3TwxxLnjI
         LGWefKWKmkGMdicJP+0oE6jVpJO1XrGvMyHTprnv262RDds08Og8ZywpNFSpL4Z8/7bM
         GmQQ==
X-Gm-Message-State: ACrzQf2gXIb/waGTp4OyXzL+UUJMMJffsowLuV6M3s+KX3Yed3en1dr2
        6Seb8blgMOjXeI9j4n+y348=
X-Google-Smtp-Source: AMsMyM6X+wN7/ZBRv0sTQmop149LiBp1WYBiaO2r2ePMExDhqoSB4rvpsaaYTdFLfg6NoqVsR7jz2g==
X-Received: by 2002:a05:6a00:bea:b0:53e:d0c0:faed with SMTP id x42-20020a056a000bea00b0053ed0c0faedmr12294958pfu.30.1663989773546;
        Fri, 23 Sep 2022 20:22:53 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902da8a00b0016ef87334aesm6860953plx.162.2022.09.23.20.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 20:22:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Sep 2022 17:22:51 -1000
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
Message-ID: <Yy54CwK84JY/o+Ci@slm.duckdns.org>
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
> ---
> Arnaldo, I think this should go through the cgroup tree since it depends
> on the earlier change there.  I don't think it'd conflict with other
> perf changes but please let me know if you see any trouble, thanks!

FWIW, looks fine to me and I'd be happy to route this through the cgroup
tree once it gets acked.

Thanks.

-- 
tejun
