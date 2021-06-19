Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F03A3ADBA1
	for <lists+cgroups@lfdr.de>; Sat, 19 Jun 2021 22:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFSUUw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 19 Jun 2021 16:20:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35730 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhFSUUv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 19 Jun 2021 16:20:51 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624133919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGxCAU5/Gg8G2QXDWd/7foFOuvLUzMk0dmwKNfusq2U=;
        b=FHmONuVOMr4+7/40TNNSG/hiyaLtRMfUkmIbkXSCD/DmuFl04ct6WCfWE+39chTJdbVo1K
        lUkQjjBuuKAg6b3uWhjaay0x1XBeysHVjJvvYDnPA3CbOnwoaUXbS4dHcEX48bVwbs9A3d
        c5ZICg5YoTojMIaLEza7vvJcfaRqO2QnCHxq/oE+NoZEJ7f8pIncF4YsfasW4My6HvrtyB
        1TDAwwmoNiLm/PseNG964ShmAm7yLLmdOfa3d05H7gNgaqBdm911btMTVAIisw+eqxASYf
        XZu4AQNSI2sTJOUfz242Z5WKZ+393Zc+Qj0gREGjZugpB/ngoSw+C6a4Z9KJfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624133919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGxCAU5/Gg8G2QXDWd/7foFOuvLUzMk0dmwKNfusq2U=;
        b=6b7bpcDeTlfRnxblWGna3hiV6agE0oq0oY3LeyiryUSDr6tNRpuxRD1lIR9Ci0vNIP7Mef
        VHs4dCzzxHGlwdAg==
To:     Alexey Klimov <aklimov@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Joshua Baker <jobaker@redhat.com>, audralmitchel@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, tj@kernel.org,
        Qais Yousef <qais.yousef@arm.com>, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH v3] cpu/hotplug: wait for cpuset_hotplug_work to finish on cpu onlining
In-Reply-To: <CAFBcO+9wLjDW6n-ZSean_UQHSJ44Tpw9XBz-3UMoVCeUridj4Q@mail.gmail.com>
References: <20210317003616.2817418-1-aklimov@redhat.com> <87tuowcnv3.ffs@nanos.tec.linutronix.de> <CALW4P+L9_tYgfOPv0riWWnv54HPhKPDJ4EK4yYaWsz0MdDGqfw@mail.gmail.com> <CAFBcO+8NBZxNdXtVuTXt9_m9gWTq7kxrcDcdFntvVjR_0rM13A@mail.gmail.com> <CAFBcO+9wLjDW6n-ZSean_UQHSJ44Tpw9XBz-3UMoVCeUridj4Q@mail.gmail.com>
Date:   Sat, 19 Jun 2021 22:18:39 +0200
Message-ID: <87zgvlhalc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Alexey,

On Mon, Jun 14 2021 at 19:14, Alexey Klimov wrote:
> On Thu, Apr 15, 2021 at 2:30 AM Alexey Klimov <aklimov@redhat.com> wrote:
>>
>> On Sun, Apr 4, 2021 at 3:32 AM Alexey Klimov <klimov.linux@gmail.com> wrote:
>> >
>> > On Sat, Mar 27, 2021 at 9:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> [...]
>
>> Are you going to submit the patch? Or I can do it on your behalf if you like.
>
> Are you going to send out this to lkml as a separate patch or do you
> want me to do this on your behalf?

sorry I forgot about this completely. No need to resend. It's on LKML
already. I pick it up from this thread.

Thanks,

      tglx


