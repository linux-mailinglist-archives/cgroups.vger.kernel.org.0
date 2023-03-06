Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734DB6AC7E6
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 17:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCFQ1z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 11:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCFQ1u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 11:27:50 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A31868E
        for <cgroups@vger.kernel.org>; Mon,  6 Mar 2023 08:27:17 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id k23so8692671ybk.13
        for <cgroups@vger.kernel.org>; Mon, 06 Mar 2023 08:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678119968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oquj9zczWta39dkibg5GfP7EL+Ye+DwkctVIeTmEPfU=;
        b=bosj6vnLUEt0XF9hTitW9opaoGtgVkZRNCeGSYikHGh3TN+eYxRp69ZbhlogPQt3FC
         8+rYgTRXE1ny3erHUDalB0QrgQcH8attkXk+h1d2LtKytFU8zc8Pfma1exRiysE8xxTq
         oMF80ZLxkA2wZf2Lm3emXf73HHEVNb7Dxy2mPqbtX4uvytvi41oLdUwW5V6fpqzYeGbX
         X+vayVe/4cTpkB5QiIc48PF7K8R2Hb/423TKKHaptnPZ5AOBhPwL7PTzyQkDVPxXiV0J
         ImE7y9Qsd+bXutgMq2XH3h21VjyFBpDzN2BVXtPNSZ1nX2TSuzooHCJh0aW5l141RdfQ
         g6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678119968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oquj9zczWta39dkibg5GfP7EL+Ye+DwkctVIeTmEPfU=;
        b=35BkFiauqKN+79xbTq0nXAvBniO9qB7SNGkPjuxl0he4e4gs1g0jOGq5M8RPPVRthW
         YkaLAW2y7HH7btC8BJBN6XUBZn52C9vbbY3/bfSHO3dMHdCua1O6XU3aeMgd3SBkSHU6
         MKrYls70ud/Up9vkHj1+RIYcGZYLy6TmQE6DMt3FCi9D74gRiryPQz33mmFTGNdaYokL
         Mayn6OIb67BXOZqCAZ+MLhM/K9g1+I85YZH7iUJrAFpWx7JjRiCrxLcQK/EUGJy/dKkR
         74tObS2Ktr7SepLaBEIFpxmDFtSMLTHtfxj+aOebVWAk40+AFxnPo3wKQR+GIhKejDVr
         F8zA==
X-Gm-Message-State: AO0yUKXn6kfDau3Ciq43ZLN1LaaY263Sq0ntVpmaZoqIl5++hy4aEhG3
        U6ecB7XL5Mv/njbTESXYd58YADjZGFHnGGPAGW74uhIfTku6L/uZl40=
X-Google-Smtp-Source: AK7set/bl1YCDuzZbRLxZZxYYgRLfDhfUgKFQPGCZLcWXBeJhSMqG+AOOEAHAovSQFDOkZMkYqcVs2oCTW3epOUAtvw=
X-Received: by 2002:a25:7808:0:b0:a4a:a708:2411 with SMTP id
 t8-20020a257808000000b00a4aa7082411mr6589900ybc.10.1678119968601; Mon, 06 Mar
 2023 08:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20230306154138.3775-1-findns94@gmail.com>
In-Reply-To: <20230306154138.3775-1-findns94@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 6 Mar 2023 08:25:57 -0800
Message-ID: <CALvZod5z4F=mS=kgd4DOy8HHCDpL--hxw2uf_bjE+7Svs5ps_g@mail.gmail.com>
Subject: Re: [PATCH v2, 0/4] mm, memcg: cgroup v1 and v2 tunable load/store
 tearing fixes
To:     Yue Zhao <findns94@gmail.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org, mhocko@kernel.org, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com
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

On Mon, Mar 6, 2023 at 7:42=E2=80=AFAM Yue Zhao <findns94@gmail.com> wrote:
>
> This patch series helps to prevent load/store tearing in
> several cgroup knobs.
>
> As kindly pointed out by Michal Hocko and Roman Gushchin
> , the changelog has been rephrased.
>
> Besides, more knobs were checked, according to kind suggestions
> from Shakeel Butt and Muchun Song.
>
> v1:
> - Add [WRITE|READ]_ONCE for memcg->oom_group
> v2:
> - Rephrase changelog
> - Add [WRITE|READ]_ONCE for memcg->oom_kill_disable,
>  memcg->swappiness, vm_swappiness and memcg->soft_limit
>

Thanks Yue and for the whole series:

Acked-by: Shakeel Butt <shakeelb@google.com>
