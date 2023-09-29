Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371637B39E8
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 20:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjI2STV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Sep 2023 14:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2STU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Sep 2023 14:19:20 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAEF136;
        Fri, 29 Sep 2023 11:19:18 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a269637b98so50901839f.3;
        Fri, 29 Sep 2023 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696011558; x=1696616358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9pPpA5pmuFeJG1c7aMaJvfIq7FGjwIYQkXGwJmZbUA=;
        b=HkgbPhF51lRc1kGEbl99BlqZiZSG24w3ozbDP2HimnIXK97DY9+Sd9nm9y+MFnU5or
         L3/D974vga2P0ziZAycgwEyODBY6A5qjxnAf5h67wiZc0Diri+oFb5UqnIQgq3p6QWMz
         LtTicM7CVSSXDjbz6LSQrH3tTkZElYwaNplvg/5Q/ldCzWt7KEeEyVg+Hh8JXnVJSPRv
         xPBjMGWmZfWjMVu1ZUXu+M4MHyVl/d+TAsWuXxPosU6X0oPOV0k9A+kHgHqvGuWnoy78
         27jiBmiPiicsOB9IOJV+JkuV+hDI1Iq5mYwCn/tB5GvIAOz40v4QdYwMbNWQhKzNuMgE
         OehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011558; x=1696616358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9pPpA5pmuFeJG1c7aMaJvfIq7FGjwIYQkXGwJmZbUA=;
        b=H4d7KLn1HVNxhq0LAvjY1/iEFySKPwFLmnRlhO71I2B1twqe4tU5CdsPL6hBhK0no+
         Fe1HdMatjK6Lxz8UGMh03mqi+oXbfLU8Ja4heE7+i7pAbuJmNqfTA6YmfXOMkEQu6F5C
         FgFdEGiBHSCTG6ecfPX0WxhKVSiFXHYFXE9j7CJa5QUTBUL3UfXdOwDOIa1x2y/ov+PJ
         z0I7BYro6me8Ix9OKQdKVuZo8oN1Unq8rG6VEi0Xb6B7yq1uubuKm+itAiwZMu68lfUv
         0owkyOCtKo6tvW7zZ/K5YbZAfM8T3pEBxQdDOe8kK0+2vS7eRRDO2KUVIztIkzwqwUlz
         mAdQ==
X-Gm-Message-State: AOJu0YwCe+2xsuuc9ja2C+0YmwSlqDcTvJx+g2y6GSJi0tMnvCc28I1A
        1EZ4MQghc7BzLkd5Rdp3Zvt2/UIVwgfz9hBhUOI=
X-Google-Smtp-Source: AGHT+IF+usraIfwRQLn3D4YSM7xMaiRq+eJ9A16MfTtfifwharY7lp032QtWJzVwmchD2QnvG93ORQptM+kwMwQx8Po=
X-Received: by 2002:a5d:9cd5:0:b0:786:2125:a034 with SMTP id
 w21-20020a5d9cd5000000b007862125a034mr5565463iow.18.1696011558176; Fri, 29
 Sep 2023 11:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230928005723.1709119-2-nphamcs@gmail.com> <20230929181712.3723495-1-nphamcs@gmail.com>
In-Reply-To: <20230929181712.3723495-1-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 29 Sep 2023 11:19:07 -0700
Message-ID: <CAKEwX=Ozp4sTG-g3gT8FCmg4ZAr7ScUoJpODixpRLhmyV1rH-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller (fix)
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 29, 2023 at 11:17=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> This fixlet disables the hugetlb memcg accounting behavior in cgroup v1.
>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/memcontrol.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d5dfc9b36acb..de6bd8ca87f5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7081,6 +7081,7 @@ int mem_cgroup_hugetlb_charge_folio(struct folio *f=
olio, gfp_t gfp)
>         int ret;
>
>         if (mem_cgroup_disabled() ||
> +               !cgroup_subsys_on_dfl(memory_cgrp_subsys) ||
>                 !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTI=
NG))
>                 return 0;
>
> --
> 2.34.1
