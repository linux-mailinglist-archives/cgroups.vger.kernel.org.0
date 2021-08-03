Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07203DE9B9
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 11:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhHCJec (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 05:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbhHCJea (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 05:34:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2867EC06175F
        for <cgroups@vger.kernel.org>; Tue,  3 Aug 2021 02:34:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a8so5891478pjk.4
        for <cgroups@vger.kernel.org>; Tue, 03 Aug 2021 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uKry6437Xp6Cf4/+d9KizqA/vEa0Seh7ohaGTHEkQRc=;
        b=jJSoKtxZLFGJsuHj4iRJutAau6/uyzXm6P/XrBQP8N/tWoP3JGt/AGyn6/lzAbAH6P
         Zt9n9Ky+kJZ3LPTz8kUGiQa8YnjrPkUConDYDrlO0sSprOQutiy+VSlNHYBgtHWQusxK
         Nu8FeHReiJE2X0NJ0joTxrWU8roZfTCalVdkVJ7z7aTS4rNFoZHwBz4y0eJp5OnTeK+N
         PWIRibE9ECjZp7W0rBztj0NK6dGh4uqsULKawfCwwOZ8/MSdApUf3gRZ1Av9H5T+oQME
         y1/9LHFbyW6vjL4W1EUmt4ymt40U+P/vxW6ehXYMHqvifB15/EPQVeNk7OeLkpBRRV+8
         S3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uKry6437Xp6Cf4/+d9KizqA/vEa0Seh7ohaGTHEkQRc=;
        b=WDns0wdVlZikhyENSfOgPAmzlYTZOF7myGBGvCEUQOFfftyp47jxMattrzrLDoGt+E
         OsV0Cnr+Q4yigj5aRTgBHfKtgpCG+0cSd5/D1/aA0S1BnlsVAQweXmRTvSXBPlaz/oNs
         9XnTn5+gSWDppJK78nuGZXO0t/4k6rOscoGJGi6JBnOC+H5WPDTcwfgHNMd7az+glzkH
         OBRtBTt99HMhbgtiLgk2QEclp5KH5slaOBmU04AzIf/mWnY48KqfGP/zQBvyI1RreQyK
         JpFtD3SF8UdtwcseS2HTT42tNAKaxy1tK9we2+0P161JsEEC41OSAWaI+6kNefoO6Ydw
         Mtrw==
X-Gm-Message-State: AOAM532IQ0maLQKcRG0OiQJt5PcyhXw/B8zu0q4ZYMpR5zZLkbN0Anyt
        2AnGHfQMYOnGmJxtzUc6GNFyuZCxSv567q0nN7CcFA==
X-Google-Smtp-Source: ABdhPJz2eL9+KnSbDZNwM0YYYYGMT6pJ/BeAYhrgUuoii3Olu5MvKl+um75Cpx+zl0QxdTmEnIpsGAjrMAaeSPlTcl8=
X-Received: by 2002:a17:902:b909:b029:12c:a6a2:b1c6 with SMTP id
 bf9-20020a170902b909b029012ca6a2b1c6mr4556059plb.20.1627983258709; Tue, 03
 Aug 2021 02:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210729125755.16871-1-linmiaohe@huawei.com> <20210729125755.16871-3-linmiaohe@huawei.com>
 <YQNsxVPsRSBZcfGG@carbon.lan> <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
 <4a3c23c4-054c-2896-29c5-8cf9a4deee98@huawei.com> <YQi6lOT6j2DtOGlT@carbon.dhcp.thefacebook.com>
 <95629d91-6ae8-b445-e7fc-b51c888cad59@huawei.com>
In-Reply-To: <95629d91-6ae8-b445-e7fc-b51c888cad59@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 3 Aug 2021 17:33:41 +0800
Message-ID: <CAMZfGtUChsJO1UrgmP6M274UwiHap0_yzCBL+mDq1OosP7JNsA@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 3, 2021 at 2:29 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2021/8/3 11:40, Roman Gushchin wrote:
> > On Sat, Jul 31, 2021 at 10:29:52AM +0800, Miaohe Lin wrote:
> >> On 2021/7/30 14:50, Michal Hocko wrote:
> >>> On Thu 29-07-21 20:06:45, Roman Gushchin wrote:
> >>>> On Thu, Jul 29, 2021 at 08:57:52PM +0800, Miaohe Lin wrote:
> >>>>> Since percpu_charge_mutex is only used inside drain_all_stock(), we=
 can
> >>>>> narrow the scope of percpu_charge_mutex by moving it here.
> >>>>>
> >>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>>>> ---
> >>>>>  mm/memcontrol.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>>>> index 6580c2381a3e..a03e24e57cd9 100644
> >>>>> --- a/mm/memcontrol.c
> >>>>> +++ b/mm/memcontrol.c
> >>>>> @@ -2050,7 +2050,6 @@ struct memcg_stock_pcp {
> >>>>>  #define FLUSHING_CACHED_CHARGE   0
> >>>>>  };
> >>>>>  static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
> >>>>> -static DEFINE_MUTEX(percpu_charge_mutex);
> >>>>>
> >>>>>  #ifdef CONFIG_MEMCG_KMEM
> >>>>>  static void drain_obj_stock(struct obj_stock *stock);
> >>>>> @@ -2209,6 +2208,7 @@ static void refill_stock(struct mem_cgroup *m=
emcg, unsigned int nr_pages)
> >>>>>   */
> >>>>>  static void drain_all_stock(struct mem_cgroup *root_memcg)
> >>>>>  {
> >>>>> + static DEFINE_MUTEX(percpu_charge_mutex);
> >>>>>   int cpu, curcpu;
> >>>>
> >>>> It's considered a good practice to protect data instead of code path=
s. After
> >>>> the proposed change it becomes obvious that the opposite is done her=
e: the mutex
> >>>> is used to prevent a simultaneous execution of the code of the drain=
_all_stock()
> >>>> function.
> >>>
> >>> The purpose of the lock was indeed to orchestrate callers more than a=
ny
> >>> data structure consistency.
> >>>
> >>>> Actually we don't need a mutex here: nobody ever sleeps on it. So I'=
d replace
> >>>> it with a simple atomic variable or even a single bitfield. Then the=
 change will
> >>>> be better justified, IMO.
> >>>
> >>> Yes, mutex can be replaced by an atomic in a follow up patch.
> >>>
> >>
> >> Thanks for both of you. It's a really good suggestion. What do you mea=
n is something like below=EF=BC=9F
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index 616d1a72ece3..508a96e80980 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -2208,11 +2208,11 @@ static void refill_stock(struct mem_cgroup *me=
mcg, unsigned int nr_pages)
> >>   */
> >>  static void drain_all_stock(struct mem_cgroup *root_memcg)
> >>  {
> >> -       static DEFINE_MUTEX(percpu_charge_mutex);
> >>         int cpu, curcpu;
> >> +       static atomic_t drain_all_stocks =3D ATOMIC_INIT(-1);
> >>
> >>         /* If someone's already draining, avoid adding running more wo=
rkers. */
> >> -       if (!mutex_trylock(&percpu_charge_mutex))
> >> +       if (!atomic_inc_not_zero(&drain_all_stocks))
> >>                 return;
> >
> > It should work, but why not a simple atomic_cmpxchg(&drain_all_stocks, =
0, 1) and
> > initialize it to 0? Maybe it's just my preference, but IMO (0, 1) is ea=
sier
> > to understand than (-1, 0) here. Not a strong opinion though, up to you=
.
> >
>
> I think this would improve the readability. What you mean is something li=
ke below ?
>
> Many thanks.
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 616d1a72ece3..6210b1124929 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2208,11 +2208,11 @@ static void refill_stock(struct mem_cgroup *memcg=
, unsigned int nr_pages)
>   */
>  static void drain_all_stock(struct mem_cgroup *root_memcg)
>  {
> -       static DEFINE_MUTEX(percpu_charge_mutex);
>         int cpu, curcpu;
> +       static atomic_t drainer =3D ATOMIC_INIT(0);
>
>         /* If someone's already draining, avoid adding running more worke=
rs. */
> -       if (!mutex_trylock(&percpu_charge_mutex))
> +       if (atomic_cmpxchg(&drainer, 0, 1) !=3D 0)

I'd like to use atomic_cmpxchg_acquire() here.

>                 return;
>         /*
>          * Notify other cpus that system-wide "drain" is running
> @@ -2244,7 +2244,7 @@ static void drain_all_stock(struct mem_cgroup *root=
_memcg)
>                 }
>         }
>         put_cpu();
> -       mutex_unlock(&percpu_charge_mutex);
> +       atomic_set(&drainer, 0);

So use atomic_set_release() here to cooperate with
atomic_cmpxchg_acquire().

Thanks.

>  }
>
> > Thanks!
> > .
> >
>
