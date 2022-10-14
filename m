Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A67C5FEEA3
	for <lists+cgroups@lfdr.de>; Fri, 14 Oct 2022 15:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJNNa7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Oct 2022 09:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJNNa6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Oct 2022 09:30:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D429CA9;
        Fri, 14 Oct 2022 06:30:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77F2FB822E8;
        Fri, 14 Oct 2022 13:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F84BC433C1;
        Fri, 14 Oct 2022 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665754255;
        bh=mINcMLnVsgheBTTRF+mKEseQpUsGdZeG1g0fkhbY1s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5k0CxXma58+OUFwamCyShctCfhZ4boPFlcTKXUDVo4dAsKnwDpkQJDIftCIIEgOw
         SUYYg38JNhtp85t0DPyanIjStUgYbL9bPCykHcwPItgz04Uj68xFIHpd8omJTGvd6R
         8dIBeSS9Du1WD4R8RpxsSs7pbRhh4Qw42iZsqRIFGq8CJkhpPpsmeA61h60IGsb4wZ
         HS6W++YWokOJ6lty9mMD5VbBuaX+IYVtn/VjkLfaQvpYsmNqIcDCgIREgAwiGM68l6
         YPiwN/0brn4bBo7l2WtuYSNF3tdtoGSv4oJe4yZU3bZCdOgLwRe/qAaMA86wiiaLo/
         z+VMAbtM9OfQQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A423C4062C; Fri, 14 Oct 2022 10:30:52 -0300 (-03)
Date:   Fri, 14 Oct 2022 10:30:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2] perf stat: Support old kernels for bperf cgroup
 counting
Message-ID: <Y0lkjJLfZNXQNYxR@kernel.org>
References: <Y0Sx2KWX4gPlLytq@slm.duckdns.org>
 <20221011052808.282394-1-namhyung@kernel.org>
 <Y0Wfl88objrECjSo@slm.duckdns.org>
 <Y0ljzN920sWalEHR@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0ljzN920sWalEHR@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Em Fri, Oct 14, 2022 at 10:27:40AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Oct 11, 2022 at 06:53:43AM -1000, Tejun Heo escreveu:
> > On Mon, Oct 10, 2022 at 10:28:08PM -0700, Namhyung Kim wrote:
> > > The recent change in the cgroup will break the backward compatiblity in
> > > the BPF program.  It should support both old and new kernels using BPF
> > > CO-RE technique.
> 
> > > Like the task_struct->__state handling in the offcpu analysis, we can
> > > check the field name in the cgroup struct.
>  
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>  
> > Applied to cgroup/for-6.1-fixes.
> 
> Hey, I noticed that the perf build is broken for the
> tools/perf/util/bpf_skel/bperf_cgroup.bpf.c skell, so I tried using b4
> on this Namhyung patch, it ended up getting a newer version, by Tejun,
> that mixes up kernel code and tooling, which, when I tried to apply
> upstream didn't work.
> 
> Please try not to mix up kernel and tools/ changes in the same patch to
> avoid these issues.
> 
> Also when changing tools/perf, please CC me.
> 
> I'm now back trying to apply v2 of this patch to see if it fixes my
> build.

Yeah, applying just Namhyung's v2 patch gets perf back building, I'll
keep it there while processing the other patches so that I can test them
all together.

- Arnaldo
