Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFBD6FEBD0
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 08:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjEKGjG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 May 2023 02:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEKGjE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 May 2023 02:39:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED70A103
        for <cgroups@vger.kernel.org>; Wed, 10 May 2023 23:38:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f315735514so271109885e9.1
        for <cgroups@vger.kernel.org>; Wed, 10 May 2023 23:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683787117; x=1686379117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYtaRcshlY3QmxEEqVJsJU+0bmCyXLBCJqkTVjmG1hA=;
        b=d0SnZ+pjyye00WmokuVRn85o0hU1sSEe2pqirea4ZcrpkfnFfRYD5NIGNnwLArYw3e
         iv64Az5W7Mu6DGr5zAJF0G8CcBCqF+sF384FS8jxP5axqWOpR9v+E5hN6C+C43h/hTNT
         0Yx7lFxm3QbgqJZg7f+9vk4JZk/9f4SujuFsWm4dfd9cVPLYUwMwbnjJFjr+VvzXVno/
         jRtlFY3mjWUXLzS3+M7/j9KC/kW7xmujUlxKN60lZpZQNRCgUXJwiyhSzBdtnmEbV+u8
         spumpdd5/+/4H/V5/yepOz9LH8iOQZNj3AK2Py3JcECSr0I5tTJe9mQ7GWgdn6jT/Psc
         i6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683787117; x=1686379117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYtaRcshlY3QmxEEqVJsJU+0bmCyXLBCJqkTVjmG1hA=;
        b=eMV0lEASNWADe5lxGlxse3D9OOhRHkQVTOYdYLeYRPUyhRS8p0IfCCj9GiLyMUQy+E
         gGjgkbaeg/JD1ewJ2cyjmiCYt4p4AjcEAEYPW3MENTfgvS/t9AqKxwGkT8NTqao/H0zr
         eBbtbSBBdHEIcryg298ZKuTVD3hOGpVqeDDG46/ZobuIG+5PpGFd5OOsbeFk2eIpBjC/
         VByDANmn+VbOCAJaIc9bNpSkgh21vEOyyxwsq/K60hHQvqpodp3VqmfJkgYfCo8bPlh4
         u0TlTI9qlaAI0s3oc6b0YrHcvEGluiLdO3+9C1hByMBs7/uW3XDyHd/xMfkSyQJtAjPD
         OL5Q==
X-Gm-Message-State: AC+VfDz0dc654kSIWSnH6W8Glfo6z7wEqCBpXnZSsMXE2+JwxSI8X1Gy
        +jHy4Y2QVrDbL5NPAtaPpDkzB6wmugaHbI0QPKxKcg==
X-Google-Smtp-Source: ACHHUZ4kMqG2j46JtpC5lVFA0riYENxtdmocRCjtPNiT5Crk6IarsSkll1FlC54MFGtjV1Y8xDM1espHli3Dl27emSY=
X-Received: by 2002:a05:600c:468e:b0:3ee:93d2:c915 with SMTP id
 p14-20020a05600c468e00b003ee93d2c915mr13695155wmo.6.1683787117430; Wed, 10
 May 2023 23:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230507170631.89607-1-hanjinke.666@bytedance.com>
In-Reply-To: <20230507170631.89607-1-hanjinke.666@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 May 2023 14:38:00 +0800
Message-ID: <CAMZfGtV8FUoBzhPjFu8V5=e=dQ3wRm+qK7S0HHCB22cjKDLAdQ@mail.gmail.com>
Subject: Re: [PATCH v3] blk-throttle: Fix io statistics for cgroup v1
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrea.righi@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 8, 2023 at 1:07=E2=80=AFAM Jinke Han <hanjinke.666@bytedance.co=
m> wrote:
>
> From: Jinke Han <hanjinke.666@bytedance.com>
>
> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
> the only stable io stats interface of cgroup v1, and these statistics
> are done in the blk-throttle code. But the current code only counts the
> bios that are actually throttled. When the user does not add the throttle
> limit, the io stats for cgroup v1 has nothing. I fix it according to the
> statistical method of v2, and made it count all ios accurately.
>
> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
> Tested-by: Andrea Righi <andrea.righi@canonical.com>
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>

Good catch.

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
