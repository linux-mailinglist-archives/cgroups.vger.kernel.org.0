Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67037BF1CB
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 06:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442013AbjJJEFw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 00:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442119AbjJJD6y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 23:58:54 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECDCB7;
        Mon,  9 Oct 2023 20:58:51 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77433d61155so343610985a.2;
        Mon, 09 Oct 2023 20:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696910331; x=1697515131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBTaDrPBLChOqx+ha9GaJ4uHRzThEiQPRrRRZCGWEAs=;
        b=lyD1cM9Wb2EuKI9FeZ5A+v3Xui1oqGuoqAU5W+S1IJXb97q9ON1glhm0PwSKUV1Eg7
         6VpQVAaGdR4CwFC5Lf0RknQaTANTscDBYM3M8jSLbshvMrfptj9oskK+B1qOoujVTt6I
         miNok4sD+WqeEHauxayV6eLo2UN6Y2JaNfa9dkMbgLjpIsUhv//+eeRRruKJfSh7i0Sj
         nYmSIc1F43RzCsg3Dkks8spN6cF8FGKEU6w7dTas68mhYC5y1wtRthVSK4OLpvgPPdRl
         lIKp/ltuHogkAFFCG4v6/58Hsd/zn41zvKIMP3VOZRRBSKD1AeVde5x1IMXYxzu8pHPu
         9p/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696910331; x=1697515131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBTaDrPBLChOqx+ha9GaJ4uHRzThEiQPRrRRZCGWEAs=;
        b=TL/rb/ZGqz/SPToDEHZkdMN7RLIm9V7+MqgDfm7O0aWHkPq5+Tt8SoDc8eL47EW4ha
         GbTzGfp/YxtMcexMqXJJoduG5ymPiW9ZFriRfRPEaoCgaFwAzkBwu0dy+dVPgb9UA6y8
         pQrEYDsphuA6CHEq559BP8MNxQCTZh6/Xa1RbKVqFXcJHoXCCNIS7l95IDFzub394Yaj
         B9z7aLpm1qBivl5On1iw7JheXXSadODOkinSUQBeJyg1j1S96UyY0SPRVKfCGtaarsvN
         PVWLQx7bxSwm2SMFdTBBGOjnr1PlujmJgiRaQ0q1d1bIcQzqSzOJCZ/GZtxKq4VLvmQn
         OdBg==
X-Gm-Message-State: AOJu0YzjBtKjZ/AYQndS4B69UsLayJShhkWOudwBmSXEgkQDKbv+q48b
        enPQ2WnB2htJsEsNsGpYWdtC4ODk+EJd7IdlIIY=
X-Google-Smtp-Source: AGHT+IGwW4SWSXNqVZB6lhKG6vTnbReEf4fmfJ7qqhCrbJQZ2qAiyVx0+66NwubYjIduB4/74uUK+n4YHoTJ0l8fZes=
X-Received: by 2002:a05:620a:44c8:b0:774:16fc:65e0 with SMTP id
 y8-20020a05620a44c800b0077416fc65e0mr20661222qkp.12.1696910331020; Mon, 09
 Oct 2023 20:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231007140304.4390-1-laoar.shao@gmail.com> <20231007140304.4390-2-laoar.shao@gmail.com>
 <sdw6rnzbvmktajcxb4svj2kzvttftae2i5nd2lnlxnm3llub37@2q2rlubjzb5a>
In-Reply-To: <sdw6rnzbvmktajcxb4svj2kzvttftae2i5nd2lnlxnm3llub37@2q2rlubjzb5a>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 10 Oct 2023 11:58:14 +0800
Message-ID: <CALOAHbC4_0990_HD4=mg8gfU51juk8fs07zYrr6VL9fPOuLOng@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/8] cgroup: Don't have to hold cgroup_mutex
 in task_cgroup_from_root()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 9, 2023 at 10:45=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Sat, Oct 07, 2023 at 02:02:57PM +0000, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > The task cannot modify cgroups if we have already acquired the
> > css_set_lock, thus eliminating the need to hold the cgroup_mutex. Follo=
wing
> > this change, task_cgroup_from_root() can be employed in non-sleepable c=
ontexts.
>
> IIRC, cset_cgroup_from_root() needs cgroup_mutex to make sure the `root`
> doesn't disappear under hands (synchronization with
> cgroup_destroy_root().

current_cgns_cgroup_from_root() doesn't hold the cgroup_mutext as
well. Could this potentially lead to issues, such as triggering the
BUG_ON() in __cset_cgroup_from_root(), if the root has already been
destroyed?

> However, as I look at it now, cgroup_mutex won't synchronize against
> cgroup_kill_sb(), it may worked by accident(?) nowadays (i.e. callers
> pinned the root implicitly in another way).
>
> Still, it'd be good to have an annotation that ensures, the root is aroun=
d
> when using it. (RCU read lock might be fine but you'd need
> cgroup_get_live() if passing it out of the RCU read section.)
>
> Basically, the code must be made safe against cgroup v1 unmounts.

What we aim to protect against is changes to the `root_list`, which
occur exclusively during cgroup setup and destroy paths. Would it be
beneficial to introduce a dedicated root_list_lock specifically for
this purpose? This approach could potentially reduce the need for the
broader cgroup_mutex in other scenarios.

--
Regards
Yafang
