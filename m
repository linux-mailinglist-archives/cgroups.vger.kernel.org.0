Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB5DD1124
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2019 16:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfJIOZI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Oct 2019 10:25:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50727 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbfJIOZI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Oct 2019 10:25:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id 5so2877927wmg.0
        for <cgroups@vger.kernel.org>; Wed, 09 Oct 2019 07:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iRU49OEAt4LyCj336K2hOD9DnveAI21uNOjEn9qQOW4=;
        b=E9KCxy7r7W8VuG+gzVrXD0ZY3tqFeU411T36Nq5kTRByAlfDI/wbHpZh/g5kswfCoM
         vwLhWo9403t2VxWW4ttuhL8ENG78lJ8LR6XWeY18QVo6Qr4zH+d1uHFUyneYhxhEkfb7
         oMSONezKLBCpzFUmlkWHaWWec4Xj13yVUdpiV6FskZnBwdrKUX9kQ6LjaOcmqOJlWuZM
         xTGdMwq4xxVsIXN7Ozu0ww8Z3z+iLn4MhQuSH898YBtmx6CNggIToafYp08ywpTdf7PC
         9bohWInAa5ueiUydRrA7pzUepRWP7esXN28+KUc2MKi0VSEEnuKu5Jajoz2XAehkmJu/
         Sp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iRU49OEAt4LyCj336K2hOD9DnveAI21uNOjEn9qQOW4=;
        b=Ni+NpzyVhKlL7vprDYkzHO9t5WZFcj+qe9VnHEq2A0/wKqtrZbDnn1oas2c5pNcej5
         SGS0EKj3PAu2fbn6Hn0XD+YrCbNP4y9ICKTf9/C0EXRceyn0ZNEuAZBkWvB1s5/vHVSZ
         6uFFQi5FLfwM47qjY7ROZ24U0ra3x+YwEAc6my970yCCJjjh3KAt/PcsmOHkrglRdj4Q
         mlQcnRFCUyGesVPWnSFi/hA4nZjJkFa54AX47ZHrmZ3ah8PwapZxrzNLcsl4p2fkw5CM
         sQ+n2fVNUjB719bUZ7A5XGafycD7ESxe0BlbkqAvFLcBjh8X5O7w/CHctVS7o3YZSEND
         bkjA==
X-Gm-Message-State: APjAAAW/Ah2wDTpTVrJBoF7CeFnQyMEVf3maDjcM168etxL+px2WQmWp
        8DfYPMUwBXPiYsS18fcz199jpg==
X-Google-Smtp-Source: APXvYqyS6nKg/vIjXNFET5U6tGkbJJYtwsehBMs1oRNWirbe2tDsdOO8TNnAQ1US3oljVkz9zRdfJw==
X-Received: by 2002:a1c:dfc4:: with SMTP id w187mr2754436wmg.107.1570631105871;
        Wed, 09 Oct 2019 07:25:05 -0700 (PDT)
Received: from [192.168.0.105] (84-33-64-100.dyn.eolo.it. [84.33.64.100])
        by smtp.gmail.com with ESMTPSA id c132sm3808601wme.27.2019.10.09.07.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 07:25:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/2] block, bfq: make bfq disable iocost and present a
 double interface
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20191001193316.3330-1-paolo.valente@linaro.org>
Date:   Wed, 9 Oct 2019 16:25:03 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <19BC0425-559E-433A-ACAD-B12FA02E20E4@linaro.org>
References: <20191001193316.3330-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Jens, Tejun,
can we proceed with this double-interface solution?

Thanks,
Paolo

> Il giorno 1 ott 2019, alle ore 21:33, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi Jens,
>=20
> the first patch in this series is Tejun's patch for making BFQ disable
> io.cost. The second patch makes BFQ present both the bfq-prefixes
> parameters and non-prefixed parameters, as suggested by Tejun [1].
>=20
> In the first patch I've tried to use macros not to repeat code
> twice. checkpatch complains that these macros should be enclosed in
> parentheses. I don't see how to do it. I'm willing to switch to any
> better solution.
>=20
> Thanks,
> Paolo
>=20
> [1] https://lkml.org/lkml/2019/9/18/736
>=20
> Paolo Valente (1):
>  block, bfq: present a double cgroups interface
>=20
> Tejun Heo (1):
>  blkcg: Make bfq disable iocost when enabled
>=20
> Documentation/admin-guide/cgroup-v2.rst |   8 +-
> Documentation/block/bfq-iosched.rst     |  40 ++--
> block/bfq-cgroup.c                      | 260 ++++++++++++------------
> block/bfq-iosched.c                     |  32 +++
> block/blk-iocost.c                      |   5 +-
> include/linux/blk-cgroup.h              |   5 +
> kernel/cgroup/cgroup.c                  |   2 +
> 7 files changed, 201 insertions(+), 151 deletions(-)
>=20
> --
> 2.20.1

