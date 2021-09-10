Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD35540708D
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 19:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhIJRcx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 13:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhIJRcw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 13:32:52 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13254C061756
        for <cgroups@vger.kernel.org>; Fri, 10 Sep 2021 10:31:41 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p15so4397038ljn.3
        for <cgroups@vger.kernel.org>; Fri, 10 Sep 2021 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4e2VGm4rZT+9uHWwvDnPkLTEAhTR8ODAxNvnYiGuQw=;
        b=S+FRcNht9+4Pr/NtV9V2YjE7h0FhQpqrIe5JtlAODhefHbazOjyRwvpQvlwmcyzu4g
         0sVjuV3fYVzTwn+rQjMjzlGV//VbtvsfgZsPGFB6IrGbHKKhMb+mybS7IO0v65yKcaRh
         TK+MwUWxI2g/bmAC5bWTKkply4ijnNYq9i7W/jEU498T5Iq+ayXfv0Aay5A4vADoCIB+
         TMskqhFeYtFPcFdU8c5ZCQHsJJMgtKUdvilz7xSoVnO6YOBSdgkKRcl2OkgXIVB+u0Vb
         c/EqFmNmYv6+mLrzlUongpTVBH3Qa+18Z56OxVXJw7zRt6clfU5eXBRB1t844WITPHlw
         Cphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4e2VGm4rZT+9uHWwvDnPkLTEAhTR8ODAxNvnYiGuQw=;
        b=2sEZN22+S+XnhtqyzsDFlmpvYo5jHuTcghpUrDABpOyk6L+lRUcCYEwxAsBvexzGj8
         atVwT4xwwFqOtzckK9qOFK99PHlqXYTXgks1iJH0oXQ45cziQHccbSPkipNs9cqVqHeH
         4A96TJT9OApc8tmTZBJXLzVAC4WaFIc0Lesi8VN+ctA28lfRpteuqxo4Ky5PP9f8cge8
         ZPlkpXfCy/1cVTjj2b9fYGfSr+nC8PadoA7F5y4tFVxJSk4Oyg0kx57l8/cK4IKFxQCi
         ljnkv9Cr14NrXrcQYNqg3dj1j9AvW2XJp3MFz5LbTvztiKbJrxgLmf3FJCyi0r8rs7zv
         Ut2w==
X-Gm-Message-State: AOAM532/a0ONa5rCZzs7/zWOxAgB2YV3y4+/17wZBaQ61/jC3rTgF3l0
        TbQJlR5rOIJRTWp3cYi2szzTnR6EObTqYxQb8TQ8FA==
X-Google-Smtp-Source: ABdhPJzxGsvnhtoDyp1S5grIVf0HLmZUqMLkIXVEtYHqIrNRlkoQTlKka5XRMeTGuFVk9rMPcrl9KJSe50kWq9pvmQg=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr4992808lji.508.1631295098788;
 Fri, 10 Sep 2021 10:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com>
 <20210909143720.GA14709@blackbody.suse.cz> <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
 <YTpY0G3+IJYmGbdd@blackbook> <478e986c-bc69-62b8-936e-5b075f9270b4@gmail.com>
 <20210910092310.GA18084@blackbody.suse.cz> <1679f995-5a6f-11b8-7870-54318db07d0d@gmail.com>
 <20210910153609.GC24156@blackbody.suse.cz> <YTuH9fULTx+pLuuH@slm.duckdns.org>
 <CAHVum0ezWW=4x2YgXHhEUFQOkFGBpP+R1Uc-KedHr+r0LGibwA@mail.gmail.com> <YTuTr5Hw4hPIWepd@slm.duckdns.org>
In-Reply-To: <YTuTr5Hw4hPIWepd@slm.duckdns.org>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 10 Sep 2021 10:31:02 -0700
Message-ID: <CAHVum0e+68df7b_e0RoCGgA1h_SLdTt9t2MZ0VgA9afPW9iEvg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        "brookxu.cn" <brookxu.cn@gmail.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 10, 2021 at 10:19 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Sep 10, 2021 at 10:16:46AM -0700, Vipin Sharma wrote:
> > For now, I think we can just have one file, events.local
> > (non-hierarchical) which has %s.max type entries. This will tell us
> > which cgroup is under pressure and I believe this is helpful.
>
> How about just sticking with hierarchical events? Do you see a lot of
> downsides with that compared to .local?
>

Local would have made it easier to identify constrained cgroup and the
lesser number of file notify events will be fired.

I don't have a strong aversion to hierarchical events only as well if
that is more suited for the cgroup v2 style.
