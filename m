Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1533698467
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 20:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBOTXG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 14:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBOTXF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 14:23:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A553B659;
        Wed, 15 Feb 2023 11:23:04 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FIiP1G032212;
        Wed, 15 Feb 2023 19:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=EEpLwX60/JUYsEED8iNKv+LKjcqjPsD3OLbefQgmUqQ=;
 b=GCIvsItmPcqX9+8heBxiM177RRqPa2Y7hMIm9ReIPES7dqKr96osoH1TtLNUwf1xMJqR
 yZ3kyLQ1o7hK7jhMj2UoQGcMTeEGyC6L/HJQvjqDrsGSVOXwEzv93TrpOzJzWKbqsucB
 qQAj6PzREcuajPCZaBEq/m6Wt0mF3IICVM0zQGuSLMkiAzk8ixHQT8HgRZgISy0XtUSP
 YVBb1ldQjymdtoXdNKQa6jAghxm1ldwQdG3a39xLD5+oijQzRRJkHh1m9rZIywxuKbGf
 G87mq/TJI4WK2GoWUNlgIXpThkaKJh7j15HdV4nEdMMwkES4POTdClWkZRsnrMZHjRL3 YQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mth7qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 19:22:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31FJJTK0016845;
        Wed, 15 Feb 2023 19:22:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f7ks99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 19:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2T389t2Aqgk4y3qh8El4YYXM9JMKwkZrFA5YMdy78K91YE4ETS8VKQtovBnJyNxGG/VDtPY6w2d1XDdJXUSDDXRUt6OaLDK8BBtAApCK9hYXBgyUB+tjAayHt0awS960Nodlg/7PLJCR5u8kq1jfHeqA620a4z3gNmxPIIT3cWaz9oYRHNI+hP9zs8lz2ZJWG+yRuDUShbTsQ5fbgHjyJ65krnNBUD070l3Y7dA+GNqth93jTbt7RZI+7ynNSKuH+EJQ7bkX+V4CISrMAVfctrm5Qs/Slbwwb7OgNidPRY783qm3yoHSYxMpHhCFg30H5K504I6RuaI+C1RXZhGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEpLwX60/JUYsEED8iNKv+LKjcqjPsD3OLbefQgmUqQ=;
 b=mtX87zMto+/bc8K9JnlI3pakFSB5M69Rgf03R22HyC0uoeChGdLfW/GVMVxxTEq15f940pcscwv3J0ANCkexMSKMP3uaAg62xw14q5ayfVVI3A/wN+CfTRw9WLslQieAddr9na6X3jr3ItV8eGFtxIA4i99wLNc/BD8J3maex49TieClK+Zj5HHSFHiwyu+isLNl7lILk52CfmqmW1NclTOhw133mz4OSEzF5owFnf6juflCi04jEMVtwdipSyD0DKxCtpBCjgT7vwStcI+bXLha66EQCySaInXR6KhMb2kHB6wOO+WBOVxtndUvewvwQ3ebeDhkXggxCAsIpd+Ubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEpLwX60/JUYsEED8iNKv+LKjcqjPsD3OLbefQgmUqQ=;
 b=Y+5QyYDcgey345YioTE7ntLMs6AXlKn+myvQ43JNXEUBXAvJ0yuFCD+xAPJNAC8mWsUJLsDrN/EuN2R815sjVe4rmlRvR2MCPUtZYS8LIOekH10OV7yESDx3c+M+sbH/c2fzDCALTxthPyLvtnB8H+sFA8JV/rmzTUoIYv0ve4I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB7030.namprd10.prod.outlook.com (2603:10b6:806:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 19:22:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6111.010; Wed, 15 Feb 2023
 19:22:14 +0000
Date:   Wed, 15 Feb 2023 11:22:11 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        sj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        willy@infradead.org, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mm: hugetlb: change to return bool for
 isolate_hugetlb()
Message-ID: <Y+0w45eacPb8mgvh@monkey>
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
 <12a287c5bebc13df304387087bbecc6421510849.1676424378.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a287c5bebc13df304387087bbecc6421510849.1676424378.git.baolin.wang@linux.alibaba.com>
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: ceffa215-fdae-471c-ead4-08db0f89f191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7vkn8xgjs5T3Zw88I4u7aJSludZmVdvuSL+F/rhddhiMrXV5SiQ8x1wIcTCHsJcF8OkIcToUoMjASca+NENs6BFeBezeRuEvA0MYtkbPcHBl6YML0wTFBjjyMcOB+qjkbfuWMmcp8Np98VR2bzSM40UWWYFtHNIDKxHyqfl4z5PYBzl1I5Z4TjEXFXR+OqywvL5Z9XyzFKIEzxjJxulLHk/HfaTn3Ws8yFUChvZAyQiQMG/OfetquYpBNrDdr+sKImF5LdeEn8Cdf8pkXWiM6D2T8UWiNlfuCDFJ7bu/dw1oOkhT8eyKiH52yNqOGY+F8bcZLtIwbnHWDK+xcznJBkIMqvMvB6wdf8cGE+5L715kkYiaYCTaQysCBRCP40G2nF9tcxzqCW0FH+CtofR3uQpCFrYojqdUXexWOtXdJhAkROeHnaQxXTEaLr6U+Z2XOvYZU+46g467KWdkEYn8wxHr0tzvO3u+DgnOq2kxzujRhljmqXyeo7oBDEBlL95oL5KbK+4kt/iVxHYwPFmwVW4LyoFd2vveJhojcuAcRkZ643hsfsIyRFPRfMawSNM1dt4Jc37V8kS/L+SQbkl8MbuunCSaWoUMgBxXklV7/PQQNZblMAW3Y+zUMJoTrftvCqxJW/88OraY4t828fjsgILclCTzDv9NnA5OvE3ZMWDWAa2iFTheVKGIeRbAv2+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199018)(44832011)(33716001)(5660300002)(4744005)(41300700001)(8936002)(7416002)(4326008)(6916009)(8676002)(2906002)(66476007)(38100700002)(6486002)(478600001)(86362001)(83380400001)(9686003)(6506007)(6666004)(186003)(26005)(6512007)(53546011)(66556008)(66946007)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d2CCJKAaNlgh85OEvwnRC9BOM2PYnMr8YHWikYSt0DS+g+BBglF9RWhWM3Xt?=
 =?us-ascii?Q?sSpKOMGd1Wu1uSrOV0MaDQjrz8EczBOPzj8adIOHkFi/xxEfZ3PJOJYYdTEg?=
 =?us-ascii?Q?CnhAQPPsIs2rI8K/YfnolrXKnVYJRh5Ye8ghTddQ6xnbng8ADTU8OTIY08BZ?=
 =?us-ascii?Q?72piaTgDfhAU2Os4MQ6SdZXMwyaBh9r8r5+2iRnQJwvt8rvkplPse2ichBg2?=
 =?us-ascii?Q?yaNylYOd2Ba7z9RTE7v8T/4990COO3YJ+0KV1lRSINlPYbIm0EibLi5+Mmgx?=
 =?us-ascii?Q?lSesb01AFg04RCxnsFsW5bih48s7mLF+RnY7lbH0KXFmlCqwPwpFZD6Ct2s+?=
 =?us-ascii?Q?kz55GqHmZlR74WzzNg9H/tfQcNzl2cj0AlUuuJ++QGuiup06GCIrbwbMGb1o?=
 =?us-ascii?Q?JjkI+rgSZdkULG9RSCGKvPSmzaQGOcpP7y3phNNRCTjgr4Oip90fS68C05vP?=
 =?us-ascii?Q?pK1zRoZZERjYes8DEcYJh10OG9blNfQML+jKPRfs8+CmsqimX+9mRAn1/Kti?=
 =?us-ascii?Q?0SJU7Iv7u59N0dM2HMb5ZlSTEiULD7ui7MV8YPgLqQX73FN++y7+axB/YZb/?=
 =?us-ascii?Q?Lla/cPl4KDAtybgHwlsgp1URBD11Y+xoCg17uaP0BuKfPZOd+AIpPCRQMIWr?=
 =?us-ascii?Q?PNpbjgw6Rex2AZmIzoxXiWKfm7ybcxknKXCsVMddrEZ/dsJvf/g+SfmDeD/r?=
 =?us-ascii?Q?Jj1UyhGt9EOpGzImr8kx7yDd7UfCDEj2vutfbN3l68vkhB6gV5XBxvgDRTaW?=
 =?us-ascii?Q?/ukYESR0Xnvh3ZoR+jSmXcgKl1s+sc6VnjYSv+MXDUighWFJYVyoX6itq0zr?=
 =?us-ascii?Q?0bF1CC1xSzkWYztRrN7KTnuObbArgu3XNzdB/5895T7A8qO9iSC/fv6LXFLA?=
 =?us-ascii?Q?asgMgW8n4kJFo0oZ8mUNoRe7JK4UKwgWBOxF9nkzJ37aIffEHlSpBM9qcbkR?=
 =?us-ascii?Q?E7HwpXxMQh3tW+cYJ1b3gleoD0rVnsCSLEBNP5s3UqXz8LRK2U0xrRnjMHJI?=
 =?us-ascii?Q?xXpSD0JQqmNZyp8TN5cF6vF3FyQyScRaz+bztIy9sh0FB/IDifUnnqMpRQHd?=
 =?us-ascii?Q?mCYw/eaQ0BuiKWPbqYtHl318iL4JvJMPAN2mQnih3s8KU4+tdplr6/ZNudos?=
 =?us-ascii?Q?dqomBjsjBnmJwj37KzN8zpl77erWgAoI5NmzwI2gHWEqzrx5ba4U2YMa3uzP?=
 =?us-ascii?Q?G8gLFtaUQgSuSRdOZh2eZy0Cthy0vW64XDQWFYXzxvyQVnSW4K2O2xtLbbs7?=
 =?us-ascii?Q?01zewAPzjrycjPLuTLzhQbO9njletZ36nFVBdiI+tueefQk3t0a0sIoRlh8E?=
 =?us-ascii?Q?Ik8MNdgwVBflolpoPQEZR4b4Twd8+vh8zWgt4X+Fmfn/xFkj5H2gsaTf1F0r?=
 =?us-ascii?Q?S4uJFNtr8ahKzmUgb98rQZRyjemVJaanIzgU/kAsyi5PRP2QMNJHnbGZVpWy?=
 =?us-ascii?Q?iwqAIkP7hdvHab/DV2IuqIWmDPYCcKE5Q2D2A7LjMAtVEXvoWcT7vDcm47sD?=
 =?us-ascii?Q?UnIJv01b2lws2jPw6FdJxB98sMgvkXUyquJbkU8RM3SbqmFoqrnYgknqsuLZ?=
 =?us-ascii?Q?3GfTNR63FpE0vZIfURffsbb89yzApQBo/vjD/UiSzfWTAc0ID6THJ1fv4x/L?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EXkuPBNSoVdGh/iYPDmInPla7XjXImCTzh3i9LXNW6WGgZWJVbdflMTY3C4d?=
 =?us-ascii?Q?TLsmUSouCS6XU5OZYlRAxBS1pDo0D+mUWQe7KZa0T4NzNXXevWLGd0LWNzxa?=
 =?us-ascii?Q?NcU/d7t/Svrf9ptOUS1kIPt40M4n0ojOg+F0hGYCGjJJ6u1+ws7AXVHWkQtq?=
 =?us-ascii?Q?2p0uvuvuxIoDstNjkTsTvY1ojSYp4gyQ2oEKWYRDmbobFpY+haU6XuvRtZ9W?=
 =?us-ascii?Q?IVUFurGxc4jQiQxQRsFAxeWYcPWTUckYWBoQd4awZB/XvXW+ueIY6Mdmuuw0?=
 =?us-ascii?Q?0KFc5GJDztZVDAAnfpB9PvL+QttR44uKlV6Az2dla8FNUc2ew/lESw5HGov5?=
 =?us-ascii?Q?wTkQZgV8Qcr4sQGdsVXh/bBxP0UCk30kZcEvbA2jBM/OOPZNYeJKsVc9xSow?=
 =?us-ascii?Q?+PFE1lBLQZK7rzBLGzVxRN4STzoP1xEPeAcoIjEeOz/iUUDSYYJaqksk/5XQ?=
 =?us-ascii?Q?O1HoThi2LdhQTJiuQJ/75ixeLFqKA4fi7DSizOZR92hcNMftm5HPLzKyrDQn?=
 =?us-ascii?Q?izLHl5mtTC2gNqIvDg98Elq7hll6eycAnOIOWVR9Hoh8/HT0a4Cb5Z4EyJSA?=
 =?us-ascii?Q?2rgNmdq35ztk+cn1FWS6Y95onJqr9di3lozDrtfTDsAh+bqEXgDVns9cVwdx?=
 =?us-ascii?Q?tfzHAFqiUPT88sfOylhoUSXfZJ6KPA88/fANJ4uygZrBlT80j5XLF1bzYvBM?=
 =?us-ascii?Q?GxUZAxhjhrQSUOFEgNwTAMw2dm9Ve8REvbrAZlErBVvGoPcC8ctAKlmZ4K9x?=
 =?us-ascii?Q?jUYafULXMeWSYHJfvv44Vnp4snCEDBrf2ACHTzxj0liePbYbzxkDMDDB7FA5?=
 =?us-ascii?Q?bJLLiolPQJD5ZeabzGJZvhTFtWyiupnfq/FUyg0YR1n7+WaHnIzk75tGabUe?=
 =?us-ascii?Q?gLuulD6S4amegIa3C4UHWrneVN8kkiimoMHN52HDikyP9TqGlDk9WKQAYmyn?=
 =?us-ascii?Q?zLiXXKmNzxSaaMPkhMpT5xJ0FzmSHoprXoE1pnN38g3ADAD6T6FKj8oFX1iD?=
 =?us-ascii?Q?PcS4rwNPDXkJXrF0Or7SEXm2whAeI9YHnbJ3u/o1/kJYKrxC4BvtUKG6Y78M?=
 =?us-ascii?Q?rsdR/RB2cUXSJ/chPWrLZrKLWxTHjYYm0Cb/Lpe90IG2Vva1fZE0fx0EO/XY?=
 =?us-ascii?Q?rt3gkWBpgELWUCT6E1vGeDWwfVvRIhcqiAKAO72RLRY2atlRP/8iBatfLyk6?=
 =?us-ascii?Q?fDWtAG3v5W5CfZyO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceffa215-fdae-471c-ead4-08db0f89f191
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 19:22:14.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36OyGTLOX1q8saBDYJjDfpnAdpa1790LZIQg1VEryrWBL4HYzcL/eIyWO8CPSJdmBUmXdFZPBDcD2JvMuYNkug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_10,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150171
X-Proofpoint-GUID: dXyAGSgFGGaJOXtwmN_W4GayKuySB0oO
X-Proofpoint-ORIG-GUID: dXyAGSgFGGaJOXtwmN_W4GayKuySB0oO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 02/15/23 18:39, Baolin Wang wrote:
> Now the isolate_hugetlb() only returns 0 or -EBUSY, and most users did not
> care about the negative value, thus we can convert the isolate_hugetlb()
> to return a boolean value to make code more clear when checking the
> hugetlb isolation state. Moreover converts 2 users which will consider
> the negative value returned by isolate_hugetlb().
> 
> No functional changes intended.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/hugetlb.h |  6 +++---
>  mm/hugetlb.c            | 13 ++++++++-----
>  mm/memory-failure.c     |  2 +-
>  mm/mempolicy.c          |  2 +-
>  mm/migrate.c            |  7 +++----
>  5 files changed, 16 insertions(+), 14 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
