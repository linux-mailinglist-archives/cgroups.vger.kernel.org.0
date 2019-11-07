Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C79DF386B
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 20:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfKGTSJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 14:18:09 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:37649 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfKGTSJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 14:18:09 -0500
Received: by mail-qt1-f173.google.com with SMTP id g50so3606797qtb.4;
        Thu, 07 Nov 2019 11:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=frzwKB0VNTg+ZAOVk2Hg0rgtTZGxKwYo7SANV2FiQrw=;
        b=DOtNb0bgjksnLw/UHH2dC6pOHZ3neE0l5WG9BV60l4/UEztqwQIh3Pg8wei/4bfnwG
         1/koANBb+xnwdqepckcyRxW7EZbM1yYcB8bDFXHcxqFGBFYWR4iU+WMfrZsOjMZ+fwUV
         OUQIKOMoSdOOKaQYk8ot8vA+0aUqFHFToNT8yYqqBZSlq8IM3+umU2obkvdeVAng5xlX
         d6VDCaVrc0TglUoj9RlpIRwN3JxRIGuABtOGAsznBkXRJGz8J99LsmyaCK7octLWtch0
         ek+3emCiEQ6KPfRl3yVPqP8Js3Dhuz2LsjHUZf0tb8wnTgzoAyAYxH8Hh9oZnmqEd8Je
         H2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=frzwKB0VNTg+ZAOVk2Hg0rgtTZGxKwYo7SANV2FiQrw=;
        b=DXuleNwnC8l6b9t1B7HXuCDcOwsFDvi1O1P1EQTL9Fl0a5aP3P8OJlh72w3dPerOwx
         KN2ibrtyBHSbdF9pSOVR/iLJXqg44+O6HmEP9HPBTT1RolbgHkHAmwuwB7ipax66LcMV
         C0CgLM84ZeYiD/3SDxKu3IK9b2puCuGW4eS+4cYayRo59gedZ2EMWvWdC2KLAwHyT3KE
         oU+6yHlmQfVb9hHSLP2mkDDBK5V5LBcz74GztzUyi8uWFLVakMXEt7FrqHMorLM6L61m
         zldqOV0OG+LdrmgUx4LXqg07nq6HSBLSxM5ZmBXOFLoYRTTHmC7VOHufDBJsSqFWN3mK
         /4AQ==
X-Gm-Message-State: APjAAAVSbMUVwjeQtm/5UE5KdpZ+kVUWU4DtNhKVmS4jtktxgUvt2apc
        YTJd9/oz5ZUgIlkMAe9hR7U=
X-Google-Smtp-Source: APXvYqzzHEdBlE4FlXU6EeSAp3KhSeG11aEuyOKLr+FosU7CaqQwF1C347fh6A/BzZUeR6wxjhUlSQ==
X-Received: by 2002:ac8:23d3:: with SMTP id r19mr5815748qtr.297.1573154287844;
        Thu, 07 Nov 2019 11:18:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3f13])
        by smtp.gmail.com with ESMTPSA id c20sm2037580qtc.13.2019.11.07.11.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:18:07 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com
Subject: [PATCHSET v2 block/for-next] blk-cgroup: use cgroup rstat for IO stats
Date:   Thu,  7 Nov 2019 11:17:58 -0800
Message-Id: <20191107191804.3735303-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

v2: Build fix when !DEBUG.

blk-cgroup IO stats currently use blkg_rwstat which unforutnately
requires walking all descendants recursively on read.  On systems with
a large number of cgroups (dead or alive), this can make each stat
read a substantially expensive operation.

This patch updates blk-cgroup to use cgroup rstat which makes stat
reading O(# descendants which have been active since last reading)
instead of O(# descendants).

 0001-bfq-iosched-relocate-bfqg_-rwstat-helpers.patch
 0002-bfq-iosched-stop-using-blkg-stat_bytes-and-stat_ios.patch
 0003-blk-throtl-stop-using-blkg-stat_bytes-and-stat_ios.patch
 0004-blk-cgroup-remove-now-unused-blkg_print_stat_-bytes-.patch
 0005-blk-cgroup-reimplement-basic-IO-stats-using-cgroup-r.patch
 0006-blk-cgroup-separate-out-blkg_rwstat-under-CONFIG_BLK.patch

0001-0003 make bfq-iosched and blk-throtl use their own blkg_rwstat to
track basic IO stats on cgroup1 instead of sharing blk-cgroup core's.
0004 is a follow-up cleanup.

0005 switches blk-cgroup to cgroup rstat.

0006 moves blkg_rwstat to its own files and gate it under a config
option as it's now only used by blk-throtl and bfq-iosched.

The patchset is on top of

  block/for-next  40afbe18b03a ("Merge branch 'for-5.5/drivers-post' into for-next")
+ block/for-linus b0814361a25c ("blkcg: make blkcg_print_stat() print stats only for online blkgs")

and also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-blkcg-rstat

Thanks.

 block/Kconfig              |    4 
 block/Kconfig.iosched      |    1 
 block/Makefile             |    1 
 block/bfq-cgroup.c         |   37 +++--
 block/bfq-iosched.c        |    4 
 block/bfq-iosched.h        |    6 
 block/blk-cgroup-rwstat.c  |  129 +++++++++++++++++++
 block/blk-cgroup-rwstat.h  |  149 ++++++++++++++++++++++
 block/blk-cgroup.c         |  304 ++++++++++++++-------------------------------
 block/blk-throttle.c       |   71 +++++++++-
 include/linux/blk-cgroup.h |  198 +++++------------------------
 11 files changed, 517 insertions(+), 387 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20191105160951.GS3622521@devbig004.ftw2.facebook.com

