Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526107BA135
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbjJEOm4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbjJEOhN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 10:37:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03EA4E351;
        Thu,  5 Oct 2023 07:03:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950k1Xv024157;
        Thu, 5 Oct 2023 11:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/NomB0qtwPLd9KH4TWgEIow1Tp0JY+7uCbWoJ48Ot8E=;
 b=JuL9e4Rc1XL0y19/xoI6j0dqzPoVZZoTh4MxojxcqjcIwadBEmMUcohlAZl75w1QFk+T
 0epEV44eGY94aUjnVBknQP+OCCDANRIVjTG84XULMYHcSypmA7Abx8005+OpcboF0e1b
 oUUQW4XDyOKmdQiGgIJApUbS3QM14YjHXVzmF/1qIU0hyvVSrzzrDIUIRoGOdPYS+0qS
 Koqz8EG1aPcki6i/eMTDWd5A5iM7IWAuvlWqDS0wp4hAvBc3gfuLiIe4IIa2jtFK4Skj
 RSvEHWJpuQA6n9zkt5IQ+PCB4pyx6uNNu2EU5PHB5tWdL/VH2QXdGzFeO7XS/loEh6ly +A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf499e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 11:22:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395Ara1R005789;
        Thu, 5 Oct 2023 11:22:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49022a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 11:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpanTLZx0GefBJsCGhpcjfXLCSXzHLEhhYt7Px6VemKtUhg2kMiSH+VXsXvK36aXnGBBl7hCGNL00DIT2ycXTzVOIVUGIC8JcF/M72jkj98nKOehfa3ds8Okr6FMgfOU6BdyYWPeQLfre3mN4zqcOFV4iLhJrMxPl7qcPPiR3ZehVgMUMwOFV/KflPhk9v773nKt766JJAl3PuJV1XxqYGRrwGQSc6JP4xItiuBwBSPS3aYFPP/D32FsRoenAZxWOzBCLdzxrQRui1Suyc4NAV7OMYt2r1GYOlDd7s8PvUFAgphcAsdcncxg9uKVPqS26RQwhYpBWm88TrBMhSozDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NomB0qtwPLd9KH4TWgEIow1Tp0JY+7uCbWoJ48Ot8E=;
 b=og972eu828qVQcneCUkbU99CkdNEVKLwDbZJfUDthZI4Q4Jdx2WCE2cCFP6TTq+rUJKEyEzV3G1X9tXmtqBRlq59MzY9CVdJ73MnWQRH7/EvFuhu/sFJKa5Bma/ELrNwYDE4yw1C6lKXd8y6Uyvpjmp6XeL/nkjNAx9hZEQQL/F2vurAsMWWs6WFDQNpDh0WTjlo9gPZvSEjqyFPodMbRb/t/STZGklBke6IMWYLndY6WyUptBsY4ohkWGaNkyukYCIxxQsBR3sKNFU731crqyuyj10UCZxbTDwjXjhuVYPw1sE0RSyasSETKqKmnJ891BhrrOkOMd7IgQslYLPs7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NomB0qtwPLd9KH4TWgEIow1Tp0JY+7uCbWoJ48Ot8E=;
 b=kNRvUdBEyUQUwLmGkrLSzXaiu5BImGe5z4R9oDvHPZ80mI+cXdgp8lJOF6xtHAQtYcGXoELg2CTBH+YoST53oI/h/4og67ZEZyzNzFdw9Oi7jqtYIToI2TSg1sNRLfbbhYWEXqsQj3gcZgl5Y4xV/yn78nxLJvp3Mk/Z67X1BL0=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.31; Thu, 5 Oct 2023 11:22:02 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 11:22:02 +0000
Message-ID: <dc74f0ed-f647-cd1d-1bab-42366d2321b7@oracle.com>
Date:   Thu, 5 Oct 2023 16:51:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [External] : Re: [PATCH] cgroup: In cgroup_no_v1() check v1
 controllers only
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230920102513.55772-1-kamalesh.babulal@oracle.com>
 <ZR26X4EJaNgQP5Be@slm.duckdns.org>
