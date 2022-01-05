Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA395485565
	for <lists+cgroups@lfdr.de>; Wed,  5 Jan 2022 16:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbiAEPG0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jan 2022 10:06:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42810 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiAEPGJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jan 2022 10:06:09 -0500
Date:   Wed, 5 Jan 2022 16:06:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641395167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zU5XndrFq1/DafMJeyDTRNBd9Wg4rCfP6rL7TcC+Lc=;
        b=24kGuqLfhX/BEMR4PTr/BvWPUcn1JGhQ5Zw4BtzQW9OZd3CM2f+BjM5utCwhvxqapFbneX
        Q2Zwva6OXJ/Bw88fm9pg6NAw+AiQB9zDsQ+3/7M52slVkzO21P+u2Uui4TbRTwjwNJ+JS9
        3dztBRTTt6VC9vC4sxj88X5A8zGA+1bu9h6M2vk3qiXQ4Nqqu/+gxO6jmYbE140b8KMMSj
        7GmvVZuRAJ6di1/LgAI5Nyvc+VGKnFpZped4B6hsYNZRStWcgCWNkHonRJqErX/cCnxVq7
        3jGQZEVDlR6HBqmW3r2XYHD1AO/VPbD9tElTcrw2SrhpyPrfp88mSVI74qEJ9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641395167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zU5XndrFq1/DafMJeyDTRNBd9Wg4rCfP6rL7TcC+Lc=;
        b=co63aLbokqKOOwFoxm+1Taneq4FpYk5r/lTtHAduUD3NL3Lq5RIZNn4RQ3QBibFnkuAJ/3
        H2ldUGLDfljEIABQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/3] mm/memcg: Address PREEMPT_RT problems instead of
 disabling it.
Message-ID: <YdWz3RvPemg3m7WD@linutronix.de>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20220105145956.GB6464@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220105145956.GB6464@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-01-05 15:59:56 [+0100], Michal Koutn=C3=BD wrote:
> On Wed, Dec 22, 2021 at 12:41:08PM +0100, Sebastian Andrzej Siewior <bige=
asy@linutronix.de> wrote:
> > - lockdep complains were triggered by test_core and test_freezer (both
> >   had to run):
>=20
> This doesn't happen on the patched kernel, correct?

I saw it first on the patched kernel (with this series) then went back
to the -rc and saw it there, too.

> Thanks,
> Michal

Sebastian
