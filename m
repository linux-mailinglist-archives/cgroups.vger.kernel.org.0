Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50C0459A7E
	for <lists+cgroups@lfdr.de>; Tue, 23 Nov 2021 04:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhKWDdy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Nov 2021 22:33:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18806 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229955AbhKWDdx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Nov 2021 22:33:53 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN1mGeP015381;
        Tue, 23 Nov 2021 03:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FJhRUVLF41IteNP30kjmIDQ0wvnfb7LrsYn2Y4FK0O8=;
 b=leWUqjA43YuNHTqWoFYWCDu1nOkEsWQP8lTGP7sc7bEp1fgQSNf2sj/7bZboGLdOJaUG
 tCAd+6kCY7Xy3/UrpbHffnxQvHbbgCnZHKOdOY7qLpSLMEqLo8WIGJpp6d9fawaiBMZa
 Pz5/nJBMN6br7DObjItS993ROv5+ya4Ci7ei52jQZwBqZE6flA3FHoItak3QqcZEWlF4
 ISYR56oBG0LXiz13nVGJKGAo7ZaB4pNQgB514Gyl0waSHKq8lM/HAfvR+UuXtXR0GmlD
 zM5W1oDAgMO1aQDSyxtkQeFgnj/Hbz/LQNHwgemZBmIxcpAbUoZyoWRNRV+K2vdao899 7w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg46f6qhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 03:30:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AN3H0QF069130;
        Tue, 23 Nov 2021 03:30:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 3ceru4fp5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 03:30:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YG4s/ogI8lGvxiA3hzpKGKZb6f1MdVPUUVBbP//NP/2BRbWbAZwBfGMCSdcb7U1wBWnOI3LIEe2nWA66xAZ/n44DUGqLIQEOs0+KFmmdorXfeqaFvDpPv/PS4jwT+YpOxJhCRTKas3k3k5Q1MkTE02GgKDsgYJ8Qliiey4ukk4HvHH/yFQ4F+xOj2FrXozCisTto7nJQx3tQ/2/vJYWZWSnRZ/ynRc1UxzM7b3tIhgGd6q+pfl7AuFcgd+Idfasz1kv0RLAS2+QDGQAlPjcc1CBxtlHyp34EpZs3S0Cr9HJPfLlZd4C2c53+c2PvtkUmTqe6rBoGeO7RYOpEk5Tr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJhRUVLF41IteNP30kjmIDQ0wvnfb7LrsYn2Y4FK0O8=;
 b=iOrJsO1zMlI/WE0ClvQafawu0T575x0Sk7aMQH6izraIXc6R7eQlpEYqj4O9BC3770grsK5klCraYOL4QdhdfYjVMd4VdcO1zW5pG4qY5j4NPiRa2tumNZlsFMakZWj/1Ai7ONonOE/n3udkQoVfQmMq1MPoTp4W14dDGE2W+ffSDXKAM4I4mdWH+bHlobf0gLElP9q2S7XzKhQndkPyiopRlKzUFUnso2hBjTTn0DRn7LcKHBALII73kC3oaozBpuPZB6e0FF0x6oPhCqY8CYVC3q6A9bLG+Ia3sxy3bfEU8E2S361av1luR5auFwa0UHnAPNYIsd8wyz2APvrkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJhRUVLF41IteNP30kjmIDQ0wvnfb7LrsYn2Y4FK0O8=;
 b=mM7XUHVVgdFMpRfIH8cPtHHvwdy8nssQ/6AVNS8Pw7Q2eUVkGUJ4l0cxwQkG69up5m0lXsyntXV19zQ0216Ntv1+UnECxthtyt23HV4K/RSbeuc5phuKxQXIEMHOBWhnvEsJh5o21BSFtVlB7IIgjr93dkTBKmGS/RyYfWi+k8A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4671.namprd10.prod.outlook.com (2603:10b6:a03:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 03:30:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.021; Tue, 23 Nov 2021
 03:30:25 +0000
Message-ID: <53ce6e47-109d-af25-25fc-151ddf512287@oracle.com>
Date:   Mon, 22 Nov 2021 19:30:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8] hugetlb: Add hugetlb.*.numa_stat file
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, Jue Wang <juew@google.com>,
        Yang Yao <ygyao@google.com>, Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
