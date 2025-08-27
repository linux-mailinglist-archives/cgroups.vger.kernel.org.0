Return-Path: <cgroups+bounces-9449-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74A1B38B25
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 22:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEB51883C70
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 20:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA123081DF;
	Wed, 27 Aug 2025 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BOo2XWDb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663927817F
	for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756327776; cv=none; b=ofHnpiDQFUQB6nCwiY2xpYxLjUfKw5OOueDnZlnUxL1RSSwKe/T3AMzcET+V/gBHGDadH7BivC/knIKci/w3pv/fRN/WG4FqimtSzdrpQDm8zGRI96W+rgf2iIJQ5G3ipUCN8KaelOcoP8QtKMDccWXEzmURvivI+X6SsQekwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756327776; c=relaxed/simple;
	bh=ipRP/ocNYyBznpHG0LS2a73hRVmQOm9PunAs5XtcJFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToV1B5vY4XsDgZo5uwIEbXKR7vi1e7wo6qjm3gFGQPEpuJBMXbBJLSBIbkqYfGdkjjEq5yRm5/sfnT6wxXlV0qi5nBfwE3OkAMDPGEzGth6Y7rjs0qq+8+RhCDmA2mAJ15gZSSqBpQm+Ejm1khhKUJGae+EQ/XK1eKlvE+mrExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BOo2XWDb; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d608e34b4so2030677b3.3
        for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 13:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756327773; x=1756932573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL5nmh3ppB78QbIn88NC3T1+26pYSI02adD9xwWXt+A=;
        b=BOo2XWDbXYkNDrNN2A80sa9QgXfp/y8fbvESGBIgkhSnE5jliW0RpBVw9MxSnUlsgl
         UZeDNjiWx+bqaFNPG3W8oeJZWkQE2xs9I45DQkoKqASR9xNi7eWAnCx5zrd0XmekhlUo
         2LZBkdVFNcTsLc55hb8w+gEbiXYUdlbX+CqN/4wiUBErH+kACjrU7lqJRpmuH65ip0Jd
         NigLgLN9lA7GnnB7jhBWRJ3gqPDC3+V9EWRwRaOdBkvyJTv9FtpEE84CMsB3hexKo7kV
         kv5ePXJIgdMsnwkOhU8a+PNSQ/jreSyrF6OzSQXnxiJsUC3rqzB2hj5HiJC/nD8yoa08
         okLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756327773; x=1756932573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL5nmh3ppB78QbIn88NC3T1+26pYSI02adD9xwWXt+A=;
        b=jrD2KCxjqNAcJFBs0zZeULx1P25TQc9p1A+qj7qMGfhN1hiVu2k7z7OsLQB1NAKP/m
         WgzQL1R5B+HNxGmuKGQrSIL0ilC0Ztpd3OwHvrtCCK4qR7wYVIncbAExll9CBRr7/A+d
         N5TNIqcoKo6re3ewkHbSef4Iby9E1OVFgXsieTk0WMFhywZSBSqivePGweJV6HCvXJcZ
         IeG9tQoSCG+J/jz95EJlR/PF9eGORH6DXklAhdyMwKKOLV48O3Ap9UzpJqbyD+Q4cNM0
         rzrCLjoYdMILWb1cHQ2hZbhkSJp8pT+kavTzoYKfS7TEnRa4pri9mCBbmk5XCIA34TZ3
         T0Pg==
X-Gm-Message-State: AOJu0Yyny/+fnxRQ9anlt4sNqfE8WKnTg0BxmDLB0MBou2qlH1w9VjGa
	RJWPVyDGhcXy4dW3H/lGfs9enR/a1aHb3H7IC93RcKNRHh9C8UrBM9/zCeknr4kC5tG+KBfsw4m
	uP8eXo5uKdgzr+tJFuVrEMihRFmTbHc+WYLdscbcylEw6IL8Z8xZExPG7CEuS
X-Gm-Gg: ASbGncs1zUOUCtbKJUnzrwWaAma+trCS7DIFOSEe2VVOCEHPb2Zf+3BREzBYH0xUfrm
	QAmzgO+olwBRfU+wCu38WIqbWXmtPZRptvp1IS5AIoxTqRSnm5IxCtYkZNWsEWZ+VKJpjJ7kYRL
	Kl1J0Iigpyu+5w/XcIaMtlYRKru8GBBZQJ+eKqWJ9eLohGKdzYTuEpkBJa8GMs1qAtXRvIPvAFw
	I0lC7LVsG0y/uE=
