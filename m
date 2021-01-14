Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706972F67D5
	for <lists+cgroups@lfdr.de>; Thu, 14 Jan 2021 18:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbhANRgI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Jan 2021 12:36:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57636 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbhANRgI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Jan 2021 12:36:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10EHXhOV182459;
        Thu, 14 Jan 2021 17:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=c+LBoDh/DLOh8njoOTcgBp+JfS0k3t69g3Yr58Vbk9M=;
 b=L8l12Bm39XlQmb0LlpmpPgOlqUr3qL2detwnM4HdHuRMlzWNMDVw2hfmrp2vNeCj/BfN
 dF8qxNGrV8mzTf3i8ge0MXKqmQ2xsPONp6Ksb+KZNDYNVEH2IudER86puQyRgSXgTqXo
 vvJ4SiFDYVbUJm0nCrb2I9K/1LKzPflEtLCxyck0vt+KKGLXA5/su1vWfj8T7nNJW+xz
 SAxDzoEvYDgihbyPi8lXYPn0dxijwsZVLgYGp5CHTwKQxsnL+mK2SE8qXOY/CXeZdEzJ
 b/9/oqBocu/fnc0YFUl2d7u+2mzpzBG1YqtJS4357RbU293HQJ/z5BTguURH2SijsxY9 TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 360kg21dbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 17:35:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10EHPjFx066011;
        Thu, 14 Jan 2021 17:35:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 360kea6kcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 17:35:11 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10EHZ71C028767;
        Thu, 14 Jan 2021 17:35:07 GMT
Received: from parnassus (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jan 2021 09:35:06 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Hao Lee <haolee.swjtu@gmail.com>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Remove unnecessary call to strstrip()
In-Reply-To: <YAA8qyBUAurgCeEz@blackbook>
References: <20210103024846.GA15337@haolee.github.io>
 <YAA8qyBUAurgCeEz@blackbook>
Date:   Thu, 14 Jan 2021 12:35:02 -0500
Message-ID: <87pn27v2ux.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101140101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101140102
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Michal,

Michal Koutn=C3=BD <mkoutny@suse.com> writes:
> On Sun, Jan 03, 2021 at 02:50:01AM +0000, Hao Lee <haolee.swjtu@gmail.com=
> wrote:
>> The string buf will be stripped in cgroup_procs_write_start() before it
>> is converted to int, so remove this unnecessary call to strstrip().
> Good catch, Hao.
>
> Perhaps the code be then simplified a bit
>
> -- >8 --
> From: =3D?UTF-8?q?Michal=3D20Koutn=3DC3=3DBD?=3D <mkoutny@suse.com>
> Date: Thu, 14 Jan 2021 13:23:39 +0100
> Subject: [PATCH] cgroup: cgroup.{procs,threads} factor out common parts
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> The functions cgroup_threads_start and cgroup_procs_start are almost

You meant cgroup_threads_write and cgroup_procs_write.

>  kernel/cgroup/cgroup.c | 55 +++++++++++-------------------------------
>  1 file changed, 14 insertions(+), 41 deletions(-)

Ok, sure, that's a good thing.

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
