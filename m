Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304DB5963C9
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 22:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiHPUkE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 16:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiHPUkD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 16:40:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5CB75CE6;
        Tue, 16 Aug 2022 13:40:01 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GKQWsO001199;
        Tue, 16 Aug 2022 20:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=fxPvanH4qeBVh2aZXacr3twnFRomdbTwosccx73kWus=;
 b=GAxzEeB9Je887taMm/C3Y6+mEPelnEBsZTdS5ir79sWaEeKsKifbbefniv/ZVwUSEqVm
 mbHAwhC/Yeueym6aKukGgOOiP1MBUDpM04UcnuLLYYgvXDE031CTL8YOmU4E4IW7o+x7
 hAYV1P6tAsVyLrHKim8W6rFQjx6L+dY3mjyRYYUlOBAUvjDKTHGsPEQi1As4LnjWdie5
 d4CslhXzh8ligvnZygwBwEOgaHHxm0K8M0DcWrCEPLVhuos8ciUPTJjjM3buY2giTdDs
 Eb1w0RTStllQ6+BfwnbGfx9v9y82+rlKk8aupKe1w+K45xkE+IIm4lsD2Tl/KVy8SNGH sg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j06c0tn60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 20:39:55 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27GKdsOk012363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 20:39:54 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 16 Aug 2022 13:39:54 -0700
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 16 Aug
 2022 13:39:53 -0700
Message-ID: <7e047ee0-0243-d9d4-f0bc-7ed19ed33c19@quicinc.com>
Date:   Tue, 16 Aug 2022 14:39:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>,
        <cgroups@vger.kernel.org>, <hannes@cmpxchg.org>
CC:     <tjmercier@google.com>, <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        <quic_ajitpals@quicinc.com>, <quic_pkanojiy@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: GPU device resource reservations with cgroups?
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F6JGtFf7UBmS0kSYJwVIEAQK6aGvdabZ
X-Proofpoint-GUID: F6JGtFf7UBmS0kSYJwVIEAQK6aGvdabZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello cgroup experts,

I have a GPU device [1] that supports organizing its resources for the 
purposes of supporting containers.  I am attempting to determine how to 
represent this in the upstream kernel, and I wonder if it fits in cgroups.

The device itself has a number of resource types – compute cores, 
memory, bus replicators, semaphores, and dma channels.  Any particular 
workload may consume some set of these resources.  For example, a 
workload may consume two compute cores, 1GB of memory, one dma channel, 
but no semaphores and no bus replicators.

By default all of the resources are in a global pool.  This global pool 
is managed by the device firmware.  Linux makes a request to the 
firmware to load a workload.  The firmware reads the resource 
requirements from the workload itself, and then checks the global pool. 
If the global pool contains sufficient resources to satisfy the needs of 
the workload, the firmware assigns the required resources from the 
global pool to the workload.  If there are insufficient resources, the 
workload request from Linux is rejected.

Some users may want to share the device between multiple containers, but 
provide device level isolation between those containers.  For example, a 
user may have 4 workloads to run, one per container, and each workload 
takes 1/4th of the set of compute cores.  The user would like to reserve 
sets of compute cores for each container so that container X always has 
the expected set of resources available, and if container Y 
malfunctions, it cannot “steal” resources from container X.

To support this, the firmware supports a concept of partitioning.  A 
partition is a pool of resources which are removed from the global pool, 
and pre-assigned to the partition’s pool.  A workload can then be run 
from within a partition, and it consumes resources from that partition’s 
pool instead of from the global pool.  The firmware manages creating 
partitions and assigning resources to them.

Partitions do not nest.

In the above user example, the user can create 4 partitions, and divide 
up the compute cores among them.  Then the user can assign each 
individual container their own individual partition.  Each container 
would be limited to the resources within it’s assigned partition, but 
also that container would have exclusive access to those resources. 
This essentially provides isolation, and some Quality of Service (QoS).

How this is currently implemented (in downstream), is perhaps not ideal. 
  A privileged daemon process reads a configuration file which defines 
the number of partitions, and the set of resources assigned to each. 
That daemon makes requests to the firmware to create the partitions, and 
gets a unique ID for each.  Then the daemon makes a request to the 
driver to create a “shadow device”, which is a child dev node.  The 
driver verifies with the firmware that the partition ID is valid, and 
then creates the dev node.  Internally the driver associates this shadow 
device with the partition ID so that each request to the firmware is 
tagged with the partition ID by the driver.  This tagging allows the 
firmware to determine that a request is targeted for a specific 
partition.  Finally, the shadow device is passed into the container, 
instead of the normal dev node.  The userspace within the container 
operates the shadow device normally.

One concern with the current implementation is that it is possible to 
create a large number of partitions.  Since each partition is 
represented by a shadow device dev node, this can create a large number 
of dev nodes and exhaust the minor number space.

I wonder if this functionality is better represented by a cgroup. 
Instead of creating a dev node for the partition, we can just run the 
container process within the cgroup.  However it doesn’t look like 
cgroups have a concept of resource reservation.  It is just a limit.  If 
that impression is accurate, then I struggle to see how to provide the 
desired isolation as some entity not under the cgroup could consume all 
of the device resources, leaving the containers unable to perform their 
tasks.

So, cgroup experts, does this sound like something that should be 
represented by a cgroup, or is cgroup the wrong mechanism for this usecase?

[1] - 
https://lore.kernel.org/all/1660588956-24027-1-git-send-email-quic_jhugo@quicinc.com/
