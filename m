Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1F33B46E
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 14:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhCON2t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 09:28:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48836 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231665AbhCON1z (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 09:27:55 -0400
Received: from zn.tnic (p200300ec2f0786006d6cd745861f0d39.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8600:6d6c:d745:861f:d39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 72A251EC0577;
        Mon, 15 Mar 2021 14:27:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615814874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ak+E12GBZwVGrIOych3fPRWu9zZC1hEEOdve/9U70zg=;
        b=f7OV/4KwJ0lilfDZewDSPgYOvuFlHRuu6kotJkJ7Vog6fokNZnUlm56IQx49imeAol5FRR
        /vxll6l2XLcTU376+wGHq4kt6g0kEhuYdbnxyuIhIDFmrWFQgnbw0KAJMBn1iK5OyUkpsB
        XkG7cd79v5BXwcwWPgEI040eXY6eIcA=
Date:   Mon, 15 Mar 2021 14:27:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [PATCH v2 8/8] memcg: accounting for ldt_struct objects
Message-ID: <20210315132740.GB20497@zn.tnic>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
 <360b4c94-8713-f621-1049-6bc0865c1867@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <360b4c94-8713-f621-1049-6bc0865c1867@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 15, 2021 at 03:24:01PM +0300, Vasily Averin wrote:
> Unprivileged user inside memcg-limited container can create
> non-accounted multi-page per-thread kernel objects for LDT

I have hard time parsing this commit message.

And I'm CCed only on patch 8 of what looks like a patchset.

And that patchset is not on lkml so I can't find the rest to read about
it, perhaps linux-mm.

/me goes and finds it on lore

I can see some bits and pieces, this, for example:

https://lore.kernel.org/linux-mm/05c448c7-d992-8d80-b423-b80bf5446d7c@virtuozzo.com/

 ( Btw, that version has your SOB and this patch doesn't even have a
   Signed-off-by. Next time, run your whole set through checkpatch please
   before sending. )

Now, this URL above talks about OOM, ok, that gets me close to the "why"
this patch.

From a quick look at the ldt.c code, we allow a single LDT struct per
mm. Manpage says so too:

DESCRIPTION
       modify_ldt()  reads  or  writes  the local descriptor table (LDT) for a process.
       The LDT is an array of segment descriptors that can be referenced by user  code.
       Linux  allows  processes  to configure a per-process (actually per-mm) LDT.

We allow

/* Maximum number of LDT entries supported. */
#define LDT_ENTRIES     8192

so there's an upper limit per mm.

Now, please explain what is this accounting for?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
