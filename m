Return-Path: <cgroups+bounces-16546-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNNxD51OHmrmiQkAu9opvQ
	(envelope-from <cgroups+bounces-16546-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 05:31:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51129627CC5
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 05:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCE61300E332
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 03:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928E0279DCA;
	Tue,  2 Jun 2026 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMY+jmie"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14F2C234A
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780370713; cv=pass; b=g5olynSi6bOKDVHU1VvIsj4PWwPWjvnrO9KkMVAVH8LMDG+89fQA9EvwloXlmyscFK9rcVVTsC0tMlIg76YRReAmDJn/1U/4fuIm2BxJYfRb5094bCNbcWkHfDBgbg71s6eo0NYusVm3DGFqw4yTuJBGqPU69jSCk8XWTpHUCSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780370713; c=relaxed/simple;
	bh=Fam29w7BM7SQN1712sc63hB2u0C0AKH1MvJ73Y+Wc24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhMRCzKRUFkpDJ6gnEedgSH4xy5u3EjM0LpkSi8G7KF5HLFEEa0frcRRP3k0MlWR5mDh9L6RAIZZzjNpVmoHpyNvb9oRD3NTALr0tIcyEMjSSSkluU2Xh/nR9QtGeT0DEqU2mkx0sLaCdFxGAsdT2q2c2pmWMHg+D6c9CC3hV+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMY+jmie; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bed4f2f0898so222773666b.3
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 20:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780370710; cv=none;
        d=google.com; s=arc-20240605;
        b=QLveKR9O77S14cRMerXh8SOth5rU/aGrFc0pJiW1KcnSs1IMMCyVByalJhcnFfScNf
         NiIpRXcRyLc0DNiV51a+9W01a9OI0Ucl4QLOs6gOjycjzA3trYRmA85uDet5zYgwSO2L
         M2USZkhVX/iiuQhzLU8mdaGDuZwla+RHwXYlbYSuWtBmQW+ztN1Fa1Pq/7DNsrXbBV/G
         aBmRNphwq9begKOxgvM3CUYkNs3DbNuClofCUT8hS2KkLzMMqczM9lzG8RE4RWiNdQRE
         iblLH5o+usg+A9i3Kpkf9Dw7XBVViryG00dQYLt3Ld3nfDTsRzeNY8Wen7O9ovlAeLaI
         sPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fam29w7BM7SQN1712sc63hB2u0C0AKH1MvJ73Y+Wc24=;
        fh=ffDskW9N0b6ecEU0vcxfr+Ru1ZQuyqOAvNvO1TETNW4=;
        b=bhEOQ7WW2XuQ31FqNLFGpd239Ue70+UeV6mZYWWh640u4c2i/g28tMpKlY7aOFCShg
         tyvFwIpbbxGUWBqzvTZw1sWRNN1nelIyr2QDBTV3ALcrBHWBzj4FXGsrxdNm4hAYzhC4
         fZnI0vpn3fcuKMBUzX0ndnIuzocLa+/BXIAnomZOwmZY0TMqz1LszGVqQlZqYyt/nBpq
         R8657s3Xw4pKfPG8zln0llqmo72OkPr0ArcvFjmYURDuJprCdvWJq2DjH5RJ61N7U1mV
         b8nXzFtairH0+6Mf5ehzER28AOmhYNJyCWMhHOz+ErGTE/ZD+lVrZk64wqI8+OwFJ6NN
         0wSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780370710; x=1780975510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fam29w7BM7SQN1712sc63hB2u0C0AKH1MvJ73Y+Wc24=;
        b=OMY+jmie8bu9I4r3R/dXdLhxR54/JpQXI7xHpaWQjcNlxM1mU7kWW+93vpGZrbiUJQ
         4pdoXVvlcP4/F4nuS6SnKwDtIS/INCLUCaDsr13KSiA8FI7W2POos9eIMy90EwFqz+Ke
         +uWX+aCkoT+b9aXO88OaCpdyYqNwJnEIIf0gfZtuqR7pB7Iu/AHf/62Caw0LjiK9Sb86
         XbtzNlMgyFqJVVAF2SiiRAP4pdGokukiNAriF9T4GqXahxOVVflZhdJBokMX0gAZHIAV
         mZiCvzKUJSa8OAUIK9/qyESHCV9B6Y8M0F3gW3LfaT247MemygG2NuIQSRf03LPfDwat
         e8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370710; x=1780975510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fam29w7BM7SQN1712sc63hB2u0C0AKH1MvJ73Y+Wc24=;
        b=gz/QN+4w9kh7E06XCZjB0X8I0iZrWHmm+qsyqLVMeeEDiMoMqL4mvpt4z/cHP2QiPr
         7k7+laADWOMynHZ7UKx7mPeRHCzSPXVZRygLry1wBFwCTXCmfgprAc/TCheuhpAmGnVj
         mWmqBHRCfVimM6ML6mEaA4CFqu5aN/rbQiUQOcJKglvm+a7+epdJJybk4jHltrVDdb/w
         pBI6+nCPdnqlMZ8RRGWXZJIxYEbo6zB3dtPRcUS9xaXErH0w5gOxpATY5NcMENnizn8T
         F/PwbQ7T/opH6C2Q+C/kVeel8d/+52HL642cP3FUgWK7XmO8kMjoDwyJueQ73pyPHq1y
         ynhg==
X-Forwarded-Encrypted: i=1; AFNElJ+61RS0mvXVSVRudf59FulrsehNhAcEiBChmEDgvY9qjYJrJlaclCtExEnARis6Geq5/t6y3icO@vger.kernel.org
X-Gm-Message-State: AOJu0YwGTs+JKXetmrVbwHDTY4VEQec5s+gGAmaCNV2smtF3Mc+VbpbH
	hYdNSlpjj7bwatT5rkYgqwQTjdiOhwvoFw61cAkfyirhEKHw/Kb0jttC8sHsipJ34yl7i49+9tY
	CpH0KQjdAaId/A9Z3rRv6gvz9TajetVw=
X-Gm-Gg: Acq92OFJUJDLAmxIIC2A0tMJ0ZJ1XFo3eiwmABuYXqxji/8aDKs0F/bQ1QELJ56ZCrN
	sFlTY1EDWV4l5pT1dTl0vtONCmSigV2tRCHuAjuaJHO1Q2X3dRE6L3m3QRe+YRGrfkz8i/whINT
	ZOqI17VCc4/zYztcvAE8g47sNSkkg9Ep8k8zaBhEuymLyVN+zqwq9XYPpnRUfydbMm5cchB2oG7
	5D90dgRL/W6e7tkgaZ8Pe6XApAaAWQG7zP2+2ob90XQjzDQZBoRHZDfdM5O2oFBShkn3mZuiUOI
	pIXysLbVhuESD9CiwONULPGMvlW4dvExljWznCVPnvTcmZ3MkQ==
X-Received: by 2002:a17:907:b582:b0:bec:b4e3:e930 with SMTP id
 a640c23a62f3a-becb4e3ea0amr390918166b.12.1780370710180; Mon, 01 Jun 2026
 20:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
 <CAMgjq7BhOn48xEyC=2j837R7qddfjeBVHMiRqdx8no4ZEBpBLg@mail.gmail.com> <CAKEwX=PmwzaJhfjBrho3+kQ8HXFUC0WiegQrsguBc-_pmn5bSA@mail.gmail.com>
In-Reply-To: <CAKEwX=PmwzaJhfjBrho3+kQ8HXFUC0WiegQrsguBc-_pmn5bSA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Jun 2026 11:24:32 +0800
X-Gm-Features: AVHnY4LgB4_R0tkXYgUuuSpKzumTcKeWUZY8_XjCCaRJMf8h2HTxkfNiEQ137jc
Message-ID: <CAMgjq7D4XsAD4NGDL7FC2kaYAQAP8PDJdn4bpzGZwXYtjEpJ6w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Nhat Pham <nphamcs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16546-lists,cgroups=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 51129627CC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jun 2, 2026 at 2:06=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Mon, Jun 1, 2026 at 10:45=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Mon, Jun 1, 2026 at 11:57=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > Are you suggesting we merge the virtual table with main swap table?
> > >
> > > Man, I'd love to do this. There is a problem though - we have a case
> > > where we occupy both backing physical swap AND swap cache. Do you
> > > think we can fit both the physical swap slot handle and the swap cach=
e
> > > PFN into the same slot in virtual table? Maybe with some expanding...=
?
> >
> > I don't really get why we would need to do that? If you put the PFN
> > info in the virtual / upper layer, then the count info, locking, and
> > all swap IO synchronization (via folio lock), dup (current protected
> > by ci lock / folio lock), and allocation (folio_alloc_swap), are all
> > handled in this layer.
> >
> > The physical / lower layer will just hold a reverse entry on
> > folio_realloc_swap, or no entry at all (no physical layer used, zswap,
> > or after swap allocation but before IO) right?
> >
> > Looking up the actual folio from the physical layer will be a bit
> > slower since it needs to resolve the reverse entry, but the only place
> > we need to do that is things like migrate, compaction (none of them
> > exist yet) which seems totally fine?
>
> All of this is correct, but consider swaping in a vswap entry backed
> by pswap. There are cases where you still want to maintain the pswap
> slots around backing vswap entry, while having the swap cache folio as
> well.
>
> For e.g, at swap in time, we add the folio into the swap cache. First
> of all, we need to hold on to the physical swap slot for IO step. But
> even after IO succeeds, there are cases where you would still like to
> keep physical swap slots around (for e.g, to avoid swapping out again
> if the folio is only speculatively fetched).

A reverse entry is enough to hold the physical swap, just like how the
current hibernation works with a fake shadow, you don't need a PFN
just for holding that.

>
> So you have to make sure we have space for both the physical swap
> slot, and the swap cache folio's PFN at the same time for each vswap
> entry. So we still need the vtable extension (well maybe the other
> approach I mentioned could work, but I'm not 100% sure).

Right, vtable extension is fine, there is no redundant data. I just
mean you don't need to set the PFN twice (for vswap & pswap). So
simply reusing the PFN format in the vswap layer and solving
everything there should be enough.

> > Thanks. Not too complicated, actually our internal kernel
> > implementation still using si->percpu cluster, and use a counter for
> > the rotation and each order have a counter :P, it's a bit ugly but
> > works fine. It still serves pretty well just like the global percpu
> > cluster, YoungJun's previous per ci percpu cluster also still provides
> > the fast path, many ways to do that.
>
> Sounds like something that should be upstreamed? ;)

I'd love to :), there is a lot of work going on as you can see and
people seem to have many different proposals about this so I didn't
prioritize it. I'll try as things settle down.

> > > >
> > > > For patch 2, a few routines like vswap_can_swapin_thp seems not
> > > > needed or should be moved to __swap_cache_alloc? VSWAP_FOLIO is
> > > > same as swap cache folio check, which is already covered. Same for
> > > > zero checking, and VSWAP_NONE which is same as swap count check
> > > > I think. That way we not only save a lot of code, we also no
> > > > longer need to treat vswap specially.
> > >
> > > Unfortunately, I think a lot of this complexity is still needed. Vswa=
p
> > > adds a new layer, which means new complications :)
> > >
> > > For instance, I think you still need vswap_can_swapin_thp. It
> > > basically enforces that the backend must be something
> > > swap_read_folio() can handle. That means:
> > >
> > > 1. No zswap.
> > >
> > > 2. No mixed backend.
> >
> > If mixed backend means phys vs zero vs zswap, then we already have
> > part of that covered with the current swap cache except for the phys
> > part (zswap part seems very doable with fujunjie's work).
> > swap_cache_alloc_folio will ensure there is no mixed zerobit, it can
> > be easily extended to ensure there is no mixed zswap as well
> > (according to what I've learned from fujunjie's code). Similar logic
> > for phys detection I think.
>
> Yeah it's basically generalizing that check, and handle the case where
> we can have indirection.
>
> I mean I can open-code it, but it has to be there :) And I figure it
> might be useful to check this opportunistically (at swap_pte_batch,
> even if it's not guaranteed to be correct down the line) before we
> even attempt to allocate a large folio etc. to avoid large folio
> allocation.

Right, but swap_cache_alloc_folio with orders=3D<large order> won't
attempt a large allocation if the batch check fails, so that's fine.

> > > Basically:
> > >
> > > 1. For vswap entry, not backed by phys swap: record swap memcg, hold
> > > reference to pin the memcg, but not charging towards swap.current.
> >
> > Maybe you don't need to record memcg here since folio->memcg already
> > have that info?
> >
> > I previously had a patch:
> > https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-7-104795d198=
15@tencent.com/
> >
> > The defers the recording of memcg, the behavior is almost identical to
> > before, but charging & recording should be cleaner and you don't need
> > to record memcg at allocation time hence maybe reduce the possibility
> > of pinning a memcg. I didn't include that in P4 just to reduce LOC,
> > maybe can be resent or included.
>
> That works-ish when the folio is sitll in swap cache, but say if it's
> vswap backed by zswap (and the swap cache folio has been reclaimed),
> you need a place to store the memcg, no?

"Backed by zswap" means the actual swapout already happened, which is
the case where we always have to record the memcg info because the
folio is gone, seems still fit in the model.

> Just seems cleaner to centralize this info at vswap layer when it is
> presented, for now anyway, rather than juggling this on a per-backend
> basis.

Zswap charge could be merged with vswap I think but pswap we just
discussed that we might want to charge it differently? And actually
vswap charge is still quite different from zswap charge if you want to
make vswap infinitely large? I think we can figure out this part as we
progress; it's not a major problem at this point.

