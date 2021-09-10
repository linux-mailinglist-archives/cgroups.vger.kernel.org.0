Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188A2407066
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 19:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhIJRSg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhIJRSf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 13:18:35 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BE2C061574
        for <cgroups@vger.kernel.org>; Fri, 10 Sep 2021 10:17:24 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h1so4301144ljl.9
        for <cgroups@vger.kernel.org>; Fri, 10 Sep 2021 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nVQhctFDZ494oNwBH6gZ4cbrFJOKVOXq8XesRbY6VI8=;
        b=X3ZeLOv7Q89I9RQFoFeRBRpC6KFK599HOifkIv4mt+CDHlTcxp+0UZzQfGIac7s/WU
         su9klzfHpoo2JCuO5V6sdmD9Pjv0Son2DzEwAUYK1Fb8fESck+P/K3BB3zpVFrrzbqoq
         fWiP8VjGyW5ujY+25dO79xLu0fCjv0GYy1PM7qxJAFJmxBfOetkWzo/gjjGwE3rxVHqq
         CoLWcgmrUkPIZI87CrcDasqd8fwS5E5jtPfD9rUiYU7zpGP7aHBwySf4Ahj2YzofjZT3
         sXJTf1zEDcGFkN25gOgJHiiScjdCRPauxVCQ+ZXyuaflxySs2RuMdOyrppCWX6Yp1rkc
         Zjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nVQhctFDZ494oNwBH6gZ4cbrFJOKVOXq8XesRbY6VI8=;
        b=ECx8QOJb0Ks7IUdrFj+Sxzxqj5kcLHW0lPc5LkQhEkUhFMOfznuXbvQzEmOvb6XrcQ
         QBSclPv/QNmInnLh48roCaCg9o3UqIU85MV5YA0k7Sg3Q+yi7o1iT1d0FiCVqMEiu40A
         HLz6Wq7RQL4Udzwka9ItIqkQqx9mSYfDmmVVzFtt2A0WbXs/DNA547OCaIgEbOkBvVjq
         4U8iHd7NEk8xpDvJW1jtPAp/j2XmUnM5pgoQhRDDZ/txB9tUVzqrHF/JRemVNN7qVwGw
         mGnaEafyzW6JFq6fONt+J9gpUWjYG9SQbK9KXEmuoMoJa5TWTDjoAf0EEXge5qJIOh/Z
         0Fbg==
X-Gm-Message-State: AOAM532Udho7NwtYv6LsfHLIWS8k1rH25Qna0zEg0OjoPNn1X5AqwmT4
        g0mSMZM/lRg3wvrXUC/eNrLLBm1RCdwHvtJRkRFY0w==
X-Google-Smtp-Source: ABdhPJxuSFmjJAz4+yQEFqKFceCVS/DwoXXiLxCnZRQlzKqsxH9ZXu8FjpT1qbLP2ejb4nwzXgEVms4z2EvPr/ik44Q=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr4949174lji.508.1631294242440;
 Fri, 10 Sep 2021 10:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com>
 <20210909143720.GA14709@blackbody.suse.cz> <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
 <YTpY0G3+IJYmGbdd@blackbook> <478e986c-bc69-62b8-936e-5b075f9270b4@gmail.com>
 <20210910092310.GA18084@blackbody.suse.cz> <1679f995-5a6f-11b8-7870-54318db07d0d@gmail.com>
 <20210910153609.GC24156@blackbody.suse.cz> <YTuH9fULTx+pLuuH@slm.duckdns.org>
In-Reply-To: <YTuH9fULTx+pLuuH@slm.duckdns.org>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 10 Sep 2021 10:16:46 -0700
Message-ID: <CAHVum0ezWW=4x2YgXHhEUFQOkFGBpP+R1Uc-KedHr+r0LGibwA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        "brookxu.cn" <brookxu.cn@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 10, 2021 at 9:29 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Sep 10, 2021 at 05:36:09PM +0200, Michal Koutn=C4=B1 wrote:
> > If there's a limit on certain level with otherwise unconstrained cgroup
> > structure below (a valid config too), the 'fail' counter would help
> > determining what the affected cgroup is. Does that make sense to you?
>
> While the desire to make the interface complete is understandable, I don'=
t
> think we need to go too far in that direction given that debugging these
> configuration issues requires human intervention anyway and providing
> overall information is often enough of aid especially for simple controll=
ers
> like misc/pid. So, let's stick to something consistent and simple even if
> not complete and definitely not name them "fail" even if we add them.
>

I understand what Michal is proposing regarding fail vs max and local
vs hierarchical. I think this will provide complete information but it
will be too many interfaces for a simple controller like misc and
might not even get used by anyone.

Chunguang's case was to avoid printing so many messages, I agree we
should remove the log message and add a file event.

For now, I think we can just have one file, events.local
(non-hierarchical) which has %s.max type entries. This will tell us
which cgroup is under pressure and I believe this is helpful.

Regarding the original cgroup which started the charge should be
easier to identify because those processes will not be able to proceed
or will use some alternate logic, and the job owner should be able to
notice it.

If in future there is a need to find the originating cgroup we can
resume this discussion during that time.
