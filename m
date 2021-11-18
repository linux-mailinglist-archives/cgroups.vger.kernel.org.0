Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54B45518A
	for <lists+cgroups@lfdr.de>; Thu, 18 Nov 2021 01:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbhKRAQP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Nov 2021 19:16:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13464 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241818AbhKRAQN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Nov 2021 19:16:13 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHMWSr7013697;
        Thu, 18 Nov 2021 00:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rorM2zXxQd3+OmY4f8e7ideAQCMEkWoCzR2pbkmtGWk=;
 b=fnU7bhKuPI3Rl4xKEYT1JyZGEimfDcvs7JVKUEBO+b1y+jyIaTkIwG+UaZeTkb9hTOeE
 5J+2Zjki6mVgAHRmaT+I6NyAS0DEjDzXkhbtYbtQ1rmB6kyvBmsnW3jG2lBkZ+c0Cnjo
 HTJZp/7r4zsIH1LHjpdX/sTpqn6aLJLry7jJe3WLpe8RY2MrZVLnF/M+XdlcGtGldfy6
 JWA/A5tBsIYJrlyyFieKcNhv64PWFEz7MmjL7iE5PlK+3rwUUIGfqLSgxeuhG6j9ZPYL
 DVRtxIN98ia/ithi4uLO+Bg3IfWM7xZA5RL6/1Z+e7Up9iCGbzIqtM4eDvp3Utcbqexp xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd2ajkp9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 00:12:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AI06Uaf061619;
        Thu, 18 Nov 2021 00:12:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3030.oracle.com with ESMTP id 3ccccqw62q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 00:12:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMuGsqezVyrLz4jwf3TEEbXrTiu8EEtsFAsNcPzBj+o1VhDYtOcCKvksWC+UN2yyAmRBgB0Zt/HOM8L3wA8jyVBKfZMbyNy7xmhQhqERsoqp+C7ATn9y9hqQhH78FIFbL0hd8b+0FjwL7OH9BEYmAN0BdBf2Tjze+nDUbN9CcvNpfmxhMeK8C7LYX73V6iNdYR0urgdq8HgNmTO4GVPdzmAQel5cqRsWTjz+/oBP3G2SuZHtK3inHSo1r09RVGMRf2ysz/3Jf79WN3fiWmHmCfoSJe9WpUGq2gUla9ZiiNSHJUpoM1VZmMs7hpk2TI2HNUc+oKgUPz08v+39u4iMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rorM2zXxQd3+OmY4f8e7ideAQCMEkWoCzR2pbkmtGWk=;
 b=HuE0nK5jEgtbRoTRo7To18PsN49trEusudLKBboTViBUp8meSfTElgKJYKKVLtYIYV9/FQfELMBRcUqMLcqVl+VyEVxSAzejC5vAWxRoKUrQ0RWF0unl7J0hNbgT/tYyYCVSEzREKktS8beLeJPOCnl3kwMUHmJLf068CNQ9uBn/GtfBuYZSQPtieOFFDhN19mzH4yVShZXqtafURyABlSOAMcwebdddz43zo6kAGdUwroQDN7eGoCh1AI5MJGZWt7U30RuaqHoouOr6Yt0Z30lv5qRNhFB/TUEhWD4P+uxlul9SEQES+H/FnpCXgrRcopKrZxMLhZgd4DTadsGK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rorM2zXxQd3+OmY4f8e7ideAQCMEkWoCzR2pbkmtGWk=;
 b=QeTmKlEg3dXR/G4BAWrBEba6BnWtOX71tuBDg8KBHgdL4swnUAQaXktYiuZloY6u8Y7nNjprYNWOOfNUUkjP0lQUxvsRaz6z4Nq8fqSEnvuBjZy9vZ0KxQzD0o7jjiWZlD2NDQMJ3zO7kLgmmChB93NEyV5h0MO8vBAjldz5nxw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3542.namprd10.prod.outlook.com (2603:10b6:a03:11a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 00:12:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.021; Thu, 18 Nov 2021
 00:12:52 +0000
Message-ID: <86d3ba7a-3706-d66c-cbf7-d2c39ad2cd4c@oracle.com>
Date:   Wed, 17 Nov 2021 16:12:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v7] hugetlb: Add hugetlb.*.numa_stat file
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
References: <20211117201825.429650-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20211117201825.429650-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:104:6::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by CO2PR04CA0103.namprd04.prod.outlook.com (2603:10b6:104:6::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Thu, 18 Nov 2021 00:12:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65895c45-e52e-4a86-0817-08d9aa282998
X-MS-TrafficTypeDiagnostic: BYAPR10MB3542:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3542E290D5B17CEAE2E14945E29B9@BYAPR10MB3542.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEJ8WR1gaU9XMOibI2cX030AgXWTNwUi1sOFAdlBorZXBZhdnpmQS0Ia4fbGcnxyaBgH6VRV79Vc+7TTAaGadxwOdHhbZBkG1leekxJUSQL2Aun1jYjOtdwNcJPNeHYjf7DZWy9XOzr2cK+9EkP0wiPLjYZdQbkuEmaItQWrXt8ZxxpHdoTeoHZmwZc5oEzWNmhcIDruWErl1LMsCKBBW4MbHwmDS/NIoq3kWvqjS6gr3xaw2lq6gEqV69DA4rz6XwaZcdUeb7Gx02LkTlmBEmiX8gv2xLVzUvJb249YjHyjZiZar3L+dnIenwxcupHBVDZny2NFguL6TFvBngJk4iaRJnDMFD8zHIaqeQXL3ywXVXS7O1fAV8UszKWRVfCyO1qA4kge+Zrz2nbmysMn8BuOkK/CFrCt2Cs++JRkh7DEEanpBY9dSgP/gFBRouHpIjf8wcaym0srrfpjeO4EMdp5ELcjsWu0zAX2+H4xFbgFq7aktq6td/0hAbk4LZu5sFYkDiL+1Yueg2lCnPx/VGesOmVaHlCDaiJXhXErpkL1M04xESkDPl8Cc1T2vtfrmVcum+14pNDn+Gvd0EDmKzkm2913jZrLF5SoriRWBHuZL+Q+MLHY9XzOLl6mJYbWmGL47pmo2b4oBhhfKz8yCDQQEagzEKUxf4yN2Cb5ZSjGvH2n+fU9vrFDu/e+C/nVX/MZyRwYVvsNbJzGFX+vHItEBKDow9vnrSuHjTq11nprlZXqSknQNrswSe/tAmD2wjhY/20EwBCEqtW2gDktVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(31696002)(66556008)(26005)(956004)(83380400001)(316002)(66476007)(66946007)(53546011)(52116002)(54906003)(7416002)(186003)(44832011)(8936002)(38100700002)(2616005)(16576012)(4326008)(31686004)(8676002)(110136005)(36756003)(2906002)(508600001)(5660300002)(6486002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUh6L0tFSlMzVEl6NFJ5NFJiVGhhWG5jTU9KQVFWQ0Z5Z1p5RCtxbkhDNitC?=
 =?utf-8?B?cklFTEpPclBQczduRTFQa1FwRjY4a0o4eitwNGRLMGcxSDlUd2Y2WnF4ZXhO?=
 =?utf-8?B?dXcyTHVoeDRLNWtxV2xCNlczQ0R4aHFyZGI2STRWU2pGQ29kd3JxVkZ0Yy9n?=
 =?utf-8?B?VG5IeCtxMVRSdVRBd0krKzlMWFkxQ0ZZVks0Z25uVURnUkZoNURpckhXV21E?=
 =?utf-8?B?VnhYMVcvcmJzSWZCck1LOXNkeUJnSWNVeFVxN253RytQbFBHVGtFL29ZbCtu?=
 =?utf-8?B?L3V3cFlJenlqN2dtRkFTeXVBZGw4UkJ4cU5SbFVET1dXTGVsWU0wb0pvOEI4?=
 =?utf-8?B?Q1VGQ24rcEhUMEdESWpsY1plUTJPZE5IQXN2aFEvWmwwL1kyTy9wc0QrU2Zk?=
 =?utf-8?B?Q0FaNmdEV1lVem5ybVlOMUNkZS9wZjJ3UFlIckY5Zjg2Nk0yYk5mUktUVHds?=
 =?utf-8?B?eXRiZEFsakNHblJ2V2hjeUJlMUZodFk3K2wzMEFwS3pIeFpSWmthUDRnQjFT?=
 =?utf-8?B?M1VQUzNZWjRqMC9xcisxSzVLYk9RWE9naHZwZk5DVEUvNWVldktqU0NkcFd6?=
 =?utf-8?B?aWphZkxQOGhDT2hFbnhCYVpXZytRN2NIcWc4VUJacDdOVjcydmhJZEVueWY2?=
 =?utf-8?B?RG9yWjR6bytpRDR6QTkyd0VScnlGUnAxS3pLdjRSM0tzWUswb28vbkJGdURk?=
 =?utf-8?B?eXFRUmxEamtmUVNLK3o2Y3hXWTdQbW54WXFiamwvdC9za3pJUStMYzhwRXhk?=
 =?utf-8?B?N3NJOUtLaWpPalV0NUo5NGkrUFU0dDNQSlVyNHVmN1U0a3NwL0IrbUExYTlj?=
 =?utf-8?B?ZE8wUDRIZ0dpb2FHS0hSMHNreEU2bXhnNVFxZytvQThIMnlVQWgwR0tBbVVE?=
 =?utf-8?B?ejV3ZG5jMkVOQmlhRDBNVVRreWlueHRLeGcwZlNaa3hrWTFORWtSRUpCQ1A4?=
 =?utf-8?B?dC9GK1Y3M3Rld3ZQNENnT21EWU91c1g5cVNrUHk1L01ZQ1owNDVOMUpsTENs?=
 =?utf-8?B?Ukw3Y29NMVg0a0JibjFrUENXT082aG5vTE1jUXNRZFZGb1crMzAwdEJhUEpY?=
 =?utf-8?B?d3FnT0RKMTZhZXlUb0NBVnRwVVN3SXorb09uUnFqLzR6R0JRZmp2eDZrU1VQ?=
 =?utf-8?B?Tm81eWN5VHZEWnk4TzA4V0hMQWJzdkc4VGpIVkI0blhKU2szWHl3aXB6UXlS?=
 =?utf-8?B?ZVpjeDRBV0NNZ2xtNDRYMmFsdTZTR0QvY3FCWHgyNGdRL0NLTUVLYUgyZTg1?=
 =?utf-8?B?Nk1MOStiVnFocjJ4YUgxbHBCd3UxaTNub3RYTG56LzQxbmE1eis0cEluWEd6?=
 =?utf-8?B?TEQ2M1pNZXd0STllQysvT3dlbE1SMkpmY3o0OHcraHZkbGZWSlA3T2FsaHNt?=
 =?utf-8?B?Q1p0dlZka1lwTXJjM1pad3k4TVByZk5DQ3JSRmtRY1pPbmYwMFhjVkVZZklI?=
 =?utf-8?B?U3hNcnlKM2RvbG8wR2R2cVJrY3BQNFRvZVZHVXh6VEM2eDZld0l3NVBvaFFX?=
 =?utf-8?B?TjNtRDkzbGhHZVR3enErVlZMeld0aTA3MGRJVWlzSWtNMU1ubWZmZFlud2ho?=
 =?utf-8?B?bnlkditzL0ZBZlQ2cFZTTC9HQUFsT2pOOUw5c0VYdHI4ajNsQ2lFaDcwb0tp?=
 =?utf-8?B?WForays2VjlaeGI3SFF2ZWorNW9vUHFLKzJkTkEybWh0ZlJSMFAxWlEvU2t4?=
 =?utf-8?B?ZFBzd2wzcDNUQjg1cVoyTko0bVQ3dzBwTUJBbjROdVRmUG5xTUF4WHF6NjJ1?=
 =?utf-8?B?WlNDd0c2YjBMdjI3TGFvVUNQOGtudGJlSE9HR3BRODJlTkdhbFZBY1h2Sngy?=
 =?utf-8?B?bW5oNjBCaldvM3pQc1l1N09HUml0MTMrNmt6K2tRSmEwTk1BSzNDNlhMU1RD?=
 =?utf-8?B?SWJLRDBzcmcxRy9tRDRLRXE1VDcxTmwwT3NmMlQ1OFdDZVIxdVRuaUpOVFgz?=
 =?utf-8?B?SHJ3QlVmNGVJbEEvTzI1NElyTUp1bFRGV0lnKzhwM0ZEQlhocE5YaGtUT0V4?=
 =?utf-8?B?eVlGejVoTUxpSWdibFMwWmFVZm9vNFcrQThkNXhoMFJ2YnZzNWhJWmYvZE9a?=
 =?utf-8?B?dHF3RFVCY3pldFBYakdWVnVzZnFEbVdLNVJTVFpuaXJrcms3dnBYenBOSzJG?=
 =?utf-8?B?Wk1hMGZCZndqa25NcmJoeWRlVHl5SVdKMDZKZ1pjTGlIV0RDUVA3ZXFxYkd1?=
 =?utf-8?Q?5ELW4zt2wLkpOqDXPfzCoqg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65895c45-e52e-4a86-0817-08d9aa282998
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 00:12:52.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWshhZEnDACdLm/+vC8lKJz0pNqxb8BE620fcSN87f5GSDxSdEjAHKTn0YSRy9Yv1trT8RwhUU+w31NEFkbFNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3542
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170113
X-Proofpoint-GUID: CWsCO6Von24_srqKJxogL79nFRPAxznE
X-Proofpoint-ORIG-GUID: CWsCO6Von24_srqKJxogL79nFRPAxznE
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/17/21 12:18, Mina Almasry wrote:
...
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
...
> @@ -288,11 +317,21 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
>  					   struct hugetlb_cgroup *h_cg,
>  					   struct page *page, bool rsvd)
>  {
> +	unsigned long *usage;
> +

I assume the use of a pointer is just to make the following WRITE_ONCE
look better?  I prefer the suggestion by Muchun:

unsigned long usage = h_cg->nodeinfo[page_to_nid(page)]->usage[idx];

usage += nr_pages;
WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx], usage);

I had to think for just a second 'why are we using/passing a pointer?'.
Not insisting we use Muchun's suggestion, it just caused me to think
a little more than necessary.

In any case, I would move the variable usage inside the
'if (!rsvd)' block.

>  	if (hugetlb_cgroup_disabled() || !h_cg)
>  		return;
> 
>  	__set_hugetlb_cgroup(page, h_cg, rsvd);
> -	return;
> +	if (!rsvd) {
> +		usage = &h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
> +		/*
> +		 * This write is not atomic due to fetching *usage and writing
> +		 * to it, but that's fine because we call this with
> +		 * hugetlb_lock held anyway.
> +		 */
> +		WRITE_ONCE(*usage, *usage + nr_pages);
> +	}
>  }
> 
>  void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> @@ -316,6 +355,7 @@ static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
>  					   struct page *page, bool rsvd)
>  {
>  	struct hugetlb_cgroup *h_cg;
> +	unsigned long *usage;

Same here.

Otherwise, looks good to me.
-- 
Mike Kravetz
