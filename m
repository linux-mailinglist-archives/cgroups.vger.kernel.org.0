Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB11ED92E
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2019 07:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfKDGzq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 01:55:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33585 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfKDGzp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 01:55:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id s1so15693381wro.0
        for <cgroups@vger.kernel.org>; Sun, 03 Nov 2019 22:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=efTsrgum6xJE7MRvVJBRK/zmwVe4c8WJ2kKIMnNW8Ps=;
        b=ZS7APdfirJFEeeWRieuYZxjTYo9DlEALo+JfcE0VB6A2bSmE0xq8e7lEn2LFs8bzxu
         ZQ0OjuqTqgY6VOaacTG1EqRkLnd2SRbWat6wLEdTuZgNvrcMZ+1bfa8gVsSbRJ1Yd/Nh
         bj8p+niD42iKCFX0pKGd659xJmFDKPbLG4p67nwtx9YJY0mMrhtArgNX2pOlxpjLIXIA
         QKyRgP3ulGzaen3kpD7HFDXpwZ7INdxT8NBmKmpvGH0H+dlOhXtqUrTZCCcS2LUiD40E
         9RaPT0ZycgVBlMOL6GJJKMVKgQQBkAagSQouQ+eflMrIgvseOzrkV+HrFRlWeV//emlE
         DrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=efTsrgum6xJE7MRvVJBRK/zmwVe4c8WJ2kKIMnNW8Ps=;
        b=CNhyxZGXqWYSRrlUNrMQEk1OTV96ROKPDV0UtlinHfkL3/c94jLvN7+emFtZI1Pp73
         KHSA6UTMiOKsLHflqTVJeM0L0Z/9nVvOkQ0XSY82zHwpLOViT6WL8cgXPg/jPkVHkILC
         yy2AQ4dFgadXJATQigK0c/utjzr0Vkm1PI6RWbt+7wytlGzJi2OEU1H8P0sgRC6EwDH/
         Ltrp5XRS9JU3XF7bsXY2wo+FauYhNXZDyqr/CPumtznk19lJRy+uTOgk5LSAePjihzJ1
         rrFcKnx6XAr3t1ZybuwzEnoftTcqN9g9UcGn0v6Llmf0F6nH3eerMutCB0jHu9u45ATF
         1azg==
X-Gm-Message-State: APjAAAVIy9nbAjbE18UoQT55+d0w7pPhNDnWxYoYDHqZWjmtB1SPQie3
        iDm6IM2OQzLHkb6qSP1J7za8zw==
X-Google-Smtp-Source: APXvYqzGKSC761RMlZIeKUUjqiTGqkddA4ouhOe2U+yzjUj6O1Iug1epfzJTGyPXBIZn7B0YaoZADg==
X-Received: by 2002:adf:c409:: with SMTP id v9mr21691604wrf.41.1572850542065;
        Sun, 03 Nov 2019 22:55:42 -0800 (PST)
Received: from [192.168.0.102] (88-147-74-230.dyn.eolo.it. [88.147.74.230])
        by smtp.gmail.com with ESMTPSA id s10sm16055564wrr.5.2019.11.03.22.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 22:55:41 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/2] block, bfq: make bfq disable iocost and present a
 double interface
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <94E51269-62DC-427A-A81C-3851ABC818BC@linaro.org>
Date:   Mon, 4 Nov 2019 07:55:39 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE7EFCFA-D8A6-48EB-AE46-0C7D813A2095@linaro.org>
References: <20191001193316.3330-1-paolo.valente@linaro.org>
 <19BC0425-559E-433A-ACAD-B12FA02E20E4@linaro.org>
 <94E51269-62DC-427A-A81C-3851ABC818BC@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jens,
no issue has been raised in more than a month, and this version was
requested by Tejun and is backed by you. So can it be queued for 5.5?

Thanks,
Paolo

> Il giorno 23 ott 2019, alle ore 07:44, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> ping
>=20
>> Il giorno 9 ott 2019, alle ore 16:25, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>=20
>> Jens, Tejun,
>> can we proceed with this double-interface solution?
>>=20
>> Thanks,
>> Paolo
>>=20
>>> Il giorno 1 ott 2019, alle ore 21:33, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>>=20
>>> Hi Jens,
>>>=20
>>> the first patch in this series is Tejun's patch for making BFQ =
disable
>>> io.cost. The second patch makes BFQ present both the bfq-prefixes
>>> parameters and non-prefixed parameters, as suggested by Tejun [1].
>>>=20
>>> In the first patch I've tried to use macros not to repeat code
>>> twice. checkpatch complains that these macros should be enclosed in
>>> parentheses. I don't see how to do it. I'm willing to switch to any
>>> better solution.
>>>=20
>>> Thanks,
>>> Paolo
>>>=20
>>> [1] https://lkml.org/lkml/2019/9/18/736
>>>=20
>>> Paolo Valente (1):
>>> block, bfq: present a double cgroups interface
>>>=20
>>> Tejun Heo (1):
>>> blkcg: Make bfq disable iocost when enabled
>>>=20
>>> Documentation/admin-guide/cgroup-v2.rst |   8 +-
>>> Documentation/block/bfq-iosched.rst     |  40 ++--
>>> block/bfq-cgroup.c                      | 260 =
++++++++++++------------
>>> block/bfq-iosched.c                     |  32 +++
>>> block/blk-iocost.c                      |   5 +-
>>> include/linux/blk-cgroup.h              |   5 +
>>> kernel/cgroup/cgroup.c                  |   2 +
>>> 7 files changed, 201 insertions(+), 151 deletions(-)
>>>=20
>>> --
>>> 2.20.1
>>=20
>=20

