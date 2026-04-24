Return-Path: <cgroups+bounces-15502-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM5hCuew62mRQQAAu9opvQ
	(envelope-from <cgroups+bounces-15502-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 20:05:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C78FE462406
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 20:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3725C300FC75
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 18:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5E33E9286;
	Fri, 24 Apr 2026 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+fO3Xf1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E403E717F
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053909; cv=pass; b=EhchiR6hInOuTkZtBuCacdCSKDkXpwoQ3kjnl/rZoIJlbibCZxW2UKNA1IjPmEJ700mDxnEDkp5I9hFDDF/9yGwXG0njCqNBQHFkLa1/JjbPWj7IPYPBNMjBgwsKlhFGx0ie5ueiCnIMewsBXZHvyjmhR3KPEHGXF8p0u/rMuS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053909; c=relaxed/simple;
	bh=4wCED2gyJ66NMivSm3uMeQZjOR2fIAqNWj1/nJY0+EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMcsQbLLLQdTRBuSxxJnLja1PNYPT/CtprcImIM31RUCLfr8B8CW5EvLrv8IVlcVJZNwT+yBIJa2RkhJcClBdYRzg1dCJXJTpLfuwSTk4GfJQ/Fd7IfGMg60EtweylgqJYeVqt4DhUa3fkQDCHdOhgZQhDtS20PArNzvboU7os4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+fO3Xf1; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6788838d543so3901589a12.1
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 11:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777053906; cv=none;
        d=google.com; s=arc-20240605;
        b=iky3eLQ77yVwmJ0XIkney9M2kf2aDw/VzxKXpibMPd1pEyNURdQS3rjPckfxpS9zU5
         3RF9jKLAlL4zObJVrVQ9cO7QazCZsBbYZMJqHC441jMwL2UDfrXLvt3sIDyT3s5BE1jZ
         ugOscXgIWJfSR9L8TQEwiPxgvf53sLpQta0KY5rsvyJgys6kdLx8ZE0FJIraSBgQrvUt
         otn4//H4S6NGlIZofPq/J6tbwarVeeY1zSSZ/DhM6vk9OuiJcuueyRXvsqwDXVRfeRSZ
         /8zU+VufMMRgPKnIJPeeiu8fytCdbUd8pmh+4COjf//l7a2K/FftTlkY/Dv2yPwEKqYw
         WexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4wCED2gyJ66NMivSm3uMeQZjOR2fIAqNWj1/nJY0+EM=;
        fh=gzTNFh/DhE73TwqpVUDiJAf3y35C0ywCNF26MeJJJJA=;
        b=DGxTcRie4fp68MbG1Jzj3tqgmeSVlX4ytoA9Khp0ZVchmwnldlfgfcAGrhKbQBd9dP
         8WGc9t1Ta5eDtiXN9lZt6mib6I0ukLZYE6uRWtgn2OyJn3pbGT8awnaTzMSV5KZ1qemC
         814Jr9xqtpaussfhKK00Iz6qY5z4LbWU3xOvx4TL6yUXpoeLPIFDcSkwMfQIAZxF11Zc
         FcTysdgWxTymz120mxnlFT3Ogs9QOzlmPxO49dhMxpq1+RG6hYw9AI4FUHI1Cen0spF1
         ofHbhYZriytQWO6pQ824Q+JsHGLifmZCeAYJDYvU7BpWVf6TfAst2tbKrRXZtOfMpfNw
         YgyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777053906; x=1777658706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wCED2gyJ66NMivSm3uMeQZjOR2fIAqNWj1/nJY0+EM=;
        b=M+fO3Xf1vte+M+aoQjf74GeOr9LhLe0bgIpEioKluyhRmvrLpnfU60D8N+6F+ykenf
         3htkjMfL1eJ6AicOUcU/lN6H/Rg1Zd3W7/N3i/wTPhvnxm/9a0ArAdNwDFdHQk9U+Jle
         eBiTX/awkW61px0cmxTfgK5O/7KYbJWysfvyLrbsFc6oAOHcIJpmwD/8bLt0A2VdC46L
         hwbBAzca0rab/fuVVaerHg1DaZE7WFdMxouL7H2/JZSVW2iJ2+wpGImYx4pjBCKIZ2Nd
         XSdOBnWOtnssKv1QvjdE7lH6iUa5ZOV7f5MpUGTJc7UT+BWrEnHgcERmQUON/KmdtnW0
         yn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777053906; x=1777658706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4wCED2gyJ66NMivSm3uMeQZjOR2fIAqNWj1/nJY0+EM=;
        b=QT1BDm2vtChhGRW/Z/f0a1yawPgw6/GIY+4b+xWbI8FBFu9w32mzSacP7PX8z+3mny
         /dEsLrg8N+JcYo0ILtPbVmFEpzVhPBHqwG1Y0hez6kqOVedMXzVS9k6cLprETcBYFOMC
         vEsSZStupyV+qlFTvqpvaZQ7wMRzKZsde9xSvynW8QlQzvseZhWJGituNbuziwg/VK+1
         tZD5NMAtg5B3XDANcj27DkGaUk5XPqQlJlT0L2OVuGY2yyy7iU8GQnBHmMrS7UWkUHdt
         anwVivNEVbwrYIMLf5qBE6F3eKJwN2GQa3JYbyUKt5kB/Yn3/ALXC4GgvYEQpPSl4mUl
         ccQg==
X-Forwarded-Encrypted: i=1; AFNElJ/NHWCs9MrvCgSZH3YU+EteeKRugFqYAabF1HWJSxzqHBb9B4Or6swKNSpFD4EPZN+U9BGA4Jo/@vger.kernel.org
X-Gm-Message-State: AOJu0YynRoHm4xWYf3XDj0KbGRogd+iswUhBTSSI+vyllRpxZSKeT37K
	W5/AmZGgilgApD9rkstIt5jH2amHygJCbAgIEXSwEWnTU0K6IWSVzvV2EGsQ7VLqAF7ZBLEiIu1
	znM+lbR9G4bzgh+lCyauQsOJ0yOEseRs=
X-Gm-Gg: AeBDietXEZ0a8KFtVIm+qX5b1ee7ZEJ69/kN1bGIqtSZoGz1Hr6RyywQi3edJGS3e8O
	TnXVsvfJGtOEci1mRXqs1qZ9aBfypyC11gbb68hmusAHMSNwkH62SD8BPNnqkb3jax3R4e5NCUp
	uBuWjkZUFETjujetF0+ho+eiEfVqIwGc9Kw5ZGLeM7ZiX33ZZTRCFW3Do7M4epg5uKBPPG6d0+K
	BGsReLS0nsNMeo15veJ+/fKxJ30CfzxqT8S7qWVaWOnVXZLC59XesGh9N/pfdBmjW9O9umeRfPx
	wnfGVW+WWRyO+MJ/g6WIwnnOAAOWvzOR9aLkKCxhhyhOiUe7pI0osmSJpvE+cA==
X-Received: by 2002:a05:6402:5051:b0:672:c366:b088 with SMTP id
 4fb4d7f45d1cf-672c366b207mr11251845a12.8.1777053905724; Fri, 24 Apr 2026
 11:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
 <aektdlD4npMVThu3@google.com> <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
 <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
 <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com> <CAKEwX=ORdgAwaJLv8CidOQZ0r6ZBHkDYVUxZv1k2PiaZi3qe+g@mail.gmail.com>
In-Reply-To: <CAKEwX=ORdgAwaJLv8CidOQZ0r6ZBHkDYVUxZv1k2PiaZi3qe+g@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 25 Apr 2026 02:04:28 +0800
X-Gm-Features: AQROBzAYXcS_1H5K9HyPupUmr2KbUwpuBsIN1OBxlrG3dClTVKgn5H7GzhL8dcs
Message-ID: <CAMgjq7A1YLyxBKqVi4moxGPBh0wbnehW91uEqxrNUm2ziTy_dQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	Alistair Popple <apopple@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baoquan He <bhe@redhat.com>, Byungchul Park <byungchul@sk.com>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@kernel.org>, 
	Dev Jain <dev.jain@arm.com>, Gregory Price <gourry@gourry.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Lance Yang <lance.yang@linux.dev>, lenb@kernel.org, 
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Brost <matthew.brost@intel.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Mariano Pache <npache@redhat.com>, Pavel Machek <pavel@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pedro Falcato <pfalcato@suse.de>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Suren Baghdasaryan <surenb@google.com>, tglx@kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Yuanchu Xie <yuanchu@google.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Zi Yan <ziy@nvidia.com>, 
	Meta kernel team <kernel-team@meta.com>, Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C78FE462406
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15502-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,linux-foundation.org,nvidia.com,google.com,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]

