Return-Path: <cgroups+bounces-16573-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7YbjL675Hmo5bQAAu9opvQ
	(envelope-from <cgroups+bounces-16573-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 17:41:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D04262FE2B
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 17:41:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mZJisVyW;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16573-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16573-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 421BC3061186
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8B93EFFCA;
	Tue,  2 Jun 2026 15:28:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2323ED125
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 15:28:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414104; cv=pass; b=sqNa3AjLy1Nrjy1mr19bYlY483LQrPy8mCfygWAovUcyyd4E4SyfIrRXKeEcjpbMBDWzuOIV3MH4St2EPYVvJcFwa2TT4mx0tpxSEx3ghAOzXKZFDetb4dF9TAMjtG4OPxYwJOWrMNqHhjAnGC/fYQGfmKdoOY7VF31JgSBZ58s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414104; c=relaxed/simple;
	bh=KioD6muOq73KOuZgXUdfc8mghtZCf5WX4ci2/jt07rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYTiavYW2eEmKer6RmfL3xLzzJP1RIJ07ToruK1PA+TMPwFRg6k2SruBwVfaXdqTxP9BT+FkYUiKWlmR76YjZAfDIRfeeR52WVRkvcv4T3oMaYf8PNYaR3pFJd3Iq2BFqBDueYBs4MO0273H2fNTalBLZ65fVLdiO61q22JMHAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZJisVyW; arc=pass smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef372c58aso2252779f8f.0
        for <cgroups@vger.kernel.org>; Tue, 02 Jun 2026 08:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780414101; cv=none;
        d=google.com; s=arc-20240605;
        b=FRMpkAxi+Ca2FubiG5P+by+5XfzjU1diL2CAFh/DEowKlRvj0fMQhC9o5ZAxkWySP2
         PtNIhxKKfAdHq6wg5i2/SSX2IoCQLOs3z58RgIWyp6YBZYPjFrUP9Z3LsezoubPtweeX
         M4f5JQ1npr2zlgvT3C504bcCr22LVHW1FfQS1v6GUwv6Jyt7Jn7L+gtiHLJXl07PuWbn
         3Z89OvkJ2SxBq3gu0DlW7IVu8yM4iJO6kYQz75/kCaupllpBzBg8HkrI+SuJHR2T3Ccs
         3r+Bt4PnM4imcYWOEHBBWUGC367GloP/D94uX8xZND1Ik6uEg4iy5qOzdslaACwixvRn
         qwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KioD6muOq73KOuZgXUdfc8mghtZCf5WX4ci2/jt07rE=;
        fh=ZjPtxVV2lpMIj9H3WAT6OPSpKOLQkuDMD4UvscyezfA=;
        b=d3ecP9854WAbb9Mz9qFAmN1DIJc103XBW13NDpCX3ieS6juIPnpJQegF4SLnuQum7q
         /0m3Hhvd/3W9llLIMeXB3zYk7BUIeal3EYsw6NH5gZqtrt6Vlxtr8OnhGNWhNdv05yND
         NPUQ80xXwEC2yPnixH9JBv9HNOO2iFyVMlUHhyFMT3jbIBABOUkSdBRee3JVId9nKGTh
         zchMrQxOjRHP4LAOtqzmHj8qJOopJTHiBko4ITYXfqyY9CZ7iN/W6RD4B4wU0LHvu1e3
         E0BQVfSGVdw9mpRUlPR2cKddrZ12E4+sj4hA0hRXhUs6UC46v9XJ31YWkGeJtypAnQXw
         XDAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780414101; x=1781018901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KioD6muOq73KOuZgXUdfc8mghtZCf5WX4ci2/jt07rE=;
        b=mZJisVyWXmXPsPq1B+4RWVJXsEAcwnVm2eooLuPaonvGk5UuSz/RcfRnYDtaXFt1jr
         lrzNhKSFhOKb9M5nvWDdGdBQ/stkgH/VByDF7fSn4tTHpXm3Q6TZvdKjxDpRp9QsqD/c
         9pEmbNrI2DqujUzI1G22wDd9A22nC6jjZXH9C1yPOX1zafbGpaOZHWKRbLSlCU9IoMDd
         6h71mvbZ4CFPTGUBAIxyVebOS3WOWDWF626Eozevs+puG3putEyoDLgA8EsCmEsIKC79
         T99vcQTxJW4cRLJaCVY4NRFVdVFXKErPfy9zR0BTilyp31D0X/rBdl8iyePJNN0Z8Fe6
         HtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414101; x=1781018901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KioD6muOq73KOuZgXUdfc8mghtZCf5WX4ci2/jt07rE=;
        b=IjLZPYJ901UEVAEkt4QGqxd9lVZWjivsge+/1mmFtNfkhMlHP3tLmruqHHrydXkgRx
         4x7HBCusBmjoQ7z8XjPbbNC6S4ZxZLBethOdAgDCXhbJodxY3YRZTVgQPkFn6eaCPQaF
         HdXj/GpxHU5qM1vbSJjEbexsfalzrAfyFM/tey57j062iAOLEnSWPcNvE2V+qFTRUxJa
         px9V0EeHISSwNYp2EQUm1Vzyx+apfE/IWPMmIyWB6tkwWHg6YEE6FWUdpCODkbFTqk0a
         qLlQCbEazeO/FfTQfJ3UXNdBnnbECkhYJaSjrRNv5ZDoCw1HivYJ7HOL6hJ4ejGQbjfS
         T0ig==
X-Forwarded-Encrypted: i=1; AFNElJ/uza5I2ZeMzsSm1cQcIlT5AojMc8cnCCO3KtZxdDWcDPQhuaIew4kYzBvIBOBBXzIJBGZHvM0/@vger.kernel.org
X-Gm-Message-State: AOJu0YwxzLPal5gbWrFb/uRSr27HhNScCrMTrGpQ818mjhjjlqyx3Gl1
	yOFZ6hWga2WkVvsyd3dcx8bosg3RRrrKlxiSNahWATXqoRqbGWyRw+aYB+hiEYAeMCTH3vHKVRb
	M6cSLl31D5HzZIKxsOfFV54zh7JcKLtE=
X-Gm-Gg: Acq92OHalTZOnVuj2etahPe11+T4Cyvdsfsasr4n8Q7o3634Di88rClJVOxH2DcvxuU
	+LnebshmBMa8WlqHD8NbSH8/TXuNmqvZnF3nBYyyF3kVW8Oi8rcfxscGA2PzcJwq8lHYXfhb2o9
	AE7VKLTqBCInLnW1caSz4fUHoBZx3Lfi7Bf6Bzxve4CwPaPW38AlbGTZM6bq2DD7JngSuVAbiao
	S4MBM1hF9gzaUDM6rWnzMcGhJmf5ejbi8fvrkE1Y8iQpng9syxC9T6kBu7qxBe+JcmPQPAhtJOT
	VZHR+Hko8NP0hqr2u+iDJjlxdWos9/019lMzS8qAHEkM3DI0hA==
X-Received: by 2002:a5d:5401:0:b0:45e:d6b2:e6a5 with SMTP id
 ffacd0b85a97d-45ef6b83764mr21337268f8f.34.1780414101045; Tue, 02 Jun 2026
 08:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
 <CAMgjq7BhOn48xEyC=2j837R7qddfjeBVHMiRqdx8no4ZEBpBLg@mail.gmail.com>
 <CAKEwX=PmwzaJhfjBrho3+kQ8HXFUC0WiegQrsguBc-_pmn5bSA@mail.gmail.com> <CAMgjq7D4XsAD4NGDL7FC2kaYAQAP8PDJdn4bpzGZwXYtjEpJ6w@mail.gmail.com>
In-Reply-To: <CAMgjq7D4XsAD4NGDL7FC2kaYAQAP8PDJdn4bpzGZwXYtjEpJ6w@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 2 Jun 2026 08:28:09 -0700
X-Gm-Features: AVHnY4IWURpsnvI312VbRdsgEkqVndHtTZWSNA7JxRNHqCQ-2eUuyz0lSoO1lo4
Message-ID: <CAKEwX=OZL+ykwTjZJzUDAEnTOO6B0mibc6dxiYtmnoLReB7TYA@mail.gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16573-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ryncsn@gmail.com,m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:bhe@redhat.com,m:byungchul@sk.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:chrisl@kernel.org,m:corbet@lwn.net,m:david@kernel.org,m:dev.jain@arm.com,m:gourry@gourry.net,m:hannes@cmpxchg.org,m:hughd@google.com,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:lenb@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-pm@vger.kernel.org,m:lorenzo.stoakes@oracle.com,m:matthew.brost@intel.com,m:mhocko@suse.com,m:muchun.song@linux.dev,m:npache@redhat.com,m:pavel@kernel.org,m:peterx@redhat.com,m:peterz@infradead.org,m:pfalcato@suse.de,m:rafael@kernel.org,m:rakie.kim@sk.com,m:roman.gushchin@linux.dev,m:rppt@kernel.org,m:ryan.roberts@arm.com,m:shakeel.butt@linux.dev,m:shikemeng@huaweicloud.com,m:surenb@google.com,m:tgl
 x@kernel.org,m:vbabka@suse.cz,m:weixugc@google.com,m:ying.huang@linux.alibaba.com,m:yosry.ahmed@linux.dev,m:yuanchu@google.com,m:zhengqi.arch@bytedance.com,m:ziy@nvidia.com,m:kernel-team@meta.com,m:riel@surriel.com,m:haowenchao22@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D04262FE2B

On Mon, Jun 1, 2026 at 8:25=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Tue, Jun 2, 2026 at 2:06=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Mon, Jun 1, 2026 at 10:45=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Mon, Jun 1, 2026 at 11:57=E2=80=AFPM Nhat Pham <nphamcs@gmail.com>=
 wrote:
> > > >
> > > > Are you suggesting we merge the virtual table with main swap table?
> > > >
> > > > Man, I'd love to do this. There is a problem though - we have a cas=
e
> > > > where we occupy both backing physical swap AND swap cache. Do you
> > > > think we can fit both the physical swap slot handle and the swap ca=
che
> > > > PFN into the same slot in virtual table? Maybe with some expanding.=
..?
> > >
> > > I don't really get why we would need to do that? If you put the PFN
> > > info in the virtual / upper layer, then the count info, locking, and
> > > all swap IO synchronization (via folio lock), dup (current protected
> > > by ci lock / folio lock), and allocation (folio_alloc_swap), are all
> > > handled in this layer.
> > >
> > > The physical / lower layer will just hold a reverse entry on
> > > folio_realloc_swap, or no entry at all (no physical layer used, zswap=
,
> > > or after swap allocation but before IO) right?
> > >
> > > Looking up the actual folio from the physical layer will be a bit
> > > slower since it needs to resolve the reverse entry, but the only plac=
e
> > > we need to do that is things like migrate, compaction (none of them
> > > exist yet) which seems totally fine?
> >
> > All of this is correct, but consider swaping in a vswap entry backed
> > by pswap. There are cases where you still want to maintain the pswap
> > slots around backing vswap entry, while having the swap cache folio as
> > well.
> >
> > For e.g, at swap in time, we add the folio into the swap cache. First
> > of all, we need to hold on to the physical swap slot for IO step. But
> > even after IO succeeds, there are cases where you would still like to
> > keep physical swap slots around (for e.g, to avoid swapping out again
> > if the folio is only speculatively fetched).
>
> A reverse entry is enough to hold the physical swap, just like how the
> current hibernation works with a fake shadow, you don't need a PFN
> just for holding that.
>
> >
> > So you have to make sure we have space for both the physical swap
> > slot, and the swap cache folio's PFN at the same time for each vswap
> > entry. So we still need the vtable extension (well maybe the other
> > approach I mentioned could work, but I'm not 100% sure).
>
> Right, vtable extension is fine, there is no redundant data. I just
> mean you don't need to set the PFN twice (for vswap & pswap). So
> simply reusing the PFN format in the vswap layer and solving
> everything there should be enough.

Ah yeah, then I might have misunderstood you here. I thought you were
proposing a way to remove vtable :)

"don't need to set the PFN twice" completely agree. I'm pretty sure I
did not here, but do let me know if I accidentally set it twice. I'm
be sure to check this myself for the next version.

>
> > > Thanks. Not too complicated, actually our internal kernel
> > > implementation still using si->percpu cluster, and use a counter for
> > > the rotation and each order have a counter :P, it's a bit ugly but
> > > works fine. It still serves pretty well just like the global percpu
> > > cluster, YoungJun's previous per ci percpu cluster also still provide=
s
> > > the fast path, many ways to do that.
> >
> > Sounds like something that should be upstreamed? ;)
>
> I'd love to :), there is a lot of work going on as you can see and
> people seem to have many different proposals about this so I didn't
> prioritize it. I'll try as things settle down.

