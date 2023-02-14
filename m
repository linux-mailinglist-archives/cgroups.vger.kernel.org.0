Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618F8696CA4
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 19:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjBNSWX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 13:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjBNSWW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 13:22:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5AD8A63;
        Tue, 14 Feb 2023 10:22:20 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EHwqjc016918;
        Tue, 14 Feb 2023 18:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Dro3dOKPHeqN7sL7Zc/rx5HdY277Qb+t6IZXlIvMOe0=;
 b=0bjhV7TaSIAvE81V6WXqyWtlOTypAS08RzJKho8tFAqMN9+JHmu8Oj84ObFNHuGNJhAh
 pmtfxbgZL6/Kc1paIsu9RtszS2QSZ03gNrTzqhBUSIW1XPt9amaXc/JiDHpLojycxD3W
 sxrsnI6oCGeQHlnAzBJH2/ytCmHwyq4HPi/sDM8yXyXQnKEBScicsMC5hzy8wEawC9/5
 p3I3khfs3FMG6OPNnY5qI71iM2sZGDvLwJyBIzMwHf4gt+78JOlL0gwDFIYqgvQVBG67
 1Dz/8PJk48ceNzMe+S/C9n6A5BkAZ6YEstrnXmlK5PTz3g1CPktMq4j4wbc3kXK/fkt7 nQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32ce66h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 18:21:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EIH8Ke013611;
        Tue, 14 Feb 2023 18:21:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f5y9gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 18:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBqultAgjICj+KJhkSy/C3Zc906L4PwBXvD9JNSCDwQ+ZIIRXZltlu95n01b3piMU1NAZAnoNbCuqdT/cNWT6aXfwPwup2sshw2mQOWb++nRgzoQ5wSl0/pZUqBOfBwvuf2LpS3nSQzBKC84xtWxcH+4z6xZ2zRsSrE76K5hm2M8y7HM/P4vDI5gFJpb+4lsdydUi3z1AoMajdGu9sRQlbGAjF+PQniDjdtKtYh8sUQo446EEHekWjs9VV8iKeFboGtt5CShWNAhajVY6tAW0cTZQRe9HGRx2o49Pnipnz1MQtqtQgHe6b0pzE3VJPnrW8tweQF7tHYRbofz4ulhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dro3dOKPHeqN7sL7Zc/rx5HdY277Qb+t6IZXlIvMOe0=;
 b=NsR6L5obKeV6IUzcuJqKlDcD27uNmwg+U68a8du6D7ICfbwiEK3OAAjkG8SBqspK6591Cqs2hRPMgXTFRJeqYuEni4n4knsskcC5h5YbH0z2pScRJcAajD0VAkQ4nAhAgS5cWrfg/q4nMCXie/0ZRZpMKHSwDwgOBLJWQl8J+3q9iC0LN88HiOpmZYyviLJHzX5pCb5iaAwWcHVxVWMnZZvCAJhTmXFuY9cQAMizGGgtcxz1aEY3tOefd0zrpChWRwqo9fy8gj+HpRIUhtfmNPLHAT8YWk5rxVLxww9buXI4JHCAUwwwf0GnRmD/xSzqVFv6oDbw0hDK3ETa6F2UrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dro3dOKPHeqN7sL7Zc/rx5HdY277Qb+t6IZXlIvMOe0=;
 b=V6oftWAtpb6pBVRvlLRtmwfXk4gawBAeAqN7oABxqq8FgEAF17F0dJoLG2XjO2c5BVcnhf/fIqFLF1BXPej2DWK3DhJaP6LdsADqdCmNpWOsCy2r79tpBl7XQ6P/fMEgzuTgBKo0mvZb/dPPdi1aIHX5Tw87rl92kjw8uXhNtvE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB7275.namprd10.prod.outlook.com (2603:10b6:208:3de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Tue, 14 Feb
 2023 18:21:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 18:21:34 +0000
Date:   Tue, 14 Feb 2023 10:21:31 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     SeongJae Park <sj@kernel.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com, david@redhat.com,
        osalvador@suse.de, willy@infradead.org, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mm: hugetlb: change to return bool for
 isolate_hugetlb()
Message-ID: <Y+vRK7kYP0xVZ9Ya@monkey>
References: <20230214180324.71585-1-sj@kernel.org>
 <20230214180708.71645-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214180708.71645-1-sj@kernel.org>
X-ClientProxiedBy: MW4PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:303:dc::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 063c2e74-6880-420e-0248-08db0eb84dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtIxTeYO5AALS5FShsLUc5gKUYZZupyHkrZao270SMBWeAhDuDQOs9ckiZGR7SUOWf5USVQLBpdvsgJa9fkHgII6VxI7q5MjpTIsQ/zy++fvg3OAaDrHNFnHqto4LpLi5vt+rmvAwnGd110FBphm+UY/4ATZjneeTt9vbo3rCLk83zUOobHTyT55zQoTr2O9QCZefdDUuGtbauT6z5K1/eq0dfxjUE2sX2WLEaYNNc8cX1ZRqe8e1iMY31Dd2eX0HW3XUgwuPR9GTE4BdrAQYgXrO6ecO/eVnCJRT3C2MXTs2Fba2XdMJcuGpfcp1kjBZ52wcxuwu7RvM/X19Dba2Oim9A/v9CKRopl5FGua9IE5QqcOXCKHQjul5trCrkeaokZzSVtSpAn6xE9N/DiiSQarKwCmXRmoYiZ4SGZhPMTF9+vvOI1lSeNflTi+2vffXdl4chLm/LVZDrMmXDM6Mph+fcgqykM1KofoSAqDRlR35/cPWbRZEMt/8aCL5ftRtqOngyUhFgPsQYbm3bQSV67GLRL8Q5JCIsTuPQboBSo7fidwQajwSeL58bdC5MYzUAeZjn4hyDETZ3MqRmjWzEBaFV5Cq3e0ZEMZwbYKNZEnDBX5y1tfcEvddSs89WKTlGlMAWwouM5wgR2RPVIeUE9qrDqRGVQoTVb09c+4YJ/F9A/eVlE5qPxfA8jbDSum
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199018)(5660300002)(41300700001)(44832011)(7416002)(2906002)(8676002)(66946007)(66556008)(6916009)(4326008)(66476007)(8936002)(83380400001)(33716001)(316002)(6506007)(53546011)(6486002)(478600001)(26005)(6512007)(9686003)(186003)(6666004)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gsPiIEhOP06coPs04NV/rk+TW6v+/oP1W/t6itl3it2H3dBXKRaGBsS1G9oY?=
 =?us-ascii?Q?zht16VMlj9X+9Nx8wBoto/QYh1nGrFwfVXqWLkPeXnFPqSL7NVfXt3X7fsQw?=
 =?us-ascii?Q?WL1SbqzwPgYjzS1s5f17SJEO+Sh2TRlvR9fd30SDlNPT34KdkKRQTAVxYAkY?=
 =?us-ascii?Q?YbWfkpPtrrOjxRJf4G/vA60pJfcWfCbVopHUFIE0ybDEBkPZGSZ0pvG1oMYP?=
 =?us-ascii?Q?6uv87PJgf5N4as6M0HKX4Bt7XItMXqEr0CmEKKUQ4UYois+95vP0lLY5o4HK?=
 =?us-ascii?Q?uCuQyF8xeF8ypp8Wur+fBMmMWBXl1OlJ/KEbddVVo6on0/qiud4tk0Y/zNu8?=
 =?us-ascii?Q?TjTAzonl5dcsUmvKpjCmjfH5D6fGJrLSrT8/MgQZ8rlCU1Fc4a0OC6SIRkb/?=
 =?us-ascii?Q?a6z8arvMj27l5/R3C5PJyo8hYB9ReUVnUrNjiEIx7r2rZtf1j72gxtOakL6W?=
 =?us-ascii?Q?UkIp4NJKOyaSf91GcoX1/NeXI04o7ZZrA+M45RsAcuWRezzCjJyP7l26dLDx?=
 =?us-ascii?Q?BsDO7GckS0r4jmp45vcyeuoIl97NLJNovScfb6DiVMzLKZgn7nORF+bDGCOE?=
 =?us-ascii?Q?wf5rvAFC6l+KGgoosr/mQItp8u6D6SkvMjwMEpzxvPOVn8ieykPd1FBhBoFJ?=
 =?us-ascii?Q?0s/50reKmhnFdP8pUr+KDy/C0BH/QXkQIssYZTdycvUPOV9r1Y5h7o1JFKIE?=
 =?us-ascii?Q?X8/tyFEomeZ6Zn10PeeyGbytc3z63Y9pZF+atBZ6jOH1zJpfLTCiaubP2DH7?=
 =?us-ascii?Q?GoCjbfzj3ErQKXsOPJsxUZwcr6+ewQpRaGOkB9PJM+kzBXRo88EsfBt4+rvg?=
 =?us-ascii?Q?mll8Zg0a1EKBlVCbDgSWGxsp4TRYIMmOpbsUZEPcIKRMvZdNn5rn/BIxQr5O?=
 =?us-ascii?Q?FCA8hqHtkxStsRfrMoOQwb02Xo8bR7kKZAimhWlU06+A/X87zayp9dZwwhMY?=
 =?us-ascii?Q?OkjvGZ6emUIlsFFMVvIj4VsTAJ5ZhpRqMgCSuASH1zWqMIhkhh35kYMc8aOn?=
 =?us-ascii?Q?fIDWxg/vOMjQmShqIoBdbC8lcb4JdX0TUUKOYrF7FdN4rZGDW13YcJlck+Nm?=
 =?us-ascii?Q?qhONnAntplj4QT9Iy16H+TqI8l5+NE3a56cKXe35sRqJlV07wmzPw8GZMgr3?=
 =?us-ascii?Q?j55kEiUQ8r486jrjTZ4PzIpKT/Ku2jgVEu+Zvj/le9+oQ7cHmrLzRg3r3kY4?=
 =?us-ascii?Q?qJLDeFdRXg8Eo6Yoo3GQIHQsYioXqR2PWaLGpYjfRTS82WUGxBFoVGL80x5d?=
 =?us-ascii?Q?N2bUzEuVO04jIH/fbr4gThYBQM/wUBrzhKAa8KsVLxOTrLl8IIvg8lqlNfFA?=
 =?us-ascii?Q?MRVPjFWCR3c01/b1ayc0a1e4SJmtHBATmaZlWJWazj6CCfkO0PjH2G7AD1Bb?=
 =?us-ascii?Q?r6vbAOk5qADbGcb+kyUyTUsntSDCsEuV4tId0lpUJxrHkiAghmFC0gOUGzOw?=
 =?us-ascii?Q?Cii4sQiz5FPMd1A5gUZMmQG9pPWiG6rpPGQ7fSSuOOPfo4qc44nDRK155HT6?=
 =?us-ascii?Q?2p8HoePe8s3EXA2CYIOyC9cXS9XGoA+Bq8SyWdQsSGgqdMR/zRYEpQo1P1fV?=
 =?us-ascii?Q?sSeBbkg3SQ9SmBiMu/7AKNviMpaf/5e7cXTQSqBfw9QKzIj2mlEBXJjrj5sX?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RFe2z438o4/OAGqonV19CACSi3PwphhHpy2czs+ECkBLBJU7+XPPbtC8Ze2n?=
 =?us-ascii?Q?/Eh26QfukXcbq++ZzlQ5pduvAgvo8VBJBRm0EXPA0y6B1AbyvrIVJkPosui4?=
 =?us-ascii?Q?2+Q3axMXVFqujnGHd8HyiGGaHrWp52Fs2SYP9AxwM9R/SZCasblxq+CfNhFI?=
 =?us-ascii?Q?qIvAPrbqeT2ygDBipYYtVaoiON2gAbHV/VZivaoUn2Am3fUmTGMD5J3Bsbak?=
 =?us-ascii?Q?sFvoAB7ATvDe3e+vF/IPegvi2CKzvkm3mlH/f5mDFi+bsa0cptLldwLArjl5?=
 =?us-ascii?Q?5Kpk8W058R1ucZUh5T0P5/f4EsUcqsyFw3t2gXd9HtW1sONvr8vCN6Ay7ZZr?=
 =?us-ascii?Q?R73/r1N76qLJhFb5K5FZYGED+igTrQplHwZMstPdGDlYfkRVBHBGpwI9Hp4f?=
 =?us-ascii?Q?A6NS+oAnoj42zPUE6FaOsMv59j28Jl4t8iJTcuSAHLGYooib8p5RcUiV5ZWg?=
 =?us-ascii?Q?ARX4DwErwNuWV6wiZCCY8e/d/FLfuyEiE4/jGSG3X2W4aYMXa83lhbRBNvxy?=
 =?us-ascii?Q?cpA/doDc39DF85EOTx1h+/bBGUZW7Yix6sGn+5CCz0X35IdYVWMNC0QwQJfH?=
 =?us-ascii?Q?U1Yngd5pKCZ/dwAEwEj9fj3/ielyTu+xWij2HT/kvsl70JhnriaIvOkicqB+?=
 =?us-ascii?Q?GUErrRJvmjm4X9zrd7ye2d6mmZyegPuTTsXgCfy95JBNUAp7IKrqWA8s9ULI?=
 =?us-ascii?Q?b4RWKTEQ2j5S+fC6cNnFkVfsJs40eMY9fdSSfFVjg9FOHR0CnGeplHPmRLkq?=
 =?us-ascii?Q?ZF9yHyD8z7Lc4lZ4MF+3Ks6JhgA1QQqPCsYYvFSZ9VxRt8T9DCeJFY4Gms0G?=
 =?us-ascii?Q?oEA7B1zCpWQJBEltaRSGTry7/aeNqEk0qaMMZMdzKuaQyqLyHTVVEhyPTQxT?=
 =?us-ascii?Q?oGZv8F9Se4SrPxe+Y2uox4oytYw1Qd4eZ/WOr8WE/8+oLt+/wT/94vbo3TCU?=
 =?us-ascii?Q?7J77BG+6ruoSZlCt4UGG+U10cqWD0jehyburrKpebtIH/xEgWCrgaZNeeMBr?=
 =?us-ascii?Q?kazbWGH/VWtTu5VmgI67K5IkcBsORgO4bMKeTkJgJrmaqY5CgZdhgB5guUZ7?=
 =?us-ascii?Q?PL50EcY59JH08RJRE+Z8TmvxqW+HzpCSlRaganYEkpMWjX2QxEE6Bvzi5N6u?=
 =?us-ascii?Q?jG1K6pTv3M/tHICRIO49Pq2I7od9zR8qMlamsr7ay+oJ1RPJZGF7nqLdTJoh?=
 =?us-ascii?Q?7K6bFxMn/2wp3pQw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063c2e74-6880-420e-0248-08db0eb84dd0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 18:21:34.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFpu2gQjXuJuuhLRTThzaEpCNPVVsXAkt6+A+Pteuxy1VqGtz5nSCBe2RLh58ZpN4epYh/rqT2vV2F6RPWC65Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_13,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302140158
