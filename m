Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B94FE30
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2019 18:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfD3Qyp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Apr 2019 12:54:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50260 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfD3Qyo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Apr 2019 12:54:44 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3UGsLrq030296;
        Tue, 30 Apr 2019 09:54:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ga/EWKOAn9UDB4/9v+JepbeJg373fEqSyzJw4liRsvE=;
 b=J/7lNJ2MO3QohbtmP58ifNjlYxGhac1sL5Qv6kjNPdsSRqsxPLuC/zWpflFo7RfaDV/C
 +avwcZOraofpifkwIPmvxuvtYmZqkwhfJCwj2PnKOmStwjuy/xDC6+NSd/lptRSvAFOh
 p79jbqnfMgOa52UIVxc95dhmotdni6sOAQU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s6h21ssch-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 30 Apr 2019 09:54:23 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 30 Apr 2019 09:54:21 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 30 Apr 2019 09:54:21 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 30 Apr 2019 09:54:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga/EWKOAn9UDB4/9v+JepbeJg373fEqSyzJw4liRsvE=;
 b=KOVM2txMvQR230Okmd0uOBavvnacL3V91C5snYPoXu3pqeRweHszbCnetT6wo2tj0SZPgLgkeSSccg+FQbh2HDnxC9JKP3rE+WrT/Mp4KmEYUXWrlChLH9JVyzAnl5Eh7QcDZsgGniMq2Q0u/eBEOWbjn9/zwfbcAjBveNKqPqs=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1168.namprd15.prod.outlook.com (10.175.2.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 16:54:18 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%10]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 16:54:18 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Kernel Team <Kernel-team@fb.com>,
        viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Topic: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Index: AQHU7lSD68FtcB4UGUOYupgC9AfmOKY1TPCAgACBxACACo6VgIAIioaAgAkx7ACAARa2gIABKdKAgACqaACAAAlcAA==
Date:   Tue, 30 Apr 2019 16:54:18 +0000
Message-ID: <19AF6556-A2A2-435B-9358-CD22CF7BFD9F@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com>
 <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
 <CAKfTPtAFB3gSZYJN1BcjU_XoY=Pfu2xtea+2MEw7FkVc3mwTSA@mail.gmail.com>
 <E97E73F4-CE8C-4CD7-B6B6-5F63A4E881B1@fb.com>
 <F0A127DD-F9B6-4FBE-B9AD-8E8B00A7D676@fb.com>
 <CAKfTPtA_ouYCes9LnYn0quAKm273mi3vP-++GTBtYcQn07xc6Q@mail.gmail.com>
 <A62E5068-4A1E-44E3-99BB-02E98229C1E2@fb.com>
 <CAKfTPtAG3v=37wyLjzkNNK_6HdoMK6WO7AMYfa+G24rq2iyAfg@mail.gmail.com>
