Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241EB7BCD12
	for <lists+cgroups@lfdr.de>; Sun,  8 Oct 2023 09:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbjJHHwT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Oct 2023 03:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJHHwT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Oct 2023 03:52:19 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED39B9;
        Sun,  8 Oct 2023 00:52:17 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b07719089aso2334950241.0;
        Sun, 08 Oct 2023 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696751536; x=1697356336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bE4QtD+mlB3SdXP/klE175cWdpugSzcGOUx211/ZRD8=;
        b=TXYC1Oxc+CIrObaBDtru5maJAF+a+JZlCMyXgvqIqDknMJ0zWwVV48pjLMyZSqWN0U
         Hc+LaLWnWdq9Qy3fJ3F8jquYS6LREq2nAjdoZWDptlfrmdltzOu2AzPM7OgkTrlo3Shm
         F0KJX8YjG1iknySVY+bQHWmyfvGNxLMBM1kXeDp6Qaiv/VM3L7uW688wzqg/QaE6vjqd
         I4vcMe8RweE4BA4CS7NE1d1+zXzpqHmw2GE+t4fGC94LiDPj9dtnumTrENVP9lNrbg1Q
         UdTYq3NhiYdwGqLSQ25N1zcK2X2MR8k0MXb+saF2k+/iW+K6hNn60b5OEBvEhr6rJchI
         gmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696751536; x=1697356336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bE4QtD+mlB3SdXP/klE175cWdpugSzcGOUx211/ZRD8=;
        b=TdSRXEH9rqeS7PKgcnMpAEZwtLGBBRVeRtbZ7d+P2k1vKv+WNpfFTpzG+o7c+5Fgzy
         dr42GdZSEvjJG64kzUu42sV9LfbyDu4HKH1BLP3W5gyWmYSWPsRxqvLrTAHJiL5++ZBw
         Wtj1o+gGTvUu4NRdDJKpUMb/tsMk6k+3F86zy6fx/aa/QXnsn/xcw6Lw/ngd1bIc2SbG
         pADYosIjo1Dq0NzqkyJ3Rp43HJ1/vJwJqVGD/FlfJ2QZmBh9rqezmyTwQeTN3nq1DsRG
         qnziEVRuahvn97c0W5d9B/6Ux0lSrighZ0K0Fmw2JWjzJDV1GLv/nH2w/Xqy9SIdo5w3
         U1TQ==
X-Gm-Message-State: AOJu0YxXRHx0fUL0MPoVzK9mZnzzl+wP1gPuLbenMf/hO71938VRCd1+
        xdEm7xYfLsQa1KIGDai2zS42cY2Svb9cv54FXvs=
X-Google-Smtp-Source: AGHT+IHmRQJ1u4u/Mq5v591Go9q6xMqfPgvZi8xktvphqGbHQWFKv3gAKHkjIrRXAqTv8RPDt8hisXowVHKriVdLpkM=
X-Received: by 2002:a67:f4d9:0:b0:452:7784:7648 with SMTP id
 s25-20020a67f4d9000000b0045277847648mr5523034vsn.14.1696751536357; Sun, 08
 Oct 2023 00:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231007130905.78554-1-jianlv@ebay.com> <87mswtkj8x.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87mswtkj8x.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Jianlin Lv <iecedge@gmail.com>
Date:   Sun, 8 Oct 2023 15:52:04 +0800
Message-ID: <CAFA-uR9ymPTktMbi96cb+smjQHB4Y=8SQfAqmsqTbniGbkGTLA@mail.gmail.com>
Subject: Re: [PATCH] memcg: add interface to force disable swap
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, yosryahmed@google.com,
        willy@infradead.org, linmiaohe@huawei.com,
        wangkefeng.wang@huawei.com, laoar.shao@gmail.com,
        yuzhao@google.com, wuyun.abel@bytedance.com, david@redhat.com,
        peterx@redhat.com, vishal.moola@gmail.com, hughd@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jianlv@ebay.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Oct 8, 2023 at 9:17=E2=80=AFAM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Jianlin Lv <iecedge@gmail.com> writes:
>
> > From: Jianlin Lv <iecedge@gmail.com>
> >
> > Global reclaim will swap even if swappiness is set to 0.
>
> Why?  Can you elaborate the situation?

We reproduced the issue of pages being swapped out even when swappiness is
set to 0 in the production environment through the following test program.
Not sure whether this program can reproduce the issue in any environment.

From the implementation of the get_scan_count code, it can be seen that,
based on the current runtime situation, memory reclamation will choose a
scanning method (SCAN_ANON/SCAN_FILE/SCAN_FRACT) to determine how
aggressively the anon and file LRU are scanned. However, this introduces
uncertainty.

For the JVM issue at hand, we expect deterministic SCAN_FILE scan to avoid
swapping out anon pages.


code::
#!/usr/bin/env python

import mmap
import os
import sys

def write_files():
    count =3D 1
    if not os.path.isdir(WRITE_DIR):
        os.mkdir(WRITE_DIR)

    while True:
        _, i =3D divmod(count, 6000)
        file =3D "{}/{}_{}.txt".format(WRITE_DIR, WRITE_FILE, i)

        with open(file, 'w') as f:
            # Write 100 MB to a file
            num_chars =3D  100 * 1024 * 1024
            f.write('0' * num_chars)
        count =3D count + 1

def create_read_file():
    with open(READ_FILE, 'wb') as f:
        num_chars =3D 10000 * 1024 * 1024
        f.write(b'0' * num_chars)

def read_file():
    with open(READ_FILE, mode=3D"r", encoding=3D"utf8") as f:
        mm =3D mmap.mmap(f.fileno(), length=3D0, access=3Dmmap.ACCESS_READ)
        text =3D mm.read()
        write_files()

WRITE_FILE =3D "file"
WRITE_DIR =3D "/tmp/rm_rf_me"
READ_FILE=3D"/tmp/10g_file_delete"
if not os.path.isfile(READ_FILE):
    create_read_file()
read_file()


Jianlin

>
> > In particular
> > case, users wish to be able to completely disable swap for specific
> > processes. One scenario is that if JVM memory pages falls into swap,
> > the performance will noticeably reduce and the GC pauses tend to increa=
se
> > to levels not tolerable by most applications.
> > If it's possible to only disable swap out for specific processes, it ca=
n
> > address the JVM GC pauses issues, and at the same time, memory reclaim
> > pressure is also manageable.
> >
> > This patch adds "memory.swap_force_disable" control file to support dis=
able
> > swap for non-root cgroup. When process is associated with a cgroup,
> > 'echo 1 > memory.swap_force_disable' will forbid anon pages be swapped =
out.
> > This patch also adds read and write handler of the control file.
>
> --
> Best Regards,
> Huang, Ying