Yeah understandable. It's a very volatile codebase, with a lot of
folks trying to improve different aspects.

Hopefully we're close to a unified design :)

I'll keep my dedicated vswap per-cpu alloc caching for now, but I'll
get rid of it whenever the per-CPU per-si cache is ready.

>
> > > > >
> > > > > For patch 2, a few routines like vswap_can_swapin_thp seems not
> > > > > needed or should be moved to __swap_cache_alloc? VSWAP_FOLIO is
> > > > > same as swap cache folio check, which is already covered. Same fo=
r
> > > > > zero checking, and VSWAP_NONE which is same as swap count check
> > > > > I think. That way we not only save a lot of code, we also no
> > > > > longer need to treat vswap specially.
> > > >
> > > > Unfortunately, I think a lot of this complexity is still needed. Vs=
wap
> > > > adds a new layer, which means new complications :)
> > > >
> > > > For instance, I think you still need vswap_can_swapin_thp. It
> > > > basically enforces that the backend must be something
> > > > swap_read_folio() can handle. That means:
> > > >
> > > > 1. No zswap.
> > > >
> > > > 2. No mixed backend.
> > >
> > > If mixed backend means phys vs zero vs zswap, then we already have
> > > part of that covered with the current swap cache except for the phys
> > > part (zswap part seems very doable with fujunjie's work).
> > > swap_cache_alloc_folio will ensure there is no mixed zerobit, it can
> > > be easily extended to ensure there is no mixed zswap as well
> > > (according to what I've learned from fujunjie's code). Similar logic
> > > for phys detection I think.
> >
> > Yeah it's basically generalizing that check, and handle the case where
> > we can have indirection.
> >
> > I mean I can open-code it, but it has to be there :) And I figure it
> > might be useful to check this opportunistically (at swap_pte_batch,
> > even if it's not guaranteed to be correct down the line) before we
> > even attempt to allocate a large folio etc. to avoid large folio
> > allocation.
>
> Right, but swap_cache_alloc_folio with orders=3D<large order> won't
> attempt a large allocation if the batch check fails, so that's fine.
>
> > > > Basically:
> > > >
> > > > 1. For vswap entry, not backed by phys swap: record swap memcg, hol=
d
> > > > reference to pin the memcg, but not charging towards swap.current.
> > >
> > > Maybe you don't need to record memcg here since folio->memcg already
> > > have that info?
> > >
> > > I previously had a patch:
> > > https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-7-104795d1=
9815@tencent.com/
> > >
> > > The defers the recording of memcg, the behavior is almost identical t=
o
> > > before, but charging & recording should be cleaner and you don't need
> > > to record memcg at allocation time hence maybe reduce the possibility
> > > of pinning a memcg. I didn't include that in P4 just to reduce LOC,
> > > maybe can be resent or included.
> >
> > That works-ish when the folio is sitll in swap cache, but say if it's
> > vswap backed by zswap (and the swap cache folio has been reclaimed),
> > you need a place to store the memcg, no?
>
> "Backed by zswap" means the actual swapout already happened, which is
> the case where we always have to record the memcg info because the
> folio is gone, seems still fit in the model.

Hmmm I might have misunderstood you in my last response here.

So what you are doing in that patch:

1. Charge towards folio->memcg when we allocate swap slots, but do not
record or take reference yet.

2. Once we reclaimed the folio after swap out, then we record and
acquire reference to pin.

You know what - this would simplify my usecase. For vswap entries not
backing by pswap, it *basically* just means I skip step 1 for vswap
backend. Step 2 is shared for all cases. Donezo.

You're right. This is simpler :) Let me brew on it a bit longer in
case there might be something we're missing. but it does seem like
this will reduce complexity (and with the added benefits of me not
having to come up with names for helpers).

>
> > Just seems cleaner to centralize this info at vswap layer when it is
> > presented, for now anyway, rather than juggling this on a per-backend
> > basis.
>
> Zswap charge could be merged with vswap I think but pswap we just
> discussed that we might want to charge it differently? And actually
> vswap charge is still quite different from zswap charge if you want to
> make vswap infinitely large? I think we can figure out this part as we
> progress; it's not a major problem at this point.

That was because I misunderstood your suggestions. My bad :)

Anyway, please keep the suggestions and recommendations coming :) I'm
playing with some of your suggestions right now, and waiting for other
folks' inputs as well. Will send out the next version at some point.
If there is no fundamental design flaws, I will un-RFC once I've
addressed all the main issues.

