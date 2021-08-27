Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE5B3FA175
	for <lists+cgroups@lfdr.de>; Sat, 28 Aug 2021 00:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhH0WXG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Aug 2021 18:23:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14784 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232094AbhH0WXG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Aug 2021 18:23:06 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17RKxYPK024925;
        Fri, 27 Aug 2021 22:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IZisUq9OmVACOelvRQP2TdK+QkYV0UHhrbNgXDD0zqc=;
 b=oqjXaPs/gI5kvOjNnPE9GwE1NxsYFNIU0kANtQBHCrBwo7sjtZ8Y/A7MSEKx6e81Z2SF
 hnjjA9tRWOhTYJAbiwYXLvOz6FoEdGG2wQ//nYF5ADdrDh7Bd4N3kjWIAIp8rlzgBURe
 lCkNi72dxNfm6+J9yjpWI1jS4qobfe73eBToWxV4DJhX+WqvAmLYuKUoa57Jl3r3ca+P
 mgHbe0EdgK1lczH+eP7GmnSqCzbSo+SyXm7EB9VR3M4/Ior1G6DjTfxW8k8j7Mc8d/LV
 i6CEYLwakOV+/XrziBWmLnIoe9Pxaxbk9h0fuj4NovbB7uIowFnm+uRlu4GxDeZy/3+i Cg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IZisUq9OmVACOelvRQP2TdK+QkYV0UHhrbNgXDD0zqc=;
 b=vYTRQzD4nIsMD6y0ymIDVQK/gQU9hpaytkhacE0BbInJPesgU+b9nDQ2ti/eba2BY8Nx
 Mfg17NyKZ2xM6RYycW5WoGqot2txQWZjlX6eOnVKk3neH6mBrZESO9cjqwMbu+44BAOL
 7rWL5s6qZcv0h3bva/L+exCOco8YXiroYvApDtnDXVDjaX3DGRuaQoEaqUBbPMLriBzq
 6gy0W0o78KKwYXJRF0hhuWhPG5zWvnKJf4b+RaipeA3K2xj+YinvdoNMuvWkn/FvZnoL
 fOraRRHDYdGdaXPCt5OY7TdLjLiTo53lqeIilH4H3Cq6vrAMatoOeizqy3qbfDZPaFHa JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4xv4kr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 22:22:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RMFOOa174616;
        Fri, 27 Aug 2021 22:22:13 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by aserp3020.oracle.com with ESMTP id 3aq5yy795k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 22:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FowMR6+Tqqt1CyMcrfFJ/aethWptl6FZc9b2lATohBcBYd6mF3FOKhrDk2OeU5dD8UIp+lc4Wkr7BCq727cuoWWNXhOWEUCa2hWc7OuVbQCIn8tr5PNc0hSfG72rWStOx1S00tN4iTry9mXCVbZfLpuJXliSMC5vV9UBBKMV1RxL1nJgCMt+lpHYWWuyzQ+ciF8UuznSsZf5tMJCFutZNZFomIbC4vVd9Z2o3AJikAZ/aRCuSAAyxJjaiNJOjHYGPqbiZoivzyTu58kaV1B2tbCe5dCQQsjHc57qzkI8k1HaUrEkQ7q1GHf2/uUaGlciHU8de4Ny5mprsRM1tw4DtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZisUq9OmVACOelvRQP2TdK+QkYV0UHhrbNgXDD0zqc=;
 b=IrJtitu7mnVAushrnAVAtuZMsj1Qdi/TEeNphHIESiAyGbUzbdGUaQVkW92paDkRo+BZjnG1SdL5f2Lc4ay8L4uIQk7ijqhxwUS1e7T1LrO9f0WFX8bMTVeh0gcN2guK4rZcoVahe1lj/Rd2/ItUHlUeQKfI77qxTz+YAsWt9u+RxmL7eSMVN9tP73BQiYou/AiWTBHqVP/XUr8T6Zj4tVA0kNoJyZTHFQpIUuOjD51AIqv7IMb/MUCk42O5pogeGiWhQvZtOkmn8xrljfuo791wkVB1ZodL6EeiQ2xhjCM3RqsHVJoZBuRYW9R8fuSUhJHdusfppyPn780lBJubBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZisUq9OmVACOelvRQP2TdK+QkYV0UHhrbNgXDD0zqc=;
 b=GyZyfe8HYwkKV5GjWqRrbGfmTt9yfbc9RzZPpn0d2uVX18he/X2f8eo3d3om9qPw7zw5b6embDpVfQBhiWeeEQIGKR602GvCJGWTaB5r2oRBF5v6zu8Hs/yv5lSz/+9CiAGrUXyNvT4kN8TZwyQzmjvsKO6iSWYloG62RIJnJEk=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 27 Aug
 2021 22:22:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Fri, 27 Aug 2021
 22:22:11 +0000
