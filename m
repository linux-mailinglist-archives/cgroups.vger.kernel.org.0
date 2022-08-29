Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55BB5A53BB
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 20:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiH2SHt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Aug 2022 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiH2SHs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Aug 2022 14:07:48 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1632B8B988
        for <cgroups@vger.kernel.org>; Mon, 29 Aug 2022 11:07:47 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id kh8so6928132qvb.1
        for <cgroups@vger.kernel.org>; Mon, 29 Aug 2022 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7rQocjicZEmcxwKtCOFzf24LVnPFDEo/4tWTRLGIYcE=;
        b=qL0rlGpyTRDVHdnZwy6wQJuIxEKjKUMQsjBj7a45cUf5S7tBgmg1bF5R/f9PiNR0Gn
         KWmzUDLsZEk79MqhJnyZIZRGIBj5vp4MUALH8RpbD+Ww3cAQo1OpenjDGzmr2p2oQC+i
         fV8bTXy5/C0GwxuhaUkXKHsUBy7mGZcNC/Aa2SjE+YGMUHyqf7fMt7TKYLMKz3CNYYXS
         pSxOmPMS5EROBSrSBSm4vbT+wUQAoBGMxub3djMvhplX2nbVFS45/nEhV4wct2EMl9/t
         Lk4TwfNdzKaBlQeNpeAj8WKQEyYuGVcbrNA+udLLIFWNW5Pc/dlmBmBBGvOEyl1iqYFr
         Z5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7rQocjicZEmcxwKtCOFzf24LVnPFDEo/4tWTRLGIYcE=;
        b=ftaD4senmc52jvdf+r/o0gSk3Yd6a2UuAc1Zf4Repw2LJW4TR2x53+k7qofQXr5xb4
         MgnH6UajbUzfX7I8ZA78NzNXDJTJQwhSypr8t9BGFH5dh847rCl5DsrVa7INKGlqLZwl
         fc74TUMlu2sV1jsPo2d3h34r+uNAmnkIH6bu932/xTjSZPZPYm+Fhd4ona/ZIYASw+Uj
         4vNsg9/sZIxSxXejXmPqR1wN3sctZMkFIBfx1An6wsbX3ujZVlhTHYhfWWoJyXtcFYRe
         MCkmjtLgB2PXFwBONiP9/UBkILQyD3TFIgA8qDnmQUu3c2+DMMtPNwvgVocF2+2edRax
         s15w==
X-Gm-Message-State: ACgBeo0an78VgZbwtxTFs7x0e0s/qtEkAlknEh+q4kOXpOQb33kqwXia
        /e3zQHyWkg7kaH2InGNkKVmbuCNAFxhuSmcC2DhV/g==
X-Google-Smtp-Source: AA6agR4OIV//3V4jm7d5wGtxHgWJ1uBfV88Ty4upvuiZ6NdZoLWIqadvl7YT969T8sm4AbUu1c5yo0cvXdZQllhqXEo=
X-Received: by 2002:a05:6214:20a8:b0:477:1882:3e7 with SMTP id
 8-20020a05621420a800b00477188203e7mr11986131qvd.44.1661796466132; Mon, 29 Aug
 2022 11:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220824233117.1312810-1-haoluo@google.com> <20220824233117.1312810-2-haoluo@google.com>
 <9edbddb7-4a3b-f8d1-777c-66e5f8efc977@fb.com>
In-Reply-To: <9edbddb7-4a3b-f8d1-777c-66e5f8efc977@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 29 Aug 2022 11:07:35 -0700
Message-ID: <CA+khW7h5KAqmhJB+3bCmeqs5EW927XnK1D+GrXqa3RUaxb1wTQ@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v9 1/5] bpf: Introduce cgroup iter
To:     Yonghong Song <yhs@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
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

On Thu, Aug 25, 2022 at 4:00 PM Yonghong Song <yhs@fb.com> wrote:
>
> Hao, we missed the bpftool dump part for the above bpf_link_info so
> a followup is needed.
> Please take a look at tools/bpf/bpftool/link.c searching 'map_id'
> for an example.

Sure Yonghong. I was on vacation. Will do this today.
