Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA281592DA3
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 13:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiHOLA4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 07:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241824AbiHOLAt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 07:00:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F566479;
        Mon, 15 Aug 2022 04:00:48 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FAD2E0029408;
        Mon, 15 Aug 2022 11:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z3aS594wlbhZKWisoOFso7+h9XZN3ISVE0QdwPxZcJY=;
 b=WRBbzsoENcdRq19Ujq2hw46Z6kxBNsWKO06VrzMF7SEyBencFrzeigFRF12ZLZzSkNXP
 0EpHbA96kWD0/6PCPMHpwlmD6XJ7ClZ3C5J0WGdSg5JXWc9Ud2rNs8Qf6nXHbWIBXW4x
 gWYRwVNfT7Lhl/3UVd0ni1Y6x0pIV50SiGAEjrzAk8nZFYIlanb+8wvt+i7A/lqdQg5W
 asIyl83STQ/srrHqvga0Dt67TY8WH5+/g9gOnyPs8FgQLHvrvtroZa8ReMh/PFt7FTi7
 QFuJB9ip3HQeqiTnKYIf403tk/9/MHOcUHiWzhqP00mxAfE893BDU4FhNDb9Tr65HCCI Ug== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx1aud5d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 11:00:09 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FB08Ov013879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 11:00:08 GMT
Received: from [10.216.30.233] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 15 Aug
 2022 04:00:03 -0700
Message-ID: <f584fecd-6ca4-4ab0-763d-2ed219009c61@quicinc.com>
Date:   Mon, 15 Aug 2022 16:29:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Query regarding deadlock involving cgroup_threadgroup_rwsem and
 cpu_hotplug_lock
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>
CC:     Tejun Heo <tj@kernel.org>, Imran Khan <imran.f.khan@oracle.com>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <tglx@linutronix.de>, <steven.price@arm.com>,
        <peterz@infradead.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Zhang Qiao <zhangqiao22@huawei.com>
References: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
 <26d0e4cc-be0e-2c12-6174-dfbb1edb1ed6@oracle.com>
 <bbc01477-231b-3dbb-3e09-9338f5413f06@oracle.com>
 <ba48eac5-8ef7-251b-11fe-8163bb7a2d54@quicinc.com>
 <224b19f3-912d-b858-7af4-185b8e55bc66@quicinc.com>
 <YthDz4BnfYHce1od@slm.duckdns.org> <YuGTBLkFerUboctl@slm.duckdns.org>
 <dc0cff0e-b744-9d5d-e727-70d1c31b2a74@quicinc.com>
 <20220815090556.GB27407@blackbody.suse.cz>
 <CAB8ipk90LxNNbq5OKamd-ArkqhEZjxS1fFZJXtnbQwGzyyJ3wQ@mail.gmail.com>
 <20220815093934.GA29323@blackbody.suse.cz>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220815093934.GA29323@blackbody.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g09p5XzNTrHElQUZFQKcos2Wl2zs6yvx
X-Proofpoint-ORIG-GUID: g09p5XzNTrHElQUZFQKcos2Wl2zs6yvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_06,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 8/15/2022 3:09 PM, Michal Koutný wrote:
> On Mon, Aug 15, 2022 at 05:25:52PM +0800, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>> Your means is that the problem should be fixed by [1]+[2]'s revert ?
> 
> I understood that was already the combination you had tested.
> You write in [T] that [1] alone causes (another) deadlock and therefore
> the revert of [2] was suggested.
> 
>> I just tested the case which reverted the [2]. Need I test with [1] and [2]?
> 
> It'd be better (unless you haven't already :-), my reasoning is for the
> [1]+[2] combo.

Feel free to add my

Reported-and-tested-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> 
> Thanks,
> Michal
> 
> [T] https://lore.kernel.org/r/CAB8ipk_gCLtvEahsp2DvPJf4NxRsM8WCYmmH=yTd7zQE+81_Yg@mail.gmail.com/
