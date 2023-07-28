Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3DD766B30
	for <lists+cgroups@lfdr.de>; Fri, 28 Jul 2023 13:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjG1LAd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jul 2023 07:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjG1LAc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jul 2023 07:00:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EE82701;
        Fri, 28 Jul 2023 04:00:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5227e5d9d96so2549482a12.2;
        Fri, 28 Jul 2023 04:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690542030; x=1691146830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PDIAfFUsFD3vbVEGsI9j/0thKIcvauqk+miCMI9pQM=;
        b=EyPBQM6RQ+S/JnVzhATw135UHbUhW8+sWivasIl3uNELayYfb/H4HnRU39ec857gzw
         8A7rjGpjYCWQKiIx2Vg+q9vtj+kz9jskd2QF+yToV+zGB3t8+kJuPq4pSmChm3PGYPXl
         V8HL1aB1yXPxOOLgnA1akWOvRDGg5VYNnTHL+e0he1bhaIfkvWG4mbhnxmJrvccjQchU
         SEfgXTN6AwH3fH3Z2JtEAbJXfrEneognCK3lvrNMcy65uQXsyij04M5hs/d18x6EnT7I
         x2oKDDypouEfGRjiNPevP2O4xDEaIypQDU/3yRECJMsejHoem4HiHGu27dtX9a54Nqah
         N+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690542030; x=1691146830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PDIAfFUsFD3vbVEGsI9j/0thKIcvauqk+miCMI9pQM=;
        b=B+QxWzeeUX0sBnjF++ZuLP2nlyZUFt5QiRVBpJjaK51yiI6s4Obd9jYTz59CEy3iaF
         60aWvNlwbcz9v8/HyLhrueswgXXC/Yar3T+nSvPbRGQifQZNPm20dJnX/2tHsV9cXSw9
         qaXFChEiAsAmM+bz2/bCGmYA0VQc5XcU9W+qfi8OUOXF6GcsSf4B2VVuZCu221y4ZBNs
         XL/7Dw7XXonI6XzPbIVPXTXAtH1beGg7NxSMXfoUS5W39toB01ydcRrhLoBjNT+7NBzG
         gEFbyMgorn5ZXqTH9z1JzMOJnxz97smsYru9DnbiJdCC9wZde9S/2foBDhbgl44LWw0X
         QVFg==
X-Gm-Message-State: ABy/qLYOuHp9vm4tbY5awHhzcE99SNbspzbMIHyMb/dMZJAc+9qRE86q
        dcNqT4abprHivzr9yqu2YBqLkC4+MDrjyxVqLag=
X-Google-Smtp-Source: APBJJlEghzB5bMgXT3leW5ZT0+gEjuoBiA4sez83WtaUcSOtr4hVGqaTHDCNdeMru3uWWlbEwaEeMFrzkTvqeODaISA=
X-Received: by 2002:a17:906:2cd:b0:99b:c845:791d with SMTP id
 13-20020a17090602cd00b0099bc845791dmr1812151ejk.76.1690542029590; Fri, 28 Jul
 2023 04:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230728105723.251892-1-krzpaw@gmail.com>
In-Reply-To: <20230728105723.251892-1-krzpaw@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 28 Jul 2023 13:00:18 +0200
Message-ID: <CAKXUXMzYyX9rz-=K=1YRRbpOAechRG4U+i5BbX8qagH2epTgXw@mail.gmail.com>
Subject: Re: [PATCH] docs: cgroup-v1: replace dead CONFIG_MEM_RES_CTRL_SWAP symbol
To:     Krzysztof Pawlaczyk <krzpaw@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jul 28, 2023 at 12:59=E2=80=AFPM Krzysztof Pawlaczyk <krzpaw@gmail.=
com> wrote:
>
> Commit e55b9f96860f ("mm: memcontrol: drop dead CONFIG_MEMCG_SWAP
> config symbol") removed MEMCG_SWAP as it was just a shorthand for
> CONFIG_MEMCG && CONFIG_SWAP.
>
> The commit also adjusted the documentation but missed reference to
> CONFIG_MEM_RES_CTRL_SWAP, which was the previous name of
> CONFIG_MEMCG_SWAP before renaming in commit c255a458055e ("memcg: rename
> config variables").
>
> Update the reference to the current state.
>

Thanks for the cleanup.

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Lukas

> Signed-off-by: Krzysztof Pawlaczyk <krzpaw@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v1/memcg_test.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documen=
tation/admin-guide/cgroup-v1/memcg_test.rst
> index a402359abb99..1f128458ddea 100644
> --- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
> @@ -62,7 +62,7 @@ Please note that implementation details can be changed.
>
>         At cancel(), simply usage -=3D PAGE_SIZE.
>
> -Under below explanation, we assume CONFIG_MEM_RES_CTRL_SWAP=3Dy.
> +Under below explanation, we assume CONFIG_SWAP=3Dy.
>
>  4. Anonymous
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.25.1
>