In-Reply-To: <CAKfTPtAG3v=37wyLjzkNNK_6HdoMK6WO7AMYfa+G24rq2iyAfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c091:180::4110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a223e25-1f92-4375-9b58-08d6cd8c7c52
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1168;
x-ms-traffictypediagnostic: MWHPR15MB1168:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB116882E2AA6D1EDAF886B17CB33A0@MWHPR15MB1168.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(51914003)(54014002)(6116002)(68736007)(102836004)(2616005)(66556008)(64756008)(71190400001)(71200400001)(66476007)(476003)(66446008)(8676002)(73956011)(91956017)(76176011)(486006)(50226002)(99286004)(81166006)(83716004)(57306001)(76116006)(11346002)(14444005)(5660300002)(256004)(2906002)(81156014)(478600001)(86362001)(966005)(446003)(8936002)(6486002)(36756003)(186003)(561944003)(53936002)(6916009)(33656002)(305945005)(6512007)(14454004)(6436002)(229853002)(25786009)(7736002)(82746002)(54906003)(93886005)(6506007)(66946007)(316002)(53546011)(97736004)(4326008)(6306002)(46003)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1168;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WQsBD6pbCqOjJev96qbPB4VUbY8SURaVX2v93xFCO1/eD6HOF7VQmYE3ypzLxKErumxgkTf55N083CG4GeRbCbwuTXONRgYN9vPcSaxeWGEuEix8kaNnNfMUiYARvZuaaB7isyIomVe3hkm5wjrZCVbSxnR28g/trMxyIEES63cksU/5EGpq7blzMHpT/hBkaRatZOrnH0p1SUOptHxi0bUh0wVUvR6RfmFvXnIHn3llKMGI9CVWa+QqmdBpHI615fHpy/DvT1qbN2EzP13EUp6hcbYetVcL8LM4eVmg5xR6QLhqB7Q85dSLaGX3KWf7oNtrE+YX7dzUu3NlRTLRgV/S7nszcBK5fBzGPIFmBv2UVLLdfPY5wCAPidQ3QB2ibtGhcX645YCOHK72Kgsmyk4+D3Mejwby3H1Z9V8O16U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D44450EECA858B4782EE638B5EF2A540@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a223e25-1f92-4375-9b58-08d6cd8c7c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 16:54:18.2466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1168
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Apr 30, 2019, at 12:20 PM, Vincent Guittot <vincent.guittot@linaro.org=
> wrote:
>=20
> Hi Song,
>=20
> On Tue, 30 Apr 2019 at 08:11, Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Apr 29, 2019, at 8:24 AM, Vincent Guittot <vincent.guittot@linaro.or=
g> wrote:
>>>=20
>>> Hi Song,
>>>=20
>>> On Sun, 28 Apr 2019 at 21:47, Song Liu <songliubraving@fb.com> wrote:
>>>>=20
>>>> Hi Morten and Vincent,
>>>>=20
>>>>> On Apr 22, 2019, at 6:22 PM, Song Liu <songliubraving@fb.com> wrote:
>>>>>=20
>>>>> Hi Vincent,
>>>>>=20
>>>>>> On Apr 17, 2019, at 5:56 AM, Vincent Guittot <vincent.guittot@linaro=
.org> wrote:
>>>>>>=20
>>>>>> On Wed, 10 Apr 2019 at 21:43, Song Liu <songliubraving@fb.com> wrote=
:
>>>>>>>=20
>>>>>>> Hi Morten,
>>>>>>>=20
>>>>>>>> On Apr 10, 2019, at 4:59 AM, Morten Rasmussen <morten.rasmussen@ar=
m.com> wrote:
>>>>>>>>=20
>>>>>>=20
>>>>>>>>=20
>>>>>>>> The bit that isn't clear to me, is _why_ adding idle cycles helps =
your
>>>>>>>> workload. I'm not convinced that adding headroom gives any latency
>>>>>>>> improvements beyond watering down the impact of your side jobs. AF=
AIK,
>>>>>>>=20
>>>>>>> We think the latency improvements actually come from watering down =
the
>>>>>>> impact of side jobs. It is not just statistically improving average
>>>>>>> latency numbers, but also reduces resource contention caused by the=
 side
>>>>>>> workload. I don't know whether it is from reducing contention of AL=
Us,
>>>>>>> memory bandwidth, CPU caches, or something else, but we saw reduced
>>>>>>> latencies when headroom is used.
>>>>>>>=20
>>>>>>>> the throttling mechanism effectively removes the throttled tasks f=
rom
>>>>>>>> the schedule according to a specific duty cycle. When the side job=
 is
>>>>>>>> not throttled the main workload is experiencing the same latency i=
ssues
>>>>>>>> as before, but by dynamically tuning the side job throttling you c=
an
>>>>>>>> achieve a better average latency. Am I missing something?
>>>>>>>>=20
>>>>>>>> Have you looked at your distribution of main job latency and tried=
 to
