Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5115A207B
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 07:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiHZFwj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 01:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiHZFwi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 01:52:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81749C04DA
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 22:52:37 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q4QSAk026510;
        Fri, 26 Aug 2022 05:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x8RAlz8VkjWw+gib2D59wTgdxtCaBT02JCU19dyRvE0=;
 b=nK5qD9k/1yqqYvOU7U1HDFIlC3k3/FFA4Hy6APcWhO8Zpwf7pRuwcT5hWWpsyVqx9T+X
 5ZJ+s3cGWZ04TiTK1s6EEoAwf0peTowK/Jc3YExnFNEcS9NHckQ+FtYMSaEWw1Xc9rVR
 0bbVnZRCO4bXpdqbTabue9ckj3OFNhA3J/guxaibfQlGxmUHL1qZN2I+UvAeV/mu8+Ec
 /kR+k7nbwSv7f6Hkb+/zFZ/sojn448qJmIt11l9xsaeGGOSaAa9qbYjZyWuxZaUhmYzw
 3LVX3ASSE0HWmBqr1ay69pL5fJvZlsjs3i9rOiMzX1EYyGbzU/xO4MCR8XlQk7MCiqT2 VQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j63v0mesa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 05:52:30 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27Q5qTdM001752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 05:52:29 GMT
Received: from [10.216.58.196] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 22:52:27 -0700
Message-ID: <eb00aa4f-3ddf-58bb-6861-216c53ace4ae@quicinc.com>
Date:   Fri, 26 Aug 2022 11:22:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] cgroup: Use cgroup_attach_{lock,unlock}() from
 cgroup_attach_task_all()
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
CC:     Cgroups <cgroups@vger.kernel.org>
References: <5ea67858-cda6-bf8d-565e-d793b608e93c@I-love.SAKURA.ne.jp>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <5ea67858-cda6-bf8d-565e-d793b608e93c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gM5EQ28yrC4BW1gz4M0biSF39TOOM6nK
X-Proofpoint-ORIG-GUID: gM5EQ28yrC4BW1gz4M0biSF39TOOM6nK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 mlxlogscore=529 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 8/26/2022 8:18 AM, Tetsuo Handa wrote:
> No behavior changes; preparing for potential locking changes in future.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>   kernel/cgroup/cgroup-internal.h | 2 ++
>   kernel/cgroup/cgroup-v1.c       | 6 ++----
>   kernel/cgroup/cgroup.c          | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
> index 36b740cb3d59..2c7ecca226be 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -250,6 +250,8 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
>   
>   int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
>   		       bool threadgroup);
> +void cgroup_attach_lock(bool lock_threadgroup);
> +void cgroup_attach_unlock(bool lock_threadgroup);
>   struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>   					     bool *locked)
>   	__acquires(&cgroup_threadgroup_rwsem);
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index ff6a8099eb2a..52bb5a74a23b 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -59,8 +59,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
>   	int retval = 0;
>   
>   	mutex_lock(&cgroup_mutex);
> -	cpus_read_lock();
> -	percpu_down_write(&cgroup_threadgroup_rwsem);
> +	cgroup_attach_lock(true);
>   	for_each_root(root) {
>   		struct cgroup *from_cgrp;
>   
> @@ -72,8 +71,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
>   		if (retval)
>   			break;
>   	}
> -	percpu_up_write(&cgroup_threadgroup_rwsem);
> -	cpus_read_unlock();
> +	cgroup_attach_unlock(true);
>   	mutex_unlock(&cgroup_mutex);
>   
>   	return retval;
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index e4bb5d57f4d1..5aee34bcf003 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2393,7 +2393,7 @@ EXPORT_SYMBOL_GPL(task_cgroup_path);
>    * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
>    * CPU hotplug is disabled on entry.
>    */
> -static void cgroup_attach_lock(bool lock_threadgroup)
> +void cgroup_attach_lock(bool lock_threadgroup)
>   {
>   	cpus_read_lock();
>   	if (lock_threadgroup)
> @@ -2404,7 +2404,7 @@ static void cgroup_attach_lock(bool lock_threadgroup)
>    * cgroup_attach_unlock - Undo cgroup_attach_lock()
>    * @lock_threadgroup: whether to up_write cgroup_threadgroup_rwsem
>    */
> -static void cgroup_attach_unlock(bool lock_threadgroup)
> +void cgroup_attach_unlock(bool lock_threadgroup)
>   {
>   	if (lock_threadgroup)
>   		percpu_up_write(&cgroup_threadgroup_rwsem);

LGTM.

Reviewed-by:Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
