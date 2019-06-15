Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4838947117
	for <lists+cgroups@lfdr.de>; Sat, 15 Jun 2019 17:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfFOP5s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 15 Jun 2019 11:57:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33029 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfFOP5r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 15 Jun 2019 11:57:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so3704108qkc.0;
        Sat, 15 Jun 2019 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V1Xn65jFA9fLzGnZCICEwL6tUShlHAvAc5j9I2/vRW4=;
        b=csyg6vgm0i4uNhPsUxiT5I9v9LOyUNu0/a9saVtXHrnPe9wqOlbnYU16Udzo53uh/u
         ntH7pwRtBjuYbe9ZRhTBP3W/jUlEuQnIvB0w7IG3x9Ic2hAnHAbtU0CPHO2gkqHUsvN6
         cbfvLAcvtmBIdwilZEn2cBDPcUNiKMGQEWZcQt6R+ZKmEM4/Opb3ub+9xk/GktAgEGmR
         7jDLFDvE5TNOV/yA2grBclF2D5ZeFv5ddWM5MPXh6kBco8WTEXIVO1CcoKFaaCofb2Bt
         XsIzD6JAPKS4+AxN7vQovTd0s8Zxat1tSWhNEOzrhnY6XwBMzmfPPOwBkM1nY3UjStQW
         Xtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=V1Xn65jFA9fLzGnZCICEwL6tUShlHAvAc5j9I2/vRW4=;
        b=coLPfFv7f+hAIkS0BM92BaoAp8P/hkPfbPRWJxIKN1boopRzD/uOcp03eoAVY7LbyM
         2GmfPuLf1G+WTZPlzGIJy862384xRHhYrnPfJ7veYR3wP/u9g9P1UOFsk5fgQkGpF/P2
         uuPCDa6Rl8WPd1yUB6PhuywUNJ5ReXbAuaeRryFt7nNgzKYW5dnpdN3MD5w5yIhxdjKF
         XrY6o2X5ndjiPxdUuBEPwJr7b6R1Vc1PGDIOPjgunG9NFwx9VU0sAdOMM1lNg/fF4Rrj
         1jU2SY6qEg0O3FyHAmuxlFEQjW+fY53Wz8wdd31UyVwBcrRXwuCH48XHqObT66MPNLxV
         0N9A==
X-Gm-Message-State: APjAAAWz5eXPQERHfp1ZAG/YL56uRSqQiq7m3Q/MAD+hAx+0Gi5SzHEB
        KryA2GCForr8pyM2/Gq9D00=
X-Google-Smtp-Source: APXvYqw7pW50FWwPRrhOjvP+Dt3tlqNNZWVvipaSTxtXb/kfSgJbt5OwlMOikhxcouvwT5smDdGKnA==
X-Received: by 2002:ae9:f702:: with SMTP id s2mr82033743qkg.28.1560614266380;
        Sat, 15 Jun 2019 08:57:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::673a])
        by smtp.gmail.com with ESMTPSA id g10sm3067097qkk.91.2019.06.15.08.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 08:57:45 -0700 (PDT)
Date:   Sat, 15 Jun 2019 08:57:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 08/10] blkcg: implement blk-ioweight
Message-ID: <20190615155743.GF657710@devbig004.ftw2.facebook.com>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614015620.1587672-9-tj@kernel.org>
 <87pnngbbti.fsf@toke.dk>
 <20190614150924.GB538958@devbig004.ftw2.facebook.com>
 <87blyzc2n9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87blyzc2n9.fsf@toke.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jun 14, 2019 at 10:50:34PM +0200, Toke Høiland-Jørgensen wrote:
> > Within a single cgroup, the IOs are FIFO. When an IO has enough vtime
> > credit, it just passes through. When it doesn't, it always waits
> > behind any other IOs which are already waiting.
> 
> OK. Is there any fundamental reason why requests from individual
> processes could not be interleaved? Or does it just not give the same
> benefits in an IO request context as it does for network packets?

I don't think there's any fundamental reason we can't.  Currently, it
just isn't doing anything it doesn't have to do while preserving the
existing ordering.  One different from networking could be that
there's more sharing - buffered writes are attributed to the whole
domain (either system or cgroup) rather than individual tasks, so the
ownership of IOs gets a bit mushy beyond resource domain level.

Thanks.

-- 
tejun