>>>>>>>> compare with when throttling is active/not active?
>>>>>>>=20
>>>>>>> cfs_bandwidth adjusts allowed runtime for each task_group each peri=
od
>>>>>>> (configurable, 100ms by default). cpu.headroom logic applies gentle
>>>>>>> throttling, so that the side workload gets some runtime in every pe=
riod.
>>>>>>> Therefore, if we look at time window equal to or bigger than 100ms,=
 we
>>>>>>> don't really see "throttling active time" vs. "throttling inactive =
time".
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> I'm wondering if the headroom solution is really the right solutio=
n for
>>>>>>>> your use-case or if what you are really after is something which i=
s
>>>>>>>> lower priority than just setting the weight to 1. Something that
>>>>>>>=20
>>>>>>> The experiments show that, cpu.weight does proper work for priority=
: the
>>>>>>> main workload gets priority to use the CPU; while the side workload=
 only
>>>>>>> fill the idle CPU. However, this is not sufficient, as the side wor=
kload
>>>>>>> creates big enough contention to impact the main workload.
>>>>>>>=20
>>>>>>>> (nearly) always gets pre-empted by your main job (SCHED_BATCH and
>>>>>>>> SCHED_IDLE might not be enough). If your main job consist
>>>>>>>> of lots of relatively short wake-ups things like the min_granulari=
ty
>>>>>>>> could have significant latency impact.
>>>>>>>=20
>>>>>>> cpu.headroom gives benefits in addition to optimizations in pre-emp=
t
>>>>>>> side. By maintaining some idle time, fewer pre-empt actions are
>>>>>>> necessary, thus the main workload will get better latency.
>>>>>>=20
>>>>>> I agree with Morten's proposal, SCHED_IDLE should help your latency
>>>>>> problem because side job will be directly preempted unlike normal cf=
s
>>>>>> task even lowest priority.
>>>>>> In addition to min_granularity, sched_period also has an impact on t=
he
>>>>>> time that a task has to wait before preempting the running task. Als=
o,
>>>>>> some sched_feature like GENTLE_FAIR_SLEEPERS can also impact the
>>>>>> latency of a task.
>>>>>>=20
>>>>>> It would be nice to know if the latency problem comes from contentio=
n
>>>>>> on cache resources or if it's mainly because you main load waits
>>>>>> before running on a CPU
>>>>>>=20
>>>>>> Regards,
>>>>>> Vincent
>>>>>=20
>>>>> Thanks for these suggestions. Here are some more tests to show the im=
pact
>>>>> of scheduler knobs and cpu.headroom.
>>>>>=20
>>>>> side-load | cpu.headroom | side/cpu.weight | min_gran | cpu-idle | ma=
in/latency
>>>>> ---------------------------------------------------------------------=
-----------
>>>>> none    |      0       |     n/a         |    1 ms  |  45.20%  |   1.=
00
>>>>> ffmpeg   |      0       |      1          |   10 ms  |   3.38%  |   1=
.46
>>>>> ffmpeg   |      0       |   SCHED_IDLE    |    1 ms  |   5.69%  |   1=
.42
>>>>> ffmpeg   |    20%       |   SCHED_IDLE    |    1 ms  |  19.00%  |   1=
.13
>>>>> ffmpeg   |    30%       |   SCHED_IDLE    |    1 ms  |  27.60%  |   1=
.08
>>>>>=20
>>>>> In all these cases, the main workload is loaded with same level of
>>>>> traffic (request per second). Main workload latency numbers are norma=
lized
>>>>> based on the baseline (first row).
>>>>>=20
>>>>> For the baseline, the main workload runs without any side workload, t=
he
>>>>> system has about 45.20% idle CPU.
>>>>>=20
>>>>> The next two rows compare the impact of scheduling knobs cpu.weight a=
nd
>>>>> sched_min_granularity. With cpu.weight of 1 and min_granularity of 10=
ms,
>>>>> we see a latency of 1.46; with SCHED_IDLE and min_granularity of 1ms,=
 we
