Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB11C552BF3
	for <lists+cgroups@lfdr.de>; Tue, 21 Jun 2022 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346799AbiFUH02 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jun 2022 03:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346767AbiFUH0L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jun 2022 03:26:11 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7912E22B2B
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 00:26:07 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id i17so12466529qvo.13
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 00:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2goD1P8UZdoMASbRq27dQ+7VURQY6z/sy9q6Pv8gJ0=;
        b=Nxf6B2MS9DZB/qkHAQOWw5j6Bxtg9kXmQExGgUeWaC3kJp0lzK6x8BHGxiyuf1PBbq
         uePpIuL+U7i0MRI/BGAYmGPWtW3pprxDU7KhDqDB55rrl2psNymEaK1oB9Bk2tuIs0DO
         vCe/RlXfewePsPZV77Rrn5giVYffEX1nAG2gak+cWKoIlPw8DsgjcHyzW6vHnei8W4yi
         bldDvXWFxnpNK7oFaUEuYWDrqSGqvzjcEkefGn6o6BMvxx9I4fD/jCRn9exwoZxlLOq9
         pgUC+UKExjEp8eFrG6lsYClq/9xrrmInHpBjHS9tBiUEBgX64G+DrX1Itm0fIudn52v3
         lk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2goD1P8UZdoMASbRq27dQ+7VURQY6z/sy9q6Pv8gJ0=;
        b=rMkTY09mo0+ML+rKpgS1gJ81melnfZnbOeTbh5Mu+MluDQmjmIMyPxPrIG4TYjP6n+
         x3JOLx2vPD22BKqCMMi6AWEdBkg+N49MNFodAe5DFuvXxrJ3aq2E59jMb8tBC3krD2Zb
         XD3605oS0Z6U12b3qTiWhSF6232yY8xZ2AJ6lnOgvc2lj/L/tYU2AOuuK9yohHRSvU8o
         e4AJBiOhkiVWjFzyb8IebzQ/QEIqmBZZK96iSex8HnUtnFaWPVkhpWSx64fiNLDzDCR2
         k6WJuLCZMw/ASXnE6hH9oZxkkzhyczuJScrR6vdieqj50B7NdSPTAVmd3rDX1J/YN/ek
         24MQ==
X-Gm-Message-State: AJIora9nHsq4HTKWCuoaosLn9pj0VRgZoZBF/XO/Bsl0GA2JJerlUuIE
        YGfu+XhdituQdNmsgI4w5NfptQt44e4FppYGckg++Q==
X-Google-Smtp-Source: AGRyM1s872tNwJc0ZLYopGWEjQHkRWEwSjnPvn0vD1OExkgUdoy/kck4+JRqdMmtHyzx3sNtCNhvpRW6dj44v3O+djY=
X-Received: by 2002:a05:622a:550:b0:305:2905:a230 with SMTP id
 m16-20020a05622a055000b003052905a230mr22593229qtx.478.1655796366422; Tue, 21
 Jun 2022 00:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220610194435.2268290-1-yosryahmed@google.com>
 <20220610194435.2268290-4-yosryahmed@google.com> <ee47c4af-aa4f-3ede-74b9-5d952df2fb1e@fb.com>
In-Reply-To: <ee47c4af-aa4f-3ede-74b9-5d952df2fb1e@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 21 Jun 2022 00:25:55 -0700
Message-ID: <CA+khW7jU=Fqt49jxG8y5n2YtRu4_C1gFUW-PqZGY_Rt8PGrGEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/8] bpf, iter: Fix the condition on p when
 calling stop.
To:     Yonghong Song <yhs@fb.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
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

On Mon, Jun 20, 2022 at 11:48 AM Yonghong Song <yhs@fb.com> wrote:
>
> On 6/10/22 12:44 PM, Yosry Ahmed wrote:
> > From: Hao Luo <haoluo@google.com>
> >
> > In bpf_seq_read, seq->op->next() could return an ERR and jump to
> > the label stop. However, the existing code in stop does not handle
> > the case when p (returned from next()) is an ERR. Adds the handling
> > of ERR of p by converting p into an error and jumping to done.
> >
> > Because all the current implementations do not have a case that
> > returns ERR from next(), so this patch doesn't have behavior changes
> > right now.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Yonghong, do you want to get this change in now, or you want to wait
for the whole patchset? This fix is straightforward and independent of
other parts. Yosry and I can rebase.
