Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9302E76C4
	for <lists+cgroups@lfdr.de>; Wed, 30 Dec 2020 08:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgL3HLX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Dec 2020 02:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgL3HLX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Dec 2020 02:11:23 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AC2C061799;
        Tue, 29 Dec 2020 23:10:38 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id y5so14010364iow.5;
        Tue, 29 Dec 2020 23:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dz6zakxhTN9+Hb27qzL2JoTPTR2hDJy3fnAhKgXSzDc=;
        b=gwEYQaCoHeTnnujhW9VMYcJPWPdfkrdzbsXXYBFkSRNkwo8LO5odYwzd841ttNPBA2
         YII/xF3VBYOs8HCqKxa4xEosWWTj76HlHJONYDiLzDOJAGWrNdWZYL3RU9Or+h2exMtW
         SeNnhSt4CAOPu8t3qcLsgqv3APCvREgULe5xYGFpxni60+76S82TohUATfKXCW0JuluD
         eAhyPregxgTVbPwlNyH0/hQR8YEYIxEMxlx714UupvIUoGkmWJ8g1UrNO5plyirkQ1rS
         dO4VfnNV3uvA6Wl9q5wgXjvj4rHvfvlpjG3dXpowyy5pplI8Qc+Z+FNkJobsYaZ4cNrH
         H3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dz6zakxhTN9+Hb27qzL2JoTPTR2hDJy3fnAhKgXSzDc=;
        b=PmxndhcOjRB8MOTXZsRc0vMWh8PgWOCVNjMjSD7bsMcfGrzXsJaTx++SWiqku8wmQj
         TKUBl9OE4xz8w2xglVhRcJ3ry9MBZ5zSFcQpTqUVgL9ckCaTY4HTCuDzNHtbef8FSi7i
         hmq327T2iwqPksHkg9XHMIrRyv2NDwjDiGN6VmiJhvukK4MwxlHwKw2sZa+sxN72fh1Y
         oMeImhNi+RoYoY5QOnezSAAmXoBZrzuFe2fRtudyFlMHWLD7xzkzEpuyyIYbED+M5Voi
         2D835aoqxgozkQUT4PhrifNE7MMDxwy5CfsTB0PXTPaEd616FsMAOY3Wqix5UQXKV4ub
         P7qQ==
X-Gm-Message-State: AOAM531pyMI0y5jJW9Z8PeiqXqCnaKcdZL6hMR83MqacIwR32puAGHy5
        m9k6BqAdOI8ZMv8bNqNkP31qjAuylmmHby/4cdz6AtZPUXI=
X-Google-Smtp-Source: ABdhPJwa1pU0cCC/mMbtuyYhyfQ5lAhEp525njljVUnbH5HwXEXif1suUfiyhTYmnNu3kzqmTRhnt4MBPCVo2RsOBrI=
X-Received: by 2002:a6b:d01a:: with SMTP id x26mr42140401ioa.11.1609312237524;
 Tue, 29 Dec 2020 23:10:37 -0800 (PST)
MIME-Version: 1.0
References: <1609311551-97108-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1609311551-97108-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Wed, 30 Dec 2020 15:10:25 +0800
Message-ID: <CAPSr9jG53xF=9BEYe4phGuyPK7yrtCB57mDwRHzb0s7ic2sGyA@mail.gmail.com>
Subject: Re: [PATCH] mm: fix: Uninitialized variable ret.
To:     YANG LI <abaci-bugfix@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

YANG LI <abaci-bugfix@linux.alibaba.com> =E4=BA=8E2020=E5=B9=B412=E6=9C=883=
0=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:02=E5=86=99=E9=81=93=EF=BC=
=9A
>
> The ret is being used but it isn't being initialized,
> need to assign a value to it, like 0.

Hi Yang,

I didn't see where it was used without initialized.
Can you point that out to me?

Thanks.


>
> Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
> Reported-by: Abaci <abaci@linux.alibaba.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 605f671..15ba17d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3366,7 +3366,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup =
*memcg,
>  {
>         bool enlarge =3D false;
>         bool drained =3D false;
> -       int ret;
> +       int ret =3D 0;
>         bool limits_invariant;
>         struct page_counter *counter =3D memsw ? &memcg->memsw : &memcg->=
memory;
>
> --
> 1.8.3.1
>
