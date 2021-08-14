Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60F73EC14B
	for <lists+cgroups@lfdr.de>; Sat, 14 Aug 2021 10:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhHNIBo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 14 Aug 2021 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhHNIBk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 14 Aug 2021 04:01:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28254C06175F;
        Sat, 14 Aug 2021 01:01:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d6so18803358edt.7;
        Sat, 14 Aug 2021 01:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M8zJWAK5zC502WBtr9TH/CUwQWjnvyStpDdJfvN9iH0=;
        b=nPEBvsm7bss9sW336uGhK2zgsPOoD4EhEfZqf8Z/GnAuZNvLXdGSvRYOfAdT0xbi+k
         MJL0JMED69nRCQZwCX2pLkomk7h0kKRwvDLM16ZeGiZrVwv+v0NbKYq9ewPu1SBx/FSk
         MMUf83twUNvZAL2GCzKiuo5v2Guxz+Xvr3swmLghVitINcXMKbKE8cbB3C3pitekzJlt
         iJMrxMT/2BeNod7KDbQt8Whd0QkAwS743hY1dIDppZhM/KfyrEC0uGEJqR94nKoRdxxX
         tYwrTq/IMmvRytbitlHcSyjHCXwP0xsnTnNZ2GeG6nV1rTNZwewsAJmAzkixM2KQj/ek
         IvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M8zJWAK5zC502WBtr9TH/CUwQWjnvyStpDdJfvN9iH0=;
        b=F9dy1nlFm2pVXFpGMZbe+iPapdbV7hr4a9n18f9td0viz6QPjI9eLKKfEGMJA72Qcn
         uLnMTRhGkbhqwMup6BPYGed70JTA6zsdPS/yT9OTpSyznXUGc/kDp7ZsQ3C/yobZL+Qy
         ECzhYdchPgp48W+MGweKnr+sgoQjVVMfBJEMl/6+whD99HtxPAwlMs24N5PIjpEOsErg
         ralpVS2zQeL1nRqgwtIPIuDq42fdB0sAhSKXL1teTATUPf2asZrMWKPR4uMuxTgAtu8t
         IkBhhuawCX+D2WJJYGIvFz4VCmcqOIhAAhOf46L0Q9jCZVBEXYLa/phuiQXotkaUHd6W
         TDJw==
X-Gm-Message-State: AOAM531oLJ/Cr9ZJtJSaU62fmshTVzUHozIZXksgU7Hs3oa62lNeG8ZX
        8vSr0E9B2m2QgWpVn9cz60pI+Inqx+SDiK8TXEIpM/ACmIWauVud
X-Google-Smtp-Source: ABdhPJy96iMPtLKAhge+HQrINHRM+HE1h2voBaa9+9D8EYGnZm1juQRycHOZb4nLyjJ1ixV3yDpd2NNIyqyu3lPXt0Q=
X-Received: by 2002:aa7:d6cc:: with SMTP id x12mr7847672edr.171.1628928070806;
 Sat, 14 Aug 2021 01:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <1628855870-5070-1-git-send-email-wang.yong12@zte.com.cn> <YRZnMYCN1ArhM3wE@chrisdown.name>
In-Reply-To: <YRZnMYCN1ArhM3wE@chrisdown.name>
From:   yong w <yongw.pur@gmail.com>
Date:   Sat, 14 Aug 2021 16:00:59 +0800
Message-ID: <CAOH5QeDgyDfN2knD+HnfyvOQNbM_9Hz_i98BXF5LqNB33rd+Tw@mail.gmail.com>
Subject: Re: [PATCH v1] mm: Add configuration to control whether vmpressure
 notifier is enabled
To:     Chris Down <chris@chrisdown.name>
Cc:     tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, tglx@linutronix.de,
        peterz@infradead.org, Shakeel Butt <shakeelb@google.com>,
        guro@fb.com, alexs@kernel.org, richard.weiyang@gmail.com,
        sh_def@163.com, sfr@canb.auug.org.au, wang.yong12@zte.com.cn,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Chris Down <chris@chrisdown.name> =E4=BA=8E2021=E5=B9=B48=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:36=E5=86=99=E9=81=93=EF=BC=9A
>
> yongw.pur@gmail.com writes:
> >From: wangyong <wang.yong12@zte.com.cn>
> >Inspired by PSI features, vmpressure inotifier function should also be
> >configured to decide whether it is used, because it is an independent
> >feature which notifies the user of memory pressure.
> >
> >Since the vmpressure interface is used in kernel common code, for
> >users who do not use the vmpressure function, there will be
> >additional overhead.
>
> Could you please demonstrate this additional overhead with profiles or
> demonstrations of other real world effects? Thanks.

Thanks for your reply. In terms of code, it will reduce the operation
of some code.

To  demonstrate this additional overhead, It is planned to use lmbench and
Christoph Lamenter=E2=80=99s pagefault tool  (https://lkml.org/lkml/2006/8/=
29/294)
for comparative testing.

Thanks.
