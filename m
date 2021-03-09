Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDF23330AE
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 22:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCIVNi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 16:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCIVNN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Mar 2021 16:13:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686BDC06174A
        for <cgroups@vger.kernel.org>; Tue,  9 Mar 2021 13:13:13 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id n16so29717140lfb.4
        for <cgroups@vger.kernel.org>; Tue, 09 Mar 2021 13:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mS9vo6iXv4jFE0RaAV7Z3FQHExEtvgPe4n5aXOd4Ddc=;
        b=Yi+mL8MLTiKYYsa94zraqn379hUW+MeC29zszoENAedRL5SdQ19igl19IemtwyjI31
         3cZVNfhuDWDPtC4lhaBhc9Pi6SFGfECg/5dujXNWZJFV7I4A91ecNzInpD/5qcm0AvwM
         LDl1z2ZjzAY8wwCk5J+RCYMS5chvpsTcRoDzf9ZfbCWS+Ym7Wgrb/3EjtUcoQIBexeBx
         v00yijtoXh7YCVkZ6wOGepP2dMwHap9YJAhPwdE0T+TLKj8vYswLV2oObYEI8J68PJgW
         sRvSlbGH07gMR7YNsT3GfIBJAsLy4foKcAkFhbukb3pnRPyO3nS7J1ZXIkaI/C/R0r+Z
         woHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mS9vo6iXv4jFE0RaAV7Z3FQHExEtvgPe4n5aXOd4Ddc=;
        b=rBv3XfD0yIvljCdoKmnpCTA+xeQw+nbzyGIUIKo9Uv3y6gkxpX9NHTCianY8UMDr+e
         fDhkQdumrwG3jvnbYeVL+w++YoOESjp+ZNY+Y2eUXSUdvoIRP1BqWx0e+jDxuubpxqX/
         9qFFvT02bnSNmq+KjJmhtL+M6WqiCU4q7yT+LEkIiYMH3tn6gL2ez3zBcrptAMA8aMAC
         iu9h2bLf38y84V37OLCFDXPXzePKy5dttIGlXbUk57FovRXS3ibUahbM2JifZaPnfP8W
         Q6Hc25J2WAbtHeBr0uaeu7wYuqpy0U6cmc7SFcEqcNqpSWQiu5wu6vBoGCov5TMOZdSm
         8CvQ==
X-Gm-Message-State: AOAM531rp+WjwjtvlpRpIDnEo+azUQlygNMEZkDp0dhbSTG9ZjhJHpWO
        acG3tgIGhOg4XnlNrIfqJVb/zDSRvgHMxYa3z9Oi1w==
X-Google-Smtp-Source: ABdhPJxQPB6fQQQnkTYMKphdPLzxNg/Rb49LywxTRgHXHEpJu1gDvnu4zpK0jTmSCBq9RkClmj4LnaCyuC/TkK57v9Q=
X-Received: by 2002:a05:6512:39c9:: with SMTP id k9mr18191698lfu.432.1615324391605;
 Tue, 09 Mar 2021 13:13:11 -0800 (PST)
MIME-Version: 1.0
References: <5affff71-e503-9fb9-50cb-f6d48286dd52@virtuozzo.com>
In-Reply-To: <5affff71-e503-9fb9-50cb-f6d48286dd52@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 Mar 2021 13:12:59 -0800
Message-ID: <CALvZod5YOtqXcSqn2Zj2Nb_SKgDRKOMW4o5i-u_yj7CanQVtGQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] memcg accounting from OpenVZ
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> OpenVZ many years accounted memory of few kernel objects,
> this helps us to prevent host memory abuse from inside memcg-limited container.
>

The text is cryptic but I am assuming you wanted to say that OpenVZ
has remained on a kernel which was still on opt-out kmem accounting
i.e. <4.5. Now OpenVZ wants to move to a newer kernel and thus these
patches are needed, right?
