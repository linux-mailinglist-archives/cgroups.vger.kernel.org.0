Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 143FC194B29
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2020 23:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCZWD6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Mar 2020 18:03:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56053 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgCZWD5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Mar 2020 18:03:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id z5so9029209wml.5
        for <cgroups@vger.kernel.org>; Thu, 26 Mar 2020 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVqQ7MESPq+AdE5FevBfn8AolxVmIzRfASYgM+H4STI=;
        b=szyVRdKUxChTizOYbqe+xujjj60j68XNY2SNyiTfGDb2FOQdOSEPl8zDMtKzEbkOEZ
         jtQCP5i4iuVP5zMrvcycKgn+qO0lKj6TLMeJBhnVXT7oeJu21WuKDaUh+y8ixfdNBFQE
         6oFyY3Q/46KVNkl3A8NeA+LMUYdpO7Slu4Tee/ERY9zUHc82YMPuRjGkqdBeKwfxRCqI
         KqUxD+S3Z4nw18kpiJmpbKA3PX2nTDSUVzJgPVy956S23Br/VEIcdC+LK3Daw9ljv9+8
         qhXItEAmwk5k03a/QD0NnuHKpqd5PPMt7j1aOKfkpLTyiT23voWFEOtliyOSwkXqS9x8
         b3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVqQ7MESPq+AdE5FevBfn8AolxVmIzRfASYgM+H4STI=;
        b=TfXCWGaw1HijlaJhhfNIIAgBfsTaqG8qQJdhSyxhZ8YNbM1EvyWpiFEXswRSJD5sYX
         RTM1vrejAyiI7GuUScXzaKlVdadD/oM7hmeQECtFWKU8zNzQ/DMIMehw0eybUNYtJ5ha
         /YUdpoi+2rzrvOlCc0ubJeUgG1jws35ajLQngGGHF4nRnjD6fsxag0bGJR3tbm44vQb0
         fSiXMiRfS4kAMmBKr9+dtb8m9OxyPQeiMZG9Hu65Q+S46Lgvmz7LNBNcSOtKk0Az2bhL
         UfrBKh8aSJyO8ndXROgGebZnnhv6lfWpWUknbOJ3pvR7NAKVhyzz7rlduqUDhABMnKXT
         Rzmw==
X-Gm-Message-State: ANhLgQ1evFTQibID+ct7LfdNSJR4Av9JDbDAKP/7JmjoxgED5QDn4YkW
        en6rkrCmaHKbO0b4lpn4D/LpMfPUXtvY4zP5YI4QXw==
X-Google-Smtp-Source: ADFU+vvMOIE+L0ZTf7lmFa3S++2BBLAB6zolh3w3IlymO56zrtRps0+OWtJzfllf8QITGyf0P7J6Gml1J+knvxy+Wb8=
X-Received: by 2002:adf:b60d:: with SMTP id f13mr12155953wre.12.1585260235721;
 Thu, 26 Mar 2020 15:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200326191623.129285-1-joel@joelfernandes.org>
 <20200326192035.GO162390@mtj.duckdns.org> <20200326194448.GA133524@google.com>
 <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com> <CAPz6YkVUsDz456z8-X2G_EDd-uet1rRNnh2sDUpdcoWp_fkDDw@mail.gmail.com>
 <e9093ab2-f61f-edf1-5da7-fce5101d6dbf@redhat.com>
In-Reply-To: <e9093ab2-f61f-edf1-5da7-fce5101d6dbf@redhat.com>
From:   Sonny Rao <sonnyrao@google.com>
Date:   Thu, 26 Mar 2020 15:03:42 -0700
Message-ID: <CAPz6YkXVYJBow-6G023eaDEKFORPh3AKQb6gfrM8XX8=bdXL2A@mail.gmail.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
To:     Waiman Long <longman@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        Jesse Barnes <jsbarnes@google.com>, vpillai@digitalocean.com,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 26, 2020 at 2:47 PM Waiman Long <longman@redhat.com> wrote:
>
> On 3/26/20 4:05 PM, Sonny Rao wrote:
> >> I think Tejun is concerned about a change in the default behavior of
> >> cpuset v1.
> >>
> >> There is a special v2 mode for cpuset that is enabled by the mount
> >> option "cpuset_v2_mode". This causes the cpuset v1 to adopt some of the
> >> v2 behavior. I introduced this v2 mode a while back to address, I think,
> >> a similar concern. Could you try that to see if it is able to address
> >> your problem? If not, you can make some code adjustment within the
> >> framework of the v2 mode. As long as it is an opt-in, I think we are
> >> open to further change.
> > I am surprised if anyone actually wants this behavior, we (Chrome OS)
> > found out about it accidentally, and then found that Android had been
> > carrying a patch to fix it.  And if it were a desirable behavior then
> > why isn't it an option in v2?
> >
> I am a bit confused. The v2 mode make cpuset v1 behaves more like cpuset
> v2. The original v1 behavior has some obvious issue that was fixed in
> v2. So what v2 option are you talking about?

I was merely pointing out the behavior of the v1 implementation is so
undesirable that it wasn't kept at all in v2.  IMHO, it's a bug that
should be fixed, and I think it's possible to keep the old behavior if
all cpus are offlined, but since you've added this option we can use
it instead.

>
> Regards,
> Longman
>
