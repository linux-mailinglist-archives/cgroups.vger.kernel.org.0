Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B44B67EE
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2019 18:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfIRQTr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Sep 2019 12:19:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34674 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbfIRQTp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Sep 2019 12:19:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so98114wrx.1
        for <cgroups@vger.kernel.org>; Wed, 18 Sep 2019 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jkRvwN7j8d6+3yYxujaDpdYkk73iNWb6wxPtS0qswdE=;
        b=NkofmqnCSprkwxBJoUDKnTb+3Uj/9yc6OmR4Yulm/W/mK7DM5Yry64Bb0TLfbeA4w/
         0L360/+PzUU7wzqahEZy7qO+5UvxDTAuFOwOCAlEg3LFZvahuaRqYvKBr9K10Xko2Cx+
         XHb6rYgdUm5i86gYRLXVj6258yQs9Qw1UUxnefk5no8k4IgTFts/Ue/Ou5RUqYyJHQOv
         UFME+F58lY294Ujkr+Mw7u0QddYKlPHlIRh8zdFjNIMsMF1PIOFTOFLfuZsWEhEiI1+y
         rNCoJv6uVhgfXsk+B7W/Laa1irG7idIEgpNZWvrfpDHtsFgiepPac8d3vgK4e82lcrgY
         Gciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jkRvwN7j8d6+3yYxujaDpdYkk73iNWb6wxPtS0qswdE=;
        b=Dt8ZhmhpEjfIjyBQkBvqScm1qRhZTpO9c0iXSrex/3/BOAS5IndL7SL8OiVYA4m8gV
         IZAlgrwbhBDNiOhB6IHI4r1La8DcbWyECNe7L6jGqBE1kFXdwClJWjVCf/OJ0yhQM9QA
         SWGgIhquZ8hDpb8hkmlOhbAOGoCEvJobHzM670iVs5ndDKIo/d6PFLCbS3JwT7m+UXG7
         nzUVjtTD1MIw7jbqJMX6tFa/fL2jz7irXIKzpMg3ON30k98TqhKPIETXaPBEmdkjTc5s
         wJcWeS7ixITBULHc432DiI+MXJxwB6tAIJ/bUcQog6Y/k7A/Pw+A/dEtz9d+7oQkEPNW
         o/jw==
X-Gm-Message-State: APjAAAUd2pGdHu0uVXNI34ZwQy5e0gWR9bB4q1v1van4/PTF37+a1Q+a
        MRQGCJrJoDPcYg7zo/r1MXVpWA==
X-Google-Smtp-Source: APXvYqxG3GZQpL0HIFBdWAF2a/qxLz0iEIJr3xmJKW6qnJ6mfouGFwWt9YLefI+hWVtg6SpdqccGFA==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr3737040wrx.58.1568823583638;
        Wed, 18 Sep 2019 09:19:43 -0700 (PDT)
Received: from [192.168.0.105] (146-241-52-159.dyn.eolo.it. [146.241.52.159])
        by smtp.gmail.com with ESMTPSA id c132sm4283228wme.27.2019.09.18.09.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 09:19:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190918151948.GL3084169@devbig004.ftw2.facebook.com>
Date:   Wed, 18 Sep 2019 18:19:42 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        cgroups@vger.kernel.org, Angelo Ruocco <angeloruocco90@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F416823-855F-4091-90B9-92253BF189FA@linaro.org>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
 <20190917165148.19146-3-paolo.valente@linaro.org>
 <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
 <4D39D2FA-A487-4FAD-A67E-B90750CE0BD4@linaro.org>
 <20190918151948.GL3084169@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 18 set 2019, alle ore 17:19, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello,
>=20
> On Wed, Sep 18, 2019 at 07:18:50AM +0200, Paolo Valente wrote:
>> A solution that both fulfills userspace request and doesn't break
>> anything for hypothetical users of the current interface already made
>> it to mainline, and Linus liked it too.  It is:
>=20
> Linus didn't like it.  The implementation was a bit nasty.  That was
> why it became a subject in the first place.
>=20
>> 19e9da9e86c4 ("block, bfq: add weight symlink to the bfq.weight =
cgroup parameter")
>>=20
>> But it was then reverted on Tejun's request to do exactly what we
>> don't want do any longer now:
>> cf8929885de3 ("cgroup/bfq: revert bfq.weight symlink change")
>=20
> Note that the interface was wrong at the time too.
>=20
>> So, Jens, Tejun, can we please just revert that revert?
>=20
> I think presenting both io.weight and io.bfq.weight interfaces are
> probably the best course of action at this point but why does it have
> to be a symlink?  What's wrong with just creating another file with
> the same backing function?
>=20

I think a symlink would be much clearer for users, given the confusion
already caused by two names for the same parameter.  But let's hear
others' opinion too.

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun

