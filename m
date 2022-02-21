Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B58C4BDD2D
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377152AbiBUN7D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 08:59:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347740AbiBUN7D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 08:59:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB71A39C
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 05:58:37 -0800 (PST)
Date:   Mon, 21 Feb 2022 14:58:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645451915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iitq/hbofHwFVa3nea7jsMf/rgjsnN6retKs9evBkAw=;
        b=qPEhuQ2CmF6oV7BGpiRhqhV00ivvDd2117OATOQJvxQ5UryEGmiFX8ty1T7Dq6VmLrqJam
        lZt17G/4o1+vEeoGKt32e/VmZKgo72F+dtG6OeGzdmRnIfPVZDW22HBXAotvv+yDL6+tSf
        KUjgff080D0UbvvtEAL3d8NcBBfJX6Nzp22r+cD6Ly33BjABwv8ZVZbTJc24LhxlcxKRqI
        Xmxq1NNghkrdWc0nT/WA8M6h5pK1RS2ImvWPaONdlEhViLprTVZaAeEXRO9bbupwJCNPjY
        arUW2yF590khxdSvX4ftEo5oG5qX2UKhPK3d/e8A4I+DHRxE3dqJB4LMGCQfZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645451915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iitq/hbofHwFVa3nea7jsMf/rgjsnN6retKs9evBkAw=;
        b=F+r+sm5WhlyUnRW5yuWA/mA7JSWd4B5U8tpnt6zrh5Hs4EU8B26lPuR9+TNU7mrc6Bvc+n
        lzqOS2tV/KjihuAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3 3/5] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <YhOaiutkyyY9v/0G@linutronix.de>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
 <20220217094802.3644569-4-bigeasy@linutronix.de>
 <CALvZod4eZWVfibhxu0P0ZQ35cB=vDbde=VNeXiBZfED=k3YPOQ@mail.gmail.com>
 <YhN4BSQ1RLomLoyl@linutronix.de>
 <20220221131825.GA7534@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220221131825.GA7534@blackbody.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-21 14:18:25 [+0100], Michal Koutn=C3=BD wrote:
> On Mon, Feb 21, 2022 at 12:31:17PM +0100, Sebastian Andrzej Siewior <bige=
asy@linutronix.de> wrote:
> > What about memcg_rstat_updated()? It does:
> >=20
> > |         x =3D __this_cpu_add_return(stats_updates, abs(val));
> > |         if (x > MEMCG_CHARGE_BATCH) {
> > |                 atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_thres=
hold);
> > |                 __this_cpu_write(stats_updates, 0);
> > |         }
> >=20
> > The writes to stats_updates can happen from IRQ-context and with
> > disabled preemption only. So this is not good, right?
>=20
> These counters serve as a hint for aggregating per-cpu per-cgroup stats.
> If they were systematically mis-updated, it could manifest by
> missing "refresh signal" from the given CPU. OTOH, this lagging is also
> meant to by limited by elapsed time thanks to periodic flushing.
>=20
> This could affect freshness of the stats not their accuracy though.

Oki. Then let me update the code as suggested and ignore this case since
it is nothing to worry about.

> HTH,
> Michal

Sebastian
