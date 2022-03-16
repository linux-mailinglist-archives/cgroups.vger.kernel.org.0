Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891074DAA4F
	for <lists+cgroups@lfdr.de>; Wed, 16 Mar 2022 07:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243672AbiCPGGX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Mar 2022 02:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiCPGGW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Mar 2022 02:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4538E2B27B;
        Tue, 15 Mar 2022 23:05:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF967617A5;
        Wed, 16 Mar 2022 06:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28635C340F2;
        Wed, 16 Mar 2022 06:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647410708;
        bh=9u56X5trjDPRUeXIbiXX2WgWMHiQeCwaMD920ZfRi8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kc/I2DRyrHvrgXU4oXkzFIkF9sFInZFOl+OfPblLYNxgfZbu4INP1YHZgxKSlgVTY
         jOZ+3aH9aLNfZLH8TSfxhdoz2+IRoL9KQWru0qiP3xt8Bd3N3XBDQF9mWN8KsDteTB
         SGwlr1EtPeo1r9XqiLJnBiZs2nysC41wMtI7VoOaN7BtI6CYW4DRuRoP/lp1vNfpKk
         yJccTxZdroLG7a8zFUBdTbVUgQQab2HUgS3gX5MTK0lCEGF/w6CYMEbG9rUmPOaAFL
         lP8OJpOfAbyNXEzqw5Mo2NzyRCY+rzAZzc3/39F0eaLDUWvFTEpHCClOPC+D0zjfnu
         UD4RFJxxNoc8Q==
Received: by mail-yb1-f176.google.com with SMTP id y142so2544674ybe.11;
        Tue, 15 Mar 2022 23:05:08 -0700 (PDT)
X-Gm-Message-State: AOAM531SyRVTG6sxsejTysWvHQQc+wlE1E5++NGONbwOf9A3IqnwHX7M
        MLsfZ/oAEEw4d1rZI9GwZwA5Bu5j9gDQQER05GI=
X-Google-Smtp-Source: ABdhPJwAyANThQc/psRngeReotj5/ZyxPDf+piaKRNAk+DtYgApdzmZEdzyAshMC7HoL0mJweq4RnHNoZOr+6dhyU0s=
X-Received: by 2002:a05:6902:1ca:b0:624:e2a1:2856 with SMTP id
 u10-20020a05690201ca00b00624e2a12856mr26465539ybh.389.1647410707221; Tue, 15
 Mar 2022 23:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
In-Reply-To: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 15 Mar 2022 23:04:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5qHSZNSEh8CQK3wYqtJ4XB+EwFEJWKA9SkA+wGFbvNCg@mail.gmail.com>
Message-ID: <CAPhsuW5qHSZNSEh8CQK3wYqtJ4XB+EwFEJWKA9SkA+wGFbvNCg@mail.gmail.com>
Subject: Re: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
To:     Yosry Ahmed <yosryahmed@google.com>
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
[...]
>
> The map usage by BPF programs and integration with rstat can be as follows:
> - Internally, each map entry has per-cpu arrays, a total array, and a
> pending array. BPF programs and user space only see one array.
> - The update interface is disabled. BPF programs use helpers to modify
> elements. Internally, the modifications are made to per-cpu arrays,
> and invoke a call to cgroup_bpf_updated()  or an equivalent.
> - Lookups (from BPF programs or user space) invoke an rstat flush and
> read from the total array.

Lookups invoke a rstat flush, so we still walk every node of a subtree for
each lookup, no? So the actual cost should be similar than walking the
subtree with some BPF program? Did I miss something?

Thanks,
Song

> - In cgroup_rstat_flush_locked() flush BPF stats as well.
>
[...]
