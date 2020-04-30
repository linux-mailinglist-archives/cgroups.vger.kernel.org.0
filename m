Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B6B1C07BC
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 22:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgD3UUZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Apr 2020 16:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgD3UUY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Apr 2020 16:20:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B41C035495
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2020 13:20:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so727463ljg.5
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2020 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=guKhKwrXEiDwgQzNFnO6v/2/mR5PiCzsUtQ3eT/ji4A=;
        b=gcaVyYdy32+4klv0m7W2u51o7lyTPuxVavEx8YwwdS2ENTcJOhovS0+Av7iXHFQVaW
         0DkmLQyPVheQfV0yVq4/ZjJ45Sm4cgzctg6kflk4xvDPRrCz9H4ctmEhZ7rU/ru60hBr
         5GNSJ3glyv1H/QAIx+KBjmCRwKhXWNzFHz1I5byQDnFd7QYuRsaizyq0/JvpuuF3vJBs
         sznI+dhDToDpZ8UYWzDkrEUWudNUnX2Au2DdObfHIzf0dkRHz9gnaCDhJiK/f0xcrvQq
         j69cVNJu7Ta/ldmUGyk+fln1PTh2sTsRPZdyYGbDCCdEisLWPib9t2fJl2bYdT22T2p4
         6sDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guKhKwrXEiDwgQzNFnO6v/2/mR5PiCzsUtQ3eT/ji4A=;
        b=boFGMvijxcLCRihu1Po/voA2yabolWZyKohbuyNvdV+6n2IlUuWohv+U32bELdC9m1
         gSHWlKnc59pY9K+m9N/rapaZPj9ovlctF8bDuRgss2pTrW443yLo8Lr1BkiNSgmsb5Yt
         1QgTk8nCjzSOHDbIAW0AqSyCLZVcD+o/5FV7nbiZXRdLN2PgwQ0fwB6OoEYn5rF5RvfS
         DXOumiWyp6qAmjHfb0wP1vTohp84ZbM8td/okevm6Xyox4Smar5rH1tpp6TlxdVv7zZG
         oUqp3Lklyzhg3DQRvqEzUvzu3R1tl0uNZB3rsM0pKdiB0mebsIh3jPpfQPseWpCLkQBl
         WJDA==
X-Gm-Message-State: AGi0PuYqmUo1ZKt8wDHpADqv1jbX0DWbpewg0jdof/7CMN4RzV4ul4gz
        dOFAIHJ9qUFCYP8nhPDtVb3mZS5hS3thWrlfz7Ic5A==
X-Google-Smtp-Source: APiQypIN1pXroLJgB0zigxp45+sMYFPb32PYYNnPovYQfEX4qVKgGdnnsiT3h2XmdfDD/SQlJTrtw3sUQJsp6N9FWGI=
X-Received: by 2002:a2e:9a4a:: with SMTP id k10mr366782ljj.115.1588278022286;
 Thu, 30 Apr 2020 13:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200430192907.GA2436@cmpxchg.org>
In-Reply-To: <20200430192907.GA2436@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 30 Apr 2020 13:20:10 -0700
Message-ID: <CALvZod6Gatw+sX7_hsVPB-O2yMt-ygXUSweQbHwxZHgwdEth4Q@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 30, 2020 at 12:29 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Apr 30, 2020 at 11:27:12AM -0700, Shakeel Butt wrote:
> > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > succeed. However if oom-killer does not find a process for killing, it
> > dumps a lot of warnings.
> >
> > Deleting a memcg does not reclaim memory from it and the memory can
> > linger till there is a memory pressure. One normal way to proactively
> > reclaim such memory is to set memory.max to 0 just before deleting the
> > memcg. However if some of the memcg's memory is pinned by others, this
> > operation can trigger an oom-kill without any process and thus can log a
> > lot un-needed warnings. So, ignore all such warnings from memory.max.
>
> Can't you set memory.high=0 instead? It does the reclaim portion of
> memory.max, without the actual OOM killing that causes you problems.

Yes that would work but remote charging concerns me. Remote charging
can still happen after the memcg is offlined and at the moment, high
reclaim does not work for remote memcg and the usage can go till max
or global pressure. This is most probably a misconfiguration and we
might not receive the warnings in the log ever. Setting memory.max to
0 will definitely give such warnings.