X-Google-Smtp-Source: AGHT+IErdZgRCjak1/43G3fss7a4blvCSHpFjkeSAzDtkW7++OZEHp6XaMKL3yuc2S41gwxWI7nwYUFv7tudGUczZNU=
X-Received: by 2002:a05:690c:64c8:b0:720:c20:dc29 with SMTP id
 00721157ae682-7200c20e1acmr142076817b3.51.1756327773245; Wed, 27 Aug 2025
 13:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827181356.40971-1-sunjunchao@bytedance.com> <aK9VTIQDA8I2vvNi@slm.duckdns.org>
In-Reply-To: <aK9VTIQDA8I2vvNi@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Thu, 28 Aug 2025 04:49:22 +0800
X-Gm-Features: Ac12FXyckmPI8HU5FEqVYGnTf_NT6hjEd-E6J_bWqEanR5Qe3yKWLiMZ0Gc7fyo
Message-ID: <CAHSKhtcqDfQRf1PAVkkR1mfD7AicfFVELM+Y87vzTMZsjCzTWA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, 
	muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 28, 2025 at 2:58=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Aug 28, 2025 at 02:13:56AM +0800, Julian Sun wrote:
> > diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-d=
ev-defs.h
> > index 2ad261082bba..6c1ed286da6a 100644
> > --- a/include/linux/backing-dev-defs.h
> > +++ b/include/linux/backing-dev-defs.h
> > @@ -65,6 +65,13 @@ struct wb_completion {
> >       wait_queue_head_t       *waitq;
> >  };
> >
> > +static inline void wb_completion_init(struct wb_completion *done,
> > +                                                                      =
 struct wait_queue_head *waitq)
>
> Indentation.
>
> > +{
> > +     atomic_set(&done->cnt, 1);
> > +     done->waitq =3D waitq;
> > +}
> > +
> >  #define __WB_COMPLETION_INIT(_waitq) \
> >       (struct wb_completion){ .cnt =3D ATOMIC_INIT(1), .waitq =3D (_wai=
tq) }
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 785173aa0739..24e881ce4909 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -157,11 +157,17 @@ struct mem_cgroup_thresholds {
> >   */
> >  #define MEMCG_CGWB_FRN_CNT   4
> >
> > +struct cgwb_frn_wait {
> > +     struct wb_completion done;
> > +     struct wait_queue_entry wq_entry;
> > +};
> > +
> >  struct memcg_cgwb_frn {
> >       u64 bdi_id;                     /* bdi->id of the foreign inode *=
/
> >       int memcg_id;                   /* memcg->css.id of foreign inode=
 */
> >       u64 at;                         /* jiffies_64 at the time of dirt=
ying */
> > -     struct wb_completion done;      /* tracks in-flight foreign write=
backs */
> > +     struct wb_completion *done;     /* tracks in-flight foreign write=
backs */
> > +     struct cgwb_frn_wait *wait;     /* used to free resources when re=
lease memcg */
>
> Is ->done still needed? Can't it just do frn->wait.done?
>
> > +#ifdef CONFIG_CGROUP_WRITEBACK
> > +static int memcg_cgwb_waitq_callback_fn(struct wait_queue_entry *wq_en=
try, unsigned int mode,
> > +                                     int flags, void *key)
> > +{
> > +     struct cgwb_frn_wait *frn_wait =3D container_of(wq_entry,
> > +                                                   struct cgwb_frn_wai=
t, wq_entry);
> > +
> > +     list_del(&wq_entry->entry);
> > +     kfree(frn_wait);
> > +
> > +     return 0;
> > +}
> > +#endif
>
> Note that the above will be called for all queued waits when any one entr=
y
> triggers. It'd need to check whether done is zero before self-deleting an=
d
> freeing.

Ah, yeah, it does need to.  Have sent v4 to fix it, thanks :)
>
> > @@ -3912,8 +3938,18 @@ static void mem_cgroup_css_free(struct cgroup_su=
bsys_state *css)
> >       int __maybe_unused i;
> >
> >  #ifdef CONFIG_CGROUP_WRITEBACK
> > -     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
> > -             wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> > +     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> > +             struct memcg_cgwb_frn *frn =3D &memcg->cgwb_frn[i];
> > +
> > +             if (atomic_dec_and_test(&frn->done->cnt))
> > +                     kfree(frn->wait);
> > +             else
> > +                     /*
> > +                      * Not necessary to wait for wb completion which =
might cause task hung,
> > +                      * only used to free resources. See memcg_cgwb_wa=
itq_callback_fn().
> > +                      */
> > +                     __add_wait_queue_entry_tail(frn->done->waitq, &fr=
n->wait->wq_entry);
> > +     }
>
> And then, this can probably be simplified to sth like:
>
>         __add_wait_queue_entry_tail(...);
>         if (atomic_dec_and_test(&frn->done->dnt);
>                 wake_up_all(waitq);
>
> Thanks.
>
> --
> tejun



--=20
Julian Sun <sunjunchao@bytedance.com>