Subject: Re: [BUG] potential hugetlb css refcounting issues
To:     Mina Almasry <almasrymina@google.com>, cgroups@vger.kernel.org
References: <20210827151146.GA25472@bender.morinfr.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux Memory Management List <linux-mm@kvack.org>
Message-ID: <8a4f2fbc-76e8-b67b-f110-30beff2228f5@oracle.com>
Date:   Fri, 27 Aug 2021 15:22:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210827151146.GA25472@bender.morinfr.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0318.namprd04.prod.outlook.com
 (2603:10b6:303:82::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0318.namprd04.prod.outlook.com (2603:10b6:303:82::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Fri, 27 Aug 2021 22:22:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94a12f95-166c-4ec5-3710-08d969a91d2d
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:
X-Microsoft-Antispam-PRVS: <BY5PR10MB41960A65E4793B997A020AA4E2C89@BY5PR10MB4196.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zF3AFQ7icAZo4n1FOxIOAdyKTPsyjwe1swHpI1AIe91ytJSNodDt72ts5Zcdj+ukPzuIaRMpqiFApE4YYPpALkgcCzd9O4gneLT7m9gMUHqGzDvh02m4Tn8Sux5V43R7ZspvJYIxYfgMjtVdE6Dqmzs5uF9hgZP93WzaQey20Z5FHBh+D5x6YoRQJpVqbP5LXl0YLY3Bg64FbEv8CkyrahV+vUolJH8jIqo65kNO/yEZd0TqMebOzG30OQrY+5KF2MfgW0NfYwxNsGTRNaX9z+1TjM3SOkID3Gj3Rw69mF+5r53RTilbpg/G4hOBr4O/A6pnPAP0yPiYRQmQjA0ZfC8NO/e8wRdySZ3mzUJ9y93lLF4WbuMGzUHINb+9OATSWHqwT9J2oYiUUmMd1PQoFqE1NJw9F4GBuluki7ytb+pCRbJL5xN7lUSCf7lMdsEffB54JzJ0hDKluoPKUvGA9UkAp7xCWwuDq1tsqbTqszv2jW4UUX6icwHp3SVLlHtMQb4g7AXGEVX54xvDQLMt6kBcEkzqO54ZxMmdJXrKy9NKpjSN9NbQSEdW9TXnUjmMwGwu1PB2VodpoQE4DNgD64Wsy5mnEqUmeC+xD8O2Y90lu4q/9c6I3J8J/u0ykwTruxAm7zZBbOod0/kxzxTNHUaIkUrZhgbCrFqMUU+tolHozaRGUZ1yGH88mzs/5CvF46e7ubdBtUmE5t2XP25pp7Oao0WFCk2R/V2WlLwy0AuM7smGy1B8xE8rXakm+D9ag7IQNrqJHSzs0+oBKU+7ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(366004)(39860400002)(376002)(2906002)(4326008)(66946007)(66556008)(8936002)(38350700002)(316002)(16576012)(186003)(83380400001)(2616005)(44832011)(38100700002)(8676002)(36756003)(478600001)(66476007)(956004)(26005)(86362001)(53546011)(6486002)(31696002)(52116002)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFdyQ2hKQmZVUlNXdTB6RHBodFMxZ211RG5pQ2hHNDdRS1hRUlM1M2NKQW1G?=
 =?utf-8?B?QlA4SGRHeEFRQ0tNWnFTVC9XSEZnNTV3ZmhhT2lyQzEwRFhZZWw5M1RPbi92?=
 =?utf-8?B?ZFFCbnEyMUtud0dXa2xTRGJFcnlvQWhxdDBSb3F3OU5ZLzk5VjZNVWpxbUVH?=
 =?utf-8?B?c0s3bXVOdDZoSUFyTHR3K2JyTVZDK25GazF2ZWFiZFgydzNXWTludkN3aS9z?=
 =?utf-8?B?MmdYTHZjOVF1d29SY3VmTDd1Z3ByM0RhSktRdWNNS05HSlFrQzNkUStNT05p?=
 =?utf-8?B?MzBWaEh5NSs2NVlqeGFGY0NQNkNMY3lEN1hzVFlVNHpEMlFUTFlLcGRvVmc0?=
 =?utf-8?B?VHIyemNDT3p1OVNlRFRZTlM0NUtqYUdxYVVrMlh3QU5KVXhOTzcrODFrVy9C?=
 =?utf-8?B?S0djazNtdUliY1drMmQ0T2lvbFo1NUJTTVBweVpwc1FqNTc4QjBnUGlKbjda?=
 =?utf-8?B?bys5c2xYclFEVWxkYndoTlhDdGV5TjZLcVZIejNTTDV3cCtOOTVlS3ZUUzVl?=
 =?utf-8?B?bTNIK3ZxUDU3bzRjWFhEbXQrQjNxNGpxSm5wZ2YySzZ5aThsRHlIT1ZWQmgr?=
 =?utf-8?B?TXdGS3RWUkhvNktKN3JFMVN4c2hTVndYU1BlbC96b1NvQ1FUZ0VjQ1dHVDU1?=
 =?utf-8?B?K3lETDJCM0ZzNzFuUjVPKytkR25Hc3B3ODZmVDZraEVQUys2L1djeGM1MkE1?=
 =?utf-8?B?QkJpeXFaMGZ2eEVxU3YrelZEM2NSSWZnNHNFZU9ESmdhVzJxdkhiMHRnWW9x?=
 =?utf-8?B?TmhSMDBvZS9XU3VDQ0xEZWg4aFpnNnZ3RGpFeUx0eXE2UEZRc0xGcWVkQjZj?=
 =?utf-8?B?OVdjMklsKzdmSldvaitxZkdCb2ZpZmVqQ3FWSGxOaE1JNFdmKzUraU9PeWxi?=
 =?utf-8?B?VGtOVDViaTd1WGNLaTBkRDE1OS92NUpIUWhXN2wzb05mT2E0Y0xGR2xCZ1Fo?=
 =?utf-8?B?bnE4QTNYSHFwbmNiR2d2WVVCWDR3R0lnemVCditQYk1YZFkvQ05tYmcrbnRQ?=
 =?utf-8?B?OXhmb1k1VkJQY3cyMjJLVkdoSDRVM2lwcU9SL25FdkRsTEUwTnVxN29Dc2p2?=
 =?utf-8?B?NXcrL09hamxGK21XSXlubWJrL3kxbjJyUXR6NUIwaUgvSUZzaUdYQXV6V0l1?=
 =?utf-8?B?VE1nNThiWTVvMjNyaDA1YnFYTmV0RkhFVmM3S1ZvOXMyQVhLOHUzMzZVbVBJ?=
 =?utf-8?B?ZkJ0NUlVK0Z3eGVUWG96aEwwQ3pZRUVtcWhjd2xDdWZCSHZrS21xeW9wcVor?=
 =?utf-8?B?SnlMR1ZzakZvNGd1U1FQc0ZOZVpQQldkaytsWEFFdHFnTTIxMDdHZGxrSitM?=
 =?utf-8?B?bnNOd0doNWRQM1h2c1d0blZWajhIRXIyMmRMVEV2MU5VZjdtSkhJZ0VCTENH?=
 =?utf-8?B?ODBRQlhRMDg3aWs1TnhxVnNpQmsxWmg4djQzZVphY1hPMStvVWVxT1llUXpI?=
 =?utf-8?B?ekthcVBXTEFHWGgrbCtOQkNueFB3RE9odG41RzduNnZ4WGFnR2QvZlJvTlVi?=
 =?utf-8?B?dFNFR0Q1WlBhUHprdExyTXlSRElGdXBJMkJNSlV0TU1TY2hLNHpSQkF1dnFY?=
 =?utf-8?B?NzlvYjBORmROdFpHQnhFSWtzZjUyQ09BZ3A0UEplVVY0eVJYY2RNUkFIZUVt?=
 =?utf-8?B?eTgwOUNJVzF3SW5kNDFGeXNNMldCQUZKYWU0bUZhWHl5L2FzbDFNdDRJTzRV?=
 =?utf-8?B?OGFIM1Y2OG9FWStvaEJvejRKcXVBWm9oNDlpbVRva3N0TFVLMzNhVFlsOEQ2?=
 =?utf-8?Q?XGwQVzj+sEVURGcPKvPlqSenCHpWpsqcAl11613?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a12f95-166c-4ec5-3710-08d969a91d2d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 22:22:11.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puMUO7lO6ZWTx2JB+ddrsJoCMr3QyyL/VHzr7R/65g8GnRI8Igj0MgECyRkPichuhYyycSz6CJJERhsCE6i9HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10089 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270132
X-Proofpoint-ORIG-GUID: WwkRSm1u6dnjlj9sn_bld2eXSzSZIIN3
X-Proofpoint-GUID: WwkRSm1u6dnjlj9sn_bld2eXSzSZIIN3
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

CC'ing linux-mm 

On 8/27/21 8:11 AM, Guillaume Morin wrote:
> Hi,
> 
> After upgrading to 5.10 from 5.4 (though I believe that these issues are
> still present in 5.14), we noticed some refcount count warning
> pertaining a corrupted reference count of the hugetlb css, e.g
> 
> [  704.259734] percpu ref (css_release) <= 0 (-1) after switching to atomic
> [  704.259755] WARNING: CPU: 23 PID: 130 at lib/percpu-refcount.c:196 percpu_ref_switch_to_atomic_rcu+0x127/0x130
> [  704.259911] CPU: 23 PID: 130 Comm: ksoftirqd/23 Kdump: loaded Tainted: G           O      5.10.60 #1
> [  704.259916] RIP: 0010:percpu_ref_switch_to_atomic_rcu+0x127/0x130
> [  704.259920] Code: eb b1 80 3d 37 4f 0a 01 00 0f 85 5d ff ff ff 49 8b 55 e0 48 c7 c7 38 57 0d 94 c6 05 1f 4f 0a 01 01 49 8b 75 e8 e8 a9 e5 c1 ff <0f> 0b e9 3b ff ff ff 66 90 55 48 89 e5 41 56 49 89 f6 41 55 49 89
> [  704.259922] RSP: 0000:ffffb19b4684bdd0 EFLAGS: 00010282
> [  704.259924] RAX: 0000000000000000 RBX: 7ffffffffffffffe RCX: 0000000000000027
> [  704.259926] RDX: 0000000000000000 RSI: ffff9a81ffb58b40 RDI: ffff9a81ffb58b48
> [  704.259927] RBP: ffffb19b4684bde8 R08: 0000000000000003 R09: 0000000000000001
> [  704.259929] R10: 0000000000000003 R11: ffffb19b4684bb70 R12: 0000370946a03b50
> [  704.259931] R13: ffff9a72c9ceb860 R14: 0000000000000000 R15: ffff9a72c42f4000
> [  704.259933] FS:  0000000000000000(0000) GS:ffff9a81ffb40000(0000) knlGS:0000000000000000
> [  704.259935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  704.259936] CR2: 0000000001416318 CR3: 000000011e1ac003 CR4: 00000000003706e0
> [  704.259938] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  704.259939] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  704.259941] Call Trace:
> [  704.259950]  rcu_core+0x30f/0x530
> [  704.259955]  rcu_core_si+0xe/0x10
> [  704.259959]  __do_softirq+0x103/0x2a2
> [  704.259964]  ? sort_range+0x30/0x30
> [  704.259968]  run_ksoftirqd+0x2b/0x40
> [  704.259971]  smpboot_thread_fn+0x11a/0x170
> [  704.259975]  kthread+0x10a/0x140
> [  704.259978]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  704.259983]  ret_from_fork+0x22/0x30
> 
> The box would soon crash due to some GPF or NULL pointer deference
> either in cgroups_destroy or in the kill_css path. We confirmed the
> issue was specific to the hugetlb css by manually disabling its use and
> verifying that the box then stayed up and happy.

