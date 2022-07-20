Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C8057AF78
	for <lists+cgroups@lfdr.de>; Wed, 20 Jul 2022 05:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiGTD2d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jul 2022 23:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiGTD2L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jul 2022 23:28:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013D843E40;
        Tue, 19 Jul 2022 20:28:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0JP4s031784;
        Wed, 20 Jul 2022 03:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4YBNVusGpdz5SOEFgMufVD6zRMtqYM3KOMIqUWpMezs=;
 b=VpCPbJ2qrcYudrNeddVS03dNwZQ0z187TlYeN6Fnblc66xEu8SvYHgNNV712r33PQoLD
 Sg+YREDqQamy1h9Af6cU21u7qQdRceY6Qb5TgTdP/2STnHbumXbL/e8F3IQqzt8RSY0E
 ZFxd0hRh+0U8L76tZ0gLUUconqdNMou2P3of8GmCf5pw28Y05VWjuPeHF41u6oBMvmia
 NufXSyIpWZk7XDy1czBU0wLS+oqoiFj0FR7U8ZbBvZiFQRHDqdkhiSQA6prodotNm27A
 EVV0M5W/D6A4FJWLqZealfkIMTeulqKGD1qXPQJuGBVeBNCOS/t428rbyLOMGVVX6dv/ KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg8jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 03:27:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1e9an016461;
        Wed, 20 Jul 2022 03:27:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1en3vt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 03:27:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yrg59xx3r1tn1xUmaIaBn3cmfGO6btJIzSopYPlIw0w/VlQ+pFx5Gy8lXYef42k3VYhbSzfGnuMfp8gHXPHMT4XghJlZvGnNidmt7C/VjDFz8RmiJcHucsemoaojUBekpEPsws/aLGMxzZvirW7r/W5DpU3L3TL08EOdjiDl2dPkN9OlFu1pnn37zMpE3ZEGm5p2PEhJmsVOcf2qTqHbpI3N4MeBFFCDwvMCXle67TPQgcSW4rvY9cNgztYjbQnhgHbHp1hZR9lZTz8BDlJW1N0zxGVR7fgtCIa1um2zoyY7OLZjR8R4vgs1STniXi2ffwITp7bpLvGEKnlyOld6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YBNVusGpdz5SOEFgMufVD6zRMtqYM3KOMIqUWpMezs=;
 b=dRGixwH2/gNFU2GPDkSqI+vL0GHoMjAqw4CbF0fyZNKGeYTZ4f8hARZHGlsWBeAXLXGwQSdlnCC/au9mqw1XISx7E6rCcYmtjBoC2WSwccvDUcqtlU/xJpOEeIhvok3R5t4qNJkhrWkY33AON5ujfhwgn2sjauRhrIGnGkPk+SK6uLqpnYfhboleUf8U5aDYt12q0cW6wVboBpR3UHpJXiJjIE5m0nnmRAyEE355I5n0YtD6XQoL44xHdKuDmrlUVIZkOHqpLRiNZd2ue83y7Z/4OtQ/q8evADi8v3SCFvE61dBpzDfAqm538ANNzWesaJaK4D+E+X36E+gnWUoO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YBNVusGpdz5SOEFgMufVD6zRMtqYM3KOMIqUWpMezs=;
 b=He2Bg/Wm09aHwihLBcCFUcENiwhBfJMhUK7EQwDB+PGBb0JNhquWkXrCrpgkRkkNQGhLcLgoGfWImLrg5ixINlz5LuAtv1Bi7XWInkMp4MrfPXsx0cnPwvJqkQJW5dAGuOurQjIecteFPQj22AioQYvOljc30466hz3Y04/JyRc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB2921.namprd10.prod.outlook.com (2603:10b6:5:6e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Wed, 20 Jul
 2022 03:27:43 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c%9]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 03:27:43 +0000
Message-ID: <bbc01477-231b-3dbb-3e09-9338f5413f06@oracle.com>
Date:   Wed, 20 Jul 2022 13:27:28 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Query regarding deadlock involving cgroup_threadgroup_rwsem and
 cpu_hotplug_lock
Content-Language: en-US
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        tglx@linutronix.de, steven.price@arm.com, peterz@infradead.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
 <26d0e4cc-be0e-2c12-6174-dfbb1edb1ed6@oracle.com>
