Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA30333890
	for <lists+cgroups@lfdr.de>; Wed, 10 Mar 2021 10:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhCJJRw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Mar 2021 04:17:52 -0500
Received: from mail-eopbgr60119.outbound.protection.outlook.com ([40.107.6.119]:10863
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231283AbhCJJRq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Mar 2021 04:17:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhLI4+dSOi33veSmSIr7HrMfI2Z2ffKsOZHwbmro8YwCx5ATxLQk3/7teIWIlb2x1xogI1DDhnxSKlOv6WDHQnij3q6bcwqfPTUN1GMJtPZNb1fpa/0MrpzKXIM7SEg0+/fE8S791X2rIOld2lbcLCUkd9zMHbUJ9BLAi5s4b2UVDqc2xjsQSPO0UjBqfJrqvSIkgiKyQ84rA7lqaJKuaGsajCGITfE9INVoWUys/MgP4Vl76jqAQNI0f8TPfT2Ir3rQlGlClREHNCfesWN/asUxYHf9fkForlsilCUzjJ6nxl/VDejx3WIdsyqXRkUuoh3ZXFgz6O1fkB6IeJDi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWpyRahM3scPgduj2VZeje83N5LT4t9feie9QxWPmu0=;
 b=WnyVAG+SKe6oU7TMOG6HwHbRt0e5Mi4JR3gfT+GFWq6eNnHij8nHCbu1jSxg9oczepqU0PlllzYUnaejOvYzeO2Nyb52+9XnEEhjCQGXGGf0CRmUkmHcVfLPmCJhixxyw2kw/jSr8k/OIiX3CPNIw5L12rduNt4/NA3acq/JIaxm74YMnqB3y1XqAg2ZVKmd3kHhNDoOw2+bx4RxosJY49uzu/dOpoyMyNCgS7v40iECUhoRioDfbLi39JCYH5QN21zbSJMzgUpd8kvTIDsFKra0OXZyfL4lCUWYEUG2fxn0lrJczOmMn7SPG12Dw2DVIkD8tzEtN7/m3ESJTi/gpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWpyRahM3scPgduj2VZeje83N5LT4t9feie9QxWPmu0=;
 b=lmJMQ/APfy8c5LbaSrrZTmmqLmyAJvEFJnnDn2z3M5SlsY5q09jf5oJeJkGUVcWc01b1wfGat9JSA7i1Uz67fywe8tGfIoLSf4mP5Pndyv+fR8lq1XIh9ZY/Al3arU3cshz7emjj1THOtAN76Qb3ouQEzj4ECGjsnUZAMS4FUYU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR0801MB1744.eurprd08.prod.outlook.com
 (2603:10a6:800:5c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 09:17:43 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Wed, 10 Mar
 2021 09:17:43 +0000
Subject: Re: [PATCH 1/9] memcg: accounting for allocations called with
 disabled BH
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
 <CALvZod4QiAhjgQOGO4KYCs4-GjUmqb6th+4tr8nQ+bPumGFzNg@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <818da0d3-80bb-cf68-2807-6604de36998a@virtuozzo.com>
Date:   Wed, 10 Mar 2021 12:17:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CALvZod4QiAhjgQOGO4KYCs4-GjUmqb6th+4tr8nQ+bPumGFzNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend Transport; Wed, 10 Mar 2021 09:17:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edbae44e-c6a0-4cca-60b7-08d8e3a55c8e
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1744:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB174443206BF344D8E649E46AAA919@VI1PR0801MB1744.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEL6PW8e6opt07omHn9RPGmYyDj3htcdt/Y+N3C10g+SoincKzq0TEUXkMx0Ar4FcSY/fFgWMIrPyUUw9CCqCru63k2b9jcvShMDFtZGX0JawBKGXEEFrpliHh8v+26N1fCu1tlGWSyO6IfE5yh0S4CbPqybyKkKT/iCfJjhOdno5XmISxbkb/mVenhGTwoC+Xdikh5YdHoZy4PkaV/Cbt9/ExSQWHpyFlSN87MLr+dulKQfu/X9sHer1hVS5GQjNEA5iwzm6mzxdLnk0o4QQQNESUhX0rEBF2QCpXfhsDEHNpomKDsT8k3gyBqyAZOqmHC5V38JSZapxBo92W82hDFRIbQsgzxMWUVMrrS9LQP+PekEBaprm/HhYAFTKhF0iA4OBygH3jgwR5UjZgFdlPoZ76tKKOISeXDRs7SkjeMXa9Z8i5Xwgrb8wZopTQmf/sqcCV+1o5GddPr9/3WP4x85YMfGpCnvfNOPY/bQjo/JcluW2M05tNl9vjH7EGOGHgfYHaj0UDPSp5PE2gn7w9XNRvl+C5qFbE8L9QxQsOZ38sI4ZojWgKZNETVnc1tnt9hUYhqR6P1yJ/KEM2vJWmx5BnfvbKQLLpQ+9tih/WE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(39830400003)(136003)(15650500001)(53546011)(956004)(66946007)(83380400001)(5660300002)(186003)(52116002)(66556008)(31696002)(31686004)(6486002)(66476007)(2906002)(54906003)(2616005)(16526019)(86362001)(36756003)(478600001)(16576012)(4326008)(8936002)(6916009)(26005)(8676002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Tk0vaW1taUc1cjFkWnFRRW15cmdWViszZ0xwVHdhcDJ4MFpaVXhiSW5mcEhG?=
 =?utf-8?B?RW0zRDFTNVhIcjhObS9vK0M1SngzRyt2NjFCK1dqN3Eza3FKTDZkYnRQTTZ2?=
 =?utf-8?B?emlmaHB3MFIrenZPRE5sVmJHcXkzZHlIUWN1TUpzQmpmUm9HUk5TNEx0bEpD?=
 =?utf-8?B?THA2R2pSdTZ6eUNsWEtSOFYrRGRqSWphVitKeG9ucU5sa1dWRVlRWjBrSW1i?=
 =?utf-8?B?QnkxRUs5blg3NEttS2pha1I3MWptbGhKQUJaMkRGcllNcXlIZHo1TEVsd00z?=
 =?utf-8?B?eUpPSUJTRFA4WHRkSjFmVEkraE9LdjdzcG9yY1dZZXo5cFRRSU9WSDBTRklX?=
 =?utf-8?B?THgyNStlamoydC8xdHhNSHVYR2cwa2RreS9WdEYrZm44NDY3TFFuQVMra3NK?=
 =?utf-8?B?UVBDaHkxbXg4SjJKTVBUa29taVF0d2dEWTMyYS8rVmVIVXZvYm9nZVFmWTJC?=
 =?utf-8?B?MmpKTnNUWlVUM3JvelZPQWhmTTdEelNKNHdPNzI4U1pjKzR2ZkxGOGV6MDQ3?=
 =?utf-8?B?SmFiQXN2dHhTNkd3d3QvMENab3JjQlNPbERxMWRJMStCMXpKaVZsNC9qZ3Zt?=
 =?utf-8?B?ZnR4MWZiQkNsODJ0RTZvSEw0SnpvdHBCdzZYckp0ZkU0TnV3WS8yOVh3UFQ5?=
 =?utf-8?B?SENtVzMvdUJITnUwbEM0QVpFTFZMUVRxNHkvcnJPbVFzbXBmdFFmSlBRRWF2?=
 =?utf-8?B?S0FlN2YvRnpkNTVhMUozSnpYRVBzbU4wV0FtZ0xpT2dFT3BpdUdXMmVUUXVS?=
 =?utf-8?B?NDhoOHR1RHhSR2dicjNjNXhXSUViTnE2dHgrdUl6dzl5Nm1abUxIYktOTnp4?=
 =?utf-8?B?SjFLcGZ1U21VVnZhVkdld1lmNHBzYVpjckV6L09WR1FxeWgxMjJtY1VEdm9p?=
 =?utf-8?B?dmhucm1uRVB1ZEo1NWUyNisxM0dLdXBpTlh4aXZIQTczOXhUelVsVVFhOWxF?=
 =?utf-8?B?Q0pLQkxzV29wYW1MYXZMbjBUeHpTMnJsejFUdDN0bVJEczM0Zm1SWExxUWNF?=
 =?utf-8?B?elFqc2Fsc3JRbGFKcUNVYmh2VnhOS1FFRk02UWV3RVZteVhZNDhBZFlTTC9Q?=
 =?utf-8?B?U29wZnQzYmJ3MVdvNkY4VTF6bi9uWGRNMHFKQmNDa0RyWm9JVS9NYmtYRWxG?=
 =?utf-8?B?NjFMQ0JSUkVxQldaaTRub3VSQVhpcjl5UFJQSlFDaGFIVUg3ZDU5Z29Rd1B1?=
 =?utf-8?B?em5XRlprOTNEUlZySDhHMk9oTlN6SXhoRHRXV2piWUNxTUE2UXM0dXRTZUNN?=
 =?utf-8?B?VDI0TjAvcmNiOGdkQldWWk0xOXIxUllFaEhEeEhMNVd1U3crQm5hMVM4bGk1?=
 =?utf-8?B?Rmk5ZEdPcmhRZ2tERjFOVXNuWTZBdjF2STQ0QVk3MEVhUnZ3cmpjU2gwK2Ru?=
 =?utf-8?B?Ui82RTFENlpOVkg0SzN4c2o2Q3cwbVFxbmFNZUFqNVBlMHJ0RkNCbTZoNC9C?=
 =?utf-8?B?K1NpTGxZUHdrVUpyOU11clduNmdhL2hJd3FnRnAyeWRDeVJkQ2pIQk1rUEl2?=
 =?utf-8?B?Mm9JYk9FMTJWU0tLK2tXbDc3a2Zxb2hqL1RGMjllYjBud1RCR3RLOE45ZkxX?=
 =?utf-8?B?SnpUNDJ4cmRxWmdKMVJka3dCZ3gyQmZtZko3RERub1grWlFYUEJKNGlaSGt0?=
 =?utf-8?B?SlNhWUNFVksxcXdUcVRibFJqZ3JxRFVlWFhkZzh1WnpHUUdJL0JzUkMvSDdZ?=
 =?utf-8?B?aWxDRnlnN3A3WmE0MnJVb2RUd3NuV1oxUWh3dzZCY2p1MWljYVkzelk1VUpC?=
 =?utf-8?Q?Sw6maenwFjNtck+czfxSpd039ejaduhDyAfpQod?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbae44e-c6a0-4cca-60b7-08d8e3a55c8e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 09:17:43.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeTgchhKGdEPDk1uajy1QJwPdA26V23I0nXL369idDFdvQTGe8ovV6eSxtbiAZW6MEeo/bpl16bMMpeNbHpV/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1744
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/9/21 10:39 PM, Shakeel Butt wrote:
> On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>>
>> in_interrupt() check in memcg_kmem_bypass() is incorrect because
>> it does not allow to account memory allocation called from task context
>> with disabled BH, i.e. inside spin_lock_bh()/spin_unlock_bh() sections
>>
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> 
> In that file in_interrupt() is used at other places too. Should we
> change those too?

Yes, you're right, in_interrupt() is used incorrectly in other places too,
but 
1) these cases are not so critical as this one,
2) and are not related to current patch set

They can be replaced later without urgency
(unless I missed something imporant).

thank you,
	Vasily Averin

>> ---
>>  mm/memcontrol.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 845eec0..568f2cb 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1076,7 +1076,7 @@ static __always_inline bool memcg_kmem_bypass(void)
>>                 return false;
>>
>>         /* Memcg to charge can't be determined. */
>> -       if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
>> +       if (!in_task() || !current->mm || (current->flags & PF_KTHREAD))
>>                 return true;
>>
>>         return false;
>> --
>> 1.8.3.1
>>

