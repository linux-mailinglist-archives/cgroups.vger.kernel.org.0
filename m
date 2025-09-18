Return-Path: <cgroups+bounces-10228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33B1B82E13
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 06:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA204A3785
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 04:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2F4221544;
	Thu, 18 Sep 2025 04:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fi9XWkQM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5710881E
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 04:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169369; cv=none; b=lza6h54emiewpCvhqhrJAWEFLwg6LEx0RQ5xRbDIkKUR8sO8VJSwac/yAXRAsrFGF1QfTKrzMX9C72XvwEfYSxhrqHQVsTC+pGNaKZNLMjva7HER/Wh9+Am7p8SdZt+tDnI++VAAhrERg19akN++QxN7TBkFpB6zRcJXtoKdwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169369; c=relaxed/simple;
	bh=Ru2G+wzqfu+8Ies7WiStQjgGukOGhgoTbUo3LPNAcW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u52qzT8iK7M34TJksid7OTEA40lB/ZxXoKqf2seR93PuEYEfXUuRt32fzEQ0Yr3Ai5ddlI0nrAnPHPjU+PnZdz+cEqe7d/45HqMk3mUbSZ8DYi7vL48wpMfNO8V8jC3sDdJ4zh0SVxL39QL1RNwUb3YIbMdMnLJH7gzRYMrXC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fi9XWkQM; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-62ef0cd926dso167638d50.0
        for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 21:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758169367; x=1758774167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5pp/oS3nVAP+usoANTjckqknf/ZBESQ3tB7xPv6m/A=;
        b=Fi9XWkQM90yTq6A5lm8xyf+e+cCFR2TOmc+OfyFGh5a4aLPFMmoUAHU/KZyGn6anSR
         PB10Vs6TwiQxCITAc6UQJ83+v4E2sPcQZpeLhuU0WL43wBPJ1Ka08oMjn9AXM6yGhSIN
         qLfzF+Ke0I1NIQdxYEeqL2t6Xp1oX6UhdE6Ewxg86NVOFQKqwGMZe+oLejKtPlhCA/8u
         zxRn2ImNRLJRqjoLpS18EINfB03bJ0/6rE0iLTHLJCz95d2M3PQ5CBALki5xXlOwaFu+
         EtzDzx+UDIW/WZN68M36NJSHdTRpUm9MRGsbvmpXPCPFX4XozMNq/wJoulbEhitzH4Lj
         p8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758169367; x=1758774167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5pp/oS3nVAP+usoANTjckqknf/ZBESQ3tB7xPv6m/A=;
        b=bAQI/D0codDv2N81N73tj5elTpNpj5lIZcDuTJ3Awjzzy4v8EnAj590M2YBorQ9diX
         v505e6KEOnjncDgSaJ0rq9fJfb4PrKJa7LgaqIC3lvx23eF26QYDsUG1WXL+6AQ4GbN3
         FHWcjrUXjkeiN8Ih8u7Dp22KI5fJ+rh+En9wAUJM2ung85SJL7giSX2yV83vcINlyWtV
         cg1Km+oEGHwTLTKjHoVkAooUEhcVtVJ36B+2DvOHzpl9vN8KzuJw5NQ0MmiFXWcx+JXv
         QP2r8wKFm5fbZy+CEYEc53PgpZ040fCz4spZsbXzHpWsD+n3kNLIKsgEjFSD6lnTEZoT
         YRKQ==
X-Gm-Message-State: AOJu0Yz+FyeZBrR0enRtmXKZFuwCFen4ZrvHsm00BMVOkXW33A6u4tLu
	AaoSAH0Yze+iLaSlt6JkW2kIcLwFZWLQMiTPp3TgVA1NqeKjKdTrbAaoJkKYqyNxVvS9Xva4MQ7
	nyW9zOBeKpFAB8bAlymaUNQ81VNETtLeQe86rY6CLLA==
X-Gm-Gg: ASbGncvYz3mdR411aezNYXC2on/RG+qd0I0taJ6n7LQ8kwX9aKR37xVN4fsN949I5E/
	5WxYHGyFgqb/fSZu2CAhZPTrFTZ/4O6demkTkKuRrZCQObpE5QTgxuunoRmvJxTmZ12qqZVOAAR
	fgfAGIRVnxxmtYOHxd7TThxmP2YKwBD8J21j+k6KejVCgEn+vw5n65jcxPFkHQnXRetnBtXTe4o
	CrxeZGSoBYv6W9WgwmArplNoxta6jBo2cF9JPd67S+iCw==
X-Google-Smtp-Source: AGHT+IH1+pFBZYesJAGB/eDlyPRl1lwhllXbWPu8DzgLWXG1lUHj/S0Zkn6lerF5ywoX/cS1ZFItEI0As+9HXKQT3ss=
X-Received: by 2002:a05:690e:d48:b0:629:ec90:c456 with SMTP id
 956f58d0204a3-633b06a5a8cmr2982235d50.23.1758169366517; Wed, 17 Sep 2025
 21:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917212959.355656-1-sunjunchao@bytedance.com>
 <20250917152155.5a8ddb3e4ff813289ea0b4c9@linux-foundation.org>
 <CAHSKhtdt9n-K6KGXTwofpRPo-pH0-YoKFLtEe3Z4CszmNL0rCg@mail.gmail.com> <20250917202606.4fac2c6852abc5ba8894f8ee@linux-foundation.org>
