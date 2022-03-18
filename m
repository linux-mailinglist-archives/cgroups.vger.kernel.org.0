Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA1D4DE20F
	for <lists+cgroups@lfdr.de>; Fri, 18 Mar 2022 21:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiCRUAq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Mar 2022 16:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiCRUAq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Mar 2022 16:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B4A18A781;
        Fri, 18 Mar 2022 12:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B202161BBE;
        Fri, 18 Mar 2022 19:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20528C340ED;
        Fri, 18 Mar 2022 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647633566;
        bh=Q/AneTN6VK0FKM8VUMmAL24sxlKXjApD+7URsOBBLys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fzwYuq1QWgluY2rLULh5F1cIB7CH4nKOrZPexeaBZc3eqdzDEUv+4hdZPHE/gD7lm
         AAWg2sHe+IiUwHYpGjhmmFn5/PJ2zjgbwMhfdLGS2H4SxfTP4N/NOfvFRAMnW8VWFy
         yimWypwcTTA3MjnqBAZ/RlnvhG/U3n37aFDxPygWEA81gV6QKBLBs2RYCQF9DB2v91
         DGKG6Ks4/cjqlRTweaFd53BWPIsYf+32FeAKYmVzVF6K4w3tUr6MFX6ZQbUEMbqBe0
         bYnXIIXo0to0tqAWBxdDupDHEA7/xxy6GoWnuMHPSl0tcZIz3z+LTQEt8ewmEK/H4d
         SXiYQbiRZVVrg==
Received: by mail-yb1-f180.google.com with SMTP id u3so17696238ybh.5;
        Fri, 18 Mar 2022 12:59:26 -0700 (PDT)
X-Gm-Message-State: AOAM5321N2kEUImHsjIIlhCLyT0v2iFyKwOpHVtd/d16IRIdwkLMSbPQ
        VKIR+9JM4cQxxSjYBhZPfi7wei/sIflAx2Rfc5A=
X-Google-Smtp-Source: ABdhPJz60lYU2HlnD1hDpuqy9kgjbRFCqrqnEE+OGFeSw2OQ9ikRZ7G7LryM455CYwDhOylz4jvJGp735eCzAMh/9ms=
X-Received: by 2002:a25:40d3:0:b0:633:bb21:2860 with SMTP id
 n202-20020a2540d3000000b00633bb212860mr4386656yba.9.1647633565201; Fri, 18
 Mar 2022 12:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
In-Reply-To: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 18 Mar 2022 12:59:14 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6QTaCVekkT8Ah0N2K4JY7yiiO2wZjk6pVKuraEqjkoXQ@mail.gmail.com>
Message-ID: <CAPhsuW6QTaCVekkT8Ah0N2K4JY7yiiO2wZjk6pVKuraEqjkoXQ@mail.gmail.com>
Subject: Re: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
To:     Yosry Ahmed <yosryahmed@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 9, 2022 at 12:27 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> Hey everyone,
>
> I would like to discuss an idea to facilitate collection of
> hierarchical cgroup stats using BPF programs. We want to provide a
> simple interface for BPF programs to collect hierarchical cgroup stats
> and integrate with the existing rstat aggregation mechanism in the
> kernel. The most prominent use case is the ability to extend memcg
> stats (and histograms) by BPF programs.
>

+ Namhyung,

I forgot to mention this in the office hour. The aggregation efficiency
problem is actually similar to Namhyung's work to use BPF programs
to aggregate perf counters. Check:
     tools/perf/util/bpf_skel/bperf_cgroup.bpf.c

Namhyung's solution is to walk up the cgroup tree on cgroup switch
events. This may not be as efficient as rstat flush logic, but I think it
is good enough for many use cases (unless the cgroup tree is very
deep). It also demonstrates how we can implement some cgroup
logic in BPF.

I hope this helps.

Thanks,
Song

[...]
