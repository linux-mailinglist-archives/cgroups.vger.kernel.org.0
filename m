Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C957B4A55
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 01:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjJAX2V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 1 Oct 2023 19:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJAX2U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 1 Oct 2023 19:28:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B74CE;
        Sun,  1 Oct 2023 16:28:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 391MvSPW004704;
        Sun, 1 Oct 2023 23:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=tnzrdv23d/GJrCz089sOwSIBVSaNc/aYCc1JP9HFaBg=;
 b=IWaOgnaMEv/0OVhKo2QcQjF3Ivy6PMm5nljcEI1kG7AwAnmRZHHeROhQlEF36BQzlPSP
 X7tUBQdIW9AfcHU0uwfIGJWBkAJwrbMnUf+HoJ60Gwt/SJTraC6EkmK7323AutuDq6Ve
 CZM5aGvhXK+uGedUfeAoyXaQB3zQ1JLcb+HzlfymaisrmgwmSQyTrALpVqYk9AfRziBs
 olK7AgbUscm37QnUzflCBOxqhuckRIaHtbH2kR8uO2XltU53YRH7FQdhiRr/wR6t53wr
 21Nr027sWzHZ2h/3lbpHg56fdZOE5xcsP/YaBnpyXiBY3iKrnJe6RBGmo+p/er+h1Q3Q Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf41kss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Oct 2023 23:27:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 391LBCmB011603;
        Sun, 1 Oct 2023 23:27:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea43wxc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Oct 2023 23:27:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxZDwWe5B4mYO10agGm++Y80gut8C0nLyu7ZDFFhzhV5C5Rs19uyzE4826hdVq/xw3ti4YwrguDc3+WbYSlFuXYqHyd/H6tx2k7Ss9O9DmQ+G9uXfEEMmZIf23mPXiQ+CVD5sGGZvxTfRHtgTOhD1mKDeLTWxoDd/lJkaX+wAe23s5WSDHemf/acqQ55PWoH19d9jaR9u1H8ndW8V3gLGr1tXUQOAkEdeoQ2eNdAHqJUr9YxeESRktjwj+nuNNZXsU75CAfVdmakOVc3qorgeSd8RZ+NMXDjZGThLoNYvPpPTligQaBZG2cYSsjVaRcHr9Q/8WdJYFEVb5A/KoE3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnzrdv23d/GJrCz089sOwSIBVSaNc/aYCc1JP9HFaBg=;
 b=fxOm9878sWRA/bFqh8GOVKIURFhDIPSNS1+wrSWnhmE0KroaoaZpzoaw+JI6IU18MX/4utelftKDW7+Cy3mowfAKqiGuK/T0sMGvXAYmoeha5v2y2m6I4sPe5OSvAv6OoLDNVKIXhO7hf5yGxED6YzGjfN2QknuOI5n8zlTHO45EBHntXjJmZwUSNnos3vZd7XhTq3xHR223maY8u3AFPV3nPS9ESdS85qMSaif/jaGODt9L6qK/43MQbxxveHQO31NKuKP07wtzyC8t6wK+jPbEITtxo+hDUVV+rykDskcmBH0KzgouwyF2UkdhTKJDveXA11Zayll6m/pYVXNKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnzrdv23d/GJrCz089sOwSIBVSaNc/aYCc1JP9HFaBg=;
 b=T/bBpxLQQmc9+4s4HKzwW3XYBuWWGRmbOgwZT+eyJqLWkyahujlS109nrYHdyfUK8qwZjOllEs0P3NEW78wveKFPRjiT4GKDfImE6L4ns75RvS6yKRkDTsdnTLosr9HDemZCefmRTWAVSkC3T0O/GlfR2p/7/sJ55D2RpDFJUx4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5062.namprd10.prod.outlook.com (2603:10b6:408:12c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 23:27:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf%6]) with mapi id 15.20.6838.030; Sun, 1 Oct 2023
 23:27:34 +0000
