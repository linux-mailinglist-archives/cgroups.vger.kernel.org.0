Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD713EC13A
	for <lists+cgroups@lfdr.de>; Sat, 14 Aug 2021 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbhHNHsc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 14 Aug 2021 03:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhHNHsb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 14 Aug 2021 03:48:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5437BC06175F;
        Sat, 14 Aug 2021 00:48:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d11so22518878eja.8;
        Sat, 14 Aug 2021 00:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8fEyrpDTg47gFd31UzZ0ta6jHJGs7IbNEF5lPQeob9k=;
        b=S5ZVB7A1d2RXw59YAFt0TXWz/Wt5TZ0DWeW0q+UryXgdVVKbqE2RcpAP6EsGasYPfD
         5i8e5LogHj/0gy9QkBERQx0c7EYo761ovSOQLzu94EUaTuQ7BC1SarXd+r6impvMeoYn
         chIdS/jV38XGr2LDPhhEQNyNh7hJsmRF9fwmSTbCq4INUT2bHBFtz7D43xQjVmljVD17
         K62/SK/t7Wrx0LfoE90kYlKSoCYRbJoMXfkQnyEPx78yxHzJgixh/0lsNGkPKH+/LFhJ
         tLKV/2hK31CzFKsNYqiUBT8I7KQ53oMLb+wgPuik1BpzKuYbiuQvYtNFhy9dq8hkpKqi
         0wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8fEyrpDTg47gFd31UzZ0ta6jHJGs7IbNEF5lPQeob9k=;
        b=MCj8hFLOGQNQTH9GuHsx1+qlI4JVrdFVRao8An3fCIPlml+Dq8uP4/We9artOQQekA
         tQ2u930a8Ch+jfozx5yp4cr4u7bwPLcXrCaY83r0ELvkrS1Gb6KIk+O4QYyxxofTW3dV
         8N4xVO9cbORbXyPu/+kFBzjEBsVIsk3EyDfuS3vgyTmU/+1oro8ByswbIcvJa8fokI6S
         JgaIYgcK2rPPQt2i7EptoHZNQ32joh8xa+JmGGkS/kz4qdD4U8cExf+TkZ9HzUq5tTMW
         I9WTA6jmsHAEtsRaauVylmdcyRFfadTarmVvPWiavujz6gaiS/rmAm0fV1/jY4g7wYpD
         FQ1g==
X-Gm-Message-State: AOAM531vUqkHQX1VtfZtcRYzaX9WJDm6GDRCJEQYEeA+AYmSaIVe/UH5
        tfCFeTwurc3uXKylrgDsbCN90iVxT7kLq8/6ges=
X-Google-Smtp-Source: ABdhPJyH6+0VTBjoT8UzCN51zosB96oIt4y+27vaDfSDbSuQ54jYU96yIImbawQpmpBs6u/cfZkUk4/XkogxpUlDz+k=
X-Received: by 2002:a17:906:b28d:: with SMTP id q13mr6205218ejz.308.1628927281732;
 Sat, 14 Aug 2021 00:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <1628855870-5070-1-git-send-email-wang.yong12@zte.com.cn> <YRZvAojYDsVPT+wr@casper.infradead.org>
In-Reply-To: <YRZvAojYDsVPT+wr@casper.infradead.org>
From:   yong w <yongw.pur@gmail.com>
Date:   Sat, 14 Aug 2021 15:47:48 +0800
Message-ID: <CAOH5QeAY2ENs1s8hGuaHr2j9dV4=TaoR08UDOYRKHx+LjDc1DQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: Add configuration to control whether vmpressure
 notifier is enabled
To:     Matthew Wilcox <willy@infradead.org>
Cc:     tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, tglx@linutronix.de,
        peterz@infradead.org, Shakeel Butt <shakeelb@google.com>,
        guro@fb.com, alexs@kernel.org, richard.weiyang@gmail.com,
        sh_def@163.com, sfr@canb.auug.org.au, wang.yong12@zte.com.cn,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2021=E5=B9=B48=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Aug 13, 2021 at 04:57:50AM -0700, yongw.pur@gmail.com wrote:
> > @@ -855,7 +856,7 @@ At reading, current status of OOM is shown.
> >            The number of processes belonging to this cgroup killed by a=
ny
> >            kind of OOM killer.
> >
> > -11. Memory Pressure
> > +11. Memory Pressure (CONFIG_MEMCG_VMPRESSURE)
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Did you build the documentation after changing it (eg make htmldocs)?

Thank you for your reply.
Sorry, I didn't  build the documentation after changing it.I will pay
attention next time.

Thanks.