In-Reply-To: <26d0e4cc-be0e-2c12-6174-dfbb1edb1ed6@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e2b4c00-8595-4fe7-39bf-08da69ffce40
X-MS-TrafficTypeDiagnostic: DM6PR10MB2921:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErcP2FA/1cTxPFRNVfHV/9Vv4TE+VkdQTLwwov9Qd9n+EDqETji0LbIcC7YVcdArXH1ogLMpSMXZNF0+6nhY5bvFvMfPAzf89q/worVVfCFfGfTTjzREGSZR/EKEn9IzYbUKbz50doGluY8YqmDdUrk/FlRFFqSJbtC9ju8jG0iVgoCvBtH8R46+fo/M0LYej3DtwMuGskOO6ZZ40udammCzgBErow1r97+fNpMR3Z2izUB09IZW293ni0AFsSJEAqpBVGb60uMRPaG+cfvqqkBWA6i/nG+CgAG6MXqNGzkaoDDDtAOny7RVLX4oyJAsOLabWp85G2cLYCK24GQw4db3Q2S3RI6csPxJl6rdvb9fA1kcJh5lgMSYF7y0VRDejMs7WKbUgDWaVlpnBxzWJB9jVVkeQzTsxud+UCsjeLVuJzPEIkeK7XB6z23/thLLXTQRjukz4fOJREAsdUlQtNvo9dQi/u5uvThRTiHAKcvbXHGfoKy5Rv3QKvwt+Uvsp2+/ivPikrzllg/bpUvCCzk51eg3Cw79t9/rS3fXwjqnkd65HwPjjpxz526akiqYJGuFQ+xm6EQLnx8yrzeu+6MISgJ0Ax6DmERhKH/QJzMBeIZbuhWjirXt4isj1hcqNdxHgRN+9eWBN0/J97K874zXcR4yp25UoY4C4m0i+t3uYjyLJi8O0OZ/iEyw7TPEbrG9izu643X7S2ni3laYOo1KAWilajJOXJqnQUvRmOmctHB2NHYSdNpmdN7eLtKmrBGEs3XvUAX69PdULepY4SYvxXFO/mlZF3r/j8VQA7jb/SziWDi6oQnHaLICtcKDiNTLvhHcBUjpb9xY0t1B5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(346002)(39860400002)(376002)(8676002)(31696002)(6666004)(478600001)(66476007)(83380400001)(26005)(41300700001)(2906002)(86362001)(6512007)(6506007)(2616005)(8936002)(5660300002)(186003)(6486002)(316002)(31686004)(66946007)(36756003)(38100700002)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFPaEtNWlZrWjJmb3E1Z1FpYS9Ed3JPVXQ4WUozNUl1T2ZsY1pUYXVYZGNi?=
 =?utf-8?B?OTVpaW5sTWlYTkJBOUtnQWpFcVE3NTYrMVVGZEo5dDhHYS9BL0lTc1p5eEln?=
 =?utf-8?B?U1FGOVNaWGpmSmpGbG1mOThpUmpnMTlLNkpYZWhDV2dWemc5a05qekh5VVN6?=
 =?utf-8?B?R2JNK1JuelBXNHVOdVVhdDBZM0VNT1dqaXRCdnRaZEl6cVlqeTNGcVJHalN0?=
 =?utf-8?B?blNINmpmdysyck5vSENTZzdKSGJPVnVUak1raVVBbTVGdDdJRW5FdC9yV1cx?=
 =?utf-8?B?Q2FrMHcyU1FHMTR0emVEUCs3ZzAvQm5MaWZCeXhSTlVOQzdINVdQaldOU2R0?=
 =?utf-8?B?MjRGRkdYZmRqUnlxTmdpcXNUMEVwNmVnSDBOTHJGRlBCQW1ZTllFL1gxTmVv?=
 =?utf-8?B?emZaNzRVUXJERUZ4Y2VOQm1WSHY4Zk92MmZ0OVhpQVpKZlFabW9tcHFlL3Nv?=
 =?utf-8?B?ZFRCcUd1TEZNMzlNeURjT2VOUXMyelZ1WENDdVRjMFhteGdXakJpVjNUVlVG?=
 =?utf-8?B?S2htSm9UZlA0VjB2MVIrZzUyTitjdnFVQUI1VlZTempXZTFjU1J5bXVSRG8y?=
 =?utf-8?B?eGdsQlRWdXFCVEFISWxKV2MzbXhCWmw4RTNwNVJBeEpXNUZSMFhsRVJqQ1hF?=
 =?utf-8?B?THhXM0ZvV1AwMTJkNE16bUIxVGxVTmxuTmQ1Q0FhNjVOQmxCTnJSZnhFL3lp?=
 =?utf-8?B?WExmaTB3a3QxUnY0WU01MHJMMjUvalNPd204UFpwc3h0d1AvQUgvMHRLWkwr?=
 =?utf-8?B?RGpmdytxaCtycWVoT3FFNUg4dHdQZGdVbzBoZ09JSjVFRTlQanRwY3J1UENJ?=
 =?utf-8?B?czVVMC8rNHNTWmJ3YnRUUWdTRzNvcFhxblF3WGNad2FvMlhmUFBHeTUyanhW?=
 =?utf-8?B?aThCajQ4WThuTjVtb1NFeDBqVTNoS1M1ZUg1N1BVUmRFMWRMcHBheGVWdGRs?=
 =?utf-8?B?UllaMmdublNKa1NNcWpvR2hIdjVsWG5mcGJ2MDF4R2ZLYkpablYyNFVZR0pm?=
 =?utf-8?B?TFhpYy8vMDFJRUNvTm5aRjZpanR6bnphZitUdHNOdUVURjYvVmdxRnFuelpu?=
 =?utf-8?B?YVViSHdNeER6QzdvWitlU29mT2xHbUlyaTc2Z0ZsOHBQMUJPUUJXZktjL1Rm?=
 =?utf-8?B?UVY2ZkVNZWtuT0lONndEQVljMCszSzc4S0hIMkF4RDBFWTBqSjBuV0xSb3R6?=
 =?utf-8?B?UThYaWZUTkZZV1VPckR0ZmlLQWtWdzBhcG1jZUtXL2F5bEdQb0tMRzFUNWlt?=
 =?utf-8?B?c3RlQllXNGxmVjVZWFZ6SVA0MWtMK0tGZWNVQlVIYS9zTUgzamIzUzBvMTB6?=
 =?utf-8?B?ZGNVSFkvczlpZngwWDJ6c0dlVGM5anZ1Kzl3czdsOVhyUHdJTm5uaHdKVnp1?=
 =?utf-8?B?OEorbUhmc2x2RGlsWmlqeW9yWURuQ0lCODBLRmVGRU9zcVg1VHB1aEZtSC8w?=
 =?utf-8?B?UmpLdC9va3ZIdkQvbS9Qc1F4Vnowb1kvcFJDbElKTFhrdjBBTGVwYTBpc3RV?=
 =?utf-8?B?aXR5L1U2UUxiZnZkWWFydVdzZjM2bnZwNi9mTndYMXBVVWpTZnN1Nm1BUjB5?=
 =?utf-8?B?UVVnV2NYenBCU1oxcXJON0tlRzlTZFdvZTBPOVc5TnVwRkhDQ1pkaUFxdURF?=
 =?utf-8?B?Y2NpTlRFdXo4RGt5eFNPTDkyQUtJNkNNbFRrNHYxV1JwazVBR0N4Rjk2cmpV?=
 =?utf-8?B?bGh2ZTZMRjZRajRncHA2dVNtVmpPeU9iNUFSRkt3TVlNellUMXhhaTIwb3pL?=
 =?utf-8?B?ZDNTL2JXaHdrTVlkZjZOVDVvUjUxWmdsS2dnOG9Eem14ZmFxTmp2eHEramRp?=
 =?utf-8?B?aEZHYVdSRGYwUnZIZnhGRFVobWtEcm5lOWlkcjNRZXpiS3VSZC9nUmlRRjVY?=
 =?utf-8?B?UjlVcUJnV25wS0RoYi9pZndMMjZISnlhVGhtekFjcjdCZVZiMmpMbzhyajZx?=
 =?utf-8?B?b3l4cTRRMmVEWU8xQmVDZzZqamsxVGRRS2dnMmd4RE9kT3RTdkNuK0ZtVkg5?=
 =?utf-8?B?ZTM0Zk1SUmxtdkhWbG4zVHUvRU40OUJNWFM3c2g3TUxKazRKSVJIRHoxSE9T?=
 =?utf-8?B?WE9xOGR5cVpYbTRhdFRGRUl6VXdHTmJ2NWtwaWwyYURrRnVNQ0R3dEZ6bEtH?=
 =?utf-8?Q?iO67tw6KsMGyOfboU8PO1VcxV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2b4c00-8595-4fe7-39bf-08da69ffce40
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 03:27:42.9131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZZ6eSuYQHsG9feGqjFpm2eg99aDkdxf0X6hxt+KXKEeWRFCRIzCleNcpY61/ZzR72WYg1EG8waUI7ODaG8ggg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=943
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200012
X-Proofpoint-GUID: iFSDoTS_U1orb_dQVN6qJjbUd82ADDWz
X-Proofpoint-ORIG-GUID: iFSDoTS_U1orb_dQVN6qJjbUd82ADDWz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello everyone,

