Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F3B199C1F
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgCaQwX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 12:52:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36400 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgCaQwW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 12:52:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id m33so18940410qtb.3;
        Tue, 31 Mar 2020 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5QdQJELOcEARpklGhcfRyc4XK3qOpUmQExpfCli9uaw=;
        b=lhnP63q6FHbTkDmsaVAbHbx5O9jgQdz8ILBnXyAQW8EWhoNE3rWAeH2Tb6658qcJt0
         gaoUFgwQSJmbOXCMLvEAAMnRhmfWK9ilMM8HKDi1bTQk5CXhrwBrTThiCXjarfCCTWDm
         Qaxn/T9wtn7ZsVlUGL2cNfzCwSn+jpk0ZPVRp/ByZURLckSKcJHBGXwwdnggw6SH14jT
         y7Y4vjRdNY2paebFxyxhZ2pJi2OFcU11vFO64Pkk0NOs3AXjHhWW9jHCF6zOIrgqRVxj
         ssLVSIETx1ZiWhcUcYkMiJnc94BHHIjGTHVHBzW/WvKgNhKGXZdLU76w1+1kakDhqkVh
         WR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5QdQJELOcEARpklGhcfRyc4XK3qOpUmQExpfCli9uaw=;
        b=FI/G6N7Go3BOz865+UqiPuVmR8kM1XEjHCSlns9bHd61u2pcLTTkP6QYhn+TTyDiJ5
         +1LMMN0sDpB2arKf7JmC9VKvy8KMQi6gaKenRZMsq4ixDl1eLQRIZR0XBveS2BhY/KU5
         /hcFBdmMvFvnx8yMo84Scuy8+ouHqO6UDXfeHFvsZyyxHtfGO+R3D2W0nthYK5mjvNNZ
         nzwmZKRKip0IoBmXqzX6CQ1YmBEmNmKhnGaaAO8MwjVDsQVqsr5DvxVMFfcuGTytpvZ1
         W4l0AavvyRlmP8gaGXMUw+SaRqmCswNZs/KpGtM+mUYjeTojLWlt9KNxKBzyk+wfzFCr
         rssg==
X-Gm-Message-State: ANhLgQ3CIO87pTGDBiV5GzMx5aJ/keTydkBAzRUhySdAAd+ZvXdVUY38
        yCbN/k3e2YIlTYe34684tkc5iv9sbtASTOd2YRo=
X-Google-Smtp-Source: ADFU+vsEokjkkNudcxEEMAdpfGLeH69VEteAjWQhulMNP+hActo74MOrq3W5ZxtFuqynK8vtzkv7Ren+dg7pxZ3InfU=
X-Received: by 2002:ac8:18c3:: with SMTP id o3mr6260590qtk.49.1585673542073;
 Tue, 31 Mar 2020 09:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com> <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
 <20200331143635.GS162390@mtj.duckdns.org> <CAA70yB51=VQrL+2wC+DL8cYmGVACb2_w5UHc4XFn7MgZjUJaeg@mail.gmail.com>
 <20200331155139.GT162390@mtj.duckdns.org> <20200331155257.GA22994@lst.de>
 <CAA70yB6PYH-W8-RRd7nxXOvpg6n+_-h_BLm6JA3EbLmsYG-ZSw@mail.gmail.com> <20200331163337.GA25020@lst.de>
In-Reply-To: <20200331163337.GA25020@lst.de>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 1 Apr 2020 00:52:10 +0800
Message-ID: <CAA70yB7V03mDSi8o8PEv0+8QzqZiA-8SJuGkyOXk5VRF-KHiQQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and nvme
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Nadolski, Edmund" <edmund.nadolski@intel.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Christoph Hellwig <hch@lst.de> =E4=BA=8E2020=E5=B9=B44=E6=9C=881=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Apr 01, 2020 at 12:31:17AM +0800, Weiping Zhang wrote:
> > Would you like to share more detail about why NVMe WRR is broken?
>
> Because it only weights command fetching.  It says absolutely nothing
> about command execution.

I know that different ssd vendor may have different implementation,
even some device can work well, seems you have no plan support it.
I drop this patchset.

@Tejun Heo  @Keith Busch
Thanks all of you
