Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E125223DF
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 20:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiEJS3Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbiEJS3Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 14:29:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C932A7C00
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 11:25:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i5so24951394wrc.13
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/K+z4FbavDUp9taCkfXpbx13rVcW3GTSvwjLfREXAU=;
        b=Tty5wMz7Ghu646JswlNLX+XwgMjXTrtdIAnTGLzWswd7pJqjghhee9uTTrSBkA1mS5
         TASpWLvrSWJ0o/VmKB1zZ2EKL7bj0qTC3lvVRuamF3i9rZ6kaQX5QDmWCn9TRCB5uXkV
         r8gOHaTXenDSj1D57niaR5CpxS9xrrcL40YA8vpjqNI+g1gL5pCdsCqYcSLce1I6fc3z
         kWNzuDcKIBDb+SwqrxV9F0c+DchRf6wXrjkpR+hTKigiASG8TQ/T4toShl24UGOGYEeY
         ZEnNjV6vVbfPH9Mde3cglN60wQIz6IJ5FIeBa8eN2oVUv11BpQol0cmvcrU6FhcjdmJZ
         DX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/K+z4FbavDUp9taCkfXpbx13rVcW3GTSvwjLfREXAU=;
        b=YMkFg06LweMmkMi+3rJz9YeZQDzjAzgwHresmp0MkGb0C/qthiRVlPWWb/SifsPgyR
         XUBsThDgp12qREkx6QlTujM5EYVYJxaCuDwGq/uVDR/W1DVqUHh0H3rwDK26GTRNFAx9
         qgqNLAEzKiw1H4C4YMLNIOoFV/eHq2ljxJPt/7z20iUtVJ7WL79POKzQ+9Q7Z3UZ9P/D
         ARnYbeaOfcUpEnnfN+M+GCVCgNbzZClWpyT/5O3jIUuffng025Lf+OD65K/wIDTjGQAP
         h9BtQaoSC+k06RcBFIpVAwPh4MpgnCZs139411RoPC1mJsvqxgZ2csU/LW33UiJLyfY4
         0jvQ==
X-Gm-Message-State: AOAM533wWiChjnDBnu4bkC24WlroAF/LpF/ThOX87M5+O71oPNLvG7fk
        GNHAxdwQVk1DIZunqTN34nHbm7NgPptLxeC4GcmO/w==
X-Google-Smtp-Source: ABdhPJyzA6ZqMl9aS9nV7QUKqV1oRP2aghQEHWBX7a2slUyqZ51MHrel4plITu1M0/TnH8bx25zFuopsJMSrkMAFd0g=
X-Received: by 2002:a5d:630d:0:b0:20a:e1a3:8018 with SMTP id
 i13-20020a5d630d000000b0020ae1a38018mr19695063wru.489.1652207124680; Tue, 10
 May 2022 11:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220510001807.4132027-1-yosryahmed@google.com> <20220510001807.4132027-9-yosryahmed@google.com>
In-Reply-To: <20220510001807.4132027-9-yosryahmed@google.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 10 May 2022 11:25:13 -0700
Message-ID: <CA+khW7i1Pcc9_bfxVhtzGQkevmodie7=M-57ScMqUyw5U=KW4A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 8/9] bpf: Introduce cgroup iter
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org
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

On Mon, May 9, 2022 at 5:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> From: Hao Luo <haoluo@google.com>
>
> Introduce a new type of iter prog: cgroup. Unlike other bpf_iter, this
> iter doesn't iterate a set of kernel objects. Instead, it is supposed to
> be parameterized by a cgroup id and prints only that cgroup. So one
> needs to specify a target cgroup id when attaching this iter. The target
> cgroup's state can be read out via a link of this iter.
>
> Signed-off-by: Hao Luo <haoluo@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  include/linux/bpf.h            |   2 +
>  include/uapi/linux/bpf.h       |   6 ++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/cgroup_iter.c       | 148 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |   6 ++
>  5 files changed, 163 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/bpf/cgroup_iter.c
>

Thanks Yosry for posting this patch! Dear reviewers, this is v2 of the
cgroup_iter change I sent previously at

https://lore.kernel.org/bpf/20220225234339.2386398-9-haoluo@google.com/

v1 - > v2:
- Getting the cgroup's reference at the time at attaching, instead of
at the time when iterating. (Yonghong) (context [1])
- Remove .init_seq_private and .fini_seq_private callbacks for
cgroup_iter. They are not needed now. (Yonghong)

[1] https://lore.kernel.org/bpf/f780fc3a-dbc2-986c-d5a0-6b0ef1c4311f@fb.com/

Hao
