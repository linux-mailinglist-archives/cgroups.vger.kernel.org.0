Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D876593113
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiHOO4X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiHOO4W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 10:56:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1EC193E7;
        Mon, 15 Aug 2022 07:56:22 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FEoOiB016475;
        Mon, 15 Aug 2022 14:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JulapoFWk3dxtqxAH3G3jT1Nroa70FxVbmz4oDd1F2c=;
 b=KR5sGZsx9MVkU2CoNuIQ426wYA8fwqUy4Rpy8RLT4lDjCKH8w37qfW3vGnQu9oonxR9m
 H2fQPe7gbMc7dC1Zosg2Z2Um8cO0jrqldfxAeTImQ2CtUKYEVviXM0jmLHpaSxYhS3hv
 FEquYyY1wJhIovoaqqRl3rFZ1E5pZMDheojt3tt0FWM/Zyesyvoi0MjqPXFJbHmYYwDe
 s7FS3ZWBEHNMgSe0/B2Qg0KPgwJ9/h/TQ5p1TAwRIPuSTFlqZHeMP1Rcreyic2icI/Na
 E8G9Pjn+Q78Hymy3YbyGS68kf6R0rE5wcCZQV5GSo/J+MVuAuRlOveIJ74IUqyJeNkPI FQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx3j6dcpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:56:10 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FEu9a9009487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:56:09 GMT
Received: from [10.216.30.233] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 15 Aug
 2022 07:56:05 -0700
Message-ID: <4323bf73-7a29-7a0e-55ef-b75fcfa76414@quicinc.com>
Date:   Mon, 15 Aug 2022 20:26:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 linux-next] mm: memcontrol: Fix a typo in comment
Content-Language: en-US
To:     <cgel.zte@gmail.com>, <hannes@cmpxchg.org>
CC:     <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <songmuchun@bytedance.com>,
        <akpm@linux-foundation.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        xupanda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
References: <20220815065102.74347-1-xu.panda@zte.com.cn>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220815065102.74347-1-xu.panda@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1qgREuCf1UUNqucLSo7q3YkWp08jjpjR
X-Proofpoint-ORIG-GUID: 1qgREuCf1UUNqucLSo7q3YkWp08jjpjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 8/15/2022 12:21 PM, cgel.zte@gmail.com wrote:
> From: xupanda <xu.panda@zte.com.cn>
> 
> Fix a spelling mistake in comment.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: xupanda <xu.panda@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> 
> ---
> Change for v2:
>   - fix wrong title
> ---
> 
>   mm/memcontrol.c     |  2 +-
>   1 files changed, 1 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b69979c9ced5..4dddd8be320a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1143,7 +1143,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
>   	} while ((memcg = parent_mem_cgroup(memcg)));
>   
>   	/*
> -	 * When cgruop1 non-hierarchy mode is used,
> +	 * When cgroup1 non-hierarchy mode is used,

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

>   	 * parent_mem_cgroup() does not walk all the way up to the
>   	 * cgroup root (root_mem_cgroup). So we have to handle
>   	 * dead_memcg from cgroup root separately.
