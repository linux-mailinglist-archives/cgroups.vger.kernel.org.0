Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7EB2D38EB
	for <lists+cgroups@lfdr.de>; Wed,  9 Dec 2020 03:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgLICnF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Dec 2020 21:43:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49132 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLICnE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Dec 2020 21:43:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B92ZW6D015259;
        Wed, 9 Dec 2020 02:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=vhPAwGbX5UKJfIemCq3LE77ldW/MS6Z/BCzHi9otysg=;
 b=T4qPBYnl6CDw7MhxbLNUcQjfUzICtHe7Qj9GkVpSQmPaYMc0vvfQl536HZLiYJTvoNJ9
 jVA851tnFUxV62TxuNng9POPjnJibMO3kJeLdLP1o1Fk6m2M/EpmZYaxGU+9aRc27Co5
 bVG0eIucX9pBiqAYyJBL3xcODZJgNK3QhdPLWXGwucydXvAMr25NL+Zvl/dCOW0NmPkn
 nQ3IS9QIgBUoraAEHf7P56v8UAdAsGwRTD+nHgSQetz1MF7CyaV55tU9Wu1hv+2lRvOA
 EdWQ9Gpd5doM08dD2BbYWdVB8UJuefPMG/FwZoN+G+ZNF3Vbbqd00W667q8W20J4gMsj Nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35825m5yd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 02:41:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B92ZnNX160888;
        Wed, 9 Dec 2020 02:41:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 358m4ytt8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 02:41:12 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B92f6B2032250;
        Wed, 9 Dec 2020 02:41:06 GMT
Received: from parnassus (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 18:41:05 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Alexey Klimov <aklimov@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, tglx@linutronix.de, jobaker@redhat.com,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, lizefan@huawei.com,
        qais.yousef@arm.com, hannes@cmpxchg.org, klimov.linux@gmail.com
Subject: Re: [RFC][PATCH] cpu/hotplug: wait for cpuset_hotplug_work to
 finish on cpu online
In-Reply-To: <20201207083827.GD3040@hirez.programming.kicks-ass.net>
References: <20201203171431.256675-1-aklimov@redhat.com>
 <20201207083827.GD3040@hirez.programming.kicks-ass.net>
Date:   Tue, 08 Dec 2020 21:40:57 -0500
Message-ID: <87k0tritvq.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=979
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=978 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090015
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
>> The nature of this bug is also described here (with different consequences):
>> https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/
>
> Yeah, pesky deadlocks.. someone was going to try again.

I dug up the synchronous patch

    https://lore.kernel.org/lkml/1579878449-10164-1-git-send-email-prsood@codeaurora.org/

but surprisingly wasn't able to reproduce the lockdep splat from

    https://lore.kernel.org/lkml/F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw/

even though I could hit it a few weeks ago.  I'm going to try to mess
with it later, but don't let me hold this up.
