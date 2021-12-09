Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480C946EB58
	for <lists+cgroups@lfdr.de>; Thu,  9 Dec 2021 16:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhLIPg5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Dec 2021 10:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbhLIPg5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Dec 2021 10:36:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E7AC0617A1
        for <cgroups@vger.kernel.org>; Thu,  9 Dec 2021 07:33:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j3so10404078wrp.1
        for <cgroups@vger.kernel.org>; Thu, 09 Dec 2021 07:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O7itgZdM7y3919RO6YNnPvjKLE+tq3HFWAix1utDOx0=;
        b=J6dSXdbyKFMxWHStSJkRVCrEl5Agv0nsilyTn+tFdcaE3R52OMOz1n+GIvJOkypJJf
         1g586dOIQY9Xm/iqkcJFF8ONXSrLJEBGSXgXJkoF5SV2FORrFSZCvbtTEeSYZZF1DByy
         sRouYzLqgLZ9YpNLxrvGYu4dQoal6MNvyuHzNrSEukxE9HgbI4HpPpynhTZRzwNimYof
         ftPFf0yVjeAugz5YlGQhz/npbPnvQavhjgZjzDkVGG55kM600uaPizfu0QFxE2HPGaZ3
         oLRMIdf/WxHeqTKv/jqs4kTO8YGNL/Hm2UrdS7G7CVUvo2HO6AhoCW6Ki1kzp1MMIe15
         BCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O7itgZdM7y3919RO6YNnPvjKLE+tq3HFWAix1utDOx0=;
        b=rad6+9vZPVxw37Yqk6WRek1rsYQo2mLMfLeo56sehIFFyXYgHYvbec37LQzryuEfYW
         5a3m73jMwZS6PnlFQjEyAy7kZiYTgbeomZw94keBirn1cBshoeT5HxXtLYHPPV10+PaS
         8dWHxOQTJYLbp5Kj2ogEOACtbiTv/idFa9DtuWARJaV5jB+RrIT563VyRLga3ptKG+tv
         m9JObfCDfgBC2RIS/g5LfsCzB0qwooQ/zCRCU7cY7dWwylA2ZqnV6yVst0f6uQhVqTNX
         6XAgCH4t0V0y8ZNCI7KMRtqiGQOjMGjv2SwjTwo7VQLyJxZYhIrvOHN4wl41QKOyC1pI
         9FKA==
X-Gm-Message-State: AOAM532KSMdci8ftlN2R0RC5/1WeQVtMyfUenAvDhJ86BbU6rk5PqTn5
        q0JaplYrSBw4Dc0HYgMggexNWw==
X-Google-Smtp-Source: ABdhPJz27KLZraMKPFKO4U0uAs5SUiORkGgyH/Ezz+eC9IdGTXORvkYzcRlS3XYqYpRKhrqg2lEOxg==
X-Received: by 2002:adf:d18f:: with SMTP id v15mr6850521wrc.447.1639064001655;
        Thu, 09 Dec 2021 07:33:21 -0800 (PST)
Received: from [192.168.0.18] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id a9sm31231wrt.66.2021.12.09.07.33.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 07:33:20 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Use after free with BFQ and cgroups
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <f03b2b1c-808a-c657-327d-03165b988e7d@huawei.com>
Date:   Thu, 9 Dec 2021 16:33:17 +0100
Cc:     Jan Kara <jack@suse.cz>,
        =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-block <linux-block@vger.kernel.org>, fvogt@suse.de,
        cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F26C3C5-AC2C-47B9-83FC-17C78E15F14D@linaro.org>
References: <20211125172809.GC19572@quack2.suse.cz>
 <20211126144724.GA31093@blackbody.suse.cz>
 <20211129171115.GC29512@quack2.suse.cz>
 <f03b2b1c-808a-c657-327d-03165b988e7d@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 9 dic 2021, alle ore 03:23, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> =E5=9C=A8 2021/11/30 1:11, Jan Kara =E5=86=99=E9=81=93:
>> On Fri 26-11-21 15:47:24, Michal Koutn=C3=BD wrote:
>>> Hello.
>>>=20
>>> On Thu, Nov 25, 2021 at 06:28:09PM +0100, Jan Kara <jack@suse.cz> =
wrote:
>>> [...]
>>> +Cc cgroups ML
>>> =
https://lore.kernel.org/linux-block/20211125172809.GC19572@quack2.suse.cz/=

>>>=20
>>>=20
>>> I understand there are more objects than blkcgs but I assume it can
>>> eventually boil down to blkcg references, so I suggest another
>>> alternative. (But I may easily miss the relations between BFQ =
objects,
>>> so consider this only high-level opinion.)
>>>=20
>>>> After some poking, looking into crashdumps, and applying some debug =
patches
>>>> the following seems to be happening: We have a process P in blkcg =
G. Now
>>>> G is taken offline so bfq_group is cleaned up in bfq_pd_offline() =
but P
>>>> still holds reference to G from its bfq_queue. Then P submits IO, G =
gets
>>>> inserted into service tree despite being already offline.
>>>=20
>>> (If G is offline, P can only be zombie, just saying. (I guess it can
>>> still be Q's IO on behalf of G.))
>>>=20
>>> IIUC, the reference to G is only held by P. If the G reference is =
copied
>>> into another structure (the service tree) it should get another
>>> reference. My na=C3=AFve proposal would be css_get(). (1)
>> So I was looking into this puzzle. The answer is following:
>> The process P (podman, pid 2571) is currently attached to the root =
cgroup
>> but it has io_context with BFQ queue that points to the =
already-offline G
>> as a parent. The bio is thus associated with the root cgroup (via
>> bio->bi_blkg) but BFQ uses io_context to lookup the BFQ queue where =
IO
>> should be queued and then uses its parent to determine blkg which it =
should
>> be charged and thus gets to the dying cgroup.
>=20
> Hi, Jan
>=20
> After some code review, we found that the root cause of the problem
> semms to be different.
>=20
> If the process is moved from group G to root group, and a new io is
> issued from the process, then bfq should detect this and changing
> bfq_queue's parent to root bfq_group:
>=20
> bfq_insert_request
> bfq_init_rq
>  bfq_bic_update_cgroup
>   serial_nr =3D __bio_blkcg(bio)->css.serial_nr; -> from root group
>   bic->blkcg_serial_nr =3D=3D serial_nr -> this do not pass=EF=BC=8Cbeca=
use bic->blkcg_serial_nr is still from group G
>   __bfq_bic_change_cgroup -> bfq_queue parent will be changed to root =
group
>=20
> And we think the following path is possible to trigger the problem:
>=20
> 1) process P1 and P2 is currently in cgroup C1, corresponding to
> bfq_queue q1, q2 and bfq_group g1. And q1 and q2 are merged:
> q1->next_bfqq =3D q2.
>=20
> 2) move P1 from C1 to root_cgroup, q1->next_bfqq is still q2
> and flag BFQQF_split_coop is not set yet.
>=20
> 3) P2 exit, q2 won't exit because it's still referenced through
> queue merge.
>=20
> 4) delete C1, g1 is offlined
>=20
> 5) issue a new io in q1, q1's parent entity will change to root,
> however the io will end up in q1->next_bfqq =3D q2, and thus the
> offlined g1 is inserted to service tree through q2.
>=20
> 6) P1 exit, q2 exit, and finially g1 is freed, while g1 is still
> in service tree of it's parent.
>=20
> We confirmed this by our reproducer through a simple patch:
> stop merging bfq_queues if their parents are different.
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 1ce1a99a7160..14c1d1c3811e 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2626,6 +2626,11 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct =
bfq_queue *new_bfqq)
>        while ((__bfqq =3D new_bfqq->new_bfqq)) {
>                if (__bfqq =3D=3D bfqq)
>                        return NULL;
> +               if (__bfqq->entity.parent !=3D bfqq->entity.parent) {
> +                       if (bfq_bfqq_coop(__bfqq))
> +                               bfq_mark_bfqq_split_coop(__bfqq);
> +                       return NULL;
> +               }
>                new_bfqq =3D __bfqq;
>        }
>=20
> @@ -2825,8 +2830,16 @@ bfq_setup_cooperator(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
>        if (bfq_too_late_for_merging(bfqq))
>                return NULL;
>=20
> -       if (bfqq->new_bfqq)
> -               return bfqq->new_bfqq;
> +       if (bfqq->new_bfqq) {
> +               struct bfq_queue *new_bfqq =3D bfqq->new_bfqq;
> +
> +               if(bfqq->entity.parent =3D=3D new_bfqq->entity.parent)
> +                       return new_bfqq;
> +
> +               if(bfq_bfqq_coop(new_bfqq))
> +                       bfq_mark_bfqq_split_coop(new_bfqq);
> +               return NULL;
> +       }
>=20
> Do you think this analysis is correct?
>=20

Hi Kuai,
I haven't checked all details, but, for sure, two bfq_queues belonging
to different parent entities (i.e., to different groups) do not have
to be merged.  So, if two bfq_queues happen to be (still) merged while
belonging to different groups, then the scheduler is in an
inconsistent state.  And rules may follow.

Let's see comments from the other people working on this issue.

Thanks for spotting this,
Paolo

> Thanks,
> Kuai
>> Apparently P got recently moved from G to the root cgroup and there =
was
>> reference left in the BFQ queue structure to G.
>>>> IO completes, P exits, bfq_queue pointing to G gets destroyed, the
>>>> last reference to G is dropped, G gets freed although is it still
>>>> inserted in the service tree.  Eventually someone trips over the =
freed
>>>> memory.
>>>=20
>>> Isn't it the bfq_queue.bfq_entity that's inserted in the service =
tree
>>> (not blkcg G)?
>> Yes, it is. But the entity is part of bfq_group structure which is =
the pd
>> for the blkcg.
>>> You write bfq_queue is destroyed, shouldn't that remove it from the
>>> service tree? (2)
>> Yes, BFQ queue is removed from the service trees on destruction. But =
its
>> parent - bfq_group - is not removed from its service tree. And that's =
where
>> we hit the problem.
>>>> Now I was looking into how to best fix this. There are several
>>>> possibilities and I'm not sure which one to pick so that's why I'm =
writing
>>>> to you. bfq_pd_offline() is walking all entities in service trees =
and
>>>> trying to get rid of references to bfq_group (by reparenting =
entities).
>>>> Is this guaranteed to see all entities that point to G? =46rom the =
scenario
>>>> I'm observing it seems this can miss entities pointing to G - e.g. =
if they
>>>> are in idle tree, we will just remove them from the idle tree but =
we won't
>>>> change entity->parent so they still point to G. This can be seen as =
one
>>>> culprit of the bug.
>>>=20
>>> There can be two types of references to blkcg (transitively via
>>> bfq_group):
>>> a) "plain" (just a pointer stored somewhere),
>>> b) "pinned" (marked by css_get() of the respective blkcg).
>>>=20
>>> The bfq_pd_offline() callback should erase all plain references =
(e.g. by
>>> reparenting) or poke the holders of pinned references to release =
(unpin)
>>> them eventually (so that blkcg goes away).
>>>=20
>>> I reckon it's not possible to traverse all references in the
>>> bfq_pd_offline().
>> So bfq_pd_offline() does erase all plain references AFAICT. But later =
it
>> can create new plain references (service tree) from the existing =
"pinned"
>> ones and once pinned references go away, those created plain =
references
>> cause trouble. And the more I'm looking into this the more I'm =
convinced
>> bfq_pd_offline() should be more careful and remove also the pinned
>> references from bfq queues. It actually does it for most queues but =
it can
>> currently miss some... I'll look into that.
>> Thanks for your very good questions and hints!
>> 								Honza