References: <20211123001020.4083653-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20211123001020.4083653-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:104:6::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by CO2PR04CA0108.namprd04.prod.outlook.com (2603:10b6:104:6::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 03:30:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a4ffa34-0afe-46b7-f4e9-08d9ae319639
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4671:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4671CB89BBB8C4CABC5D43F5E2609@SJ0PR10MB4671.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FMXs8yqbgLetr7Mnq7DfhT03JwT1ase3oUvKekkU5WBjIpuuUPVCrd9XUq8g5pytDwX0KF6mKrD7jU7xa/liNWvbv7jNFw1eMfUN7kq8moLChfovL9le+lyAnLsRryI/mnMM4Kj6zLeUddy/y+YI84NVDsjsJ0ModkybIsBdaTMx2LWX32GFbnn4LEjw0/Y18frhBNjScnoYvX8BiFNNc4aMgVaF3TYSDHi9xxI3ZHTyyPdpQ8xb+6y9dIcJivD2qnsTGOa5vn0k8btz4QWvGXO2UrBcGxYNUBjQLrNim31ikhxC5YV+yEX7cl5khpa4oZadCwEPDKkc7FIAEuAkIO3KqBel4C5UhBR2i8nXd1dxGT6qrmdC1CSFlPigv4WoxX5bbDsRG7q7iyu+pi6sJuUeeF4QtuNnhuGmcdQNgotn1nRhIpP236OYyzN3MuAvTe+szYeY1cRpeDr0rnrR7Y36KSrt8YPRadakGq6/uEGE0+E5pW/MUDEccC5r2wNcPdjuEtSAmxQDR50aUQSdHdXfW/uV/leJ4Dkcmm/FYRuqOVEIOSgzPxdMMFODt9YxCTg+E3INqUmmw2+LRpW5PYf2igbF0KhlUpyBeSvMieO33soItZurdGRf79n4a7/3/ZbjaMnSWgAenYmAu7MCQUtibtwG3ScYxUHqbY5OV8tDSLPYnfkwEzloVAdjl4EY+0C6unV3gaiPneTEVd8hkkOJedgmL0f5Y+9XGl91nDuHJNqOkziRdWj7sOWqe9SaOfQ+YT35yZ4Vpkwjc3vpIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(31696002)(36756003)(186003)(86362001)(83380400001)(2906002)(53546011)(31686004)(956004)(2616005)(66556008)(66476007)(66946007)(8936002)(8676002)(7416002)(52116002)(5660300002)(110136005)(26005)(6486002)(16576012)(54906003)(316002)(44832011)(4326008)(38100700002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnFJSjdRU1FqR2ptUkdoVW10Ly9WbUZIOG02dTd1aUlvWmZ4MnU0aGloRngw?=
 =?utf-8?B?NWMzU2JuMkhGNk1YOS9pVzRWNHZwVkRwT0pGRm9JRllwV2phdGwrY2JveGVV?=
 =?utf-8?B?R1FqSHhJZDNOakZ2WTlGbGxYU2luRi9lOXlCdDZFT2N2OTA2ZTRKU0FWTnZx?=
 =?utf-8?B?MnB3RHArbkpMZUszbUs0eXdTNm9xa2xyU0c0VkZPR3RFV3p2WkFKZTVFOGVX?=
 =?utf-8?B?ZXlEa1FBbWxqdmVZVi91bXZld1NvcU1pZ2F0aFF0dzhwVGFYaG9BQ2I1VkQ0?=
 =?utf-8?B?RkJHdGJPOHVxaVM0NmozWGkyQWE1K0srb3hOZDJtL1ZTREtyS1hrU1pDRzUy?=
 =?utf-8?B?SVduL1RobjdGOFZ3Tm1jZGpMcTlFM0RYMWZTaVBZMFAwRHJrRG5URDl2cWQ3?=
 =?utf-8?B?dS93U0dKcXBRd3hwcnl6N2dacWJ2UjFaYmNpRkNiYW1MeklkQjZPeTZTS2pj?=
 =?utf-8?B?U0hneHNxSTg1c2dwRnpUUjVRbTFVQSthK1Zyd1R2VThqVW9GRUVtQjY0OUFM?=
 =?utf-8?B?TkphMUowZlkxU3gxN0pVaDQxQ29yUVRlMlBOOFJQQWlFd2E5K3dzV1NUZXdq?=
 =?utf-8?B?WFlQTHcyNldaNHRITmxKUlQ0WDBaUjdKai9XVno0WTZSRUtLVElLZjZkMWQ3?=
 =?utf-8?B?Wlg0MG1INE1UbmpIV0hDaUxiQjBlaDBhNWtnTjQ3aXFkc1ZwQmR3VEpxN3M2?=
 =?utf-8?B?NTdhbk9jMGkxSnRreWFVdVNyZGNEWGFNVWJlN0x0QmdtVWxxVG0wYzNaM1dU?=
 =?utf-8?B?U3loQmVFUHlTV1p0QlMzZTI0ZUZ1N21ybmJYM0p6NmNHa0dlWG00WW84Zjcw?=
 =?utf-8?B?US9OUWY0ZHlyTlJPY3M0T014ZTdtbjZvZU9rVGg2MXhRRHNmQ0srbnpTQTl2?=
 =?utf-8?B?TTNpUDN0S1VKQTdSQXYvUUl4c05ySC81NFhqN0o0dEVuQVFFMHJzVWRMNjRz?=
 =?utf-8?B?UDhUZ09OWGdtQXhuNU43bDhqeTh3WG9oY3AxN0lPK2NEMkhNL3RON0FsWHFB?=
 =?utf-8?B?dlZ0dzJFS0JzaTErMHptZTZseHQvcUV2SmpsODAzanp1VWhwd0J0SnRhd252?=
 =?utf-8?B?QzRIdlVHTm9MbDg2ekJmcTlKSFFZNXZsY2ZnR21mMFo1azhEY3BsMVhDTklx?=
 =?utf-8?B?NW12ZUJEVEFWK2tKL01XMFM2bTRGUGR2L21wVnJCelc5eG8xanptK295ZUZB?=
 =?utf-8?B?WnN4Y1VSWGdzQzFEV29SMUxkRGk3enJCdFhSQVljbTVuRXR4SnBSMG9NbFhK?=
 =?utf-8?B?Q2tzRGtKb0Ezb0tXM3VURjN3cTdGVk1pTUdIdjZUdWtjcDlQWng4UGtVYzZ2?=
 =?utf-8?B?bTZ3ekdPWjkvanRoMmxOUFF5Q2dndk5vKzNIRmtmenp5WEFPTXptTHhiRlVy?=
 =?utf-8?B?RjArRi9TdEw0dCtnb1g5SU13akk0WkZQQXR3bWFsaWNuczI5YzJZUWx6Y2tG?=
 =?utf-8?B?ZFhHQWxXQ1ljSzBURG1ac3krNW5va0ZwYVBIN2tPaXMvZUtXcWJ3VWpSY3hp?=
 =?utf-8?B?VGp2S2d6bzAzYTNGYTZlay9JbWVYLzFRTHU3TmJkZi9IcVFSOFFWZ3M0Ky9Q?=
 =?utf-8?B?WEdQelhMSjFPdDYwVnFQN0pvQWQrT3JzVk9vcENHZzFmbFg3SGFEMFRGUW1Q?=
 =?utf-8?B?Zis3YXBBSXcxd0JaMmVFWGtuaUlKQU9WWTl2dTNCVFB6TW56K20reDNSRjV4?=
 =?utf-8?B?QkdaRno5U2kwRWtjdjBtVnlrdWQ4bmpSMUQrQW9zSkR6SjlwWElFNXJaUVdV?=
 =?utf-8?B?YmI1bUV1S2JLWFp0cWdoUjFBOUkxTFp2OFpzd3E2QTZCbkRqQ2Z0S1hrbTJV?=
 =?utf-8?B?elgvTXFZdlZRMmN0YVNNR0w3RmhYMkl2ZHNOVk5MY3JTTlVDai9xYmp6VWMw?=
 =?utf-8?B?ZW1CZmJNZXMrL1M5QnZGU08zSGZoaVhESUNYRWl2RlZWRy9QSTRiVFUzT3Ra?=
 =?utf-8?B?dzEvSW5ad2lwMUxneEFGcnhtblNZdkxmUzU5ZWdLZ0t5ZDFBOHE0cVA4MEZZ?=
 =?utf-8?B?dm9CRVlGN2V6SC9HNEs5S3VHSGZ2SHZkWTIyb1A3V0JaY3lOVzBGMWFTN1Fp?=
 =?utf-8?B?T0FzZnFIanlmOFV6VXE4Zzh0bk5zUGVONHAydHBxbXA5TWNMTnRhWVJQUnF0?=
 =?utf-8?B?M2lBUzNBWUwxWFJsYkx5S2hma0Y0a2l5WnRRSjA4b1lQdythZkNobEtOdkts?=
 =?utf-8?Q?2N4KZRsrMACkuQWwWNxcWHI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4ffa34-0afe-46b7-f4e9-08d9ae319639
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 03:30:24.9703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhjlGtlgXTKSvq+H1lUknAlCjlXRXS1YHlBe+wQtbf8dQe9DHVSKJeRFmvTLcwC2nyYCqJR+1WtedXPyxaKSFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4671
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230015
X-Proofpoint-GUID: xD8mbVFgRkLLjCzlZL78hd234Mv_fctq
X-Proofpoint-ORIG-GUID: xD8mbVFgRkLLjCzlZL78hd234Mv_fctq
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/22/21 16:10, Mina Almasry wrote:
> For hugetlb backed jobs/VMs it's critical to understand the numa
> information for the memory backing these jobs to deliver optimal
> performance.
> 
> Currently this technically can be queried from /proc/self/numa_maps, but
> there are significant issues with that. Namely:
> 1. Memory can be mapped or unmapped.
> 2. numa_maps are per process and need to be aggregated across all
>    processes in the cgroup. For shared memory this is more involved as
>    the userspace needs to make sure it doesn't double count shared
>    mappings.
> 3. I believe querying numa_maps needs to hold the mmap_lock which adds
>    to the contention on this lock.
> 
> For these reasons I propose simply adding hugetlb.*.numa_stat file,
> which shows the numa information of the cgroup similarly to
> memory.numa_stat.
> 
> On cgroup-v2:
>    cat /sys/fs/cgroup/unified/test/hugetlb.2MB.numa_stat
>    total=2097152 N0=2097152 N1=0
> 
> On cgroup-v1:
>    cat /sys/fs/cgroup/hugetlb/test/hugetlb.2MB.numa_stat
>    total=2097152 N0=2097152 N1=0
>    hierarichal_total=2097152 N0=2097152 N1=0
> 
> This patch was tested manually by allocating hugetlb memory and querying
> the hugetlb.*.numa_stat file of the cgroup and its parents.
> ￼
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Jue Wang <juew@google.com>
> Cc: Yang Yao <ygyao@google.com>
> Cc: Joanna Li <joannali@google.com>
> Cc: Cannon Matthews <cannonmatthews@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 

Thanks for continuing to update, this version looks good.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
