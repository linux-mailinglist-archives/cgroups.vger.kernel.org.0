Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0B32D3D0
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2019 04:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfE2C2Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 22:28:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34010 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfE2C2Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 22:28:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id j24so861632ljg.1;
        Tue, 28 May 2019 19:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jngkMWQWeT6Ytmh9mcjV3DQL1AShmUfVQ6aFNiIluI=;
        b=nJ4xE5inj00Fe2a1TbZXYkujROIcoPjG/hbkA0ys18kpxfk+/lel51EN+/3hRjMTBE
         vmt+jXznMSmhJudZZZe6GlL+fLapUegrFbNVTuHRsFU9O0jafXIJr6ILDZZ4OXddWbKW
         BRGC7z7ea7sLn4vOyLTysUwXg3KDBcdXwND2q9yFOIte+C7oC9xCLzwNSo9aEH27X7se
         jpCfNgFkaZwPwZQkpf8Nue3mg1CK03NrnRHMwAtCt+1jQsgi6EfkdY0iTLEjb/fIhIBa
         FYz7z5OtBY2q2g8rOp9t0bL4FHmIEPoy1S1N8DRafuV+ijK2eJy3njl9ekpEytCOBeSK
         4RlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jngkMWQWeT6Ytmh9mcjV3DQL1AShmUfVQ6aFNiIluI=;
        b=BA/wA6BM3dJzYA2iprTmlpID1hBRgk703IeFV7TjIRDWWB21Zw7SO0N4sKx1xNeYm/
         4/jhy3dvqFJ70OVlBEY6BqKuqHyMSiYLfX9AgP4+BPwil0LlUe2CKNx4nug1vJKHjOiV
         XpvpaXcFjRN3saeEDXzsi0SPR0V9s9+H4792U2sD/obM3SQQqYMZpSxzs0zpFeJszQtq
         1CkdffHUMVFDzK3Myi/AHbJeN7D0e5lBH6IAgJmqXPAvwE8DDX2duYcw3fXzpAcnVDyL
         r2bGVvBtWTfZ5m9wVgz3eWItK9gBUClMGS1SxNLbRu5dnP9MyTnRjaE/WE3J9aBQCmq1
         Ppqw==
X-Gm-Message-State: APjAAAVKuzvjI7I76FdJzXR7xUpAwYuHIuKMtz89tl3gdBqMkRGBBrK2
        y7wT6gKGaIIwiLzlDWwUOOy6xdRtNIIR6P/PJQ4=
X-Google-Smtp-Source: APXvYqw8PopHT10RBVxKSi+QeWS+ud4on5c9+NwmkJLEAaoUYLmW2DSqt+82RDhGoedfmlz8lWr6Q5PsOW7hGKlQ9oU=
X-Received: by 2002:a2e:b0d0:: with SMTP id g16mr40536101ljl.132.1559096902271;
 Tue, 28 May 2019 19:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190523064412.31498-1-xxhdx1985126@gmail.com>
 <20190524214855.GJ374014@devbig004.ftw2.facebook.com> <CAJACTueLKEBkuquf989dveBnd5cOknf7LvB+fg+9PyjDw1VX6g@mail.gmail.com>
 <20190528185604.GK374014@devbig004.ftw2.facebook.com>
In-Reply-To: <20190528185604.GK374014@devbig004.ftw2.facebook.com>
From:   Xuehan Xu <xxhdx1985126@gmail.com>
Date:   Wed, 29 May 2019 10:27:36 +0800
Message-ID: <CAJACTucnCGLTbRAX0V5GBMmCQh4Dh8T9b0in1TUMCOVysJ0wjw@mail.gmail.com>
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

> Hmmm... io.latency works only if the IOs pass through a request_queue.
> Given the transport is network, would it make more sense to control
> from network side?

Hi, tejun:-)

I think, since we are offering users an interface to control the io
reqs issuing rate, we'd better provide the interface through the io
controller, is this right?

Actually, for now, we are considering implement a ceph-specific
"blkcg_policy" which adds new io controller "cf" files to let users
modify configurations of the ceph-specific "blkcg_policy" and limit
the ceph reqs sent to the underlying cluster all by itself rather than
relying on the existing blkcg_policies like io latency or io throttle.
Is this the right way to go? Thanks:-)
>
> Thanks.
>
> --
> tejun