I am seeing a deadlock between cgroup_threadgroup_rwsem and cpu_hotplug_lock in
5.4 kernel.

Due to some missing drivers I don't have this test setup for latest upstream
kernel but looking at the code the issue seems to be present in the latest
kernel as well. If needed I can provide stack traces and other relevant info
from the vmcore that I have got from 5.4 setup.

The description of the problem is as follows (I am using 5.19-rc7 as reference
below):

__cgroup_procs_write acquires cgroup_threadgroup_rwsem via
cgroup_procs_write_start and then invokes cgroup_attach_task. Now
cgroup_attach_task can invoke following call chain:

cgroup_attach_task --> cgroup_migrate --> cgroup_migrate_execute --> cpuset_attach

Here cpuset_attach tries to take cpu_hotplug_lock.

But by this time if some other context

1. is already in the middle of cpu hotplug and has acquired cpu_hotplug_lock in
_cpu_up but
2. has not yet reached CPUHP_ONLINE state and
3. one of the intermediate hotplug states (in my case CPUHP_AP_ONLINE_DYN ) has
a callback which involves creation of a thread (or invocation of copy_process
via some other path) the invoked copy_process will get blocked on
cgroup_threadgroup_rwsem in following call chain:

   copy_process --> cgroup_can_fork --> cgroup_css_set_fork -->
cgroup_threadgroup_change_begin


I am looking for suggestions to fix this deadlock.

Or if I am missing something in the above analysis and the above mention
scenario can't happen in latest upstream kernel, then please let me know as that
would help me in back porting relevant changes to 5.4 kernel because the issue
definitely exists in 5.4 kernel.

Thanks,
-- Imran