X-Proofpoint-GUID: YpJPd9PD1Vu55G4RzSrP83UKJkVI4Fmh
X-Proofpoint-ORIG-GUID: YpJPd9PD1Vu55G4RzSrP83UKJkVI4Fmh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 02/14/23 18:07, SeongJae Park wrote:
> On Tue, 14 Feb 2023 18:03:24 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Tue, 14 Feb 2023 21:59:31 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > 
> > > Now the isolate_hugetlb() only returns 0 or -EBUSY, and most users did not
> > > care about the negative value, thus we can convert the isolate_hugetlb()
> > > to return a boolean value to make code more clear when checking the
> > > hugetlb isolation state. Moreover converts 2 users which will consider
> > > the negative value returned by isolate_hugetlb().
> > > 
> > > No functional changes intended.
> > > 
> > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > ---
> > >  include/linux/hugetlb.h |  6 +++---
> > >  mm/hugetlb.c            | 12 ++++++++----
> > >  mm/memory-failure.c     |  2 +-
> > >  mm/mempolicy.c          |  2 +-
> > >  mm/migrate.c            |  2 +-
> > >  5 files changed, 14 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > index df6dd624ccfe..5f5e4177b2e0 100644
> [...]
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index 53010a142e7f..c5136fa48638 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -2128,7 +2128,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
> > >  		if (PageHead(page)) {
> > >  			err = isolate_hugetlb(page_folio(page), pagelist);
> > >  			if (!err)
> > > -				err = 1;
> > > +				err = -EBUSY;
> > 
> > Again, I think this is confusing.  'err' is 'bool', not 'int'.
> 
> I mean, 'err' is not 'bool' but 'int', sorry.  See? This confuses me ;)
> 

Yes,
in the case here (and elsewhere) I like David's suggestion of using a separate
bool such as 'isolated' to capture the return value of the isolate function.
Then, the statement:

	err = isolated ? 0 : -EBUSY;

would be pretty clear.
-- 
Mike Kravetz