Thanks for reporting this Guillaume!

There have been other hugetlb cgroup fixes since 5.10.  I do not believe
they are related to the underflow issue you have seen.  Just FYI.

I do hope Mina is taking a look as well.  His recent/ongoing mremap work
is also touching these areas of the code.

> I believe there might be 2 distinct bugs leading to this. I am not
> familiar with the cgroup code so I might be off base here. I did my best
> to track this and understand the logic. Any feedback will be welcome.
> 
> I have not provided patches because if I am correct, they're fairly
> trivial and since I am unfamiliar with this code, I am afraid they could
> not be that helpful.  But I could provide them if anybody is interested.
> 
> 1. Since e9fe92ae0cd2, hugetlb_vm_op_close() decreases the refcount of
> the css (if present) through the hugetlb_cgroup_uncharge_counter() call
> if a resv map is set on the vma and the owner flag is present (i.e
> private mapping).  In the most basic case, the corresponding refcount
> increase is done in hugetlb_reserve_pages().
> However when sibling vmas are opened, hugetlb_vm_op_open() is called,
> the resv map reference count is increased (if vma_resv_map(vma) is not
> NULL for private mappings), but not for a potential resv->css (i.e if
> resv->css != NULL).
> When these siblings vmas are closed, the refcount will still be
> decreased once per such vma, leading to an underflow and premature
> release (potentially use after free) of the hugetlb css.  The fix would
> be to call css_get() if resv->css != NULL in hugetlb_vm_op_open()

