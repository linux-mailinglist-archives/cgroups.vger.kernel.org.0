Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F37B6F58
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 19:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjJCROO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 13:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjJCRON (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 13:14:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2509E9B;
        Tue,  3 Oct 2023 10:14:10 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393Dwq8Q015976;
        Tue, 3 Oct 2023 17:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=htI1D+oDThWlldkTvev0uhQE7z8KBuLGpYV6WwWWcPE=;
 b=fcRC44BEGf0Z/4potBcquoBvCJN4MXkaOJtRo8AB2Juq006/1Wlpg99KE4+F3B/9xvwr
 NYW9nYZ2mz+WDT5W54eveQCQYGTEQ1VPvkRAPZhKohE6JUdHanGLtYdEcgvxBz/45aC+
 ZRfksrdDW7ZsSzPTYMg6IwZ3+ENv71Od87PZe0K03rm4RumOKRTEK90pV3AbSfoSrySy
 HbLdSnj9n8PBTrSTbfhYbU8mNePCW+i5GnyoVf13Bskme0z158OPd31d+WqtJaqU30Oc
 q/zfCp+u6N9GtMRrbYEVroUiY++vFjnhjbXg8pfW2NfGX0WF2ZQ8wDXswjNxFtdeIqQx wA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqdw9cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 17:13:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393GlV6h008833;
        Tue, 3 Oct 2023 17:13:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46ufvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 17:13:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be3papo3cPXF8CriRZjMeei3rZR/PgZ4p4b8qgzEWo8lmKuy++Zy+Cvc+vqz0l/G8/JPZPPcn5E2ppMQN7lJq0cnadz11qW6DC1So/dj60mC2D2H2QdXKtrkQsBNnMZpOdPe0/YXUYadIvK3OOq4VVrPhHBlg1Az8srOXFro2QIPOdmDu/wDR6AwHvdamm/BKS+Nzv34oURU860gaSL+9n3ScgOZRm8kbYxyynVV/yuVgJMJne+cbFZNTDOgTdrokMEGVtad1WU3xCs7oxOESJAdoJcnfl74X20pfUFkZNKVAVbMzIb9JJ+msM8sgerx4ScFG02zPNdfn65VSxVdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htI1D+oDThWlldkTvev0uhQE7z8KBuLGpYV6WwWWcPE=;
 b=kKOmgcQ1WjZv3bXjp/XtrPGlsjRqoS0Rt8TqWwxeRJ2iM273JyjP+9tY4t/E9p6h2JnVAQWg+QIzcwBb9CXmVZWoWfsRT4b1Fxmktq3aiCxrdhqS+eN6lwotYfuMODskl+tqWeb6L+QFEu3j+WaAUFkRRe/YYcODz3CbXHCHaJ/BgwGmylRBWRoPHWINrMdiRvEEw0syKC5b7riQUS3UCpVFHPAs8qHIh7OkqfBHj3HW59ZwaMcBhY/7oFN6D1NFej54VxJ9K6vPc21ClPMqZHvI0D5MMxuHPTk58np4233RtCBAQg/tw8Bvz79+Nk6G/aLRR9ElNthr1R2x2WUxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htI1D+oDThWlldkTvev0uhQE7z8KBuLGpYV6WwWWcPE=;
 b=N47KGv36ZQQiXjIfqHqvVuCHGXGKL1OYAT7oCIJM+NxZ3SdmcBDjBRyyEFJo4yZkzHI5Yo+GH/bYf4hp3lEFhFZC/vvYYgrbOYaJwoouW6K7PUQdBNcHcoQxM5dPAOBzFBL8W+UgJqNuqmdZgWLyEttQ+Pj1up5hvVP4iJ3KH18=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 3 Oct
 2023 17:13:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf%6]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 17:13:33 +0000
Date:   Tue, 3 Oct 2023 10:13:29 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, yosryahmed@google.com, fvdl@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <20231003171329.GB314430@monkey>
References: <20231003001828.2554080-1-nphamcs@gmail.com>
 <20231003001828.2554080-3-nphamcs@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003001828.2554080-3-nphamcs@gmail.com>
