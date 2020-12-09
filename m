Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C842D389B
	for <lists+cgroups@lfdr.de>; Wed,  9 Dec 2020 03:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgLICNX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Dec 2020 21:13:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55176 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLICNX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Dec 2020 21:13:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B929iCp157546;
        Wed, 9 Dec 2020 02:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=TQkdG2HxofP7Gjx/2MbWPihewec5Qk/l1s4p7G1cXC8=;
 b=U9gwOjq7SmCbCgRImhl1TwXzuxOUUqCB0rMIJdegBcv9/Gzu+laCbtU2jTGUxx4tmpH4
 mNyfpxy3z+yi78IBboMbbYliZCv4lw8u1B5OZX4xN83a6LobhTnYThTFG/S8qL7rVcgx
 MAL5OtXa0n2n4fD2nkobJowekxaCoWc2abDld8DvitfkDcfrKCu0tCuSF17ebefEYn9k
 +43E16O5KWiZ7JrgzfXlBfgw1bDTwmrtz/I6mk66Stx/Z9oe3N3jvGsywGPBTqMEwKFx
 21a5WpWQwP3sEppwkJgVBptCcyDKtLxBX4s6ZoUmQs3Dnp6XDYjbfElMId5YhlVLHGoz Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35825m5wcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 02:12:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B925jSM093680;
        Wed, 9 Dec 2020 02:10:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 358m4ysrtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 02:10:08 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B929qCx012013;
        Wed, 9 Dec 2020 02:09:52 GMT
Received: from parnassus (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 18:09:49 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alexey Klimov <aklimov@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com, tglx@linutronix.de,
        jobaker@redhat.com, audralmitchel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, tj@kernel.org,
        lizefan@huawei.com, qais.yousef@arm.com, hannes@cmpxchg.org,
        klimov.linux@gmail.com
Subject: Re: [RFC][PATCH] cpu/hotplug: wait for cpuset_hotplug_work to
 finish on cpu online
In-Reply-To: <20201203171431.256675-1-aklimov@redhat.com>
References: <20201203171431.256675-1-aklimov@redhat.com>
Date:   Tue, 08 Dec 2020 21:09:35 -0500
Message-ID: <87k0trvig0.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090012
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Alexey Klimov <aklimov@redhat.com> writes:
> I also in doubts if we need cpuset_wait_for_hotplug() in cpuhp_online_cpu_device()
> since an online uevent is sent there too.

We do need it there if we go with this fix.  Your reproducer hits the
same issue when it's changed to exercise smt/control instead of
cpuN/online.
