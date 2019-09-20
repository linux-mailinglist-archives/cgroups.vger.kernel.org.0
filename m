Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10BB8B4C
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2019 08:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394933AbfITG6w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Sep 2019 02:58:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38594 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394931AbfITG6w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Sep 2019 02:58:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so1077653wmi.3
        for <cgroups@vger.kernel.org>; Thu, 19 Sep 2019 23:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yoSKv6iKPafqA3E2EdHP7bvoi3Wx6UArkcBIy3W3JgE=;
        b=cA+ud2rCE++WSHjLDz3AhrKm293GXSXkrwLk/s9r9iW4WBQtPmAPmvIByyMA9hh1VE
         ug54X6TIvCVMpSwKL/UF4ne11znZGpabGzgJd38sgYHeOHcP0/2tI2pKcuG4RMOFCpWL
         WXvdIzHkgfs83ngR0qoFEaQWT9jsT7EpNeCgUq6NtK+pK3hQCaFsuTU0gFmgEHlV/xz8
         uTE3pJzqyTC43dkjHllvIP7kco+gOSyIEFSD0+jDyqob2BoR9aMvCmvLE/BbOHNV/7Em
         o/QaogW/g3+Zt8xN2m1Et005rX98nd7opXkYqFNlJe1tkomlr7Oyi+mPBQBco6Acxvvf
         NyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yoSKv6iKPafqA3E2EdHP7bvoi3Wx6UArkcBIy3W3JgE=;
        b=uKHQJQu1b3t0yq4DqcORwOKF2/Em4ZyuN80bw1FJ0qAdhFGB0M+io3qfpnsL61KAwT
         pQG/4N4p2Mv/CD+IEDA1j0Fdw14KkuZeiV3/7yvn9HlWfmkWXgJCMF7QTDXnecF1776t
         1ObwIZYAtq26mYJBL5KUkce0RDx1bu4bIeRIcdpLEpuI/7+DD2+xZNp/kyMjaYHdzcE9
         1N595ndSLWkvmKcu9YqLmNNI/Lp5W7FhQZZQtdgVttbEUmLNxmHzr9nJJQqh4fOaSaau
         ixKGS7wspTES1inRbtjCkeKdntsM+z+oSr4NA/LI1ZkReSFofasM8D03jmoxIWZ1oX1k
         7n1g==
X-Gm-Message-State: APjAAAUBHv0NKZ4pZ9eh+5swVkKcFK5V3gPwSQctcdPpmhxnPDjaNvT7
        5a11hVJsVrnGGP3F1688wEoeUA==
X-Google-Smtp-Source: APXvYqxFbquKMMhkFejMJOJKNJxEm+G04tfs3QH4DRcTuXri0pbUEPHrXRiB90Cn6nrpvSihy6vgcA==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr2017817wmb.151.1568962730219;
        Thu, 19 Sep 2019 23:58:50 -0700 (PDT)
Received: from [192.168.0.100] (146-241-67-0.dyn.eolo.it. [146.241.67.0])
        by smtp.gmail.com with ESMTPSA id b5sm817428wmj.18.2019.09.19.23.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 23:58:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <4F416823-855F-4091-90B9-92253BF189FA@linaro.org>
Date:   Fri, 20 Sep 2019 08:58:47 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        cgroups@vger.kernel.org, Angelo Ruocco <angeloruocco90@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A87FEC8A-3E1A-4DC8-89F7-5FAF63CF5B47@linaro.org>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
 <20190917165148.19146-3-paolo.valente@linaro.org>
 <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
 <4D39D2FA-A487-4FAD-A67E-B90750CE0BD4@linaro.org>
 <20190918151948.GL3084169@devbig004.ftw2.facebook.com>
 <4F416823-855F-4091-90B9-92253BF189FA@linaro.org>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 18 set 2019, alle ore 18:19, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 18 set 2019, alle ore 17:19, Tejun Heo <tj@kernel.org> ha =
scritto:
>>=20
>> Hello,
>>=20
>> On Wed, Sep 18, 2019 at 07:18:50AM +0200, Paolo Valente wrote:
>>> A solution that both fulfills userspace request and doesn't break
>>> anything for hypothetical users of the current interface already =
made
>>> it to mainline, and Linus liked it too.  It is:
>>=20
>> Linus didn't like it.  The implementation was a bit nasty.  That was
>> why it became a subject in the first place.
>>=20
>>> 19e9da9e86c4 ("block, bfq: add weight symlink to the bfq.weight =
cgroup parameter")
>>>=20
>>> But it was then reverted on Tejun's request to do exactly what we
>>> don't want do any longer now:
>>> cf8929885de3 ("cgroup/bfq: revert bfq.weight symlink change")
>>=20
>> Note that the interface was wrong at the time too.
>>=20
>>> So, Jens, Tejun, can we please just revert that revert?
>>=20
>> I think presenting both io.weight and io.bfq.weight interfaces are
>> probably the best course of action at this point but why does it have
>> to be a symlink?  What's wrong with just creating another file with
>> the same backing function?
>>=20
>=20
> I think a symlink would be much clearer for users, given the confusion
> already caused by two names for the same parameter.  But let's hear
> others' opinion too.
>=20

Jens, could you express your opinion on this?  Any solution you and
Tejun agree on is ok for me.  Also this new (fourth) possible
implementation of this fix, provided that then it is definitely ok for
both of you.

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>> Thanks.
>>=20
>> --=20
>> tejun

