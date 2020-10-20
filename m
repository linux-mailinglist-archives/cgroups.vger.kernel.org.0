Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1687294463
	for <lists+cgroups@lfdr.de>; Tue, 20 Oct 2020 23:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgJTVOc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Oct 2020 17:14:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59758 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbgJTVOc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Oct 2020 17:14:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KLELjH154973
        for <cgroups@vger.kernel.org>; Tue, 20 Oct 2020 21:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=NVS75jl5f3ZgS5RJJBrIX/ZDaY9HPmTwQMgddPNnFP4=;
 b=ITEA31dhyG2ZaX0WelBf8u1mPcB1AUi+3fjjumdh1jFXOGy+NcjMnJ9fV7VbLo7SwqzX
 H0V2Hx28us78znyAM+p2CZtweBsZGimLEpmdsSbz3G1Hm3vKbbswaiGvFNDJhoEu12ok
 XmBQo++6Q5/BVRdMrQHHGNSQUdiD4ipULj4ZqWAXqZJW9SecP/KXUmtKm0c6mY+G5cpI
 g5lnXRTNs/bahjyixBQ0XTLGJ6pp9rYQPoDGgLGCUaQo6VSWQ0GuKOn4UhhpIk7BPWMm
 p2/+7b/aMrDl4dhnH5RhC8REXGbA77wxG5yvvEEJvXcNk2KtwNKfVSWCK+gCyuUj1DiY Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 347s8mwbxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <cgroups@vger.kernel.org>; Tue, 20 Oct 2020 21:14:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KL9ss5016073
        for <cgroups@vger.kernel.org>; Tue, 20 Oct 2020 21:12:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 348acr9f94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <cgroups@vger.kernel.org>; Tue, 20 Oct 2020 21:12:30 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09KLCTLZ008855
        for <cgroups@vger.kernel.org>; Tue, 20 Oct 2020 21:12:30 GMT
Received: from OracleT490.vogsphere (/73.203.30.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 14:12:28 -0700
From:   Tom Hromatka <tom.hromatka@oracle.com>
Subject: [QUESTION] Cgroup namespace and cgroup v2
To:     cgroups@vger.kernel.org
Message-ID: <d223c6ba-9fcf-8728-214b-1bce30f26441@oracle.com>
Date:   Tue, 20 Oct 2020 15:12:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=1 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=1
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200145
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I am in the process of adding automated cgroup v2 testing to
libcgroup and ran into an unsatisfactory user experience when
using cgroup v2 and cgroup namespaces.

I used lxc to create a container on a cgroup v2 system.  lxc
uses cgroup namespaces to remap /sys/fs/cgroup/mycontainer/ on
the host to /sys/fs/cgroup/ within the container.  Within the
container, I then created a cgroup - /sys/fs/cgroup/MyCgroup/ and
placed a long-running process in it.  (Note that as part of the
container creation, there are other cgroups in /sys/fs/cgroup/.)

I then used cgdelete to recursively delete the MyCgroup/ folder.
In recursive mode, cgdelete will move processes from a child
cgroup to its parent.  But this fails on a cgroup v2 system in a
cgroup namespace because the root cgroup is a non-leaf cgroup.

A couple questions/thoughts:

* As outlined above, the behavior of the "root" cgroup in a cgroup
   namespace on a v2 system differs from the behavior of the
   unnamespaced root cgroup.  At best this is inconsistent; at worst,
   this may leak information to an unethical program.  Any ideas how
   we can make the behavior more consistent for the user and
   libcgroup?

* I will likely add a flag to cgdelete to simply kill processes in
   a cgroup rather than try and move them to the parent cgroup.
   Moving processes to the parent cgroup is somewhat challenging
   even in a cgroup v1 system due to permissions, etc.

tl;dr - I can't move a process to the root cgroup within a cgroup
         v2 cgroup namespace because its "root" is a non-leaf cgroup

Thanks.

Tom

