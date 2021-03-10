Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B2333386B
	for <lists+cgroups@lfdr.de>; Wed, 10 Mar 2021 10:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhCJJL5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Mar 2021 04:11:57 -0500
Received: from mail-eopbgr20113.outbound.protection.outlook.com ([40.107.2.113]:63045
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229489AbhCJJLd (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Mar 2021 04:11:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiUwxe1x9IjN2m2r0qicWdorxviYEXQQM4hpdfaB9qbKAW2lJaMFZWT3T0/sGYVBzaXnnkQFkA0yw5Nt2czDx9ivk+thSoV1EM4JINlbcasHZFApJRuQUrODcjDUSeNiSkBI09z1VVNLjE4bvMC2hPaIgYJKq+ksbiruuy5VfmmHRH7aO11NDsd39UVRi4vjyCeLTRqJo1h2Tuey1UHV5YczMIqgPjPoC7LN8b/zbbnJH1tvjNFvpDKfu1E0UWfFofvZ8tEAzzfK+8foWUSYwDYuaokc+Ly6XZLVahxtfIkTMmwEfuGigF/mIOsU+Ob4BhPo2/O5qc5dm5k5Nwqlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li5frmD9SCXBj5Pm1ZvYCMOqZm8Q7Kkqx/voF2Vx6iQ=;
 b=RrMhFEpxaonWaPFYwnwvzCS4JyP17sepv+YiSlthtDr8DpDSdxM+yS3UWc5iMQr62xomPMTAzb+sjanmPV/Z5xZx31Qk7ojjMmb1GKlQbjP+odMYi0a6QFqx1u/4DdI6YKeypAwWrT6l2B1hp447Z3r3NgggKFBqnCUB0rcBTaNLl6eynKdfu4GkQf/gJTbH2YpP/9zXQ6oTdwxZO3Rc0ZoFLEBZspQM9xXpcAbtUt6cwYL2QGYLFfx7NQTdzJTxporVpIi/ZQ1gQuu6pSigQNlLJoPDh2uc79ZN/PTm2OjPt388AjmEzWgMI9DVfpxOksAk6hezF8lFu9MiFcimYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li5frmD9SCXBj5Pm1ZvYCMOqZm8Q7Kkqx/voF2Vx6iQ=;
 b=I17qZ20ISZOauP9RVDm+uEgnL9vfpJjwdb4fr6cYPHdFB61sR44d9jM4M3t6XsMk55+LZ+1bOx0u2SU0M5b6SkT2bGfrhku6FnpmGAkJAKhnkvL/caIMMSdhP0/Irn0FFrPfkYl3TCbUGREWlULT/4FIr0wndmVQ6G//iFAd6/Q=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR0801MB1791.eurprd08.prod.outlook.com
 (2603:10a6:800:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Wed, 10 Mar
 2021 09:11:30 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Wed, 10 Mar
 2021 09:11:30 +0000
Subject: Re: [PATCH 1/9] memcg: accounting for allocations called with
 disabled BH
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
 <YEeM8AZczZt/irhR@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <60275aa1-082e-af13-b048-76c5a5cf18fb@virtuozzo.com>
Date:   Wed, 10 Mar 2021 12:11:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEeM8AZczZt/irhR@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0209.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::16) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR02CA0209.eurprd02.prod.outlook.com (2603:10a6:20b:28f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 09:11:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c0bf47b-4d52-4476-15ca-08d8e3a47dcc
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1791:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1791BA8B41CB41063A75C701AA919@VI1PR0801MB1791.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1j1d0EKUzyrp/FK5Lcy9PDU1RA/hytqjVZEPWOK3tMjUfzmiIFPhGpCyecEO9whCfmCgFq4jbZq48MoK5X6Z4cTmgki//6IKD6P9UzAUxhW0owyW+s2/2zIlWxtwtWjNdKsppVGPLtJCB1Jt/umD0cpovOAg1KlNI0OCvZtATO9eV4uhGw8gkb/r9FfTqu87Ob2yIF/nbh5eOTu6fARNbvpaANw0JQjyNgjK6OmYTTPWCBNFDnxhek+cWmbTIpctVS7v5dHNVXQtmFBr+3jI71yHFnFIOA9RbqdvieslOJxkPQqJJs9lNq7a5IIxOlNo/uKwdIkt5Bjj4bTlTC13EE+sKL1XntvBUjW9HPCR4XvZwecBntk3f67UeX6bkBkPrFUIj8YEIjVYrG4L0hukcoocO39VEcF3/BNqXdWohC/U+BslI8EeOmDnrvOPvFXQtRNH0fcNai+5o5Xw/RjF3JCPCa/YkioXb3XHha1mEHCD4CaFa8iPX5r/TBcqs19KuKIPeyhjf4NrCKR6aOgwb4CBe/hF9EmQhkT2fH4X3f8p/Ik6FTOcEhgOIgI6R2Wc5e6YdoBGMNfSjyFpN7FQ+GnXlwgH6j4sH10p7otPHpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39830400003)(396003)(376002)(346002)(66946007)(66556008)(36756003)(956004)(2616005)(4744005)(5660300002)(31686004)(6486002)(66476007)(186003)(26005)(31696002)(15650500001)(8936002)(16526019)(86362001)(52116002)(53546011)(8676002)(6666004)(2906002)(6916009)(83380400001)(478600001)(54906003)(316002)(16576012)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VTZnYzMrS21rOVpWempaakVQdFQrTjNacGpKaVJoVlQrQXlIbXJ6K2tTQ2Rn?=
 =?utf-8?B?d1dlUGVLVmpyQnhtSm5DRGx0b2NqeGFkU3REV2lZMlJPOGxxSmRXYlZBSCt6?=
 =?utf-8?B?dWdHUGpzWkV4TkIzekQ0Lys5MlZ0U2xsU3RYSE41QlZzWDFLYXlNR3huVHNn?=
 =?utf-8?B?eW9DUllaQVlVTDNkTjM0aE1oa24yTGwzUm9ZY1RNVjY2a2dPY1hLdWZJZGFE?=
 =?utf-8?B?YUhSdVprMEt3NW0vMDFhMzN0WW1BOUU0MUF5bEU2ZlFmZWFQQzNWR2F0ZzYw?=
 =?utf-8?B?Q3JXVGZpNTlhRHR3cFFJTnoyenRaL3ZSc0pOdm1MWloycHFTNWFiS3pXaEYr?=
 =?utf-8?B?ZTB6dlZDZGkxZXl0Tlg1b0xmKzlkNVZaSHU0eHk2dHVxQ3hDdnVRcmFhbHlO?=
 =?utf-8?B?dXlCUEFPcnRSYzhIZG9zemVKYUNpb3dBaVUwTVlNTVk3cFhHZjg3L2ZITHM4?=
 =?utf-8?B?VlhueEdTUGZ0aFJmTE9OWmh6Q1hST0xUUE55QVZOUnVDNWZlMlU3UGU3SmlC?=
 =?utf-8?B?WjBNOEJVVExLNVVCYzFBZHd2MnB6SlJsSzUzTjU1Z1BEYUhmYTVCVEZHZVB5?=
 =?utf-8?B?QmFRclRMc2ZYd2NNNnk1emFsbkpzd2ZkNVYrVjk5bm5TYkd4YStoU1kzOEp0?=
 =?utf-8?B?UVJRRUt1LzcxS2dQQW5sNkFVbVN3NmxWRFBsRVBReVZvWGpyaVVpZ2ZKK3Rq?=
 =?utf-8?B?UHJVd1FJUUxTbzJXTzdkcm5SYzdEbjk4eE5RVC92Sng0R3F5VU44Z0lrVkxz?=
 =?utf-8?B?UVhGcmd2NFpVYTJZT0orQUdMaXVxblU3cEJ6UkUwMVkyaEFxd2ZRU3QzNkto?=
 =?utf-8?B?ZDFaaE1QTmpHeUw3czlsVU43c3l0ZFl0b3d6MDAzMU80c2JIa0pWaS9jZFl4?=
 =?utf-8?B?RndaWkhjVjhDc0x6bitodGo4VmZWVitpSDUwSEYxQmZMZFB3U0NRalgxVEZ5?=
 =?utf-8?B?Y2tCTVRZMU1TT29ENll0emFDdFRXSFYzMmpkRnFxNGh2UmhUNm1EaDhxYk5U?=
 =?utf-8?B?QTZyRFc1U2dLNEo4Q0U3cFo2L2lwUzQrSlBnWmdLVXVzOFYrelJWOUc1UmdG?=
 =?utf-8?B?RFBzMHBtV0hCVEpySHFKMHQwK3ptenhHY0MwQzhlQXM0V0UyY0wzVlh1VXMr?=
 =?utf-8?B?WkFDY2YyWkhhUmo4N3lGZjNIQmNWZTRLcktudENPbi8ralE2QkN1V2QwTlpw?=
 =?utf-8?B?eWdXQS84blFVbFNKL0NDMGl5NElwKytJQVJxVThOTGZhTlR3RkJXL05SR1U5?=
 =?utf-8?B?Zmt4UUg2UU9MandiZjJiTmlOZ3JOa2E5Z0hJMjFPRk5mV2d3Z3BsWHBwK3k1?=
 =?utf-8?B?UlBBMlFIcTZHazlERm9KVzhJYU1FMnFQaFNjVDc0UzVQY0FNaG5kaHVTdmc3?=
 =?utf-8?B?Y0FXc0xxellqclNZNnR5eFZUKzlmMUZGV0hBNVJUVlAxaDZMYzdVb1p4VWVM?=
 =?utf-8?B?R1l2R2xzNXArNXhEckFmSlY3N3hITWpBQjl0eS8yeERRSlVraG5ibkFtNDUr?=
 =?utf-8?B?VFhkWHhVSnlYQ29xYkNHN1hOMGlkYVFIWStoUjZpRG5hSG9QeVR2L0pmZUw3?=
 =?utf-8?B?K2NBZnp1ei8zVmRCUmtmc2g4RVpQQnh3OVJmajByZFlHUUUxeFFESHNxaE9G?=
 =?utf-8?B?cFlGSzVKTm5KNlRWREVYTityVFkxUnBUbGFoT1FEMGVCd0ViSFVRaURsNVoz?=
 =?utf-8?B?WVFBbkF1WFVHdG4xMTlTSFdQYllUc20zSGtPM3pId01mdS9FeE1HOTFWeSt5?=
 =?utf-8?Q?Wg0kIc0Tt3ybC6nqpHRYaUKleSAuEtM7CV0BXce?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0bf47b-4d52-4476-15ca-08d8e3a47dcc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 09:11:30.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZ2eGHPd0JNcE5U6m7S04+HCvMhC8WeI3yti5ZVKuAZTAYYHPaNNrfxSjZdyrWN3kcD8hrar53J0yANk4Is7Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1791
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/9/21 5:57 PM, Michal Hocko wrote:
> On Tue 09-03-21 11:03:48, Vasily Averin wrote:
>> in_interrupt() check in memcg_kmem_bypass() is incorrect because
>> it does not allow to account memory allocation called from task context
>> with disabled BH, i.e. inside spin_lock_bh()/spin_unlock_bh() sections
> 
> Is there any existing user in the tree? Or is this more of a preparatory
> patch for a later one which will need it? In other words, is this a bug
> fix or a preparatory work.

struct fib6_node objects are allocated by this way
net/ipv6/route.c::__ip6_ins_rt()
...        write_lock_bh(&table->tb6_lock);
        err = fib6_add(&table->tb6_root, rt, info, mxc);
        write_unlock_bh(&table->tb6_lock);

I spend some time to understand why properly entries from properly configured cache
was not accounted to container's memcg.

Thank you,
	Vasily Averin
