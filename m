Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF1D43DBE2
	for <lists+cgroups@lfdr.de>; Thu, 28 Oct 2021 09:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhJ1HZ2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Oct 2021 03:25:28 -0400
Received: from mail-eopbgr80115.outbound.protection.outlook.com ([40.107.8.115]:52103
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229626AbhJ1HZ1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 28 Oct 2021 03:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOOWmQ9aUzfhXNB8YaJkyx0SgNYyky80OQMHzKLX0nAPNrk8JHDJVhdxLnrB8Cug8WJIxEwWYten65hGCUd5hJoYQCkUhO04AsNc2ql+Byc4erTTnYeg1tFkrw80XpVCh/TKi7yOYNjVDPEBrBYhvP27BvZchKulZw0MKDPwBzDk63MaiYRF8e58lPRM5b90Syoiupjnm/OsJ6hebvAOD4hoE1MkDwq2uk6lDF0QdK7hkDTfixG4i8FCyIQrZFTE/JGlVjto1BkSrJjHNrllj0GSfMDya+pYDrQF7RWBRY7z5iA0zBLndXG1Caov1D0fnIgZOdzBqt9TDms7NWdLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y06wyIaTQk/vqnWTXXrbA0/17cWwIbbEVGj8aQ97gw=;
 b=hJDQ41ormK5ClgXN0sQKvxChS+B4T3TF7CmHG1B6nFtmlBlWeaBxA71a4zTEToB9TyPgviKYNgGHRzBQq7iQMpV15EMM7fP22LNweM/uLLI1DgOHh47g0Pyxt2F40OElKJCO536ei6G3cR9G+EH19X972GK4a3+mx6073Dj+Mzg9POi9buRnw07AZu+tpe6PMeDKKi3+So4Dnk18roe1sWGMSv8wE099Vp2DvAiefgF0yk73OVkgSHMypVX7izwJtr7O0jCI/wlStql6oRGXvTeRyavWWVAdPk9uki+tk6SderfdWpd23DhsJVy1s5JtR88ZoGTBCeG83TNAmOy+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y06wyIaTQk/vqnWTXXrbA0/17cWwIbbEVGj8aQ97gw=;
 b=v0E1eKyk5HkI9KAhSRzN5tvx7lbiK4uS9uNhLCAGMXtyZ39nTwFO6n93BCM75aEYeizhPiQwNeBAKbAJE/VbQkGLN+g699ubbOAQmQHXiS64YmlC+msidD4htb+7ITDU4j7Jbhhf/wcicsPqCRS78YUaYE0PrTHOjAp7l44JAeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DBBPR08MB4726.eurprd08.prod.outlook.com (2603:10a6:10:f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 07:22:59 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::ac34:81d6:6ef8:4bb4]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::ac34:81d6:6ef8:4bb4%5]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 07:22:58 +0000
Subject: Re: [PATCH memcg v3 3/3] memcg: prohibit unconditional exceeding the
 limit of dying tasks
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
 <cover.1634994605.git.vvs@virtuozzo.com>
 <8f5cebbb-06da-4902-91f0-6566fc4b4203@virtuozzo.com>
 <YXZ6qaMJBomVfV8O@dhcp22.suse.cz>
 <20211027153608.9910f7db99d5ef574045370e@linux-foundation.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <ea14200f-ad2c-6901-25da-54900fe2ce14@virtuozzo.com>
