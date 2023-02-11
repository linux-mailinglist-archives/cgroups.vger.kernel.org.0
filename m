Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4E9692EF7
	for <lists+cgroups@lfdr.de>; Sat, 11 Feb 2023 08:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBKHKV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 11 Feb 2023 02:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKHKV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 11 Feb 2023 02:10:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17E532CF6;
        Fri, 10 Feb 2023 23:10:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 522C860A4A;
        Sat, 11 Feb 2023 07:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A665C433D2;
        Sat, 11 Feb 2023 07:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676099418;
        bh=IYS1UXEO949wArIgsINV5rvcHrLkfM5cJb+SmCbKbNQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=umY86AB+wKf1J1/6UxDpMDn9AlI7GSQ3rBUJM7bEi9PlHfypfObSTswAiVI5/TEXw
         9mAbkPULSOM3rHA1GDLSyNXB+/KUyS1LvHZ/MlsXOQPYLyrBq6zw7f/laBFFMO18yu
         mPn39/vQRRbMnWu1vJyihtpBHnq4AZuxn2E/O6s4uPftzgS/QhqiCOeV211rrzVEzE
         essChqKwfnA2gfwrXgA+naR41bkJf7U+qu0j3KbVg5LDgDWHubjAips6gFE5GTlZiw
         MornHY3KRSrrokdDqguozFg6+whdbnMwYm8OfBT1KO06/d1kLyJfRHiWS9VVEaY5W+
         8hbUNrLEA02zA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BEF3E55F00;
        Sat, 11 Feb 2023 07:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] bpf, mm: introduce cgroup.memory=nobpf 
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167609941850.20060.1828725334029145544.git-patchwork-notify@kernel.org>
Date:   Sat, 11 Feb 2023 07:10:18 +0000
References: <20230210154734.4416-1-laoar.shao@gmail.com>
In-Reply-To: <20230210154734.4416-1-laoar.shao@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 10 Feb 2023 15:47:30 +0000 you wrote:
> The bpf memory accouting has some known problems in contianer
> environment,
> 
> - The container memory usage is not consistent if there's pinned bpf
>   program
>   After the container restart, the leftover bpf programs won't account
>   to the new generation, so the memory usage of the container is not
>   consistent. This issue can be resolved by introducing selectable
>   memcg, but we don't have an agreement on the solution yet. See also
>   the discussions at https://lwn.net/Articles/905150/ .
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] mm: memcontrol: add new kernel parameter cgroup.memory=nobpf
    https://git.kernel.org/bpf/bpf-next/c/b6c1a8af5b1e
  - [bpf-next,v2,2/4] bpf: use bpf_map_kvcalloc in bpf_local_storage
    https://git.kernel.org/bpf/bpf-next/c/ddef81b5fd1d
  - [bpf-next,v2,3/4] bpf: allow to disable bpf map memory accounting
    https://git.kernel.org/bpf/bpf-next/c/ee53cbfb1ebf
  - [bpf-next,v2,4/4] bpf: allow to disable bpf prog memory accounting
    https://git.kernel.org/bpf/bpf-next/c/bf3965082491

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


