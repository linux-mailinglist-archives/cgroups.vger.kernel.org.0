Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCFE10B8E0
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2019 21:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfK0Urn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Nov 2019 15:47:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbfK0Urn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Nov 2019 15:47:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xARKi2Pj143347;
        Wed, 27 Nov 2019 20:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=IgkMzbjRPUbwRkAG0xZ2tA24LLs27aOqCh9wo7AWk4g=;
 b=BxROrlmjTjbkScBqFw2uHf/mP5vQHwTSzMoKTBlj5/w1EWfb0QRZpUSlYnXDj6j8Of3L
 nXagl3m0yQoJZLOa1Cn1xplEFPJXJzq2Hd+cFl+DOvnfm194jcL9VZq+WTAWG7ls+MQU
 dLoAm2Y1egApyLKVrjAZ1r4EDD6u+APKcbWIm1Kp5URbYMgvCVdDAflSBlWcRDWLgrYf
 zsgYPGGqJ9UnO/+gJmqDKV8hN6WRLhAU9TOii3FIAVl9qS2nM05dheZ+GJcPNV1anLFO
 UMZUlx4b18Ai2NL/hRt9m7Ef6cOQKOjGsC+I7hudW03nf/ywzSDDF0+jGvKroEPMccXw Eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wev6ufwch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 20:47:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xARKhBrW062684;
        Wed, 27 Nov 2019 20:45:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2whrks0jmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 20:45:30 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xARKjPnG028951;
        Wed, 27 Nov 2019 20:45:25 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Nov 2019 12:45:25 -0800
Subject: Re: [PATCH v3] mm: hugetlb controller for cgroups v2
To:     Giuseppe Scrivano <gscrivan@redhat.com>, cgroups@vger.kernel.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        almasrymina@google.com
References: <20191127124446.1542764-1-gscrivan@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <70b8960d-3890-9b57-1c9e-2e891e5dc02b@oracle.com>
Date:   Wed, 27 Nov 2019 12:45:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127124446.1542764-1-gscrivan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911270167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911270167
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/27/19 4:44 AM, Giuseppe Scrivano wrote:
> In the effort of supporting cgroups v2 into Kubernetes, I stumped on
> the lack of the hugetlb controller.
> 
> When the controller is enabled, it exposes three new files for each
> hugetlb size on non-root cgroups:
> 
> - hugetlb.<hugepagesize>.current
> - hugetlb.<hugepagesize>.max
> - hugetlb.<hugepagesize>.events
> 
> The differences with the legacy hierarchy are in the file names and
> using the value "max" instead of "-1" to disable a limit.
> 
> The file .limit_in_bytes is renamed to .max.
> 
> The file .usage_in_bytes is renamed to .usage.
> 
> .failcnt is not provided as a single file anymore, but its value can
> be read in the new flat-keyed file .events, through the "max" key.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Thanks for doing this.  And, thanks to the people who know more than me
about cgroups for commenting.

This has no impacts on core hugetlb code, and appears to do what is needed
for cgroups v2.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
