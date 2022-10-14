Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF6B5FEE94
	for <lists+cgroups@lfdr.de>; Fri, 14 Oct 2022 15:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJNN1q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Oct 2022 09:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJNN1p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Oct 2022 09:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E21B76F6;
        Fri, 14 Oct 2022 06:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9608D61B29;
        Fri, 14 Oct 2022 13:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD380C433C1;
        Fri, 14 Oct 2022 13:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665754063;
        bh=Mer19hBhh2VO610s7L+5FvRU6lA4fQAb3tmDtTWR/JQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSMyBkrDW0HP2yY/TqJk38iFPqW3PhdhSf8o4Ma1vvCup/yA3qpniqx3AoaGRow6f
         PFBot3CSD3KUgKSSltJrF0UJU9pDn1yZ0icuzKeKSjtXsqoPnRocW36KDXEvuYeZcq
         F/rcnbjXCNa3TB3QeOoGH8kbKp1tCjIW3ySbEJ/lkDW3OV0xYbB1AOIBY6evPI8Q0k
         1DKnN5nqTOL1ymnU6f91TW+u80krsokFzeZy7KDxIeWPFK5K7OOOmks9c/apQqcMKu
         b6DfBCG1ZTcyn4GZKM3SQVQq/paEGjX3hpP3hiWW4vGwvxBbU8ZaAsN6g/V1BWGtYS
         mTTupBSRKzoGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C07E4062C; Fri, 14 Oct 2022 10:27:40 -0300 (-03)
Date:   Fri, 14 Oct 2022 10:27:40 -0300
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
Message-ID: <Y0ljzN920sWalEHR@kernel.org>
References: <Y0Sx2KWX4gPlLytq@slm.duckdns.org>
 <20221011052808.282394-1-namhyung@kernel.org>
 <Y0Wfl88objrECjSo@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0Wfl88objrECjSo@slm.duckdns.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Em Tue, Oct 11, 2022 at 06:53:43AM -1000, Tejun Heo escreveu:
> On Mon, Oct 10, 2022 at 10:28:08PM -0700, Namhyung Kim wrote:
> > The recent change in the cgroup will break the backward compatiblity in
> > the BPF program.  It should support both old and new kernels using BPF
> > CO-RE technique.

> > Like the task_struct->__state handling in the offcpu analysis, we can
> > check the field name in the cgroup struct.
 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
 
> Applied to cgroup/for-6.1-fixes.

Hey, I noticed that the perf build is broken for the
tools/perf/util/bpf_skel/bperf_cgroup.bpf.c skell, so I tried using b4
on this Namhyung patch, it ended up getting a newer version, by Tejun,
that mixes up kernel code and tooling, which, when I tried to apply
upstream didn't work.

Please try not to mix up kernel and tools/ changes in the same patch to
avoid these issues.

Also when changing tools/perf, please CC me.

I'm now back trying to apply v2 of this patch to see if it fixes my
build.

Thanks,

- Arnaldo
