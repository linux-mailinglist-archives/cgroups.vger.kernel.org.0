Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84983339CC
	for <lists+cgroups@lfdr.de>; Wed, 10 Mar 2021 11:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCJKRr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Mar 2021 05:17:47 -0500
Received: from mail-eopbgr40128.outbound.protection.outlook.com ([40.107.4.128]:9287
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232449AbhCJKRX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Mar 2021 05:17:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IB11BmDsx/2jLh6F5JJR6XxJc7DK1GQggENSAPybttVxoUEGTJJEdQn55elbgMmNVXt9hqCZpKGVzh9AfK2XrUPOlsnUXYWKebmI7zz8WITbN/gD/wLAjI4a5n3dnkv4kPski0oqPnqDNCoQ1735VDNmCzSn0vP7dgBMe3Ndl7JzkFO923TFLkJduifjEZIqL8jDU1G1YgVzdmgdGz8keF3y1dquqK9xx1pmxRcvQ3JW9/5PvT1BZ8ghgVLtJ6TY6TreqM6qGmyjNsZW4smrQvsUung2NY47TQ6X6RBDgEWvVZylUOXEn19KE7LDBG0pgHzdDkThwVU+yPN7chhvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j7T74Ki28KSvdMiQAt3HSWqcxK14Ic+rNrs/T4XFHY=;
 b=Xqwoe2Zb9w0LrjC/qBJJAjtVyatUfVYGK9WttRUts7H0dYwZZafUaT08y61c37BVprpXghHykSjsrTjpg2/KEw9VlUJJ63vR9QDGtrZAV/+T9svg6+a8h4sfXJBId1CwxlnQUQ4ysKHZh31BqX/JhZ/hFVP35AUsfd8C8Yk7I1mqHv8+VOb1XWFCQ9f/7aqlL/2CE3cMf4CnK5DAED2t5sH+Sa1H1WiA0EYCuLDyQdjTOxDbtKX945MOKne2XoIPrdHZjVzWQWKyMZJSm0NQRHJoBF/TlLCvGjvZJJr6qtLB58KiHTqQWU7GwWTCLAqvSMxdDZE+19BThqtyY2x22w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j7T74Ki28KSvdMiQAt3HSWqcxK14Ic+rNrs/T4XFHY=;
 b=QM6+pwg3BjIJtkQEMbR8FpAmbmDqFZf+n8nCk6cgHHHfmFE5hPQsDIAIyXelsNYfUSPyE/8J6IMSK56aMaRTY49wsZJdBF3xeik1aJd+bN7qo59oOvwP/cfRPgeT6C/nM99xttpcqBN3/AMYYQwQxxAquZ0EiWnC47JzvCXRzIo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR08MB2813.eurprd08.prod.outlook.com
 (2603:10a6:802:1b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 10 Mar
 2021 10:17:21 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Wed, 10 Mar
 2021 10:17:21 +0000
Subject: Re: [PATCH 0/9] memcg accounting from OpenVZ
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <5affff71-e503-9fb9-50cb-f6d48286dd52@virtuozzo.com>
 <CALvZod5YOtqXcSqn2Zj2Nb_SKgDRKOMW4o5i-u_yj7CanQVtGQ@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <ad68d004-fa84-3d21-60b7-d4a342ad4007@virtuozzo.com>
Date:   Wed, 10 Mar 2021 13:17:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CALvZod5YOtqXcSqn2Zj2Nb_SKgDRKOMW4o5i-u_yj7CanQVtGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM9P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::11) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM9P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend Transport; Wed, 10 Mar 2021 10:17:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef248582-4511-4cb0-ca2c-08d8e3adb121
X-MS-TrafficTypeDiagnostic: VI1PR08MB2813:
X-Microsoft-Antispam-PRVS: <VI1PR08MB2813ED89D1B300499E98A91FAA919@VI1PR08MB2813.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVMt8/SCkXmshB826+v71SGwOmwa4/ooQSXEs39ZRNiRpn/YAHCq1nvwCDBk0nx4kY8+NLC4S6n/hE7UpUFhc9UI+RPoy8bjgYykZbSyHleMZ0+hmk49NGO2an+Ua5nF5d4JCkW5FufmF+hXcP3ZISLh5iw9SsuzKa/lUs34eaUFwZV9hyao9AY43h3hi/sVQWBr5w2DO/6P3DVuRJd/qy+UvxF7rDMbW6XDbPnamYKumN2TSxmj1rrFom7DJYTb+uMXA7ZhbndPIOjjnTMLgRTnhoHSIFJGs+muqVpHe/t50J4sfvnHYvM5idgERFm+90E9vowlpwZbvF2x8sZKSDBhlsikOitFnwO4KyvAM1ZKaVgOwnApuePyYJVB9tQCBS70J/VZWDGS2vq+3cEaL6QkTFtz8Jw6zbhvfXETVpY3bJAaAYp9NvPhgepHowJd2qutkhmerp07PFzx9kPLMva/90dCX1oLT/UAm/InlDPA2WDIXyih2PZUeq+0qMNBkjp5iwbBTY7S8H0k6JnBdB2uWelwOv4DR5pWRShXm+o3V0wkhDkP7rn13U22dmJ7QsZbFTNNFPULA31sbTWWLQviPdXGvMSAULfchn4wWNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39840400004)(346002)(376002)(366004)(66556008)(4326008)(316002)(2616005)(31696002)(15650500001)(53546011)(66476007)(16576012)(956004)(6486002)(186003)(52116002)(31686004)(86362001)(5660300002)(54906003)(6916009)(83380400001)(8676002)(16526019)(36756003)(8936002)(26005)(478600001)(2906002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TzFWNnoxNUZIM3ZRZmtwZVNMT29SK1JReWpMSjdHc052b1VLQ2FHQjk0SDBN?=
 =?utf-8?B?MlpxZWk2WUNHaGViR1FHbXRuS1J5M2JZeGU5aTFWVEdKWGhNdE5sMjhGNnpC?=
 =?utf-8?B?VUZvTWhuMUZzVlR0YVBJdS81YnhlK1pYNkNQcW83OUZBV05aRWYvVE84VDRL?=
 =?utf-8?B?YkFWUEpsaFY1Z0pJdHB5ODh6WkswTG1Kdjg3cnR0QlZCb0JndzFBcFlSWDBW?=
 =?utf-8?B?NnZhN3ZPdmRqTWFtSXJxRStkVGF0MXcvay9rZ3FEdCs0V24xa1RmdmkrQUdm?=
 =?utf-8?B?MEdnZTNOMnJ2c1FkM0dzQTNPQWp2U0Nhcy9nU1VCVCtzWldLSTZPak9walB0?=
 =?utf-8?B?bGlJNmlNQ2lHak9mUTRxQnVzOTllczNxOUJYOEJndVNUTGhTNzNmWmlWazhQ?=
 =?utf-8?B?bng0TWlQcm4xY2paNVh0SjgwSFB5a0Z5TTZ4aXNmYmFqSG1PRE1YK1pCVmtw?=
 =?utf-8?B?TFlFalJBci9rQVZGWXBneEJMUUpFb0YweUNPbjhiNHNBNHRRRmJxSzQxSlgy?=
 =?utf-8?B?Q202eHlnd0VuRFRQV3YxWWJqRk5nYzNkVWlBc2FKYStEUmxtY1E5SzR2M3hw?=
 =?utf-8?B?bmF6clN0MVRZWWF1NzRYR1k5aTJ5Nml2aFlKb0doZ0lNaUVWUS95UFlQblZ4?=
 =?utf-8?B?MHdrdC94V3cxc0hNYTlscGdMa1VxWVhTWmVYamh0d29sTmtyb2dpM3FOclZh?=
 =?utf-8?B?R3YxRENRNkxEWkU2WEZvUWtGeXltbGRyZ29lcEhRK1BabmxhUFAxK1AvQ0Q2?=
 =?utf-8?B?YS9SMWVoT05vUXNxMElCVzM2ejAwbmhmMStobWtEeW5ISWFhWVlyY1B2VmRF?=
 =?utf-8?B?VXo5QzVrMThiK3gvL25QVFhRRlY1dHR4bERYY0JkaG5LaWRpZjFpU25xdEhI?=
 =?utf-8?B?UzZQT2t4WVJMMzFNMEoyT3NUS3dJWHl6YW5xLzZWQU1DYlMreEFoemhmMm0r?=
 =?utf-8?B?bS84ZTcvd3gxcytSMHFNS0dwalZQTFNmb1JXQS9FbXF3RDhYWDlidFZSdUEw?=
 =?utf-8?B?OGVxd3FqOWhqNWdvZVhHb3piWCt5WDFja2FpL2dXUmkvYURsSDMyVFVpM1RK?=
 =?utf-8?B?b0hJeklRVzhQVXBuVy94eGlBZkpKdXN3Y0puR3MweEpEUzJQZ3E4ZkFQNlRB?=
 =?utf-8?B?OTlFNTh2bzVMV3NhM3ZrU1NxWkkrM001YWg4bEtSRlZZRzFzbFE4MUlKNGgy?=
 =?utf-8?B?RXI5RmlQalhFdmhseE1pZmk2V1pBdExMbnQ1UERZM1VFa0FLdHJTck1lMjNY?=
 =?utf-8?B?djlYK3d0b0FBS0h5K3A1RHAvRnRwWUlDczNYbGdydDBPN0U0K0ZWWjFaYXhN?=
 =?utf-8?B?Wkp2S0xMMXZLZFhDV0JQbHh1RzIva0FqbkFkdnhnTWR5NjhkN2Z1U1kyWW9x?=
 =?utf-8?B?UXIrK3B2VXhEZ1NKNyt2Ujg0cWE0U2FuM2ZLSGFzQzhHSXdjc1RReUQ1a3dj?=
 =?utf-8?B?b2xUL1NXTHBqNWJ4elZzcUdLdVZpcWxtMTVDakN0NXZaWld1ejQxWFIwT2Nm?=
 =?utf-8?B?cFZyTjh1T1lYaDZxcDV5TU9YQ1RXYUF2M09nOUx1UFRLN0xET041TmxzQUFD?=
 =?utf-8?B?aTYwMEdvOTJvNml5eWsxTGV5eTB4VTc2WGM2MXJndlVIMnJGVkgxZ0d6R01Q?=
 =?utf-8?B?MWk2RzRqcUxkbjdSeG4rUm5rVE4zNjBLQ3BOUTR3NnNodVpVOFAyeXk4UjN4?=
 =?utf-8?B?blVYMkZXZldNWHU0dWhmYVZwM20rQTBiODRyMXJQREpHSVNNTXZGMFdiaExW?=
 =?utf-8?Q?+fzHuo8kzPu4R4P0YorgkXV+miL0zPnDW+LmgC/?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef248582-4511-4cb0-ca2c-08d8e3adb121
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 10:17:21.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfWJaMLAsTMOrMtUfFKTmnv9O/1yje/oFaKyKZv2ANtR/0DVUquO9zrx7AzYY2RUPbiL4nezQ2XUmMBLCSFnag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2813
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/10/21 12:12 AM, Shakeel Butt wrote:
> On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>>
>> OpenVZ many years accounted memory of few kernel objects,
>> this helps us to prevent host memory abuse from inside memcg-limited container.
>>
> 
> The text is cryptic but I am assuming you wanted to say that OpenVZ
> has remained on a kernel which was still on opt-out kmem accounting
> i.e. <4.5. Now OpenVZ wants to move to a newer kernel and thus these
> patches are needed, right?

Something like this.
Frankly speaking I badly understand which arguments should I provide to upstream
to enable accounting for some new king of objects.

OpenVZ used own accounting subsystem since 2001 (i.e. since v2.2.x linux kernels) 
and we have accounted all required kernel objects by using our own patches.
When memcg was added to upstream Vladimir Davydov added accounting of some objects
to upstream but did not skipped another ones.
Now OpenVZ uses RHEL7-based kernels with cgroup v1 in production, and we still account
"skipped" objects by our own patches just because we accounted such objects before.
We're working on rebase to new kernels and we prefer to push our old patches to upstream. 

Thank you,
	Vasily Averin