Content-Language: en-US
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <ZR26X4EJaNgQP5Be@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 296f349e-68ec-4d90-b308-08dbc5954c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7U1VQ18g7jloUWsVHVgAH8PLbHgEb/eVf8RZ6Q62iKAX8QexOJVuN+jhuXxGyc8iz2vNLdQ3BVAs2I4sGBS/7Un61OJeflJZ/ifFxiE4QJYIM8CZpqTLE0SpxP59dS9OiGbBI7e6YsBw4NbUug9oS4bkWpK7ma9t3B6ChkZBxv8vKHPPQjjLqlAJq9ZVwCQoMEdo6gjRfll7VqCQ0/wEmbGnZ9oDf6HVOR3Q8fDJZT04dHi1aINcO4JJumLWHzJjKg7P2foUhhGZHpCQ94wscQJKDPkWftzHkLREPmCFx+94uOeEPX9vtmITUKroXEqB5Hu4fYAzXAHxq16k9pWs8H29wzV+fm7CkCgzpvZ8MUJoPm2Z0opSa7/xvV6GP6Hkol6jOG0rozGF8SFWDDr+cLSFLaM8bVLuBD3Tv0Y2EBf1RTgo9n54lPSjwVKqtCle4vp067MfaYQJ+FhpUmCS4JrtN8mQQHMF95kuBqh1DG6vLuvL6UJdE88/8y1G9ETDEX9LZBtD/aMsRiTdh8KEFEgn5soj38rJ0aL/gfKURd9+W9tFfHPFWRqCW4Ek0v2bkv94nrNnfVg5ARiQhcxE6vVLJoeWnsKI/j0werw/SLTJXWoQzm3eRErLydau8ZPdtZIInkNDv8d+rcYkJqJQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(4326008)(8936002)(6666004)(5660300002)(8676002)(44832011)(66476007)(66556008)(316002)(66946007)(41300700001)(6916009)(54906003)(31686004)(6486002)(478600001)(2906002)(86362001)(26005)(6512007)(31696002)(36756003)(2616005)(38100700002)(6506007)(53546011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3B0dkQ5aHlKZE04TnNCQ3FISTZxU1NXMUkvQlJMNkwwM0ZnNUJJSHlWdEVY?=
 =?utf-8?B?WTdTekJLd2dHRjg5Z0h6RmlHMm5nUXBHREV4aU55YWZnZXpBTTQ3eDF3SzBB?=
 =?utf-8?B?UlF5TWY3M2NlSEUrL0F0NCtwOUZEelpYU3dKdS90d0EwN1hUNzlxQ0NOaU02?=
 =?utf-8?B?SHcvTjNJb1dTQ2hrZHlCYnhZMkV2OElrSzJBQS9BRitIUnRnOForTktaTlJS?=
 =?utf-8?B?c1h2ck8vU2FtSGdnVDJpME51QWw2ck1EZSs1NWhOQXR2MWJhNFNQeXRJVzRY?=
 =?utf-8?B?WWlKQjBDRjE2Y0ZNbFptYytxOTB3ZFNuOUg3VXF4MzUvWWtwUzhneFNPaE1I?=
 =?utf-8?B?SzhQaWwzTHpIb3l6cG42RWJFam9LMy9ySm9MQi83YnhuYmNiY1pKdGRSWkxv?=
 =?utf-8?B?MUhkblFqNjkyVmQ5NW5XLzg0T3Nzb3RZQVhGVGVmZWJEZ1lrRkpkSjAwUU5k?=
 =?utf-8?B?c2lXOTE1WFdBZGNsTFdzd1RXM3NTWmFhYU9HNmxRc3FSTFlvbFc1dUlBR2Rk?=
 =?utf-8?B?RGhoOTlEaXZBMzFod2NJUVF5WHljZUM2Nnp5OVhxRjQ4clREWWcrVmMvQUhy?=
 =?utf-8?B?NkJSQ1dSMmNqNGozQXFYOHVxazk4QldPOE90RGsvckp0Zks1R240amJ5ZWI5?=
 =?utf-8?B?aitDNlNuWSs3ZGZiUVM4YnRHWE5ZNGd5T3RGMGhtaGNzMkNOaXVvbmhFaEZN?=
 =?utf-8?B?bHp4UWVQWGNMWTkrVjRYNElqZG91dUtTYU5LdU5aNU5La3pwcWFDNlhDbXVx?=
 =?utf-8?B?RWhibzhrY1JvV3BySG5xUWg4K1k3eFpxYis0eTFacFlWMlUzc1ZLTkhzaXNK?=
 =?utf-8?B?MFhRZkF4KzNkdGJRSitURFlRbmozeTFuN3J2OWFIak15QmtidmhSTU1mVTN1?=
 =?utf-8?B?SzhSdEEwRGUzZEJpait2RjdBQ0szakhISlhpNmNCelJpbGI5Rzh4TWtDYTdI?=
 =?utf-8?B?Wm9KakVJZjFjSllqVDhRbnVwNXpCOHFJQS9mVEVGVWJMK3Rpb3dOZFpNckQy?=
 =?utf-8?B?NUpEZUpyUCtFdjRVTW5xWS9RYWZOUGFsT0pQdFZzMmREckxKaElmNHpwY0xa?=
 =?utf-8?B?ZzdQaVFMeDIxKzJTNktGb0d2a2RVWEE3TncyYWkyME1TVFViSkY2aklmVWJy?=
 =?utf-8?B?NG1EZnhuak5NZ28xMXBoWHRuVWM4TFVjS2VGbkZpeGZiMGdzZEVkbWNYSkxJ?=
 =?utf-8?B?Y1VwbHVtaU5MandIQXRhbEs0dEhrRFdTOHhkVVMxQ3dic3lMZnhyRUYrTTho?=
 =?utf-8?B?TzZaK1J1ejhZVS9uR056MWNzb3B5dlRGbUNiU1gvd0JUUHBMQ2NtS0VvdGlr?=
 =?utf-8?B?MVpZaDlpQm8wWjcwZFBmMUNoNkRlVWYwMHBzdWVkZzkvZytzSUlNMnpGVm1y?=
 =?utf-8?B?anJXUXo3ZWVaRG9iajJUNllpVkZrVUV5YlFKNUlhSWFNNkM2N2kyWVJjOTJW?=
 =?utf-8?B?V3ByQklacDZaTzBwMGQ2WCtDWFFscFY4NXRUWGQ5TVFHS24zSEFqa3FobG9G?=
 =?utf-8?B?RXhpL1BSczNkNHQ2TUM0UHplb2VYd0tyT2RQQ2lmaUZlYm9Tb1VJYkxyU0VU?=
 =?utf-8?B?aGVCTHpDQnZETzgxZ3Z1c1pMYnIyMDRrWU5WVnRlaSsvWitXMnZRZGczaXNQ?=
 =?utf-8?B?NjVoMVg4QjRKS21jOTF6ajZadkZKdDN5eURja0ZCeGk3MUpzbm9pY1Q0ZUdW?=
 =?utf-8?B?VnJFZDk1MnBhWXFkdjBMdkZ0NUdnRnhSK2ZjMHloWGY5R1AxQmYySUFDMjdl?=
 =?utf-8?B?L2V5L0RvQWpGVDhRSnRLK3pHZ3RIZ09heXp6TVpMRTdiNGl0akxDZVJSRmIz?=
 =?utf-8?B?ZzM3Mkd0T1pqZXNUd0N3KzN6WnpDaDVISEtvcXg5a0d6SDBoTXJuSmhtNFR5?=
 =?utf-8?B?VVllaEJTTmtGVnlMOUNSdDBWK3hlRDdla21HWVNlRkhESUduVGl2Q3N0L1Y3?=
 =?utf-8?B?ZDZlSHlFWW5taUpVQVR4WlRhaVpvb1UrZlladDBpT29OM2lwZ2RhVFZCanI3?=
 =?utf-8?B?dzJSUEIxU3oyaUlEd1pKQXlLUHhQamY4RGFoWDBiZTFkQml2NFR5NHZzU1lh?=
 =?utf-8?B?a3VGMG4xblJWZHVpMTFEcFFyTzlicGcvYlFjeisyeDY5bVlxdXh4ZFdKd0VB?=
 =?utf-8?B?SDREUHNqM25FcmNtcVpWNElLMjVCRk1QZXNHSFltOVdvOXZMUVN6Y1NNNHk2?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8tU5NFxtQIkMA59HcNaIkh53V2SMn1HUNKGUKtoieN5lgyEpPlX88/Wk8kvvsIbEaPoSsY4HuQbem8WVznDa6s34H9yQ8OvZWLKr0TvoFlryoyG0jX27yxrsd3DTVjpnzcrPZOV5BOnnfBGjHy2nO5LR2+E+38PPJwrNCuLMFfk3m4rU4fdCUZrpG/8jZFB8RcWhQ+CaZcfBezGmCFCFQyOjpcaso3Cj4FZdZ9pCnbOKjjLygmd8wMLpcLdd/rRu7zwqYzF6bxFPCuJCkpEST2V2TwWMzAoA19/m+gqGcT4vm1muj/8Wqepd3NCtNOlJKdvskcsMcHWwnGxG9yVckZo245LdRLeQfrMvL8K4LgQlmZXZeAjNVmA+fnywSkY3FEruM3d47DR2Rcotu3S1hjlWl9wv1Aa/ghugO+/iEJKjBq/xJ0MswfqrcenDFNrjgtRgRyK3LKc7S848/na06TO2d+0AeZej4msLx98qKSPpvfyCTIKgBavQbaMK6dmrYzrMS3LVSbEgRUmOyXHp2jU+TB7N60xG3Y/QeD6Vu7mSglzGxSlB8xjeS+GmQEFsPBnR3YkNgQ9Od7mxDrPvpukw4qn+9F2iyyF89fWrKvmFv/YubHvVz1vvu1MTTBjFAoc+c5WhYzKZS73od+7Rs2t2WgU0lo4ZBG22URvUn7YGlds0OggccJ9nkGeavlw/Z1h6iMnXsxKS042gRTWMHGrHESBh4gKKmGK5tldnU6dLX1I9Gj9LNTEycwicvcUZzrGx5wm3CRaQmrhEGmTtMVUKyz3aEhCKJkcNGl0GkthIQQiDjdvILVloBoPD2fuWNw6Sbp+FXcObRPCCE5v0qptfba/6BSpose7wCKH98N4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296f349e-68ec-4d90-b308-08dbc5954c24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 11:22:02.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYCmbHH+IqtUp/uWilTKcLjBRPXrDPk5Wblw5iq0e+ANmaivd9eNe152ORkD+P0JDjKbGMQPq6pQceV6m49SBHUCJET3QAHL+qM7mhy8eV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050088
X-Proofpoint-GUID: SVQOVc8WiqX0ybAq-vFuczyI0_bBPY_C
X-Proofpoint-ORIG-GUID: SVQOVc8WiqX0ybAq-vFuczyI0_bBPY_C
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 10/5/23 00:47, Tejun Heo wrote:
> On Wed, Sep 20, 2023 at 03:55:12PM +0530, Kamalesh Babulal wrote:
>> cgroup v1 or v2 or both controller names can be passed as arguments to
>> the 'cgroup_no_v1' kernel parameter, though most of the controller's
>> names are the same for both cgroup versions. This can be confusing when
>> both versions are used interchangeably, i.e., passing cgroup_no_v1=io
>>
>> $ sudo dmesg |grep cgroup
>> ...
>> cgroup: Disabling io control group subsystem in v1 mounts
>> cgroup: Disabled controller 'blkio'
> 
> So, making the printed names consistent makes sense but I'm not sure about
> not matching "io" anymore. That's gonna break users who already use them,
> right?

Agreed, users might pass "io" in place of "blkio", I was thinking
in terms of cgroup v1 users, for whom it is "blkio" controller but
as an argument, "cgroup_no_v1" makes the controllers passed to it,
available under cgroup v2, where the controller is named "io",
which the user may use interchangeably.

Shall I re-send the patch to print the controller legacy_name only?

-- 
Thanks,
Kamalesh
