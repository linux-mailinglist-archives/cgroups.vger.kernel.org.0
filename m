Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF6F405B4B
	for <lists+cgroups@lfdr.de>; Thu,  9 Sep 2021 18:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhIIQvp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Sep 2021 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhIIQvo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Sep 2021 12:51:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F86C061574
        for <cgroups@vger.kernel.org>; Thu,  9 Sep 2021 09:50:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id f2so4027713ljn.1
        for <cgroups@vger.kernel.org>; Thu, 09 Sep 2021 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I16UVI1xVNxqcbO392QGXtKnK4wf/LUEXByP19oIeTk=;
        b=Ts2msjDfBeODNwvVyn3lwhkrQzPDGDljScDheKIeHLjMmkvMh7yGfx688Vm87Hv5D/
         RF65aHED9Q5juZc+DoS23IdDOeQgwYzCoXIrXr5Fw4VOE7FTPw3mx+H/yRoXJ4YoKHRk
         2toWXQn8T84Uwzeqeh0micHUDl6U5YT3P2zgfa2f/NNEwx0LV36LXvFpCPDXLbr8V7fM
         5YRQrdmhm2pTpZdbRv39VwXOMaJ52wXaSiRHqj4TVSIb7KgrDhxfRfxzCXtoi+dTr2nd
         j8hZGk/fqXUJadr8sgos3olZOpt8LLlGqPp2jOdwOpHYO6Ovzu0YNtoyoutkl6jMzO/0
         mCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I16UVI1xVNxqcbO392QGXtKnK4wf/LUEXByP19oIeTk=;
        b=hIvsJeQ+OOg/g4iHPT/QE/6xELe8mH33rH6SmsnNzqvypeb5ls9+Fc/WTpmvHGBuQ4
         2roTDU4T9ONDuT/6alZRHWljozcaMIo5xzx+8StoIriuJA/O768F/s3dTN2hWqAmoMXJ
         YJPS/vSSO0Oh0Zda8fOwyQ0l/ReolYwDqXZGmY2TO28YBYZZg+Ttl22xqeQmrrQjPblK
         xFnxUMiIFLzK10t601P5d0690sdZgYFTM8x50moP+ezXvD7UpFJ53Ea5xJSEB0tRBf6k
         ejoxgd1h1zs6jYoxXooVz6BNyWS8qW7sMbIRSXBZXT9KdqrrFdX3J2Bcqqf81fzDEyDD
         T81g==
X-Gm-Message-State: AOAM530pp+9y0QC3GlAiTXe/JKNp/mwv9DWfguTByRAY7dsyPYP4G4WS
        oZO0kKGWPM+14jLhHn1bKOT0xOpEY8cFmdq9hV5jaA==
X-Google-Smtp-Source: ABdhPJzsq+40EzV4QjbIXO9dYnNo3PtCyHv2QiJiQaPtGgeQiWLSJR50jmB2S74ONZs4Ir7Zr6hyKPjYJjCgFbiffgo=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr656887lji.508.1631206232900;
 Thu, 09 Sep 2021 09:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com> <20210909143720.GA14709@blackbody.suse.cz>
In-Reply-To: <20210909143720.GA14709@blackbody.suse.cz>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Thu, 9 Sep 2021 09:49:56 -0700
Message-ID: <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     brookxu <brookxu.cn@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 9, 2021 at 7:37 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> On Wed, Sep 08, 2021 at 01:24:36PM +0800, brookxu <brookxu.cn@gmail.com> =
wrote:
>
> So there could be two type of events (not referring to the v1-specific
> failcnt):
> - max - number of times the cgroup's misc.max was hit,
> - fail - number of times operation failed (rejected) in the cgroup.
>
> The former would tell you which limit is probably set too low, the
> latter would capture which cgroup workload is affected. (The difference
> would become apparent with >1 level deep hierarchies.)

We are adding two files in this patch series, misc.events and
misc.events.local. I think "fail" should go in misc.events.local and
its name should be changed to "max". So, both files will have "max"
entry but the one in misc.events will refer to the failures in the
current cgroup and its children, and the one in misc.events.local will
refer to the originating cgroup.

>
> Regards,
> Michal
>
> [1] https://lore.kernel.org/lkml/20191202191100.GF16681@devbig004.ftw2.fa=
cebook.com/
>