In-Reply-To: <20250917202606.4fac2c6852abc5ba8894f8ee@linux-foundation.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Thu, 18 Sep 2025 12:22:35 +0800
X-Gm-Features: AS18NWBGJrlfGJ_PCm5TEC9HMRnBe4IoEXTWlHp5_aRNtYzwBhtuIlMrUElbbfc
Message-ID: <CAHSKhtdPGuMW0jRRgARGt+ZdnC02v9O11=ofsgRmnZny3c5aaw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6] memcg: Don't wait writeback completion
 when release memcg.
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, tj@kernel.org, 
	muchun.song@linux.dev, venkat88@linux.ibm.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	Lance Yang <lance.yang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 18, 2025 at 11:26=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 18 Sep 2025 11:03:18 +0800 Julian Sun <sunjunchao@bytedance.com> =
wrote:
>
> > Hi,
> > Thanks for your review and comments.
> >
> > On Thu, Sep 18, 2025 at 6:22=E2=80=AFAM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Thu, 18 Sep 2025 05:29:59 +0800 Julian Sun <sunjunchao@bytedance.c=
om> wrote:
> > >
> > > > Recently, we encountered the following hung task:
> > > >
> > > > INFO: task kworker/4:1:1334558 blocked for more than 1720 seconds.
> > > > [Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy css_free_rwork=
_fn
> > > >
> > > > ...
> > > >
> > > > The direct cause is that memcg spends a long time waiting for dirty=
 page
> > > > writeback of foreign memcgs during release.
> > > >
> > > > The root causes are:
> > > >     a. The wb may have multiple writeback tasks, containing million=
s
> > > >        of dirty pages, as shown below:
> > > >
> > > > >>> for work in list_for_each_entry("struct wb_writeback_work", \
> > > >                                   wb.work_list.address_of_(), "list=
"):
> > > > ...     print(work.nr_pages, work.reason, hex(work))
> > > > ...
> > > > 900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
> > > > 1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
> > > >
> > > > ...
> > > >
> > >
> > > I don't think it's particularly harmful that a dedicated worker threa=
d
> > > has to wait for a long time in this fashion.  It doesn't have anythin=
g
> > > else to do (does it?) and a blocked kernel thread is cheap.
> >
> > It also delays the release of other resources and the update of
> > vmstats and vmevents statistics for the parent cgroup.
>
> This is new - such considerations weren't described in the changelog.
> How much of a problem are these things?

The cost of the release of other resources should be fine, but I'm not
very sure about the impact of delayed statistics..
>
> > But we can put
> > the wb_wait_for_completion() after the release of these resources.
>
> Can we move these actions into the writeback completion path which
> seems to be the most accurate way to do them?

IMHO, it is technically feasible but logically a little bit weird. The
wb_wait_for_completion() here is only used to wait for wb completion
of foreign dirty pages (pages that memcg and writeback ownerships
don't match) and there's no connection between foreign writeback and
release of memcg resources if I'm not missing something.  It's up to
Tejun anyway.
>
> > >
> > > > 3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
> > > > 3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00
> > > >
> > > >     b. The writeback might severely throttled by wbt, with a speed
> > > >        possibly less than 100kb/s, leading to a very long writeback=
 time.
> > > >
> > > > ...
> > > >
> > > >  include/linux/memcontrol.h | 14 +++++++++-
> > > >  mm/memcontrol.c            | 57 ++++++++++++++++++++++++++++++++--=
----
> > > >  2 files changed, 62 insertions(+), 9 deletions(-)
> > >
> > > Seems we're adding a bunch of tricky code to fix a non-problem which
> > > the hung-task detector undesirably reports.
> >
> > Emm.. What is the definition of 'undesirably' here?
>
> Seems the intent here is mainly to prevent the warning.  If that
> warning wasn't coming out, would we bother making these changes?  If
> no, just kill the warning.

Got it. Seems like there's no more impact other than the pesky warning.
BTW, I'm also seeing many hung task warnings when the mount/umount
syscall is waiting for the s_umount semaphore=E2=80=94while s_umount is hel=
d
by the writeback code path. I think the hung task is also undesirable,
right? Since AFAICS there's also no more impact instead of the pesky
warnings.
>
> > >
> > > Would a better fix be to simply suppress the warning?
> > >
> > > I don't think we presently have a touch_hung_task_detector() (do we?)
> > > but it's presumably pretty simple.  And maybe
> > > touch_softlockup_watchdog) should be taught to call that
> > > touch_hung_task_dectector().
> > >
> > > Another approach might be to set some flag in the task_struct
> > > instructing the hung task detector to ignore this thread.
> >
> > To me, this feels kind of like a workaround rather than a real fix.
>
> I don't see why.  It appears that the kworker's intended role is to
> wait for writeback completion then to finish things up.  Which it does
> just fine, except there's this pesky warning we get.  Therefore: kill
> the pesky warning,
>
> > And these approaches are beyond the scope of memcg,
>
> So expand the scope?  If hung-task doesn't have a way to suppress
> inappropriate warnings then add it and use it.

Sounds good and more general.
>
> > I'm not sure how
> > Tejun thinks about it since he mentioned before wanting to keep the
> > modifications inside the memcg. Given the fact we already have an
> > existing solution and code, and the scope of impact is confined to
> > memcg, I prefer to use the existing solution.
>
> mmm...  sunk cost fallacy!  Let's just opt for the best solution,
> regardless of cost.

Sure. I will try new approaches if it's fine to Tejun.
>

Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

