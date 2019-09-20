Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3ABB9048
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2019 15:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfITNFL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Sep 2019 09:05:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38822 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfITNFK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Sep 2019 09:05:10 -0400
Received: by mail-io1-f67.google.com with SMTP id k5so15973779iol.5
        for <cgroups@vger.kernel.org>; Fri, 20 Sep 2019 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V5857UdtPy5LB2Qj3lCJ6EALsf9VjY4ozTOyQCCtBGw=;
        b=UEGHzk2GzwFGmTZh0bMvpjw+ZTxI4UuQ46JyhNc+Q7HgzhT1dG+11UmOyBzCpzQY4s
         lk0MHF/15pJ7XjuqR2/lGIxxUGl9/8RAU8Zu5Q4+A87uAvB2t13t+QAbeQO1Q1fw1gBB
         ZKRFpb6au1iAuYTH0VI59bC2ky2zo+61KNrjyIPqi73XMkKrZgsxPm45Xx+1wRaiL1S2
         EHtqIVjnodF5mn1wkgbC470zLtNPMNlVg1obE8ddgNMN+j1iSUHapYTYLu1PtWAJJqQJ
         GQmXaQJEI/B66NhZgBExVjFcbXoSZMcvweZ9GTrE3E9tluhNTRhuaRzM1nZr/e08JnmB
         1pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V5857UdtPy5LB2Qj3lCJ6EALsf9VjY4ozTOyQCCtBGw=;
        b=cVMKEzw2RA/vfZBQyF58fSk/XHvBPcFB8X0VnxUJQpUS1hfc9MJoA0vcx4kWFQUc99
         RTHMa8dTmKXAiRReJ+cn6bUTGdLRZ9vQxiJVEciWJX/AyUmTi6+XEQk19gNorcMR+CI4
         OQ/z3eJBya41u3okpzBkmV+ZtTfEPOjAq2guxt6Y4Oz12CWjnmwUe2csWEnDKxFJ0mPW
         qv8azZ4yqzQgiZZqSb89Zao7SMtXb9cOgXmmrae3tgyPdfnSq6toPDW9SwOcoe1ZR3D1
         brrJoMbqBKIkoij/gu7a50wdo16G1rrXJywtghO9VUBQ6MNhvprw2Bft0fdHklrNHeXu
         PzWQ==
X-Gm-Message-State: APjAAAXYpZ6FJKT0k1b1M4WkbuFRX2dYK4zZb54T1wjYXQStKpqQIXFd
        JdMZNp4JYYoEUeh+CqTxrzzAOpXGe/kmkQ==
X-Google-Smtp-Source: APXvYqz5yXouKOTZlRsl2vibdMPIsushtwZaeMaqyPL5+VKJgbmnNBDavKKhox5RFzmBV1D/zcgCHg==
X-Received: by 2002:a5e:8218:: with SMTP id l24mr13613162iom.56.1568984709226;
        Fri, 20 Sep 2019 06:05:09 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m5sm2293192ioh.69.2019.09.20.06.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 06:05:08 -0700 (PDT)
Subject: Re: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
To:     Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        cgroups@vger.kernel.org, Angelo Ruocco <angeloruocco90@gmail.com>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
 <20190917165148.19146-3-paolo.valente@linaro.org>
 <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
 <4D39D2FA-A487-4FAD-A67E-B90750CE0BD4@linaro.org>
 <20190918151948.GL3084169@devbig004.ftw2.facebook.com>
 <4F416823-855F-4091-90B9-92253BF189FA@linaro.org>
 <A87FEC8A-3E1A-4DC8-89F7-5FAF63CF5B47@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de7664b1-6f47-8a7b-b231-727336c0ef85@kernel.dk>
Date:   Fri, 20 Sep 2019 07:05:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <A87FEC8A-3E1A-4DC8-89F7-5FAF63CF5B47@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/20/19 12:58 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 18 set 2019, alle ore 18:19, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>
>>
>>
>>> Il giorno 18 set 2019, alle ore 17:19, Tejun Heo <tj@kernel.org> ha scritto:
>>>
>>> Hello,
>>>
>>> On Wed, Sep 18, 2019 at 07:18:50AM +0200, Paolo Valente wrote:
>>>> A solution that both fulfills userspace request and doesn't break
>>>> anything for hypothetical users of the current interface already made
>>>> it to mainline, and Linus liked it too.  It is:
>>>
>>> Linus didn't like it.  The implementation was a bit nasty.  That was
>>> why it became a subject in the first place.
>>>
>>>> 19e9da9e86c4 ("block, bfq: add weight symlink to the bfq.weight cgroup parameter")
>>>>
>>>> But it was then reverted on Tejun's request to do exactly what we
>>>> don't want do any longer now:
>>>> cf8929885de3 ("cgroup/bfq: revert bfq.weight symlink change")
>>>
>>> Note that the interface was wrong at the time too.
>>>
>>>> So, Jens, Tejun, can we please just revert that revert?
>>>
>>> I think presenting both io.weight and io.bfq.weight interfaces are
>>> probably the best course of action at this point but why does it have
>>> to be a symlink?  What's wrong with just creating another file with
>>> the same backing function?
>>>
>>
>> I think a symlink would be much clearer for users, given the confusion
>> already caused by two names for the same parameter.  But let's hear
>> others' opinion too.
>>
> 
> Jens, could you express your opinion on this?  Any solution you and
> Tejun agree on is ok for me.  Also this new (fourth) possible
> implementation of this fix, provided that then it is definitely ok for
> both of you.

Retaining both interfaces is arguably the right solution. It would be
nice if we didn't have to, but the first bfq variant was incompatible
with the in-kernel one, so we'll always have that out in the wild.
Adding everything to stable doesn't work, as we still have existing
kernels out there with the interface. In fact, in some ways that's
worse, as you definitely don't want interfaces to change between two
stable kernels.

I know it's not ideal, and some better initial planning would have
made it better, but we have to deal with the situation as it stands
now.

-- 
Jens Axboe

