Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BCD5A53AF
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 20:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiH2SCv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Aug 2022 14:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH2SCu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Aug 2022 14:02:50 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DB57D7BF
        for <cgroups@vger.kernel.org>; Mon, 29 Aug 2022 11:02:48 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f14so6673558qkm.0
        for <cgroups@vger.kernel.org>; Mon, 29 Aug 2022 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UeCjsqVX03HELV6Qxt26VdXhNVQmFOTxZbHveZi3Wic=;
        b=cUqah88qiqkMfKXIggmg3kkUscXJDGR5OrYwItkLbrscXP0wYnc6ckeka2erXb9+EK
         sMS+NHZt6ZJeQw5uULvYMQj02mdFaEp9RH0AfvLiKJs1hk2KIeSzdztoblg4GHwuYAqo
         xJeq1L3lg9LCT0kx6VYK7lxh2La6HHLVxdQnn1yW8dW25hwlg5PRUQsgU5boHtjoRdVD
         2dJ9e3wrNYW/kfW4g7WqzZoY8OzS/twBI5CP3iVmtwlxOE/oC9V6GgT6xG4x7+OqE3Zl
         sTXfjeW5XeJ2pFjxoriPT0yfEIdAhd+uiYl+xGpi8w3v08bruNKjvsBUwGxhCPUrdKMl
         xAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UeCjsqVX03HELV6Qxt26VdXhNVQmFOTxZbHveZi3Wic=;
        b=oq6+2Y7WxSQAN2OOlxNhwWlPBbjwOOVvpJoMBCH9SJL4zY3Di8Szp7HDOhS3F77dKQ
         DZJVGpfsMggYIVRjQCweYoMrd4qBqe9DQk0qD9syGa+hJCpAK0bW6q4i/2l4p8DfZ9Vd
         WiCC3E1kyrF5y17OZxym2/0hUrfskOBJ/NKG2Bp5qsC4eLKlcmCMROhgi3lwquMmOWFR
         XrFpGC/JjE6SwUbTzQdPkBMDWgca/noPI3rL/ZnVwNr8IFZx96kZN3x1gfvpaqNqkADf
         oRltw5sAibgNIrjhfsq+Wut5/BxDzo0bvTWZx4OHsk4YTv63VoluJR2MJhvA4ThKVCNZ
         O4EQ==
X-Gm-Message-State: ACgBeo1jsKWPyjqu04jOeuMexdW5Xc2pD4yicyZxNWH7wXXwiBkBtJr7
        c3WfwUWS8ID6a5lVmhMeezgaYLIVOpvJnbwCn2JXrw==
X-Google-Smtp-Source: AA6agR5OBmeDJ16u+wpsLthSvl07+laB7IqnfG6IMHAL5xzAxarEXJcb+CwRWclg02qBxPnvrkbaCKG0Hlu9zMCSoWg=
X-Received: by 2002:a37:4d7:0:b0:6ba:c29a:c08f with SMTP id
 206-20020a3704d7000000b006bac29ac08fmr9048293qke.669.1661796167617; Mon, 29
 Aug 2022 11:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220826165238.30915-1-mkoutny@suse.com> <20220826165238.30915-5-mkoutny@suse.com>
 <CAJD7tkZZ6j6mPfwwFDy_ModYux5447HFP=oPwa6MFA_NYAZ9-g@mail.gmail.com>
 <20220829125957.GB3579@blackbody.suse.cz> <CAJD7tkZySzWgJgp4xbkpSstc_RMN_tJqt83-FFrxv6jASeg8CA@mail.gmail.com>
 <Ywz8J70t3508J62n@slm.duckdns.org>
In-Reply-To: <Ywz8J70t3508J62n@slm.duckdns.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 29 Aug 2022 11:02:36 -0700
Message-ID: <CA+khW7jZCN54nUonNLp59fTAqOtAk_Ror+PgrLBfufRcE-CnFQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] cgroup/bpf: Honor cgroup NS in cgroup_iter for ancestors
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 29, 2022 at 10:49 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Aug 29, 2022 at 10:30:45AM -0700, Yosry Ahmed wrote:
> > > I'd like to clarify, if a process A in a broad cgroup ns sets up a BPF
> > > cgroup iterator, exposes it via bpffs and than a process B in a narrowed
> > > cgroup ns (which excludes the origin cgroup) wants to traverse the
> > > iterator, should it fail straight ahead (regardless of iter order)?
> > > The alternative would be to allow self-dereference but prohibit any
> > > iterator moves (regardless of order).
> > >
> >
> > imo it should fail straight ahead, but maybe others (Tejun? Hao?) have
> > other opinions here.
>
> Yeah, I'd prefer it to fail right away as that's simple and gives us the
> most choices for the future.
>

Thanks Michal for fixing the cgroup iter use case! I agree that
failing straight ahead is better. I don't envision a use case that
wants the alternative.

> Thanks.
>
> --
> tejun
