Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC3D01D0F3
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2019 22:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfENU65 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 16:58:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfENU65 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 May 2019 16:58:57 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EKrBxO011159;
        Tue, 14 May 2019 13:58:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vGfxxx7ynQxiHzJwgifK140qhBCPYAw4G3XpHKPfuTU=;
 b=gmfws8zX0OboxV6w+zsUQdMFVnthlKoHoYpsXXvwFRcOAbPDBheLCR2bt+LkApe1FIE/
 c9sAYAuxXbKsElzQQ5/AwaCBNhjb9PZvBwnkCy5zu74Z+tDq7/ATlVXB/CdY0ls0BXZw
 19nyQ9S/NvRQMSGt4ACWyF7LFx/RNZ+UahE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sfqq2jyvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 May 2019 13:58:35 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 May 2019 13:58:33 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 May 2019 13:58:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGfxxx7ynQxiHzJwgifK140qhBCPYAw4G3XpHKPfuTU=;
 b=X8MepOHB3lgUXq+mSwr0tJmfKc/kt0a4xeuMLjqN/R8LmlgpeaVfAk3WXbgdRlQ4CPrCQDto9NHKwQmtHU8F33zgyAd1gVcMo3TF8IElKwlLPPST52UnDLZnDOJUvaYm9lb1h6iYPHTtWKkGiH0aFY1CjoB6G5gxx5voSRJrau0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1135.namprd15.prod.outlook.com (10.175.2.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Tue, 14 May 2019 20:58:32 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1878.024; Tue, 14 May 2019
 20:58:32 +0000
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
Thread-Index: AQHU7lSD68FtcB4UGUOYupgC9AfmOKY1TPCAgACBxACACo6VgIAIioaAgAkx7ACAARa2gIABKdKAgACqaACAAAlcAIAP0BQAgAZ0zoA=
Date:   Tue, 14 May 2019 20:58:31 +0000
Message-ID: <0C1325C9-DE18-42C6-854D-64433ABD6FC3@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com>
 <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
 <CAKfTPtAFB3gSZYJN1BcjU_XoY=Pfu2xtea+2MEw7FkVc3mwTSA@mail.gmail.com>
 <E97E73F4-CE8C-4CD7-B6B6-5F63A4E881B1@fb.com>
 <F0A127DD-F9B6-4FBE-B9AD-8E8B00A7D676@fb.com>
 <CAKfTPtA_ouYCes9LnYn0quAKm273mi3vP-++GTBtYcQn07xc6Q@mail.gmail.com>
 <A62E5068-4A1E-44E3-99BB-02E98229C1E2@fb.com>
 <CAKfTPtAG3v=37wyLjzkNNK_6HdoMK6WO7AMYfa+G24rq2iyAfg@mail.gmail.com>
 <19AF6556-A2A2-435B-9358-CD22CF7BFD9F@fb.com>
 <2E7A1CDA-0384-474E-9011-5B209A1A58DF@fb.com>
In-Reply-To: <2E7A1CDA-0384-474E-9011-5B209A1A58DF@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:e039]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11c598c1-20ab-4580-0bbd-08d6d8aeec5a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1135;
x-ms-traffictypediagnostic: MWHPR15MB1135:
x-microsoft-antispam-prvs: <MWHPR15MB1135B65B381CB5A98C626339B3080@MWHPR15MB1135.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(39860400002)(136003)(396003)(366004)(51914003)(189003)(199004)(81166006)(102836004)(83716004)(14444005)(256004)(54906003)(81156014)(8676002)(8936002)(6512007)(99286004)(50226002)(71200400001)(6436002)(71190400001)(229853002)(305945005)(6486002)(57306001)(5660300002)(2906002)(86362001)(14454004)(25786009)(478600001)(6916009)(30864003)(82746002)(53546011)(53936002)(36756003)(46003)(33656002)(4326008)(6246003)(2616005)(76176011)(7736002)(316002)(486006)(6506007)(68736007)(66556008)(66446008)(76116006)(66946007)(66476007)(64756008)(73956011)(186003)(11346002)(6116002)(446003)(476003)(561944003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1135;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I22xRKhSm0ExnKVgDAA8C1S3hy2fZ5hX2nJBKLc9Q0LzWVHJCpptuDD4XH0OLdjq+jeo+5QHbupDGsiDoOk3V6XhZ/6nYGtVAFMgxupSg4IHSjabDw5kKOzT/ohdIBp3vDg2FGr0WpJxQqnmSj9gaSpGYi8Lm1jb42bSM149q8aiv2ontm6MHPA0NPetV5DxCdSQcAs5ZlLXO8XzqayRT7TBMX7IYTzm5sDUaLe0oyTMz9q/s/QkfA68v+d/6sqh7yi7jgepwm+lfHzLcHwPJZFMyi/rEeJfaoW2PTsjmmeEO0e10Gs5sk9b7aokSybz31xHI/Z9Ha0IY6rpjsE1SQofhQnvPZscWswqksIvztKEP1ld8Pc8/Cqy/ogHQzrS2Ul4v1A3cCxicEe9wYm57p/1Th1BcJ5m21Zb+hSkQPk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F99F34678C1BC34EA4410EB9C4CE875C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c598c1-20ab-4580-0bbd-08d6d8aeec5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 20:58:31.8145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1135
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140139
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Vincent,

> On May 10, 2019, at 11:22 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Apr 30, 2019, at 9:54 AM, Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Apr 30, 2019, at 12:20 PM, Vincent Guittot <vincent.guittot@linaro.o=
rg> wrote:
>>>=20
>>> Hi Song,
>>>=20
>>> On Tue, 30 Apr 2019 at 08:11, Song Liu <songliubraving@fb.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Apr 29, 2019, at 8:24 AM, Vincent Guittot <vincent.guittot@linaro.=
org> wrote:
>>>>>=20
>>>>> Hi Song,
>>>>>=20
>>>>> On Sun, 28 Apr 2019 at 21:47, Song Liu <songliubraving@fb.com> wrote:
>>>>>>=20
>>>>>> Hi Morten and Vincent,
>>>>>>=20
>>>>>>> On Apr 22, 2019, at 6:22 PM, Song Liu <songliubraving@fb.com> wrote=
:
>>>>>>>=20
>>>>>>> Hi Vincent,
>>>>>>>=20
>>>>>>>> On Apr 17, 2019, at 5:56 AM, Vincent Guittot <vincent.guittot@lina=
ro.org> wrote:
>>>>>>>>=20
>>>>>>>> On Wed, 10 Apr 2019 at 21:43, Song Liu <songliubraving@fb.com> wro=
te:
>>>>>>>>>=20
>>>>>>>>> Hi Morten,
>>>>>>>>>=20
>>>>>>>>>> On Apr 10, 2019, at 4:59 AM, Morten Rasmussen <morten.rasmussen@=
arm.com> wrote:
>>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> The bit that isn't clear to me, is _why_ adding idle cycles help=
s your
>>>>>>>>>> workload. I'm not convinced that adding headroom gives any laten=
cy
>>>>>>>>>> improvements beyond watering down the impact of your side jobs. =
AFAIK,
>>>>>>>>>=20
>>>>>>>>> We think the latency improvements actually come from watering dow=
n the
>>>>>>>>> impact of side jobs. It is not just statistically improving avera=
ge
>>>>>>>>> latency numbers, but also reduces resource contention caused by t=
he side
>>>>>>>>> workload. I don't know whether it is from reducing contention of =
ALUs,
>>>>>>>>> memory bandwidth, CPU caches, or something else, but we saw reduc=
ed
>>>>>>>>> latencies when headroom is used.
>>>>>>>>>=20
>>>>>>>>>> the throttling mechanism effectively removes the throttled tasks=
 from
>>>>>>>>>> the schedule according to a specific duty cycle. When the side j=
ob is
>>>>>>>>>> not throttled the main workload is experiencing the same latency=
 issues
>>>>>>>>>> as before, but by dynamically tuning the side job throttling you=
 can
>>>>>>>>>> achieve a better average latency. Am I missing something?
>>>>>>>>>>=20
>>>>>>>>>> Have you looked at your distribution of main job latency and tri=
ed to
>>>>>>>>>> compare with when throttling is active/not active?
>>>>>>>>>=20
>>>>>>>>> cfs_bandwidth adjusts allowed runtime for each task_group each pe=
riod
>>>>>>>>> (configurable, 100ms by default). cpu.headroom logic applies gent=
le
>>>>>>>>> throttling, so that the side workload gets some runtime in every =
period.
>>>>>>>>> Therefore, if we look at time window equal to or bigger than 100m=
s, we
>>>>>>>>> don't really see "throttling active time" vs. "throttling inactiv=
e time".
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> I'm wondering if the headroom solution is really the right solut=
ion for
>>>>>>>>>> your use-case or if what you are really after is something which=
 is
>>>>>>>>>> lower priority than just setting the weight to 1. Something that
>>>>>>>>>=20
>>>>>>>>> The experiments show that, cpu.weight does proper work for priori=
ty: the
>>>>>>>>> main workload gets priority to use the CPU; while the side worklo=
ad only
>>>>>>>>> fill the idle CPU. However, this is not sufficient, as the side w=
orkload
>>>>>>>>> creates big enough contention to impact the main workload.
>>>>>>>>>=20
>>>>>>>>>> (nearly) always gets pre-empted by your main job (SCHED_BATCH an=
d
>>>>>>>>>> SCHED_IDLE might not be enough). If your main job consist
>>>>>>>>>> of lots of relatively short wake-ups things like the min_granula=
rity
>>>>>>>>>> could have significant latency impact.
>>>>>>>>>=20
>>>>>>>>> cpu.headroom gives benefits in addition to optimizations in pre-e=
mpt
>>>>>>>>> side. By maintaining some idle time, fewer pre-empt actions are
>>>>>>>>> necessary, thus the main workload will get better latency.
>>>>>>>>=20
>>>>>>>> I agree with Morten's proposal, SCHED_IDLE should help your latenc=
y
>>>>>>>> problem because side job will be directly preempted unlike normal =
cfs
>>>>>>>> task even lowest priority.
>>>>>>>> In addition to min_granularity, sched_period also has an impact on=
 the
>>>>>>>> time that a task has to wait before preempting the running task. A=
lso,
>>>>>>>> some sched_feature like GENTLE_FAIR_SLEEPERS can also impact the
>>>>>>>> latency of a task.
>>>>>>>>=20
>>>>>>>> It would be nice to know if the latency problem comes from content=
ion
>>>>>>>> on cache resources or if it's mainly because you main load waits
>>>>>>>> before running on a CPU
>>>>>>>>=20
>>>>>>>> Regards,
>>>>>>>> Vincent
>>>>>>>=20
>>>>>>> Thanks for these suggestions. Here are some more tests to show the =
impact
>>>>>>> of scheduler knobs and cpu.headroom.
>>>>>>>=20
>>>>>>> side-load | cpu.headroom | side/cpu.weight | min_gran | cpu-idle | =
main/latency
>>>>>>> -------------------------------------------------------------------=
-------------
>>>>>>> none    |      0       |     n/a         |    1 ms  |  45.20%  |   =
1.00
>>>>>>> ffmpeg   |      0       |      1          |   10 ms  |   3.38%  |  =
 1.46
>>>>>>> ffmpeg   |      0       |   SCHED_IDLE    |    1 ms  |   5.69%  |  =
 1.42
>>>>>>> ffmpeg   |    20%       |   SCHED_IDLE    |    1 ms  |  19.00%  |  =
 1.13
>>>>>>> ffmpeg   |    30%       |   SCHED_IDLE    |    1 ms  |  27.60%  |  =
 1.08
>>>>>>>=20
>>>>>>> In all these cases, the main workload is loaded with same level of
>>>>>>> traffic (request per second). Main workload latency numbers are nor=
malized
>>>>>>> based on the baseline (first row).
>>>>>>>=20
>>>>>>> For the baseline, the main workload runs without any side workload,=
 the
>>>>>>> system has about 45.20% idle CPU.
>>>>>>>=20
>>>>>>> The next two rows compare the impact of scheduling knobs cpu.weight=
 and
>>>>>>> sched_min_granularity. With cpu.weight of 1 and min_granularity of =
10ms,
>>>>>>> we see a latency of 1.46; with SCHED_IDLE and min_granularity of 1m=
s, we
>>>>>>> see a latency of 1.42. So SCHED_IDLE and min_granularity help prote=
cting
>>>>>>> the main workload. However, it is not sufficient, as the latency ov=
erhead
>>>>>>> is high (>40%).
>>>>>>>=20
>>>>>>> The last two rows show the benefit of cpu.headroom. With 20% headro=
om,
>>>>>>> the latency is 1.13; while with 30% headroom, the latency is 1.08.
>>>>>>>=20
>>>>>>> We can also see a clear correlation between latency and global idle=
 CPU:
>>>>>>> more idle CPU yields better lower latency.
>>>>>>>=20
>>>>>>> Over all, these results show that cpu.headroom provides effective
>>>>>>> mechanism to control the latency impact of side workloads. Other kn=
obs
>>>>>>> could also help the latency, but they are not as effective and flex=
ible
>>>>>>> as cpu.headroom.
>>>>>>>=20
>>>>>>> Does this analysis address your concern?
>>>>>=20
>>>>> So, you results show that sched_idle class doesn't provide the
>>>>> intended behavior because it still delay the scheduling of sched_othe=
r
>>>>> tasks. In fact, the wakeup path of the scheduler doesn't make any
>>>>> difference between a cpu running a sched_other and a cpu running a
>>>>> sched_idle when looking for the idlest cpu and it can create some
>>>>> contentions between sched_other tasks whereas a cpu runs sched_idle
>>>>> task.
>>>>=20
>>>> I don't think scheduling delay is the only (or dominating) factor of
>>>> extra latency. Here are some data to show it.
>>>>=20
>>>> I measured IPC (instructions per cycle) of the main workload under
>>>> different scenarios:
>>>>=20
>>>> side-load | cpu.headroom | side/cpu.weight  | IPC
>>>> ----------------------------------------------------
>>>> none     |     0%       |       N/A        | 0.66
>>>> ffmpeg   |     0%       |    SCHED_IDLE    | 0.53
>>>> ffmpeg   |    20%       |    SCHED_IDLE    | 0.58
>>>> ffmpeg   |    30%       |    SCHED_IDLE    | 0.62
>>>>=20
>>>> These data show that the side workload has a negative impact on the
>>>> main workload's IPC. And cpu.headroom could help reduce this impact.
>>>>=20
>>>> Therefore, while optimizations in the wakeup path should help the
>>>> latency; cpu.headroom would add _significant_ benefit on top of that.
>>>=20
>>> It seems normal that side workload has a negative impact on IPC
>>> because of resources sharing but your previous results showed a 42%
>>> regression of latency with sched_idle which is can't be only linked to
>>> resources access contention
>>=20
>> Agreed. I think both scheduling latency and resource contention=20
>> contribute noticeable latency overhead to the main workload. The=20
>> scheduler optimization by Viresh would help reduce the scheduling
>> latency, but it won't help the resource contention. Hopefully, with=20
>> optimizations in the scheduler, we can meet the latency target with=20
>> smaller cpu.headroom. However, I don't think scheduler optimizations=20
>> will eliminate the need of cpu.headroom, as the resource contention
>> always exists, and the impact could be significant.=20
>>=20
>> Do you have further concerns with this patchset?
>>=20
>> Thanks,
>> Song=20
>=20
> Here are some more results with both Viresh's patch and the cpu.headroom
> set. In these tests, the side job runs with SCHED_IDLE, so we get benefit
> of Viresh's patch.=20
>=20
> We collected another metric here, average "cpu time" used by the requests=
.
> We also presented "wall time" and "wall - cpu" time. "wall time" is the=20
> same as "latency" in previous results. Basically, "wall time" includes cp=
u=20
> time, scheduling latency, and time spent waiting for data (from data base=
,=20
> memcache, etc.). We don't have good data that separates scheduling latenc=
y
> and time spent waiting for data, so we present "wall - cpu" time, which i=
s=20
> the sum of the two. Time spent waiting for data should not change in thes=
e=20
> tests, so changes in "wall - cpu" mostly comes from scheduling latency.=20
> All the latency numbers are normalized based on the "wall time" of the=20
> first row.=20
>=20
> side job | cpu.headroom |  cpu-idle | wall time | cpu time | wall - cpu
> ------------------------------------------------------------------------
> none    |     n/a      |    42.4%  |   1.00    |   0.31   |   0.69
> ffmpeg   |       0      |    10.8%  |   1.17    |   0.38   |   0.79
> ffmpeg   |     25%      |    22.8%  |   1.08    |   0.35   |   0.73
>=20
> From these results, we can see that Viresh's patch reduces the latency
> overhead of the side job, from 42% (in previous results) to 17%. And=20
> a 25% cpu.headroom further reduces the latency overhead to 8%.=20
> cpu.headroom reduces time spent in "cpu time" and "wall - cpu" time,=20
> which means cpu.headroom yields better IPC and lower scheduling latency.
>=20
> I think these data demonstrate that=20
>=20
>  1. Viresh's work is helpful in reducing scheduling latency introduced=20
>     by SCHED_IDLE side jobs.=20
>  2. cpu.headroom work provides mechanism to further reduce scheduling
>     latency on top of Viresh's work.=20
>=20
> Therefore, the combination of the two work would give us mechanisms to=20
> control the latency overhead of side workloads.=20
>=20
> @Vincent, do these data and analysis make sense from your point of view?

Do you have further questions/concerns with this set?=20

As the data shown, scheduling latency is not the only resource of high
latency here. In fact, with hyper threading and other shared system=20
resources (cache, memory, etc.), side workload would always negatively
impact the latency of the main workload. It is impossible to eliminate
these impacts with scheduler optimizations. On the other hand,=20
cpu.headroom provides mechanism to limit such impact.=20

Optimization and protection are two sides of the problem. While we=20
spend a lot of time optimizing the workload (so Viresh's work is really
interesting for us), cpu.headroom works on the protection side. There=20
are multiple reasons behind the high latencies. cpu.headroom provides=20
universal protection against all these.=20

With the protection of cpu.headroom, we can actually do optimizations=20
more efficiently, as we can safely start with a high headroom, and=20
then try to lower it.

Please let me know your thoughts on this.=20

Thanks,
Song



