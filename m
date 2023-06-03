Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B513720E80
	for <lists+cgroups@lfdr.de>; Sat,  3 Jun 2023 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjFCHgz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Jun 2023 03:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFCHgz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Jun 2023 03:36:55 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBE41B4
        for <cgroups@vger.kernel.org>; Sat,  3 Jun 2023 00:36:53 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f804665702so106301cf.0
        for <cgroups@vger.kernel.org>; Sat, 03 Jun 2023 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685777813; x=1688369813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUND+da6jPiEZt0cfKognqgQRJ86LBwupcOXaX1hrLc=;
        b=VE46kVI2oIPTsZQ3yann7Au1KxFUj1nnFC+18MB5AqtniFnmSHWd1y1BXsjKsUwm+u
         Ozkr1Fu04aLS6kfxawtnRVfdkElUMVB6/BauC46cNNtSjC7P/UA9xEl74ZJP4URW0RND
         rk0Iiykc0ZL5UbkzaajOyqatihTO1jw8jKbx+cJ5xiDrbBA8EYif5JnBmJObGk7icRw4
         NfAwuBlR5lBxPgg4cEw1o4jI9HyazTql6te3QaGXS3SMhj52QcJYxrzji3wa1diaDMML
         iEYaLuhJHi39hiGGgXb1swQjwl7o78WAwN0plU6i6piYAymxjyiR3XTRPKncDXW7ai+2
         x6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685777813; x=1688369813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUND+da6jPiEZt0cfKognqgQRJ86LBwupcOXaX1hrLc=;
        b=LLqKhdB5I6YODcPcgCv342kx7/MDCiPstqQilxxpqQwGHPaG4jCsfraxQlvT2k7hpQ
         vgsyR2gL04YivOVUKsdcTYv1rEkClL+gIRjJYhdQAJ1Jyho2X4m/HdhOmVPrH+j8RM/Q
         rpJNzzE47VR8NMW8sgUtj2tZEsDqFmmuEZ6KkcHs7q3Fpx1CakSMq+0CcuC644XUaKdz
         G6t4Qt2FUZXMizb4kYeX4MnpEQnYrWEM5dpFkRRJ+OWprMzhDKstJhMNQPHnXwNrySQ5
         pt6A+ZnwQ17nyeP3ptk6f4oWkJNGPzIrYj1zK3136YmM4Y5lAa3zAnkErT4600s24Vlp
         P/BA==
X-Gm-Message-State: AC+VfDxPY3Sh6DprZQU80stXNr7144f/ONoS3kU7Hx4qLSeWu2llaOCT
        jewlaH6tz7xFDOI8mi620gLTSZrBh+giP8O8tLamF/0NzQlzF5C29DI=
X-Google-Smtp-Source: ACHHUZ6I6H13jR3j7FRGhw5gTeO9K2llUEgho3hmspahu6mqRnuRNV6MU65MQKj3kBr+jV7kdmRqkEjpjCg2jWvhW3E=
X-Received: by 2002:a05:622a:295:b0:3f0:af20:1a37 with SMTP id
 z21-20020a05622a029500b003f0af201a37mr338498qtw.15.1685777812715; Sat, 03 Jun
 2023 00:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230603072116.1101690-1-linmiaohe@huawei.com>
In-Reply-To: <20230603072116.1101690-1-linmiaohe@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 3 Jun 2023 00:36:41 -0700
Message-ID: <CALvZod6Qa5doN7QJAbr+vtPByyqoPoPiOJAdecT7gnO5+AZnNA@mail.gmail.com>
Subject: Re: [PATCH] memcg: use helper macro FLUSH_TIME
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jun 3, 2023 at 12:21=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> Use helper macro FLUSH_TIME to indicate the flush time to improve the
> readability a bit. No functional change intended.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
