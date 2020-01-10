Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A559B137993
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2020 23:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgAJWP4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jan 2020 17:15:56 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36140 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgAJWP4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jan 2020 17:15:56 -0500
Received: by mail-qv1-f68.google.com with SMTP id m14so1527669qvl.3
        for <cgroups@vger.kernel.org>; Fri, 10 Jan 2020 14:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yXIVe2dTLc7Z63wJAa51lMa4i7IcmWqKH3GK/I4PfiA=;
        b=NhOpxDYQeVJJNEAquPQAe5JMywSLk/WrXx228nGhCAAj7I0pdgHEdLYEIFbpyBnBwk
         Sdw+g408KW3Q7oIl+smVnnPwx0ddixJXLiAyQMnPvLXy+yqKcQ09qXOcb85JHxnfF1WW
         vJctDD1q0qb398FOcN3Pb5fRNQF7YpujJgNPJBAelD3lWyVifUtyAAHF3UWuG6bBTuSH
         7J7gC8GAEXB6Nb6ddSUWg/ZKv2GreQshOqclrkgt05xyy6/P1IBzIteV4tQ6Mb4OL3eE
         IowUaH8J8qP9Fv+pnJr29ma29v9VArC6/0JJrNWsKCUz/cfXzz/m6NkkZLCdlgDlTPiq
         zo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yXIVe2dTLc7Z63wJAa51lMa4i7IcmWqKH3GK/I4PfiA=;
        b=p14TC5sBJFsOnBJlUSxGTm3XMaJJ8x0owiyBVa72p5+2e9qv68/f70twkKuiB5sl45
         pm4bHbRDyd9R8bsEE8m49e/t/YLiRbNnI5VRVUwSWAdg1yFmuH40isW66n+0h3jK3VE8
         2ppvUYBrSkVciBeqjfO5NWT+QVEJpb8lea34Da7AsOrSitH2urL3alpnSmHq1XTYQMyv
         05s/wrWNx81HGizLDCl4sH+Vtqt1PWWNt4EmnX2fYBLIYmL39KRcrWoX33bMEKhkWujs
         H7MM9Of5zHFTyzKhpiiDiQyxWNEV2HCQgYX1tHlaU3efhIwaDM9zQ3UH9l/KlRnUOUBZ
         5hqQ==
X-Gm-Message-State: APjAAAVwh63Xl9ssJtfVBjQEHnUbCk0a8a+VFoXsSsQNQx10aelJIoNU
        U7JX+205oXnbGvpKtcIVluc=
X-Google-Smtp-Source: APXvYqxCGJLhHVd0F5j9GUZsHcwcjyJowqn6o8g9Le/jq03qAPwludHqDZJv6IcbNGbhbZuNitof9w==
X-Received: by 2002:a05:6214:6ab:: with SMTP id s11mr910486qvz.180.1578694555490;
        Fri, 10 Jan 2020 14:15:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:de76])
        by smtp.gmail.com with ESMTPSA id z141sm1493829qkb.63.2020.01.10.14.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 14:15:54 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:15:53 -0800
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
Message-ID: <20200110221553.GD2677547@devbig004.ftw2.facebook.com>
References: <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
 <20190607170952.GE30727@blackbody.suse.cz>
 <20190611185742.GH3341036@devbig004.ftw2.facebook.com>
 <CAJuCfpGkAsmp5B=fNz38fLE8pYaMCG=uLDSSBFByNOtWD20zVQ@mail.gmail.com>
 <20200110215648.GC2677547@devbig004.ftw2.facebook.com>
 <CAJuCfpHPRfV5KDM74JtDepdUJ2G+-3-A3XV+Fzr3Lkbj9nR-Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHPRfV5KDM74JtDepdUJ2G+-3-A3XV+Fzr3Lkbj9nR-Cg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 10, 2020 at 02:14:19PM -0800, Suren Baghdasaryan wrote:
> > Yeah, the current behavior isn't quite consistent with the
> > documentation and what we prolly wanna do is allowing destroying a
> > cgroup with only dead processes in it.  That said, the correct (or at
> > least workable) signal which indicates that a cgroup is ready for
> > removal is cgroup.events::populated being zero, which is a poll(2)able
> > event.
> 
> Unfortunately it would not be workable for us as it's only available
> for cgroup v2 controllers.
> I can think of other ways to fix it in the userspace but there might
> be other cgroup API users which are be broken after this change. I
> would prefer to fix it in the kernel if at all possible rather than
> chasing all possible users.

Yeah, the right thing to do is allowing destruction of cgroups w/ only
dead processes in it.

-- 
tejun
