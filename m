Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239A1E11CC
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 07:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfJWFow (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Oct 2019 01:44:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38416 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbfJWFow (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Oct 2019 01:44:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so18273231wmi.3
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2019 22:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yxvk4JK0S6fOQxsokBnmhH3TcJSOZWVYOtlV6nQoCzM=;
        b=IFQbUvYUvIHygSN9UBfOAvTiOyAzVBISTOa5oYkQV7XmGLlGYuvqaeduwqDjZf7K/e
         SQDZFmJeyHwpYRriWd5Nw2SSe3qrPJifJuCW0PwujfTLdYgFxe+mBVIu5EjjpfFDas4b
         ZFsJhWPjdQVgMj7ILlz3158WwsfWdOr4KiDokAQqJZsGMG+qn5d1YC6Ub6GHPn6fRbcR
         VjLGYvNaCMSA/huILsbMGgR/4rntEmKbyAOGT9zdGIt4ElfUIX9yDoehNxnQ1B8zRBjK
         D3+k9tktvAsX7k0YeKEdQ8+l3k2AFN/jC7+bAXc2YX9R2y8OKdKEqb0CDJ4jAEipvBZ0
         d9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yxvk4JK0S6fOQxsokBnmhH3TcJSOZWVYOtlV6nQoCzM=;
        b=QK3bZqtyUhET7SZ+uxBWklhvWBNbcByRr39Gbr43qavmV/ET8PTNlW72hcWlngcyHK
         5xgXyKceky5q4Gh2nY6C3kneKfyb+1GZXyRMs4ZrlbFl8Wuzgn/H3dTSPqVdfq3n2yqN
         9we8ZdrF18HvRHHlPTnXUx94WqyFl3A4z/73bWtuj1F2DnhDHNZ87cQ8nvjx8Dhx2kT5
         Bp5mPnkRLKYPF4/qc+rfDoM2fcqWRiLxEZEdBa47fTeypLF49sWyEC5k9VIDHwBNTtYL
         EPeGGDds/hZwWprOaAzO/kGb7HoPotHP8I7ozCbKhfiW2XvOiOBqB1cQYbF50WMyzQSn
         qvaA==
X-Gm-Message-State: APjAAAV3fafq2SQrDpzyZSuUgHLN7VlAJv/tQLnnOEbpkoCkZekp2yOk
        XPO9aLMZKQPuPRFhcycbdMqUQA==
X-Google-Smtp-Source: APXvYqxWENcAhG3ml7y69a4emJVDFc6t3DUaWlnyAPA/Dv2uJdnijYtDiaKwsMRWVlPpsLWX9yZGeA==
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr445601wmb.163.1571809489836;
        Tue, 22 Oct 2019 22:44:49 -0700 (PDT)
Received: from [192.168.0.102] (84-33-74-57.dyn.eolo.it. [84.33.74.57])
        by smtp.gmail.com with ESMTPSA id 200sm14202462wme.32.2019.10.22.22.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 22:44:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/2] block, bfq: make bfq disable iocost and present a
 double interface
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <19BC0425-559E-433A-ACAD-B12FA02E20E4@linaro.org>
Date:   Wed, 23 Oct 2019 07:44:47 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <94E51269-62DC-427A-A81C-3851ABC818BC@linaro.org>
References: <20191001193316.3330-1-paolo.valente@linaro.org>
 <19BC0425-559E-433A-ACAD-B12FA02E20E4@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ping

> Il giorno 9 ott 2019, alle ore 16:25, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Jens, Tejun,
> can we proceed with this double-interface solution?
>=20
> Thanks,
> Paolo
>=20
>> Il giorno 1 ott 2019, alle ore 21:33, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>=20
>> Hi Jens,
>>=20
>> the first patch in this series is Tejun's patch for making BFQ =
disable
>> io.cost. The second patch makes BFQ present both the bfq-prefixes
>> parameters and non-prefixed parameters, as suggested by Tejun [1].
>>=20
>> In the first patch I've tried to use macros not to repeat code
>> twice. checkpatch complains that these macros should be enclosed in
>> parentheses. I don't see how to do it. I'm willing to switch to any
>> better solution.
>>=20
>> Thanks,
>> Paolo
>>=20
>> [1] https://lkml.org/lkml/2019/9/18/736
>>=20
>> Paolo Valente (1):
>> block, bfq: present a double cgroups interface
>>=20
>> Tejun Heo (1):
>> blkcg: Make bfq disable iocost when enabled
>>=20
>> Documentation/admin-guide/cgroup-v2.rst |   8 +-
>> Documentation/block/bfq-iosched.rst     |  40 ++--
>> block/bfq-cgroup.c                      | 260 =
++++++++++++------------
>> block/bfq-iosched.c                     |  32 +++
>> block/blk-iocost.c                      |   5 +-
>> include/linux/blk-cgroup.h              |   5 +
>> kernel/cgroup/cgroup.c                  |   2 +
>> 7 files changed, 201 insertions(+), 151 deletions(-)
>>=20
>> --
>> 2.20.1
>=20

