Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84816445B9F
	for <lists+cgroups@lfdr.de>; Thu,  4 Nov 2021 22:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhKDVad (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Nov 2021 17:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhKDVac (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 4 Nov 2021 17:30:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D14516120F;
        Thu,  4 Nov 2021 21:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1636061274;
        bh=i9bMCMWDq8qHtNLlg+d8d+bhz1QaRU5Lfr6G49bzhRs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W49zmmuOtuvil1F/FB/CNc96Rs+frDTFSY/kBa0OMbA6zracevDH8JNrTJpvcMOLJ
         zvojXYCv8MRxejfqR2v9CDScI5Y2DFrHbUs1yDrF90ozZMDEr0IIqWVxkB4rapy9Xg
         GY7j0KWCbsCGMfp/9cLEdNiwLY4e+eYMvtWFt274=
Date:   Thu, 4 Nov 2021 14:27:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     mkoutny@suse.com, cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org
Subject: Re: [PATCH v2 1/2] memcg: flush stats only if updated
Message-Id: <20211104142751.5ab290d5cf4be1749c9c87ed@linux-foundation.org>
In-Reply-To: <20211014163146.2177266-1-shakeelb@google.com>
References: <20211013180130.GB22036@blackbody.suse.cz>
        <20211014163146.2177266-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 14 Oct 2021 09:31:46 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> Hi Michal,
>=20
> On Wed, Oct 13, 2021 at 11:01 AM Michal Koutn=FD <mkoutny@suse.com> wrote:
> >
> > On Fri, Oct 01, 2021 at 12:00:39PM -0700, Shakeel Butt <shakeelb@google=
.com> wrote:
> > > In this patch we kept the stats update codepath very minimal and let =
the
> > > stats reader side to flush the stats only when the updates are over a
> > > specific threshold. =A0For now the threshold is (nr_cpus * CHARGE_BAT=
CH).
> >
> > BTW, a noob question -- are the updates always single page sized?
> >
> > This is motivated by apples vs oranges comparison since the
> > =A0 =A0 =A0 =A0 nr_cpus * MEMCG_CHARGE_BATCH
> > suggests what could the expected error be in pages (bytes). But it's mo=
stly
> > wrong since: a) uncertain single-page updates, b) various counter
> > updates summed together. I wonder whether the formula can serve to
> > provide at least some (upper) estimate.
> >
>=20
> Thanks for your review. This forces me to think more on this because each
> update does not necessarily be a single page sized update e.g. adding a h=
ugepage
> to an LRU.
>=20
> Though I think the error is time bounded by 2 seconds but in those 2 seco=
nds
> mathematically the error can be large.

Sounds significant?

> What do you think of the following
> change? It will bound the error better within the 2 seconds window.

This didn't seem to go anywhere.  I'll send "memcg: flush stats only if
updated" Linuswards, but please remember to resurrect this idea soonish
(this month?) if you think such a change is desirable.

