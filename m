Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F630B5AC1
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2019 07:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfIRFSz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Sep 2019 01:18:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38699 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfIRFSy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Sep 2019 01:18:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so5383983wrx.5
        for <cgroups@vger.kernel.org>; Tue, 17 Sep 2019 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cjIjHnXm58P1zO4oY7wd4+yUsPOW1veEt4hwLPpO2MY=;
        b=K8Dp9vC/OdSO9BAKVo9xeWWUiq2GDluYa2bLJ6eA0T9Jx7oTWgtTuS+aw8jzpbEZED
         JtfNz/iXeCdnyNgIKTNFiek7ijuz0E6YXmCeywGkS78IkEBRsO0h0bLdzrlTUuPNQsOY
         Ht0ezrew4y5yiyHfA52s2TuHHixni67GN23+E9m5YB9xKy3NpLJZ5VZIF7YCobCVeIvA
         ZFM8scx6LXHSI7Y5aFYKyQzUB/eB5MaTBLISGqatmi5SkNUqo1zk+X/MZDf66V+UhWyh
         BLBx0BugJNVz3Ha8NJW4zrhsmxEWz86jZFpHIrgOslr8gn+38AYcVBkL7pyilVw2ys2T
         ut2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cjIjHnXm58P1zO4oY7wd4+yUsPOW1veEt4hwLPpO2MY=;
        b=T4aY/KEGPP1XDO6KzObSiK3BPVMmCKWEJn46QR27/z9/oo9b2R+xQU4Sa8eojazcCh
         /ZlGv/+Zliz9s5gxWMhXC7k93j0lJI2F5YV8gkuCxwLMICBnXd5j0wLQSl4vkT7UNgrS
         Gec1Kr7jSRqHoqPiBbaj37y3BjKF3242H3dEUXqdaiGrQ0FBkSuYzO7jxgVk/Je8pYs7
         D0fyMYD48w0OwM7yI4uPWOFVSiqzyY84jLQuqPd6DEW9QvQYrQ/oU92LDdH5foYbgjN+
         nst9mm0GCOWhrH5CocTHhmWjRLERxGmykPNY0liWLCWT3QIOU6EiGJYb9Lsx/ufFHSEB
         Yr0g==
X-Gm-Message-State: APjAAAVYJzO6H+4U032DtHSXNQf/VNDFz6eN82w6yUwD76OtuBs7gsfF
        s+ejsFMLkg1pBXoyaqorDmN9XQ==
X-Google-Smtp-Source: APXvYqxe0Xdy3auX9QiGXRBhoUsU0XIKBmVZD/cFRMqsg4PH78ZQCps1oiVnhWgZI4OdV5Pp92p4Ng==
X-Received: by 2002:a5d:6049:: with SMTP id j9mr1253419wrt.213.1568783932195;
        Tue, 17 Sep 2019 22:18:52 -0700 (PDT)
Received: from [192.168.0.102] (146-241-104-100.dyn.eolo.it. [146.241.104.100])
        by smtp.gmail.com with ESMTPSA id n7sm67149wrt.59.2019.09.17.22.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 22:18:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
Date:   Wed, 18 Sep 2019 07:18:50 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        Angelo Ruocco <angeloruocco90@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D39D2FA-A487-4FAD-A67E-B90750CE0BD4@linaro.org>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
 <20190917165148.19146-3-paolo.valente@linaro.org>
 <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 17 set 2019, alle ore 23:32, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello,
>=20
> On Tue, Sep 17, 2019 at 06:51:48PM +0200, Paolo Valente wrote:
>> When bfq was merged into mainline, there were two I/O schedulers that
>> implemented the proportional-share policy: bfq for blk-mq and cfq for
>> legacy blk. bfq's interface files in the blkio/io controller have the
>> same names as cfq. But the cgroups interface doesn't allow two
>> entities to use the same name for their files, so for bfq we had to
>> prepend the "bfq" prefix to each of its files. However no legacy code
>> uses these modified file names. This naming also causes confusion, =
as,
>> e.g., in [1].
>>=20
>> Now cfq has gone with legacy blk, so there is no need any longer for
>> these prefixes in (the never used) bfq names. In view of this fact, =
this
>> commit removes these prefixes, thereby enabling legacy code to truly
>> use the proportional share policy in blk-mq.
>=20
> So, I wrote the iocost switching patch and don't have a strong
> interest in whether bfq prefix should get dropped or not.  However, I
> gotta point out that flipping interface this way is way out of the
> norm.
>=20
> In the previous release cycle, the right thing to do was dropping the
> bfq prefix but that wasn't possible because bfq's interface wasn't
> compatible at that point and didn't made to be compatible in time.
> Non-obviously different interface with the same name is a lot worse
> than giving it a new name, so the only acceptable course of action at
> that point was keeping the bfq prefix.
>=20
> Now that the interface has already been published in a released
> kernel, dropping the prefix would be something extremely unusual as
> there would already be users who will be affected by the interface
> flip-flop.  We sometimes do change interfaces but I'm having a
> difficult time seeing the overriding rationales in this case.
>=20

This issue is a nightmare :)

Userspace wants the weight to be called weight (I'm not reporting
links to threads again).  *Any* solution that gets to this is ok for me.

A solution that both fulfills userspace request and doesn't break
anything for hypothetical users of the current interface already made
it to mainline, and Linus liked it too.  It is:
19e9da9e86c4 ("block, bfq: add weight symlink to the bfq.weight cgroup =
parameter")

But it was then reverted on Tejun's request to do exactly what we
don't want do any longer now:
cf8929885de3 ("cgroup/bfq: revert bfq.weight symlink change")

So, Jens, Tejun, can we please just revert that revert?

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun

