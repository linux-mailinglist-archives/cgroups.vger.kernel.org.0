Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD596A73A9
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 19:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCASkq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Mar 2023 13:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCASkp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Mar 2023 13:40:45 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F4A4D634
        for <cgroups@vger.kernel.org>; Wed,  1 Mar 2023 10:40:17 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-536c02c9dfbso380499987b3.11
        for <cgroups@vger.kernel.org>; Wed, 01 Mar 2023 10:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677696017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VNgf/r1TnHipquaSqm1nBgcfCj1sznNvb3fMKCfdzk=;
        b=COdiTXCTNt65uxq2qiDXYzfPtnXK1e4ui6Q+vUpUn8iwglyQFGsBmRbIApA3qffQE9
         CWYk1Ea125YBWTqc9drTxqJWMMhBNLfJXyUfM2xFbiIvYFEM8NTWo9EcvoXpGPLzmDQu
         N5dJ7eEJRPWkmZEu0Tcd2cXRavT48kX3cTotQhqznDkkzebA1Rnh8bfLFbV/Ijl9DptM
         toDwFGvlYoQWsqC5klnDfy25CN+wNfIOdeX3fxh97zq3LMzUERHqE5kkSCysr/KxuYPP
         DneIapDgvV0LtVULE9BmwlCaPnwjpOvSGRHXO7IsZMo4f/eRMa/2ZuD3czVvUo4ScYMC
         lBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677696017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VNgf/r1TnHipquaSqm1nBgcfCj1sznNvb3fMKCfdzk=;
        b=AS8XmKEBRvUF52YWDWtgeayWJXcvRcJLzCsJj/f0FMwm0WfonprZHoau6QD9R8Y5hr
         aJoeyg3R+ddDxLBllVihpxoYgNb87Ir9WQK0OS3wXqRHlvRhLC2+BP+Or765pL59yRVi
         gIGG/W9uuovRmbzYJfEihmhGEMRCAj+orRch1wiZrtXS60uF26T/dMEUiqEtJLDUg2uU
         Yr4Pc3raEl51VkmnNq1Uiw2t+H1C79OeEOO0NtWUY73nVf/fiCAhmTA6N2Q9DPwdTu5O
         K8zPc6lkpzimWbbFpmZfMpGHztn67A6CSHD4fQFlOPeZo8gFaq+erw9AS3f8fVHCq93z
         B5Pw==
X-Gm-Message-State: AO0yUKXE9+NRw33ESmdoZiXL2B8olfWqqI2Y+MbaWOaeDN9SpSGY7LCE
        8QL4kL7qgsTwM9PphJI8oeTMPxvmHJiJkSCNppVKVA==
X-Google-Smtp-Source: AK7set917PtkuTxnpZfLzH1CxVeaDGB1+cZ2cTzi1+wqXN1JwkwDK1ULzLkfsF5xRlj0xmQuZW3wtq/Msi8QimPbukM=
X-Received: by 2002:a05:690c:f0d:b0:52e:e8b1:d51e with SMTP id
 dc13-20020a05690c0f0d00b0052ee8b1d51emr7425595ywb.1.1677696016742; Wed, 01
 Mar 2023 10:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20230301014651.1370939-1-surenb@google.com> <Y/8fNrNm1B2h/MTb@dhcp22.suse.cz>
 <CAJuCfpERczW1YhEW0fN3p2zrdDj-Ec_pCONH6SQVEwTj0BHYMw@mail.gmail.com> <Y/+a7fczvsVe2lPP@dhcp22.suse.cz>
In-Reply-To: <Y/+a7fczvsVe2lPP@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 1 Mar 2023 10:40:05 -0800
Message-ID: <CAJuCfpH1OsRH15p9PBxuCXrp8RrSiP5u4XQouuO-zOUxCB-zbw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 1, 2023 at 10:35=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 01-03-23 10:05:36, Suren Baghdasaryan wrote:
> [...]
> > Yes but hopefully my argument about keeping this and min period
> > patches separate is reasonable?
>
> I am not questioning that. The practical advantage to squash the two
> changes is that in case of the CAP_SYS_RESOURCE you do not have to
> explicitly think about reverting the min constrain as well. I do not
> think reverting one without the other is good.

Ok, I'm fine with having both changes in the same patch. Will post v2
later today. Thanks!

>
> --
> Michal Hocko
> SUSE Labs
