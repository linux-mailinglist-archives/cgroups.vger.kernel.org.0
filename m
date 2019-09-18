Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB2BB66ED
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2019 17:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfIRPTy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Sep 2019 11:19:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39328 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfIRPTy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Sep 2019 11:19:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id n7so186084qtb.6;
        Wed, 18 Sep 2019 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/ozkoPe7I7HBcRNmLxlm9zJ7nl+dZfk4PcCpSwHEE0=;
        b=T2V++haNtE/r+StT15PyzM8Pcx6eaP5oSwCQUlyICnkOO9OKmWUetxLSpJ+zeMMVm4
         Umui41NlalpMH08oCwjhUB8rcPoPnvb4O75FaSLSpzXsOC8AeDcEFpcwKgGoIrv8svQG
         Rq6lvlestuw80aSnQEx6Bp8hEcJzMpt1xbUH732DypsleAg7F1jnT0gy2aTwuAuVwG5i
         vG3D/JY8NyPMDOrlPAk9MoiOF/4w7Er3TI3dDYvtUxWooplJYAbrWZwmnWkbKkv2kZNJ
         O9knfGLSvhfjDSDSr3jLBMun+UVHVSZO/V4bM/o9XlBnZMKtacHwgn6vG8Zd4liINg+A
         vcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/ozkoPe7I7HBcRNmLxlm9zJ7nl+dZfk4PcCpSwHEE0=;
        b=HNj2Q43hlOubWboB/7iSXpUwuSUiU7YnnqcmaM4WzJrrPnmRKHdcgshnDCOx+zIJNQ
         G64B9BcvWfifDNBE/VIBMCxX6AoPDoQBWLzFTNZIYWjxj4lq2Q+qRUWrWYLHqs56m2Rc
         lRFK5yID/n3mhs9loBft6aNDuiSbCDCpi2E0P9VTQpB2/b9pkWkt6RD7jMCzIAZWeqFz
         uFaLNOWORb1dOAjlt8WuT2lfqu5FaJ7Rt0IG5Oyq1KI+1uB7CVUHxF+dkO3iwycltt8M
         sly5hzRww5QQW+EjDg301xc3QxpDmyMV37hfMyqfIy5cZ40pSG4WsHS7e7T6cztyjlJZ
         jVtA==
X-Gm-Message-State: APjAAAUDZdbQr+2ce++dwJeJIWfSpSTkqIlX2H4pZzHL6cD9xBAmL8t/
        tmSk6vJB95k1mymHiiHkkHw=
X-Google-Smtp-Source: APXvYqyUV3Moh52SBY0W8pItsBoyuN8/Tuoat2VePzXuwr1j0fiDdwfUdmD7qbDpiunmtNeODAgw2w==
X-Received: by 2002:ad4:43c5:: with SMTP id o5mr3692951qvs.207.1568819992834;
        Wed, 18 Sep 2019 08:19:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::fef0])
        by smtp.gmail.com with ESMTPSA id e6sm340551qtr.25.2019.09.18.08.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 08:19:51 -0700 (PDT)
Date:   Wed, 18 Sep 2019 08:19:48 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        Angelo Ruocco <angeloruocco90@gmail.com>
Subject: Re: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
Message-ID: <20190918151948.GL3084169@devbig004.ftw2.facebook.com>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
 <20190917165148.19146-3-paolo.valente@linaro.org>
 <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
 <4D39D2FA-A487-4FAD-A67E-B90750CE0BD4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D39D2FA-A487-4FAD-A67E-B90750CE0BD4@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Sep 18, 2019 at 07:18:50AM +0200, Paolo Valente wrote:
> A solution that both fulfills userspace request and doesn't break
> anything for hypothetical users of the current interface already made
> it to mainline, and Linus liked it too.  It is:

Linus didn't like it.  The implementation was a bit nasty.  That was
why it became a subject in the first place.

> 19e9da9e86c4 ("block, bfq: add weight symlink to the bfq.weight cgroup parameter")
> 
> But it was then reverted on Tejun's request to do exactly what we
> don't want do any longer now:
> cf8929885de3 ("cgroup/bfq: revert bfq.weight symlink change")

Note that the interface was wrong at the time too.

> So, Jens, Tejun, can we please just revert that revert?

I think presenting both io.weight and io.bfq.weight interfaces are
probably the best course of action at this point but why does it have
to be a symlink?  What's wrong with just creating another file with
the same backing function?

Thanks.

-- 
tejun
