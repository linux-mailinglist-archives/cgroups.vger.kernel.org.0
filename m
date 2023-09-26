Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369867AE3F1
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 05:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjIZDJY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 23:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjIZDJY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 23:09:24 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435239F;
        Mon, 25 Sep 2023 20:09:16 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-65b0e623189so17697216d6.1;
        Mon, 25 Sep 2023 20:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695697755; x=1696302555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHSIKUeBex5AI8uxl+C0er1czMgcQqC68b/wIooWTTM=;
        b=GKTNcrEA5fTTZLWAYJZ/DtBxvpv0317vg7njbKqQChkBIC7y6kzJkMIHvVOY385l2y
         GgS6hxpAJHYyYCcxR94JMcJcMrdB8q2i+7w1Xnje+Xzoxk9sz9Rpxmv/2hRurqdSkhP2
         Wx62aFVtHk2EuMgTtbX3IoMQSV/nBEtsgAmP3P9WX6SBbMv9VLlR3UpZJzm81xebu2bc
         oMgPPAklf+Uzm5YNQ4rIP6VuV/jufhdYcxgiPb6lD+SC5Ghrh6eEvCct96CXNI06RRqk
         YxsmVcJUtItPrZwG9gu4PssZpqHVR4HXIDsuEo+n8LhY+NfVALlrEgzE+PLVT+tr3wX7
         0SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695697755; x=1696302555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHSIKUeBex5AI8uxl+C0er1czMgcQqC68b/wIooWTTM=;
        b=q23PIl2T/fV50ULk/ZcqjWU2ZfBrIB1i+PhtBY8hG3i6LCnYG9Kli9piyAIXIahoJ8
         iKvk2QVlXaKgkQ5mOXVEXeAM+OiBBAg7RzbHfGHDgQjOKLxbwl2yELsgMKhasYUsOsJK
         94TFauQtBzV1jDdM/9yMBTMpubTLr0W/QIZ5ERD0ibRVwsQtyFjCvczV7+568/7VRbK2
         3NgU12AzEEm+O+l/WIqqkWS1hWq9XrAgBwJD5AlAJTtrRNlmsO9ycl8ceh//KCAfKo5F
         Y2ksR3Aq3q0EPwdH6OFKWCNSK6gtAoQBWkkMQeuJXTagOEHWM00n64XtKeFsgp/nasEw
         NZRg==
X-Gm-Message-State: AOJu0YykvLa2txVC0EiJ9WDnl7jqvtbKZEkdq52e+ncgy3UaTzHKDao5
        Qqg/jNJ39vJSJrPUrhJQREywiOTlvim3a2HAmYA=
X-Google-Smtp-Source: AGHT+IHzfgpEIFbW4RP9NhWoFXvF1rvZJCxV6NhVkjqgl55VJzA9DeEj1oTeEDGwfFbYV1bNU7SrEsVDol3le+K2t3s=
X-Received: by 2002:a0c:f8c9:0:b0:64f:539b:f52a with SMTP id
 h9-20020a0cf8c9000000b0064f539bf52amr8943786qvo.20.1695697755420; Mon, 25 Sep
 2023 20:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230922112846.4265-1-laoar.shao@gmail.com> <9e83bda8-ea1b-75b9-c55f-61cf11b4cd83@gmail.com>
In-Reply-To: <9e83bda8-ea1b-75b9-c55f-61cf11b4cd83@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 26 Sep 2023 11:08:39 +0800
Message-ID: <CALOAHbBAOY7dRO-gQnGXU0xdD2DdzdgX5FLx9ty=u7Q1ZEfL8w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add bpf support for cgroup controller
To:     Kui-Feng Lee <sinquersw@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 26, 2023 at 2:22=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 9/22/23 04:28, Yafang Shao wrote:
> > Currently, BPF is primarily confined to cgroup2, with the exception of
> > cgroup_iter, which supports cgroup1 fds. Unfortunately, this limitation
> > prevents us from harnessing the full potential of BPF within cgroup1
> > environments.
> >
> > In our endeavor to seamlessly integrate BPF within our Kubernetes
> > environment, which relies on cgroup1, we have been exploring the
> > possibility of transitioning to cgroup2. While this transition is
> > forward-looking, it poses challenges due to the necessity for numerous
> > applications to adapt.
> >
> > While we acknowledge that cgroup2 represents the future, we also recogn=
ize
> > that such transitions demand time and effort. As a result, we are
> > considering an alternative approach. Instead of migrating to cgroup2, w=
e
> > are contemplating modifications to the BPF kernel code to ensure
> > compatibility with cgroup1. These adjustments appear to be relatively
> > minor, making this option more feasible.
>
> Do you mean giving up moving to cgroup2? Or, is it just a tentative
> solution?

Our transition to cgroup2 won't happen in the near future. It's a
long-term job.

--=20
Regards
Yafang
