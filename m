Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E242049E3A5
	for <lists+cgroups@lfdr.de>; Thu, 27 Jan 2022 14:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbiA0NiY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jan 2022 08:38:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36524 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242170AbiA0Ngt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jan 2022 08:36:49 -0500
Date:   Thu, 27 Jan 2022 14:36:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643290607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjY0dW0yhGN0PJkMP5xju7/MogIUEUa6wSeDiVxCBYQ=;
        b=TQvEJLjphAdoWfSbcdBCOZX31ZONcIpQB2O0UTEwb1dRhZHwHS7E1WBElY23hM2520+D7W
        bQ6xksTWXPLUgUZiAr6hz2SNUTuJXERZtK0PMP4r+aMKRjxL+rGAjvYfOVVUycsNtJuYTJ
        Lpj/p4GT51eAKZgrtjaGga4oqsL/GoVtNn18ikMQn8wfGl+J4YKRa2Ph1De9jgC/Dx23HM
        xTRAcaNPDEJWp/fnSoDMMCJOd6hgNHvY0OLzQJbIyW8Cy4T+h5MHxhAaMHwZEmv5tKh29x
        Fr0YHcyesqAc06QqjBakve7Q4rGMIDPv5sz9fne1nxlnI4kgdh1lAGH3Y7Dw9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643290607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjY0dW0yhGN0PJkMP5xju7/MogIUEUa6wSeDiVxCBYQ=;
        b=Wob4kE+EqwyVSQfI16o+1cEpXLMB/VEr40ymUnoaYeIs8fdFlpi1/jtoFaQuIK2R39k//0
        MsGgjs/54gfF1JAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/4] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
Message-ID: <YfKf7YaUoaL998m6@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-2-bigeasy@linutronix.de>
 <YfFddqkAhd1YKqX9@dhcp22.suse.cz>
 <YfFegDwQSm9v2Qcu@linutronix.de>
 <20220126150455.GC2516@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220126150455.GC2516@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-01-26 16:04:55 [+0100], Michal Koutn=C3=BD wrote:
> On Wed, Jan 26, 2022 at 03:45:20PM +0100, Sebastian Andrzej Siewior <bige=
asy@linutronix.de> wrote:
> > If that is not good, let me think of something else=E2=80=A6
>=20
> I like ifdefing just the static branch enablement. *wink*

That would be one way but it is not obvious that the eventfd/ signal
part of the code is not invoked. And why keep dead code around?

> Michal

Sebastian