X-ClientProxiedBy: MW4PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:303:6b::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e027521-f06a-45b2-eb0b-08dbc4341294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcxElLSdTbM61mkEF4tjUxs840Q8orM3M56RBWws9fTvPDp/pJXJQOU4+knrwSg9fD0CW7oyoidCOcJH9gofx/PKunXoUjAuwRfwalB5XRewM7MxYBsMWWDLBroJRhncm7HY+x2HNmgt/p262OPJ2crtwf/wafDS0FPX2YD+MI41DV2Fl6CLgSCy47P9gHYc+STO5NLYUYYlwfxifvl2gIcOoVaxKMeJsKZ9mk/25cmAaW3yKmWraUaDcy0/L81w509k8JLSLGvS9RuokbDMyo6yb0m61JY19q4C+nqokH/+/OfFjvjkINl22bdk7suyy9RNM7CAoKLyfcQp3+lmuE47hZJjlddXAZE/ApDDCPKNHgJo2JuRdL1EMym4YU6SvZ8cMW29N97Rl6xROEAzwmhWmFmMCDtBTV7nYN8kg3JBG9Jr8PRiwBSMgiCPR5RgbA4shwv6qhN3NkBj3iaHw+0I6xr7c0qZVK9t2pK/ppU38zPgMVoUJ/XA1VrsvZtdRzlhXNV1djZZmbH6EpqRw9Xt9MG7jQOok87t6Prasf76ucJO0kx2pjJaM0/QXgAK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(33656002)(2906002)(7416002)(8936002)(4326008)(83380400001)(86362001)(44832011)(5660300002)(15650500001)(478600001)(8676002)(66476007)(9686003)(26005)(41300700001)(316002)(38100700002)(6512007)(6506007)(53546011)(33716001)(66946007)(6666004)(6916009)(6486002)(66556008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qoFiFaBNy4ZTq/I3I6kPuhkV7vmdrKuml62DezlFoc2Rjs/YbSh6JhK+mezv?=
 =?us-ascii?Q?w79vfGyWw5o+Z6HddXs4V3wqB4ILELA4ZFnbZ4wSWZMzAEbQsZg5VhvcDxb+?=
 =?us-ascii?Q?eld7YVwHmh36wAjxAFCPi7XK9UxnhmZVgiFov1lSW7oltJAmLnhq5VdM7CDL?=
 =?us-ascii?Q?CfCEncwlcqBPW5zTe87OL4/92h/JR3OHXlG4P2J16s+TeTObzBJDZmFT3Jqk?=
 =?us-ascii?Q?Fi79lvHSKt2PZrQX88wSuRnlOnYzYCzYDUZ7lQekWYwmCChRdHXr+HXB0aXB?=
 =?us-ascii?Q?1r1CmUeY7abiDNcEYg3jjBgMAdXMx2mVKtsnJdO9MONsPzdv8XawY0YmoNKV?=
 =?us-ascii?Q?x+XIL4/VCeeHhvlYp60ulyCW8q6SFKg7hp/gmdaJ8eGhjcO7lao6EARw1w9n?=
 =?us-ascii?Q?7xqBzs8ulJ3XKfwMk00BLNunHapxUp29xMRpbIpsI/QcLqQR/hJIHQ3ExzsW?=
 =?us-ascii?Q?V1emRzUdIpWiE5xvKJZjexmhQgA3cOh+cZXubw9ZU3l3xAe59X8UVs0Zx97T?=
 =?us-ascii?Q?h46y1uFroxsqFQnTBT2Sn+aEtGVr2no+6P+az1Tr/r1yueUneI3D2omW5qpj?=
 =?us-ascii?Q?Kb6znW3BswShDGdI3GoTK38r6VeCSJH4w9uM7yQB0VOG6ZRyI6mczKG+XR69?=
 =?us-ascii?Q?K9db2guHUsN1xgVPgBEELzn1dxwrz7uTNEghC4qlCy1NTSRBCFRZlgs+k6vM?=
 =?us-ascii?Q?pENLRr+bGA33gh5w12ImBzmrKcqzqv0kxGJ6Io6AiTXNTlgU+cO6IXYjA/5b?=
 =?us-ascii?Q?VPNgIRmsXedPRWWO1XK2ONJYPSzIlUcrZcK4GollevcfVqdph7JYBgi5toV8?=
 =?us-ascii?Q?VnUWb28wThsAMUamFbdZg20yvpsjlaSeGz/JaEPAi1qnEIXV4cIrZS5IXcNp?=
 =?us-ascii?Q?lfhicG9YRcRRgsAck1TGgTsiPPOeUsFSWP7XhV0GirqiiK8xvNQofLikQWyU?=
 =?us-ascii?Q?WMW9ib+NAS1+3szp7k2aFQeGZVepjLAFnCI/eurVuCTBQpWBP7QGGAndiF5k?=
 =?us-ascii?Q?HrilL0l0nzdipgqwMgkajjaBA2mx8IMjtBznanHKMNhRNhGh9IZdTFdA0G2Q?=
 =?us-ascii?Q?U5xgqtmj+H2a6y0Gag/KiQHIyWHIgTxJ4IkuER/eLcEutSNp4YQ0QH+rjwGG?=
 =?us-ascii?Q?DCWyceJ+Eq35ZaKryoQg1pUZgSxmMh2e9WJeU606LIBHQD7ME0nvFGrbn432?=
 =?us-ascii?Q?UQ7KMAJ7MOQGetXj1rAP8jgk4dl2bFJWqnohDsG6K5yChQb6HymlN1KEn3Uv?=
 =?us-ascii?Q?OBqW9RSid8FeXM+1SBghJfq/j7rW58aPMw9pngNw+/+UK4TkRpK2ZHLjjSw4?=
 =?us-ascii?Q?WZDyB3+quPhWX68H5vL/MV5uAF+vPqSl7j05hiGKudU3SwlmEyjteAw9fbiN?=
 =?us-ascii?Q?jEfw5tZmonsgvV1hyzn61e0zeGiOv8LCSrz7wVoIy9Ie7IX0uFuIc4jTLBpJ?=
 =?us-ascii?Q?Qfn0uU3TNyXnBJTNxgx3RnCi2KvmTu2O8MScTlg0PsORntYPHIF3H0pCX1nB?=
 =?us-ascii?Q?asCinTPWAAbj8ACpOYTN+CQ2Y9Z/jeEwrSVwdYIqYItiXMmTEKTYLY1AUkF3?=
 =?us-ascii?Q?iS2N0bIoZ0xmnhanl0r6o4tNIxoilcIiqw0oiiaY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NjCPopDPxnMtR/zTNFShWeJOVc2+JoNUe0PGEAFeISUyR141bHHnSjqL3EFN?=
 =?us-ascii?Q?3mivfPhg0NV8uAS7kogQHQUt1hqDtNvFui+//Xj0PHz/ENUtDWCnIZhimjlO?=
 =?us-ascii?Q?J9kVho4NYVrTyoQ+zvYR/gntjs1Ja1pNX0KhCCHi+4+gilMovSdwDnIUQQVy?=
 =?us-ascii?Q?l6qDQ9nnJetOwGEkFFf3nXDByc4VTLpS21B6AM15qYjZlzXtG61De6BLXjgA?=
 =?us-ascii?Q?jXVZdD/AYoc7x12wjlgDsOAiys9fWIRZS3pnxsIGM2pcPW9oRt3YXbwJUKB3?=
 =?us-ascii?Q?wLyuTgz0xIqeWz7MOFL0KqXIM8AnpOhhNwFB6A9ocajWTR6PiKR0EG+e/ZLU?=
 =?us-ascii?Q?CMWgeiQR1fTmu/dummVlkjqVA/u4HnH66+GWW5a6WnRBfjJ9xQSmQYkmVIMu?=
 =?us-ascii?Q?ASTa2/F8FgqnOT15+3oEOEw26v/zF9/aNe6Kci56d2OgNigOSpjks+tb8lyY?=
 =?us-ascii?Q?eCxGNvPj3BAysXd7kvtmjKwdS6cl9m1TUh6s/C9hdJ5MhzVNOcC63gblEuYH?=
 =?us-ascii?Q?UOU3VSg8q18/3po0hMtN1Ham77+eKM8LkvY6qIHsow4J0L7YSnA97YMmF2Bc?=
 =?us-ascii?Q?h0a23NNYNEIvceJzOaaFvyey4gbh4lzx8TRCCU/SI9uSR2LCLiC3+mUZnGJu?=
 =?us-ascii?Q?c5vFjnx8lppNrl3Tl/H6SJH4QoVvy863NCIf0hjzhuPBmfxDgNabuScwGwEa?=
 =?us-ascii?Q?xM8ijp/c3s3l7ehpe1c3PsQE/IF6hV3EyPMMw2VtYZneeEkVS67MjU0H0GZg?=
 =?us-ascii?Q?9nm+i0fWHbV3yZzCKJDqKYYM0ljyN5AdVbB3Byx9WehDeNIfurXc3a1LNZjj?=
 =?us-ascii?Q?cF+Up9kKavYFZdsqef+C1SsUnZbjUIlGITKO59/M4e/f9cZgfNpGbF6wQFqE?=
 =?us-ascii?Q?EwWX/vWLWxVq4O87cJAJcLuJ8DOTPOqQMCCfq32i9F/BkMxaKMTfodt+x6yL?=
 =?us-ascii?Q?ulzDh+jR2PqZ+2xultaim9jbuRWnqEW6AMrqA8iL6XuHrS1xXGulPHryPOtL?=
 =?us-ascii?Q?IoHByDCmsHZ1DBAJ69jYBfIBpPEsen5BDwLXkalANN/1sSeg6LQ3Za3tdw6V?=
 =?us-ascii?Q?ZzN/vsWKaTVE5saI/hX4xAlDn48vdA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e027521-f06a-45b2-eb0b-08dbc4341294
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 17:13:33.3805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Lv3+eLfRlOCIEMi9gv1qxEAqZhbjFl1kS8nR0BlG8wR1WilHVJSHua3tle/UfXG123CU0pLUlll7XBfFtejug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030131
X-Proofpoint-GUID: 0AwUZvipXCGtrR0up2Edwigy8cppLqQJ
X-Proofpoint-ORIG-GUID: 0AwUZvipXCGtrR0up2Edwigy8cppLqQJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/02/23 17:18, Nhat Pham wrote:
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index de220e3ff8be..74472e911b0a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1902,6 +1902,7 @@ void free_huge_folio(struct folio *folio)
>  				     pages_per_huge_page(h), folio);
>  	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
>  					  pages_per_huge_page(h), folio);
> +	mem_cgroup_uncharge(folio);
>  	if (restore_reserve)
>  		h->resv_huge_pages++;
>  
> @@ -3009,11 +3010,20 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	struct hugepage_subpool *spool = subpool_vma(vma);
>  	struct hstate *h = hstate_vma(vma);
>  	struct folio *folio;
> -	long map_chg, map_commit;
> +	long map_chg, map_commit, nr_pages = pages_per_huge_page(h);
>  	long gbl_chg;
> -	int ret, idx;
> +	int memcg_charge_ret, ret, idx;
>  	struct hugetlb_cgroup *h_cg = NULL;
> +	struct mem_cgroup *memcg;
>  	bool deferred_reserve;
> +	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
> +
> +	memcg = get_mem_cgroup_from_current();
> +	memcg_charge_ret = mem_cgroup_hugetlb_try_charge(memcg, gfp, nr_pages);
> +	if (memcg_charge_ret == -ENOMEM) {
> +		mem_cgroup_put(memcg);
> +		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	idx = hstate_index(h);
>  	/*
> @@ -3022,8 +3032,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	 * code of zero indicates a reservation exists (no change).
>  	 */
>  	map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
> -	if (map_chg < 0)
> +	if (map_chg < 0) {
> +		if (!memcg_charge_ret)
> +			mem_cgroup_cancel_charge(memcg, nr_pages);
> +		mem_cgroup_put(memcg);
>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	/*
>  	 * Processes that did not create the mapping will have no
> @@ -3034,10 +3048,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	 */
>  	if (map_chg || avoid_reserve) {
>  		gbl_chg = hugepage_subpool_get_pages(spool, 1);
> -		if (gbl_chg < 0) {
> -			vma_end_reservation(h, vma, addr);
> -			return ERR_PTR(-ENOSPC);
> -		}
> +		if (gbl_chg < 0)
> +			goto out_end_reservation;
>  
>  		/*
>  		 * Even though there was no reservation in the region/reserve
> @@ -3119,6 +3131,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
>  					pages_per_huge_page(h), folio);
>  	}
> +
> +	if (!memcg_charge_ret)
> +		mem_cgroup_commit_charge(folio, memcg);
> +	mem_cgroup_put(memcg);
> +
>  	return folio;
>  
>  out_uncharge_cgroup:
> @@ -3130,7 +3147,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  out_subpool_put:
>  	if (map_chg || avoid_reserve)
>  		hugepage_subpool_put_pages(spool, 1);
> +out_end_reservation:
>  	vma_end_reservation(h, vma, addr);
> +	if (!memcg_charge_ret)
> +		mem_cgroup_cancel_charge(memcg, nr_pages);
> +	mem_cgroup_put(memcg);
>  	return ERR_PTR(-ENOSPC);
>  }
>  

IIUC, huge page usage is charged in alloc_hugetlb_folio and uncharged in
free_huge_folio.  During migration, huge pages are allocated via
alloc_migrate_hugetlb_folio, not alloc_hugetlb_folio.  So, there is no
charging for the migration target page and we uncharge the source page.
It looks like there will be no charge for the huge page after migration?

If my analysis above is correct, then we may need to be careful about
this accounting.  We may not want both source and target pages to be
charged at the same time.
-- 
Mike Kravetz