Date:   Thu, 28 Oct 2021 10:22:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211027153608.9910f7db99d5ef574045370e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0060.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::37) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
Received: from [172.29.1.17] (130.117.225.5) by AM6PR10CA0060.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend Transport; Thu, 28 Oct 2021 07:22:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7554860-11b8-48ff-b7d9-08d999e3c4a1
X-MS-TrafficTypeDiagnostic: DBBPR08MB4726:
X-Microsoft-Antispam-PRVS: <DBBPR08MB4726D278F608C183321AA7D5AA869@DBBPR08MB4726.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Msq63SsqfV2frW1LqQmtCZT9w8aiaibV2w7+SzoWqlUgGjK5pc2WLtM9wXSivNrKxO2qR66OPHB6mbvpDDjAWhoCAYPefFsi4B6eS95Cd0WDWkkctBua6uO5u6J64Du7k8DIx15FkHABVwJ+YGD1btfUO2E1/YalCopWD5FMyhGG1crqF/HxtE9P7LsnstHB6awYSWyou3mu1wIPsM+tW/aimFh3PL2bLXZYMat0LUkxCAUFGV/EOgW3xY/9hGwQCybgs8h9zt3eTi/rV5DjsOB3dzCc5uAOC6XEuF3y1ZCrh60qhTCxPFHK8p5A7AHQ02zNb/uAsPlo7c5sGfA1AVvnEISPnEHk3xrmmPZLE3ViY/zTR8+5rRZSxtBrE2PDyBBZAjLpBz9qMaGbfEHVd8d0AFH0eeZl3yySvYZXW22pIoOh3ZmHQ8ipel01SKK9VTwWwBPiCrO2I9c3HpIQeLOtopRiCsomajTjQyouYSuZZze0k1bD5f+D529IpZE5410yvAEccG+K9Z6PlnJLiVIaUwLExIafm7tb98IVZxgwojmUczX03suA4Gq6Fq/MOjYi7WPtPNtqOrYBpISv+GA6UEyupDbTRLKZ+2CC5KEieFTnuHLZMPcgq38YAl2rYmDyVtDbd9hx8SgdbRyH9A1CLlQzclmQ0eFFDWNru6jyz9PXDSEOJ0lMCgZB+F4OJWrfVuSAg3s7bgjoiPq5HtzVOJV4520VNJVCFJnPN2tDZmOCFyQCAaYp/wBbzmzVROwUafbH+QZVgIhiTKgoBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(110136005)(8676002)(956004)(54906003)(36756003)(86362001)(31686004)(2616005)(16576012)(66946007)(38100700002)(186003)(38350700002)(66476007)(316002)(26005)(8936002)(508600001)(31696002)(6486002)(52116002)(53546011)(7416002)(2906002)(4326008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUdzREhMS0RQbXdRTTBJQXBHbzhpSUJQbmtNMVBKS21LZlB6OEd1MXZtejg2?=
 =?utf-8?B?TjN6M2pvbysrVUplcWt3YVMxL2YrSU9mQkhweXBiOEhVcXhpUlFKRFV1d2My?=
 =?utf-8?B?VGNVMy9LU0pnYU9YazF0enVRT3E0TEZpRGs5bURyb2E4UUMxWlE5aThrcGpK?=
 =?utf-8?B?Z1V4azcrSVVlZDNuc09oRDZCdW1MVlNtbnlRZEx2cFNwdFVEbWFqbC9oVUVO?=
 =?utf-8?B?WkRtZER6NzBSZDljOFlQSVdMNVBBU1QzdFNiMU44enpGTVJqTngrMG92Mlg4?=
 =?utf-8?B?aXZEbEx3MnA1eHJoR0xRdms5Rnk0Y0E4YzZHODNYTUR6aDg1QXAyZUFKQlgv?=
 =?utf-8?B?alc4Mkt3NmtScFVtcDk0K0puNnFpalNPYmE1aThYNGY3bGxjQTdyeG9QQlBj?=
 =?utf-8?B?MUdSdUw4M0ZHRTRpRSs4NDFVZEtOQ2llSVoyRXBMWmZBRmVmTUVpV0VVNjBn?=
 =?utf-8?B?ZjZkbk12YnBlNzJpc0dKb3l2bzJxeWxacEFYNnNYRlJzM1JtU0szS2c3THVK?=
 =?utf-8?B?a0o2MU1tNTF2VGJyZ3RYd1B3R1FiUmlpRi9KcXN2cGxpOEg4MSt2cWVmUDF0?=
 =?utf-8?B?QitpWUcvbVVLYWxPa1I5RndnbFVtUEhkMHd6RDN1MDNzUjBQdkpHYlFXS255?=
 =?utf-8?B?TkUyQkxvMHRYZFhscjNFb2RYSkZ1bXYzandEZndKeEh4b1Z2MWFkcjF4dEgv?=
 =?utf-8?B?aUx1aCtoSDZ4MXFZWXV5YWhkY2tFLzFXQWo5ajA0eFhKZG1CTnNlYXlXUmd0?=
 =?utf-8?B?Rm9TRUVPdUU0UmtNTlpVbVBNZ2lRc2RrMHRCMVVkTys1VDU2eDRmNXo4UURl?=
 =?utf-8?B?Ui91RHdLTGlDY0Z1RERiQnNDYlowU2tuVGs2K3U4OC9EaVBCcmxURTVBY2dM?=
 =?utf-8?B?N3NQeTFqSlB3bFA0QUxJTDBIRFE1dFNqbWcyOG9Gc0RteHBMR2lMQmtCUGRk?=
 =?utf-8?B?dFk5aTllRyt0aW5EamgwVXJsbkRlY1BkQk50T01kcithemFlZEwwMTFtQTJq?=
 =?utf-8?B?SlNNaWF3RDlmTnh6b2tqSnQvN2Z2R0w2cC8wZGtqWE1UdGgzcmFxaGZVRUd4?=
 =?utf-8?B?eEJyejBEV3pxYjZUcTNuZStWUzhsS1RqaURFOG5TamZWYUdwNVArUlVHR0Vm?=
 =?utf-8?B?VktmaWZUMkg0emRJT0gyOGpLVi9mOFR6ZUsvanN0SkpBVXJ0YkxMc0hEYi9w?=
 =?utf-8?B?Y255QTk1ODdaQ2RTSExDbGlzaGVNN3hpYStHb1NGNTNHUHJPNVFtbHBOVGlp?=
 =?utf-8?B?ajZJMmZWZzQ4a2MvZ1pCTnlsOWNIOEM0Nlk0enpHZVRyS3FiR1pld3BzTWI5?=
 =?utf-8?B?YWhDZzZQZEYzUUxMd1BUT1VTQURqbHdNZTBOMHpXSFRlVlp5ZDVhZjk2RGxP?=
 =?utf-8?B?bE5uRXVQelMrbUdlOHBOUElZam9iUmtkc0VJNTA5VWZBUkkyS3dnM2NDS3o1?=
 =?utf-8?B?ZmxZWXpXRUhSbWlUMVhab2QxeDZTUzhvbTc0azhlekJFYlpSQWxFeHVUUUMx?=
 =?utf-8?B?b3hZZHAxcmp3M3RRMHlFQXoySS8wT0RHLzkwZ0IrajBFM1M3NWJ3SlJQOVI0?=
 =?utf-8?B?Yk95RGpzQnEvSUp6S014aUk1Q1dCTkY4aktDc0RUdm1GTEE4NXFuSE90dExj?=
 =?utf-8?B?ZUdJa2FaUDBpbTkxVGdHR3o5allHeFVxRXFvQlA5Z2Z1R3JNekxHNHZWNzJC?=
 =?utf-8?B?MXZLQnlTL3BPbzZDM0wxdFA1MmxKZlRRVFMrQ2dmUE1ubXNLTVBBZWtSSzJO?=
 =?utf-8?B?czNwc1hRSzhEYS9EZmQ1RXZxRFVENEpNcmQ0cUJMdVByMnVvWDlMamtSdnds?=
 =?utf-8?B?VnNCYjJybmFzZnVJMVpTK1NkSnhFb0VZTTR0NW1yN2lXT0xtMkxnYmVkN09R?=
 =?utf-8?B?L3BXdFhPT2ovYkU3Und3Mm9RaFVqQ2dhZkw0dkpCajRmZ1RlZzlobHNnQWY4?=
 =?utf-8?B?d2lZTTRsS0lDQUNHVDlpQmFlQ2hkT0FtU21zL2VuZW5NMjFnZ0Fia3g1SVlH?=
 =?utf-8?B?NGZXVDNkc1pmNnY0MkNEVGlsY0U5MDFnYlVtbmtONnBLbVRwSmVKa0xCSzdj?=
 =?utf-8?B?Z0h0RFlnNWxQa2o0WmdQdURwMHp0QmlZWTJEU0o2TlBpYVpVMU15eW1KTEJl?=
 =?utf-8?B?SnBKbHJwYis0OVIvODBjcGZ6ZkhOYVdLRnpFSkYySFRtSlZlTCs2TjI1aGUy?=
 =?utf-8?Q?iWTSb9hKR5pScjafrAUBKB0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7554860-11b8-48ff-b7d9-08d999e3c4a1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 07:22:58.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRHTpvAA5T2gkBeyLnZZC3i/xQLPt87PXxuqNqlyMjrTHbI/vILod70pdHa3iV4XPOS4Sjy85alD7Nm9mC+e9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4726
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 28.10.2021 01:36, Andrew Morton wrote:
> On Mon, 25 Oct 2021 11:36:41 +0200 Michal Hocko <mhocko@suse.com> wrote:
> 
>> My view on stable backport is similar to the previous patch. If we want
>> to have it there then let's wait for some time to see whether there are
>> any fallouts as this patch depends on the PF_OOM change.
> 
> It's strange that [1/3] doesn't have cc:stable, but [2/3] and [3/3] do
> not.  What is the thinking here?

My fault, I missed it.
All 3 patches should be backported,
I did it already to stables kernels since 4.4 and I'm ready to submit it in demand.

> I expect we'd be OK with merging these into 5.16-rc1.  This still gives
> another couple of months in -rc to shake out any problems.  But I
> suspect the -stable maintainers will merge and release the patches
> before they are released in 5.16.
> 
> In which case an alternative would be not to mark these patches
> cc:stable and to somehow remember to ask the -stable maintainers to
> merge them after 5.16 has been on the streets for a suitable period.
> 
> Greg, thoughts?

If you wish I can remind Greg in a month or even after 5.17 release.

Thank you,
	Vasily Averin

