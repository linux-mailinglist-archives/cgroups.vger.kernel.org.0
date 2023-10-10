Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51607BFA7A
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 13:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjJJL7g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjJJL7f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 07:59:35 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981059D;
        Tue, 10 Oct 2023 04:59:34 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d89ba259964so6006475276.2;
        Tue, 10 Oct 2023 04:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696939174; x=1697543974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ic1gFQ2flukZpGsUvQ78a+x1p7tCfT5gyU+UYciX8w0=;
        b=FYBMSfNTsliLnR1sJHQZUhVXDnacCeq4ntengrZv69dBMKBEQDk8/BKQRJ+6QuKq9c
         2J7j3cu5JBhcJDhTXxss8C3jDukQGfrDaYPD+EwSaLridzxJVyzsYJHuiggNajrdUZtF
         IEf8sj7o4EKWzJDiSvT0vsnJHCUDZNb+Me7wrkm4Yj0RWURXoepbUbbiE1IGpVp3gl0t
         Fy43+76qXOTGpLIDhWoLILGSIfB+XkL9+EqFgHe50yQaujTkkJ8PHFk103g0s4+/z5yG
         yOK50gM2QRi3Ut2BaalsBE7wJzmcue79OTM31RU0f2McI+XyxreKXLdVv2c+8EPlcGyT
         Z8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696939174; x=1697543974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ic1gFQ2flukZpGsUvQ78a+x1p7tCfT5gyU+UYciX8w0=;
        b=c3IqO6zbfVe65fD6SK9BKyx2CbyZGHxnjLEu3pkjCqALE1khtNZ/C0vu1mrrtnK9lL
         JK5r3OxvyORHwJDUlB+TGsnmmd3l/Go/wNJGI81hO00qEDe1t2zkDwAcOCOg8b7CHAQa
         geJ8joiT3gRJgGJpYCCv54rszJX4K5mS8XYsRY65rCjK1cE2kl6YXTtuHn53vOiW6hVZ
         PzmKO56Qu//h95JhZ9u9cG2hZGClwvVpQ3+wYcDJSTo8OiNDAx99PFBOX1Hsna/G+kJJ
         ZOCRVNDBON6Sh/LPWZMcDzMvPTbDLYo54YNfqSWDhf9Ho2SEX2TPsGGQ2Ko1WdmskcXi
         hQRA==
X-Gm-Message-State: AOJu0Yxyt6TkuHhCmWJ8nbgRSo4jo4IUqO+ehLUzAIf0FyWpOLWCEzYv
        vD3lDPtDvauyjC3sPM4XprBWxN9oPuqVVNAGNZk=
X-Google-Smtp-Source: AGHT+IFeKRwUOFt9FTsWV+Ayu6wmPxiTFRWSpYD/9Ldp5Gs//CdagIbQzbxG/c6rLVi/ETs+Bi0a7KkisJhs6sK3BTo=
X-Received: by 2002:a25:97c7:0:b0:d77:91db:e5c6 with SMTP id
 j7-20020a2597c7000000b00d7791dbe5c6mr16844920ybo.17.1696939173777; Tue, 10
 Oct 2023 04:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231007140304.4390-1-laoar.shao@gmail.com> <20231007140304.4390-2-laoar.shao@gmail.com>
 <sdw6rnzbvmktajcxb4svj2kzvttftae2i5nd2lnlxnm3llub37@2q2rlubjzb5a>
 <CALOAHbC4_0990_HD4=mg8gfU51juk8fs07zYrr6VL9fPOuLOng@mail.gmail.com> <afdnpo3jz2ic2ampud7swd6so5carkilts2mkygcaw67vbw6yh@5b5mncf7qyet>
In-Reply-To: <afdnpo3jz2ic2ampud7swd6so5carkilts2mkygcaw67vbw6yh@5b5mncf7qyet>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 10 Oct 2023 19:58:57 +0800
Message-ID: <CALOAHbDfteSf=RcMt0JHYtgM4DUvnft+gQRraALvA_KkRWYpwA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 10, 2023 at 4:29=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hi Yafang.
>
> On Tue, Oct 10, 2023 at 11:58:14AM +0800, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > current_cgns_cgroup_from_root() doesn't hold the cgroup_mutext as
> > well. Could this potentially lead to issues, such as triggering the
> > BUG_ON() in __cset_cgroup_from_root(), if the root has already been
> > destroyed?
>
> current_cgns_cgroup_from_root() is a tricky one, see also
> https://lore.kernel.org/r/20230502133847.14570-3-mkoutny@suse.com/
>
> I argued there with RCU read lock but when I look at it now, it may not b=
e
> sufficient for the cgroup returned from current_cgns_cgroup_from_root().
>
> The 2nd half still applies, umount synchronization is ensured via VFS
> layer, so the cgroup_root nor its cgroup won't go away in the
> only caller cgroup_show_path().

Thanks for your explanation.

>
>
> > Would it be beneficial to introduce a dedicated root_list_lock
> > specifically for this purpose? This approach could potentially reduce
> > the need for the broader cgroup_mutex in other scenarios.
>
> It may be a convenience lock but v2 (cgrp_dfl_root could make do just
> fine without it).

Right. cgroup2 doesn't require it.

>
> I'm keeping this dicussuion to illustrate the difficulties of adding the
> BPF support for cgroup v1. That is a benefit I see ;-)

A potentially more effective approach might be to employ RCU
protection for the cgroup_list. That said, use
list_for_each_entry_rcu/list_add_rcu/list_del_rcu instead.

--
Regards

Yafang
