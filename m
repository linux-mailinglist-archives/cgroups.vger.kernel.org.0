Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C147CE12F
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 17:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjJRP33 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 11:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJRP33 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 11:29:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B267116
        for <cgroups@vger.kernel.org>; Wed, 18 Oct 2023 08:29:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c9c145bb5bso164945ad.1
        for <cgroups@vger.kernel.org>; Wed, 18 Oct 2023 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697642967; x=1698247767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvT/F9M12lZm/f3D1aGMmIgwqCpKkP/1Cg2t3T9TAg4=;
        b=RxnwkYuY8pHQaXTJFN8ZsRFAUARh0XgSC6WM9hayUMbdkcOaIFujgPcXTGbuwOneE/
         r3kQhOFgUZXcIA12WiDh5XaXVtns44XWRKSFyKckwGNrESodmsQ4Y4+Hy7gUvHscMDb1
         0LI+cYfl1tU+yLKxNCR7lj1Ykrc4vXE3htzax4bVxFJvGijcgI1WkeSu4z23IZGjr4kd
         nOKfcvxXn4vQNTLtIqG2ofzjwfrX6LA1/8WwlFWxHkT5HcRE/hCqfos+QaW8S1hDWMDD
         50MM3a00UWgOt6tVi3w8M+Peoq/PmlMkisonWJcdev+Tv63cTA0scyue+C6Oaqg9zydL
         4BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697642967; x=1698247767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvT/F9M12lZm/f3D1aGMmIgwqCpKkP/1Cg2t3T9TAg4=;
        b=w3TyImnb7w+JmFjlqy+a3pc2n+raaC6qXAi2bsvkjOx6e3P1tiK2plfRIUTZbp0Z7l
         oAzwEOAPS38sC1DEtbnOMp57E7BGRQgWS/y5WRaILR9pzoQ2aeF90c6jHuUY7iWe2il9
         dDPsGvdMgsV0sA2jXV6rVRPCbbN9y+8OvOEFDN51JK+rsEn3OXO2DrgbKjmlpUn6YwtB
         Abm6PMV9VoVoExrOspQWMeKD1pAxxjHcHEMphW7JGSCpJzPdJKCWyTnGGW3imJ9DOPUt
         dv3oS0dt4UXR/yg3LuctzaNMED2MoBD0/IzpAGQC7fY0NUhb03kNxjBEATP5u++JS+8f
         jbWw==
X-Gm-Message-State: AOJu0YzoD+MxZK5KERHHwxVlaY8KsXLBQV1pkpETPQpm8KszroSFHgs4
        FX6Cz7uAU9hYUOcxDF7fQY6QHE97NbFS+KC928AqfA==
X-Google-Smtp-Source: AGHT+IF5hViTClBnqdxspegkUBq7qYbfY2Qcm/p4LWyxEptN20AcF3AhGkl61K5wm8lJmebJ8cI2NX4VWFszp3sJFL4=
X-Received: by 2002:a17:903:1446:b0:1c6:112f:5ceb with SMTP id
 lq6-20020a170903144600b001c6112f5cebmr205416plb.25.1697642966371; Wed, 18 Oct
 2023 08:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231016221900.4031141-1-roman.gushchin@linux.dev>
 <20231016221900.4031141-3-roman.gushchin@linux.dev> <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
In-Reply-To: <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 Oct 2023 08:29:14 -0700
Message-ID: <CALvZod5bxWQ8nwxyxv=ySN-75FEgtCKWussyNyFeDadURQ2XYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm: kmem: add direct objcg pointer to task_struct
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 18, 2023 at 2:52=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
[...]
> >
> > +static struct obj_cgroup *current_objcg_update(void)
> > +{
> > +     struct mem_cgroup *memcg;
> > +     struct obj_cgroup *old, *objcg =3D NULL;
> > +
> > +     do {
> > +             /* Atomically drop the update bit. */
> > +             old =3D xchg(&current->objcg, NULL);
> > +             if (old) {
> > +                     old =3D (struct obj_cgroup *)
> > +                             ((unsigned long)old & ~CURRENT_OBJCG_UPDA=
TE_FLAG);
> > +                     if (old)
> > +                             obj_cgroup_put(old);
> > +
> > +                     old =3D NULL;
> > +             }
> > +
> > +             /* Obtain the new objcg pointer. */
> > +             rcu_read_lock();
> > +             memcg =3D mem_cgroup_from_task(current);
> > +             /*
> > +              * The current task can be asynchronously moved to anothe=
r
> > +              * memcg and the previous memcg can be offlined. So let's
> > +              * get the memcg pointer and try get a reference to objcg
> > +              * under a rcu read lock.
> > +              */
> > +             for (; memcg !=3D root_mem_cgroup; memcg =3D parent_mem_c=
group(memcg)) {
> > +                     objcg =3D rcu_dereference(memcg->objcg);
> > +                     if (likely(objcg && obj_cgroup_tryget(objcg)))
>
> So IIUC here we increase objcg refcount.
>
> > +                             break;
> > +                     objcg =3D NULL;
> > +             }
> > +             rcu_read_unlock();
> > +
> > +             /*
> > +              * Try set up a new objcg pointer atomically. If it
> > +              * fails, it means the update flag was set concurrently, =
so
> > +              * the whole procedure should be repeated.
> > +              */
> > +     } while (!try_cmpxchg(&current->objcg, &old, objcg));
>
> And if this fails we throw objcg away and try again, but we should do
> obj_cgroup_put(objcg) first, as otherwise it would cause a leak?
>

Indeed there is a reference leak here.
