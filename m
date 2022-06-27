Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E102455B5DD
	for <lists+cgroups@lfdr.de>; Mon, 27 Jun 2022 05:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiF0Deh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Jun 2022 23:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiF0Deg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Jun 2022 23:34:36 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0325585
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 20:34:35 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3176b6ed923so72824447b3.11
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 20:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udYx9yVhBp19zfd4dxd6NWb/kHxWi5c9y7nXzGrjJEY=;
        b=Ntxnvqwm+4atSA7oH8HbS0qWbiyLl9hwKQPjhaoe5CikG0EkSFeR0jzF9Fwgs89O4j
         ozapg21g9OejXt5DBNn8WHlCY7d3wYaGk6oVysdhLX5uDoB0lr4Yj2j5BFkI8663a8CI
         vEn9f5StKVKnsH4GCtCWGuUIEclxpY7VETIg4LAbikp2xJIoxYRU/G60aZC+L5uz0YMX
         gAFxNaaPYcAbhKgIJuuMQXi6TMfdYpZvDjd1AL92PLhymq6SZ1HHzQqn1/sc6ctNL/67
         0YEX5l2JvW2MC4YiaTeERP3HtTy2l0iDOGc3MhIAtFpGeaEHSo0XcpN+idqgqzAYWKXG
         v33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udYx9yVhBp19zfd4dxd6NWb/kHxWi5c9y7nXzGrjJEY=;
        b=FENWcwAqPXHtw5Daovq8BwR4Ec+EwdmnPLtIp4vVSyOHeVxxb6gQVTg2z/RsGGNJBy
         YiPI0J3qZqJzcBh9ygBKqoCBCCCYHHXO9AR2/vTDG7zpAEr8e37tBOXy8zNDYULstW8K
         eWb6VopgdZWuiSB400qRJdd0fjOMgEHzxGU+g/UI1OmlYpnQQxRbUO3bn5GsPRYVtRXK
         KDvzRf8iSX3vveHWisywt6yuHUFkveVc1+3bjJm4VtR0KDvOGkB+vZxYLIayxg2PpHUg
         g1Lj/aDQsoCn8g7SJtnxg6d28NkyPGJX3r+aSyEtiKehAlj92f3LdIUgYXd+qPcS6/qi
         wlpA==
X-Gm-Message-State: AJIora+ID6AlmU87IaB02GedUpYq+DB3Z0uwGcRixF2yGlcoXK6vl23e
        u//sYwGCsK0FK/3qU+mNSbxU7b4ZbhOwA9HGX/Xg1A==
X-Google-Smtp-Source: AGRyM1u1N/MM546IwEfu4pxLiWE2+9UtIyWwwrr/JEDz3XtCt5/tu6Z+IVxr9dZDJZdt/Z3XI5k3yf+zQdPyps+kfFc=
X-Received: by 2002:a81:5e42:0:b0:31b:6254:1c2b with SMTP id
 s63-20020a815e42000000b0031b62541c2bmr13394314ywb.35.1656300874622; Sun, 26
 Jun 2022 20:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <186d5b5b-a082-3814-9963-bf57dfe08511@openvz.org> <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org>
In-Reply-To: <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 27 Jun 2022 11:33:58 +0800
Message-ID: <CAMZfGtWrqFiXUtGkhQwuR3wk1a8xH4Z1+B8zCwRTzny7EJGG-Q@mail.gmail.com>
Subject: Re: [PATCH cgroup] cgroup: set the correct return code if hierarchy
 limits are reached
To:     Vasily Averin <vvs@openvz.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 27, 2022 at 10:12 AM Vasily Averin <vvs@openvz.org> wrote:
>
> When cgroup_mkdir reaches the limits of the cgroup hierarchy, it should
> not return -EAGAIN, but instead react similarly to reaching the global
> limit.
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
