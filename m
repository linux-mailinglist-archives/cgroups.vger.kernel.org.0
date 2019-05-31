Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D923078C
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2019 06:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfEaEFy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 May 2019 00:05:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46080 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaEFx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 May 2019 00:05:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id l26so6721069lfh.13;
        Thu, 30 May 2019 21:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VcjAC4JQMdoF7isS9cdHm7wqc4qunRDCIHNfgNMmAM=;
        b=FWExfyFr7Erc9jYAYe2rB10EppsXdu9fwCoJgWmHhR85WMldfIQcdUgPIgGGbB3TrV
         Jxyi/lA3laeoi1PHxuih1T80zGNJ/FrUQa517UXaaAAshRFjr1xcTLfzLcgBjftndW8T
         odQ+NKC5lMrg2TRQuxIH+9Q6WgPgCTIdvtx8l6rvNRX6G/8DL9obV3KmzltnOLK8c+XI
         B0hnnE9kPHqPNDdoKXMHTpeh09fyxgVaKp0Tx18rs4XADKG0HI/1KnPZ+lAK9k2K7SQB
         bJzqynlCYPZt9nC3e5RK7n2YnCcVnX0gS4kfOx9hGWMA1xHn1eVbaXBg94kyeyb3viFv
         Relw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VcjAC4JQMdoF7isS9cdHm7wqc4qunRDCIHNfgNMmAM=;
        b=WkVXzUefUkWoe3KYB725qYNE593/jQShc04lWy5YLnaiBFops1+BpFG+fkOyJGcoRO
         nbkGnsiCNgEDbM2CRsT9dhuqVq1N+yH+llC+vtnTlCsdpRWTK31dtexuQAwuJAxr8nFy
         w2dSqN3LRhKqDcBhlu0TVQAaJyQA3kCgfQR59nage4ioonZtBkDGDaPh4y7+qCF4fNo1
         bWZWeUCXfUqIBXQUHee/K9hUBsK//CxXBFANIRW/cQO9kZHevAOq4wSLDAlvbxI+mwyy
         x8/U+rQYOUmmbFO6ZXQ5aIS2LPHpkteJyhrs1+LKBMkB51/3yu6A9BxipYb2YWrbCJ0d
         ot1w==
X-Gm-Message-State: APjAAAU1eMeQxzbugkn8LCuHU3QUGNhmfib7tddVk67ZagaD0u98tQcG
        EJzcaGWErP/k+LORnEnGiB0BSHMiBuaykJE0AT0=
X-Google-Smtp-Source: APXvYqz5DfGuXFM3fPfddDGSd3hMqPY36FIDZDY/c/SB+Hm/tRO8es4EncHkWSrtWoCt1ruu4yl0p5F+AvEqm5XGhX4=
X-Received: by 2002:a19:2791:: with SMTP id n139mr4332391lfn.67.1559275551682;
 Thu, 30 May 2019 21:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190523064412.31498-1-xxhdx1985126@gmail.com>
 <20190524214855.GJ374014@devbig004.ftw2.facebook.com> <CAJACTueLKEBkuquf989dveBnd5cOknf7LvB+fg+9PyjDw1VX6g@mail.gmail.com>
 <20190528185604.GK374014@devbig004.ftw2.facebook.com> <CAJACTucnCGLTbRAX0V5GBMmCQh4Dh8T9b0in1TUMCOVysJ0wjw@mail.gmail.com>
 <20190530205930.GW374014@devbig004.ftw2.facebook.com>
In-Reply-To: <20190530205930.GW374014@devbig004.ftw2.facebook.com>
From:   Xuehan Xu <xxhdx1985126@gmail.com>
Date:   Fri, 31 May 2019 12:04:57 +0800
Message-ID: <CAJACTuc+B+v0yGFY3L7iS1qTdRsw7b6tw5_e9sP43LuR=P1NWA@mail.gmail.com>
Subject: Re: [PATCH] cgroup: add a new group controller for cephfs
To:     Tejun Heo <tj@kernel.org>
Cc:     ceph-devel <ceph-devel@vger.kernel.org>,
        "Yan, Zheng" <ukernel@gmail.com>, cgroups@vger.kernel.org,
        Xuehan Xu <xuxuehan@360.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 31 May 2019 at 04:59, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, May 29, 2019 at 10:27:36AM +0800, Xuehan Xu wrote:
> > I think, since we are offering users an interface to control the io
> > reqs issuing rate, we'd better provide the interface through the io
> > controller, is this right?
>
> I'm not entirely sure what the right approach is here.  For most
> controllers, there are concrete resources which are being controlled
> even if it's a virtual resource like pids.  Here, it isn't clear how
> the resource should be defined.  Ideally, it should be defined as
> fractions / weights of whatever backends can do but that might not be
> that easy to define.
>
> Another issue is that non-work-conserving limits usually aren't enough
> to serve majority of use cases and it's better to at least consider
> how work-conserving control should look like before settling interface
> decisions.

Hi, Tejun.

The resource that we want to control is the ceph cluster's io
processing capability usage. And we are planning to control it in
terms of iops and io bandwidth. We are considering a more
work-conserving control mechanism that involves server side and are
more workload self-adaptive. But, for now, as we mostly concern about
the scenario that a single client use up the whole cluster's io
capability, we think maybe we should implement a simple client-side io
throttling first, like the blkio controller's io throttle policy,
which would be relatively easy. On the other hand, we should provide
users io throttling capability even if their servers don't support the
sophisticated QoS mechanism. Am I right about this? Thanks:-)

>
> > Actually, for now, we are considering implement a ceph-specific
> > "blkcg_policy" which adds new io controller "cf" files to let users
> > modify configurations of the ceph-specific "blkcg_policy" and limit
> > the ceph reqs sent to the underlying cluster all by itself rather than
> > relying on the existing blkcg_policies like io latency or io throttle.
> > Is this the right way to go? Thanks:-)
>
> Can we take a step back and think through what the fundamental
> resources are?  Do these control knobs even belong to the client
> machines?

Since we need to control the cluster's io resource usage in the
granularity of docker instances, we need the clients to offer control
group information to the servers even in the scenario that involves
server-side QoS as only clients know which docker instance the
requesting process belongs to. So we think, either way, we need some
kind of cgroup relative functionality on the client side. Is this
right? Thanks:-)

>
> Thanks.
>
> --
> tejun