That does appear to be a real issue.  In the 'common' fork case, a vma
is duplicated but reset_vma_resv_huge_pages() is called to clear the
pointer to the reserve map for private mappings before calling
hugetlb_vm_op_open.  However, when a vma is split both resulting vmas
would be 'owners' of private mapping reserves without incrementing the
refcount which would lead to the underflow you describe.

> 2. After 08cf9faf75580, __free_huge_page() decrements the css refcount
> for _each_ page unconditionally by calling
> hugetlb_cgroup_uncharge_page_rsvd().
> But a per-page reference count is only taken *per page* outside the
> reserve case in alloc_huge_page() (i.e
> hugetlb_cgroup_charge_cgroup_rsvd() is called only if deferred_reserve
> is true).  In the reserve case, there is only one css reference linked
> to the resv map (taken in hugetlb_reserve_pages()).
> This also leads to an underflow of the counter.  A similar scheme to
> HPageRestoreReserve can be used to track which pages were allocated in
> the deferred_reserve case and call hugetlb_cgroup_uncharge_page_rsvd()
> only for these during freeing.

I am not sure about the above analysis.  It is true that
hugetlb_cgroup_uncharge_page_rsvd is called unconditionally in
free_huge_page.  However, IIUC hugetlb_cgroup_uncharge_page_rsvd will
only decrement the css refcount if there is a non-NULL hugetlb_cgroup
pointer in the page.  And, the pointer in the page would only be set in
the 'deferred_reserve' path of alloc_huge_page.  Unless I am missing
something, they seem to balance.

In any case I will look closer at the code with an eye on underflows.
Thanks for the report and help!
-- 
Mike Kravetz
