Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67787F3895
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 20:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKGT2w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 14:28:52 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37096 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfKGT2v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 14:28:51 -0500
Received: by mail-io1-f67.google.com with SMTP id 1so3602202iou.4
        for <cgroups@vger.kernel.org>; Thu, 07 Nov 2019 11:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LsQBOGT7wlBeTtd5DGVJ1cAFGBGmgxUQGz4CBk4TLCk=;
        b=pVKXsw6iTlJ2Rzs/YUhd1cSagr7G85BPX4jvG88avd78mLhxpwKSuSup+KefjXgIzd
         D99eKJyFKqrIcZz8kgmmwl8B7bGRqu8tHo6szfdV1XbTdJ6NW7Daw49AkY/gMmuKncRn
         t5QMRH81Y3OOOXlCBRJRI8iZUCYzpSb4T3mleVCNGWEdUdF1GzrTwDjUe9aEUSneQL4B
         uGtLuJbyPxquXYAPyeyX8vY0Bgl/FCPAwmmQGAHRZObaR2TK/+SlD7+smuzdVvztSDN1
         xpINYOf1vFWkuiS8IiRdmGwfG3W5cTmNRSeHvQH6W7ubVPkL/J0BJfpWgkDHYxjfInUl
         uxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LsQBOGT7wlBeTtd5DGVJ1cAFGBGmgxUQGz4CBk4TLCk=;
        b=oaIV/6+MO7McMwpn0DERf+vqE4Dtgi4RbOmbIyVF7BwnCiG5W/dbL2mz7P21uAJ2Xq
         nF0aYsRq9AftfeNw30AqyyHiroO9kU7DtgVYbmoYf8c+3Fpsu/iYvDiT7culZqmHQJ1Y
         CHYW6h8S/XWy1cpzcopXv6bJo3DSZYQsFZ4LecigvpRHge9sml3uuJUGkBzW/Khs01nG
         PvPYKztfODCkQJBDDMhcp3Q52Vc7Hb/Hie6gp47tnETxhTyE1hgWcf0n6e5h4DTeYdmh
         fWoJEKqr4f5TAdVAMybWDaDbbKZ7avNaCeL9zA8pdhVivc63J42AurMTLX9PXSJGkCJ0
         pmUw==
X-Gm-Message-State: APjAAAVQcg4ot4YpaWtkC3u58ZCXJMG+HJUQzSSupJbvW3iG26f7vIri
        k0MXe0onTsRQw+bVZpl5CgQk0g==
X-Google-Smtp-Source: APXvYqytRM2OaAe3ZSxiJMqKi+CwRvtOJTQx6oa467TEQdWnroU8YHYetutKqI3f0YDuqGs+xrjF2A==
X-Received: by 2002:a02:c9d2:: with SMTP id c18mr5844902jap.108.1573154929192;
        Thu, 07 Nov 2019 11:28:49 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r25sm437420ilb.16.2019.11.07.11.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:28:48 -0800 (PST)
Subject: Re: [PATCHSET v2 block/for-next] blk-cgroup: use cgroup rstat for IO
 stats
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com
References: <20191107191804.3735303-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a6dd76b-6063-92b9-7b20-97f69bb4b344@kernel.dk>
Date:   Thu, 7 Nov 2019 12:28:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107191804.3735303-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/7/19 12:17 PM, Tejun Heo wrote:
> Hello,
> 
> v2: Build fix when !DEBUG.
> 
> blk-cgroup IO stats currently use blkg_rwstat which unforutnately
> requires walking all descendants recursively on read.  On systems with
> a large number of cgroups (dead or alive), this can make each stat
> read a substantially expensive operation.
> 
> This patch updates blk-cgroup to use cgroup rstat which makes stat
> reading O(# descendants which have been active since last reading)
> instead of O(# descendants).
> 
>   0001-bfq-iosched-relocate-bfqg_-rwstat-helpers.patch
>   0002-bfq-iosched-stop-using-blkg-stat_bytes-and-stat_ios.patch
>   0003-blk-throtl-stop-using-blkg-stat_bytes-and-stat_ios.patch
>   0004-blk-cgroup-remove-now-unused-blkg_print_stat_-bytes-.patch
>   0005-blk-cgroup-reimplement-basic-IO-stats-using-cgroup-r.patch
>   0006-blk-cgroup-separate-out-blkg_rwstat-under-CONFIG_BLK.patch
> 
> 0001-0003 make bfq-iosched and blk-throtl use their own blkg_rwstat to
> track basic IO stats on cgroup1 instead of sharing blk-cgroup core's.
> 0004 is a follow-up cleanup.
> 
> 0005 switches blk-cgroup to cgroup rstat.
> 
> 0006 moves blkg_rwstat to its own files and gate it under a config
> option as it's now only used by blk-throtl and bfq-iosched.
> 
> The patchset is on top of
> 
>    block/for-next  40afbe18b03a ("Merge branch 'for-5.5/drivers-post' into for-next")
> + block/for-linus b0814361a25c ("blkcg: make blkcg_print_stat() print stats only for online blkgs")
> 
> and also available in the following git branch.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-blkcg-rstat

Thanks, applied!

-- 
Jens Axboe

