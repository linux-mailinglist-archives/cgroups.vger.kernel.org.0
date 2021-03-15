Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D433B28A
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 13:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCOMYP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 08:24:15 -0400
Received: from mail-eopbgr70130.outbound.protection.outlook.com ([40.107.7.130]:15685
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230169AbhCOMXt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 08:23:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtgQXXIMYBADE4Knw8fUer7G8YCS7WjNAzLVlGuZoyILDxNTq59RZKx0ABuoKN7VIckTDzmigD4hqEAaNwB2hMfL9eL7MSsaD9aL6tCKfy3Wfx3ArDeHAV744eomjlFALAcs8PXw52OYlLk7iYAvbIKdffAJAchGEAclcAu2VBU+OUUb8ZSK6AfbUsAAt1zjOqWotR14F4rgJnYGmi82Ue8IzwfponRMB5Nwc/k+DJVQVK6EEZepEye6CgZFdIGpufvH+Fw9L2Zq1FkTV2r5npCvn2XnSFOexUpfizr1U/9kH3kSsiu1P0JbWh7x7N1OQMkhpOYN0XIutgjpHzIzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJk519X8QJk9kT6eYCL7kFmjyTh/WBJuliX1U/YIvXg=;
 b=d+vrGt0uOYC/u+t0YY5qXTqUei22bmWMXyW5CrHAopsohHJhqNw2H0sBvGLnIk/7hwMN6tgFnOeaNZ3r+/BPXg/TbaN03JLcY0yJWI3Jd/jJs/ccSgExcuwbvwtwBIl6Y7AovkBcBOumiq+RJhEvi+JNUED+IFvWH+CFTlzhZAsddufUvptOdC7J960P7+Nio8TqIVUx4FXoKSXFcJgkaUMNi2iVDFzFZBnOPJycoHU98gaY8jE/USjSFQ5hKGjJ82+6qBajOtNUUcCyz8xoWjBGWj1t1UrqFJqUkcaFbrpjSal6fhZBta3VHgaBT10lYoNSpL1ezklwWu9rChv24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJk519X8QJk9kT6eYCL7kFmjyTh/WBJuliX1U/YIvXg=;
 b=D0RT5n2q18yLf3o7qSQJPllGCF24RmI+LTa4FD9t7PHCDZaGo/NxfFNj9PN7Cb9Zwaxe793XwxblVBthP6SvmcxEIKT2n6V2OGlS3tbk7qqI/eZBSmwDVFI3LslXpdeKR+w1hvB/UTZ4AC8RxBOMNZFQ+1tzJ9siMeoXtVQHFW0=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR08MB2959.eurprd08.prod.outlook.com
 (2603:10a6:803:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 12:23:47 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3933.032; Mon, 15 Mar
 2021 12:23:47 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 6/8] memcg: accounting for mnt_cache entries
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Message-ID: <9ccfd80e-5c38-5dd8-7d05-9226a722f440@virtuozzo.com>
Date:   Mon, 15 Mar 2021 15:23:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0061.eurprd07.prod.outlook.com
 (2603:10a6:207:4::19) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM3PR07CA0061.eurprd07.prod.outlook.com (2603:10a6:207:4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Mon, 15 Mar 2021 12:23:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4891f9d-fe27-42bc-e2c7-08d8e7ad2e72
X-MS-TrafficTypeDiagnostic: VI1PR08MB2959:
X-Microsoft-Antispam-PRVS: <VI1PR08MB29592FBAF150FCD4C1A78F43AA6C9@VI1PR08MB2959.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCtUGlIvJg9amSyIl/kt0M6qjC4pF3adl6IVeSQOKux7Kq8Pw6o0bsj8wzzvV6DDMPTm7dBMvFYhRQDAmjzaMv0OKluz2RbHdCqdE4YijPi/9tivbpgrDdmHuzcmauDS5/TYdFPfL3wKh1t6txNxFeOGwFXI+acQ9to1DNj/xXO18vWG2FEpZ2Eu5ZrfswRqI9C8+G5vq8h/4csXHFE8nHlz2zNMRcJ5QatoKHFrl8V9x6XwUAHGrUBXnp/pAi/4QB5Uij5J7Vwa2jSfEMWgSVsF3XzSmU0W7VOUtz2gCOM51+PMydtLjMvj6TWBnEzOWFz5G4QdVOngOi4jLcqB+WiAygbcv2zHfcA1wIATZd8YuJp8Xk1r0cIyDan0M9DuSDhKYZSegu0crSlLhY2eeSHZZYTsTYc7ca0Dt8DNGd7+e/97wjduLsx7qU6x82/xGvxM58Quye3XrTls6Xd/SvtyUtNBXxo+j4bkdMTeDsBila0vYwymg5RjxDy+tJWbKZWHLfqmSUoNyJTQXjnirlrZaDrSPCZovbLxr7ohVp1+wb/5BkSdFm8DYl8gdFWoptBeMRX9X1XvdUSgeHx4NVjyZXwx3r/kv7bEuWYU57vqNOTpcvSDGqdCtXuxtG4O8VA7Tud1QN0F0jsiD2STkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39840400004)(136003)(54906003)(956004)(8936002)(2616005)(5660300002)(31686004)(66946007)(16576012)(16526019)(4744005)(52116002)(6486002)(316002)(6916009)(8676002)(36756003)(26005)(66476007)(66556008)(31696002)(478600001)(4326008)(86362001)(2906002)(186003)(83380400001)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZWFCZzQzcG5BMXp3Y3hSU3FxL2RWYkk3TUIremVZMGdQWXVXWjQ4bDlQendS?=
 =?utf-8?B?V20wbHluSXpDTEp2TnVvM3p4ZFdjU0sraE5ZNzE5WXJYN2FYWkZBck9VdmhR?=
 =?utf-8?B?WTZDZFhuOXpBOWxJazFjdVNHd3k1bCtObzBIclIvb3pVNTl5YkpNcVZGZm1W?=
 =?utf-8?B?d0FaZkh6OE15bDB1RGFGaUIrSVZ1R3pIT25xK0REcVFlN1UzOEx4SjJDZnlX?=
 =?utf-8?B?eVQxRHRrc2RaSkJ4RVVWQWd1b0ppZi93Q3ZhK1RtZXlkN1BlQlNQVkFOY1Fy?=
 =?utf-8?B?VlZMTkp5cFJYUGJIeXJFM3g0RTNiSWlDTkQ3TEJVcnVSR0xEUG5PeDlvaklX?=
 =?utf-8?B?bXhZOVcwa0NHVkEyNmFNYVkvZkcrMi9ueGtoR3JRZkhhNzhzam9yZjF6YWk2?=
 =?utf-8?B?UDR4eXRZdUQwcmJpRTRrV1AxMzBzWVh0STd4TjF0Nmt4OWIyWndVV2tkeDdB?=
 =?utf-8?B?dm45dGRxWGF3ajRiRW40cm9MVUE2bWxvNURQa3M2THhSWktFVjhaMnlZU3gx?=
 =?utf-8?B?aEhGcVNPR2xVejdSdm5mQWQyRGVnYWRxdStQSVl1b0kzVFhVaEpVdENlditN?=
 =?utf-8?B?b0pZeDhZd3JYL1pDUnB2bVpDUGdWdFBFUWc0RkZPWHJCcVE0eUJUaDNpTjdh?=
 =?utf-8?B?d1V3N1h0TzZBZGNHRW9ISWJ5TzlQM0grU0xBRkFOUmZVVGY1WHFLWmdGWmRu?=
 =?utf-8?B?MzRnZzRGL3BqUSswY25KdVFWbnlDRjhUdy9md01ZKzZRcm9KZFpuaDNlaHVj?=
 =?utf-8?B?NWhsQXZxbzN4U2NwUk8vUjVtaGlpR0dtR1lUbWJabVRBdGZJeWJvSTU1RWFS?=
 =?utf-8?B?QTZ3dmMvZFh3dFh1cTg4bnJPKzRrL29ZaXlUY0gvTHdLbXJlQ3docStrNEtC?=
 =?utf-8?B?YnJCd0R4Q2VqM2xjVTFaS05WSnlEalFtNU9BZVZKYWN1NEh4UDVvVmsyN3dE?=
 =?utf-8?B?eDA3NldaamRCRkhvMGZvaE5GVm85NXpUVVdhUlpaaTlMWHlZYzVjd0M1b09X?=
 =?utf-8?B?ZUtuOXMxdzlLNTVUYi9semZBQ01oMHV6eFYxRlRTcjN6dVBnK0UwNTNGLzZQ?=
 =?utf-8?B?YTI5emx0NDQySXovMkxra2hSazZkeTg1a2Uzc0NBelJzR2dNekVmaURXTS9X?=
 =?utf-8?B?cExXL1NPYm1NUGhnaTVoOVRFb0t5QTdZeDNBU2FhWnNPcUx2L1JJQm96U0gv?=
 =?utf-8?B?ejhJWklwU2J4L0JlbVpvMXB4SUZyNlQvZGVQUGVMYTNiUFREV1hmWk54OVZ5?=
 =?utf-8?B?Q2FwWUE3ekE5TnVkZE5SeGxZTFd0N0pjL094TVNGZ3FrR1RBVU5DWXQ5SXhL?=
 =?utf-8?B?TUZhV3pVQ1Y1VVdwNjY2aVBYTHhHSGpkTVBObUlMcHA0RmtsQnY2Tldma2dj?=
 =?utf-8?B?ODlNQUFiN0c4VmVLUVErUEd0MHZXTC9YZXlQWnFqK01GVTNOVzVjMGRiTnk4?=
 =?utf-8?B?eGNSa01VWG41S0JaWTRTTnA0dWNnaDI1em5DKy9uTzNJQXFQbjFwemYzVzVT?=
 =?utf-8?B?aTd1VmI5aFlCRlhnQXRDRDNvV25naTdsK3ZBV2x5Wi8wL2s1Q2M2c0drWnZZ?=
 =?utf-8?B?aVF1ZFVMeVRZODFVU1lYcG1pdG5VYUduZm14ZjliZXhzTjF5SUE2LzFOeWVP?=
 =?utf-8?B?YmtMSGhvME5kbzJBRSsxU2cxNlAxR0w2ZHRGYklDNlBEenBlL05RRU1teXdR?=
 =?utf-8?B?aHB5OXFFbzRqOEk5b2hBQm94UnI0ZzFTT0o3WHVpbVIveEs1N1pSUElOUVh6?=
 =?utf-8?Q?0ioU4z5P4ZQFGPcMShkMxcstwYyuasWeVxP5ymV?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4891f9d-fe27-42bc-e2c7-08d8e7ad2e72
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:23:46.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlvnqwcQoLHbDR58jbd1rlbqNHhUmwDPzU+VwDXxnzL0KO2Y2cY0A8fFxWV4nRzmRcS0omu2G/yH2f3+FhjKCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2959
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Each mount inside memcg-limited container creates non-accounted mount object,
each new mount namespace allocates lot of them for cloned mounts.
---
 fs/namespace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 56bb5a5..d550c2a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -203,7 +203,8 @@ static struct mount *alloc_vfsmnt(const char *name)
 			goto out_free_cache;
 
 		if (name) {
-			mnt->mnt_devname = kstrdup_const(name, GFP_KERNEL);
+			mnt->mnt_devname = kstrdup_const(name,
+							 GFP_KERNEL_ACCOUNT);
 			if (!mnt->mnt_devname)
 				goto out_free_id;
 		}
@@ -4213,7 +4214,7 @@ void __init mnt_init(void)
 	int err;
 
 	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct mount),
-			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
+			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
 
 	mount_hashtable = alloc_large_system_hash("Mount-cache",
 				sizeof(struct hlist_head),
-- 
1.8.3.1

