Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37394590F6A
	for <lists+cgroups@lfdr.de>; Fri, 12 Aug 2022 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiHLK1h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Aug 2022 06:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiHLK1g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Aug 2022 06:27:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DD0A61E2;
        Fri, 12 Aug 2022 03:27:35 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C8qatH015088;
        Fri, 12 Aug 2022 10:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZzPNjrNBak90pV4hdaFyMYkL83XF79pJEP5ke2LniWs=;
 b=V+UW1v4ECFm6kVBHUaix40abLgIczL54Q7Kd7JY3c6gfer9o1SzXeUVW/f1uHyLobVoL
 MYIAiP+/jSQN46saUHo9WCNe2dpuoaMDwzs3eptgJ+rr8cllQ1phTiCkJR/83W39BXUE
 mPZ1Vyi+QdH3xgPVW3EqJznVqjUg/pqo3y7rWahf/hP6A8C3v6zKoksY9EER8FR2PSal
 MuPGNy3VCDZtEEydknqelzw5N6JtHHsGKcvMK91n8e5ilZFOQMEYm8J9DMMRgPre0+fj
 DO9oWY9NcWW3x1sJRjRQw4Njjy9ojNG0uuVbHxY69Gt371d9E7rcle1wPHShNcMuRABE zQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hwahwhjy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 10:27:08 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27CAR7rp027705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 10:27:07 GMT
Received: from [10.216.5.168] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 12 Aug
 2022 03:27:04 -0700
Message-ID: <dc0cff0e-b744-9d5d-e727-70d1c31b2a74@quicinc.com>
Date:   Fri, 12 Aug 2022 15:57:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Query regarding deadlock involving cgroup_threadgroup_rwsem and
 cpu_hotplug_lock
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
CC:     Imran Khan <imran.f.khan@oracle.com>, <lizefan.x@bytedance.com>,
        <hannes@cmpxchg.org>, <tglx@linutronix.de>, <steven.price@arm.com>,
        <peterz@infradead.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
 <26d0e4cc-be0e-2c12-6174-dfbb1edb1ed6@oracle.com>
 <bbc01477-231b-3dbb-3e09-9338f5413f06@oracle.com>
 <ba48eac5-8ef7-251b-11fe-8163bb7a2d54@quicinc.com>
 <224b19f3-912d-b858-7af4-185b8e55bc66@quicinc.com>
 <YthDz4BnfYHce1od@slm.duckdns.org> <YuGTBLkFerUboctl@slm.duckdns.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <YuGTBLkFerUboctl@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2MSKsR2X3Dh5jcDZQrdfa3XQY98QrniE
X-Proofpoint-ORIG-GUID: 2MSKsR2X3Dh5jcDZQrdfa3XQY98QrniE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_07,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0
 mlxlogscore=836 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,


On 7/28/2022 1:03 AM, Tejun Heo wrote:
> On Wed, Jul 20, 2022 at 08:05:03AM -1000, Tejun Heo wrote:
>> On Wed, Jul 20, 2022 at 05:31:51PM +0530, Mukesh Ojha wrote:
>>> Looks like these patches are the fixes.
>>>
>>> https://lore.kernel.org/all/YtDvN0wJ6CKaEPN8@slm.duckdns.org/#r
>>>
>>> Would let Tejun confirm this .
>>
>> Yeah, looks like the same issue. I'll write up a patch later this week /
>> early next unless someone beats me to it.
> 
> https://lore.kernel.org/lkml/20220705123705.764-1-xuewen.yan@unisoc.com/ is
> the thread with the same issue. Let's follow up there.

Since, i am not part of the above thread, is the reason i am commenting 
here.

The original patch of yours [1]  and the revert of [2] is fixing the 
issue and it is also confirmed here [3].
Can we get proper fix merge on your tree?

[1] https://lore.kernel.org/lkml/YuGbYCfAG81mZBnN@slm.duckdns.org/

[2] 
https://lore.kernel.org/all/20220121101210.84926-1-zhangqiao22@huawei.com/

[3] 
https://lore.kernel.org/lkml/CAB8ipk-72V-bYRfL-VcSRSyXTeQqkBVj+1d5MHSVV5CTar9a0Q@mail.gmail.com/

-Mukesh

> 
> Thanks.
> 
