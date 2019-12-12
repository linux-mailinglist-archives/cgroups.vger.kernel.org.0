Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEA911D9E7
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2019 00:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfLLXUJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Dec 2019 18:20:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56146 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfLLXUJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Dec 2019 18:20:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCNJeJn091462;
        Thu, 12 Dec 2019 23:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=A8+rZkIKQnTkzrZReMSKxP4WljcNotdLx2sQG/CyxEg=;
 b=EeGwvUS+ueFkrznbJ9pMiE7SnTs7O0wxs7KWl8laS7as1MMrHGZPhcYDy10/U5rGYNhn
 CQEinpNzDzjwjS1cfDfy7C5sWirz76pGhRiHnD28O7umxdrFBfn5CHJTOLJsVTU5GV8B
 8dvwvrGoeXMhHIi5KKDFKxBwZeCToIksukEtIiZl0T3K33qPxkJGlV+zFiaii0KHC7Yb
 Ak3v4Zl9+IWEob7SOKA6PiTzJMp6a4KABG0KcfGLxBx+kHVOYQMfdKYdFlpp7vB9cPZu
 4zGgPK6Tg+01crUCz6vfuQxx1OwilkncNhO4hUqNJWAylOyd1oChC5oB85vCJEG9gRTA Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wr41qp3dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 23:19:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCNJZlM032254;
        Thu, 12 Dec 2019 23:19:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wumk6y2cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 23:19:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBCNIniM023966;
        Thu, 12 Dec 2019 23:18:49 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 15:18:49 -0800
Subject: Re: [PATCH v4] mm: hugetlb controller for cgroups v2
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     cgroups@vger.kernel.org, tj@kernel.org, mkoutny@suse.com,
        lizefan@huawei.com, almasrymina@google.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191205114739.12294-1-gscrivan@redhat.com>
 <20191212194148.GB163236@cmpxchg.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2a203549-5fe6-f13f-7d96-7e33d88327c1@oracle.com>
Date:   Thu, 12 Dec 2019 15:18:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212194148.GB163236@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120179
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120179
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/12/19 11:41 AM, Johannes Weiner wrote:
> [CC Andrew]
> 
> Andrew, can you pick up this patch please?
> 
> On Thu, Dec 05, 2019 at 12:47:39PM +0100, Giuseppe Scrivano wrote:
>> In the effort of supporting cgroups v2 into Kubernetes, I stumped on
>> the lack of the hugetlb controller.
>>
>> When the controller is enabled, it exposes three new files for each

Nit, there are four files now that you added "events.local"

>> hugetlb size on non-root cgroups:
>>
>> - hugetlb.<hugepagesize>.current
>> - hugetlb.<hugepagesize>.max
>> - hugetlb.<hugepagesize>.events
>> - hugetlb.<hugepagesize>.events.local
>>
>> The differences with the legacy hierarchy are in the file names and
>> using the value "max" instead of "-1" to disable a limit.
>>
>> The file .limit_in_bytes is renamed to .max.
>>
>> The file .usage_in_bytes is renamed to .usage.
> 
> Minor point: that should be ".current" rather than ".usage"
> 
>> .failcnt is not provided as a single file anymore, but its value can
>> be read through the new flat-keyed files .events and .events.local,
>> through the "max" key.
>>
>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Since this has no impacts on core hugetlb code, and appears to do what is
needed for cgroups v2, you can add:

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
