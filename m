Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A3D52AF9B
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 03:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiERBEv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 21:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiERBEv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 21:04:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F375C5401B;
        Tue, 17 May 2022 18:04:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id er5so1039731edb.12;
        Tue, 17 May 2022 18:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cGbIZ0WjSw2ZJa647FvL8buifxBLVMmodCe2ePJMeJM=;
        b=NorNrwCZP1aJ/u2RVDG9zK0qpsF3l1n2Vx79ANbCZTXP1MuDNkyoGmYJE3J4L2g6JF
         ZD80dJOmGCe2z4I8I7bizk/FHdX0bwcCt+dEcYAFmltKL6f8/rZnktPPuFPHwDFMzCPB
         rDuNjFOeNv9W0gufxxvk0CI7C8P7qfQOwkGBkAYPsXa9FHjHognB0BqIFrZ+GMCTOpLi
         eNjxITHqU9P5GRBwcnCsywD8kPBTu68U83wkRuZ3B/pCwtCgw+gIpZLmPIDvbeK6tVxO
         afFPfkpp2D5HTzX6DbC6wQOuUi++Ma6gAjtloUl3vUjphBPvbXEBC/kVnZ2nS/lmuXG3
         gGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cGbIZ0WjSw2ZJa647FvL8buifxBLVMmodCe2ePJMeJM=;
        b=KIFpT+VDtZLHJ87h7i0VElMQSWwDu2gOusN+um6KePa4wevq0ObclVum67GOfhlB4o
         itiJBRkmQT90X9jWNAx/kxUTiQmS5X47/FUjOP99bYa6UpoiqfCa1hS8HGjRVCvJtxse
         TDlTYVy7U1WoHvWt+D+P2KuuuQhIyQ7uIati0EqgD4MT2/y23Z39HgAvopv2ZL0yg4m6
         wyzGTvWz6UCAC7kOtby6V9f9JDkxLWOKGMKedCf/iAEwp4gqd+m+vf4hiGuzFjggJ5pZ
         gsibnZqHqsfqy/Lf0X+bFnjJjMFWRJ1PL0I0M6LLS0vUHbbv/hNE+GmTmmKxSmlEh9W/
         e9Og==
X-Gm-Message-State: AOAM530zRWvNrvhRnvhg3zeyp8E6ehaPGs20d9d3Hx68KEXfESn0I9vU
        6cVY1uc/kLnhu3IXJMom+vNmLRiMJYo/CFIgxyU=
X-Google-Smtp-Source: ABdhPJyvtzFSCEhDZPT4YaHd8kEkqbVIx3ENmQgv/A91tQnntTVhQOm9MoHyMsfHv5GGdOsxhOhpliDjh7q1pLciy8o=
X-Received: by 2002:a05:6402:176b:b0:42a:a828:5d79 with SMTP id
 da11-20020a056402176b00b0042aa8285d79mr17334145edb.272.1652835888521; Tue, 17
 May 2022 18:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220517073106.1704628-1-zhangshida@kylinos.cn> <YoPWWfoZ+6PrHuJl@slm.duckdns.org>
In-Reply-To: <YoPWWfoZ+6PrHuJl@slm.duckdns.org>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Wed, 18 May 2022 09:04:12 +0800
Message-ID: <CANubcdX7rvnWPd6BfLsHpchxCtmbg67mARHQbJXgpr6Ezkm1jQ@mail.gmail.com>
Subject: Re: [PATCH] cgroup: fix potential null pointer risk
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        zhangshida <zhangshida@kylinos.cn>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Tejun Heo <tj@kernel.org> =E4=BA=8E2022=E5=B9=B45=E6=9C=8818=E6=97=A5=E5=91=
=A8=E4=B8=89 01:07=E5=86=99=E9=81=93=EF=BC=9A
>
> The function is never called for a root cgroup. The parent check up above=
 in
> the same function is superflous. So, maybe remove that?
>
> Thanks.
>
> --
> tejun

Thanks. I will remake a patch based on this.


--
Stephen
