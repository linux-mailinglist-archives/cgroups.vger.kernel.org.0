Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE23D7B8E48
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 22:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbjJDUoo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 16:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjJDUon (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 16:44:43 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE114C1
        for <cgroups@vger.kernel.org>; Wed,  4 Oct 2023 13:44:39 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65b0557ec77so1169296d6.0
        for <cgroups@vger.kernel.org>; Wed, 04 Oct 2023 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696452278; x=1697057078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsTHf1RxRwyrCT7iXJgHTlu9ULLERBCmiy3t5RYublw=;
        b=jbO9SFz0GDPdCkv7KXlTzoxlH6CJ17RGQi4XWf5P15eIsDJobGsA/jCN2oeHjpMa+1
         2cB604GObaSaBZ2TdbX7xFWSqa9vRiHCQDpjVTaZDVbSA8UaI8g2yZfgkkpi/1tHLDTJ
         cmr8AnhilmFmEsgu06GHA50KIK9utdcjY3lP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696452278; x=1697057078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsTHf1RxRwyrCT7iXJgHTlu9ULLERBCmiy3t5RYublw=;
        b=nFm0n2yEKq1C0zx2XSVGh4KH6L39BCazzgmBeJ8L6CJyjG1mdjOlVNxJ4hKb2RSHjB
         Ebj6aNdxZzgxo43jLb5cpUqSIavLvsc2IPXhLq5z1TTJHTQ5UEmkvIApgdMn3lGBmXM5
         j/PIQoRIjkd9hZelu23W3hnArfeP4j8/OmEvEcU00ugSvQqxOxfnWqU8hPtmJN/v2WyU
         C2ryVv2zxFf/eoeJy08fTEpZtA11kLh/XZ1ZiYTpltqyrqb4lD78t26IxEpSxDjVI/vi
         XjngBWkiI6Evggpf6ZP9j/JbybNR6fCl9I4VaosUq62ziXs9BSyjfdfLacb+dj7P6eGR
         cqiA==
X-Gm-Message-State: AOJu0YzL3f2ZBetX/C7xVOin/j1CE5pOvB5Ccuwpzh4pk8+FdvEi/yQW
        dhCj1MITnBa9RJVP6d4HrQZjVuEEl585udb7+Ovapw==
X-Google-Smtp-Source: AGHT+IFrjbga6HTO0187Z2uEWDzKwuOe649C9EifkHZ+6iwN0Mbzp/HxvvsGWFTnMGdZho6HAlE/Cw==
X-Received: by 2002:ad4:4f04:0:b0:668:d7e3:845e with SMTP id fb4-20020ad44f04000000b00668d7e3845emr2914652qvb.32.1696452278554;
        Wed, 04 Oct 2023 13:44:38 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id l26-20020a0c979a000000b0065cffe12ae9sm1603306qvd.36.2023.10.04.13.44.37
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:44:37 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-419886c7474so20591cf.1
        for <cgroups@vger.kernel.org>; Wed, 04 Oct 2023 13:44:37 -0700 (PDT)
X-Received: by 2002:a05:622a:100e:b0:417:5a8c:a104 with SMTP id
 d14-20020a05622a100e00b004175a8ca104mr69912qte.26.1696452277267; Wed, 04 Oct
 2023 13:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
In-Reply-To: <20230928015858.1809934-1-linan666@huaweicloud.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Wed, 4 Oct 2023 13:44:26 -0700
X-Gmail-Original-Message-ID: <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
Message-ID: <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     linan666@huaweicloud.com
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 7:05=E2=80=AFPM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> When the throttle of bps is not enabled, tg_bps_limit() returns U64_MAX,
> which is be used in calculate_bytes_allowed(), and divide 0 error will
> happen.
>
> To fix it, only calculate allowed value when the throttle of bps/iops is
> enabled and the value will be used.
>
> Fixes: e8368b57c006 ("blk-throttle: use calculate_io/bytes_allowed() for =
throtl_trim_slice()")
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Closes: https://lore.kernel.org/all/CAGVVp+Vt6idZtxfU9jF=3DVSbu145Wi-d-Wn=
AZx_hEfOL8yLZgBA@mail.gmail.com
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/blk-throttle.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 38a881cf97d0..3c9a74ab9f0e 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -730,8 +730,10 @@ static u64 calculate_bytes_allowed(u64 bps_limit, un=
signed long jiffy_elapsed)
>  static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>  {
>         unsigned long time_elapsed;
> -       long long bytes_trim;
> -       int io_trim;
> +       long long bytes_trim =3D 0;
> +       int io_trim =3D 0;
> +       u64 bps_limit;
> +       u32 iops_limit;
>
>         BUG_ON(time_before(tg->slice_end[rw], tg->slice_start[rw]));
>
> @@ -758,11 +760,14 @@ static inline void throtl_trim_slice(struct throtl_=
grp *tg, bool rw)
>         if (!time_elapsed)
>                 return;
>
> -       bytes_trim =3D calculate_bytes_allowed(tg_bps_limit(tg, rw),
> -                                            time_elapsed) +
> -                    tg->carryover_bytes[rw];
> -       io_trim =3D calculate_io_allowed(tg_iops_limit(tg, rw), time_elap=
sed) +
> -                 tg->carryover_ios[rw];
> +       bps_limit =3D tg_bps_limit(tg, rw);
> +       iops_limit =3D tg_iops_limit(tg, rw);
> +       if (tg->bytes_disp[rw] > 0 && bps_limit !=3D U64_MAX)
I don't think this change is sufficient to prevent kernel crash, as a
"clever" user could still set the bps_limit to U64_MAX - 1 (or another
large value), which probably would still result in the same crash. The
comment in mul_u64_u64_div_u64 suggests there's something we can do to
better handle the overflow case, but I'm not sure what it's referring
to. ("Will generate an #DE when the result doesn't fit u64, could fix
with an __ex_table[] entry when it becomes an issue.") Otherwise, we
probably need to remove the mul_u64_u64_div_u64 and check for
overflow/potential overflow ourselves?

Khazhy
> +               bytes_trim =3D calculate_bytes_allowed(bps_limit,
> +                            time_elapsed) + tg->carryover_bytes[rw];
> +       if (tg->io_disp[rw] > 0 && iops_limit !=3D UINT_MAX)
> +               io_trim =3D calculate_io_allowed(iops_limit, time_elapsed=
) +
> +                         tg->carryover_ios[rw];
>         if (bytes_trim <=3D 0 && io_trim <=3D 0)
>                 return;
>
> --
> 2.39.2
>
