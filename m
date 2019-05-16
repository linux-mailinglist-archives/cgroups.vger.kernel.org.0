Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A2D20DEC
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 19:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfEPR0E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 13:26:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40930 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfEPR0E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 13:26:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id d15so3829169ljc.7;
        Thu, 16 May 2019 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YsmiCF+0ChugiiWHEcFwV16sqQfUmNJP6UJfaTo0+0=;
        b=EGZKEVL8Lf3a8GdWC0vp4TdMLolm0MREXJP2qv3Dfg5SeFbUcgf+UXwo/ORJy8+VC8
         WD1pNne/r6jXuNvNz4I9jtA5mK7fo7cgiL+8kApoaE+uvBnZhxTd0ra1n7hACytIHGwy
         O9jB/YSzTxSiwiQYSpCqUDd7P6mHSP+HyE5s87LEpneXgY2UjdqXCR7Jdazun/2KndLh
         /xblAVUWoHiBQY2Cxj2nTHSnlkPD4Qb86GLD0xZGtMppusn6b+Q4IAtItoBdpDfMke3L
         HWJ80X9+Prcr2SkPDlq3b0eOSU27zNmO91Vio/XnLiLt76PZdbf7rgvOmlb1xR8cr4DS
         xjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YsmiCF+0ChugiiWHEcFwV16sqQfUmNJP6UJfaTo0+0=;
        b=Z7j/ODZuhqyvDoQzrgYIS2ynJeGcZlw55R7nv9gMsvweEd1CEyRSOmWzfw8hTfLC8e
         cMyZP84H+odPtbXxmayM+2dv+bcmIdLFNRZhPqLp3tLOEdvJMRYn1biHu7MF0ypwL0dD
         zASoMo4xQa+NETl+jpWZtFynHvKzg/i+O2rPHUtvxQufseDdxumIlcR2L142eTsXskSX
         E7gD2TMUfbz5nk3AdNKwGvoFut8fBbjBjHZzvWeEMGEWeQ9OuZS6oX37KyuP2cEriICR
         FBGzLa0x6KC1UU3uh4a5N5F0v3B3j+O4ktp41O9+P4u7LKyXNof2B76QFuHp2GKxAkZw
         XCmA==
X-Gm-Message-State: APjAAAV/WbhBhfiUHLiV89Ih1zM6dwrHYwBF6JTf802DSU9rChzrIvAH
        LivvvCg3evEzJisCbOFRh0hbW2W5h4EMEY73ItI=
X-Google-Smtp-Source: APXvYqxswR6qsbROOkH8Y4iYo8uiFgBaL+buhjJIl2g2Dh9SHbbC32YR2fWrXoGCWI5M+ygvq4EE+tTc1aFOaWR9wUE=
X-Received: by 2002:a2e:9f44:: with SMTP id v4mr2860319ljk.85.1558027562260;
 Thu, 16 May 2019 10:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190516103915.GB27421@krava> <20190516152224.GA7163@castle.DHCP.thefacebook.com>
 <20190516153144.GC19737@antique-laptop> <20190516171427.GA8058@castle.DHCP.thefacebook.com>
In-Reply-To: <20190516171427.GA8058@castle.DHCP.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 May 2019 10:25:50 -0700
Message-ID: <CAADnVQ+c4HW+1jrurHDX0M4-yn13fmU=TYhF+8wPrxNZZRcjTw@mail.gmail.com>
Subject: Re: [RFC] cgroup gets release after long time
To:     Roman Gushchin <guro@fb.com>
Cc:     Pavel Hrdina <phrdina@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Daniel Mack <daniel@zonque.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        "hange-folder>?" <toggle-mailboxes@castle.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 16, 2019 at 10:15 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, May 16, 2019 at 05:31:44PM +0200, Pavel Hrdina wrote:
> > On Thu, May 16, 2019 at 03:22:33PM +0000, Roman Gushchin wrote:
> > > On Thu, May 16, 2019 at 12:39:15PM +0200, Jiri Olsa wrote:
> > > > hi,
> > > > Pavel reported an issue with bpf programs (attached to cgroup)
> > > > not being released at the time when the cgroup is removed and
> > > > are still visible in 'bpftool prog' list afterwards.
> > >
> > > Hi Jiri!
> > >
> > > Can you, please, try the patch from
> > > https://github.com/rgushchin/linux/commit/f77afa1952d81a1afa6c4872d342bf6721e148e2 ?
> > >
> > > It should solve the problem, and I'm about to post it upstream.
> >
> > Perfect, I'll give it a try with full libvirt setup as well.
> >
> > Can we have this somehow detectable from user-space so libvirt can
> > decide when to use BPF or not?  I would like to avoid using BPF with
> > libvirt if this issue is not fixed and we cannot simply workaround it
> > as systemd automatically removes cgroups for us.
>
> Hm, I don't think there is a good way to detect it from userspace.
> At least I have no good ideas. Alexei? Daniel?
>
> If you're interested in a particular stable version, we can probably
> treat it as a "fix", and backport.

right.
also user space workaround is trivial.
Just detach before rmdir.
