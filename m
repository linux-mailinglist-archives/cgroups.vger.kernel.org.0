Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFB5F27B4
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 07:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfKGGhK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 01:37:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53330 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfKGGhK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 01:37:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA76YsB1185803;
        Thu, 7 Nov 2019 06:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=XgxfCulyBH2//qmNgzyWmuwH5ET2V0/HQXlmNyOpFMs=;
 b=AraxsU+BWg/O2bX4Iog4MVptevzQYhA65RsHWhZrIgwV0G+4aZ6kenf3/vVLcqhJcTkv
 8shX/Sko0HCAFzpJ5euTotVF7wt7qp4jwWBDdA3KWgL9WV6X2yin0FuIOmJszUdmkkRz
 rAjD+Ks8+v4xJj7t1YzHBTiEw175QVSx2w9vWnfAyL9D8TRO1OQsQ98mYZHrRfUCM6XY
 213hdRKQaK1S9NcfiVxuXJEp9bPcTMuoFaGltJckbSYniD0eBZHSXVEU85qoNkqIUPzA
 6DHMIGPvZjq0EITycDMMDQQLMZzJufKm2JadmyMzItZIfQq32NVWHCwj5UPZohUNm/G5 bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w41w0uujq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 06:36:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA76Yip9172306;
        Thu, 7 Nov 2019 06:34:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2w41wgch6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 06:34:47 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA76XRU6009286;
        Thu, 7 Nov 2019 06:33:28 GMT
Received: from [10.182.71.227] (/10.182.71.227)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 22:33:26 -0800
Subject: Re: [PATCH v2] cgroup: freezer: don't change task and cgroups status
 unnecessarily
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, guro@fb.com, oleg@redhat.com
References: <20191030081810.18997-1-honglei.wang@oracle.com>
From:   Honglei Wang <honglei.wang@oracle.com>
Message-ID: <4116b285-7e1e-8a95-a9e1-54f096f90229@oracle.com>
Date:   Thu, 7 Nov 2019 14:33:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030081810.18997-1-honglei.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=794
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=871 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070066
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Gentle ping. /Honglei


On 10/30/19 4:18 PM, Honglei Wang wrote:
> It's not necessary to adjust the task state and revisit the state
> of source and destination cgroups if the cgroups are not in freeze
> state and the task itself is not frozen.
> 
> And in this scenario, it wakes up the task who's not supposed to be
> ready to run.
> 
> Don't do the unnecessary task state adjustment can help stop waking
> up the task without a reason.
> 
> Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> ---
>   kernel/cgroup/freezer.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> index 8cf010680678..3984dd6b8ddb 100644
> --- a/kernel/cgroup/freezer.c
> +++ b/kernel/cgroup/freezer.c
> @@ -230,6 +230,15 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
>   	if (task->flags & PF_KTHREAD)
>   		return;
>   
> +	/*
> +	 * It's not necessary to do changes if both of the src and dst cgroups
> +	 * are not freezing and task is not frozen.
> +	 */
> +	if (!test_bit(CGRP_FREEZE, &src->flags) &&
> +	    !test_bit(CGRP_FREEZE, &dst->flags) &&
> +	    !task->frozen)
> +		return;
> +
>   	/*
>   	 * Adjust counters of freezing and frozen tasks.
>   	 * Note, that if the task is frozen, but the destination cgroup is not
> 
