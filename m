Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A781FC9
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2019 17:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfHEPIl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Aug 2019 11:08:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52716 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbfHEPIl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Aug 2019 11:08:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so75086703wms.2
        for <cgroups@vger.kernel.org>; Mon, 05 Aug 2019 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CfGlMJlJq1yx6eSWof1+4yQXKTkrtm+XZNLVyiuuYPc=;
        b=jbxxzFHHvusryD5w8vzHeuPeqU/d3yLi9SHaw+kphMYUNZbQHKRDzd0wOyUR/cmUgM
         iMB55vlb/E8GPsyr5ucRPmimQH23RpGgdFiQBLzrxFXoq1sqDkFlGV+7etEF2y6fKRcg
         mc5VTGedBcNbRLHK58Op9xwxSGRqTW4NNy2ZXqz4/zNBv9SNY0VBWz5gJVC1blrGH3jF
         vNnmQ7gxzsoLn1ExYyoQuw5LWo9CH554+vbq0kfDJVdyCK4eq5LocjSQ4KunVUAkwDaG
         7q2NuNsw16RVT8AZxS87xuORXknHwk+nYviQ763BWAYD5i9CYfsX2MjrExgAgGrwLfWf
         gQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CfGlMJlJq1yx6eSWof1+4yQXKTkrtm+XZNLVyiuuYPc=;
        b=pVw7NXtu4XG9iHRlwHqpjxbrSK3vp+EGawLngIMvXmuEbzlxv2WESBTmLXuPeAxCK/
         /QqJAu6fXSwZNmKlRtmoDZ3NKvAlknlKblVdXg/iDn1kJyosxKnd6RLnl+SdtefFzgOc
         /eFT9Uc+iJ8wFyHV+kiAtOGoQnxILwYxlHcHz6wUZ1Tr9N9v2aADotrodtNouyCwF4Nh
         owssQOQlH5IUw4wj2mHfmR8NMNvSXdekoLaBZ8P/F+RsGpd59CU9QQByksuMwcM7ekyN
         Ym7KWepGTlV3cWa134IvzrxjvZA/uO5pVwh7bPZRqGWJ76cG3Zpsy+wuu522MH0WZ+9L
         jQKg==
X-Gm-Message-State: APjAAAWe4WdQS4QYxABlJHdh7sTIRu/ZA5tBks1v9w7rraRwD+et9t1h
        kaZEASls1oLWFAsK8Tm0Zk1QNQ==
X-Google-Smtp-Source: APXvYqxRh/11CyvYNBmPNpSUQlUGVd7DPB6MVKtbk4hpZxUXI6n37AJ0hZvqbtL18gsPQ4efe74OnA==
X-Received: by 2002:a1c:1a87:: with SMTP id a129mr18849472wma.21.1565017719279;
        Mon, 05 Aug 2019 08:08:39 -0700 (PDT)
Received: from [192.168.0.100] (88-147-69-71.dyn.eolo.it. [88.147.69.71])
        by smtp.gmail.com with ESMTPSA id c3sm87272983wrx.19.2019.08.05.08.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 08:08:38 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v2 0/3] Implement BFQ per-device weight interface
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190805063807.9494-1-zhengfeiran@bytedance.com>
Date:   Mon, 5 Aug 2019 17:08:36 +0200
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Fam Zheng <fam@euphon.net>,
        duanxiongchun@bytedance.com,
        linux-block <linux-block@vger.kernel.org>, tj@kernel.org,
        cgroups@vger.kernel.org, zhangjiachen.jc@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6E36505-16B1-4E6D-BCA8-53E5FD4AEE98@linaro.org>
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
To:     Fam Zheng <zhengfeiran@bytedance.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thank you very much, Fam, for this extension.

Reviewed-by: Paolo Valente <paolo.valente@linaro.org>

> Il giorno 5 ago 2019, alle ore 08:38, Fam Zheng =
<zhengfeiran@bytedance.com> ha scritto:
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
> block/bfq-cgroup.c  | 151 =
+++++++++++++++++++++++++++++++++++++++-------------
> block/bfq-iosched.h |   3 ++
> block/bfq-wf2q.c    |   2 +
> 3 files changed, 119 insertions(+), 37 deletions(-)
>=20
> --=20
> 2.11.0
>=20