Date:   Sun, 1 Oct 2023 16:27:30 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, riel@surriel.com,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, yosryahmed@google.com, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <20231001232730.GA11194@monkey>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
 <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
 <20230927184738.GC365513@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927184738.GC365513@cmpxchg.org>
X-ClientProxiedBy: MW4PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:303:b7::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: 67396643-35f7-41db-db06-08dbc2d5fd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44UJ9lAnKXEh968hZjNRlQdMlx3yNTh5QxszsGrtokpECpqVXfW9lLGtfXVvk/pHTGu/KyTq4mGc5/IK7o8ykk6YdCQsoKLePUAYonklI2xr2ShFXCZ1edGdk9INVIAXP62E42IVkp/PwTkcRTmHsfhcT9GrjO0sCXFeDox+trux0Xkf96OrUxa9dxwi8Ibt7JJgR+miAQwOY80kQggK++oxhfvA4CCbRHMkHsyvKIVLIjCr7I2Nwo6+IT4hFvJQBIKnA/fjcIp5QP2uUlcqHLv+okDhTYirz9t6qB1AiirVAc7mA3nVFo38+ArsD4OzK8jY/u3//7AT7iwM/5rCw+ZomC/Ts7vWx54Y0SLwZUIVfUT9WLOqWop7FZXkza2xRGrqr09m0abZEp4NklUZshhuKIuj/dw7xVJKIccHNQUvKl50hS0yHJoLy3IUhRA2WWK/J3iyiccLK3NPM7Ppif/tT8GvI5mU79IYc+Js1KGL1TUn8K5X4oimOlOVhIPNC5xEaansRaVoSRG2FbBXxSBaxNB5pFdobCSAoPtTEQPde8oxsn+Besn0i/QcFLiQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66556008)(66476007)(66946007)(2906002)(4326008)(8676002)(8936002)(6916009)(5660300002)(44832011)(316002)(54906003)(41300700001)(6486002)(9686003)(6512007)(478600001)(6666004)(7416002)(53546011)(6506007)(26005)(33716001)(1076003)(83380400001)(38100700002)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fhmxk9jxxNAZl7NvrO9S2tTUIu8cCpyxp7ZEENN92xdy7UX9oqBMEziSWoym?=
 =?us-ascii?Q?1aqkJ8Rse8q/ajsYRVfMIfT9B6WQoQlv1MOycYc7Xx6mNvZX6vnTavvcoKJz?=
 =?us-ascii?Q?x4+YGC7Tbwj5P5Uxvh81QCGrtOXVIHchUtSMKkdNRvv4h92bZyj729LXP+Cj?=
 =?us-ascii?Q?MyVhZfiUtyGfVQTwzSdNMqMy0QYsqptvy4lY8HXNLnbiA3VCDzucWQPJ1Lsl?=
 =?us-ascii?Q?yih1QwEV/XPoKip/SFMLnw6huy9ebLdjULQi0oti5hwWgUCrrNcLvbaib353?=
 =?us-ascii?Q?uLkocPaYmvRSrS0/dwNxtKObvT2rjLrbhhGJRzHXTsHEO5jw6SLKd5FYv872?=
 =?us-ascii?Q?sZ9bFv9q4GkhtO94avru4a1CWox03oNYmnD6E9odVEipKrjTyfOcV7p743zp?=
 =?us-ascii?Q?e/nbQ4TqbETyGPp0i50CfJTV1IDIxtu6murVyLAkBrVjDVO30Dz1o95PBYwJ?=
 =?us-ascii?Q?y/ijEWnl1IhXRhkhkoB51b2WRo8U+Gk2kay3rLiSlSYCGUGCKBM/VEkABBPl?=
 =?us-ascii?Q?zRqEkbPzAF3Vd5PMFa+6sEDFRakeV/y2vwp/pv5SEC2C3W5A8gcfUUWibwty?=
 =?us-ascii?Q?3uVia6UUkFTVtaNaL52rqKbL+f+WM37c2dNSWSzGxh+Xaf/dEzJ1PiNapcS9?=
 =?us-ascii?Q?zFGLFxjEmg4uA70Z4R8cKxBm9pJXhg9cBMeNQLY5ppSfBT0CEheGRGuTQGIX?=
 =?us-ascii?Q?DENGLcGyl+3NDX3qNY+XQYz6ykUc9h+XiWjr7aEGrhzgoNIGbzzSHj6lwdUK?=
 =?us-ascii?Q?JEAu23EunU85VzL5a6V8X4b0IHzOU4fI1aen18yDa63rRZ+hP3BBvz2+Bwp7?=
 =?us-ascii?Q?xGGo++qX91YHhiRdktae1e4X905kqK7QhLSv2vZcExUdduG0uGXWFvqvq/oq?=
 =?us-ascii?Q?zzhmV3kl/Tj51yW2D/5Z6vjnku9sxhoJ90wADYNLlJH5FbGNpxgBLXZei78h?=
 =?us-ascii?Q?MI12nonmzlJdb9GzI4K0dPalXqU+5aSq6rl4Ac/YXeTqtWG9ktr3vUqs7qyf?=
 =?us-ascii?Q?PurACNc/z8ERkZmr/d+0WLW2a0vRd6ZnpxM2qdJ/eQ62KdSO2DXyHIRCA+pV?=
 =?us-ascii?Q?jsOVkMdjvnrAcxZv0GE6nqPCdAHZCXctnZyKMcn428qakyrrJ3WIbp5fGxDS?=
 =?us-ascii?Q?pIQNmVvPkx7w2mJ6yWbmk/53YM/fuVt4FDfn8gt7hRkpYwG12aK3Iyct96Fm?=
 =?us-ascii?Q?x1IuG6tz0EjEfcbEkrS/l0QbUx7nhzR3x0XKmyZLpmhquei1JHgOyKrzqd9K?=
 =?us-ascii?Q?jTIdghVXu3UqZSYD5A+xgC2kfNAeDvqt336EQNeZVbegaPi7yi5oG4OZJY+n?=
 =?us-ascii?Q?+3PynlZE3p3Ks7qEMxNXo03o3WVGIKxg2fBU9M73uwDwbjR42rMxAxlOeD4n?=
 =?us-ascii?Q?lMXEbpVo/i9g/gY+oIXbdilnfpR6i/7t1OIRST++TT/DI55Y5nKBFZZqx2Cv?=
 =?us-ascii?Q?vkIQB9wYLbzuCl6mmTm0Fbmx8Oj1KB4bIN1iBTFsz0c4fycPhUxdYbVVn53X?=
 =?us-ascii?Q?jnKlNfQQjb35Ln+otlmQHivofOTdVypv95AOnE1nMaOCWKLkhTuQAnRCBFMd?=
 =?us-ascii?Q?KMY8exqWWQQhOcvQyCXM5HRFrsAE843DRIlhCmBk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xYguQwKkIcSVgPcDsFWqev97uygRm6CITSggG1HUx6hvn0HqrbE/Kwmsa1Bv?=
 =?us-ascii?Q?mp6IgWdgFT4Gwe35t+x2bcSYZrG9ZsiIfEpYX2W8M1sbJWXiZ5RkiInUBuVE?=
 =?us-ascii?Q?TxLVd/VrTeDg7Zx7wZTyNXMtOBb79rGGQvQhR6VYSCLTf72JwX9f3PgR83wB?=
 =?us-ascii?Q?fZNI272uMRUARWSUJIlLsCI742CDQHwDWbKCaEDhsozlJHZQFEZUq5Yaxz5R?=
 =?us-ascii?Q?PPijtvDfcK0FOVNI57ux5KKquIFBoRKLcf8V5pLY7mPQQfnT0JAUF+1dIR3j?=
 =?us-ascii?Q?Orb0Owyb6EJz1I2xG65Xm3ckE0oTD+IPF0xSy/6qwy+z6XdM3QJHU8fotQW2?=
 =?us-ascii?Q?539P66fUp2og48C9T3v/XTFvnHdUsMLgo94Sh5KtwY7/Al9NJ4RCKT5CkwsZ?=
 =?us-ascii?Q?WJr3wyQnXxL/Tda+g0uzoPfGnoHUZPHyztWJova00VpnzZalHyxTDLDe1JOR?=
 =?us-ascii?Q?sLtlOY0X3aY2aVe4UjRJqZe8nSfAnSCRrD9+/d7G+cCzMDEI2sg3oTabhfy1?=
 =?us-ascii?Q?OF1AKioj7t86kRmeFDZoOSigbWDQglD9oxEdPFP/QLIjcm8zxhsjQ+qfXK80?=
 =?us-ascii?Q?fV6m+t8HtcSrQblNVwddTeLODL5pAufy1kbbFV0ywjDgShZ/qe3agSPmUYT0?=
 =?us-ascii?Q?r5XT7A9LyDIrwB1X38nCgZWPBRRoXttV13r6ghop+hqde/jdxF77G8Bc5iAb?=
 =?us-ascii?Q?e0T3LM5+LP1FOyuiVBPwUOgkh8LpSzUXDjZZMeRw3CdNa2ssZead30bPzaBy?=
 =?us-ascii?Q?RbD0iQSz14Q5t35ZqVYBBoxzPebv8CV/glecFcmmMaE4qgYI0i/9ukasCW59?=
 =?us-ascii?Q?2Dm6dWYCnFwRYthNrKwDdtqz0CsDKknGu8Pmr5bFzr1EVQKsVkb4bCnJamfM?=
 =?us-ascii?Q?46xesLB9ii9gmypFb1qS06BDjLXmyM8kvwR/7oN1DfFWlCMN5nOFJOSq1uMb?=
 =?us-ascii?Q?/oJ+5ROp7w6TckpXUiNjoaQcwKUlr5bqDGzcegjkmOlSKxZ9cqk/TaRshv8v?=
 =?us-ascii?Q?+OnGaiMLpx+S6yPTEIrhhFXtZFl/jB+LHj1jcXTMLoIBikfonLsdBkHYDpNy?=
 =?us-ascii?Q?MK0bGx6eO21daFtNqAnppLbkVFEhXxizoYvfR1+SRP0i6vsv590=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67396643-35f7-41db-db06-08dbc2d5fd99
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 23:27:34.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g180/pVcD/Nq9Et86F+JCIGy+80jjRLJXy7wvVxRnDllWb+ygwTuR2Wpbn73KlGBamVH9sErUCZgoEtrFSd9Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-01_21,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=706 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310010188
X-Proofpoint-GUID: cHiiP0DFMg_Hq3l_cXFHczg298Ddybq7
X-Proofpoint-ORIG-GUID: cHiiP0DFMg_Hq3l_cXFHczg298Ddybq7
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 09/27/23 14:47, Johannes Weiner wrote:
> On Wed, Sep 27, 2023 at 01:21:20PM +0200, Michal Hocko wrote:
> > On Tue 26-09-23 12:49:47, Nhat Pham wrote:
> 
> So that if you use 80% hugetlb, the other memory is forced to stay in
> the remaining 20%, or it OOMs; and that if you don't use hugetlb, the
> group is still allowed to use the full 100% of its host memory
> allowance, without requiring some outside agent continuously
> monitoring and adjusting the container limits.

Jumping in late here as I was traveling last week.  In addition, I want
to state my limited cgroup knowledge up front.

I was thinking of your scenario above a little differently.  Suppose a
group is up and running at almost 100% memory usage.  However, the majority
of that memory is reclaimable.  Now, someone wants to allocate a 2M hugetlb
page.  There is not 2MB free, but we could easily reclaim 2MB to make room
for the hugetlb page.  I may be missing something, but I do not see how that
is going to happen.  It seems like we would really want that behavior.
-- 
Mike Kravetz
