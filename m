Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8697BABAD6
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2019 16:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394442AbfIFO2r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Sep 2019 10:28:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35118 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394274AbfIFO2q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Sep 2019 10:28:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id n10so7361659wmj.0
        for <cgroups@vger.kernel.org>; Fri, 06 Sep 2019 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CPNhO04EXqyOcEwUnPkRjub5+4HJbhPw4k4lP1BUIFY=;
        b=SgMVkFczhy1adqzEWg0jDFl+ms6YylZJ+CPw0meDi4tUKNT8GSH+BXVqYMst9hiMpB
         ahVaFQ2nBY9/RFvc6TbN6UuBnQKQ3l/SvFs0p2M2wqUn2P7rT7dzpxtzj1BejrOrcNf5
         GrJ+AkVNYBb/t76oZGsJzPhQKcne+Xrh7uGpnNSTVyWvb4al4388+x1HdL299wqPpp1c
         Lyg4KemDwXk0laBb06V79aAKdNQXdABlbYod4zV5iP3plkj5i/7NqDb4AJ7966TZklBZ
         Rg/lM3x03AjmR4EuOcvd1a7sRypF0naq0keKBd7Tttg3niHeMUPYrn5FnIk5e5EGmGFX
         cO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CPNhO04EXqyOcEwUnPkRjub5+4HJbhPw4k4lP1BUIFY=;
        b=QTrEBdH9hkNdezpubaHwZf+aE+UObxUZqesOL0c6w6XKOdIQZBT3+fX0gInQybWzrG
         NxaeZgkbtrjygrnGDVsiKdqksQZa+6qE3k4R2IbARq0M5f52fionq+CWJasW/WaWpKsD
         R9Ds5WGJGGp3GrUq8m5s6xfJ2NO2RPlcpM/Hw2w0p1NGLWjCqY8lt3G1Gz2lczKGqFrX
         X8zgEJjCqZynl1CmNzBIE5Bn0mlwmAncK13Doj1G4gDsyRTuzDAxj4BfC2BExd76UPlY
         vC02PeRPVeLQNluVEtLBo3AMbV+NRVyZtf1459tXU/dATqiKsYUXSBNnRWy9ru1a8Vyr
         SKjQ==
X-Gm-Message-State: APjAAAXdm8cUPvTkpiC0ZQDiR8gyAzpxV1RRA0zNHBYSOfFPB+RtM+hy
        6mMtV3x6ma9153/RZbAYuB87Ng==
X-Google-Smtp-Source: APXvYqyc6RBd2jtYFzjwtUHsMgQOUvTqHDhABOM21BWYEwlWnWzlh9cQtUKb1Yj7ckJuA6gf4WcLwg==
X-Received: by 2002:a1c:cb07:: with SMTP id b7mr7937000wmg.41.1567780124531;
        Fri, 06 Sep 2019 07:28:44 -0700 (PDT)
Received: from [192.168.0.103] (88-147-65-157.dyn.eolo.it. [88.147.65.157])
        by smtp.gmail.com with ESMTPSA id q25sm6346078wmq.27.2019.09.06.07.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 07:28:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v3 0/3] Implement BFQ per-device weight interface
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190828035453.18129-1-zhengfeiran@bytedance.com>
Date:   Fri, 6 Sep 2019 16:28:42 +0200
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, axboe@kernel.dk,
        Fam Zheng <fam@euphon.net>, duanxiongchun@bytedance.com,
        cgroups@vger.kernel.org, zhangjiachen.jc@bytedance.com,
        tj@kernel.org, linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9FD0759-F1A7-4675-A2B3-26E5F11019EF@linaro.org>
References: <20190828035453.18129-1-zhengfeiran@bytedance.com>
To:     Fam Zheng <zhengfeiran@bytedance.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jens,
is this patch series fine now?

Thanks,
Paolo

> Il giorno 28 ago 2019, alle ore 05:54, Fam Zheng =
<zhengfeiran@bytedance.com> ha scritto:
>=20
> v3: Pick up rev-by and ack-by from Paolo and Tejun.
>    Add commit message to patch 3.
>=20
> (Revision starting from v2 since v1 was used off-list)
>=20
> Hi Paolo and others,
>=20
> This adds to BFQ the missing per-device weight interfaces:
> blkio.bfq.weight_device on legacy and io.bfq.weight on unified. The
> implementation pretty closely resembles what we had in CFQ and the =
parsing code
> is basically reused.
>=20
> Tests
> =3D=3D=3D=3D=3D
>=20
> Using two cgroups and three block devices, having weights setup as:
>=20
> Cgroup          test1           test2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> default         100             500
> sda             500             100
> sdb             default         default
> sdc             200             200
>=20
> cgroup v1 runs
> --------------
>=20
>    sda.test1.out:   READ: bw=3D913MiB/s
>    sda.test2.out:   READ: bw=3D183MiB/s
>=20
>    sdb.test1.out:   READ: bw=3D213MiB/s
>    sdb.test2.out:   READ: bw=3D1054MiB/s
>=20
>    sdc.test1.out:   READ: bw=3D650MiB/s
>    sdc.test2.out:   READ: bw=3D650MiB/s
>=20
> cgroup v2 runs
> --------------
>=20
>    sda.test1.out:   READ: bw=3D915MiB/s
>    sda.test2.out:   READ: bw=3D184MiB/s
>=20
>    sdb.test1.out:   READ: bw=3D216MiB/s
>    sdb.test2.out:   READ: bw=3D1069MiB/s
>=20
>    sdc.test1.out:   READ: bw=3D621MiB/s
>    sdc.test2.out:   READ: bw=3D622MiB/s
>=20
> Fam Zheng (3):
>  bfq: Fix the missing barrier in __bfq_entity_update_weight_prio
>  bfq: Extract bfq_group_set_weight from bfq_io_set_weight_legacy
>  bfq: Add per-device weight
>=20
> block/bfq-cgroup.c  | 151 +++++++++++++++++++++++++++++++++-----------
> block/bfq-iosched.h |   3 +
> block/bfq-wf2q.c    |   2 +
> 3 files changed, 119 insertions(+), 37 deletions(-)
>=20
> --=20
> 2.22.1
>=20

