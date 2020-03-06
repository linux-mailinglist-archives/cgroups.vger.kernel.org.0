Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B25217B456
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2020 03:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFCQI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 21:16:08 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53791 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgCFCQI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 21:16:08 -0500
Received: by mail-pj1-f68.google.com with SMTP id cx7so398423pjb.3
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2020 18:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=z2MtYmeH2j2KewserLKK2k6VMHRwOlZRf+3/F4kq+Sk=;
        b=PVpkrCMCy0ZsCjsLfnfGd/4xzJJq7apSm7Px0RwrucCbeqa2OpumEJYeZ6x9brHl12
         pNGT2d8lsIo9HbDQ/KWXgZhA4vQmL0Ji856oTphf/TpQPCUL13BWLMdsH9i8+8WQLsyw
         Oz4C8pa9qEtansov8FD965ZXuFygcd6108Mk4pcCpYfdHrvY5rI6XXqrFKLmcMn9hp4q
         4+voMfhA9eqB4fK4n9VoHhYzqKd2gQcE4ccSS1iwp8E4gMb0xaMZB8eA0xAZku9pLSli
         nh/GSl1mvYadLyYx6yGpyq6o4QpfFhPdfHaRNVP1LEPvnCJh/jBtReyX9S1nc0Tg/7tV
         ecMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=z2MtYmeH2j2KewserLKK2k6VMHRwOlZRf+3/F4kq+Sk=;
        b=CfeDHSGdR0W9SVf7t73E4/FNFOR80z52ynfCUeEA7GCHdsQTlTa8A0cfBgt1Kg0tZj
         SUNMUhdY56qL1GLR7Yn/E08tlrgmOu/tRZH5IueU+A91VrsUwt/OEHsEJ11/oItQedDj
         mK1gWgA4TPNVczBJsSoOm6Bza+Nal3Iwt5myVBa6D/1o+RlDxETCrJaj3KNrr9wy+BoL
         bTw/9dhcAt5eyJqwDvByRQu18zk9NkrS7mA3GMio/tc+/YX4l/2uNtGy0Vv2NUHnZyMk
         jSJabayaewXNufpYdAOiTOC49cyyIfXUHzsHzJwYsJ9rLX5ICjJ8gD5K425Ts36+Tyfo
         vnlA==
X-Gm-Message-State: ANhLgQ0UvEHtHwhZ2aP3UmQn2wdpKBZqpNYVkOfn3dJ8h+2x+LN7v8Xq
        AT3HYbJ8MvoI549WTiCnChHBIw==
X-Google-Smtp-Source: ADFU+vsxYxL5yf/ce8z75wcVJZ949vaEaCge8Blvf1JHNJK858IIKa6k4hhsMKoeSQ5GqK42jErAUQ==
X-Received: by 2002:a17:90a:d101:: with SMTP id l1mr1201947pju.130.1583460966067;
        Thu, 05 Mar 2020 18:16:06 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id a19sm7334404pjs.22.2020.03.05.18.16.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2020 18:16:05 -0800 (PST)
Date:   Thu, 5 Mar 2020 18:15:40 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
cc:     cgroups@vger.kernel.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        Fengguang Wu <fengguang.wu@intel.com>,
        Rong Chen <rong.a.chen@intel.com>
Subject: Re: [PATCH v9 00/21] per lruvec lru_lock for memcg
In-Reply-To: <59634b5f-b1b2-3b1d-d845-fd15565fcad4@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2003051642580.1190@eggly.anvils>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com> <20200302141202.91d88e8b730b194a8bd8fa7d@linux-foundation.org> <59634b5f-b1b2-3b1d-d845-fd15565fcad4@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1920851028-1583460965=:1190"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1920851028-1583460965=:1190
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Mar 2020, Alex Shi wrote:
> =E5=9C=A8 2020/3/3 =E4=B8=8A=E5=8D=886:12, Andrew Morton =E5=86=99=E9=81=
=93:
> >> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu=
,
> >> and Yun Wang.
> > I'm not seeing a lot of evidence of review and test activity yet.  But
> > I think I'll grab patches 01-06 as they look like fairly
> > straightforward improvements.
>=20
> cc Fengguang and Rong Chen
>=20
> I did some local functional testing and kselftest, they all look fine.
> 0day only warn me if some case failed. Is it no news is good news? :)

And now the bad news.

Andrew, please revert those six (or seven as they ended up in mmotm).
5.6-rc4-mm1 without them runs my tmpfs+loop+swapping+memcg+ksm kernel
build loads fine (did four hours just now), but 5.6-rc4-mm1 itself
crashed just after starting - seconds or minutes I didn't see,
but it did not complete an iteration.

I thought maybe those six would be harmless (though I've not looked
at them at all); but knew already that the full series is not good yet:
I gave it a try over 5.6-rc4 on Monday, and crashed very soon on simpler
testing, in different ways from what hits mmotm.

The first thing wrong with the full set was when I tried tmpfs+loop+
swapping kernel builds in "mem=3D700M cgroup_disabled=3Dmemory", of course
with CONFIG_DEBUG_LIST=3Dy. That soon collapsed in a splurge of OOM kills
and list_del corruption messages: __list_del_entry_valid < list_del <
__page_cache_release < __put_page < put_page < __try_to_reclaim_swap <
free_swap_and_cache < shmem_free_swap < shmem_undo_range.

When I next tried with "mem=3D1G" and memcg enabled (but not being used),
that managed some iterations, no OOM kills, no list_del warnings (was
it swapping? perhaps, perhaps not, I was trying to go easy on it just
to see if "cgroup_disabled=3Dmemory" had been the problem); but when
rebooting after that, again list_del corruption messages and crash
(I didn't note them down).

So I didn't take much notice of what the mmotm crash backtrace showed
(but IIRC shmem and swap were in it).

Alex, I'm afraid you're focusing too much on performance results,
without doing the basic testing needed - I thought we had given you
some hints on the challenging areas (swapping, move_charge_at_immigrate,
page migration) when we attached a *correctly working* 5.3 version back
on 23rd August:

https://lore.kernel.org/linux-mm/alpine.LSU.2.11.1908231736001.16920@eggly.=
anvils/

(Correctly working, except missing two patches I'd mistakenly dropped
as unnecessary in earlier rebases: but our discussions with Johannes
later showed to be very necessary, though their races rarely seen.)

I have not had the time (and do not expect to have the time) to review
your series: maybe it's one or two small fixes away from being complete,
or maybe it's still fundamentally flawed, I do not know.  I had naively
hoped that you would help with a patchset that worked, rather than
cutting it down into something which does not.

Submitting your series to routine testing is much easier for me than
reviewing it: but then, yes, it's a pity that I don't find the time
to report the results on intervening versions, which also crashed.

What I have to do now, is set aside time today and tomorrow, to package
up the old scripts I use, describe them and their environment, and send
them to you (cc akpm in case I fall under a bus): so that you can
reproduce the crashes for yourself, and get to work on them.

Hugh
--0-1920851028-1583460965=:1190--
