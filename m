Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593AF6A7464
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 20:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCAThM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Mar 2023 14:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCAThM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Mar 2023 14:37:12 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C074DBFD
        for <cgroups@vger.kernel.org>; Wed,  1 Mar 2023 11:37:10 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-536cb25982eso383106147b3.13
        for <cgroups@vger.kernel.org>; Wed, 01 Mar 2023 11:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677699429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN5p7z1WK4bckACT7Rmjh2flVU52vLPk6a4cmtTmWCM=;
        b=Bz3Gg87YDUOZRW3JtWlnTSRav9KQ3c8UoFRle8RRsFj4E8JL/6YPrh+cbeKQvNJrSI
         QMDpNr81KkfsEda0yEywOHnC+W2xKgL2Ft6WVjYTsKQOeC1h3KVcSLXhiUMyy8SnnowZ
         AvnOHJ70aVW5+ohbUw4QNQ/tpW2+8xTwez8SZjiA43cyddyn9r9oJ5V0erPMEqP58l0c
         hZnbK+zPGprvS608QVNuofuBnuktaml9uU+vJsBuz4YC+hK8HHLgPyItbqzCSt0YzPe9
         g171Iu8gTmGP5yXq9dTY2t6ZDaA3Teq+g2BPfaRFOIcY9M+dgqFZOZJyLxQBQ7lB0odM
         oWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677699429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QN5p7z1WK4bckACT7Rmjh2flVU52vLPk6a4cmtTmWCM=;
        b=p7V7YqDQcmegikuU35bxZQsXpijCifKCWh1tTJVa1AbfYg3Z68djkdpZjB/NmAQovS
         7jYdbuJe71r++60H0pWXowgvU5Xf1ik4smyfUwkfjyPe9eyv/NBD6B2U6ZMEwgU9PaHq
         KOVklzAgNLgZy7myodaKbZV7+bmvVrlaTJqDFP3T+gvpX8szbHLn08/wb9mlVwg4BUnS
         p2fxzSsm2ay9K48ZOvXLxpQVkvYMge74vkRSSYG3uulV305Us8TIdtKSEjOcDQwmzjgC
         +FyLWv5R44qatOQzNaXJgjqEDZngnxfQa4pEEmOYZvKIwwRW7eM8qwKj54Lg2ph7Gqb4
         YyNg==
X-Gm-Message-State: AO0yUKVtkjdgePnF8SBrancyD+t1307INzWwN31sg2xK8J63Z9kdiBqj
        eXFCs+kOEGYZVP1iWKEHJ5vFflwWmPJC+EUHr9b0XQ==
X-Google-Smtp-Source: AK7set959ywP5kb93gzYIRJS/wk9K0P02eARMqCZ6qig+6yex6/lV35+7mlNP2bx3bJOX45VvuUf5Mgex4bik8sctAE=
X-Received: by 2002:a81:ae23:0:b0:533:9c5b:7278 with SMTP id
 m35-20020a81ae23000000b005339c5b7278mr4521096ywh.0.1677699429308; Wed, 01 Mar
 2023 11:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20230301014651.1370939-1-surenb@google.com> <Y/8fNrNm1B2h/MTb@dhcp22.suse.cz>
 <CAJuCfpERczW1YhEW0fN3p2zrdDj-Ec_pCONH6SQVEwTj0BHYMw@mail.gmail.com>
 <Y/+a7fczvsVe2lPP@dhcp22.suse.cz> <CAJuCfpH1OsRH15p9PBxuCXrp8RrSiP5u4XQouuO-zOUxCB-zbw@mail.gmail.com>
In-Reply-To: <CAJuCfpH1OsRH15p9PBxuCXrp8RrSiP5u4XQouuO-zOUxCB-zbw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 1 Mar 2023 11:36:58 -0800
Message-ID: <CAJuCfpH=vEObrnSkqyk2BfeG0Jqgz2T4GxrS7=xJ3Ts2zj0A7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] cgroup: limit cgroup psi file writes to processes
 with CAP_SYS_RESOURCE
To:     Michal Hocko <mhocko@suse.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        peterz@infradead.org, johunt@akamai.com, quic_sudaraja@quicinc.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 1, 2023 at 10:40=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Mar 1, 2023 at 10:35=E2=80=AFAM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Wed 01-03-23 10:05:36, Suren Baghdasaryan wrote:
> > [...]
> > > Yes but hopefully my argument about keeping this and min period
> > > patches separate is reasonable?
> >
> > I am not questioning that. The practical advantage to squash the two
> > changes is that in case of the CAP_SYS_RESOURCE you do not have to
> > explicitly think about reverting the min constrain as well. I do not
> > think reverting one without the other is good.
>
> Ok, I'm fine with having both changes in the same patch. Will post v2
> later today. Thanks!

Didn't call it v2 since the title had to be changed. The new patch is
posted at: https://lore.kernel.org/all/20230301193403.1507484-1-surenb@goog=
le.com/

>
> >
> > --
> > Michal Hocko
> > SUSE Labs
