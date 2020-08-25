Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D31B2514A9
	for <lists+cgroups@lfdr.de>; Tue, 25 Aug 2020 10:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHYIyj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Aug 2020 04:54:39 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:45345 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbgHYIyj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Aug 2020 04:54:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U6oygkt_1598345661;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6oygkt_1598345661)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Aug 2020 16:54:24 +0800
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, willy@infradead.org, hannes@cmpxchg.org,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <20200825015627.3c3pnwauqznnp3gc@ca-dmjordan1.us.oracle.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <4cc9f54a-9eda-9966-df9a-a00bc9e88f4c@linux.alibaba.com>
Date:   Tue, 25 Aug 2020 16:52:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200825015627.3c3pnwauqznnp3gc@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/8/25 ÉÏÎç9:56, Daniel Jordan Ð´µÀ:
> On Mon, Aug 24, 2020 at 01:24:20PM -0700, Hugh Dickins wrote:
>> On Mon, 24 Aug 2020, Andrew Morton wrote:
>>> On Mon, 24 Aug 2020 20:54:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
>> Andrew demurred on version 17 for lack of review.  Alexander Duyck has
>> been doing a lot on that front since then.  I have intended to do so,
>> but it's a mirage that moves away from me as I move towards it: I have
> 
> Same, I haven't been able to keep up with the versions or the recent review
> feedback.  I got through about half of v17 last week and hope to have more time
> for the rest this week and beyond.
> 
>>>> Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
>>>> containers on a 2s * 26cores * HT box with a modefied case:
> 
> Alex, do you have a pointer to the modified readtwice case?
> 

Hi Daniel,

my readtwice modification like below.

diff --git a/case-lru-file-readtwice b/case-lru-file-readtwice
index 85533b248634..57cb97d121ae 100755
--- a/case-lru-file-readtwice
+++ b/case-lru-file-readtwice
@@ -15,23 +15,30 @@

 . ./hw_vars

-for i in `seq 1 $nr_task`
-do
-       create_sparse_file $SPARSE_FILE-$i $((ROTATE_BYTES / nr_task))
-       timeout --foreground -s INT ${runtime:-600} dd bs=4k if=$SPARSE_FILE-$i of=/dev/null > $TMPFS_MNT/dd-output-1-$i 2>&1 &
-       timeout --foreground -s INT ${runtime:-600} dd bs=4k if=$SPARSE_FILE-$i of=/dev/null > $TMPFS_MNT/dd-output-2-$i 2>&1 &
-done
+OUT_DIR=$(hostname)-${nr_task}c-$(((mem + (1<<29))>>30))g
+TEST_CASES=${@:-$(echo case-*)}
+
+echo $((1<<30)) > /proc/sys/vm/max_map_count
+echo $((1<<20)) > /proc/sys/kernel/threads-max
+echo 1 > /proc/sys/vm/overcommit_memory
+#echo 3 > /proc/sys/vm/drop_caches
+
+
+i=1
+
+if [ "$1" == "m" ];then
+       mount_tmpfs
+       create_sparse_root
+       create_sparse_file $SPARSE_FILE-$i $((ROTATE_BYTES))
+       exit
+fi
+
+
+if [ "$1" == "r" ];then
+       (timeout --foreground -s INT ${runtime:-300} dd bs=4k if=$SPARSE_FILE-$i of=/dev/null > $TMPFS_MNT/dd-output-1-$i 2>&1)&
+       (timeout --foreground -s INT ${runtime:-300} dd bs=4k if=$SPARSE_FILE-$i of=/dev/null > $TMPFS_MNT/dd-output-2-$i 2>&1)&
+fi

 wait
 sleep 1

-for file in $TMPFS_MNT/dd-output-*
-do
-       [ -s "$file" ] || {
-               echo "dd output file empty: $file" >&2
-       }
-       cat $file
-       rm  $file
-done
-
-rm `seq -f $SPARSE_FILE-%g 1 $nr_task`
diff --git a/hw_vars b/hw_vars
index 8731cefb9f57..ceeaa9f17c0b 100755
--- a/hw_vars
+++ b/hw_vars
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/sh -ex

 if [ -n "$runtime" ]; then
        USEMEM="$CMD ./usemem --runtime $runtime"
@@ -43,7 +43,7 @@ create_loop_devices()
        modprobe loop 2>/dev/null
        [ -e "/dev/loop0" ] || modprobe loop 2>/dev/null

-       for i in $(seq 0 8)
+       for i in $(seq 0 104)
        do
                [ -e "/dev/loop$i" ] && continue
                mknod /dev/loop$i b 7 $i