>>>>> see a latency of 1.42. So SCHED_IDLE and min_granularity help protect=
ing
>>>>> the main workload. However, it is not sufficient, as the latency over=
head
>>>>> is high (>40%).
>>>>>=20
>>>>> The last two rows show the benefit of cpu.headroom. With 20% headroom=
,
>>>>> the latency is 1.13; while with 30% headroom, the latency is 1.08.
>>>>>=20
>>>>> We can also see a clear correlation between latency and global idle C=
PU:
>>>>> more idle CPU yields better lower latency.
>>>>>=20
>>>>> Over all, these results show that cpu.headroom provides effective
>>>>> mechanism to control the latency impact of side workloads. Other knob=
s
>>>>> could also help the latency, but they are not as effective and flexib=
le
>>>>> as cpu.headroom.
>>>>>=20
>>>>> Does this analysis address your concern?
>>>=20
>>> So, you results show that sched_idle class doesn't provide the
>>> intended behavior because it still delay the scheduling of sched_other
>>> tasks. In fact, the wakeup path of the scheduler doesn't make any
>>> difference between a cpu running a sched_other and a cpu running a
>>> sched_idle when looking for the idlest cpu and it can create some
>>> contentions between sched_other tasks whereas a cpu runs sched_idle
>>> task.
>>=20
>> I don't think scheduling delay is the only (or dominating) factor of
>> extra latency. Here are some data to show it.
>>=20
>> I measured IPC (instructions per cycle) of the main workload under
>> different scenarios:
>>=20
>> side-load | cpu.headroom | side/cpu.weight  | IPC
>> ----------------------------------------------------
>> none     |     0%       |       N/A        | 0.66
>> ffmpeg   |     0%       |    SCHED_IDLE    | 0.53
>> ffmpeg   |    20%       |    SCHED_IDLE    | 0.58
>> ffmpeg   |    30%       |    SCHED_IDLE    | 0.62
>>=20
>> These data show that the side workload has a negative impact on the
>> main workload's IPC. And cpu.headroom could help reduce this impact.
>>=20
>> Therefore, while optimizations in the wakeup path should help the
>> latency; cpu.headroom would add _significant_ benefit on top of that.
>=20
> It seems normal that side workload has a negative impact on IPC
> because of resources sharing but your previous results showed a 42%
> regression of latency with sched_idle which is can't be only linked to
> resources access contention

Agreed. I think both scheduling latency and resource contention=20
contribute noticeable latency overhead to the main workload. The=20
scheduler optimization by Viresh would help reduce the scheduling
latency, but it won't help the resource contention. Hopefully, with=20
optimizations in the scheduler, we can meet the latency target with=20
smaller cpu.headroom. However, I don't think scheduler optimizations=20
will eliminate the need of cpu.headroom, as the resource contention
always exists, and the impact could be significant.=20

Do you have further concerns with this patchset?

Thanks,
Song=20


>>=20
>> Does this assessment make sense?
>>=20
>>=20
>>> Viresh (cced to this email) is working on improving such behavior at
>>> wake up and has sent an patch related to the subject:
>>> https://lkml.org/lkml/2019/4/25/251
>>> I'm curious if this would improve the results.
>>=20
>> I could try it with our workload next week (I am at LSF/MM this
>> week). Also, please keep in mind that this test sometimes takes
>> multiple days to setup and run.
>=20
> Yes. I understand. That would be good to have a simpler setup to
> reproduce the behavior of your setup in order to do preliminary tests
> and analyse the behavior
>=20
>>=20
>> Thanks,
>> Song
>>=20
>>>=20
>>> Regards,
>>> Vincent
>>>=20
>>>>>=20
>>>>> Thanks,
>>>>> Song
>>>>>=20
>>>>=20
>>>> Could you please share your comments and suggestions on this work? Did
>>>> the results address your questions/concerns?
>>>>=20
>>>> Thanks again,
>>>> Song
>>>>=20
>>>>>>=20
>>>>>>>=20
>>>>>>> Thanks,
>>>>>>> Song
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Morten

