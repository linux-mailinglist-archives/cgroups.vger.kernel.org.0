Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46387FD10E
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2019 23:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKNWmS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Nov 2019 17:42:18 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:35595 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWmS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Nov 2019 17:42:18 -0500
Received: by mail-qk1-f181.google.com with SMTP id i19so6544388qki.2;
        Thu, 14 Nov 2019 14:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ojnBoVhRYBbbCku6o5OhWdqFFJEnFiZ4I+6b/GkoBQg=;
        b=trF141knO9ioTtIa22bXyKIHKH4GLkubkdpaZr1p66/+mAnS94hwyTuqJPEpeDTdcK
         MRnCl8OXpIg1M8eDQmjQPZWi676P7i1N5qlBXHT96lVpD41/u6XK+f01o/wVTMYdghmM
         afyaTE0ClSOVWSwOfLOp/XKVxNs0m3hlegXjlIYwiKOrmRmudrMRcY5mjWvP32mSZxQF
         kRlRt+udROlAYRStA84rdML/0FveL4AzC/OvVehfYFSmUP6YUaD5H6gEDRxO0XZt4y1X
         tyRYUQjDBh4UErUv6KNQpQOu/xkl8aL+n5hsLT7cGwcWWUhxAZRdKspN5q12+EHTH04y
         2W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ojnBoVhRYBbbCku6o5OhWdqFFJEnFiZ4I+6b/GkoBQg=;
        b=nq6SHPAQ/klByGa7vVUsPb7i6QRinl510t52Lo1NUlFgu1t07CA5Sx7koqEaeI+f9Q
         UoUqGbMmc3/CGUSZQRiD55W/8XqJEJ4/eJK1akaWVnPMyVe7E2BlwNyzkQL8wYWZWVjk
         +QB1WZ6KLH53zT1S+1lXSpwh8CmnnqvN2b5c4WVUkC6N3gcFZ6x35/ZFoYEDPEzYXHpz
         g/DN8qzOPf4J0+/qm+Cbzf/u74HZVVS2o+7XjlJEEgjbDR7MJ82Z9NdKW3YA8BkcFkWk
         L+/Z72Tedxn8h9LyLh6g/+5mGmJHYMS4HDOkuyWWQnL5BiW5ROXm3pqGVuXgSkIFHYOl
         ScRQ==
X-Gm-Message-State: APjAAAW6+QffSFtAXhIWzdsEq2zoN2FRQ+0ieiH7yWzSnj5CQHY9rd3z
        Fz8NCzGUu7PnMAlx2r/IWXk=
X-Google-Smtp-Source: APXvYqxhcsNRS8z1z19HuTak8nmGeut7qM5J5CXY7voNTNUlMc4zMnbbjvWNDPBjAd8TzvU4Rgq//Q==
X-Received: by 2002:ae9:e814:: with SMTP id a20mr9392966qkg.117.1573771336538;
        Thu, 14 Nov 2019 14:42:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:69f2])
        by smtp.gmail.com with ESMTPSA id l93sm3874982qtd.86.2019.11.14.14.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 14:42:15 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:42:13 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     cgroups@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org, open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, lizefan@huawei.com,
        hannes@cmpxchg.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>
Subject: Re: linux-next: arm32: beagleboard x15: WARNING: CPU: 0 PID: 0 at
 /usr/src/kernel/kernel/cgroup/cgroup.c:1969 cgroup_setup_root+0x36c/0x4e8
Message-ID: <20191114224213.GN4163745@devbig004.ftw2.facebook.com>
References: <CA+G9fYviReoG+gq=Jm8yQOMd01j2opae5p+VTGGMK7aLn0xWgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYviReoG+gq=Jm8yQOMd01j2opae5p+VTGGMK7aLn0xWgw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Naresh.

On Thu, Nov 14, 2019 at 11:02:53AM +0530, Naresh Kamboju wrote:
> [    0.015402] WARNING: CPU: 0 PID: 0 at /usr/src/kernel/kernel/cgroup/cgroup.c:1969
> cgroup_setup_root+0x36c/0x4e8
...
> [    0.015726] [<c053ac48>] (cgroup_setup_root) from [<c1c2a260>]
> (cgroup_init+0x108/0x560)

So, that's saying that the initial kernfs_node ino allocation returned
something other than 1.  Hmmm... x86_32 works fine.  What does the
following say?

# mkdir -p /tmp/cgroup2
# mount -t cgroup2 none /tmp/cgroup2
# ls -lid /tmp/cgroup2

Thanks.

-- 
tejun
