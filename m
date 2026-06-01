Return-Path: <cgroups+bounces-16529-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGHXEi/LHWrHeQkAu9opvQ
	(envelope-from <cgroups+bounces-16529-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 20:10:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC12623C78
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 20:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 988EA309819A
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F18C3E2ADD;
	Mon,  1 Jun 2026 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0FzUPxw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBDC3E3179
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337213; cv=pass; b=i8TKtIkLhhgdCFW4LiXy9Y3WNsoVTfHoK8VTFDF93Du6+xq3DsFzaygbFxZipAxGBr3ZKc10J8VYyX7ZUzHhu2wqQXOMlyxw/ObxuvcH6EDIfxCfVrEhG91x4pclTRy764M4cU6AP3GeFmqTHvPXtuxJb0PCbd2HSYpxM0/L33U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337213; c=relaxed/simple;
	bh=ghYY1NsDZ0jpHFccSpot/TCvl6MbOIQ0KElLf2vfeCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qU//xdfcJnnRCC0BD3ebkFvMizY6uZIRG6lfn/JBp7r3kcnw74yfMsCF4XKq49pusINEdHj9sJWgBmqkTjOdTnV2Rgklxn/3OWhzk/4CkvxR2fvOEKnnO9Wiwuuzw3g4iR1BJDukXDJfsyV9kpgLlyPA/BKICZQ5tP9Q/TpJoAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0FzUPxw; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ee1a56328so5057397f8f.3
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 11:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780337210; cv=none;
        d=google.com; s=arc-20240605;
        b=Srl3EQvHRR1Nw3ooTntwGZ00hyjRQ0I7Bzo9rxdwY+NE/4FWDbHTpigaelaiq8jqFX
         EbE4zMzTDQtlDT3RYNY7MIo4HxE+IDdjl80UnE5u5d4sCvmQH6Md8l1cR0owMEV45ols
         2yAgh+cl86HNlsn+o8yRtbPNE5tEjM2nT7bANh0BTHSoGnTwWeI4TQJnoWdbUXkclWf/
         55YcSOuwWrtNYFuFtR9mwrUY/XxxkToX5gpCjW6OPM3gHVlVfKxI6APso64pi3iMTszK
         MR7IVTmyFGipX6R+sD8sr0wNiwPwayPk1nW/Pc7XS6RVc3VNAPljcRyCrtBGZFZ7vnh7
         R6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k+NcOvINeD/X7jg493pqLpYD2a6ETdaWQNv9IdTEDm4=;
        fh=kmNR6egGAo06e+Mi0AQohWyGOTK6SjRq2pEB4FeIEhk=;
        b=Nvv732abVsLuAsH57MfR6JH4Psex6cPG+KIcclHgz+auphiSO2QKI7CxxNjlDh/Nuw
         iGvmP+KlrL/5Ve0Oxl9HKocSMqoG5+Lp+EVPAZUDUegJfC3FkkqYLV0ZsnO8CMveFx1X
         NQwWwRK7ecP8TeeXy440HpnEiL80E/uo1gZ76K6pwiUBPbgjszkFgsJA8TLbOLoVqfcf
         vSDFHEbZdOR7sdifiKfBBmWdOdcBqrcXbT07DddacP4RYcrMclYtFiKjWokYB7fOXGgl
         HXkae8CjuYnu1ayfG0wZszJAzOp5HttuMoNu3Lqu8xJIqccUOhAR2cVDqS6emwqCDixD
         QqEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780337210; x=1780942010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+NcOvINeD/X7jg493pqLpYD2a6ETdaWQNv9IdTEDm4=;
        b=Q0FzUPxwzGm/zWFf7Tg8sYP3YVthlIVOEnKgBuyM+ux6CENRgaaHHcMg7poSeU8A8p
         C5c0/hTZySmDecntt7nqrt9DWz+Eof+ukCjbhR5ykyrlXd8AEZnFaxkSTQGqBZxi3NpJ
         WPa8uChKUhNX7QI4lvUy/D0+8FzBfJOl1O30qFTHTaqTzl2ji+CDNgR2Q7ydv/3dx0jW
         ETV8seoMAXU5fM1W3XcIS5w6NuveuwKud9/LnEKY91Y0jzkNiuVhqtU6ge9S3qQwU7c3
         CEQXt/JOvHukMD9pnQfEw4HfBCS3KtWt2oOGCGb07Hf1jsK9Cvig/ssf0f3kcpi8cObX
         RxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337210; x=1780942010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+NcOvINeD/X7jg493pqLpYD2a6ETdaWQNv9IdTEDm4=;
        b=rP9Fz/nxPgkFHc/0GS+PKC7KWGR3dRUNZfP54qdX+ksTyMAM+IGmcyxGMjMCatiCrC
         IwMl+UGQYVQeYI9mNStB/C4bSo4pHf2wYmr4R4AxRnnCb6VHX/y/UBgGts0zk7hYFnnZ
         1bH9thp/3HC0BspM1g7YUvsbMcZHHUnub0VN5Z+Fl3WgH0hHsnKtcQg/b4/TmiRepx31
         ZFbpgBF/7y41Mwx1qHENvEidPmq8l5Y0FcRx5vWf5KFiVSpAzihICLYNuEUzrFN1G6jk
         V9plcyW+f/tDoEN8OObOiOOe+475JjtY9OxXwzDUbq78+9EOH9/WIM9U+lDlEAdGLm/e
         gUNg==
X-Forwarded-Encrypted: i=1; AFNElJ9DMvHGczAp2FlrkUs4V3ENoetve1zTCXiR1F7PLNI2ei66/qvDyIfAYhwk5IFymlXhqhHxF/aZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwTExr4K98TWAXide1OxIDDzQyooCbyGmyvlhWs5G5z1pBs6Hcy
	+ISAgGpeSctJSkjdvJRuadnNc6gZCi7CotbeRCqyEU2faCRIvIwwhPO4NO6cQbrjTAfcpc9Xm40
	mPEZohuE8f0AAisCWnIGjALgS0vmx8y8=
X-Gm-Gg: Acq92OFnRT8i7Yqsw721vQVzjzxRnS6p0KFBje2TWJ690HHSaK5AL1a615fJldscfG+
	2gMoFFp/ooraaAdL+ZlkMpxPHAjkKZfCAhdplzKM8FehaGzjdKpu+H3FTHel1sRKpF/FzwTbiR9
	30o1qDNKDQlbeSGFkfGKUtIs2HzOg+dhqvGXwpbyO3VL6LcGbjGq0+hHlMFiNRuzdK65S5C9fha
	IK3pW8U5Cv8RZ+lvnU+6Gl8glInfqpndlD6lQ6nt9dsnhQDuUV/Q4lFgB0uErxmW+tq2vOeuN1r
	/8XLqOxBwDikk7A9u/XT+Uir2ecsF21xY2xfbw6V6jCCC7srRA==
X-Received: by 2002:a5d:58f6:0:b0:45e:e50e:3bc with SMTP id
 ffacd0b85a97d-45ef6b71573mr17744808f8f.29.1780337209883; Mon, 01 Jun 2026
 11:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com> <CAMgjq7BhOn48xEyC=2j837R7qddfjeBVHMiRqdx8no4ZEBpBLg@mail.gmail.com>
In-Reply-To: <CAMgjq7BhOn48xEyC=2j837R7qddfjeBVHMiRqdx8no4ZEBpBLg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 1 Jun 2026 11:06:36 -0700
X-Gm-Features: AVHnY4KpgrZEoyhjTsiexcEZOQjS_1bg9H_7TW6-dFwfjU3rgggaOz11SKO19Jw
Message-ID: <CAKEwX=PmwzaJhfjBrho3+kQ8HXFUC0WiegQrsguBc-_pmn5bSA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Kairui Song <ryncsn@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com, haowenchao22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16529-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AEC12623C78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 10:45=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Mon, Jun 1, 2026 at 11:57=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Mon, Jun 1, 2026 at 12:34=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > For the format part, PHYS don't need that much bits I think,
> > > so by slightly adjust the format vswap device could be share
> > > mostly the same format with ordinary device.
> > >
> > > For example typical modern system don't have a address space larger
> > > than 52 bit. (Even with full 64 bits used for addressing, shift it
> > > by 12 we get 52). Plus 5 for type, you get 57, so you can have a
> > > marker that should work as long as it shorter than 1000000 for PHYS,
> > > and shared for all table format since it's not in conflict with
> > > anything. You have also use a few extra bits so a single swap space
> > > can be 8 times larger than RAM space, and since we can help
> > > multiple swap type I think that should be far than enough?
> > >
> > > Then you have Shadow back at 001, and zero bit in shadow. The only
> > > special one is Zswap, which will be 100 now, and that's exactly the
> > > reserved pointer format in current swap table format, on seeing
> > > si->flags & VSWAP && is_pointer(swp_tb) you know that's zswap :)
> >
> > Are you suggesting we merge the virtual table with main swap table?
> >
> > Man, I'd love to do this. There is a problem though - we have a case
> > where we occupy both backing physical swap AND swap cache. Do you
> > think we can fit both the physical swap slot handle and the swap cache
> > PFN into the same slot in virtual table? Maybe with some expanding...?
>
> I don't really get why we would need to do that? If you put the PFN
> info in the virtual / upper layer, then the count info, locking, and
> all swap IO synchronization (via folio lock), dup (current protected
> by ci lock / folio lock), and allocation (folio_alloc_swap), are all
> handled in this layer.
>
> The physical / lower layer will just hold a reverse entry on
> folio_realloc_swap, or no entry at all (no physical layer used, zswap,
> or after swap allocation but before IO) right?
>
> Looking up the actual folio from the physical layer will be a bit
> slower since it needs to resolve the reverse entry, but the only place
> we need to do that is things like migrate, compaction (none of them
> exist yet) which seems totally fine?

All of this is correct, but consider swaping in a vswap entry backed
by pswap. There are cases where you still want to maintain the pswap
slots around backing vswap entry, while having the swap cache folio as
well.

For e.g, at swap in time, we add the folio into the swap cache. First
of all, we need to hold on to the physical swap slot for IO step. But
even after IO succeeds, there are cases where you would still like to
keep physical swap slots around (for e.g, to avoid swapping out again
if the folio is only speculatively fetched).

So you have to make sure we have space for both the physical swap
slot, and the swap cache folio's PFN at the same time for each vswap
entry. So we still need the vtable extension (well maybe the other
approach I mentioned could work, but I'm not 100% sure).

>
> > > This could be imporved by per-si percpu cluster. Both YoungJun's
> > > tiering and Baoquan's previous swap ops mentioned this is needed,
> > > and now vswap also need that. If the vswap is also a si, then it will
> > > make use of this too.
> >
> > Yeah I made the same recommendation when I review swap tier last week:
> >
> > https://lore.kernel.org/all/CAKEwX=3DN2XcMHN1jatppOk6wnmz-Shab5XMtTtzgY=
OzRvU_6YFw@mail.gmail.com/
> >
> > I like it, but yeah it will be complicated. That said, I think not
> > fixing the fast path for tiering/vswap will seriously restrict their
> > usefulness. We don't want to go back to the old swap allocator days :)
>
> Thanks. Not too complicated, actually our internal kernel
> implementation still using si->percpu cluster, and use a counter for
> the rotation and each order have a counter :P, it's a bit ugly but
> works fine. It still serves pretty well just like the global percpu
> cluster, YoungJun's previous per ci percpu cluster also still provides
> the fast path, many ways to do that.

Sounds like something that should be upstreamed? ;)

I was concerned that you might deem the overhead too high (so I came
up with the per-tier percpu caching), but honestly I like it a lot.

>
> >
> > >
> > > YoungJun posted this a few month before:
> > > https://lore.kernel.org/linux-mm/20260131125454.3187546-5-youngjun.pa=
rk@lge.com/
> > >
> > > The concern is that some locking contention could be heavier, or mayb=
e
> > > that's just a hypothetical problem though.
> >
> > I don't think it's hypothetical. At least with vswap, it's very easy
> > to get into a state where the shared per-cpu cache gets invalidated
> > constantly if phys swap and vswap allocation alternates (which is
> > actually very possible under heavy memory pressure), hammering the
> > slow paths...
>
> I mean if the per-cpu cache is moved to si level, then whoever enters
> the allocation path of a si will almost always get a stable percpu
> cache to use, even if the last used si changes.
>
> We might better have a more explicit per si fast path for that. The
> plist rotation should better be done in a different (will be even
> better if lockless) way.

Exactly! That's what I'm thinking too. Basically I'm special-casing
for vswap here, but if you're happy with generalizing this for every
si I'm happy with it.

>
> >
> > >
> > > >
> > > > - Runtime enable/disable of the vswap device. To be honest, I don't
> > > >   know if there is a value in this. My preference is vswap can be
> > > >   optimized to the point that any overhead is negligible. Failing t=
hat,
> > > >   maybe we can come up with some simple heuristics that automatical=
ly
> > > >   decides for users?
> > > >
> > > >   In this RFC, CONFIG_VSWAP=3Dy means the vswap device is always cr=
eated at
> > > >   boot, and CONFIG_VSWAP=3Dn means the vswap device is never create=
d. This
> > > >   *might* be enough just on its own.
> > > >
> > > >   Is a runtime knob (sysfs or sysctl) worth the complexity beyond
> > > >   these heuristics? I'm not sure yet. Maintaining both cases
> > >
> > > I checked the code and I think it's not hard to do, patch 1 already
> > > handling the meta data dynamically, everything will still just work
> > > even if you remove vswap at runtime. The rest of patches need adaptio=
n
> > > but might not end up being complex, it other comments here
> > > are considered.
> >
> > Yeah, it's not terribily hard to do. I'm more wondering if it's worth
> > the effort, both for the implementer and the user :)
> >
> > As I said here, if we want vswap, just enable it at boot time and get
> > a vast (but dynamic) device. We can make it optional per-cgroup
> > through Youngjun's interface, and that would be good enough?
> >
> > >
> > > For patch 2, a few routines like vswap_can_swapin_thp seems not
> > > needed or should be moved to __swap_cache_alloc? VSWAP_FOLIO is
> > > same as swap cache folio check, which is already covered. Same for
> > > zero checking, and VSWAP_NONE which is same as swap count check
> > > I think. That way we not only save a lot of code, we also no
> > > longer need to treat vswap specially.
> >
> > Unfortunately, I think a lot of this complexity is still needed. Vswap
> > adds a new layer, which means new complications :)
> >
> > For instance, I think you still need vswap_can_swapin_thp. It
> > basically enforces that the backend must be something
> > swap_read_folio() can handle. That means:
> >
> > 1. No zswap.
> >
> > 2. No mixed backend.
>
> If mixed backend means phys vs zero vs zswap, then we already have
> part of that covered with the current swap cache except for the phys
> part (zswap part seems very doable with fujunjie's work).
> swap_cache_alloc_folio will ensure there is no mixed zerobit, it can
> be easily extended to ensure there is no mixed zswap as well
> (according to what I've learned from fujunjie's code). Similar logic
> for phys detection I think.

Yeah it's basically generalizing that check, and handle the case where
we can have indirection.

I mean I can open-code it, but it has to be there :) And I figure it
might be useful to check this opportunistically (at swap_pte_batch,
even if it's not guaranteed to be correct down the line) before we
even attempt to allocate a large folio etc. to avoid large folio
allocation.

>
> > > For memcg table allocation, on demand seems a good idea, and actually
> > > we are not far from there, I tried to generalize the
> > > alloc-then-retry-sleep-alloc in swap_alloc_table but still not generi=
c
> > > enough I guess.. Good new is the allocation of the table is already
> > > kind of ondemand, just need to split the detection of these two kind
> > > of table.
> >
> > I have a prototype of this, but I have not tested, so I do not want to
> > send it out. :)
> >
> > TLDR is - I still want to record the memcg for vswap (just not charge
> > it towards the counter). So we still need memcg_table at both level,
> > generally - just not allocating until needed (basically if a physical
> > swap slot in the cluster is directly mapped into PTE). You can kinda
> > tell, since you pass the folio into the allocation path - with some
> > care you can distinguish between:
> >
> > 1. Virtual swap, or directly maped physical swap -> need memcg_table
> >
> > 2. Physical swap, backing vswap -> does not memcg_table.
> >
> > Another alternative is you can defer this allocation until the point
> > where you have to do the charging action. But then you have to be
> > careful with failure handling, and need to backoff ya di da di da.
> > Funsies.
> >
> > I think I did a mixed of these 2 strategies. Anyway, I'll include the
> > patch in v2 (if folks like this approach).
> >
> > >
> > > Mean while I also remember we once discussed about splitting the
> > > accounting for vswap / physical swap? If we went that approach we
> > > don't need to treat memcg_table specially.
> >
> > For the charging behavior, I already have a patch for it actually in
> > this series (just not the dynamic allocation of the memcg_table field
> > yet).
> >
> > Basically:
> >
> > 1. For vswap entry, not backed by phys swap: record swap memcg, hold
> > reference to pin the memcg, but not charging towards swap.current.
>
> Maybe you don't need to record memcg here since folio->memcg already
> have that info?
>
> I previously had a patch:
> https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-7-104795d19815=
@tencent.com/
>
> The defers the recording of memcg, the behavior is almost identical to
> before, but charging & recording should be cleaner and you don't need
> to record memcg at allocation time hence maybe reduce the possibility
> of pinning a memcg. I didn't include that in P4 just to reduce LOC,
> maybe can be resent or included.

That works-ish when the folio is sitll in swap cache, but say if it's
vswap backed by zswap (and the swap cache folio has been reclaimed),
you need a place to store the memcg, no?

Just seems cleaner to centralize this info at vswap layer when it is
presented, for now anyway, rather than juggling this on a per-backend
basis.

>
> > 2. For phys swap backing vswap: charging towards swap.current, but
> > does not record the memcg in its memcg_table, nor does it hold
> > reference to memcg (its vswap entry holds the reference already)
> >
> > 2. For phys swap directly mapped to PTE: charges, records, and holds re=
ference.
> >
> > The motivation here is I do not want vswap entry to shares the same
> > limit as phys swap counter. If we think of it as "infinite" or
> > "dynamic", it should not be capped at all, but even if it is charged,
> > it should be something separate.
>
> Good to know, it's not too messy to make everything dynamic, but if
> our ultimate goal is to account for them separately, maybe we can save
> some effort here.

It's not terrible, TBH.

