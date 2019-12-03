Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D4A110561
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2019 20:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLCTnV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Dec 2019 14:43:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48892 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLCTnU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Dec 2019 14:43:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3Jg93s180145;
        Tue, 3 Dec 2019 19:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=kWgRiFzPLbddsjol2zxbW3zqShnzJ0yocmLVwOP7628=;
 b=gQLKk2nIEvtnCvez2CKnaipEbEMjSDfCu8FNZcKG3//TrWd2/CkpuUhSEATROB3aDFBR
 bhbkMNITSVmjwiJwuM4oOHnYYXM6/1LXeCH/ZCQBFZJHtvWVdxT26PADeBLpoLGAdhvW
 j21Mpa24O5fmIosf1uSYL+DiwRV8lUzSYYtnoHgSQufIzB5tn09ewNXVmkeaQZwqp6CS
 vOLTorIjPZ92qOCeo0uwX/I0esTpbH/ooEudiOCHr20O/GqiTF1EvvQnt5UAzF12J8QX
 6faQz/Ta9s6RAUBKmFYv4XtaaECjJqkDMmWUODwSg4YO2TrfgtxLaw/AcZmkSY5+Bi7s Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wkgcqa0cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 19:43:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3JEnkT032106;
        Tue, 3 Dec 2019 19:43:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wn8k35y4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 19:43:02 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB3Jgx4i015319;
        Tue, 3 Dec 2019 19:42:59 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 11:42:58 -0800
Subject: Re: [PATCH v3] mm: hugetlb controller for cgroups v2
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, almasrymina@google.com
References: <20191127124446.1542764-1-gscrivan@redhat.com>
 <20191203144602.GB20677@blackbody.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <59c7e7a2-e8bb-c7b8-d7ec-1996ef350482@oracle.com>
Date:   Tue, 3 Dec 2019 11:42:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203144602.GB20677@blackbody.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=932
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=975 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030144
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/3/19 6:46 AM, Michal Koutný wrote:
> Hello.
> 
> On Wed, Nov 27, 2019 at 01:44:46PM +0100, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> - hugetlb.<hugepagesize>.current
>> - hugetlb.<hugepagesize>.max
>> - hugetlb.<hugepagesize>.events
> Just out of curiosity (perhaps addressed to Mike), does this naming
> account for the potential future split between reservations and
> allocations charges?

Mina has been working/pushing the effort to add reservations to cgroup
accounting and would be the one to ask.  However, it does seem that the
names here should be created in anticipation of adding reservations in
the future.  So, perhaps something like:

hugetlb_usage.<hugepagesize>.current

with the new functionality having names like

hugetlb_reserves.<hugepagesize>.current
-- 
Mike Kravetz