On Sat, Apr 25, 2026 at 1:28=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Apr 23, 2026 at 9:16=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
>
> My apologies for delayed response - I'm cleaning things up, and
> fighting with some memsw issue. I changed the semantic of the
> memory.swap counter a bit, but that makes it diverge operationally
> from memsw. Need to be careful not double charging or double
> uncharging here.

Hi Nhat,

No worries.

About memory.swap, I also thought about changing it a bit previously
to make thing cleaner:
https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-7-104795d19815@t=
encent.com/

But I dropped that part so swap table series p4 can be reviewed
without any behavior change. Not sure if related.

> > I think it's actually functionally very similar to Nhat's design
> > already from a high level, the only difference is we don't need
> > standalone infra for virtual parts.
> Well yeah, great minds think alike ;)

:)

>
> As you have noticed, I have also converged towards a lot of your
> metadata design and operational arrangement.
>
> Case in point is the delaying of cgroup check merging with swap
> freeing - I did not notice that patch you had in your series, but I
> realized I had to do it as well after studying the regression for
> awhile.
>
> (I did think about proposing that outside of the vswap series, but I
> was thinking it would not be a problem at all with the current code.
> But in hindsight, since you're also merging swap cgroup with swap
> table, it will have a similar implications, albeit less expensive due
> to no xarray indirection).

There are actually more issues behind that. Later we would also want
to distinguish shmem / anon swap entries again, so swap cache
allocation ensures there is no conflict between these two. That is
also causing some real issues.

>
> Hopefully we can iron out the rest of the differences. I have a couple

Yeah, definitely. I think things are already getting much cleaner as
we keep unifying and simplify the swap infra. Consider the current
swap file something like s swap mapping as an infra seems to make
things easier to understand as well.

> more use cases in mind (compressed writeback from zswap, discontiguous
> fallback for swapout, etc.), but without virtualization they seem like
> a deadend :(
>
> And Gregory's cram stuff too - I think it's not undoable without
> vswap, but it's just a lot hairier :(

Ah, I'm not against a virtual layer at all, actually that's a shared
goal, I mean we might not want something mandatory, and redo
everything again with more overhead.

