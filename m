Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03C9405BC5
	for <lists+cgroups@lfdr.de>; Thu,  9 Sep 2021 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbhIIRK2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Sep 2021 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbhIIRK1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Sep 2021 13:10:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99638C061575
        for <cgroups@vger.kernel.org>; Thu,  9 Sep 2021 10:09:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c8so5105531lfi.3
        for <cgroups@vger.kernel.org>; Thu, 09 Sep 2021 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4R55HGCX5kPiIdGourKYRqDLwJwF8WpWPhWp89wjZ2A=;
        b=WFfYj9RQ/+CHwxP1EKydAwy0xyGRTKUWvF0EFylgCw0ummpVqqR+qlnHE+s3nGMV6H
         wNaPrKSGu0kuhKvxKWfgzSkrzk0UxkNFJozak3jVIUxe2Y+3X/V8L7sXP97u9eLsXyLr
         RnbvRWT28a4GkgJpXu/dG/sxpesgDHNLad6n4bn62ObFCt2BXe6Ivcx+AEBCTzI73F3f
         r4kknqIged7tVjFk6Q1n70H111zzqGzXRwWg55hm6vsEgYhXV8qsi04oNyVtONp8Wljt
         ee2XR2txI//CcTYgL+xIqkSHWzf2bT/xRXsQ89LxaL6nRIg9rI871PPoK25LrT6GnC3U
         lRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4R55HGCX5kPiIdGourKYRqDLwJwF8WpWPhWp89wjZ2A=;
        b=KYo2U8V+SO7dtpRspG15KjhuwKyeT+FyCC/24LnkmLbq1WG/UMFsujj84AQbjWOhKg
         akUxCoIxAw6jsNNuDSEWYtsEPWaBrn4IPdbrr6RJ6JlBSdqlSMBUnxsEgcP6Tfwm3OSi
         uzthX3xt5Ks0K6S19GD/olPxicD1B8gbT41nySs84lOmmE3DPDhC/WjY5WF1ykI9yAbC
         MHVI0iyW4Q2ToZqh1ziFdGKQfr7qD2lbVLeT/uFZysnWoGexIAi9VQTLghOYkhj2XRcM
         ywFO6UHaozqah0d1JeEc2xDN1jajDXWaxtzu3y8jSxnjsBDrsZjBodYdODnDuT2EIiM/
         xx5A==
X-Gm-Message-State: AOAM530QQOhUSl8lYvpvBlQIhZeLyc1PAHPwOjpc7Qde8yO0tuC8eSmE
        nZl3ZVa/+j0kBtR1UUMOM8X917DjWym8oswTJDiMCQ==
X-Google-Smtp-Source: ABdhPJzYXMg1aYccPWt/T8lspSIPDaJsCwWJrjgKVpN8cMalHVNtMc2Z8HDIwdsGbCL9zWFlJ+rQeYF2GKfNc9jnkSo=
X-Received: by 2002:a05:6512:3393:: with SMTP id h19mr665587lfg.13.1631207355736;
 Thu, 09 Sep 2021 10:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <20210909143702.GA13761@blackbody.suse.cz>
In-Reply-To: <20210909143702.GA13761@blackbody.suse.cz>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Thu, 9 Sep 2021 10:08:39 -0700
Message-ID: <CAHVum0eGN=v1kLqHQg7HBESp8Kg4aGZFNd4XTpxfeyToXPmPVg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] misc_cgroup: introduce misc.events and misc_events.local
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     brookxu <brookxu.cn@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 9, 2021 at 7:37 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello Chunguang.
>
> The new version looks like a good step generally.
>
> My main remark is that I wouldn't make a distinct v1 and v2 interface,
> it's a new controller so I think the v2 could be exposed in both cases
> (or in other words, don't create new v1-specific features).

I agree with Michal. We can have the same interface for v1 otherwise
there will not be any form of feedback in v1 for failures.

>
> On Wed, Sep 08, 2021 at 01:24:34PM +0800, brookxu <brookxu.cn@gmail.com> =
wrote:
> > +static int misc_events_show(struct seq_file *sf, void *v)
> > +{
> > +     struct misc_cg *cg =3D css_misc(seq_css(sf));
> > +     unsigned long count, i;
> > +
> > +     for (i =3D 0; i < MISC_CG_RES_TYPES; i++) {
> > +             count =3D atomic_long_read(&cg->events[i]);
> > +             if (READ_ONCE(misc_res_capacity[i]) || count)
> > +                     seq_printf(sf, "%s %lu\n", misc_res_name[i], coun=
t);
>
> More future-proof key would be
>                         seq_printf(sf, "%s.max %lu\n", misc_res_name[i], =
count);
> or
>                         seq_printf(sf, "max.%s %lu\n", misc_res_name[i], =
count);
>
> (Which one is a judgement call but I'd include the "name" of event type t=
oo.)
>
I am inclined more towards "%s.max", it looks nice to see the resource
name before its corresponding events.
