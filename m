Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3008779C99
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 04:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjHLC33 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 22:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLC32 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 22:29:28 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E15122
        for <cgroups@vger.kernel.org>; Fri, 11 Aug 2023 19:29:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40a47e8e38dso83051cf.1
        for <cgroups@vger.kernel.org>; Fri, 11 Aug 2023 19:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691807367; x=1692412167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDyw1JjcpV1wN7RXJDPu6qRAhGishkYEQXNXltLrwqE=;
        b=xrwp0+Iccpn6Uin6XRwUTuUWAnIphWW88ckS5UVuoJHR53Wz4zPgauLVAlS8ea/reh
         P6nCQPt5kk6qpeaA28ylijv9M1ShXu/CQqeQ+unDlr0l7ODJE/MVNy5LJ5+miYzm65P9
         ewYg0S91YpN/MM4udZ/TrSppR0VBaO7ppUTPtx0pb5l3K5N7GVVdXKZiEq0tn1RYFgXP
         22jsWQQsasyrgLUu0kJVAOTTuh/0o+1lwGAChd7eiyHLTE/Sdpv9fYOhS5yqRPkh2juo
         x9QW7u/JQydETf6QqHhl2k+BhQrQm92GwgG1crEWzw1n3TWeJPmiJVe8O8IQsfGc2YXP
         y1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691807367; x=1692412167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDyw1JjcpV1wN7RXJDPu6qRAhGishkYEQXNXltLrwqE=;
        b=bubYaxJq0yAKvh8yccVmXqZQUhtOlD4gwlilekEUHmU1Z69YdQOu9aTOqD3CupcyLm
         x1TaJd0/B4NV/mBez9waVbcuB6iEO9a7T/LJb8F23bzOPOV8emiRsWBoP48mykOufO39
         mH2oe+TgVPyPwtqLH6zdj8NctolztpymDQUlfAtpyOBgHriTsy8ghOqUaphAo2Q5vF2s
         UWMC7cgO/R9d9ElinKCaeidNT7bgKnqFeCmQcC5r0u+I2D+905TtWjmXT9ghoqY1ZBCj
         cSULLvLvI1ZtTaEUkKQ5GxWE9KUyoSrvX8Txvg1eWgH6anMeZTP2X6otvZ+UUHMjax0S
         2TaA==
X-Gm-Message-State: AOJu0YwlLWwHQi0iuIIYM6Zp9BKPuS42Ob3HA5lfkxdKJzw5Li4VCTec
        irxIZ6ilsbBFcypwyv1pT9X2B1W8uDLOABTaa0gCGg==
X-Google-Smtp-Source: AGHT+IGZqawJEl//8Xrptw/LxwGlWIjxY/GblVrivPdDAihIFBUHvwT8i3TMcbnX7n6nETRTKzQ0LxMm2xnWtX4QIUA=
X-Received: by 2002:ac8:5a15:0:b0:405:3a65:b3d6 with SMTP id
 n21-20020ac85a15000000b004053a65b3d6mr325349qta.13.1691807367233; Fri, 11 Aug
 2023 19:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230809045810.1659356-1-yosryahmed@google.com>
 <ZNNTgZVPZipTL/UM@dhcp22.suse.cz> <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
 <ZNONgeoytpkchHga@dhcp22.suse.cz> <CAJD7tkb9C77UUxAykw_uMQvkzGyaZOZhM0nwWn_kcPjV0umyuA@mail.gmail.com>
 <ZNOVS0Smp2PHUIuq@dhcp22.suse.cz> <CAJD7tkZFxbjas=VfhYSGU84Y5vyjuqHqGsRjiDEOSDWh2BxNAg@mail.gmail.com>
 <ZNYnx9NqwSsXKhX3@dhcp22.suse.cz> <CAJD7tkbJ1fnMDudtsS2xubKn0RTWz7t0Hem=PSRQQp3sGf-iOw@mail.gmail.com>
 <ZNaLGVUtPu7Ua/jL@dhcp22.suse.cz> <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
 <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com> <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
In-Reply-To: <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Aug 2023 19:29:14 -0700
Message-ID: <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 11, 2023 at 7:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
[...]
>
> I am worried that writing to a stat for flushing then reading will
> increase the staleness window which we are trying to reduce here.
> Would it be acceptable to add a separate interface to explicitly read
> flushed stats without having to write first? If the distinction
> disappears in the future we can just short-circuit both interfaces.

What is the acceptable staleness time window for your case? It is hard
to imagine that a write+read will always be worse than just a read.
Even the proposed patch can have an unintended and larger than
expected staleness window due to some processing on
return-to-userspace or some scheduling delay.
