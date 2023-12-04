Return-Path: <cgroups+bounces-782-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0714A803563
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 14:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1353281078
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2108F25574;
	Mon,  4 Dec 2023 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="kotUtWQm"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A379DD5;
	Mon,  4 Dec 2023 05:50:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8POF1RKUmgsoxhV1ES8pHt4STc8gKQFYREFI58CYUDDRLNz5B7bXTsTNIuJ5PjAoklIM/hcCLOFHUfjExIV0E/5xKhVr8O+DJyqggqC5Ns7qXJ6iBdzk2fMpylJ5pEFOC+A2iSEaLeITtKNiuOMXb+hBR9MBBK/g++1yjjIMduk/qXBql6J6b3DoZ/wQtyVxxCJz0BR4bCXJiytWt5CKqcGSN1PTBK8QYqw00Y717+7M0g3lTT4bxitrgu6SjfuVYBmeGWcmgy0TjbpnEmk+FJNBxZGwS9MamUA5JKd676bRmnjuVcic1rkFOB/v9PePx1Fd8fqJLQ3q9xF1GXz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqt4GTRYEk/qBH16LKiWLsnrEk42j8Be2vsfGQW3qJg=;
 b=MrIKXYhcDzBAxZiVY80z6W6UbH7P9NwJNYOjyGiXx5z2M/4mJqqV/yiXoDuqy/jMqvBkzFjme5ZJa2bTpxv2Jp0Zm1bvRH2Q7hETDsJINn5/0EHINGBBn7xtrQ3GdmaEcQbhqrxRXaS2oJxjjWTgEyy5Iqh7BewVyQ3FJ7AEnWwE6UYrZya1RPEgu6ynVpmDcjhMXkiaazswQbsqrbw5LY+UOkx2ZmklD7yVuWWcu6wCXxSRGpJ1O088JtXgsRL/6KORYlyH8p8XgzijHCZVNtcNJLpuBb1Gw4MREw297Gac33eHRxww61Co8ETrcc9OQ3/nLSB1kvnJyUHPvLqaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqt4GTRYEk/qBH16LKiWLsnrEk42j8Be2vsfGQW3qJg=;
 b=kotUtWQmcScyqCPJYuycTqGj00wsQVfPedDkQOAzvUHK0mbYBbOBXvQlRI3AyYjQ9oMx/TZ8LKfGIxlVLfuxt/pzjimG7GY6eDPLk80L0Eswm5TuDPb/kxgGSqf+hags3QSQbnGEMG922S9Tymk2KkdPZLPSh+NsBDiMkiUNZ/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4482.namprd17.prod.outlook.com (2603:10b6:303:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23; Mon, 4 Dec
 2023 13:50:16 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 13:50:16 +0000
Date: Mon, 4 Dec 2023 08:50:12 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>, "tj@kernel.org" <tj@kernel.org>,
	John Groves <john@jagalactic.com>,
	Gregory Price <gourry.memverge@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
	"shakeelb@google.com" <shakeelb@google.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>,
	"jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZW3ZFDeTs7xotImL@memverge.com>
References: <ZU6uxSrj75EiXise@memverge.com>
 <ZU7vjsSkGbRLza-K@slm.duckdns.org>
 <ZU74L9oxWOoTTfpM@memverge.com>
 <ZVNBMW8iJIGDyp0y@tiehlicka>
 <ZVOXWx8XNJJNC23A@memverge.com>
 <ZVOn2T_Qg_NTKlB2@tiehlicka>
 <ZVOzMEtDYB4l8qFy@memverge.com>
 <87o7fveeze.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZW1IdPI11nhKcdZl@memverge.com>
 <87sf4i2xe1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf4i2xe1.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR06CA0048.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::25) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd3711f-09c8-457e-8c16-08dbf4cff243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ThCoz1ld7NFGvC6W+nM4GQFs7CZTjIRaGQ8zHRCtFd0D8G2i8Q8Ok7P4H1RYD/Jy0bmYvCRjdNuwtgh6e3aPvhVnfAabhbfI6VSDL0ChsKXl/+KWIJ4z40kgDDnY8g2tSJwT08F0pOHznjC1rYkPGk2EtDHM8AIQColI6iRXE2os3anLG7zROuvCO/wBC2o/281xE0hZU3I42q3j+aGykbOW0qVa/ESmftFyFh47sVore/Ivp3EcaZAFoJqtH9hYLWIU56B9QA2aenGx85gPStmtbFJ1LZ+6VxFZcL1R2nbe0b0q9GgDAF4IWvjstW93nVLsv0mpc9qUeGbE1YUyi0D4+t1HuCP1j0hG5laK8iEEunfNIt/SMucLQDnWT/bj1HMs8VgeCdZiiqr2XaQ99mdGFpBB9oDaqt3qGjXgbJSAkQPsPffrxIJt0SLuGBpix5sFATC55GhOmiwUnHtkFkIm8urU+xsVMJ1yGWDNbg0bhuYvlGNoclNTVlRJV2unzcsoIWU9zaMzwOY0/kOsAqBAQNqKafzV9tpVTXKjEKrV2vg9vQulIqmDpob9PEo6+DW+CLE2PlrtG0OIxHQxPhmxo1ziS8ctQgDLbduV42N4GJMqYCy07hDH4EBYffnz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39840400004)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(8676002)(8936002)(4326008)(44832011)(86362001)(38100700002)(6506007)(6512007)(26005)(478600001)(6486002)(66899024)(54906003)(6916009)(66556008)(66946007)(66476007)(6666004)(316002)(2906002)(41300700001)(36756003)(5660300002)(7416002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nJoxg69U4mROXt31wFMl2vOUgXax2YSHXBH+hYC1oX6HE7SbK21L3qLSgiQs?=
 =?us-ascii?Q?RJk5Bqdv5FX5BmxGBc8gy17Atn2O5vwUwzFqkRQF4PRYV4835ptOdZpb5Inz?=
 =?us-ascii?Q?etk/ReWN3arhenzqOC8yy6AqYtLggcCM6soXnpqclOHi2JNHbpczfN7ur8jl?=
 =?us-ascii?Q?bKfSgBGNQfGOIB4MF6wbZvmtxZlRasAz7t+dK5cv1drhcQpv6wFGi7v8MMat?=
 =?us-ascii?Q?QGUytGeYwp8FbV3B2SVwekWj5ETdkMWZHzKP5fn/QCQjXYIaClyN1dKbVc2Z?=
 =?us-ascii?Q?zmLlN3yEWSxHTtZBfxG8/RPBGVaEXc5w0TLQTJjW5LI+PwVgBso9CpUu28+O?=
 =?us-ascii?Q?4W/Bx/BTnBSVJPIhYZtig0sUphnoEf6ioFxR9yO+UoCP9n7oTMK5FygQU4bt?=
 =?us-ascii?Q?bStkxrMiyQHQnumYYRr4V/+iKTsn6qk9tVN6D1yP14maoDbCQosTek9Ijt7b?=
 =?us-ascii?Q?6KXMGV7HhVeD1r4y7NZN4XklrmKZ1u2K3ExUrU2GHEoqxC+OmY+uuXOeQ5PE?=
 =?us-ascii?Q?efwaDHvoNVfCQoU8gKyhXYSsyJcPGdVdF2+CF7QbjJlowrQQIrlGAf2V7HEI?=
 =?us-ascii?Q?5uREzhMWViJhR3IkicmHwZfJEswLR4xJBGLt7uonvHJFojzMmV+otvJATSva?=
 =?us-ascii?Q?yRmZR3rYDYonAhDuY+t1mrHzvU/1cT/FhQP5lL2hrOCLrNaFMu53YKOVLBqp?=
 =?us-ascii?Q?MS38MQSVODQT2xowOWjIqMRhNgzs0WClgTSnPsedr4sXaRcxiZjaNZy0nopL?=
 =?us-ascii?Q?Xz99k9mx5fYraq4hMwAWfBjmmijpoJJtKOXMOGSTeNLWdTA8mAVskw1lozvU?=
 =?us-ascii?Q?ZI0ZjGr5Fb9rK123G3HW5mNiIOT/dXaakd2945saJ+qmlLSGnnaflSC5m7RC?=
 =?us-ascii?Q?qIMi+oPOE+7CtV+O/sdYRv9Yk412APzGIKl0ILpbt1qTN1s5a+knHdDW5kWB?=
 =?us-ascii?Q?3bi6Xb0jSKoSn4YZ08sEyYSenkCzY05ecxqeLSZzCEoWli4QMYwzkmUyQPLc?=
 =?us-ascii?Q?SmxdHL8eMehq2C8BavyUZl+kizUA7yeJAyMAV3619PibkomnMHQM8IaH6d23?=
 =?us-ascii?Q?WY1+K5uNvg7/BfJtuPPNbdV/vSS3OSkTuwK4pN9D40EuzcE39UYFSqsWzgNf?=
 =?us-ascii?Q?8Z0nky5+VLsILgNlTsMNkKEDhS6a3oHqCJEggyzyehHhtgxC7taw5D8Qtdp6?=
 =?us-ascii?Q?KpCelIctXKaeVBqkPTi05bxrXC7Wbcfo7O+xQ2zUplYwJQJZJgJMySVqIop7?=
 =?us-ascii?Q?HcVd1hNi5wSYpqj8hBT5FAmDcpe2MhB62F8HsRtE3rHSoHpMz0N76mu4a91o?=
 =?us-ascii?Q?eV5A7eph1MzKOs3iVGA631UB6ssuG7Ffhssfg5BiiFjnLSx4nO7qQ953u0zp?=
 =?us-ascii?Q?o6f3OQi3Dv0F5etX9Oavv7Oo26Uxos4+qfN3zi9XlazfMkyTo2P3aVmqRRVG?=
 =?us-ascii?Q?8FzAL6SxeH+AMxLFgm2j5JQ3i2IrIzf7fG4WfPqOvOc8TuuoKqVQex5bh/tX?=
 =?us-ascii?Q?MEzuuqfHijvEL1KAjvM+76K9vg/kbaXbjX8e+MH3cYdVsBXJX9FnKkiHVjHK?=
 =?us-ascii?Q?uT/ydl0cegVh8fbPAyOOZEpIhqZOyHf0wT0qE2b/OTh2ozzafLLRJ1w/A/q7?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd3711f-09c8-457e-8c16-08dbf4cff243
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 13:50:16.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6iaAjG/DPD12mnxMPuO4Hq0SUoxjRfeP5Fcxw1DIYQJbqUnpsNmi6thyWIVWHzSmZvE0CWuRkYmQ1plq7VaXskYNO6fj87EIMjZNWsnHIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4482

On Mon, Dec 04, 2023 at 04:19:02PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > If the structure is built as a matrix of (cpu_node,mem_nodes),
> > the you can also optimize based on the node the task is running on.
> 
> The matrix stuff makes the situation complex.  If people do need
> something like that, they can just use set_memorypolicy2() with user
> specified weights.  I still believe that "make simple stuff simple, and
> complex stuff possible".
> 

I don't think it's particularly complex, since we already have a
distance matrix for numa nodes:

available: 2 nodes (0-1)
... snip ...
node distances:
node   0   1
  0:  10  21
  1:  21  10

This would follow the same thing, just adjustable for bandwidth.

I personally find the (src,dst) matrix very important for flexibility.

But if there is particular pushback against it, having a one dimensional
array is better than not having it, so I will take what I can get.

> > That feels very intuitive, deals with many race condition issues, and
> > the global setting can actually be implemented without the need for
> > set_mempolicy2 at all - which is certainly a bonus.
> >
> > Would love more thoughts here.  Will have a new RFC with set_mempolicy2,
> > mbind2, and MPOL_WEIGHTED_INTERLEAVE soon that demonstrate the above.
> 
> Thanks for doing all these!
> 

Someone's got to :]

~Gregory

