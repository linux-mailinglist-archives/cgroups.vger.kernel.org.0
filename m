Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1753C1378BD
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2020 22:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgAJV4z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jan 2020 16:56:55 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39885 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgAJV4y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jan 2020 16:56:54 -0500
Received: by mail-qk1-f195.google.com with SMTP id c16so3385006qko.6
        for <cgroups@vger.kernel.org>; Fri, 10 Jan 2020 13:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6hNzu1Oo7PHMOnFbZClvOZQnKyzqO41DtlrzmrxAtKo=;
        b=P33WSIBIvROI0TAlJXbNz6ELf/4rfmv3kPuHPDXo6fYLm1KX6hT6290vFs5gBvvE6s
         MIkouKk2z7qtr2hKJY3+be4lCgduxU7tREMFalr/ft27ItaoSfMbz1QwyyK5pvoJRU5r
         4yokCJURUz9SByDJUAXYyUhrfQH7TcbrUXN3JmblesqGa8T8bzuPIWUtyB8i90tVt3D9
         c5VXLxusn5I02b5+uW7gDwkUbB/f7IF+7om2LD9+V6AkRr4boG24xKuiGQRQaLXjamWT
         OLmvO/UEsIghC1pM/HatZWerQr9V/VJywJlj0gMU6fQBzuIW/Nnqj3CjHEhD2Zsnwm+O
         v0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6hNzu1Oo7PHMOnFbZClvOZQnKyzqO41DtlrzmrxAtKo=;
        b=ByAfa2RBEYsoliKeVeaJMmAVqnNv7dupC7lXqVjmurYJTkcYql4ILN31BYJMcr4b01
         MEEOkJtT2e8BsR+ptIoO8/btK46p0/a03GrtEAYQEtEPzl3TvdY2R56NCYeBtksLf1r7
         DuCDZx0EBtBSlfxQTjG1WhPjKnzpyjvr/z2NC8VsY+3QoY+J1A4dJ5yuBdSMeDlO9acO
         JdMfQ7iJTF8y+NGAPxocUViWqNW6JBcO0+t7Y/AeX1JPQr6EryJnHRrMUF3e/ZOjnF54
         DRZ8Qa2VOsezUdlUVqL86qg5gINN9T3L7RGUeldHsLRf+sknIPGXTyDzRfmY311S1NWG
         hPEQ==
X-Gm-Message-State: APjAAAVfoiGI0kpPN3X8PNMsnSWonJHokk66yC0BnERIi6h+NbyTwjbg
        7TKg0QXOpaAUpkKKppt9xLw=
X-Google-Smtp-Source: APXvYqyBtG5sixCC0zfqm4jg010b8qydS/IKfZGwqI2/OxGkhAlHoSDtaPa7OKE2zwRrX1tnfAaX8A==
X-Received: by 2002:a37:b602:: with SMTP id g2mr5458197qkf.174.1578693413889;
        Fri, 10 Jan 2020 13:56:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:de76])
        by smtp.gmail.com with ESMTPSA id s27sm1445648qkm.97.2020.01.10.13.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 13:56:53 -0800 (PST)
Date:   Fri, 10 Jan 2020 13:56:48 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Topi Miettinen <toiwoton@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        security@debian.org, Security Officers <security@kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        james.hsu@mediatek.com, linger.lee@mediatek.com,
        Tom Cherry <tomcherry@google.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 3/3 cgroup/for-5.2-fixes] cgroup: Include dying leaders
 with live threads in PROCS iterations
Message-ID: <20200110215648.GC2677547@devbig004.ftw2.facebook.com>
References: <87zhn6923n.fsf@xmission.com>
 <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
 <20190607170952.GE30727@blackbody.suse.cz>
 <20190611185742.GH3341036@devbig004.ftw2.facebook.com>
 <CAJuCfpGkAsmp5B=fNz38fLE8pYaMCG=uLDSSBFByNOtWD20zVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGkAsmp5B=fNz38fLE8pYaMCG=uLDSSBFByNOtWD20zVQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jan 10, 2020 at 01:47:19PM -0800, Suren Baghdasaryan wrote:
> So from user space's point of view the cgroup is empty and can be
> removed but rmdir() fails to do so. I think this behavior is
> inconsistent with the claim "cgroup which doesn't have any children
> and is associated only with zombie processes is considered empty and
> can be removed" from
> https://elixir.bootlin.com/linux/v5.4.10/source/Documentation/admin-guide/cgroup-v2.rst#L222

Yeah, the current behavior isn't quite consistent with the
documentation and what we prolly wanna do is allowing destroying a
cgroup with only dead processes in it.  That said, the correct (or at
least workable) signal which indicates that a cgroup is ready for
removal is cgroup.events::populated being zero, which is a poll(2)able
event.

Thanks.

-- 
tejun
