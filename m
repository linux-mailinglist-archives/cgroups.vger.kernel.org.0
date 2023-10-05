Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16097BA7D1
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjJERVu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 13:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjJERVL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 13:21:11 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFC130EE
        for <cgroups@vger.kernel.org>; Thu,  5 Oct 2023 10:15:22 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d81adf0d57fso1370410276.1
        for <cgroups@vger.kernel.org>; Thu, 05 Oct 2023 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696526121; x=1697130921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kZZ+LzTQhw7SnaWxRb1LSoI3AuNMSpArazM0mZwyHk=;
        b=jFAzAjhe//Btj9YfCdZ4387UR49Vd+7ggJwFZ13BjOPQeN9j1s9FpTpO7aM6nNp5id
         Aml1Yeu6QV4t0/jbppFGa7n+Tk4BjXgFOBrN/i7+u9WF+c5E+6aVZl4CB+vULu3W3e0d
         Xkrj8WwscBRlLoSsRLAaMU+fMV+qsyidhpe64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526121; x=1697130921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kZZ+LzTQhw7SnaWxRb1LSoI3AuNMSpArazM0mZwyHk=;
        b=sA3ZTESDXLqDf9mbo8EtUJ5FnGJFXnNEp75qgbGYQazE+vSTXh0nLBoQVindVVcXay
         B79M1AGfVidPkD5v70G2sBn+rUmPnr7bnUNPnm7R6Ab8qqDfdcXYeWl+9rJmPS/aq5hy
         42J14eqRpdKnT8N17GUM/6YzLEUMrV3P3xLd84WdN40OFei6VxL+E4w7oR1dbr+Oh+/o
         UpdpWFB1SB0m02bYqmKRw/Mb3gWBotgu50K08HJmLRmpDcYhnMF6UpsZIzZHwXtb66Mn
         iljtLQkA3+oatkyYGr127CS5VffA35B67q4VXmVrKrk+lo1stbOOKzeFuaJsSqFf6AVD
         PDYQ==
X-Gm-Message-State: AOJu0YzW0lv+AuY8fbFePLUEMysrdAsjTJibKleXcuV2k46ONThYcEXv
        n6K0fHgmcHwRrY948OqDSO1kSt0lTj6PzFJal7M=
X-Google-Smtp-Source: AGHT+IHDoBZT3hL9zLItaY7kbV6DwfUIFLBoYKIMSNZp6KmsdRPYEoMhyLuKIQ5vpclMRviMCKsEag==
X-Received: by 2002:a25:bbd2:0:b0:d91:b6e5:54dd with SMTP id c18-20020a25bbd2000000b00d91b6e554ddmr3534315ybk.3.1696526121121;
        Thu, 05 Oct 2023 10:15:21 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id q11-20020a0ce20b000000b0065b13180892sm648973qvl.16.2023.10.05.10.15.20
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 10:15:20 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-419768e69dfso22411cf.0
        for <cgroups@vger.kernel.org>; Thu, 05 Oct 2023 10:15:20 -0700 (PDT)
X-Received: by 2002:ac8:5786:0:b0:419:79c0:ef9a with SMTP id
 v6-20020ac85786000000b0041979c0ef9amr180288qta.6.1696526120141; Thu, 05 Oct
 2023 10:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com> <20231005170413.GB32420@redhat.com>
In-Reply-To: <20231005170413.GB32420@redhat.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Thu, 5 Oct 2023 10:15:06 -0700
X-Gmail-Original-Message-ID: <CACGdZYJm312U70ysC_vpv=Pat063R=mRRVQGBiLocKc+QCkjnQ@mail.gmail.com>
Message-ID: <CACGdZYJm312U70ysC_vpv=Pat063R=mRRVQGBiLocKc+QCkjnQ@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Li Nan <linan666@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
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

On Thu, Oct 5, 2023 at 10:05=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> sorry, didn't notice this part before.
>
> I am not a asm expert (to say at least;) but
>
> On 10/05, Li Nan wrote:
> >
> > When (a * mul) overflows, a divide 0 error occurs in
> > mul_u64_u64_div_u64().
>
> Just in case... No, iirc it is divq which triggers #DE when the
> result of division doesn't fit u64.
Yeah, sorry for my incorrect wording here - but we're probably seeing
exactly that the final result doesn't fit in u64. (I wasn't familiar
with the intermediary registers here, thanks for explaining)
>
> (a * mul) can't overflow, the result is 128-bit rax:rdx number.
>
> Oleg.
>
