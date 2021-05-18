Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5C38831C
	for <lists+cgroups@lfdr.de>; Wed, 19 May 2021 01:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbhERX3n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 May 2021 19:29:43 -0400
Received: from mail-eopbgr1410041.outbound.protection.outlook.com ([40.107.141.41]:56384
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230352AbhERX3n (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 18 May 2021 19:29:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FafAel+WyVWniMtD1RGJy7szX6JXNyudkXtmWHXAuP2avu3dZzm++ahFhyzXTxhJF0CzZf3oNTL1bg+hev+o80q6s+OqMlRt7IBunPcA+WnlkwodO1lNi63b37qajxyGv5X2H30Y6Ft1lW+pKTE0S18S6iogLKdKTOmzcAxCp8HbKiuNDQzf7JX8In6DY3sAIkEbb9EfQZPqWCROmSS6NygggKkmBfxTrZGzF+Bd0i3Hk23sfEDW30i5VGpw4ZiCqe/kpthXoKAXRqa2vxUhRZygI8Z3+Y0xF6QmiFq6FlW+jaYD4tNbIjBOv1O2hhXJIZZI8ax2gECNLX01vnQBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jca7gpM5jq61hUaPufeRsEZ30MHS3g63z6H/2NEarpI=;
 b=H64z0VJfoibvoJapGpHLppUKlYyDp9TGbRCYgGM0zDwhkVv6471gVXR0ZZ/NTIinVKKYoafb0teSQD8ToPXu/mvQGK4yiisi7IdzoAJGLL5xuYznrA4eqcBBdhYUXrxfbAIoX4yNhMbYcN4Sq+n0Sr+BDqqdX1Sf2KWFmeOye+lX2eXRSpXb8JXm1LF7BvCU0QWzML5AIQylESMGHPL4xAomWDwsjXs4lxCv7HfVn77mYd4KW12aufEXcqf/Bp9AbE9lUMZtoSiy+Xqxh+/Q6kPULxqaMo1m7e1SkvcmfjxAUmshSiUrnWX0z4h1LPNrgBGDZBTbJ1uWSc7EGKlxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jca7gpM5jq61hUaPufeRsEZ30MHS3g63z6H/2NEarpI=;
 b=iHc9JRC4pc+QOu62rDIvOsnKoM7/vZuqtEaBCLCwUxvH4yRMxuz6dwMxgiv+Kfq/CeEoEnXPvUhd5PA8l2goXZy/KIn+EyHQt27tefk2DTlQi/wLSTwinEaccZoeVjKw+XVRrDLaMgcycNwO+9rLJYJW9m2ym9fj9a5SPDR+IsQ=
Received: from TYCPR01MB6637.jpnprd01.prod.outlook.com (2603:1096:400:af::9)
 by TYCPR01MB5632.jpnprd01.prod.outlook.com (2603:1096:400:47::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 23:28:19 +0000
Received: from TYCPR01MB6637.jpnprd01.prod.outlook.com
 ([fe80::2c85:38b9:eebe:b58b]) by TYCPR01MB6637.jpnprd01.prod.outlook.com
 ([fe80::2c85:38b9:eebe:b58b%5]) with mapi id 15.20.4129.033; Tue, 18 May 2021
 23:28:19 +0000
From:   =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?= 
        <junichi.nomura@nec.com>
To:     Yang Shi <shy828301@gmail.com>, Shakeel Butt <shakeelb@google.com>
CC:     =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?= 
        <junichi.nomura@nec.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ##freemail## Re: [PATCH] cgroup: disable controllers at parse
 time
Thread-Topic: ##freemail## Re: [PATCH] cgroup: disable controllers at parse
 time
Thread-Index: AQHXTBGPToDbgm+SQUqGBMSrinA+Jarppv6AgAA714A=
Date:   Tue, 18 May 2021 23:28:19 +0000
Message-ID: <dee7912f-c797-963c-909e-4f7681433a32@nec.com>
References: <20210512201946.2949351-1-shakeelb@google.com>
 <CALvZod5a_W8P0v7xg0jdh-TLvy4OUYaQkyjBx-1RSTUBo+YQmg@mail.gmail.com>
 <CAHbLzkqziUEUz-4nxBs4H5z4pZS3y+ceKciKYt8KVN34Gw8egw@mail.gmail.com>
In-Reply-To: <CAHbLzkqziUEUz-4nxBs4H5z4pZS3y+ceKciKYt8KVN34Gw8egw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nec.com; dkim=none (message not signed)
 header.d=none;nec.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc56bae1-bcae-494c-df19-08d91a549ec6
x-ms-traffictypediagnostic: TYCPR01MB5632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB56323FD2B91C624F06210A1A832C9@TYCPR01MB5632.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7PEq7cB0aGrFi9GZcpaO3KceSivH9wRgvPbyeugR2w6+6QtpiBIlk/tGTPqp2fDL0Bc9CuiMH8jYS+kG4zjrH2oUu/52MNwkJS5cBpe4JUbPnSHcpvFeUuVd7wqVlpbUHU4rqm3LX8TUDFURI75W9qCoVaZfU28OIJiIaTQHBk+JyanYxvYHzQ9r7FUblPzxmFFu84KcR9AbTnRHGH7Q34LKyNN2mVHsjpEmMvpSy3CyMbnKOgeDED93dFNMiEqEokET6Yw+k+YQee9T7LIAUa71V7dx8Z26isW5wy7D6YaF6CQffUIebWm6YKegKWD+20oijNH7j1KdeydElVp7354t+7yITK1/R3fzWc+Gw4UqciXi7v4xzkTO8fci+QtoaFblf8orESc5gmmahwAAib/KLlzFYKGYn9eFxac5xvVEtCa23vxkXw1MHTPO23AEIpnWbfLwwL69ywMuDGJzJI/VaoQ37/NRjfTGlpuw98BXOG6TEx35JEfHhOrwBIv7keagDWaaovSZ+/IUzA6b4Ck/ocgriSDAW/aPzPV/mvXjdS/afTqwClRujSmzWChftqIazg/gGK7kuVUQK6oECqVG7Udz0FYIors/uwiEpMhAOd2k9BUw21K2DnxH9gXc/ZVbITAluGuMN3WURYcN/xa6RQTB/P1V5saQ1NwA5HPBCwwbKb1mv4vpn9QBqWlfZJOOlSPR8eHcrV11E/LdU8Xy7+iaHjDmRmcqv79On4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6637.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(478600001)(5660300002)(86362001)(6486002)(31686004)(2906002)(186003)(71200400001)(36756003)(76116006)(4326008)(54906003)(66446008)(8676002)(6512007)(110136005)(83380400001)(122000001)(66556008)(55236004)(2616005)(64756008)(85182001)(966005)(66476007)(316002)(8936002)(6506007)(31696002)(66946007)(26005)(53546011)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?UzV0TUYxWVJCbjl1K2lGMjJzY0tGdGhEazlSOCtPVWNxdUR3eVUrUUto?=
 =?iso-2022-jp?B?Q0xWV2ZxZHZBcTU0eHZmSHA4RXJ1TzV1TXJJbHRLVnl5TE9TdFpBeVAr?=
 =?iso-2022-jp?B?UUhIcDNyTzRGcHZvMVlKKzhSbHd3T2s0Rk12U0dWSWZ5ckZXbnhyZkZL?=
 =?iso-2022-jp?B?T2hKMWFNeUEyb2k2Z3NqR3o2NEQzLzRWVFQwbmdNczFqTFVXTWoyZzF2?=
 =?iso-2022-jp?B?dDNmTUx6cHdNdHRGQmRPbEdoMVR6YzRibTVHczM0dGl3ZXNPckxlT3Ri?=
 =?iso-2022-jp?B?eEtSeDdlRWZTVWdqeE5Nbys0dVRWTHJBY1Yxb043TldiaXN0emFUd0xq?=
 =?iso-2022-jp?B?RlhOWVJFTmg3YXhXZEg2bFNLZXhDUTc2K2M3Mm9VempST3VQTk45Sklu?=
 =?iso-2022-jp?B?RStRVWNlNzJOTUR2WkVmRFNNWFMydXh5ZEFHNGNmK1NJUElhelFoMDlx?=
 =?iso-2022-jp?B?UFJDN0N6QTlwait4YUQ2NzFaUXVLZmlqTmlreWhjckxFaGQ0U2RHQ2xn?=
 =?iso-2022-jp?B?RWJTTWNXMEpDV2RPdndSQzVESzZlV0xHdXlHTUZEcG41WjhYdDVXL0Ny?=
 =?iso-2022-jp?B?ZUZsUk00UlhVQ3dJR3pNaHhXMmltMGNyZXovdVR6clMwdklxTFgybldV?=
 =?iso-2022-jp?B?RE9vYkhLWmVmWSsvam5qWTRQVHgvb0R5QzdMNVhnNGRJVlJXZUllQlBL?=
 =?iso-2022-jp?B?WUpuRjNGY3hBYUF3ZUhVTVo0dFNva0FJdEhFZWFNQlczOFIyY0wxYmVY?=
 =?iso-2022-jp?B?bUhGWS9aRGtnU21ZZ0p3ZS8wV0RQQVRJbmtCMndmVDdQb01qMFpiekpz?=
 =?iso-2022-jp?B?YlFCaXFxU3lpalhzaDdmendYWDgzaW1VQUkzeXVwUWxWcUpSVjlxN1BQ?=
 =?iso-2022-jp?B?bnJEZzhlN2FDU0xKY0lwU29MdXdFaU5MWVllYkNkc3pHL1BKTjlsZy9v?=
 =?iso-2022-jp?B?ZlZxdGs1Qy92QlJIVThoVGduWGk4allFL0dJWGovdkFWZnpKYkVTRjQv?=
 =?iso-2022-jp?B?OEZiRlVIZU84cjhWMjJ3eUVKYkc0Q2lKVnNCWjVNUnpETVEwelZhcTRx?=
 =?iso-2022-jp?B?eExlVHI1MVNvdU80N2ZVME5WVlJKSFZNNjB3NlZQTFVQenVFWEJ2UXNw?=
 =?iso-2022-jp?B?c0FuQ3hhM0RaOXByRU41cHZOTGtubkZ6cE5pd1AxcEZ5bjRoMlhBelY5?=
 =?iso-2022-jp?B?eFFuTWxVekFKNXZqaHA0SVFNVHRpUStNcFRpNFUxcE5MWStJSlcxRTBO?=
 =?iso-2022-jp?B?ZTUybHNrM2ZlZ3U0bURUb0tMdFg0bW16Q2lnS05RM2JGcDkvSlV3Mzhi?=
 =?iso-2022-jp?B?Wmx4d3l3TTdidE96MGpLSTJ6OWFqMHgyaFIvaUR6ckl4M3dMaFg3Z2Ey?=
 =?iso-2022-jp?B?T2Jad2xmQktGWU1KYS9veW1yM0JrRkRMTFQvV0tUSmtFQkNEc2U3aTEw?=
 =?iso-2022-jp?B?NW56US80bWNkQmJlUUFFTzk0SzhyZlVCeksxR1h5NGI1cnZwQnZlVmZp?=
 =?iso-2022-jp?B?VXdhejFLb0NBVzVNaG91NURWNHpReG0rSFJwWEd6NlhOcENtbUtZSTRj?=
 =?iso-2022-jp?B?YXN4VmxqckYrSDF5ZytFSGQ5NUNMSllQb00xdmJmVEt0VVdYUjBhdGFU?=
 =?iso-2022-jp?B?NS9SdjJ4V3NoWGhxTGptQmppVXhIaG1xM0lETjgzMkkrQUhSemR1dUxK?=
 =?iso-2022-jp?B?OER1RHk3eVRpWTdlZXlodTM4RXN0alp0aUwrQzlxWVZFU1Aza1ZHZlY1?=
 =?iso-2022-jp?B?cmhSSHM5QXdxUWE4b3NjbUZ2ai9yOHRuTUt1Z2FwVFJsdGxWckI0MTl2?=
 =?iso-2022-jp?B?YW9vQVpvSCtKNUwrb1VaNDJOSUladnRnWm1uKzk2VExYMWVWNER3NTl4?=
 =?iso-2022-jp?B?M29kTXdpRnd5WEh1bVFKNENWUzJsQjdzSlUyK2hmSHRWQ2JROHpXWUs2?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <7D92BB4160A89548BD440755338749B1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6637.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc56bae1-bcae-494c-df19-08d91a549ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 23:28:19.2178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37yaAgQEsQQriFb1HB3VQ3pUW+ISvBLyMShYrZNPEmeY3U/2LEeMmVbfs7CXMq8TLkY+JivjNHx0zLFGH9wumQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5632
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/05/19 4:54, Yang Shi wrote:
> On Tue, May 18, 2021 at 11:13 AM Shakeel Butt <shakeelb@google.com> wrote=
:
>>
>> On Wed, May 12, 2021 at 1:19 PM Shakeel Butt <shakeelb@google.com> wrote=
:
>>>
>>> This patch effectively reverts the commit a3e72739b7a7 ("cgroup: fix
>>> too early usage of static_branch_disable()"). The commit 6041186a3258
>>> ("init: initialize jump labels before command line option parsing") has
>>> moved the jump_label_init() before parse_args() which has made the
>>> commit a3e72739b7a7 unnecessary. On the other hand there are
>>> consequences of disabling the controllers later as there are subsystems
>>> doing the controller checks for different decisions. One such incident
>>> is reported [1] regarding the memory controller and its impact on memor=
y
>>> reclaim code.
>>>
>>> [1] https://lore.kernel.org/linux-mm/921e53f3-4b13-aab8-4a9e-e83ff15371=
e4@nec.com
>>>
>>> Signed-off-by: Shakeel Butt <shakeelb@google.com>
>>> Reported-by: NOMURA JUNICHI(=1B$BLnB<!!=3D_0l=1B(B) <junichi.nomura@nec=
.com>
>>
>> Nomura, I think you have already tested this patch, so, can you please
>> add your tested-by tag?

Sure, I have confirmed the problem still occurs with v5.13-rc2 and it
disappeared with your patch.

So,
Tested-by: Jun'ichi Nomura <junichi.nomura@nec.com>

--=20
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.=
