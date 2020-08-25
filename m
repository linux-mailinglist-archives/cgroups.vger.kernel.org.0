Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA6E250FFC
	for <lists+cgroups@lfdr.de>; Tue, 25 Aug 2020 05:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHYD2e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 23:28:34 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53142 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbgHYD2d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 23:28:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U6nFDwk_1598326106;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6nFDwk_1598326106)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Aug 2020 11:28:27 +0800
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
Message-ID: <ec62a835-f79d-2b8c-99c7-120834703b42@linux.alibaba.com>
Date:   Tue, 25 Aug 2020 11:26:58 +0800
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

Sorry, no. my developer machine crashed, so I lost case my container and modified
case. I am struggling to get my container back from a account problematic repository. 

But some testing scripts is here, generally, the original readtwice case will
run each of threads on each of cpus. The new case will run one container on each cpus,
and just run one readtwice thead in each of containers.

Here is readtwice case changes(Just a reference)
diff --git a/case-lru-file-readtwice b/case-lru-file-readtwice
index 85533b248634..48c6b5f44256 100755
--- a/case-lru-file-readtwice
+++ b/case-lru-file-readtwice
@@ -15,12 +15,9 @@

 . ./hw_vars

-for i in `seq 1 $nr_task`
-do
        create_sparse_file $SPARSE_FILE-$i $((ROTATE_BYTES / nr_task))
        timeout --foreground -s INT ${runtime:-600} dd bs=4k if=$SPARSE_FILE-$i of=/dev/null > $TMPFS_MNT/dd-output-1-$i 2>&1 &
        timeout --foreground -s INT ${runtime:-600} dd bs=4k if=$SPARSE_FILE-$i of=/dev/null > $TMPFS_MNT/dd-output-2-$i 2>&1 &
-done

 wait
 sleep 1
@@ -31,7 +28,7 @@ do
                echo "dd output file empty: $file" >&2
        }
        cat $file
-       rm  $file
+       #rm  $file
 done

 rm `seq -f $SPARSE_FILE-%g 1 $nr_task`

And here is how to running the case: 
--------
#run all case on 24 cpu machine, lrulockv2 is the container with modified case.
for ((i=0; i<24; i++))
do
        #btw, vm-scalability need create 23 loop devices
        docker run --privileged=true --rm lrulockv2 bash -c " sleep 20000" &
done
sleep 15  #wait all container ready. 

#kick testing
for i in `docker ps | sed '1 d' | awk '{print $1 }'` ;do docker exec --privileged=true -it $i bash -c "cd vm-scalability/; bash -x ./run case-lru-file-readtwice "& done

#show testing result for all
for i in `docker ps | sed '1 d' | awk '{print $1 }'` ;do echo === $i ===; docker exec $i bash -c 'cat /tmp/vm-scalability-tmp/dd-output-* '  & done
for i in `docker ps | sed '1 d' | awk '{print $1 }'` ;do echo === $i ===; docker exec $i bash -c 'cat /tmp/vm-scalability-tmp/dd-output-* '  & done | grep MB | awk 'BEGIN {a=0
;} { a+=$8} END {print NR, a/(NR)}'


> 
> Even better would be a description of the problem you're having in production
> with lru_lock.  We might be able to create at least a simulation of it to show
> what the expected improvement of your real workload is.

we are using thousands memcgs in a machine, but as a simulation, I guess above case
could be helpful to show the problem.

Thanks a lot!
Alex

> 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
>>>> With this patchset, the readtwice performance increased about 80%
>>>> in concurrent containers.
>>>
>>> That's rather a slight amount of performance testing for a huge
>>> performance patchset!
>>
>> Indeed.  And I see that clause about readtwice performance increased 80%
>> going back eight months to v6: a lot of fundamental bugs have been fixed
>> in it since then, so I do think it needs refreshing.  It could be faster
>> now: v16 or v17 fixed the last bug I knew of, which had been slowing
>> down reclaim considerably.
>>
>> When I last timed my repetitive swapping loads (not loads anyone sensible
>> would be running with), across only two memcgs, Alex's patchset was
>> slightly faster than without: it really did make a difference.  But
>> I tend to think that for all patchsets, there exists at least one
>> test that shows it faster, and another that shows it slower.

In my testing, case-lru-file-mmap-read has a bit slower, 10+% on 96 thread machine,
when memcg is enabled but unused, that may due to longer pointer jumpping on 
lruvec than pgdat->lru_lock, since cgroup_disable=memory could fully remove the
regression with the new lock path.

I tried reusing page->prviate to store lruvec pointer, that could remove some 
regression on this, since private is generally unused on a lru page. But the patch
is too buggy now. 

BTW, 
Guess memcg would cause more memory disturb on a large machine, if it's enabled but
unused, isn't it?


>>
>>> Is more detailed testing planned?
>>
>> Not by me, performance testing is not something I trust myself with,
>> just get lost in the numbers: Alex, this is what we hoped for months
>> ago, please make a more convincing case, I hope Daniel and others
>> can make more suggestions.  But my own evidence suggests it's good.
> 
> I ran a few benchmarks on v17 last week (sysbench oltp readonly, kerndevel from
> mmtests, a memcg-ized version of the readtwice case I cooked up) and then today
> discovered there's a chance I wasn't running the right kernels, so I'm redoing
> them on v18.  Plan to look into what other, more "macro" tests would be
> sensitive to these changes.
> 
