Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993CCF17A1
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2019 14:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKFNu2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 08:50:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37863 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfKFNu2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 08:50:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so19941490wrv.4;
        Wed, 06 Nov 2019 05:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvnGoYA1nxIWzHKPGnMvGjsm7DK1fN/JIf8O6DGY4wM=;
        b=YJV4hvkIvb5RQt9Is8GHAnnixH55XjTT2QvGs9LRbjLx5cElS44rQaMU/Vpe1mX4fE
         ZZ6B+W/BH2zz0pHIHEf+byAQ/ZXhUoykJFSHW2aspHetFzZo3thJ2lgr6WkxfW4p4OZL
         1cJsavhby1Tq8xwnZRDbbMbe/ikQ5eD9vhGW8SheokLGAHv2ZTBRi/N2+gUUlMJn369m
         kC5oCz2JNC4L/mOPxC6/xIiB4dFp/knF0mFNeBWwa/9sICspPD5Vng8N4McgG0RiRSHF
         tL++FQDIwkZjiO5iLJ8ofUKmjNmgkYZxFWq/py5L/fXa0AoDKxpp9zT3UXjrG0Qq41wP
         DJCQ==
X-Gm-Message-State: APjAAAXBZOkS694u1PLRXTaAfb2SovG7dKFoJEQW5yKHI06Bb4lWLfm+
        CY+lmtH8SFacFenPPHqpxfFTS0+RwyJYv1g7wP0=
X-Google-Smtp-Source: APXvYqz0jRDuP53ISYwccGpwG0/d58L5srOHroxn4RNKS7/o9vJChpPgrK5CHtUZsye3bEH8dvXksnP8WrN+IVLdpTc=
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr2690726wrs.86.1573048226318;
 Wed, 06 Nov 2019 05:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20191104235944.3470866-1-tj@kernel.org>
In-Reply-To: <20191104235944.3470866-1-tj@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Nov 2019 22:50:15 +0900
Message-ID: <CAM9d7cjXX8aYYjJdnb0SUjBYwhOTWiD+V9fagUVnW9FUS6C=5g@mail.gmail.com>
Subject: Re: [PATCHSET cgroup/for-5.5] kernfs,cgroup: support 64bit inos and
 unify cgroup IDs
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@fb.com, linux-kernel <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On Tue, Nov 5, 2019 at 8:59 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> Currently, there are three IDs which are being used to identify a
> cgroup.
>
> 1. cgroup->id
> 2. cgroupfs 32bit ino
> 3. cgroupfs 32bit ino + 32bit gen
>
> All three IDs are visible to userland through different interfaces.
> This is very confusing and #1 can't even be resolved to cgroups from
> userland.
>
> A 64bit number is sufficient to identify a cgroup instance uniquely
> and ino_t is 64bit on all archs except for alpha.  There's no reason
> for three different IDs at all.  This patchset updates kernfs so that
> it supports 64bit ino and associated exportfs operations and unifies
> the cgroup IDs.
>
> * On 64bit ino archs, ino is kernfs node ID which is also the cgroup
>   ID.  The ino can be passed directly into open_by_handle_at(2) w/ the
>   new key type FILEID_KERNFS.  Backward compatibility is maintained
>   for FILEID_INO32_GEN keys.
>
> * On 32bit ino archs, kernfs node ID is still 64bit and the cgroup ID.
>   ino is the low 32bits and gen is the high 32bits.  If the high
>   32bits is zero, open_by_handle_at(2) only matches the ino part of
>   the ID allowing userland to resolve inos to cgroups as long as
>   distinguishing recycled inos isn't necessary.
>
> This patchset contains the following 10 patches.
>
>  0001-kernfs-fix-ino-wrap-around-detection.patch
>  0002-writeback-use-ino_t-for-inodes-in-tracepoints.patch
>  0003-netprio-use-css-ID-instead-of-cgroup-ID.patch
>  0004-kernfs-use-dumber-locking-for-kernfs_find_and_get_no.patch
>  0005-kernfs-kernfs_find_and_get_node_by_ino-should-only-l.patch
>  0006-kernfs-convert-kernfs_node-id-from-union-kernfs_node.patch
>  0007-kernfs-combine-ino-id-lookup-functions-into-kernfs_f.patch
>  0008-kernfs-implement-custom-exportfs-ops-and-fid-type.patch
>  0009-kernfs-use-64bit-inos-if-ino_t-is-64bit.patch
>  0010-cgroup-use-cgrp-kn-id-as-the-cgroup-ID.patch
>
> 0001 is a fix which should be backported through -stable.  0002 and
> 0003 are prep patches.  0004-0009 make kernfs_node->id a u64 and use
> it as ino on 64bit ino archs.  0010 replaces cgroup->id with the
> kernfs node ID.
>
> Greg, how do you want to route the patches?  We can route 0001-0009
> through your tree and the last one through cgroup after pulling in.
> I'd be happy to route them all too.
>
> This patchset is also available in the following git branch.
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-unified-cgid
>
> diffstat follows.  Thanks.

Thanks a lot for doing this!  I've tested it with my perf cgroup patchset
based on top of this series and it looks good.  You can add my

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung
