Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780ADB3CFA
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2019 16:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfIPO4K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Sep 2019 10:56:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36480 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388070AbfIPO4K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Sep 2019 10:56:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id t3so148950wmj.1
        for <cgroups@vger.kernel.org>; Mon, 16 Sep 2019 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gBWC3snefCabDrXZ1x4w/4vScF2L6+ltsxd1AOElg+8=;
        b=OjrwaYz2AQwT5OelSHDlmDJTq6d0W9vtp6R/Mf+Rxp3t1feUrbsXjI3gOk5kiQBo/F
         efj1fQ7n39FshL6tti/+V7aMUF2f3svbaUUu5cj8lO3QiMcrEurtxCpsGvugrG50YT+A
         Vkakk7cd9B2ISXHfmQrfSP1J7zemHWVgL0HteBJA/zQYrq8/07FlLfJ2JXCqFSlpZipo
         88Qf1QCBSnjzOpgUndKfw8fL5YW1M69Dpl2EvndiWoLC249vJBdEF2svILgs/I/WMmwI
         YyeYDzcEQUIOLOQEWyXgcLDiA1Ief9EiZZElT/V4q94l6RwEJ5GA2bWqnVfi1XDzhM48
         d8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gBWC3snefCabDrXZ1x4w/4vScF2L6+ltsxd1AOElg+8=;
        b=mts3Q5o2Sqs8BgENNIwdS4B1bHfJK2jCVeeloS8wWEpYfDJ14nEluNjhrvuEU/2YZR
         ExYnF/z88LKO1yG7n+8rQS+LlVDzQJV7Wxa394S0lAmzdh0gDYKO+pstiW+VTD6wZfZi
         8Eu8/tzN2gqbuG8zlHWH7OBR1AnOtVHeyYkQMuMO2UQdzuRq/+iI8J4C4oUniMZcEx3r
         j+o2NsxZYEIgE76cwPm6GlMUvey1uvIUInWx6MCIQ8ndi6cxnwzjGzxp7hUE/c2DP695
         GP9oaCF8npRtazm26YeabuJhfTgf61F1MkY+aRMjnqZxuvsq2S0JCoAAtVIi++y8Leeo
         UEaA==
X-Gm-Message-State: APjAAAVkMLDNPdvnhIBFVdm+3PPLeKLyKLWeYi81qewO6aewIDyVmuZt
        X5H4pTcNYKMAApbUfanosh3Xrf1bSjk=
X-Google-Smtp-Source: APXvYqxxGliveFj5rRtU91G+rUagNoaG4zG7frcMy88jLejSwZ6OCXSOBT0eN5UBYzyWzrdq23T4cQ==
X-Received: by 2002:a05:600c:141:: with SMTP id w1mr77779wmm.75.1568645768078;
        Mon, 16 Sep 2019 07:56:08 -0700 (PDT)
Received: from [192.168.0.101] (146-241-102-115.dyn.eolo.it. [146.241.102.115])
        by smtp.gmail.com with ESMTPSA id n8sm99707wma.7.2019.09.16.07.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 07:56:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/1] block, bfq: remove bfq prefix from cgroups filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190909073117.20625-1-paolo.valente@linaro.org>
Date:   Mon, 16 Sep 2019 16:56:06 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <80C56C11-DA21-4036-9006-2F459ACE9A8C@linaro.org>
References: <20190909073117.20625-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

News of this change?  Can we have it (or the solution with the
symlinks if you prefer it) for 5.4?

Thanks,
Paolo

> Il giorno 9 set 2019, alle ore 09:31, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi Jens,
> now that BFQ's weight interface has been fixed [1], can we proceed
> with this change?
>=20
> In addition to acking this solution, in [2] Tejun already suggested a
> reduced version of the present patch. In Tejun's version, only
> bfq.weight is changed. But I guess that legacy code may use also some
> of the other bfq parameters in cgroups, without the bfq prefix. Apart
> from that, any version is ok for me, provided that it solves the
> current confusing situation for userspace [3].
>=20
> Thanks,
> Paolo
>=20
> [1] https://lkml.org/lkml/2019/8/27/1716
> [2] =
https://www.mail-archive.com/linux-block@vger.kernel.org/msg35823.html
> [3] https://github.com/systemd/systemd/issues/7057
>=20
> Angelo Ruocco (1):
>  block, bfq: delete "bfq" prefix from cgroup filenames
>=20
> block/bfq-cgroup.c | 46 +++++++++++++++++++++++-----------------------
> 1 file changed, 23 insertions(+), 23 deletions(-)
>=20
> --
> 2.20.1

