Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DA826AA2D
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIORA3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 13:00:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37802 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgIOQun (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 12:50:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FGj2uS166558;
        Tue, 15 Sep 2020 16:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=eBeJCMXkKKPUoXo+GGUtTOFktz8jnI+NP33/TyiPS/w=;
 b=ulKHxk5gGvdXpMlFiC8CI800x3RJYnP5dOe29xnrVqi9GGlzXh3vB0Wzd99u4w0IP1nc
 KvZLxOkebeOOtzmAK3YM/gRbkRFRz2UzxTfb6tR3rWqmLvEzO+Hn6oZpuCHQVjmNM5lj
 k6H7YWO7BEWxSqLaYmyujDnFrIo4D0cNP3ofHIe+T+BK7k3RNEjU3/8H0J/rMIy6V9IB
 LlGXT9aHStWTDLRu/NDaVMgjRfNAeZq201TRbYcaoDruFt98mXjfsg0AZm3p8Qa27PUC
 u0UTPiyClLkubsVNPHWzSdu+ZpkX66eyGpGWcIbxhhhb1AKPd66+WdIY9aErvRU6XfOA BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33j91dfwtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 16:49:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FGif42026815;
        Tue, 15 Sep 2020 16:49:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33h88yn5yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 16:49:13 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08FGn5fZ021990;
        Tue, 15 Sep 2020 16:49:06 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 16:49:04 +0000
Date:   Tue, 15 Sep 2020 12:58:07 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, vbabka@suse.cz, minchan@kernel.org, cai@lca.pw
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
Message-ID: <20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com>
References: <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils>
 <61a42a87-eec9-e300-f710-992756f70de6@linux.alibaba.com>
 <alpine.LSU.2.11.2009091524260.10087@eggly.anvils>
 <855ad6ee-dba4-9729-78bd-23e392905cf6@linux.alibaba.com>
 <alpine.LSU.2.11.2009111634020.22739@eggly.anvils>
 <5cfc6142-752d-26e6-0108-38d13009268b@linux.alibaba.com>
 <alpine.LSU.2.11.2009150112130.1550@eggly.anvils>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="erochwecjadffrwv"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2009150112130.1550@eggly.anvils>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150136
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--erochwecjadffrwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2020 at 01:21:56AM -0700, Hugh Dickins wrote:
> On Sun, 13 Sep 2020, Alex Shi wrote:
> > Uh, I updated the testing with some new results here:
> > https://lkml.org/lkml/2020/8/26/212
> 
> Right, I missed that, that's better, thanks.  Any other test results?

Alex, you were doing some will-it-scale runs earlier.  Are you planning to do
more of those?  Otherwise I can add them in.

This is what I have so far.


sysbench oltp read-only
-----------------------

The goal was to run a real world benchmark, at least more so than something
like vm-scalability, with the memory controller enabled but unused to check for
regressions.

I chose sysbench because it was relatively straightforward to run, but I'm open
to ideas for other high level benchmarks that might be more sensitive to this
series.

CoeffVar shows the test was pretty noisy overall.  It's nice to see there's no
significant difference between the kernels for low thread counts (1-12), but
I'm not sure what to make of the 18 and 20 thread cases.  At 20 threads, the
CPUs of the node that the test was confined to were saturated and the variance
is especially high.  I'm tempted to write the 18 and 20 thread cases off as
noise.

- 2-socket * 10-core * 2-hyperthread broadwell server
- test bound to node 1 to lower variance
- 251G memory, divided evenly between the nodes (memory size of test shrunk to
  accommodate confining to one node)
- 12 iterations per thread count per kernel
- THP enabled

export OLTP_CACHESIZE=$(($MEMTOTAL_BYTES/4))
export OLTP_SHAREDBUFFERS=$((MEMTOTAL_BYTES/8))
export OLTP_PAGESIZES="default"
export SYSBENCH_DRIVER=postgres
export SYSBENCH_MAX_TRANSACTIONS=auto
export SYSBENCH_READONLY=yes
export SYSBENCH_MAX_THREADS=$((NUMCPUS / 2))
export SYSBENCH_ITERATIONS=12
export SYSBENCH_WORKLOAD_SIZE=$((MEMTOTAL_BYTES*3/8))
export SYSBENCH_CACHE_COLD=no
export DATABASE_INIT_ONCE=yes

export MMTESTS_NUMA_POLICY=fullbind_single_instance_node
numactl --cpunodebind=1 --membind=1 <mmtests_cmdline>

sysbench Transactions per second
                            5.9-rc2        5.9-rc2-lru-v18
Min       1       593.23 (   0.00%)      583.37 (  -1.66%)
Min       4      1897.34 (   0.00%)     1871.77 (  -1.35%)
Min       7      2471.14 (   0.00%)     2449.77 (  -0.86%)
Min       12     2680.00 (   0.00%)     2853.25 (   6.46%)
Min       18     2183.82 (   0.00%)     1191.43 ( -45.44%)
Min       20      924.96 (   0.00%)      526.66 ( -43.06%)
Hmean     1       912.08 (   0.00%)      904.24 (  -0.86%)
Hmean     4      2057.11 (   0.00%)     2044.69 (  -0.60%)
Hmean     7      2817.59 (   0.00%)     2812.80 (  -0.17%)
Hmean     12     3201.05 (   0.00%)     3171.09 (  -0.94%)
Hmean     18     2529.10 (   0.00%)     2009.99 * -20.53%*
Hmean     20     1742.29 (   0.00%)     1127.77 * -35.27%*
Stddev    1       219.21 (   0.00%)      220.92 (  -0.78%)
Stddev    4        94.94 (   0.00%)       84.34 (  11.17%)
Stddev    7       189.42 (   0.00%)      167.58 (  11.53%)
Stddev    12      372.13 (   0.00%)      199.40 (  46.42%)
Stddev    18      248.42 (   0.00%)      574.66 (-131.32%)
Stddev    20      757.69 (   0.00%)      666.87 (  11.99%)
CoeffVar  1        22.54 (   0.00%)       22.86 (  -1.42%)
CoeffVar  4         4.61 (   0.00%)        4.12 (  10.60%)
CoeffVar  7         6.69 (   0.00%)        5.94 (  11.30%)
CoeffVar  12       11.49 (   0.00%)        6.27 (  45.46%)
CoeffVar  18        9.74 (   0.00%)       26.22 (-169.23%)
CoeffVar  20       36.32 (   0.00%)       47.18 ( -29.89%)
Max       1      1117.45 (   0.00%)     1107.33 (  -0.91%)
Max       4      2184.92 (   0.00%)     2136.65 (  -2.21%)
Max       7      3086.81 (   0.00%)     3049.52 (  -1.21%)
Max       12     4020.07 (   0.00%)     3580.95 ( -10.92%)
Max       18     3032.30 (   0.00%)     2810.85 (  -7.30%)
Max       20     2891.27 (   0.00%)     2675.80 (  -7.45%)
BHmean-50 1      1098.77 (   0.00%)     1093.58 (  -0.47%)
BHmean-50 4      2139.76 (   0.00%)     2107.13 (  -1.52%)
BHmean-50 7      2972.18 (   0.00%)     2953.94 (  -0.61%)
BHmean-50 12     3494.73 (   0.00%)     3311.33 (  -5.25%)
BHmean-50 18     2729.70 (   0.00%)     2606.32 (  -4.52%)
BHmean-50 20     2668.72 (   0.00%)     1779.87 ( -33.31%)
BHmean-95 1       958.94 (   0.00%)      951.84 (  -0.74%)
BHmean-95 4      2072.98 (   0.00%)     2062.01 (  -0.53%)
BHmean-95 7      2853.96 (   0.00%)     2851.21 (  -0.10%)
BHmean-95 12     3258.65 (   0.00%)     3203.53 (  -1.69%)
BHmean-95 18     2565.99 (   0.00%)     2143.90 ( -16.45%)
BHmean-95 20     1894.47 (   0.00%)     1258.34 ( -33.58%)
BHmean-99 1       958.94 (   0.00%)      951.84 (  -0.74%)
BHmean-99 4      2072.98 (   0.00%)     2062.01 (  -0.53%)
BHmean-99 7      2853.96 (   0.00%)     2851.21 (  -0.10%)
BHmean-99 12     3258.65 (   0.00%)     3203.53 (  -1.69%)
BHmean-99 18     2565.99 (   0.00%)     2143.90 ( -16.45%)
BHmean-99 20     1894.47 (   0.00%)     1258.34 ( -33.58%)

sysbench Time
                            5.9-rc2            5.9-rc2-lru
Min       1         8.96 (   0.00%)        9.04 (  -0.89%)
Min       4         4.63 (   0.00%)        4.74 (  -2.38%)
Min       7         3.34 (   0.00%)        3.38 (  -1.20%)
Min       12        2.65 (   0.00%)        2.95 ( -11.32%)
Min       18        3.54 (   0.00%)        3.80 (  -7.34%)
Min       20        3.74 (   0.00%)        4.02 (  -7.49%)
Amean     1        11.00 (   0.00%)       11.11 (  -0.98%)
Amean     4         4.92 (   0.00%)        4.95 (  -0.59%)
Amean     7         3.65 (   0.00%)        3.65 (  -0.16%)
Amean     12        3.29 (   0.00%)        3.32 (  -0.89%)
Amean     18        4.20 (   0.00%)        5.22 * -24.39%*
Amean     20        6.02 (   0.00%)        9.14 * -51.98%*
Stddev    1         3.33 (   0.00%)        3.45 (  -3.40%)
Stddev    4         0.23 (   0.00%)        0.21 (   7.89%)
Stddev    7         0.25 (   0.00%)        0.22 (   9.87%)
Stddev    12        0.35 (   0.00%)        0.19 (  45.09%)
Stddev    18        0.38 (   0.00%)        1.75 (-354.74%)
Stddev    20        2.93 (   0.00%)        4.73 ( -61.72%)
CoeffVar  1        30.30 (   0.00%)       31.02 (  -2.40%)
CoeffVar  4         4.63 (   0.00%)        4.24 (   8.43%)
CoeffVar  7         6.77 (   0.00%)        6.10 (  10.02%)
CoeffVar  12       10.74 (   0.00%)        5.85 (  45.57%)
CoeffVar  18        9.15 (   0.00%)       33.45 (-265.58%)
CoeffVar  20       48.64 (   0.00%)       51.75 (  -6.41%)
Max       1        17.01 (   0.00%)       17.36 (  -2.06%)
Max       4         5.33 (   0.00%)        5.40 (  -1.31%)
Max       7         4.14 (   0.00%)        4.18 (  -0.97%)
Max       12        3.89 (   0.00%)        3.67 (   5.66%)
Max       18        4.82 (   0.00%)        8.64 ( -79.25%)
Max       20       11.09 (   0.00%)       19.26 ( -73.67%)
BAmean-50 1         9.12 (   0.00%)        9.16 (  -0.49%)
BAmean-50 4         4.73 (   0.00%)        4.80 (  -1.55%)
BAmean-50 7         3.46 (   0.00%)        3.48 (  -0.58%)
BAmean-50 12        3.02 (   0.00%)        3.18 (  -5.24%)
BAmean-50 18        3.90 (   0.00%)        4.08 (  -4.52%)
BAmean-50 20        4.02 (   0.00%)        5.90 ( -46.56%)
BAmean-95 1        10.45 (   0.00%)       10.54 (  -0.82%)
BAmean-95 4         4.88 (   0.00%)        4.91 (  -0.52%)
BAmean-95 7         3.60 (   0.00%)        3.60 (  -0.08%)
BAmean-95 12        3.23 (   0.00%)        3.28 (  -1.60%)
BAmean-95 18        4.14 (   0.00%)        4.91 ( -18.58%)
BAmean-95 20        5.56 (   0.00%)        8.22 ( -48.04%)
BAmean-99 1        10.45 (   0.00%)       10.54 (  -0.82%)
BAmean-99 4         4.88 (   0.00%)        4.91 (  -0.52%)
BAmean-99 7         3.60 (   0.00%)        3.60 (  -0.08%)
BAmean-99 12        3.23 (   0.00%)        3.28 (  -1.60%)
BAmean-99 18        4.14 (   0.00%)        4.91 ( -18.58%)
BAmean-99 20        5.56 (   0.00%)        8.22 ( -48.04%)


docker-ized readtwice microbenchmark
------------------------------------

This is Alex's modified readtwice case.  Needed a few fixes, and I made it into
a script.  Updated version attached.

Same machine, three runs per kernel, 40 containers per test.  This is average
MB/s over all containers.

    5.9-rc2          5.9-rc2-lru
-----------          -----------
220.5 (3.3)          356.9 (0.5)

That's a 62% improvement.

--erochwecjadffrwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Dockerfile

FROM centos:8
MAINTAINER Alexs 
#WORKDIR /vm-scalability 
#RUN yum update -y && yum groupinstall "Development Tools" -y && yum clean all && \
#examples https://www.linuxtechi.com/build-docker-container-images-with-dockerfile/
RUN yum install git xfsprogs patch make gcc -y && yum clean all && \
git clone  https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/ && \
cd vm-scalability && make usemem

COPY readtwice.patch /vm-scalability/

RUN cd vm-scalability && patch -p1 < readtwice.patch

--erochwecjadffrwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="run.sh"

#!/usr/bin/env bash
#
# Originally by Alex Shi <alex.shi@linux.alibaba.com>
# Changes from Daniel Jordan <daniel.m.jordan@oracle.com>

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TAG='lrulock'
runtime=300

nr_cont=$(nproc)

cd "$SCRIPT_DIR"

echo -e "starting $nr_cont containers\n"

pids=()

sudo docker build -t "$TAG" .

nr_running_cont=$(sudo docker ps | sed '1 d' | wc -l)
if (( nr_running_cont != 0 )); then
	echo "error: $nr_running_cont containers already running"
	exit 1
fi

# start some testing containers
for ((i=0; i < nr_cont; i++)); do
	sudo docker run --privileged=true --rm "$TAG" bash -c "sleep infinity" &
done

nr_running_cont=$(sudo docker ps | sed '1 d' | wc -l)
until (( nr_running_cont == nr_cont )); do
	sleep .5
	nr_running_cont=$(sudo docker ps | sed '1 d' | wc -l)
done

# do testing evn setup 
for i in `sudo docker ps | sed '1 d' | awk '{print $1}'`; do
	sudo docker exec --privileged=true -t $i \
		bash -c "cd /vm-scalability/; bash ./case-lru-file-readtwice m" &
	pids+=($!)
done

wait "${pids[@]}"
pids=()

# kick testing
for i in `sudo docker ps | sed '1 d' | awk '{print $1}'`; do
	sudo docker exec --privileged=true -t -e runtime=$runtime $i \
		bash -c "cd /vm-scalability/; bash ./case-lru-file-readtwice r" &
	pids+=($!)
done

wait "${pids[@]}"
pids=()

# save results
ts=$(date +%y-%m-%d_%H:%M:%S)
f="$ts/summary.txt"

mkdir "$ts"
echo "$ts" >> "$f"
uname -r >> "$f"

for i in `sudo docker ps | sed '1 d' | awk '{print $1}'`; do
	sudo docker exec $i bash -c 'cat /tmp/vm-scalability-tmp/dd-output-*' &> "$ts/$i.out" &
	pids+=($!)
done

wait "${pids[@]}"
pids=()

grep 'copied' "$ts"/*.out | \
	awk 'BEGIN {a=0;} { a+=$10 } END {print NR, a/(NR)}' | \
	tee -a "$f"

for i in `sudo docker ps | sed '1 d' | awk '{print $1}'`; do
	sudo docker stop $i &>/dev/null &
done
wait

echo 'test finished'
echo

--erochwecjadffrwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="readtwice.patch"

diff --git a/case-lru-file-readtwice b/case-lru-file-readtwice
index 85533b248634..57cb97d121ae 100755
--- a/case-lru-file-readtwice
+++ b/case-lru-file-readtwice
@@ -15,23 +15,30 @@
 
 . ./hw_vars
 
-for i in `seq 1 $nr_task`
-do
-	create_sparse_file $SPARSE_FILE-$i $((ROTATE_BYTES / nr_task))
-	timeout --foreground -s INT ${runtime:-600} dd bs=4k if=$SPARSE_FILE-$i of=/dev/null > $TMPFS_MNT/dd-output-1-$i 2>&1 &
-	timeout --foreground -s INT ${runtime:-600} dd bs=4k if=$SPARSE_FILE-$i of=/dev/null > $TMPFS_MNT/dd-output-2-$i 2>&1 &
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
+	mount_tmpfs
+	create_sparse_root
+	create_sparse_file $SPARSE_FILE-$i $((ROTATE_BYTES))
+	exit
+fi
+
+
+if [ "$1" == "r" ];then
+	(timeout --foreground -s INT ${runtime:-300} dd bs=4k if=$SPARSE_FILE-$i of=/dev/null > $TMPFS_MNT/dd-output-1-$i 2>&1)&
+	(timeout --foreground -s INT ${runtime:-300} dd bs=4k if=$SPARSE_FILE-$i of=/dev/null > $TMPFS_MNT/dd-output-2-$i 2>&1)&
+fi
 
 wait
 sleep 1
 
-for file in $TMPFS_MNT/dd-output-*
-do
-	[ -s "$file" ] || {
-		echo "dd output file empty: $file" >&2
-	}
-	cat $file
-	rm  $file
-done
-
-rm `seq -f $SPARSE_FILE-%g 1 $nr_task`
diff --git a/hw_vars b/hw_vars
index 8731cefb9f57..ceeaa9f17c0b 100755
--- a/hw_vars
+++ b/hw_vars
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/sh -e
 
 if [ -n "$runtime" ]; then
 	USEMEM="$CMD ./usemem --runtime $runtime"
@@ -43,7 +43,7 @@ create_loop_devices()
 	modprobe loop 2>/dev/null
 	[ -e "/dev/loop0" ] || modprobe loop 2>/dev/null
 
-	for i in $(seq 0 8)
+	for i in $(seq 0 104)
 	do
 		[ -e "/dev/loop$i" ] && continue
 		mknod /dev/loop$i b 7 $i

--erochwecjadffrwv--
